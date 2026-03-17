package com.opencaresens.air;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests for the CareSensCalibrator public API facade.
 *
 * These tests verify that the facade correctly wraps the internal calibration
 * pipeline and provides a clean, safe interface for host apps.
 */
class CareSensCalibratorTest {

    private static final double EPS = 1e-10;

    // ======================================================================
    // Helper: create a typical sensor config (lot type 1)
    // ======================================================================

    private static SensorConfig createTypicalConfig() {
        return new SensorConfig.Builder()
            .eapp(0.10067f)
            .vref(1.2f)
            .slope100(2.5f)
            .slope(0.025f)
            .slopeRatio(1.0f)
            .t90(10.0f)
            .basicWarmup(5)
            .err345Seq2(5)
            .iirFlag(1)
            .sensorStartTime(100L)
            .maximumValue(500.0f)
            .wSgX100(new int[]{-3, 12, 17, 12, 17, 12, -3})
            .err1Seq(new int[]{23, 50, 100})
            .err1NLast(288)
            .err1Multi(new int[]{10, 10})
            .err2Seq(new int[]{100, 48, 24})
            .err2StartSeq(289)
            .err2Cummax(1)
            .err2Glu(100.0f)
            .err345Seq4(new int[]{0, 0, 12, 0, 0})
            .err32Dt(new int[]{10, 15})
            .err32N(new int[]{3, 5})
            .kalmanDeltaT(5)
            .build();
    }

    private static int[] createAdcSamples(int value) {
        int[] adc = new int[30];
        for (int i = 0; i < 30; i++) adc[i] = value;
        return adc;
    }

    // ======================================================================
    // SensorConfig tests
    // ======================================================================

    @Nested
    @DisplayName("SensorConfig")
    class SensorConfigTests {

        @Test
        @DisplayName("builder creates config with correct values")
        void builderValues() {
            SensorConfig config = new SensorConfig.Builder()
                .eapp(0.10067f)
                .vref(1.2f)
                .slope100(2.5f)
                .lot("LOT123")
                .sensorId("SENS456")
                .sensorStartTime(12345L)
                .basicWarmup(5)
                .err345Seq2(5)
                .build();

            assertEquals(0.10067f, config.getEapp());
            assertEquals(1.2f, config.getVref());
            assertEquals(2.5f, config.getSlope100());
            assertEquals("LOT123", config.getLot());
            assertEquals("SENS456", config.getSensorId());
            assertEquals(12345L, config.getSensorStartTime());
            assertEquals(5, config.getBasicWarmup());
            assertEquals(5, config.getErr345Seq2());
        }

        @Test
        @DisplayName("builder throws when required fields missing")
        void builderValidation() {
            assertThrows(IllegalStateException.class, () ->
                new SensorConfig.Builder().build());
        }

        @Test
        @DisplayName("builder throws when only vref is zero")
        void builderValidationVrefZero() {
            assertThrows(IllegalStateException.class, () ->
                new SensorConfig.Builder().slope100(2.5f).build());
        }

        @Test
        @DisplayName("builder throws when only slope100 is zero")
        void builderValidationSlope100Zero() {
            assertThrows(IllegalStateException.class, () ->
                new SensorConfig.Builder().vref(1.2f).build());
        }

        @Test
        @DisplayName("builder with only required fields succeeds")
        void builderMinimal() {
            SensorConfig config = new SensorConfig.Builder()
                .vref(1.2f)
                .slope100(2.5f)
                .build();
            assertEquals(1.2f, config.getVref());
            assertEquals(2.5f, config.getSlope100());
        }

        @Test
        @DisplayName("builder deep-copies DeviceInfo so post-build mutation is safe")
        void builderImmutability() {
            SensorConfig.Builder builder = new SensorConfig.Builder()
                .eapp(0.10067f)
                .vref(1.2f)
                .slope100(2.5f)
                .basicWarmup(5)
                .err345Seq2(5);

            SensorConfig config = builder.build();

            // Mutate the builder after build
            builder.vref(9.9f);
            builder.slope100(9.9f);

            // Config must retain original values
            assertEquals(1.2f, config.getVref());
            assertEquals(2.5f, config.getSlope100());
        }
    }

