# CareSens Air CGM — Complete Knowledge Base for Subagents

> **Purpose:** This document contains EVERYTHING a subagent needs to understand the CareSens Air calibration algorithm project. Read this before doing any work. It is comprehensive by design — wrong assumptions in medical device software can endanger a patient's life.

---

## 1. Project Context: Why This Exists

### The Patient
Laurens, a 9-year-old boy with Type 1 diabetes, uses the CareSens Air CGM sensor. His father (Erik's nephew) manages his glucose monitoring. The CareSens Air works with the proprietary i-SENS app or with Juggluco (an open-source app that wraps the proprietary library). But it does NOT work with xDrip+ or AndroidAPS — the two most important open-source apps in the DIY diabetes community — because these apps cannot bundle the proprietary `libCALCULATION.so`.

### The Goal
Build an open-source, GPL-compatible reimplementation of the calibration algorithm so that CareSens Air can be directly integrated into xDrip+ and AndroidAPS, eliminating the need for Juggluco as intermediary.

### Why This Is Safety-Critical
The calibration algorithm's output controls insulin dosing. A glucose reading that is wrong by even 1 mg/dL at a threshold boundary can flip an error code bit, which determines whether insulin is delivered or withheld. Wrong values can cause:
- **Hypoglycemia** (life-threatening — patient can lose consciousness, seizures, death)
- **Hyperglycemia** (organ damage over time)

**There is no room for "close enough." Every field must match the reference implementation exactly.**

---

## 2. The Hardware: CareSens Air CGM Sensor

- **Manufacturer:** i-SENS (South Korea)
- **Sensor lifetime:** 15 days (4320 readings at 5-minute intervals)
- **Warmup period:** 2 hours (24 readings, controlled by `basic_warmup=24`)
- **Data transmission:** BLE (Bluetooth Low Energy)
- **Raw output:** 30× uint16_t ADC values per reading (one reading every 5 minutes, with 30 sub-readings per 10 seconds within that window)
- **Temperature:** Sent alongside ADC data
- **Calibration:** Factory-calibrated (no user finger-stick calibration required, though supported)

### What the sensor sends (raw)
Each BLE packet (0xC5 command) contains:
```
deviceErrorCode: int8     — 0 = normal
r_count: uint8
a_count: uint32
misc: uint32
sequenceNumber: uint32    — monotonically increasing, 1 per 5-minute reading
time: uint32              — unix timestamp
battery: uint16
temperature: uint16       — multiply by 0.01 for °C
glucose_array: uint16[30] — RAW ADC values (NOT glucose!)
```

The sensor does NOT compute glucose. It sends raw electrochemical ADC values that must be converted by the calibration algorithm.

---

## 3. BLE Protocol (from Juggluco's AirGattCallback.java)

### BLE Services and Characteristics
```
Service 1: c4de7bda-5a9d-11e9-8647-d663bd873d93
  char1: c4de7e96  — Device Info (SW revision, etc.)
  char2: c4de83c8  — Device Info
  char3: c4de8544  — Device Info (model, FW revision)
  char4: c4de86a2  — Device Info
  char5: c4de87e2  — Device Info
  char6: c4de89ae  — Device Info
  char7: c4de8af8  — Device Info

Service 2: c4de9a20-5a9d-11e9-8647-d663bd873d93 (Scan Service)
  char11: c4de9b74 — Glucose data (NOTIFY: receive raw readings)
                     Commands: 0xC4/0x01=number records, 0xC5/0x01=data

Service 3: c4de9dc2-5a9d-11e9-8647-d663bd873d93
  char21: c4de9ee4 — Control (authentication, sensor info, time sync)
  char22: c4dec61c — App registration
```

### Connection Flow
1. Connect → requestMtu(512) → discoverServices
2. Enable notifications on char11 → enable notifications on char21
3. **Authentication** (firmware ≥1.4): AES-CBC encrypt serial number with key `tq1Tg265o4UFD8tfPvNqUCiYyCxkhdZV`, IV = last6+last6+last4 of serial
4. Enable notifications on char22 → Send app registration: `{0xC0, 0x03, "csair", ..., unusedSensor?1:0}`
5. Receive `{0xC0, 0x01, ...}`: device time, userID, dataCountPerSet, AdcInterval → time sync if needed
6. Receive `{0xC0, 0x02, ...}`: **eapp** (float at offset 2) and **vref** (float at offset 6), elapsedSecs → `airSaveStartSensor(eapp, vref, elapsedSecs)`
7. Request sensor info: `{0xC2, 0x01}` → receive and save via `airSaveSensorInfo`
8. Receive second part: `{0xC2, 0x02}` → save via `airSaveSensorInfo2`
9. Receive CRC: `{0xC2, 0x03}` → verify CRC
10. Request data: `{0xC4, 0x01, lastSeqNumber}` → receive `{0xC5, 0x01, ...}` glucose data packets

### Key: eapp and vref
These two floating-point values from the sensor are CRITICAL:
- **eapp** — determines `lot_type` (0, 1, or 2), which selects different calibration constants throughout the algorithm
- **vref** — reference voltage for ADC-to-current conversion
- Stored in `device_info.eapp` and `device_info.vref`
- Set via `airSaveStartSensor()` which also records `sensor_start_time`

### Pairing
PIN-based pairing using 6-byte PIN from `airGetPin(dataptr)`.

### Device Name Pattern
BLE device name: `CSAir XXXX` where XXXX = last 4 characters of serial number.

---

## 4. The Proprietary Library: libCALCULATION.so

### Binary Details
```
Format:           ELF 32-bit LSB shared object
Architecture:     ARM (armeabi-v7a, Thumb-2)
Float ABI:        softfp with VFPv3-d16
NOT stripped:      Contains debug_info and complete symbol table
Developer path:   /Users/hojun/project/caresens_air_android/csair_sdk/Core/src/main/cpp/
Source files:      algorithm.c, cgms_algorithm.c through cgms_algorithm6.c
.text section:     VMA 0x31178–0x6ef8c (254,996 bytes)
```

### WHY function names are known
The library was compiled with debug info and **never stripped**. The ELF `.symtab` section contains every function name, address, and size. `llvm-nm` reads these directly — no decompilation needed. Even `static` (local) functions appear (marked with lowercase `t` in nm output).

### Multiple Algorithm Versions
The library contains 5 independent algorithm versions, each with its own complete copy of all helper functions:

| Version | Entry Point | Address | Era |
|---------|------------|---------|-----|
| `cgms_algorithm` | Legacy | 0x32cf8 | Original |
| `air1_opcal_algorithm` | opcal1 | 0x40d38 | v1 |
| `air1_opcal2_algorithm` | opcal2 | 0x4a280 | v2 |
| `air1_opcal3_algorithm` | opcal3 | 0x537b0 | v3 |
| `air1_opcal4_algorithm` | opcal4 | 0x616e8 | **Current (v4)** |

**We only need to reimplement opcal4.** Juggluco calls `air1_opcal4_algorithm` via `dlsym`.

Each version has its own private copies of helper functions (math_mean, eliminate_peak, etc.) at different addresses. The opcal4 helpers live in the 0x6xxxx address range.

### Address Mapping: Ghidra vs ELF
**CRITICAL:** Ghidra applied a 0x10000 base offset when loading this ELF:
```
Ghidra address = ELF VMA + 0x10000
ELF VMA = Ghidra address - 0x10000
```
Example: `smooth_sg` is at Ghidra address 0x7ccbc = ELF VMA 0x6ccbc.

All disassembly files use ELF VMA addresses (the correct ones). All Ghidra decompiled code uses Ghidra addresses (+0x10000).

---

## 5. Algorithm Entry Point and Data Structures

### Function Signature
```c
typedef unsigned char (*air1_opcal4_algorithm_t)(
    air1_opcal4_device_info_t *dev_info,     // Factory calibration parameters (from sensor info BLE packets)
    air1_opcal4_cgm_input_t *cgm_input,      // Current reading (seq_number, time, 30× ADC, temperature)
    air1_opcal4_cal_list_t *cal_input,        // User calibrations (passed EMPTY by Juggluco = factory-cal only)
    air1_opcal4_arguments_t *algo_args,       // Persistent state (~106KB, accumulated over 15-day sensor lifetime)
    air1_opcal4_output_t *algo_output,        // Output: glucose value, trend rate, error code
    air1_opcal4_debug_t *algo_debug           // Debug oracle: ALL intermediate values (168 fields, 1579 bytes)
);
// Returns: 1 = success, 0 = failure
// Juggluco checks: res && !output.errcode
// Glucose validity check: 35.0 < result_glucose < 505.0
```

### How Juggluco Calls It (java.cpp)
```c
// Input setup (from BLE packet):
air_input input = {
    .data = {
        .sequence_number = (uint16_t)air->sequenceNumber,
        .measurement_time = mtime,
        .glucose_array = air->glucose_array,
        .temperature = air->temperature / 100.0
    }
};
// The cal_list is part of air_input and is passed EMPTY (zeroed)
// algo_args = sdata->generated.data() — persistent across calls

unsigned char res = air1_opcal4_algorithm(
    (air1_opcal4_device_info_t*)deviceInfo,
    &input.cgm_input,
    &input.empty,       // EMPTY cal_list — factory calibration only
    sdata->generated.data(),  // persistent arguments_t
    &output,
    &debug
);

if (res && !output.errcode) {
    // Use output.result_glucose (mg/dL)
    // Use output.trendrate (mg/dL/min)
}
```

### Key Data Structures

#### air1_opcal4_device_info_t (Factory calibration — from sensor BLE)
Source: `air.hpp:485-602` and defaults in `DeviceInfo2Obj` (air.hpp:604-720)

Key fields with default values:
```
sensor_version = 1
ycept = 1.0f                    — y-intercept for ADC conversion
slope100 = 3.5226f              — slope × 100 for ADC conversion
slope_ratio = 1.0f
basic_warmup = 24               — 24 readings = 2 hours warmup
iir_flag = 1                    — IIR filter enabled
iir_st_d_x10 = 90              — IIR filter parameter × 10
drift_correction_on = 0         — drift correction disabled by default
kalman_t90 = 10
kalman_delta_t = 5
kalman_q_x100[3][3] = {{-115,0,0},{0,1440,0},{0,0,10}}  — NON-STANDARD (negative!)
kalman_r_x100 = 200
w_sg_x100[7] = {80,130,90,80,110,90,80}  — Savitzky-Golay weights × 100
vref = 1.49594f                 — reference voltage (set from BLE)
eapp = 0.10067f                 — applied potential (determines lot_type, set from BLE)
sensor_start_time               — unix timestamp (set from BLE)
```

**CRITICAL: The negative `kalman_q_x100[0][0] = -115` means the Kalman filter is NOT a textbook implementation. Do not use standard Kalman filter equations — follow the ARM disassembly exactly.**

#### air1_opcal4_cgm_input_t (Per-reading input)
```c
struct air1_opcal4_cgm_input_t {
    uint16_t seq_number;            // Monotonically increasing (1, 2, 3, ...)
    uint32_t measurement_time_standard; // Unix timestamp
    uint16_t workout[30];           // 30 raw ADC values (10-second sub-samples)
    double temperature;             // °C (from BLE: temperature/100.0)
};
```

#### air1_opcal4_arguments_t (Persistent state — ~106KB!)
Source: `air.hpp:68-283`

This accumulates state over the entire 15-day sensor lifetime. It contains:
- `args_seq` — current sequence counter
- `lot_type` — determined from eapp on first call (0, 1, or 2)
- `accu_seq[865]`, `curr_avg_arr[865]` — accumulated readings
- `prev_current[5]`, `prev_new_i_sig[5]` — recent history
- `iir_x[2]`, `iir_y` — IIR filter state
- `out_kalman[3]` — Kalman filter state vector [glucose, rate, acceleration]
- `kalman_roc[4]` — Kalman rate-of-change history
- `smooth_sig_in[10]`, `smooth_time_in[10]` — smoothing buffer
- `cal_result_*[7]` — calibration results
- Error detection state:
  - `err1_*` — 20+ fields for contact/noise error history
  - `err2_delay_*[575]` — 575-element delay buffers!
  - `err4_*[576]` — signal quality history
  - `err16_CGM_ISF_smooth[865]` — sensor drift tracking (865 entries!)
  - `err32_*` — timing gap detection

**IMPORTANT:** Test vectors MUST be run sequentially. Reading #100 depends on the accumulated state from readings #1-#99. You cannot test readings in isolation.

#### air1_opcal4_output_t (Result per reading)
```c
struct air1_opcal4_output_t {
    uint16_t seq_number_original;
    uint16_t seq_number_final;
    uint32_t measurement_time_standard;
    uint16_t workout[30];            // Processed ADC values
    double result_glucose;           // THE glucose value (mg/dL)
    double trendrate;                // Rate of change (mg/dL/min)
    uint8_t current_stage;           // Algorithm stage
    uint8_t smooth_fixed_flag[6];
    uint16_t smooth_seq[6];          // Smoothed historical sequence numbers
    double smooth_result_glucose[6]; // Smoothed historical glucose values
    uint16_t errcode;                // Error bits: 1|2|4|8|16|32|128
    uint8_t cal_available_flag;
    uint8_t data_type;
};
```

#### air1_opcal4_debug_t (Oracle — 1579 bytes, 168 fields)
Source: `air.hpp:316-484`, byte layout in `DebugData4Obj.java:516-737`

This contains the intermediate result of EVERY pipeline stage:
- `tran_inA[30]` — ADC-to-current converted values
- `out_iir` — IIR filter output
- `out_drift` — drift correction output
- `out_rescale` — Kalman filter output
- `smooth_sig[6]`, `smooth_seq[6]` — smoothing output
- `cal_slope[7]`, `cal_ycept[7]` — calibration parameters
- `error_code1..32` — individual error detector results
- `err1_*`, `err2_*`, `err4_*`, `err8_*`, `err16_*`, `err128_*` — per-error-detector debug fields

**This is our oracle.** We verify EVERY field of our reimplementation against the reference library's debug output.

---

## 6. The Calibration Pipeline

```
Raw ADC (30× uint16_t from BLE)
  │
  ├─ eliminate_peak()          — 2σ outlier clipping, replace outliers with mean
  │                              Oracle: debug.tran_inA[30] (after ADC→current conversion)
  │
  ├─ IIR low-pass filter      — Controlled by iir_flag, iir_st_d_x10
  │                              State: args.iir_x[2], args.iir_y
  │                              Oracle: debug.out_iir
  │
  ├─ Drift correction         — Polynomial, controlled by drift_correction_on
  │                              Default OFF (pass-through for most sensors)
  │                              Oracle: debug.out_drift, debug.curr_baseline
  │
  ├─ Kalman filter             — 3-state linear: [glucose, rate, acceleration]
  │   (fun_linear_kalman)        NON-STANDARD Q matrix (negative diagonal!)
  │                              Oracle: debug.state_init_kalman, debug.out_rescale
  │
  ├─ Savitzky-Golay smoothing — Weighted convolution, 7 coefficients (w_sg_x100)
  │   (smooth_sg)                Oracle: debug.smooth_sig[6], smooth_seq[6], smooth_frep[6]
  │
  ├─ regress_cal()             — Weighted least-squares recalibration (if user cal present)
  │                              Oracle: debug.cal_slope[7], debug.cal_ycept[7]
  │
  ├─ check_boundary()          — Parallelogram validity region for slope/intercept
  │
  ├─ check_error()             — ALL error detection (err1, err2, err4, err8, err16, err32, err128)
  │                              Oracle: debug.error_code1..32, debug.err1_*, err2_*, etc.
  │
  └─ Final output:
      result_glucose (mg/dL) + trendrate (mg/dL/min) + errcode (uint16_t bitmask)
```

---

## 7. Complete Function Inventory (opcal4 only)

### Disassembly available at: `reference/disasm/`

### How to create disassembly for any function
```bash
OBJDUMP=$(xcrun --find llvm-objdump)
$OBJDUMP -d --triple=thumbv7-linux-gnueabi \
    --start-address=<ELF_VMA_START> --stop-address=<ELF_VMA_END> \
    vendor/native/lib/armeabi-v7a/libCALCULATION.so > output.asm
```

### Main Entry Point
| Function | ELF Address | Size | Status |
|----------|------------|------|--------|
| `air1_opcal4_algorithm` | 0x616e8 | ~20KB | Partially decompiled by Ghidra (991 lines) + full disasm |

### Signal Processing Functions
| Function | ELF Address | Instructions | Disasm File | Ghidra Status |
|----------|------------|-------------|-------------|---------------|
| `eliminate_peak` | 0x6c6f8 | ~100 | — | **Fully decompiled** |
| `smooth_sg` | 0x6ccbc | 111 | `smooth_sg_opcal4.asm` | Truncated → full disasm |
| `fun_linear_kalman` | 0x40528 | 583 | `fun_linear_kalman.asm` | Truncated → full disasm (opcal1 variant, used as reference) |
| `regress_cal` | 0x6ce38 | 462 | `regress_cal_opcal4.asm` | Truncated → full disasm |
| `check_boundary` | 0x6d3d8 | ~100 | — | **Fully decompiled** |

### Error Detection Functions
| Function | ELF Address | Instructions | Disasm File | Ghidra Status |
|----------|------------|-------------|-------------|---------------|
| `check_error` | 0x66688 | **8008** | `check_error.asm` | Not found by Ghidra → full disasm |
| `cal_threshold` | 0x6e908 | ~100 | — | **Fully decompiled** |
| `err1_TD_var_update` | 0x6e9fc | ~50 | — | **Fully decompiled** |
| `err1_TD_trio_update` | 0x6ea48 | ~50 | — | **Fully decompiled** |
| `f_check_cgm_trend` | 0x6e498 | ~200 | — | **Fully decompiled** |
| `f_cgm_trend` | 0x6d950 | 636 | `f_cgm_trend_opcal4.asm` | Truncated → full disasm |

### Math Utility Functions (ALL fully decompiled by Ghidra)
| Function | ELF Address | Purpose |
|----------|------------|---------|
| `math_mean` | 0x6c6a0 | NaN-aware arithmetic mean |
| `math_std` | 0x6c610 | Sample standard deviation (N-1) |
| `math_round` | 0x6c758 | Standard rounding |
| `math_ceil` | 0x6cde8 | Ceiling |
| `math_max` | 0x6e400 | Maximum of two doubles |
| `math_min` | 0x6e448 | Minimum of two doubles |
| `math_median` | 0x6c950 | Median (sort-based for small arrays) |
| `math_round_digits` | 0x6cbd0 | Round to N decimal places |
| `quick_select` | 0x6ca20 | QuickSelect for k-th smallest |
| `quick_median` | 0x6c7a0 | QuickSelect-based median |
| `eliminate_peak` | 0x6c6f8 | 2σ outlier clipping |
| `delete_element` | 0x6c668 | Array element removal |
| `fun_comp_decimals` | 0x6c828 | Compare doubles rounded to N decimals |
| `f_trimmed_mean` | 0x6e170 | Symmetric percentile trimming |
| `calcPercentile` | 0x6e0e0 | Percentile with interpolation |

### Newly Discovered Helper Functions
| Function | ELF Address | Instructions | Disasm File | Purpose |
|----------|------------|-------------|-------------|---------|
| `solve_linear` | 0x6d458 | 140 | `solve_linear.asm` | 2×2 linear system solver |
| `apply_simple_smooth` | 0x6d608 | 117 | `apply_simple_smooth.asm` | Smoothing helper |
| `smooth1q_err16` | 0x6d740 | 162 | `smooth1q_err16.asm` | err16-specific smoothing (Hann window + Fourier) |
| `fit_simple_regression` | 0x6e210 | 84 | `fit_simple_regression.asm` | Simple linear regression (NaN-aware) |
| `f_rsq` | 0x6e310 | 673 | `f_rsq.asm` | R-squared calculation |
| `cal_average_without_min_max` | 0x6cc68 | 27 | `cal_average_without_min_max.asm` | Trimmed average |

### Internal Utility Functions
| Function | ELF Address | Purpose |
|----------|------------|---------|
| `clear_mem` | 0x66674 | `memset(ptr, 0, size)` — wrapper for `__aeabi_memclr8` |
| `copy_mem` | 0x6c5fe | `memcpy(dst, src, size)` |
| `MathRoundToInt` | — | Round double to integer (not in opcal4, only opcal1/2) |

---

## 8. Ghidra Decompiled Code Reference

### Location
`vendor/decompiled_c/all_functions.c` (8735 lines, 267KB — from original Ghidra analysis)

### What's Useful vs Not
- **Math utilities (lines ~1000-3000):** Fully decompiled, directly usable as implementation reference
- **Error helpers (cal_threshold, err1_TD_*):** Fully decompiled, directly usable
- **check_boundary:** Fully decompiled, directly usable
- **air1_opcal4_algorithm (line 6171, 991 lines):** Partially decompiled — the overall flow is visible but some expressions are garbled (especially floating-point operations)
- **Truncated functions (smooth_sg, regress_cal, fun_linear_kalman):** Only prologue — UNUSABLE, use ARM disassembly instead
- **check_error:** Not found by Ghidra at all — use ARM disassembly

### Known Ghidra Artifacts
- Ghidra uses addresses offset by +0x10000 from real ELF VMA
- Truncation pattern: function prologue → `__aeabi_memclr8()` call → `return;`
- Float operations sometimes shown as integer manipulations of fpscr register
- Some function calls shown as `(*pcVar10)(...)` — indirect calls via GOT

---

## 9. ARM Disassembly Reading Guide

### Instruction Set
ARM Thumb-2 with VFPv3-d16 floating-point:
- **d0–d15:** 64-bit double-precision floating-point registers
- **s0–s31:** 32-bit single-precision floating-point registers
- **r0–r12:** General-purpose 32-bit integer registers

### Key Instructions for This Codebase
```
vldr   d16, [r0]        — Load double from memory
vstr   d16, [r0, #8]    — Store double to memory
vadd.f64 d0, d1, d2     — d0 = d1 + d2 (double)
vsub.f64 d0, d1, d2     — d0 = d1 - d2
vmul.f64 d0, d1, d2     — d0 = d1 × d2
vdiv.f64 d0, d1, d2     — d0 = d1 / d2
vmla.f64 d0, d1, d2     — d0 = d0 + (d1 × d2)  (multiply-accumulate)
vmls.f64 d0, d1, d2     — d0 = d0 - (d1 × d2)  (multiply-subtract)
vcmp.f64 d0, d1         — Compare d0 with d1
vmrs APSR_nzcv, fpscr   — Move FP status to integer flags (for branching)
vcvt.f64.s32 d0, s0     — Convert signed int32 to double
vcvt.f64.u32 d0, s0     — Convert unsigned int32 to double
vmov s0, r0             — Move integer register to FP register
vmov r0, r1, d0         — Move double to two integer registers
vmov.i32 d0, #0x0       — Load immediate zero into d-register
vmov.f64 d0, #2.0       — Load immediate float constant
it/ite/itttt cond        — If-Then block (conditional execution)
cbz r0, target           — Compare and Branch if Zero
blx target               — Branch with Link (function call)
push/pop                 — Stack operations
ldr r0, [pc, #offset]    — PC-relative load (constants from literal pool)
```

### Calling Convention (ARM AAPCS)
- **Arguments:** r0, r1, r2, r3 (integer/pointer), d0-d7 (float/double)
- **Return:** r0 (integer), d0 (float/double)
- **Callee-saved:** r4-r11, d8-d15
- **Literal pool:** Constants at end of function, loaded via PC-relative `ldr`

### Reading Double Constants from Literal Pool
Look for `.word` entries at the end of functions:
```asm
6d928: 18 2d 44 54   .word 0x54442d18
6d92c: fb 21 09 40   .word 0x400921fb
```
This is little-endian IEEE 754 double: `0x400921fb54442d18` = **π (3.14159265...)**

Common constants found:
- `0x400921fb54442d18` = π
- `0xc01921fb54442d18` = -2π
- `0x401921fb54442d18` = 2π
- `0x8000000000000000` = -0.0

---

## 10. Key Algorithms: What We Know

### ADC-to-Current Conversion
Inlined in main function. Uses `vref`, `eapp`, `slope100`:
```
current = (ADC_value * vref / 65536 - eapp) * slope100 / 100
```
(Exact formula to be confirmed from disassembly -- verify against `debug.tran_inA[30]`)

### tran_inA Processing Pipeline (FULLY SOLVED)

The complete algorithm from `tran_inA[30]` (per-sample ADC-converted values) to
`tran_inA_1min[5]` (one-minute current averages) has been reverse-engineered and
validated against the oracle with bit-perfect accuracy across all tested sequences.

**Algorithm Flow:**
```
tran_inA[30] (from per-sample loop with outlier removal at indices 4,14,20,28)
  |
  +-- seq <= 2 OR time_gap >= 897.2s: SIMPLE PATH
  |     intermediate_30 = tran_inA (pass-through)
  |
  +-- seq >= 3 AND time_gap < 897.2s: IRLS LOESS PATH
  |     data_90 = [history_60, per_sample_output_30]
  |     intermediate_30 = irls_loess(data_90)[60:90]  (last 30 of 90 fitted values)
  |
  +-- Running Median Filter (5 groups x 6 windows)
  |     For each group of 6 values, compute 6 running medians:
  |       median([0:3]), median([0:4]), median([0:5]), median([0:6]),
  |       median([1:6]), median([2:6])
  |     Result: 30 running medians
  |
  +-- FIR Filter (if seq >= 2 AND time_gap < 327.2s)
  |     Coefficients: [-0.25, 1.0, 1.75, 2.0, 1.75, 1.0, -0.25] / 7.0
  |     Input: extended = prev3[3] + medians[30] = 33 values
  |     For k=0..26: out[k] = sum(coeff[j] * extended[k+j]) / 7.0
  |     Boundary (k=27,28,29): truncated filter, denominators 7.25, 6.25, 4.5
  |     Update prev3 = medians[27:30] (raw un-FIR'd medians, stored at args+0xf48)
  |
  +-- cal_average_without_min_max (per group of 6)
        For each group of 6 FIR'd medians: remove min and max, average remaining 4
        Result: tran_inA_1min[5]
```

**IRLS LOESS Regression Details:**

The IRLS LOESS regression at 0x63cf2-0x63eba performs locally-weighted polynomial
(degree 1) regression with bisquare reweighting:

- **Input:** 90 data points with 1-based x-values (x=1..90)
  - data[0:30] = oldest history (args+0xd68, from 2 readings ago)
  - data[30:60] = recent history (args+0xe58, from 1 reading ago, PRE-call state)
  - data[60:90] = current per-sample loop output

- **LOESS kernel weights:** Pre-computed tricube kernel stored as 90x45 doubles
  at symbol `air1_opcal4_loess_weight_arr` (ELF address 0x29240, file offset 0x29240).
  Each row = one data point, each column = one eval point (for eval points 0-44).
  For eval points 45-89, use symmetry: weight[e][d] = table[89-d][89-e].
  Bandwidth varies per eval point (k-nearest neighbor, k=86 of 90 points).

- **Bisquare reweighting:** Up to 3 iterations.
  After each fit: compute absolute residuals, find median absolute residual,
  set threshold = 6.0 * median_abs_resid,
  bisquare_weight[i] = (1 - min(|residual[i]|/threshold, 1)^2)^2.
  If any weight is NaN, stop iterations early.

- **Output:** 90 fitted values. Take fitted[60:90] as the intermediate array
  that feeds the running median filter.

**Key Offsets in arguments_t (from disassembly, NOT from C header):**
```
args + 0x0d38: prev_current[5] (5 doubles)
args + 0x0d68: prev_outlier_removed_curr[0:30] (30 doubles, old history)
args + 0x0e58: prev_outlier_removed_curr[30:60] (30 doubles, current history)
args + 0x0f48: prev_mov_median_curr[3] (3 doubles, prev3 for FIR)
args + 0x0648: args_seq (uint16_t, incremented early in the function)
```
NOTE: These offsets do NOT match the computed offsets from the C header struct.
The C header yields offsets ~13 bytes lower. Always use the disassembly offsets.

**Verification Status:**
- Seq 1 (simple, no FIR): PERFECT MATCH (delta < 4e-15)
- Seq 2 (simple, with FIR): PERFECT MATCH (delta < 8e-15)
- Seq 3-10 (IRLS + FIR): PERFECT MATCH (delta < 8e-14)
- Seq 24-25 (IRLS + FIR, with glucose change): PERFECT MATCH (delta < 8e-14)
- Full end-to-end simulation maintaining state: CONFIRMED for all sequences
  with available args checkpoints

**Implementation files:**
- `tools/irls_with_kernel.py` -- IRLS with extracted kernel table
- `tools/full_simulation.py` -- end-to-end validation
- `tools/gdb_dump_intermediate.py` -- FIR on medians validation

### lot_type Determination
On first call (seq==1), the algorithm determines `lot_type` from `eapp`:
- lot_type 0, 1, or 2
- Different lot_types select different calibration constants throughout the algorithm
- Must be tested with all 3 lot_types

### IIR Low-Pass Filter
State: `args.iir_x[2]`, `args.iir_y`
Controlled by: `iir_flag`, `iir_st_d_x10`
Oracle: `debug.out_iir`

### Kalman Filter (fun_linear_kalman — 583 instructions)
**NON-STANDARD.** The Q matrix has `kalman_q_x100[0][0] = -115` (negative value on the diagonal). This violates the positive semi-definite requirement of standard Kalman filters.

Ghidra local variables confirm 3×3 state-space model:
- `kalman_q[3][3]`, `kalman_a[3][3]`, `kalman_at[3][3]`, `temp_p[3][3]`

State vector: [glucose_estimate, rate_of_change, acceleration]

**DO NOT** implement a textbook Kalman filter. Use the ARM disassembly to understand the exact algorithm, and verify against `debug.out_rescale` and `debug.state_init_kalman`.

**CONFIRMED:** There is only ONE `fun_linear_kalman` in the entire library — at address 0x40528 in the opcal1 region. Analysis of opcal4's call graph shows it does **NOT** call `fun_linear_kalman` — neither directly (`bl 0x40528`) nor indirectly. The Kalman filter is therefore **inlined** in `air1_opcal4_algorithm` (and possibly modified from the opcal1 version).

**opcal4's complete call graph** (direct calls from `air1_opcal4_algorithm`):
```
Helper functions called directly:
  copy_mem, math_std, delete_element, math_mean, eliminate_peak,
  math_round, math_median, fun_comp_decimals, quick_median,
  cal_average_without_min_max, smooth_sg, math_ceil,
  regress_cal (called 3×), check_boundary (called 3×),
  apply_simple_smooth (called 2×), check_error (called 1×)

Indirect calls (via register):
  blx r4, blx r5, blx r6 — function pointers, likely memset/memcpy variants

NOT called (inlined or absent):
  fun_linear_kalman, f_cgm_trend, f_rsq, fit_simple_regression,
  solve_linear, smooth1q_err16, f_trimmed_mean, calcPercentile,
  cal_threshold, err1_TD_var_update, err1_TD_trio_update, f_check_cgm_trend
```

**CONFIRMED:** All error-detection helpers are called from within `check_error`:
```
From check_error (0x66688–0x6c5fe):
  cal_threshold (2×)          — error threshold calculation
  err1_TD_trio_update (7×)    — err1 trio state updates
  err1_TD_var_update (2×)     — err1 variance tracking
  f_check_cgm_trend (3×)     — CGM trend evaluation
  f_rsq (1×)                  — R-squared for err16
  f_trimmed_mean (4×)        — robust statistics for err2/err16
  fit_simple_regression (2×)  — linear regression for err16
  fun_comp_decimals (12×)     — threshold comparisons
  math_ceil (3×)              — ceiling for seq calculations
  math_mean (2×)              — averages
  math_min (1×)               — minimum tracking
  math_round (5×)             — rounding
  math_std (1×)               — standard deviation for err4
  smooth1q_err16 (2×)         — Hann window smoothing

Note: solve_linear and apply_simple_smooth are NOT directly called from check_error —
they are called from within fit_simple_regression and smooth1q_err16 respectively.
f_cgm_trend is called from f_check_cgm_trend (not directly from check_error).
```

The opcal1 standalone `fun_linear_kalman` (583 instructions) is useful as a **reference** for understanding the algorithm structure, but the actual opcal4 Kalman implementation must be extracted from the inlined code in `air1_opcal4_algorithm`. Use the oracle (`debug.out_rescale`, `debug.state_init_kalman`) to verify.

### Savitzky-Golay Smoothing (smooth_sg — 111 instructions)
Weighted convolution with 7 coefficients from `w_sg_x100[7] = {80,130,90,80,110,90,80}`.
Small enough that LLM transpilation should be near-perfect on first attempt.

### smooth1q_err16 (162 instructions)
Uses **Hann window + Fourier decomposition** for error detection smoothing:
- Generates Hann window: `w[k] = 2 - 2*cos(2πk/N)` for k = 0..2N-1
- Applies sincos() for Fourier coefficients
- Constants: π, -2π, 2π visible in literal pool

### regress_cal (462 instructions)
**IRLS (Iteratively Reweighted Least Squares)** regression.
Ghidra local variables: `x[60]`, `y[60]`, `X[60][2]`, `w[60]`, `XtX[2][2]`, `Xty[2]`, `r[60]`, `abs_r[60]`, `xtwx[2][2]`, `xtwy[2]`, `gauss_var`.
Uses `solve_linear` for the 2×2 system and `fit_simple_regression` for initial estimate.

### fit_simple_regression (84 instructions)
Simple linear regression with NaN-awareness. Skips NaN input pairs.
Two passes:
1. Compute means of x and y (skipping NaN pairs)
2. Compute slope = Σ(yi-ȳ)(xi-x̄) / Σ(yi-ȳ)² and intercept = x̄ - slope×ȳ

### check_error (8008 instructions — THE BIG ONE)
One massive function containing ALL error detection. Produces error bits:
```
errcode = err1 | err2 | err4 | err8 | err16 | err32 | err128
```
Each error is a separate bit:
- **err1 (bit 0):** Contact/noise error — uses `cal_threshold`, `err1_TD_var_update`, `err1_TD_trio_update`
- **err2 (bit 1):** Rate-of-change error — 575-element delay buffers, uses `f_trimmed_mean`
- **err4 (bit 2):** Signal quality — minimum tracking, range analysis
- **err8 (bit 3):** Boundary check — simplest error detector
- **err16 (bit 4):** Sensor drift/degradation — most complex after err1, uses `f_cgm_trend`, `f_check_cgm_trend`, `smooth1q_err16`, `apply_simple_smooth`, `f_rsq`, `fit_simple_regression`, `solve_linear`, maintains 865-element history
- **err32 (bit 5):** BLE data gap — timing-based
- **err128 (bit 7):** Noise/spike revision

Strategy: Split logically by error code. Each has separate debug fields. Implement one error detector at a time.

---

## 11. Verification Oracle Rules

### Tolerance Specifications
| Field Type | Tolerance | Rationale |
|-----------|-----------|-----------|
| Integer fields (error codes, flags, seq numbers, stage) | **Exact match (zero tolerance)** | A 1-bit error code difference means the difference between delivering insulin or not |
| Boolean/uint8_t fields | **Exact match** | Flags must match exactly |
| Floating-point on same ARM target (softfp, VFPv3-d16) | **Bit-exact** | Same FPU, same operations = identical bits |
| Floating-point cross-platform (Python verification) | **Relative tolerance 1e-10** | Different FP implementations may differ in last ULP |

### Why Exact Error Code Match is Non-Negotiable
Consider: glucose value at 69.5 mg/dL (near hypoglycemia threshold). If our implementation computes 69.4 instead of 69.6, and this triggers `err8` (boundary check) where the reference doesn't, then:
- Reference: glucose=69.6, errcode=0 → insulin delivered
- Ours: glucose=69.4, errcode=8 → **insulin WITHHELD** → hyperglycemia

The reverse (we don't trigger an error that should trigger) is even more dangerous.

### How to Use the Oracle
1. Run the reference `libCALCULATION.so` with known inputs on ARM
2. Capture the raw bytes of `debug_t` (1579 bytes)
3. Parse field-by-field using `DebugData4Obj.java` byte layout
4. Run our reimplementation with identical inputs
5. Compare every field
6. Any mismatch = bug in our code (never in the reference)

---

## 12. File Locations

### Source of Truth Files
| File | Path | Purpose |
|------|------|---------|
| Struct definitions | `/Users/erik/github.com/j-kaltes/Juggluco/Common/src/main/cpp/air/air.hpp` | ALL struct definitions with defaults |
| Algorithm call site | `/Users/erik/github.com/j-kaltes/Juggluco/Common/src/main/cpp/air/java.cpp` | How Juggluco calls the algorithm |
| BLE protocol | `/Users/erik/github.com/j-kaltes/Juggluco/Common/src/dex/java/tk/glucodata/AirGattCallback.java` | Complete BLE communication flow |
| Debug struct layout | `vendor/decompiled/sources/com/isens/airsdk/module/type/DebugData4Obj.java` | Byte-level layout of debug_t (1579 bytes) |
| Proprietary library | `vendor/native/lib/armeabi-v7a/libCALCULATION.so` | The reference implementation |

### Generated Analysis Files
| File | Path | Purpose |
|------|------|---------|
| Ghidra decompiled C | `vendor/decompiled_c/all_functions.c` | 8735 lines, partial decompilation (from original Ghidra analysis) |
| ARM disassembly | `reference/disasm/*.asm` | Complete disassembly of key functions |
| Implementation plan | `docs/plans/2026-03-06-caresens-air-calibration-cleanroom.md` | 31-task implementation plan |
| This document | `docs/reference/caresens-air-knowledge-base.md` | Complete reference |

### Disassembly Files Detail
| File | Function | Instructions |
|------|----------|-------------|
| `fun_linear_kalman.asm` | Kalman filter (opcal1) | 583 |
| `smooth_sg_opcal4.asm` | S-G smoothing | 111 |
| `regress_cal_opcal4.asm` | IRLS regression | 462 |
| `f_cgm_trend_opcal4.asm` | CGM trend analysis | 636 |
| `check_error.asm` | ALL error detection | 8008 |
| `solve_linear.asm` | 2×2 system solver | 140 |
| `apply_simple_smooth.asm` | Smoothing helper | 117 |
| `smooth1q_err16.asm` | Hann window + Fourier | 162 |
| `fit_simple_regression.asm` | Simple linear regression | 84 |
| `f_rsq.asm` | R-squared | 673 |
| `cal_average_without_min_max.asm` | Trimmed average | 27 |
| `all_opcal4_functions.asm` | Everything (0x616e8-0x6ef80) | ~19800 |

---

## 13. LLM-Assisted Transpilation Workflow

For each function that needs ARM→C conversion:

### Input to LLM
1. **ARM disassembly** from `reference/disasm/`
2. **Function signature** (from llvm-nm and Ghidra prologue)
3. **Local variable names** (from Ghidra's stack frame analysis — even truncated functions show variable declarations)
4. **Struct definitions** (from `air.hpp`)
5. **Domain knowledge** (what the function SHOULD do — Kalman filter, S-G smoothing, etc.)
6. **ARM Thumb-2 instruction reference** (this document section 9)

### Process
1. LLM generates candidate C implementation
2. Cross-compile for ARM with same float ABI: `-mfloat-abi=softfp -mfpu=vfpv3-d16`
3. Run with known inputs alongside reference library
4. Compare debug struct field-by-field
5. If mismatch: feed the specific failing fields + disassembly region to LLM for correction
6. Iterate until bit-exact match

### Feedback Loop Speed
- Compilation: <1 second
- Running on ARM (via adb or QEMU): microseconds per function call
- Full 4320-reading session: under 1 minute even at 50× slowdown
- Iteration cycle: seconds, not minutes

---

## 14. Reverse Engineering Breakthroughs

### Breakthrough 1: Ghidra Truncation Solved
**Problem:** Ghidra truncated complex functions after `__aeabi_memclr8()`.
**Root cause:** 0x10000 base address offset causing failed cross-references.
**Solution:** `llvm-objdump --triple=thumbv7-linux-gnueabi` with correct ELF VMA addresses.

### Breakthrough 2: check_error Found
**Problem:** 24KB gap in Ghidra's function list.
**Solution:** `llvm-nm` revealed `check_error @ 0x66688` — 8008 instructions.

### Breakthrough 3: Complete Symbol Table
**Problem:** Assumed library was stripped.
**Solution:** Library has debug_info. `llvm-nm` reveals ALL function names, even `static` ones.

### Key Tool Commands
```bash
# Get complete symbol table
LLVM_NM=$(xcrun --find llvm-nm)
$LLVM_NM vendor/native/lib/armeabi-v7a/libCALCULATION.so | sort

# Disassemble specific function (use ELF VMA addresses, NOT Ghidra addresses)
OBJDUMP=$(xcrun --find llvm-objdump)
$OBJDUMP -d --triple=thumbv7-linux-gnueabi \
    --start-address=0x6ccbc --stop-address=0x6cde8 \
    vendor/native/lib/armeabi-v7a/libCALCULATION.so

# Convert Ghidra address to ELF VMA
# ELF_VMA = GHIDRA_ADDR - 0x10000
```

---

## 15. Risk Register

| Risk | Impact | Mitigation |
|------|--------|------------|
| LLM misinterprets ARM assembly | Wrong C code | Oracle catches instantly; iterate |
| Kalman Q matrix non-standard | Wrong glucose values | Full disassembly available; oracle verification |
| lot_type constants unknown | Wrong behavior for some sensors | Extract from disassembly; test all 3 lot_types |
| check_error too complex for single LLM pass | Slow progress | Split by error code; each has its own debug fields |
| Float precision across platforms | False test failures | Same ARM float ABI on target; QEMU for emulation |
| Safety-critical insulin dosing | Patient harm | **NEVER deploy without 100% oracle match on real sensor data** |
| Sequential state dependency | Can't test readings in isolation | Generate complete 15-day test sessions, run sequentially |

---

## 16. Glossary

| Term | Meaning |
|------|---------|
| ADC | Analog-to-Digital Converter — raw sensor reading |
| CGM | Continuous Glucose Monitor |
| ISF | Interstitial Fluid — what the sensor actually measures |
| opcal4 | The 4th version of the calibration algorithm |
| lot_type | Sensor manufacturing lot category (0, 1, or 2) |
| eapp | Applied potential — determines lot_type |
| vref | Reference voltage — used in ADC→current conversion |
| BLE | Bluetooth Low Energy |
| S-G | Savitzky-Golay (smoothing filter) |
| IRLS | Iteratively Reweighted Least Squares |
| errcode | Bitmask: bit0=err1, bit1=err2, bit2=err4, bit3=err8, bit4=err16, bit5=err32, bit7=err128 |
| oracle | The debug_t struct from the reference library — our ground truth |
| Juggluco | Open-source Android app by Jaap Korthals Altes that wraps libCALCULATION.so |
| xDrip+ | Open-source CGM receiver app (cannot bundle proprietary .so) |
| AndroidAPS | Open-source artificial pancreas system |
