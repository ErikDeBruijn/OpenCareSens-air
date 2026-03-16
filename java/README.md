# OpenCareSens-Air Java Calibration Library

Pure Java port of the CareSens Air CGM calibration algorithm. Converts raw ADC sensor readings into calibrated glucose values (mg/dL) with trend rate computation. No Android dependencies -- works anywhere Java runs.

**Verification:** 2000 oracle readings tested across 5 sensor lots (normal, extreme, low-eapp, hypo, hyper profiles). All safety-critical outputs (glucose, error codes, stage, trend rate) match 100% against the proprietary i-SENS library. Debug intermediates match 99.995% (263987/264000 fields).

**Medical context:** This library produces glucose values that people with diabetes use to dose insulin. Incorrect values can be dangerous. Do not modify the calibration pipeline without re-running full oracle verification.

## Quick start

```java
// 1. Build config from BLE advertisement data (one-time per sensor)
SensorConfig config = new SensorConfig.Builder()
    .eapp(0.10067f)
    .vref(1.2f)
    .slope100(2.5f)
    .basicWarmup(5)
    .err345Seq2(5)
    .wSgX100(new int[]{-3, 12, 17, 12, 17, 12, -3})
    .sensorStartTime(sensorStartUnixSeconds)
    .build();

// 2. Create calibrator
CareSensCalibrator calibrator = new CareSensCalibrator(config);

// 3. Process each reading as it arrives (~every 5 minutes)
CalibrationResult result = calibrator.processReading(
    sequenceNumber,       // starts at 1, increments each reading
    timestampSeconds,     // Unix epoch seconds
    adcSamples,           // int[30] raw ADC values from sensor
    temperature           // skin temperature in Celsius
);

if (result.isValid()) {
    double glucose = result.getGlucoseMgdl();    // or getGlucoseMmol()
    double trend = result.getTrendRateMgdlPerMin();
    int stage = result.getStage();                // 0 = warmup, 1 = steady state
}
```

## API reference

### CareSensCalibrator

The main entry point. One instance per sensor session.

| Method | Description |
|--------|-------------|
| `CareSensCalibrator(SensorConfig)` | Create a new calibrator from factory calibration parameters |
| `processReading(int seq, long timestamp, int[] adc, double temp)` | Calibrate one raw reading. Call in order, once per reading |
| `isWarmedUp()` | Whether the sensor has passed its warmup period |
| `getReadingsProcessed()` | Number of readings processed so far |
| `saveState()` | Serialize internal state to `byte[]` for persistence |
| `restoreState(byte[], SensorConfig)` | Static. Reconstruct a calibrator from saved state |

Not thread-safe. Use external synchronization or one instance per thread.

### SensorConfig

Immutable container for factory calibration parameters parsed from BLE advertisement data. Built with `SensorConfig.Builder`.

Required fields: `vref`, `slope100`. All others have defaults. See the Builder's javadoc for the full field list.

### CalibrationResult

Immutable result from `processReading()`.

| Method | Description |
|--------|-------------|
| `getGlucoseMgdl()` | Calibrated glucose in mg/dL |
| `getGlucoseMmol()` | Calibrated glucose in mmol/L |
| `getTrendRateMgdlPerMin()` | Rate of change. 100.0 = not yet available |
| `isTrendAvailable()` | Whether trend rate has been computed (needs ~12 readings) |
| `getErrorCode()` | Error bitmask. 0 = no error |
| `hasError()` | True if any error flag is set |
| `isValid()` | No errors and glucose within 40-500 mg/dL |
| `getStage()` | 0 = warmup, 1 = steady state |
| `getSmoothedGlucose()` | 6 Savitzky-Golay smoothed historical values (mg/dL) |

## State persistence

The calibrator maintains internal state across readings (Kalman filter, Holt smoother, error history). Persist this across app restarts:

```java
// Save (e.g., to SharedPreferences)
byte[] state = calibrator.saveState();
prefs.edit().putString("cal_state", Base64.encodeToString(state, 0)).apply();

// Restore
byte[] state = Base64.decode(prefs.getString("cal_state", ""), 0);
CareSensCalibrator calibrator = CareSensCalibrator.restoreState(state, config);
```

The `SensorConfig` must match the sensor that produced the saved state. Mixing configs and state from different sensors will produce incorrect glucose values.

## Building

Requires JDK 11+. No other dependencies (JUnit 5 is downloaded automatically for tests).

```bash
cd java
./build.sh          # compile + run all tests
./build.sh compile  # compile only
./build.sh test     # run tests only
```

The build script auto-detects your JDK and downloads the JUnit 5 standalone runner.

## Android integration

The library is a pure Java JAR with zero Android dependencies.

### Option 1: Source inclusion

Copy `java/src/main/java/com/opencaresens/air/` into your Android project's `java/` source directory. No build configuration needed -- it's all standard Java with zero dependencies.

### Option 2: JitPack (once a release is tagged)

```groovy
repositories {
    maven { url 'https://jitpack.io' }
}
dependencies {
    implementation 'com.github.erikdebruijn:OpenCareSens-air:v0.1.0'
}
```

### Integration pattern

The library handles calibration only -- not BLE. Your app is responsible for:

1. Scanning for CareSens Air BLE advertisements
2. Parsing advertisement bytes into `SensorConfig` fields
3. Receiving raw ADC data via BLE notifications
4. Calling `processReading()` with each raw reading
5. Persisting state via `saveState()` / `restoreState()`
6. Displaying or forwarding the calibrated glucose value

This matches how xDrip+ integrates factory-calibrated sensors (GluPro, Medtrum): the library produces a final glucose value, the app inserts it via `BgReading`.

## Architecture

```
com.opencaresens.air (public API)
  CareSensCalibrator      -- facade, the only class most integrators touch
  SensorConfig            -- factory calibration parameters (Builder pattern)
  CalibrationResult       -- immutable output per reading

com.opencaresens.air (internal, package-private)
  CalibrationAlgorithm    -- 14-step calibration pipeline
  SignalProcessing        -- Hampel filter, SG smoothing, IIR, LOESS, drift correction
  CheckError              -- error flag computation (err1/2/4/8/16/32)
  MathUtils               -- math primitives (percentile, median, linear solve)
  LoessKernel             -- LOESS regression kernel

com.opencaresens.air.model (internal structs)
  AlgorithmState          -- persistent state across readings
  DeviceInfo              -- sensor factory calibration data
  AlgorithmOutput         -- raw pipeline output
  CgmInput                -- raw pipeline input
  CalibrationList         -- calibration history
```

The pipeline per reading:

```
raw ADC -> eliminate_peak -> IIR filter -> drift correction -> LOESS resampling
-> Savitzky-Golay smoothing -> IRLS regression -> 3-state Kalman filter
-> Holt exponential smoothing -> error detection -> calibrated glucose (mg/dL)
```

## License

GPL-2.0 -- see [LICENSE](../LICENSE).
