# OpenCareSens-Air Java Library: Integration Analysis

## 1. Library Packaging

### Recommended: Pure Java library (JAR), published via JitPack

The library should remain a **pure Java library** (no Android dependencies). This is the
strongest design choice for the following reasons:

- The calibration algorithm is pure math — no Android APIs needed.
- A JAR works in Android (AAR), desktop Java, and server-side environments.
- xDrip+ already demonstrates this pattern with `libkeks` and `libglupro`, which are
  separate Gradle modules included via `settings.gradle`.
- JitPack can publish the JAR directly from the GitHub repo, so any Android app can add
  a single Gradle dependency line.

**Build configuration** (current `build.gradle` is already correct):
```groovy
plugins {
    id 'java-library'
}
group = 'com.opencaresens'
version = '0.1.0'
```

For JitPack distribution, add a `jitpack.yml` or just ensure the Gradle wrapper is committed.
Consumers add:
```groovy
repositories { maven { url 'https://jitpack.io' } }
dependencies { implementation 'com.github.erikdebruijn:OpenCareSens-air:v0.1.0' }
```

### Why not an AAR?

An AAR would force an Android SDK dependency for no reason. The algorithm has zero Android
imports. If a BLE transport layer is added later (like `libglupro` does for GluPro CGMs),
that should be a **separate** module (e.g., `opencaresens-air-ble`) that depends on this
core library.

## 2. Public API Design

The library needs a single, stateless entry point that Android apps call once per CGM reading.
The current internal structure (`CalibrationAlgorithm`, `SignalProcessing`, `CheckError`,
`MathUtils`, `LoessKernel`) should remain internal — only the facade and data classes are public.

### Proposed public API

```java
package com.opencaresens.air;

/**
 * Main entry point for CareSens Air CGM calibration.
 *
 * Usage:
 *   CareSensCalibrator calibrator = new CareSensCalibrator();
 *   calibrator.initialize(deviceInfo);
 *
 *   // Called once per CGM reading (~every minute):
 *   CalibrationResult result = calibrator.processReading(rawReading);
 */
public final class CareSensCalibrator {

    /**
     * Initialize with factory calibration parameters from BLE advertisement.
     * Must be called once before processReading().
     */
    public void initialize(SensorConfig config);

    /**
     * Process one raw CGM reading through the full calibration pipeline.
     * Returns the calibrated glucose value, trend rate, error flags, and
     * smoothed historical values.
     *
     * Thread-safe: holds internal state, but a single instance should be
     * used per sensor session (not shared across sensors).
     */
    public CalibrationResult processReading(RawReading reading);

    /**
     * Restore state from a previous session (e.g., after app restart).
     * The byte array is the serialized AlgorithmState.
     */
    public void restoreState(byte[] serializedState);

    /**
     * Serialize current state for persistence.
     */
    public byte[] saveState();

    /**
     * Reset all state (new sensor session).
     */
    public void reset();
}
```

### Public data classes

```java
package com.opencaresens.air;

/** Factory calibration parameters parsed from BLE advertisement data. */
public final class SensorConfig {
    // Wraps the current DeviceInfo fields, but with a cleaner name.
    // Constructed from raw BLE advertisement bytes via SensorConfig.fromAdvertisement(byte[]).
    public static SensorConfig fromAdvertisement(byte[] bleData);
    public static SensorConfig fromFields(float ycept, float slope100, float eapp, ...);

    public float getEapp();
    public float getSlope();
    public float getYcept();
    public String getLot();
    public String getSensorId();
    // ... other getters
}

/** One raw sensor reading to be calibrated. */
public final class RawReading {
    public RawReading(int sequenceNumber, long timestampMs, int[] adcValues, double temperature);
}

/** Result of calibrating one reading. */
public final class CalibrationResult {
    public double getGlucoseMgdl();
    public double getTrendRateMgdlPerMin();
    public int getErrorCode();           // bitmask: 0 = no error
    public boolean isValid();            // errcode == 0 && glucose in range
    public int getStage();               // warmup stage
    public SmoothedValue[] getSmoothedHistory();  // 6 smoothed historical values

    /** Convert mg/dL to mmol/L. */
    public double getGlucoseMmol();
}

/** One smoothed historical glucose value. */
public final class SmoothedValue {
    public int getSequenceNumber();
    public double getGlucoseMgdl();
    public boolean isFixed();
}
```

