# CareSens Air Calibration Algorithm — Reference-Guided Reimplementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.
>
> **REQUIRED READING:** Before starting ANY task, read the comprehensive knowledge base at `docs/reference/caresens-air-knowledge-base.md`. It contains everything you need: struct definitions, BLE protocol, ARM instruction reference, algorithm pipeline, function inventory, oracle rules, and tool commands.

**Goal:** Build an open-source, GPL-compatible reimplementation of the CareSens Air CGM calibration algorithm (`libCALCULATION.so`) that converts raw ADC sensor values to calibrated glucose readings (mg/dL), verified per-function against the proprietary library's debug output.

**Architecture:** A standalone C library with the same function-level decomposition as the original: ADC→eliminate_peak→IIR filter→drift correction→Kalman filter→Savitzky-Golay smoothing→error detection→calibrated glucose. Each function is reimplemented independently using ARM disassembly + LLM-assisted transpilation, verified against the `air1_opcal4_debug_t` struct oracle.

**Tech Stack:** C (targeting Android NDK / ARM), CMake build system, Android test harness (JNI), Python verification scripts. Reference materials: ARM Thumb-2 disassembly (via llvm-objdump), Ghidra decompiled C (partial), Juggluco source (struct definitions, BLE protocol), jadx-decompiled Java (debug struct field names).

**Important discovery:** The library contains 5 algorithm versions (cgms, opcal, opcal2, opcal3, opcal4), each with their own complete copy of all helper functions. We only reimplement **opcal4** — all opcal4 functions live in the ELF address range 0x61518–0x6ea48.

---

## Reverse Engineering Breakthrough Log

### Breakthrough 1: Ghidra truncation root cause identified and solved

**Problem:** Ghidra's decompiler truncated all complex functions after `__aeabi_memclr8()` calls, producing only stack-frame prologues (15-25 lines) instead of full function bodies. The `fun_linear_kalman` function showed as 16 lines; `regress_cal` as 25 lines.

**Root cause:** Ghidra applied a **0x10000 base address offset** when loading the ELF. The `.text` section lives at ELF VMA 0x31178–0x6ef8c, but Ghidra mapped it to 0x41178–0x7ef8c. This caused Ghidra's internal analysis to fail on cross-references within large functions — it couldn't resolve relative branches after the memclr8 call because the offsets pointed to "wrong" addresses.

**Solution:** Use `llvm-objdump --triple=thumbv7-linux-gnueabi` directly on the ELF binary with correct VMA addresses. This bypasses Ghidra entirely and produces complete, correct ARM Thumb-2 disassembly.

**Key command:**
```bash
OBJDUMP=$(xcrun --find llvm-objdump)
$OBJDUMP -d --triple=thumbv7-linux-gnueabi \
    --start-address=0x40528 --stop-address=0x40d38 \
    libCALCULATION.so > fun_linear_kalman.asm
```

**Address mapping:** `Ghidra address - 0x10000 = ELF VMA address`

**Result:** ALL previously truncated functions are now fully available as ARM Thumb-2 assembly:

| Function | Ghidra lines | ARM instructions | Status |
|----------|-------------|-----------------|--------|
| `fun_linear_kalman` | 16 | **583** | Fully recovered |
| `smooth_sg` | 13 | **111** | Fully recovered |
| `regress_cal` | 25 | **462** | Fully recovered |
| `f_cgm_trend` | 31 | **636** | Fully recovered |
| `check_error` | 0 (undiscovered!) | **8008** | Newly found |
| `air1_opcal4_algorithm` | 991 | ~5000+ | Already partially recovered |

### Breakthrough 2: Hidden `check_error` function discovered

**Problem:** Ghidra showed a 24KB "gap" between `clear_mem @ 0x76674` and `copy_mem @ 0x7c5fe` with no identified functions.

**Solution:** `llvm-nm` on the ELF revealed `check_error @ 0x66688` — a **24,948-byte** function (8008 ARM instructions) containing ALL error detection logic (err1 through err128). Ghidra never found it because it sits in a region Ghidra classified as data.

