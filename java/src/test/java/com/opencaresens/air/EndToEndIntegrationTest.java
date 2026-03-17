package com.opencaresens.air;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * End-to-end integration test: BLE bytes -> BlePacketParser -> CareSensCalibrator
 * -> CalibrationResult -> glucose value.
 *
 * Uses synthetic BLE packets with known ADC values and the same lot0 device
 * parameters from OracleVerificationTest.
 */
class EndToEndIntegrationTest {

    private static final long SENSOR_START_TIME = 1709726400L; // 2024-03-06 12:00:00 UTC
    private static final int INTERVAL_SECONDS = 300; // 5 minutes between readings

    private SensorConfig config;

    @BeforeEach
    void setUp() {
        config = createLot0Config();
    }

    // ------------------------------------------------------------------
    // Test 1: Full BLE-to-glucose flow
    // ------------------------------------------------------------------

    @Test
    @DisplayName("Full BLE-to-glucose flow: 84-byte packet -> parse -> calibrate -> glucose")
    void fullBleToGlucoseFlow() {
        CareSensCalibrator calibrator = new CareSensCalibrator(config);

        // Build a realistic 84-byte BLE packet with known values
        int seqNumber = 1;
        long timestamp = SENSOR_START_TIME + INTERVAL_SECONDS;
        int rawTemperature = 3412; // 34.12 degrees Celsius
        int adcValue = 8000; // mid-range ADC value

        byte[] blePacket = buildBlePacket(seqNumber, timestamp, rawTemperature, adcValue, 0);

        // Parse
        BlePacketParser.ParsedReading reading = BlePacketParser.parse(blePacket);
        assertEquals(seqNumber, reading.getSequenceNumber());
        assertEquals(timestamp, reading.getTimestamp());
        assertEquals(34.12, reading.getTemperature(), 0.001);
        assertEquals(0, reading.getDeviceErrorCode());

        int[] adcSamples = reading.getAdcSamples();
        assertEquals(30, adcSamples.length);
        for (int sample : adcSamples) {
            assertEquals(adcValue, sample);
        }

        // Calibrate
        CalibrationResult result = calibrator.processReading(
            reading.getSequenceNumber(),
            reading.getTimestamp(),
            reading.getAdcSamples(),
            reading.getTemperature()
        );

        // Verify result is populated (first reading is during warmup so glucose
        // may or may not be in normal range, but result must not be null)
        assertNotNull(result);
        assertFalse(Double.isNaN(result.getGlucoseMgdl()),
            "Glucose should not be NaN");
        assertFalse(Double.isInfinite(result.getGlucoseMgdl()),
            "Glucose should not be Infinite");
        // Error code should be a valid integer (bitmask)
        assertTrue(result.getErrorCode() >= 0,
            "Error code should be non-negative");
        // Stage should be 0 (warmup) or 1 (steady)
        assertTrue(result.getStage() == 0 || result.getStage() == 1,
            "Stage should be 0 or 1, got " + result.getStage());
        // toString should not throw
        assertNotNull(result.toString());
    }

    // ------------------------------------------------------------------
    // Test 2: Multi-reading sequence
    // ------------------------------------------------------------------

