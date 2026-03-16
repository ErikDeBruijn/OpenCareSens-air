# Java Port Analysis - OpenCareSens-Air Calibration Algorithm

## Architecture Overview

The C implementation is a 14-step calibration pipeline that converts raw ADC readings from a CareSens Air CGM sensor into calibrated glucose values (mg/dL). It processes 30 ADC samples per reading, producing one glucose value plus error codes, trend rate, and smoothed history.

## Source Modules to Port (4 modules, ~2700 lines of C)

### 1. `math_utils.c` (397 lines, 28 functions)
Pure math/statistics. No state. Easiest to port and test independently.
- Statistical: mean, std, median, percentile, trimmed mean, min, max
- Signal: eliminate_peak, delete_element, simple_smooth
- Math: round, ceil, round_digits, compare_decimals
- Regression: fit_simple_regression, rsq, solve_linear
- Memory: copy_mem, cal_average_without_min_max

### 2. `signal_processing.c` (663 lines, 11 functions)
Signal processing pipeline with the most complex function being `compute_tran_inA_1min` (LOESS pipeline).
- LOESS pipeline: Hampel filter -> IRLS LOESS -> running median -> FIR -> trimmed mean
- Savitzky-Golay smoothing (7 weights)
- Weighted least-squares recalibration
- Boundary check (parallelogram)
- DFT-based spectral smoothing (err16)
- Threshold tracking
- Error detection helpers (TD trio, TD var)

### 3. `check_error.c` (578 lines, 1 large function)
Error detection with 7 independent error codes (bitmask).
- err1: contact/noise
- err2: rate-of-change delay
- err4: signal quality
- err8: warmup/range
- err16: sensor drift (largest, 3000+ state fields)
- err32: timing gap
- err128: CGM noise

### 4. `calibration.c` (main, ~450 lines in algorithm function)
14-step pipeline orchestrator. Calls all other modules.
- ADC to current conversion
- LOESS pipeline
- Baseline correction
- IIR filter
- Temperature correction (lot-type dependent)
- Drift correction (lot1 only)
- Initial glucose estimate
- Stage computation (warmup vs steady-state)
- Bias correction (Holt-Kalman with fixed gains)
- Savitzky-Golay smoothing
- Error detection
- Trendrate computation
- Output assembly

## Data Structures (6 structs)

| Struct | C Size | Purpose |
|--------|--------|---------|
| `cgm_input_t` | 74 B | Per-reading input (seq, time, 30 ADC, temp) |
| `output_t` | 155 B | Per-reading output (glucose, trend, errors, smoothed) |
| `device_info_t` | 446 B | Factory calibration parameters |
| `arguments_t` | 117,312 B | Persistent state machine (massive) |
| `debug_t` | 1,579 B | Intermediate values for verification |
| `cal_log_t` | 104 B | Calibration history entry (up to 50) |
| `cal_list_t` | 751 B | User calibration input |

## Key Porting Considerations

### 1. Floating Point Precision
The C code uses `double` throughout. Java `double` is IEEE 754 identical. Key concern:
- NaN handling differs: C uses `isnan()`, Java uses `Double.isNaN()`
- Java has no `NAN` macro, use `Double.NaN`
- `math.h` functions map to `java.lang.Math` equivalents

### 2. Integer Types
- C `uint8_t` -> Java `int` (no unsigned byte issues, just mask with 0xFF if needed)
- C `uint16_t` -> Java `int` (Java char is 16-bit unsigned but int is cleaner)
- C `uint32_t` -> Java `long` (to avoid sign issues) or `int` (if values stay < 2^31)
- C `int8_t` -> Java `byte` or `int`
- C `int64_t` -> Java `long`

### 3. Array Handling
- C arrays are 0-indexed, same as Java
- C passes arrays by pointer with separate length; Java arrays know their length
- Large arrays in arguments_t: just use Java arrays

### 4. Struct Packing
Not relevant for Java port - no binary compatibility needed. Use plain classes.

### 5. Pointer Arithmetic
C code passes pointers into arrays (e.g., `&arr[offset]`). In Java, pass array + offset, or use array copy/views.

### 6. LOESS Kernel Table
101 KB of precomputed coefficients in `loess_kernel.h`. Port as static final arrays in a constants class.

### 7. Dead Code
The C code has commented-out/dead code (old gain tables, etc.). Skip these entirely.

## Java Package Design

```
com.opencaresens.air/
  CalibrationAlgorithm.java    # Main entry point (calibration.c)
  CheckError.java              # Error detection (check_error.c)
  SignalProcessing.java        # Signal processing (signal_processing.c)
  MathUtils.java               # Math utilities (math_utils.c)
  LoessKernel.java             # Precomputed LOESS coefficients
  model/
    CgmInput.java              # Input data
    AlgorithmOutput.java       # Output data
    DeviceInfo.java            # Factory parameters
    AlgorithmState.java        # Persistent state (arguments_t)
    DebugOutput.java           # Debug/verification output
    CalibrationLog.java        # Calibration history entry
    CalibrationList.java       # User calibration input
```

## Verification Strategy

Oracle binary data (5 lots x 400 readings) provides field-by-field verification.
The Java port should:
1. Read the same oracle binary files
2. Run the same 2000 readings
3. Compare every output field at machine epsilon precision
4. This proves the Java code is functionally identical to the C code

## Key Constants

- phi = exp(-0.5) = 0.60653065971263342
- Holt gains: K = [0.6729, 1.761, 0.1279]
- Temp coefficients: lot1=0.1584 (ref 37.0), lot2=0.0328 (ref 34.0854)
- Drift poly: A=-5.15e-12, B=5.99e-09, C=5.29e-05, D=0.9147
- ADC divisor: 40950.0
- Ycept: lot1=0.7, lot2=0.243