### Breakthrough 3: Complete function inventory via llvm-nm

Using `llvm-nm` instead of Ghidra's symbol table revealed 7 previously unknown helper functions:

| Function | Instructions | Purpose |
|----------|-------------|---------|
| `check_error` | 8008 | All error detection (err1–err128) |
| `solve_linear` | 140 | Linear system solver |
| `apply_simple_smooth` | 117 | Smoothing helper |
| `smooth1q_err16` | 162 | err16-specific smoothing |
| `fit_simple_regression` | 84 | Simple linear regression |
| `f_rsq` | 673 | R-squared calculation |
| `cal_average_without_min_max` | 27 | Trimmed average |

### Implication for the plan

**There is no truncation problem anymore.** Every function's complete machine code is available. The approach shifts from "guess from theory + oracle" to "LLM-assisted ARM→C transpilation + oracle verification." This is a fundamentally stronger position:

1. LLM reads ARM Thumb-2 assembly (well-documented ISA)
2. LLM generates candidate C implementation
3. Oracle instantly verifies correctness per debug-struct field
4. Iterate until bit-exact match

---

## Context for the Implementer

### What is this?

The CareSens Air is a 15-day continuous glucose monitor (CGM) that transmits raw ADC readings over BLE. The raw values must be calibrated to produce glucose values in mg/dL. The calibration algorithm lives in a proprietary native library (`libCALCULATION.so`) by i-SENS. This library cannot be bundled in GPL-licensed apps like xDrip+ or AndroidAPS.

### Why reference-guided reimplementation?

We have full ARM disassembly (via llvm-objdump) and partial Ghidra decompilation for understanding *what* the algorithm does. Our reimplementation is verified against the debug struct oracle at every step. This is not a "clean room" (same people read disassembly and write code), but it IS GPL-compatible: we write original C code verified against behavioral output, not copying decompiled C verbatim.

### Safety: This is medical software

This algorithm's output controls insulin dosing for a Type 1 diabetes patient. Wrong glucose values can cause hypoglycemia (life-threatening) or hyperglycemia (organ damage). Every function must be verified to produce identical output to the reference implementation. There is no room for "close enough."

### Verification tolerance rules

- **Integer/boolean fields** (error codes, flags, stage, seq numbers): **exact match, zero tolerance**
- **Floating-point fields** on same ARM target: **bit-exact** (same float ABI: `-mfloat-abi=softfp`, `-mfpu=vfpv3-d16`)
- **Cross-platform verification** (Python scripts): relative tolerance 1e-10

A 1 mg/dL glucose difference at a threshold boundary can flip an error code bit, changing `errcode=0` to `errcode=1`, which means the difference between delivering insulin or not. Error codes must always match exactly.

### Key files

| File | Purpose |
|------|---------|
| `docs/reference/caresens-air-knowledge-base.md` | **START HERE** — Complete reference for subagents |
| `/Users/erik/github.com/j-kaltes/Juggluco/Common/src/main/cpp/air/air.hpp` | All struct definitions (753 lines) |
| `/Users/erik/github.com/j-kaltes/Juggluco/Common/src/main/cpp/air/java.cpp` | How Juggluco calls the algorithm via dlopen/dlsym |
| `/Users/erik/github.com/j-kaltes/Juggluco/Common/src/dex/java/tk/glucodata/AirGattCallback.java` | BLE protocol (UUIDs, authentication, commands) |
| `vendor/decompiled_c/all_functions.c` | Ghidra decompiled C (partial — math utils OK, complex functions truncated, from original analysis) |
| `vendor/decompiled/sources/com/isens/airsdk/module/type/DebugData4Obj.java` | Debug struct field names and byte layout |
| `vendor/native/lib/armeabi-v7a/libCALCULATION.so` | Proprietary library (ARM 32-bit, not stripped, with debug_info) |
| `reference/disasm/*.asm` | **Complete ARM Thumb-2 disassembly** of all key functions |