### What stays internal (package-private)

- `CalibrationAlgorithm` — the 14-step pipeline (static utility methods)
- `SignalProcessing` — Hampel filter, SG smoothing, IIR, etc.
- `CheckError` — error flag computation
- `MathUtils` — math primitives (percentile, linear solve, etc.)
- `LoessKernel` — LOESS regression
- `model.AlgorithmState` — the massive 117KB state struct
- `model.AlgorithmOutput` — internal output struct
- `model.CgmInput` — internal input struct

## 3. xDrip+ Integration Points

### How xDrip+ handles factory-calibrated CGMs today

xDrip+ has two calibration paths:

1. **PluggableCalibration system** (`calibrations/CalibrationAbstract.java`): For sensors
   that provide raw data and need xDrip+ to calibrate (Dexcom G4/G5 raw mode, Libre raw).
   These use slope+intercept linear calibration with finger-stick blood glucose references.

2. **Native/factory calibration** (`bgReadingInsertFromGluPro`, `bgReadingInsertMedtrum`):
   For sensors that provide already-calibrated glucose values. The sensor's own algorithm
   runs the calibration, and xDrip+ just ingests the final glucose value. This is the path
   used by GluPro, Medtrum, Dexcom G6/G7, and followers.

**CareSens Air falls into category 2** — the library runs the full calibration algorithm
and produces a final glucose value. xDrip+ should not attempt to re-calibrate it.

### Specific integration locations in xDrip+

To add CareSens Air support, these xDrip+ files would need changes (but we do NOT modify
them — this is reference for anyone building the integration):

1. **`DexCollectionType.java`** — Add `CareSensAir("CareSensAir")` to the enum and add it
   to `alwaysNativeCal`, `newerCollector`, `usesBluetooth`, and `usesBluetoothScan`.

2. **`cgm/caresensair/CareSensAirService.java`** (new) — Foreground service modeled after
   `GluProService`. This would:
   - Scan for CareSens Air BLE advertisements
   - Parse the advertisement into `SensorConfig`
   - Create a `CareSensCalibrator` instance
   - On each BLE notification with raw ADC data, call `processReading()`
   - Insert the result via `BgReading.bgReadingInsertFromGluPro()` (or a new
     `bgReadingInsertFromCareSensAir()` method)

3. **`BgReading.java`** — Optionally add a `bgReadingInsertFromCareSensAir()` method,
   or reuse `bgReadingInsertFromGluPro()` since the pattern is identical (factory-calibrated
   glucose + timestamp).

4. **`NativeCalibrationPipe.java`** — Add `CareSensAir.addCalibration()` if the sensor
   supports in-vivo recalibration via BLE write.

5. **`settings.gradle`** — Add the library as either a Gradle module or a JitPack dependency.

### Data flow

```
BLE Advertisement -> SensorConfig.fromAdvertisement(bytes)
                                     |
                                     v
                          CareSensCalibrator.initialize(config)

BLE Notification (raw ADC) -> RawReading(seq, timestamp, adc[], temp)
                                     |
                                     v
                          CareSensCalibrator.processReading(reading)
                                     |
                                     v
                              CalibrationResult
                                     |
                                     v
                   BgReading.bgReadingInsertFromGluPro(
                       result.getGlucoseMgdl(),
                       timestamp,
                       "CareSensAir"
                   )
```

## 4. Keeping the Library Generic (Not xDrip-Specific)

### Design principles

1. **Zero Android imports** in the core library. No `Context`, no `SharedPreferences`,
   no `BluetoothDevice`. The BLE transport is the host app's responsibility.

2. **No persistence assumptions.** The library provides `saveState()` / `restoreState()`
   as opaque byte arrays. The host app decides where to store them (SharedPreferences,
   Room DB, files — whatever).

