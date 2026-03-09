/*
 * Struct size verification test.
 *
 * Ensures all packed structs match the expected byte sizes from the
 * original CareSens Air binary interface. The debug_t size (1579) is
 * independently confirmed by DebugData4Obj.java MAX_LENGTH.
 */

#include <stdio.h>
#include <stdlib.h>
#include "calibration.h"

static int failures = 0;

#define CHECK_SIZE(type, expected) do { \
    size_t actual = sizeof(struct type); \
    if (actual != (expected)) { \
        fprintf(stderr, "FAIL: sizeof(%s) = %zu, expected %zu\n", \
                #type, actual, (size_t)(expected)); \
        failures++; \
    } else { \
        printf("OK:   sizeof(%s) = %zu\n", #type, actual); \
    } \
} while (0)

int main(void) {
    printf("=== Struct size verification ===\n\n");

    CHECK_SIZE(air1_opcal4_cal_log_t,       104);  /* natural alignment (8-byte doubles) */
    CHECK_SIZE(air1_opcal4_arguments_t,     117312); /* oracle-verified: natural alignment */
    CHECK_SIZE(air1_opcal4_output_t,        155);
    CHECK_SIZE(air1_opcal4_debug_t,         1579);
    CHECK_SIZE(air1_opcal4_device_info_t,   446);
    CHECK_SIZE(air1_opcal4_cgm_input_t,     74);
    CHECK_SIZE(air1_opcal4_cal_list_t,      751);

    printf("\n");
    if (failures > 0) {
        fprintf(stderr, "%d size check(s) FAILED\n", failures);
        return EXIT_FAILURE;
    }
    printf("All struct sizes OK\n");
    return EXIT_SUCCESS;
}