### Complete function map (opcal4)

All functions at their ELF VMA addresses (Ghidra = +0x10000):

**Signal processing pipeline:**
```
air1_opcal4_algorithm  @ 0x616e8  (main entry, ~20KB)
eliminate_peak         @ 0x6c6f8  (fully decompiled by Ghidra)
smooth_sg              @ 0x6ccbc  (111 instructions, full disasm)
fun_linear_kalman      @ 0x40528  (583 instructions, full disasm — opcal1, used as reference)
regress_cal            @ 0x6ce38  (462 instructions, full disasm)
check_boundary         @ 0x6d3d8  (fully decompiled by Ghidra)
```

**Error detection:**
```
check_error            @ 0x66688  (8008 instructions — ALL err1–err128 in one function)
cal_threshold          @ 0x61518  (fully decompiled by Ghidra)
err1_TD_var_update     @ 0x6160c  (fully decompiled by Ghidra)
err1_TD_trio_update    @ 0x61658  (fully decompiled by Ghidra)
f_check_cgm_trend      @ 0x6e498  (fully decompiled by Ghidra)
f_cgm_trend            @ 0x6d950  (636 instructions, full disasm)
```

**Math utilities (all fully decompiled by Ghidra):**
```
math_mean, math_std, math_round, math_ceil, math_max, math_min,
math_median, math_round_digits, quick_select, quick_median,
eliminate_peak, delete_element, fun_comp_decimals, f_trimmed_mean,
calcPercentile, cal_average_without_min_max
```

**Newly discovered helpers:**
```
solve_linear           @ 0x6d458  (140 instructions)
apply_simple_smooth    @ 0x6d608  (117 instructions)
smooth1q_err16         @ 0x6d740  (162 instructions)
fit_simple_regression  @ 0x6e210  (84 instructions)
f_rsq                  @ 0x6e310  (673 instructions)
```

### The calibration pipeline

```
Raw ADC (30x uint16_t)
  → eliminate_peak (2σ outlier clipping, replace with mean)
  → IIR low-pass filter (controlled by iir_flag, iir_st_d_x10)
  → drift correction (polynomial, controlled by drift_correction_on, drift_coefficient[3][3])
  → Kalman filter (3-state linear: glucose, rate, acceleration)
  → Savitzky-Golay smoothing (weighted, 7 coefficients in w_sg_x100)
  → regress_cal (weighted least-squares recalibration, if user calibration present)
  → check_boundary (parallelogram validity region for slope/intercept)
  → check_error (err1, err2, err4, err8, err16, err32, err128 — one unified function)
  → final glucose (mg/dL) + trend rate + error code
```

### The debug struct as oracle

The `air1_opcal4_debug_t` (1579 bytes, 168 fields) contains intermediate results at each pipeline stage. See `DebugData4Obj.java` for complete field names.

### Algorithm entry point

```c
typedef unsigned char (*air1_opcal4_algorithm_t)(
    air1_opcal4_device_info_t *dev_info,     // Factory calibration params
    air1_opcal4_cgm_input_t *cgm_input,      // Current reading (seq, time, 30x ADC, temp)
    air1_opcal4_cal_list_t *cal_input,        // User calibrations (passed EMPTY for factory-cal)
    air1_opcal4_arguments_t *algo_args,       // Persistent state (~106KB, accumulated over sensor lifetime)
    air1_opcal4_output_t *algo_output,        // Result: glucose, trend, error code
    air1_opcal4_debug_t *algo_debug           // Debug: all intermediate values
);
// Returns: 1 = success, 0 = failure
// Juggluco checks: res && !output.errcode
```

### Known gotcha: Kalman Q matrix

`device_info.kalman_q_x100[0][0] = -115` (a NEGATIVE value on the diagonal of what should be a positive semi-definite process noise covariance matrix). This means the Kalman filter uses a **non-standard modification**. Do NOT implement a textbook Kalman filter — use the ARM disassembly of `fun_linear_kalman` (583 instructions) to understand the actual algorithm, and verify against oracle output.