3. **No logging framework dependency.** If debug logging is needed, accept an optional
   `Logger` interface (like libglupro's `ILog`):
   ```java
   public interface CalibrationLogger {
       void debug(String tag, String message);
       void error(String tag, String message);
   }
   calibrator.setLogger(myLogger);  // optional
   ```

4. **No threading assumptions.** The `processReading()` call is synchronous and fast
   (sub-millisecond). The host app manages its own threading.

5. **Immutable public data classes.** `SensorConfig`, `RawReading`, `CalibrationResult`,
   and `SmoothedValue` should be immutable (final fields, no setters). This prevents
   accidental mutation bugs in host apps.

### How other apps would integrate

**Jugluco** (popular Libre CGM app with CareSens interest):
- Jugluco handles its own BLE connection and already parses sensor advertisements.
- It would add the library as a dependency, create a `CareSensCalibrator`, and call
  `processReading()` in its existing data pipeline.
- It persists state using its own SQLite database via `saveState()` / `restoreState()`.

**AndroidAPS** (closed-loop insulin pump controller):
- AAPS receives glucose values via xDrip+ broadcast intents or Nightscout.
- If it wanted direct CareSens Air support, the same pattern applies: add the library,
  handle BLE, call the calibrator.

**Any custom app**:
```java
// One-time setup
SensorConfig config = SensorConfig.fromAdvertisement(bleAdvBytes);
CareSensCalibrator cal = new CareSensCalibrator();
cal.initialize(config);

// On each BLE notification (every ~60 seconds)
RawReading reading = new RawReading(seq, System.currentTimeMillis(), adcValues, temp);
CalibrationResult result = cal.processReading(reading);

if (result.isValid()) {
    double glucose = result.getGlucoseMgdl();
    double trend = result.getTrendRateMgdlPerMin();
    // display, store, broadcast — app's choice
}
```

## 5. Migration Path from Current Code

The current codebase has the algorithm logic ready in:
- `CalibrationAlgorithm.java` — the 14-step pipeline
- `SignalProcessing.java` — signal processing
- `CheckError.java` — error detection
- `MathUtils.java` / `LoessKernel.java` — math utilities
- `model/` — data classes (AlgorithmState, AlgorithmOutput, CgmInput, DeviceInfo, etc.)

Steps to create the public API:

1. **Add `CareSensCalibrator` class** as the public facade. It wraps `AlgorithmState` +
   `DeviceInfo` internally and delegates to `CalibrationAlgorithm`.

2. **Add public data classes** (`SensorConfig`, `RawReading`, `CalibrationResult`,
   `SmoothedValue`) that translate between the clean public API and the internal C-like
   structs.

3. **Make internal classes package-private.** Remove `public` from `CalibrationAlgorithm`,
   `SignalProcessing`, `CheckError`, etc.

4. **Add state serialization.** Implement `saveState()` / `restoreState()` using Java
   serialization or a custom binary format (matching the C struct layout for
   interoperability with the C reference implementation).

5. **Add `SensorConfig.fromAdvertisement(byte[])`** to parse raw BLE advertisement bytes
   into the factory calibration parameters.

6. **Publish v0.1.0** on JitPack once the oracle verification tests pass at full accuracy.

## 6. xDrip+ Library Module Patterns (Reference)

xDrip+ includes two library modules that demonstrate how external libraries integrate:

### libkeks (Dexcom G7 authentication)
- **Package:** `jamorham.keks`
- **Interface:** Implements `IPluginDA` (xDrip's plugin interface for BLE data exchange)
- **Build:** Android library module (`com.android.library`), depends on BouncyCastle
- **Coupling:** Tightly coupled to xDrip's plugin system via `IPluginDA`

### libglupro (Generic CGM BLE profile)
- **Package:** `lwld.glucose.profile`
- **Interface:** Callback-based (`Listener` interface with `onData(Map<DataKey, String>)`)
- **Build:** Android library module, depends on Nordic BLE library
- **Coupling:** Loosely coupled — communicates via a `Map<DataKey, String>` data dictionary
- **Best model for us:** libglupro's approach of a standalone library with a callback
  interface is closest to what we need, except our library is even simpler because it
  does not handle BLE — only calibration math.

### Key difference for OpenCareSens-Air
Our library is **simpler than both** — it has no BLE, no Android context, no plugin
interface. It is pure computation: input raw data, output calibrated glucose. This makes
it the easiest possible integration for any host app.
