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

## 2. Public API (Implemented)

The public API consists of 4 classes. All internal implementation classes are package-private.

```java
// 1. Build config from sensor's BLE advertisement (one-time)
SensorConfig config = new SensorConfig.Builder()
    .eapp(0.10067f).vref(1.2f).slope100(3.5226f)
    .basicWarmup(24).err345Seq2(5)
    .wSgX100(new int[]{80, 130, 90, 80, 110, 90, 80})
    .build();

// 2. Create calibrator
CareSensCalibrator calibrator = new CareSensCalibrator(config);

// 3. On each BLE C5 notification (~every 5 minutes)
BlePacketParser.ParsedReading reading = BlePacketParser.parse(bleBytes);
CalibrationResult result = calibrator.processReading(
    reading.getSequenceNumber(), reading.getTimestamp(),
    reading.getAdcSamples(), reading.getTemperature());

if (result.isValid()) {
    double glucose = result.getGlucoseMgdl();
    double trend = result.getTrendRateMgdlPerMin();
}

// 4. State persistence
byte[] state = calibrator.saveState();
CareSensCalibrator restored = CareSensCalibrator.restoreState(state, config);
```

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
BLE Advertisement -> SensorConfig.Builder -> CareSensCalibrator(config)

BLE C5 Notification -> BlePacketParser.parse(bytes) -> ParsedReading
                                                           |
                                                           v
                          calibrator.processReading(seq, time, adc, temp)
                                                           |
                                                           v
                                                    CalibrationResult
                                                           |
                                                           v
                              BgReading.bgReadingInsertFromGluPro(
                                  result.getGlucoseMgdl(), timestamp, "CareSensAir")
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
SensorConfig config = new SensorConfig.Builder()
    .eapp(eapp).vref(vref).slope100(slope100).build();
CareSensCalibrator cal = new CareSensCalibrator(config);

// On each BLE C5 notification (~every 5 minutes)
BlePacketParser.ParsedReading r = BlePacketParser.parse(bleBytes);
CalibrationResult result = cal.processReading(
    r.getSequenceNumber(), r.getTimestamp(),
    r.getAdcSamples(), r.getTemperature());

if (result.isValid()) {
    double glucose = result.getGlucoseMgdl();
    double trend = result.getTrendRateMgdlPerMin();
    // display, store, broadcast — app's choice
}
```

## 5. Current Status

All steps have been completed:
- Public API facade: `CareSensCalibrator`, `SensorConfig`, `CalibrationResult`, `BlePacketParser`
- Internal classes are package-private
- State serialization with versioned format
- Oracle verification: 100% match on all safety-critical outputs across 2000 readings
- 310 tests passing

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