### Known gotcha: lot_type branching

The algorithm determines `lot_type` (0, 1, or 2) from `device_info.eapp` on the first call. Different lot_types use different constants throughout the algorithm. Test vectors must cover all lot_types.

### LLM-assisted transpilation workflow

For each function that Ghidra couldn't decompile:

1. **Feed LLM the ARM disassembly** (from `reference/disasm/`)
2. **Feed LLM the function signature** (from Ghidra prologue or llvm-nm)
3. **Feed LLM the local variable names** (from Ghidra stack frame analysis)
4. **Feed LLM the struct definitions** (from `air.hpp`)
5. **Feed LLM domain knowledge** (Kalman filters, S-G smoothing, etc.)
6. **LLM generates candidate C code**
7. **Compile and run against oracle**
8. **Debug struct diff shows exact field mismatches**
9. **Iterate until bit-exact match**

This is a tight feedback loop. Each iteration takes seconds (compile + run oracle on ARM device via adb).

---

## Phase 0: Project Setup & Test Harness

### Task 1: Create project structure

**Files:**
- Create: `caresens-calibration/CMakeLists.txt`
- Create: `caresens-calibration/src/calibration.h`
- Create: `caresens-calibration/src/calibration.c`
- Create: `caresens-calibration/tests/CMakeLists.txt`

**Step 1: Create the project directory and initial files**

```bash
mkdir -p ~/github.com/caresens-calibration/{src,tests,oracle,tools}
```

**Step 2: Create CMakeLists.txt with Android NDK cross-compilation support**

Target ARM with same float ABI as the original: `-mfloat-abi=softfp -mfpu=vfpv3-d16`.

**Step 3: Create calibration.h with struct definitions**

Port struct definitions from `air.hpp` to pure C (replace `std::array<T,N>` with `T name[N]`). The structs to port:
- `air1_opcal4_device_info_t`
- `air1_opcal4_cgm_input_t`
- `air1_opcal4_cal_list_t`
- `air1_opcal4_arguments_t`
- `air1_opcal4_output_t`
- `air1_opcal4_debug_t`

Verify struct sizes match with `_Static_assert(sizeof(...) == expected_size)`.

**Step 4: Commit**

```bash
git init && git add -A && git commit -m "feat: initial project structure with struct definitions"
```

---

### Task 2: Build the Oracle — Android test harness

**Goal:** Create a native ARM binary that calls the real `libCALCULATION.so` with known inputs and dumps the complete `debug_t`, `output_t`, and `arguments_t` structs to files.

**Important:** Test vectors MUST be run sequentially. The `arguments_t` struct accumulates state across the entire 15-day sensor session (865 accumulated entries, Kalman state, error history windows). You cannot test reading #100 without first processing readings #1-#99.

**Step 1: Write C test harness (not Java/JNI)**

Use `dlopen`/`dlsym` directly, same as Juggluco does. This avoids Java overhead and runs on any ARM Linux (Android device, Raspberry Pi, QEMU).

**Step 2: Create synthetic test data sequences**

Generate SEQUENTIAL test vectors covering:
- **Warmup phase**: seq 1-24 (basic_warmup=24 readings = 2 hours)
- **Stable readings**: constant ADC values → stable glucose
- **Rising glucose**: linearly increasing ADC
- **Falling glucose**: linearly decreasing ADC
- **Spike/noise/contact error**: edge cases for error detection
- **Different lot_types**: vary eapp to trigger lot_type 0, 1, and 2

**Step 3: Run on ARM device and capture output**

Use any ARM Android device via adb, or QEMU user-mode emulation. Even at 50x slowdown, individual function calls are microseconds — a 4320-reading session completes in under a minute.

**Step 4: Commit**

---

### Task 3: Build the verification framework

**Files:**
- Create: `tools/compare_debug.py`
- Create: `tools/parse_debug_struct.py`

**Step 1: Write debug struct parser**