    @Test
    @DisplayName("Multi-reading sequence: 40 readings, realistic range, warmup transition, no NaN/Inf")
    void multiReadingSequence() {
        CareSensCalibrator calibrator = new CareSensCalibrator(config);

        int numReadings = 40;
        List<CalibrationResult> results = new ArrayList<>();
        boolean sawWarmup = false;
        boolean sawSteadyState = false;

        for (int i = 1; i <= numReadings; i++) {
            long timestamp = SENSOR_START_TIME + (long) i * INTERVAL_SECONDS;
            // Simulate slowly varying ADC values (glucose ~120 mg/dL range)
            int adcValue = 7500 + (int)(500 * Math.sin(i * 0.2));
            int rawTemp = 3400 + (i % 20); // ~34.00-34.20 C, slight variation

            byte[] blePacket = buildBlePacket(i, timestamp, rawTemp, adcValue, 0);
            BlePacketParser.ParsedReading reading = BlePacketParser.parse(blePacket);

            CalibrationResult result = calibrator.processReading(
                reading.getSequenceNumber(),
                reading.getTimestamp(),
                reading.getAdcSamples(),
                reading.getTemperature()
            );

            results.add(result);

            if (result.getStage() == 0) sawWarmup = true;
            if (result.getStage() == 1) sawSteadyState = true;
        }

        assertEquals(numReadings, results.size());
        assertEquals(numReadings, calibrator.getReadingsProcessed());

        // Verify no NaN or Infinity in any result field
        for (int i = 0; i < results.size(); i++) {
            CalibrationResult r = results.get(i);
            assertFalse(Double.isNaN(r.getGlucoseMgdl()),
                "Glucose NaN at reading " + (i + 1));
            assertFalse(Double.isInfinite(r.getGlucoseMgdl()),
                "Glucose Infinite at reading " + (i + 1));
            assertFalse(Double.isNaN(r.getTrendRateMgdlPerMin()),
                "TrendRate NaN at reading " + (i + 1));
            assertFalse(Double.isInfinite(r.getTrendRateMgdlPerMin()),
                "TrendRate Infinite at reading " + (i + 1));

            // Smoothed glucose values
            double[] smoothed = r.getSmoothedGlucose();
            for (int j = 0; j < smoothed.length; j++) {
                assertFalse(Double.isNaN(smoothed[j]),
                    "SmoothedGlucose[" + j + "] NaN at reading " + (i + 1));
                assertFalse(Double.isInfinite(smoothed[j]),
                    "SmoothedGlucose[" + j + "] Infinite at reading " + (i + 1));
            }

            // Error codes should be sensible (non-negative bitmask, fits in lower 7 bits)
            assertTrue(r.getErrorCode() >= 0 && r.getErrorCode() < 256,
                "Error code out of range at reading " + (i + 1) + ": " + r.getErrorCode());
        }

        // Verify warmup transition: with basicWarmup=24 and err345Seq2=5,
        // we should see warmup in early readings
        assertTrue(sawWarmup, "Should have seen warmup stage (stage=0)");

        // After enough readings, post-warmup glucose values that are valid
        // should be in realistic range
        for (int i = 25; i < results.size(); i++) {
            CalibrationResult r = results.get(i);
            if (r.getErrorCode() == 0 && r.getGlucoseMgdl() > 0) {
                assertTrue(r.getGlucoseMgdl() >= 20.0 && r.getGlucoseMgdl() <= 600.0,
                    "Post-warmup glucose out of realistic range at reading " + (i + 1)
                    + ": " + r.getGlucoseMgdl());
            }
        }
    }

    // ------------------------------------------------------------------
    // Test 3: State persistence through BLE flow
    // ------------------------------------------------------------------

    @Test
    @DisplayName("State persistence: calibrate 10 readings, save/restore, continue, verify continuity")
    void statePersistenceThroughBleFlow() {
        CareSensCalibrator calibrator = new CareSensCalibrator(config);

        // Process 10 readings
        List<CalibrationResult> beforeResults = new ArrayList<>();
        for (int i = 1; i <= 10; i++) {
            long timestamp = SENSOR_START_TIME + (long) i * INTERVAL_SECONDS;
            int adcValue = 7800 + i * 10;
            byte[] blePacket = buildBlePacket(i, timestamp, 3400, adcValue, 0);
            BlePacketParser.ParsedReading reading = BlePacketParser.parse(blePacket);

            CalibrationResult result = calibrator.processReading(
                reading.getSequenceNumber(),
                reading.getTimestamp(),
                reading.getAdcSamples(),
                reading.getTemperature()
            );
            beforeResults.add(result);
        }

        assertEquals(10, calibrator.getReadingsProcessed());

        // Save state
        byte[] savedState = calibrator.saveState();
        assertNotNull(savedState);
        assertTrue(savedState.length > 0, "Saved state should not be empty");

        // Restore into a new calibrator
        CareSensCalibrator restored = CareSensCalibrator.restoreState(savedState, config);
        assertEquals(10, restored.getReadingsProcessed());

        // Continue processing readings 11-20 on both original and restored
        List<CalibrationResult> originalContinued = new ArrayList<>();
        List<CalibrationResult> restoredContinued = new ArrayList<>();

        for (int i = 11; i <= 20; i++) {
            long timestamp = SENSOR_START_TIME + (long) i * INTERVAL_SECONDS;
            int adcValue = 7800 + i * 10;
            byte[] blePacket = buildBlePacket(i, timestamp, 3400, adcValue, 0);
            BlePacketParser.ParsedReading reading = BlePacketParser.parse(blePacket);

            CalibrationResult origResult = calibrator.processReading(
                reading.getSequenceNumber(),
                reading.getTimestamp(),
                reading.getAdcSamples(),
                reading.getTemperature()
            );
            originalContinued.add(origResult);

            CalibrationResult restResult = restored.processReading(
                reading.getSequenceNumber(),
                reading.getTimestamp(),
                reading.getAdcSamples(),
                reading.getTemperature()
            );
            restoredContinued.add(restResult);
        }

        // Verify continuity: original and restored should produce identical results
        for (int i = 0; i < originalContinued.size(); i++) {
            CalibrationResult orig = originalContinued.get(i);
            CalibrationResult rest = restoredContinued.get(i);

            assertEquals(orig.getGlucoseMgdl(), rest.getGlucoseMgdl(), 1e-10,
                "Glucose mismatch at continued reading " + (i + 11));
            assertEquals(orig.getTrendRateMgdlPerMin(), rest.getTrendRateMgdlPerMin(), 1e-10,
                "TrendRate mismatch at continued reading " + (i + 11));
            assertEquals(orig.getErrorCode(), rest.getErrorCode(),
                "ErrorCode mismatch at continued reading " + (i + 11));
            assertEquals(orig.getStage(), rest.getStage(),
                "Stage mismatch at continued reading " + (i + 11));
        }

        assertEquals(20, calibrator.getReadingsProcessed());
        assertEquals(20, restored.getReadingsProcessed());
    }

