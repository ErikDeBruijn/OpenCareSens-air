package com.opencaresens.air;

import com.opencaresens.air.model.AlgorithmOutput;
import com.opencaresens.air.model.AlgorithmState;
import com.opencaresens.air.model.CalibrationList;
import com.opencaresens.air.model.CgmInput;
import com.opencaresens.air.model.DebugOutput;
import com.opencaresens.air.model.DeviceInfo;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

/**
 * Main facade for CareSens Air CGM calibration.
 *
 * <p>This is the primary entry point for Android CGM apps (xDrip+, Jugluco,
 * AndroidAPS, etc.) to integrate the CareSens Air calibration algorithm.
 * It wraps the internal 14-step calibration pipeline behind a simple API.
 *
 * <p>Usage:
 * <pre>{@code
 * // One-time setup from BLE advertisement data
 * SensorConfig config = new SensorConfig.Builder()
 *     .eapp(0.10067f)
 *     .vref(1.2f)
 *     .slope100(2.5f)
 *     .basicWarmup(5)
 *     .err345Seq2(5)
 *     .wSgX100(new int[]{-3, 12, 17, 12, 17, 12, -3})
 *     .sensorStartTime(sensorStartUnixSeconds)
 *     .build();
 *
 * CareSensCalibrator calibrator = new CareSensCalibrator(config);
 *
 * // Called once per CGM reading (~every 5 minutes)
 * CalibrationResult result = calibrator.processReading(
 *     sequenceNumber, timestampSeconds, adcSamples, temperature);
 *
 * if (result.isValid()) {
 *     double glucose = result.getGlucoseMgdl();
 *     double trend = result.getTrendRateMgdlPerMin();
 * }
 * }</pre>
 *
 * <p>State can be persisted across app restarts:
 * <pre>{@code
 * // Save
 * byte[] state = calibrator.saveState();
 * // ... persist to SharedPreferences, database, etc.
 *
 * // Restore
 * CareSensCalibrator restored = CareSensCalibrator.restoreState(state, config);
 * }</pre>
 *
 * <p>This class is NOT thread-safe. Use external synchronization if calling
 * from multiple threads, or (recommended) use one instance per thread.
 */
public final class CareSensCalibrator {

    private final DeviceInfo deviceInfo;
    private AlgorithmState state;
    private final CalibrationList calList;
    private int readingsProcessed;

    /** Serialization format version. Increment when AlgorithmState layout changes. */
    private static final int STATE_VERSION = 1;

    /**
     * Create a new calibrator for a CareSens Air sensor.
     *
     * @param config sensor factory calibration parameters (from BLE advertisement)
     * @throws NullPointerException if config is null
     */
    public CareSensCalibrator(SensorConfig config) {
        if (config == null) {
            throw new NullPointerException("SensorConfig must not be null");
        }
        this.deviceInfo = config.toDeviceInfo();
        this.state = new AlgorithmState();
        this.calList = new CalibrationList();
        this.readingsProcessed = 0;
    }

    /**
     * Process one raw CGM reading through the full calibration pipeline.
     *
     * <p>Call this once per sensor reading (typically every 5 minutes).
     * The calibrator maintains internal state between calls, so readings
     * must be processed in order.
     *
     * @param seqNumber  sensor sequence number (starts at 1, increments each reading)
     * @param timestamp  measurement time in Unix seconds
     * @param adcSamples 30 raw ADC sample values from the sensor
     * @param temperature skin temperature in degrees Celsius
     * @return immutable calibration result
     * @throws IllegalArgumentException if adcSamples is null or not length 30
     */
    public CalibrationResult processReading(int seqNumber, long timestamp,
                                            int[] adcSamples, double temperature) {
        if (adcSamples == null) {
            throw new IllegalArgumentException("adcSamples must not be null");
        }
        if (adcSamples.length != 30) {
            throw new IllegalArgumentException(
                "adcSamples must have exactly 30 elements, got " + adcSamples.length);
        }

        // Build internal input
        CgmInput input = new CgmInput();
        input.seqNumber = seqNumber;
        input.measurementTimeStandard = timestamp;
        input.temperature = temperature;
        System.arraycopy(adcSamples, 0, input.workout, 0, 30);

        // Run the pipeline
        AlgorithmOutput output = new AlgorithmOutput();
        DebugOutput debug = new DebugOutput();
        CalibrationAlgorithm.process(deviceInfo, input, calList, state, output, debug);

        readingsProcessed++;

        // Build immutable result
        return new CalibrationResult(
            output.resultGlucose,
            output.trendrate,
            output.errcode,
            output.currentStage,
            output.calAvailableFlag,
            output.smoothResultGlucose,
            output.smoothSeq,
            output.smoothFixedFlag
        );
    }

    /**
     * Whether the sensor has completed its warmup period.
     *
     * <p>During warmup, glucose values may be less accurate. The warmup
     * period is defined by the sensor's factory calibration parameters
     * (typically 5-10 readings).
     */
    public boolean isWarmedUp() {
        return readingsProcessed > 0
            && state.idxOriginSeq > deviceInfo.err345Seq2;
    }

    /**
     * Number of readings processed since creation or last restore.
     */
    public int getReadingsProcessed() {
        return readingsProcessed;
    }

    /**
     * Serialize the current calibrator state for persistence.
     *
     * <p>The returned byte array can be stored in SharedPreferences, a database,
     * or any other storage mechanism. Use {@link #restoreState(byte[], SensorConfig)}
     * to reconstruct the calibrator later.
     *
     * @return serialized state bytes
     * @throws RuntimeException if serialization fails
     */
    public byte[] saveState() {
        try {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ObjectOutputStream oos = new ObjectOutputStream(bos);
            oos.writeInt(STATE_VERSION);
            oos.writeInt(readingsProcessed);
            oos.writeObject(state);
            oos.flush();
            return bos.toByteArray();
        } catch (Exception e) {
            throw new RuntimeException("Failed to serialize calibrator state", e);
        }
    }

    /**
     * Restore a calibrator from previously saved state.
     *
     * <p>The {@code config} must match the sensor that produced the saved state.
     * Using a different sensor's config with saved state from another sensor
     * will produce incorrect glucose values.
     *
     * @param stateBytes serialized state from {@link #saveState()}
     * @param config     sensor factory calibration parameters
     * @return restored calibrator
     * @throws IllegalArgumentException if stateBytes is null or empty
     * @throws RuntimeException if deserialization fails
     */
    public static CareSensCalibrator restoreState(byte[] stateBytes, SensorConfig config) {
        if (stateBytes == null || stateBytes.length == 0) {
            throw new IllegalArgumentException("stateBytes must not be null or empty");
        }
        try {
            ByteArrayInputStream bis = new ByteArrayInputStream(stateBytes);
            ObjectInputStream ois = new ObjectInputStream(bis);
            int version = ois.readInt();
            if (version != STATE_VERSION) {
                throw new RuntimeException(
                    "Incompatible state version: expected " + STATE_VERSION
                    + ", got " + version
                    + ". Saved state from a different library version cannot be restored.");
            }
            int readingsProcessed = ois.readInt();
            AlgorithmState restoredState = (AlgorithmState) ois.readObject();

            CareSensCalibrator calibrator = new CareSensCalibrator(config);
            calibrator.state = restoredState;
            calibrator.readingsProcessed = readingsProcessed;
            return calibrator;
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException("Failed to deserialize calibrator state", e);
        }
    }
}