Parse `air1_opcal4_debug_t` (1579 bytes) field by field using `DebugData4Obj.java` byte offsets.

**Step 2: Write comparison function**

```python
def compare_field(name, expected, actual):
    """Integer fields: exact match. Float fields: bit-exact on ARM, 1e-10 relative cross-platform."""
    if isinstance(expected, int):
        return expected == actual  # ZERO tolerance for error codes, flags
    if isinstance(expected, float):
        if math.isnan(expected) and math.isnan(actual):
            return True
        return expected == actual  # bit-exact on same platform
    return expected == actual
```

**Step 3: Commit**

---

## Phase 1: Math Utilities (Fully Decompiled by Ghidra)

These functions have complete, correct Ghidra decompilation. Implement from the decompiled C, verify against oracle.

### Task 4: math_mean, math_std

- `math_mean`: NaN-aware arithmetic mean. Return NaN for count=0.
- `math_std`: Sample std dev (Bessel's correction, N-1). Return NaN for 0, 0.0 for 1.

### Task 5: eliminate_peak, delete_element

- `eliminate_peak`: 2σ outlier clipping on 30-element array, replace outliers with mean.
- `delete_element`: Remove element at index, shift left, decrement size counter.

### Task 6: math_median, quick_select, quick_median

- `quick_select`: QuickSelect for k-th smallest
- `quick_median`: Dispatches to sort-median for <30 elements, quick_select otherwise

### Task 7: math_round, math_round_digits, math_ceil, math_max, math_min

Standard math with NaN handling.

### Task 8: fun_comp_decimals, f_trimmed_mean, calcPercentile

- `fun_comp_decimals`: Compare doubles rounded to N decimal places (5 comparison modes)
- `f_trimmed_mean`: Symmetric percentile trimming
- `calcPercentile`: Percentile calculation with interpolation

### Task 9: cal_average_without_min_max

Average of array excluding min and max values. (27 instructions — trivial.)

### Task 10: cal_threshold, err1_TD_var_update, err1_TD_trio_update

These error-detection helpers are fully decompiled. Implement now, use in Phase 3.

**Phase 1 Checkpoint:** All math utility tests pass. These are building blocks for everything that follows.

---

## Phase 2: Signal Processing Pipeline (LLM-Assisted Transpilation)

For functions where Ghidra decompilation is truncated, use the ARM disassembly + LLM workflow.

### Task 11: ADC-to-current conversion

**Oracle field:** `debug.tran_inA[30]`

This is inlined in `air1_opcal4_algorithm`. The conversion formula uses `vref`, `eapp`, `slope100` from device_info. Derive from the main function's disassembly or from oracle input/output pairs.

### Task 12: IIR low-pass filter

**Oracle field:** `debug.out_iir`

Inlined in main function. Controlled by `iir_flag`, `iir_st_d_x10`. State in `args.iir_x[2]`, `args.iir_y`.

### Task 13: Drift correction

**Oracle field:** `debug.out_drift`, `debug.curr_baseline`

Inlined in main function. Default `drift_correction_on=0` means pass-through for most sensors.

### Task 14: Kalman filter (fun_linear_kalman)

**Disassembly:** `reference/disasm/fun_linear_kalman.asm` (583 instructions — this is the **opcal1** variant)
**Oracle fields:** `debug.state_init_kalman`, `debug.out_rescale`

**CRITICAL:** Do NOT use textbook Kalman. The `kalman_q_x100[0][0] = -115` indicates a non-standard modification. Use the ARM disassembly to understand the actual algorithm.

**CONFIRMED: Kalman is INLINED in opcal4.** Analysis of opcal4's call graph shows NO call to `fun_linear_kalman` (0x40528) — neither direct nor indirect. The Kalman filter code is part of the ~20KB `air1_opcal4_algorithm` body. Use the opcal1 standalone version (583 instr) as a structural reference, but extract the actual implementation from the opcal4 main function disassembly. The region between `eliminate_peak` calls and `smooth_sg` call (roughly 0x62d8c–0x64e0a) likely contains the IIR filter, drift correction, AND Kalman filter. Use oracle fields `debug.out_iir`, `debug.out_drift`, `debug.out_rescale` to isolate each stage.

**Local variables from Ghidra:** `kalman_q[3][3]`, `kalman_a[3][3]`, `kalman_at[3][3]`, `temp_p[3][3]` — confirming it IS a 3x3 state-space model, but the Q matrix handling is non-standard.

**LLM workflow:**
1. Feed the 583-instruction disassembly to LLM
2. Feed the struct definitions and local variable names
3. LLM generates C code
4. Verify against oracle `debug.out_rescale` field
5. Iterate

### Task 15: Savitzky-Golay smoothing (smooth_sg)

**Disassembly:** `reference/disasm/smooth_sg_opcal4.asm` (111 instructions)
**Oracle fields:** `debug.smooth_sig[6]`, `debug.smooth_seq[6]`, `debug.smooth_frep[6]`

At 111 instructions, this is small enough that LLM transpilation should be near-perfect on first attempt.

### Task 16: regress_cal (weighted least-squares recalibration)

**Disassembly:** `reference/disasm/regress_cal_opcal4.asm` (462 instructions)
**Oracle fields:** `debug.cal_slope[7]`, `debug.cal_ycept[7]`

**Local variables from Ghidra:** `x[60]`, `y[60]`, `X[60][2]`, `w[60]`, `XtX[2][2]`, `Xty[2]`, `r[60]`, `abs_r[60]`, `xtwx[2][2]`, `xtwy[2]`, `gauss_var` — confirms IRLS weighted regression.

**Newly discovered helpers:**
- `solve_linear` (140 instr) — solves the 2x2 linear system
- `fit_simple_regression` (84 instr) — simple linear regression for initial estimate

### Task 17: check_boundary (parallelogram validity)

**Already fully decompiled by Ghidra.** Direct implementation.

**Phase 2 Checkpoint:** Every intermediate debug field matches the oracle exactly.

---

## Phase 3: Error Detection (check_error — the big one)

**Disassembly:** `reference/disasm/check_error.asm` (8008 instructions, 24,948 bytes)

This is one massive function containing ALL error detection logic. It is 3× larger than the entire signal processing pipeline. Plan accordingly.

**Strategy:** Split the function logically by error code. The debug struct has separate fields for each error detector (error_code1, error_code2, ..., err1_*, err2_*, ...). Implement one error detector at a time, verify its debug fields, then move to the next.

### Task 18: err1 — contact/noise error (bit 0)

**Oracle fields:** `debug.error_code1`, `debug.err1_*` (20+ fields)

The most complex error detector. Uses helpers:
- `cal_threshold` (fully decompiled)
- `err1_TD_var_update` (fully decompiled)
- `err1_TD_trio_update` (fully decompiled)

**Approach:** Identify the err1 region in check_error's disassembly by looking for accesses to `args.err1_*` fields. Use LLM to transpile that region.

### Task 19: err2 — rate-of-change error (bit 1)

**Oracle fields:** `debug.error_code2`, `debug.err2_*`

Uses `f_trimmed_mean` for robust statistics. Delay buffer logic with 575-element arrays.

### Task 20: err4 — signal quality (bit 2)

**Oracle fields:** `debug.error_code4`, `debug.err4_*`

Minimum tracking, range analysis, delayed flag accumulation.

### Task 21: err8 — boundary check (bit 3)

**Oracle fields:** `debug.error_code8`, `debug.err8_condi[2]`

Likely the simplest error detector.

### Task 22: err16 — sensor drift/degradation (bit 4)

**Oracle fields:** `debug.error_code16`, `debug.err16_*` (40+ fields)

The second most complex detector. Uses helpers:
- `f_cgm_trend` (636 instr disassembly)
- `f_check_cgm_trend` (fully decompiled)
- `smooth1q_err16` (162 instr)
- `apply_simple_smooth` (117 instr)
- `f_rsq` (673 instr)
- `fit_simple_regression` (84 instr)
- `solve_linear` (140 instr)

Maintains 865-element history arrays, multi-scale trend decomposition (min, mode, mean variants).

### Task 23: err32 — BLE data gap (bit 5)

**Oracle fields:** `debug.error_code32`

Timing-based detection of data gaps.

### Task 24: err128 — noise/spike revision (bit 7)

**Oracle fields:** `debug.err128_flag`, `debug.err128_revised_value`, `debug.err128_normal`

**Phase 3 Checkpoint:** Combined error code from our implementation exactly matches oracle for every test vector. Every individual error bit matches. Every error-related debug field matches.

---

## Phase 4: Integration & Main Entry Point

### Task 25: Implement air1_opcal4_algorithm

Wire all components together. The main function is ~20KB of code (partially decompiled by Ghidra at 991 lines). Much of it is initialization, lot_type branching, and plumbing between the pipeline stages.

Use the partially decompiled Ghidra output for the overall flow, ARM disassembly for the details, and oracle for verification.

**Must handle:**
- First-call initialization (lot_type from eapp)
- Lot_type-dependent constant selection
- Sequential state accumulation in arguments_t
- All pipeline stages in correct order
- Debug struct population

### Task 26: Extended validation — 15-day session

Simulate 4320 sequential readings. Every glucose value, trend rate, and error code must match the oracle exactly. Generate a field-by-field difference report.

---

## Phase 5: Safety Verification

### Task 27: Boundary and edge case testing

1. Hypoglycemia accuracy (40-70 mg/dL)
2. Normal range accuracy (70-180 mg/dL)
3. Hyperglycemia accuracy (180-500 mg/dL)
4. Error detection coverage (every error condition triggers)
5. Warmup behavior, sensor expiry, temperature, ADC saturation
6. Time gap handling, state persistence
7. All lot_types (0, 1, 2)

### Task 28: Parallel validation with Juggluco

Run our library and libCALCULATION.so side-by-side on REAL sensor data from an actual CareSens Air sensor. Instrument Juggluco's `AirGattCallback.java` to log raw BLE packets, replay through both implementations, compare reading-by-reading.

---

## Phase 6: Integration into xDrip+/AndroidAPS

### Task 29: Create Android library (.aar)

Package as Android AAR with JNI bindings.

### Task 30: xDrip+ integration

New `DexCollectionType` + BLE collector service using protocol from `AirGattCallback.java`.

### Task 31: AndroidAPS integration

New `BgSource` plugin following existing plugin architecture.

---

## Risk Register

| Risk | Impact | Mitigation |
|------|--------|------------|
| LLM misinterprets ARM assembly | Wrong C code | Oracle catches instantly; iterate |
| Kalman Q matrix non-standard | Wrong glucose values | Full disassembly available (583 instr); oracle verification |
| Lot_type constants unknown | Incorrect behavior for some sensors | Extract from disassembly; test all 3 lot_types |
| check_error too complex to transpile at once | Slow progress on Phase 3 | Split by error code; each has its own debug fields |
| Float precision across platforms | False test failures | Compile with same ARM float ABI; verify bit-exact on target |
| Safety-critical insulin dosing | Patient harm | NEVER deploy without 100% oracle match on real sensor data |

---

## Definition of Done

- [ ] All math utilities verified against oracle (Phase 1)
- [ ] All signal processing stages verified bit-exact against oracle (Phase 2)
- [ ] All error detectors verified — error codes exact match, debug fields exact (Phase 3)
- [ ] Full pipeline matches oracle for 4320-reading session — zero differences (Phase 4)
- [ ] All safety boundary tests pass, all lot_types tested (Phase 5)
- [ ] Real sensor data parallel validation shows 100% match (Phase 5)
- [ ] Code review by at least 2 independent reviewers from DIY diabetes community
- [ ] GPL-2.0 license applied, no proprietary code copied