    // ------------------------------------------------------------------
    // Test 4: Error handling — invalid BLE packets
    // ------------------------------------------------------------------

    @Test
    @DisplayName("Error handling: null BLE packet throws IllegalArgumentException")
    void nullBlePacketThrows() {
        assertThrows(IllegalArgumentException.class, () -> BlePacketParser.parse(null));
    }

    @Test
    @DisplayName("Error handling: too-short BLE packet throws IllegalArgumentException")
    void shortBlePacketThrows() {
        byte[] tooShort = new byte[42];
        assertThrows(IllegalArgumentException.class, () -> BlePacketParser.parse(tooShort));
    }

    @Test
    @DisplayName("Error handling: empty BLE packet throws IllegalArgumentException")
    void emptyBlePacketThrows() {
        byte[] empty = new byte[0];
        assertThrows(IllegalArgumentException.class, () -> BlePacketParser.parse(empty));
    }

    @Test
    @DisplayName("Error handling: null ADC samples to calibrator throws IllegalArgumentException")
    void nullAdcSamplesToCalibrator() {
        CareSensCalibrator calibrator = new CareSensCalibrator(config);
        assertThrows(IllegalArgumentException.class, () ->
            calibrator.processReading(1, SENSOR_START_TIME + 300, null, 34.0));
    }

    @Test
    @DisplayName("Error handling: wrong ADC sample count throws IllegalArgumentException")
    void wrongAdcSampleCount() {
        CareSensCalibrator calibrator = new CareSensCalibrator(config);
        int[] wrongLength = new int[15];
        assertThrows(IllegalArgumentException.class, () ->
            calibrator.processReading(1, SENSOR_START_TIME + 300, wrongLength, 34.0));
    }

    @Test
    @DisplayName("Error handling: extreme ADC values don't crash the calibrator")
    void extremeAdcValuesDontCrash() {
        CareSensCalibrator calibrator = new CareSensCalibrator(config);

        // Very low ADC values
        byte[] lowPacket = buildBlePacket(1, SENSOR_START_TIME + 300, 3400, 100, 0);
        BlePacketParser.ParsedReading lowReading = BlePacketParser.parse(lowPacket);
        CalibrationResult lowResult = calibrator.processReading(
            lowReading.getSequenceNumber(),
            lowReading.getTimestamp(),
            lowReading.getAdcSamples(),
            lowReading.getTemperature()
        );
        assertNotNull(lowResult);
        assertFalse(Double.isNaN(lowResult.getGlucoseMgdl()));

        // Very high ADC values (near uint16 max)
        byte[] highPacket = buildBlePacket(2, SENSOR_START_TIME + 600, 3400, 65000, 0);
        BlePacketParser.ParsedReading highReading = BlePacketParser.parse(highPacket);
        CalibrationResult highResult = calibrator.processReading(
            highReading.getSequenceNumber(),
            highReading.getTimestamp(),
            highReading.getAdcSamples(),
            highReading.getTemperature()
        );
        assertNotNull(highResult);
        assertFalse(Double.isNaN(highResult.getGlucoseMgdl()));

        // Zero ADC values
        byte[] zeroPacket = buildBlePacket(3, SENSOR_START_TIME + 900, 3400, 0, 0);
        BlePacketParser.ParsedReading zeroReading = BlePacketParser.parse(zeroPacket);
        CalibrationResult zeroResult = calibrator.processReading(
            zeroReading.getSequenceNumber(),
            zeroReading.getTimestamp(),
            zeroReading.getAdcSamples(),
            zeroReading.getTemperature()
        );
        assertNotNull(zeroResult);
        assertFalse(Double.isNaN(zeroResult.getGlucoseMgdl()));
    }