    // ======================================================================
    // CalibrationResult tests
    // ======================================================================

    @Nested
    @DisplayName("CalibrationResult")
    class CalibrationResultTests {

        @Test
        @DisplayName("valid result: no errors, glucose in range")
        void validResult() {
            CalibrationResult r = new CalibrationResult(
                120.0, 1.5, 0, 1, 1,
                new double[6], new int[6], new int[6]);
            assertTrue(r.isValid());
            assertFalse(r.hasError());
            assertEquals(120.0, r.getGlucoseMgdl());
            assertEquals(1.5, r.getTrendRateMgdlPerMin());
            assertEquals(1, r.getStage());
        }

        @Test
        @DisplayName("invalid: error code set")
        void errorResult() {
            CalibrationResult r = new CalibrationResult(
                120.0, 1.5, 1, 1, 0,
                new double[6], new int[6], new int[6]);
            assertFalse(r.isValid());
            assertTrue(r.hasError());
            assertEquals(1, r.getErrorCode());
        }

        @Test
        @DisplayName("invalid: glucose below 40 mg/dL")
        void lowGlucose() {
            CalibrationResult r = new CalibrationResult(
                30.0, 0.0, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            assertFalse(r.isValid());
        }

        @Test
        @DisplayName("invalid: glucose above 500 mg/dL")
        void highGlucose() {
            CalibrationResult r = new CalibrationResult(
                550.0, 0.0, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            assertFalse(r.isValid());
        }

        @Test
        @DisplayName("mmol/L conversion")
        void mmolConversion() {
            CalibrationResult r = new CalibrationResult(
                180.0, 0.0, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            assertEquals(180.0 / 18.0182, r.getGlucoseMmol(), 1e-6);
        }

        @Test
        @DisplayName("trend available when not sentinel value")
        void trendAvailable() {
            CalibrationResult available = new CalibrationResult(
                120.0, 1.5, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            assertTrue(available.isTrendAvailable());

            CalibrationResult notAvailable = new CalibrationResult(
                120.0, 100.0, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            assertFalse(notAvailable.isTrendAvailable());
        }

        @Test
        @DisplayName("NaN trend is not reported as available")
        void trendNanNotAvailable() {
            CalibrationResult r = new CalibrationResult(
                120.0, Double.NaN, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            assertFalse(r.isTrendAvailable());
        }

        @Test
        @DisplayName("Infinity trend is not reported as available")
        void trendInfinityNotAvailable() {
            CalibrationResult r = new CalibrationResult(
                120.0, Double.POSITIVE_INFINITY, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            assertFalse(r.isTrendAvailable());
        }

        @Test
        @DisplayName("Negative Infinity trend is not reported as available")
        void trendNegInfinityNotAvailable() {
            CalibrationResult r = new CalibrationResult(
                120.0, Double.NEGATIVE_INFINITY, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            assertFalse(r.isTrendAvailable());
        }

        @Test
        @DisplayName("smoothed arrays are defensive copies")
        void defensiveCopies() {
            double[] sg = {100.0, 101.0, 102.0, 103.0, 104.0, 105.0};
            CalibrationResult r = new CalibrationResult(
                120.0, 0.0, 0, 1, 0,
                sg, new int[6], new int[6]);
            double[] copy1 = r.getSmoothedGlucose();
            copy1[0] = 999.0;
            assertEquals(100.0, r.getSmoothedGlucose()[0]);
        }

        @Test
        @DisplayName("toString includes key fields")
        void toStringFormat() {
            CalibrationResult r = new CalibrationResult(
                120.5, 1.5, 0, 1, 0,
                new double[6], new int[6], new int[6]);
            String s = r.toString();
            assertTrue(s.contains("120.5"));
            assertTrue(s.contains("stage=1"));
        }
    }

    // ======================================================================
    // CareSensCalibrator construction
    // ======================================================================

    @Nested
    @DisplayName("CareSensCalibrator construction")
    class ConstructionTests {

        @Test
        @DisplayName("null config throws NullPointerException")
        void nullConfig() {
            assertThrows(NullPointerException.class, () ->
                new CareSensCalibrator(null));
        }

        @Test
        @DisplayName("new calibrator starts with zero readings")
        void initialState() {
            CareSensCalibrator cal = new CareSensCalibrator(createTypicalConfig());
            assertEquals(0, cal.getReadingsProcessed());
            assertFalse(cal.isWarmedUp());
        }
    }

    // ======================================================================
    // processReading
    // ======================================================================

    @Nested
    @DisplayName("processReading")
    class ProcessReadingTests {

        private CareSensCalibrator calibrator;

        @BeforeEach
        void setUp() {
            calibrator = new CareSensCalibrator(createTypicalConfig());
        }

        @Test
        @DisplayName("null ADC samples throws")
        void nullAdc() {
            assertThrows(IllegalArgumentException.class, () ->
                calibrator.processReading(1, 1000L, null, 36.5));
        }

        @Test
        @DisplayName("wrong ADC array length throws")
        void wrongAdcLength() {
            assertThrows(IllegalArgumentException.class, () ->
                calibrator.processReading(1, 1000L, new int[10], 36.5));
        }

        @Test
        @DisplayName("first reading returns a result")
        void firstReading() {
            CalibrationResult result = calibrator.processReading(
                1, 1000L, createAdcSamples(2000), 36.5);

            assertNotNull(result);
            assertEquals(0, result.getStage()); // warmup
            assertEquals(1, calibrator.getReadingsProcessed());
            assertTrue(Double.isFinite(result.getGlucoseMgdl()));
        }

        @Test
        @DisplayName("readings increment counter")
        void readingCounter() {
            for (int i = 1; i <= 3; i++) {
                calibrator.processReading(i, (long)(i * 300), createAdcSamples(2000), 36.5);
            }
            assertEquals(3, calibrator.getReadingsProcessed());
        }

        @Test
        @DisplayName("warmup transitions to warmed up after enough readings")
        void warmupTransition() {
            assertFalse(calibrator.isWarmedUp());

            // Feed readings through warmup (err345Seq2=5)
            for (int s = 1; s <= 5; s++) {
                calibrator.processReading(s, (long)(s * 300), createAdcSamples(2000), 36.5);
            }
            assertFalse(calibrator.isWarmedUp()); // seq 5 is still <= err345Seq2

            // Reading 6 should transition to steady state
            CalibrationResult r6 = calibrator.processReading(
                6, 1800L, createAdcSamples(2000), 36.5);
            assertTrue(calibrator.isWarmedUp());
            assertEquals(1, r6.getStage());
        }

        @Test
        @DisplayName("trendrate defaults to 100.0 early in sensor life")
        void trendDefault() {
            CalibrationResult result = calibrator.processReading(
                1, 1000L, createAdcSamples(2000), 36.5);
            assertEquals(100.0, result.getTrendRateMgdlPerMin());
            assertFalse(result.isTrendAvailable());
        }

        @Test
        @DisplayName("smoothed glucose array has 6 elements")
        void smoothedLength() {
            CalibrationResult result = calibrator.processReading(
                1, 1000L, createAdcSamples(2000), 36.5);
            assertEquals(6, result.getSmoothedGlucose().length);
            assertEquals(6, result.getSmoothedSeq().length);
            assertEquals(6, result.getSmoothedFixedFlag().length);
        }

        @Test
        @DisplayName("glucose output is finite for typical inputs")
        void glucoseFinite() {
            CalibrationResult result = calibrator.processReading(
                10, 5000L, createAdcSamples(2000), 36.5);
            assertTrue(Double.isFinite(result.getGlucoseMgdl()));
        }
    }

    // ======================================================================
    // State persistence
    // ======================================================================

    @Nested
    @DisplayName("State persistence")
    class StatePersistenceTests {

        @Test
        @DisplayName("save and restore preserves readings count")
        void saveRestoreCount() {
            SensorConfig config = createTypicalConfig();
            CareSensCalibrator cal = new CareSensCalibrator(config);

            for (int s = 1; s <= 3; s++) {
                cal.processReading(s, (long)(s * 300), createAdcSamples(2000), 36.5);
            }
            assertEquals(3, cal.getReadingsProcessed());

            byte[] saved = cal.saveState();
            assertNotNull(saved);
            assertTrue(saved.length > 0);

            CareSensCalibrator restored = CareSensCalibrator.restoreState(saved, config);
            assertEquals(3, restored.getReadingsProcessed());
        }

        @Test
        @DisplayName("restored calibrator produces same output as continued original")
        void saveRestoreContinuity() {
            SensorConfig config = createTypicalConfig();
            CareSensCalibrator cal = new CareSensCalibrator(config);

            // Feed 5 readings
            for (int s = 1; s <= 5; s++) {
                cal.processReading(s, (long)(s * 300), createAdcSamples(2000), 36.5);
            }

            // Save state
            byte[] saved = cal.saveState();

            // Process reading 6 on original
            CalibrationResult r6original = cal.processReading(
                6, 1800L, createAdcSamples(2000), 36.5);

            // Process reading 6 on restored
            CareSensCalibrator restored = CareSensCalibrator.restoreState(saved, config);
            CalibrationResult r6restored = restored.processReading(
                6, 1800L, createAdcSamples(2000), 36.5);

            // Results should be identical
            assertEquals(r6original.getGlucoseMgdl(), r6restored.getGlucoseMgdl(), 0.0);
            assertEquals(r6original.getTrendRateMgdlPerMin(), r6restored.getTrendRateMgdlPerMin(), 0.0);
            assertEquals(r6original.getErrorCode(), r6restored.getErrorCode());
            assertEquals(r6original.getStage(), r6restored.getStage());
        }

        @Test
        @DisplayName("restore with null bytes throws")
        void restoreNull() {
            assertThrows(IllegalArgumentException.class, () ->
                CareSensCalibrator.restoreState(null, createTypicalConfig()));
        }

        @Test
        @DisplayName("restore with empty bytes throws")
        void restoreEmpty() {
            assertThrows(IllegalArgumentException.class, () ->
                CareSensCalibrator.restoreState(new byte[0], createTypicalConfig()));
        }

        @Test
        @DisplayName("restore with garbage bytes throws RuntimeException")
        void restoreGarbage() {
            assertThrows(RuntimeException.class, () ->
                CareSensCalibrator.restoreState(new byte[]{1, 2, 3}, createTypicalConfig()));
        }

        @Test
        @DisplayName("restore detects incompatible version")
        void restoreIncompatibleVersion() {
            // Build a byte stream with wrong version number
            try {
                java.io.ByteArrayOutputStream bos = new java.io.ByteArrayOutputStream();
                java.io.ObjectOutputStream oos = new java.io.ObjectOutputStream(bos);
                oos.writeInt(999); // wrong version
                oos.writeInt(0);   // readingsProcessed
                oos.writeObject(new com.opencaresens.air.model.AlgorithmState());
                oos.flush();
                byte[] badVersion = bos.toByteArray();

                RuntimeException ex = assertThrows(RuntimeException.class, () ->
                    CareSensCalibrator.restoreState(badVersion, createTypicalConfig()));
                assertTrue(ex.getMessage().contains("Incompatible state version"));
            } catch (Exception e) {
                fail("Test setup failed: " + e.getMessage());
            }
        }
    }

    // ======================================================================
    // Oracle verification through the facade
    // ======================================================================

    @Nested
    @DisplayName("Oracle verification through facade")
    class OracleTests {

        @Test
        @DisplayName("lot1: multiple readings produce consistent glucose values")
        void lot1Consistency() {
            CareSensCalibrator cal = new CareSensCalibrator(createTypicalConfig());

            double prevGlucose = Double.NaN;
            for (int s = 1; s <= 10; s++) {
                CalibrationResult r = cal.processReading(
                    s, (long)(s * 300), createAdcSamples(2000), 36.5);
                assertTrue(Double.isFinite(r.getGlucoseMgdl()),
                    "Glucose should be finite at seq " + s);

                if (s > 1) {
                    // Glucose should not wildly jump with constant inputs
                    double delta = Math.abs(r.getGlucoseMgdl() - prevGlucose);
                    assertTrue(delta < 50.0,
                        "Glucose delta should be small with constant input, got " + delta);
                }
                prevGlucose = r.getGlucoseMgdl();
            }
        }

        @Test
        @DisplayName("lot2: config with eapp < 0.075 processes correctly")
        void lot2Processing() {
            SensorConfig lot2Config = new SensorConfig.Builder()
                .eapp(0.05f)
                .vref(1.2f)
                .slope100(2.5f)
                .slope(0.025f)
                .slopeRatio(1.0f)
                .t90(10.0f)
                .basicWarmup(5)
                .err345Seq2(5)
                .iirFlag(1)
                .sensorStartTime(100L)
                .maximumValue(500.0f)
                .wSgX100(new int[]{-3, 12, 17, 12, 17, 12, -3})
                .err1Seq(new int[]{23, 50, 100})
                .err1NLast(288)
                .err1Multi(new int[]{10, 10})
                .err2Seq(new int[]{100, 48, 24})
                .err2StartSeq(289)
                .err2Cummax(1)
                .err2Glu(100.0f)
                .err345Seq4(new int[]{0, 0, 12, 0, 0})
                .err32Dt(new int[]{10, 15})
                .err32N(new int[]{3, 5})
                .kalmanDeltaT(5)
                .build();

            CareSensCalibrator cal = new CareSensCalibrator(lot2Config);

            CalibrationResult r = cal.processReading(
                1, 1000L, createAdcSamples(2500), 36.5);
            assertNotNull(r);
            assertTrue(Double.isFinite(r.getGlucoseMgdl()));
        }

        @Test
        @DisplayName("facade result matches direct pipeline call")
        void facadeMatchesPipeline() {
            // This is the key test: verify the facade produces the same
            // output as calling CalibrationAlgorithm.process() directly.
            SensorConfig config = createTypicalConfig();
            CareSensCalibrator cal = new CareSensCalibrator(config);

            int seq = 1;
            long time = 1000L;
            int[] adc = createAdcSamples(2000);
            double temp = 36.5;

            // Through facade
            CalibrationResult facadeResult = cal.processReading(seq, time, adc, temp);

            // Direct pipeline call
            com.opencaresens.air.model.DeviceInfo di = config.toDeviceInfo();
            com.opencaresens.air.model.AlgorithmState state = new com.opencaresens.air.model.AlgorithmState();
            com.opencaresens.air.model.CalibrationList calList = new com.opencaresens.air.model.CalibrationList();
            com.opencaresens.air.model.CgmInput input = new com.opencaresens.air.model.CgmInput();
            input.seqNumber = seq;
            input.measurementTimeStandard = time;
            input.temperature = temp;
            System.arraycopy(adc, 0, input.workout, 0, 30);
            com.opencaresens.air.model.AlgorithmOutput output = new com.opencaresens.air.model.AlgorithmOutput();
            com.opencaresens.air.model.DebugOutput debug = new com.opencaresens.air.model.DebugOutput();
            CalibrationAlgorithm.process(di, input, calList, state, output, debug);

            // Verify facade matches direct call
            assertEquals(output.resultGlucose, facadeResult.getGlucoseMgdl(), 0.0);
            assertEquals(output.trendrate, facadeResult.getTrendRateMgdlPerMin(), 0.0);
            assertEquals(output.errcode, facadeResult.getErrorCode());
            assertEquals(output.currentStage, facadeResult.getStage());
        }
    }
}
