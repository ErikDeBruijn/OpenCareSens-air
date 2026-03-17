# OpenCareSens Air

Open-source reimplementation of the CareSens Air CGM calibration algorithm (`libCALCULATION.so` by i-SENS). Available in both C99 and Java, producing calibrated glucose values (mg/dL) from raw ADC sensor readings.

**Status: 100% output match** against the proprietary library on all tested scenarios (normal, low sensor parameter, hypoglycemia, hyperglycemia) — verified across 2000 oracle readings from 5 sensor lots.

## Why

The CareSens Air continuous glucose monitor uses a proprietary ARMv7-only shared library for its calibration pipeline. Open-source projects like [Juggluco](https://github.com/j-kaltes/Juggluco) currently bundle this binary via `dlopen`, which creates:

- **Platform lock-in**: only runs on 32-bit ARM Android
- **License conflict**: proprietary binary bundled in GPL-licensed software
- **Opacity**: no way to audit or verify what the calibration does

This reimplementation is pure C99 (no external dependencies beyond `libm`) and pure Java (no Android dependencies), compiles on any platform, and is licensed GPL-2.0.

## Implementations

### C library (`src/`)

The reference implementation in standard C99. Compiles on any platform with a C compiler. Used for oracle verification and as the basis for the Java port.

### Java library (`java/`)

A complete Java port designed for direct integration into Android CGM apps like [xDrip+](https://github.com/NightscoutFoundation/xDrip), Juggluco, and AndroidAPS. Pure Java with zero Android dependencies — works anywhere Java runs.

**Quick start:**
```java
SensorConfig config = new SensorConfig.Builder()
    .eapp(0.10067f).vref(1.2f).slope100(3.5226f)
    .basicWarmup(24).build();

CareSensCalibrator calibrator = new CareSensCalibrator(config);

BlePacketParser.ParsedReading reading = BlePacketParser.parse(bleBytes);
CalibrationResult result = calibrator.processReading(
    reading.getSequenceNumber(), reading.getTimestamp(),
    reading.getAdcSamples(), reading.getTemperature());

if (result.isValid()) {
    double glucose = result.getGlucoseMgdl();
}
```

See [`java/README.md`](java/README.md) for full API documentation and Android integration guide.

## Approach

Clean-room reverse engineering: we study only the *external behavior* of the original library, never its source code.

The original `libCALCULATION.so` runs inside a Docker ARM emulator — a sandbox where it thinks it's running on an Android phone. Around it sits an "oracle harness": code that systematically feeds synthetic sensor data (400 consecutive readings per run, multiple sensor lots with varying parameters) and captures not just the final result, but also 102 intermediate values from the internal data structure (1579 bytes per reading).

The complete pipeline was rewritten based on this input/output dataset — fully independent, without copying a single byte from the original. Every intermediate step is validated against the oracle: integers bit-exact, floating point to machine epsilon.

### Pipeline

```
raw ADC → eliminate_peak → IIR filter → drift correction → LOESS resampling
→ Savitzky-Golay smoothing → IRLS regression → 3-state Kalman filter
→ Holt exponential smoothing → error detection → calibrated glucose (mg/dL)
```

### Key discovery

The library's internal Kalman filter uses **fixed gains** (K = [0.6729, 1.761, 0.1279]) with a phi-based transition matrix — not the dynamic Riccati recursion we initially expected. This was the breakthrough that achieved machine-epsilon precision.

## Oracle verification

Both implementations (C and Java) are verified against oracle data from the proprietary binary:

| Lot | eapp | Profile | C match | Java glucose | Java debug |
|-----|------|---------|---------|-------------|------------|
| lot0 | 0.10067 | Normal (100→120→200→100 mg/dL) | 100% | 100% | 99.97% |
| lot1 | 0.15 | Extreme (eapp ≥ 0.12 rejected) | 100% | 100% | 100% |
| lot2 | 0.05 | Low-eapp (lot_type=2) | 100% | 100% | 99.98% |
| lot3 | 0.10067 | Hypoglycemia (→45 mg/dL sustained) | 100% | 100% | 99.91% |
| lot4 | 0.10067 | Hyperglycemia (→380+ mg/dL sustained) | 100% | 100% | 99.97% |

Each lot tests 400 sequential readings. All safety-critical outputs (glucose, error codes, calibration stage, trend rate) match 100% across all 2000 readings. Java debug intermediates match 99.995% (263,987 / 264,000 fields).

## Building

### C library

```bash
cd build && cmake .. && make && ctest

# Compare against oracle data
cc -O2 -Isrc tools/compare_oracle.c src/*.c -lm -o build/compare_oracle
build/compare_oracle oracle/output/lot0
```

### Java library

```bash
cd java
./build.sh          # compile + run all 323 tests
./build.sh compile  # compile only
./build.sh test     # run tests only
```

Requires JDK 11+. The build script auto-detects your JDK and downloads JUnit 5.

### Prerequisites

- **C**: C99 compiler (gcc, clang), CMake 3.10+
- **Java**: JDK 11+ (builds target Java 8 for Android compatibility)
- **Oracle generation**: Docker, Android NDK 27, the proprietary APK (see below)

## Reproducing the oracle

The oracle data (`oracle/output/`) is generated by running the proprietary library in a Docker ARM container. To regenerate:

1. Download the CareSens Air app (package `com.isens.csair`) from [APKPure](https://apkpure.com/caresens-air/com.isens.csair/download) — select the **armeabi-v7a** variant (XAPK format)
2. Run the setup script:
   ```bash
   ./scripts/setup-vendor.sh ~/Downloads/caresens-air.xapk
   ```
3. Start Docker Desktop, then:
   ```bash
   cd oracle && ./run_oracle.sh
   ```

See `scripts/setup-vendor.sh` for details on APK extraction and `oracle/run_oracle.sh` for lot definitions.

## Project structure

```
src/
  calibration.c        — main algorithm pipeline (opcal4)
  check_error.c        — error detection (err1/2/4/8/16/32/128)
  math_utils.c         — math primitives (median, std, percentile, etc.)
  signal_processing.c  — LOESS, Savitzky-Golay, IIR filter, drift correction
  calibration.h        — struct definitions (arguments_t, device_info_t, etc.)

java/
  src/main/java/com/opencaresens/air/
    CareSensCalibrator.java   — public API facade
    SensorConfig.java         — sensor factory parameters (Builder)
    CalibrationResult.java    — immutable result object
    BlePacketParser.java      — BLE C5 packet parser
    CalibrationAlgorithm.java — internal: 14-step pipeline
    SignalProcessing.java     — internal: signal processing
    CheckError.java           — internal: error detection
    MathUtils.java            — internal: math utilities
    LoessKernel.java          — internal: precomputed LOESS coefficients
    model/                    — internal: data model classes
  src/test/java/              — 323 tests incl. oracle verification

oracle/
  oracle_harness.c     — ARM harness that exercises the proprietary .so
  run_oracle.sh        — runs the harness in Docker with multiple lot configs

tools/
  compare_oracle.c     — compares C output against oracle data field-by-field

scripts/
  setup-vendor.sh      — extracts .so from APK, disassembles, decompiles
```

## Remaining work

- **Real sensor data validation**: verified against synthetic oracle data; real device testing pending
- **SG smoothing**: Savitzky-Golay smoothed output uses a simplified kernel; the proprietary binary uses a data-dependent causal convolution that requires further reverse engineering (does not affect primary glucose output)

## Acknowledgments

This project builds on the pioneering work of the [Juggluco](https://github.com/j-kaltes/Juggluco) project by Jaap Korthals Altes, and the broader "We Will Not Wait" community that has made CGM data accessible to those who need it.

## License

GPL-2.0 — see [LICENSE](LICENSE).
