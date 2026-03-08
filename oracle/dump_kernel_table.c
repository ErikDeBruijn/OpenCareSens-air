/*
 * Dump the kernel table used by the IRLS regression in libCALCULATION.so.
 *
 * The kernel table is accessed via a GOT entry that gets resolved at dlopen time.
 * We can find it by:
 *   1. Loading the library
 *   2. Finding the function air1_opcal4_algorithm
 *   3. The GOT entry is at a known PC-relative offset from the function code
 *   4. Reading the resolved pointer from the GOT
 *   5. Dumping the table data
 *
 * From disassembly:
 *   0x63d56: ldr r0, [pc, #0x324]  -> pool at 0x6407c
 *   0x63d58: ...
 *   0x63d5a: add r0, pc            -> r0 = pool_value + (0x63d5a + 4)
 *   0x63d5c: ldr lr, [r0]          -> lr = *r0 (GOT entry, resolved pointer)
 *
 * Pool at 0x6407c = 0x0000f49e
 * Target = 0xf49e + 0x63d5e = 0x731fc (GOT entry address in file)
 * But at runtime, the library is loaded at some base address.
 * We need: base + 0x731fc -> read pointer -> that's the kernel table address.
 *
 * Actually, we can compute it more directly:
 *   func_addr = dlsym(lib, "air1_opcal4_algorithm")
 *   The function starts at file offset 0x616e8 (from the ELF)
 *   The GOT reference is at file offset 0x63d5a
 *   So the offset from function start = 0x63d5a - 0x616e8 = 0x2672
 *   At runtime: code_addr = func_addr + 0x2672
 *   Pool value at func_addr + (0x6407c - 0x616e8) = func_addr + 0x2994
 *   The instruction adds pool_value to PC:
 *     effective_addr = pool_value + code_addr + 4 (Thumb PC offset)
 *   Then deref to get the kernel table pointer.
 *
 * Actually it's simpler: just scan the .got section after dlopen.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>
#include <stdint.h>

int main(int argc, char **argv) {
    const char *so_path = argc > 1 ? argv[1] : "./libCALCULATION.so";

    printf("Loading %s...\n", so_path);
    void *lib = dlopen(so_path, RTLD_NOW);
    if (!lib) {
        fprintf(stderr, "dlopen failed: %s\n", dlerror());
        return 1;
    }

    void *func = dlsym(lib, "air1_opcal4_algorithm");
    if (!func) {
        fprintf(stderr, "dlsym failed: %s\n", dlerror());
        return 1;
    }

    /* In Thumb mode, the function pointer has bit 0 set. Clear it. */
    uintptr_t func_addr = (uintptr_t)func & ~1;
    printf("Function at %p (clean: 0x%08x)\n", func, (unsigned)func_addr);

    /* The function starts at file offset 0x616e8.
     * The pool at file offset 0x6407c contains a PC-relative offset.
     * Pool offset from function start = 0x6407c - 0x616e8 = 0x2994
     *
     * Read the pool value (4 bytes, little-endian):
     */
    uint32_t pool_offset = 0x2994;
    uint32_t pool_value = *(uint32_t *)(func_addr + pool_offset);
    printf("Pool value at func+0x%x: 0x%08x\n", pool_offset, pool_value);

    /* The instruction at 0x63d5a (func+0x2672) does: add r0, pc
     * In Thumb mode, PC = current_instruction_address + 4
     * So: r0 = pool_value + (func_addr + 0x2672 + 4)
     *       = pool_value + func_addr + 0x2676
     * Wait, the pool is loaded at 0x63d56 and add r0,pc is at 0x63d5a:
     *   0x63d56: ldr r0, [pc, #0x324]  -> r0 = pool_value
     *   0x63d5a: add r0, pc            -> r0 = r0 + (0x63d5a + 4) = pool_value + 0x63d5e
     * At runtime: r0 = pool_value + (func_addr + (0x63d5a - 0x616e8) + 4)
     *           = pool_value + func_addr + 0x2672 + 4
     *           = pool_value + func_addr + 0x2676
     */
    uintptr_t got_addr = pool_value + func_addr + 0x2676;
    printf("GOT entry at: 0x%08x\n", (unsigned)got_addr);

    /* Read the resolved pointer from GOT */
    uintptr_t kernel_table_ptr = *(uintptr_t *)got_addr;
    printf("Kernel table pointer: 0x%08x\n", (unsigned)kernel_table_ptr);

    if (kernel_table_ptr == 0) {
        printf("Kernel table pointer is NULL. The GOT entry wasn't resolved.\n");
        printf("Trying alternative: scan nearby memory for the table...\n");

        /* Let's try reading the GOT entry directly */
        printf("\nDumping memory around GOT entry:\n");
        uint8_t *p = (uint8_t *)got_addr;
        for (int i = -16; i < 32; i += 4) {
            uint32_t v = *(uint32_t *)(p + i);
            printf("  [%+d] = 0x%08x\n", i, v);
        }
    } else {
        /* Dump the kernel table */
        printf("\n=== Kernel table dump ===\n");
        printf("Stride per row: 0x168 = 360 bytes = 45 doubles\n");
        printf("Expected: 90 rows for 90 evaluation points\n\n");

        double *table = (double *)kernel_table_ptr;
        int stride_doubles = 360 / 8;  /* 45 doubles per row */

        /* Dump first few rows */
        for (int row = 0; row < 5; row++) {
            printf("Row %d (eval point %d):\n", row, row);
            for (int col = 0; col < 10; col++) {
                printf("  [%d] = %.10f\n", col, table[row * stride_doubles + col]);
            }
            printf("  ...\n");
        }

        /* Dump the full table to a binary file */
        FILE *f = fopen("/oracle/output/kernel_table.bin", "wb");
        if (f) {
            /* Dump 90 rows * 45 doubles = 4050 doubles = 32400 bytes */
            fwrite(table, sizeof(double), 90 * stride_doubles, f);
            fclose(f);
            printf("\nFull kernel table saved to /oracle/output/kernel_table.bin\n");
            printf("(%d doubles = %d bytes)\n", 90 * stride_doubles, (int)(90 * stride_doubles * sizeof(double)));
        }

        /* Also dump some statistics */
        printf("\nRow sums:\n");
        for (int row = 0; row < 90; row++) {
            double sum = 0;
            for (int col = 0; col < stride_doubles; col++) {
                sum += table[row * stride_doubles + col];
            }
            if (row < 10 || row >= 80 || row % 10 == 0)
                printf("  Row %2d: sum=%.10f\n", row, sum);
        }
    }

    dlclose(lib);
    return 0;
}