    @Test
    @DisplayName("Error handling: oversized BLE packet parses without error (extra bytes ignored)")
    void oversizedBlePacketParses() {
        byte[] oversized = new byte[128];
        // Fill the first 84 bytes with a valid packet
        byte[] valid = buildBlePacket(1, SENSOR_START_TIME + 300, 3400, 8000, 0);
        System.arraycopy(valid, 0, oversized, 0, 84);

        BlePacketParser.ParsedReading reading = BlePacketParser.parse(oversized);
        assertNotNull(reading);
        assertEquals(1, reading.getSequenceNumber());
    }

    // ------------------------------------------------------------------
    // Helpers
    // ------------------------------------------------------------------

    /**
     * Build a synthetic 84-byte BLE C5 notification packet.
     *
     * Layout matches BlePacketParser expectations:
     *   [0]    reg0 = 0xC5
     *   [1]    reg1 = 0
     *   [2]    deviceErrorCode (int8)
     *   [3]    r_count = 0
     *   [4-7]  a_count = 0
     *   [8-11] misc = 0
     *   [12-15] sequenceNumber (uint32 LE)
     *   [16-19] timestamp (uint32 LE)
     *   [20-21] battery (uint16 LE)
     *   [22-23] temperature raw (uint16 LE)
     *   [24-83] glucose_array[30] (uint16 LE each)
     */
    private static byte[] buildBlePacket(int seqNumber, long timestamp,
                                         int rawTemperature, int adcValue,
                                         int deviceErrorCode) {
        ByteBuffer buf = ByteBuffer.allocate(BlePacketParser.PACKET_SIZE)
            .order(ByteOrder.LITTLE_ENDIAN);

        buf.put((byte) 0xC5);          // reg0
        buf.put((byte) 0);             // reg1
        buf.put((byte) deviceErrorCode); // deviceErrorCode
        buf.put((byte) 0);             // r_count
        buf.putInt(0);                 // a_count
        buf.putInt(0);                 // misc
        buf.putInt(seqNumber);         // sequenceNumber
        buf.putInt((int) timestamp);   // time (uint32)
        buf.putShort((short) 3000);    // battery
        buf.putShort((short) rawTemperature); // temperature
        for (int i = 0; i < 30; i++) {
            buf.putShort((short) adcValue); // ADC samples
        }

        return buf.array();
    }

    /**
     * Create lot0 SensorConfig matching OracleVerificationTest parameters.
     */
    private static SensorConfig createLot0Config() {
        return new SensorConfig.Builder()
            .eapp(0.10067f)
            .vref(1.49594f)
            .slope100(3.5226f)
            .slope(1.0f)
            .ycept(1.0f)
            .r2(0.0f)
            .t90(0.0f)
            .slopeRatio(1.0f)
            .basicWarmup(24)
            .basicYcept(0.0f)
            .err345Seq2(5)
            .iirFlag(1)
            .maximumValue(500.0f)
            .minimumValue(40.0f)
            .kalmanDeltaT(5)
            .wSgX100(new int[]{80, 130, 90, 80, 110, 90, 80})
            .err1Seq(new int[]{23, 47, 11})
            .err1Multi(new int[]{10, 10})
            .err1NLast(288)
            .err2StartSeq(289)
            .err2Seq(new int[]{20, 11, 6})
            .err2Cummax(2)
            .err2Glu(800.0f)
            .err345Seq4(new int[]{11, 23, 12, 288, 24})
            .err32Dt(new int[]{23, 60})
            .err32N(new int[]{3, 2})
            .sensorStartTime(SENSOR_START_TIME)
            .build();
    }
}
