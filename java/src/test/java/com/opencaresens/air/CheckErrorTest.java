package com.opencaresens.air;

import com.opencaresens.air.model.AlgorithmState;
import com.opencaresens.air.model.DebugOutput;
import com.opencaresens.air.model.DeviceInfo;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests for CheckError, ported from check_error.c.
 * Each error detector is tested independently following Red-Green-Refactor.
 *
 * MEDICAL SAFETY: These tests verify that error detection matches the C
 * implementation exactly. Incorrect error codes can suppress or fabricate
 * glucose readings, leading to dangerous insulin dosing decisions.
 */
class CheckErrorTest {

    private static final double EPS = 1e-10;

    private DeviceInfo devInfo;
    private AlgorithmState algoArgs;
    private DebugOutput debug;

    @BeforeEach
    void setUp() {
        devInfo = new DeviceInfo();
        algoArgs = new AlgorithmState();
        debug = new DebugOutput();

        // Typical factory defaults
        devInfo.err1Seq = new int[]{23, 50, 100};
        devInfo.err1NLast = 288;
        devInfo.err1Multi = new int[]{10, 10};
        devInfo.err2Seq = new int[]{100, 48, 24};
        devInfo.err2StartSeq = 289;
        devInfo.err2Cummax = 1;
        devInfo.err2Glu = 100.0f;
        devInfo.maximumValue = 500.0f;
        devInfo.kalmanDeltaT = 5;
        devInfo.err345Seq2 = 5;
        devInfo.err345Seq4 = new int[]{0, 0, 12, 0, 0};
        devInfo.err32Dt = new int[]{10, 15};
        devInfo.err32N = new int[]{3, 5};
        devInfo.slope100 = 100.0f;
    }

    // ======================================================================
    // FIFO array shifts
    // ======================================================================

    @Nested
    @DisplayName("shiftArrays — FIFO maintenance")
    class ShiftArraysTest {

        @Test
        @DisplayName("errGluArr shifts left and appends round(glucose)")
        void errGluArrShiftsAndAppends() {
            for (int i = 0; i < 288; i++) {
                algoArgs.errGluArr[i] = i;
            }

            CheckError.shiftArrays(algoArgs, debug, 150.7);

            assertEquals(1.0, algoArgs.errGluArr[0], EPS, "first element should be old [1]");
            assertEquals(287.0, algoArgs.errGluArr[286], EPS, "second-to-last");
            assertEquals(151.0, algoArgs.errGluArr[287], EPS, "last element = round(150.7)");
        }

        @Test
        @DisplayName("err128 noise buffer shifts left and appends tran_inA_5min")
        void err128BufferShiftsAndAppends() {
            for (int i = 0; i < 36; i++) {
                algoArgs.err128CgmCNoiseRevisedValue[i] = i * 10.0;
            }
            debug.tranInA5min = 42.5;

            CheckError.shiftArrays(algoArgs, debug, 100.0);

            assertEquals(10.0, algoArgs.err128CgmCNoiseRevisedValue[0], EPS);
            assertEquals(350.0, algoArgs.err128CgmCNoiseRevisedValue[34], EPS);
            assertEquals(42.5, algoArgs.err128CgmCNoiseRevisedValue[35], EPS);
        }

        @Test
        @DisplayName("round uses math_round (half-away-from-zero)")
        void roundUsesHalfAwayFromZero() {
            CheckError.shiftArrays(algoArgs, debug, 100.5);
            assertEquals(101.0, algoArgs.errGluArr[287], EPS);

            CheckError.shiftArrays(algoArgs, debug, -0.5);
            assertEquals(-1.0, algoArgs.errGluArr[287], EPS);
        }

        @Test
        @DisplayName("NaN glucose is preserved as NaN in array")
        void nanGlucosePreserved() {
            CheckError.shiftArrays(algoArgs, debug, Double.NaN);
            assertTrue(Double.isNaN(algoArgs.errGluArr[287]));
        }
    }

    // ======================================================================
    // err32: timing gap detection
    // ======================================================================

    @Nested
    @DisplayName("err32 — timing gap detection")
    class Err32Test {

        @Test
        @DisplayName("no error on first reading (prev_time == 0)")
        void noErrorOnFirstReading() {
            algoArgs.err32PrevTime = 0;

            int bits = CheckError.detectErr32(devInfo, algoArgs, debug, 1, 1000L);

            assertEquals(0, bits);
            assertEquals(0, debug.errorCode32);
        }

        @Test
        @DisplayName("no error when seq <= 1")
        void noErrorWhenSeqOne() {
            algoArgs.err32PrevTime = 100L;

            int bits = CheckError.detectErr32(devInfo, algoArgs, debug, 1, 400L);

            assertEquals(0, bits);
        }

        @Test
        @DisplayName("no error when dt within threshold2")
        void noErrorWithinThreshold() {
            // err32_dt[1] = 15 => threshold2 = 15*60 = 900s
            algoArgs.err32PrevTime = 1000L;

            int bits = CheckError.detectErr32(devInfo, algoArgs, debug, 5, 1800L);

            assertEquals(0, bits);
            assertEquals(0, debug.errorCode32);
        }

        @Test
        @DisplayName("error fires when dt > threshold2")
        void errorWhenDtExceedsThreshold2() {
            // threshold2 = 15*60 = 900s, dt = 1000s > 900s
            algoArgs.err32PrevTime = 1000L;

            int bits = CheckError.detectErr32(devInfo, algoArgs, debug, 5, 2001L);

            assertEquals(32, bits);
            assertEquals(1, debug.errorCode32);
        }

        @Test
        @DisplayName("state updated: prev_time, prev_seq, result_prev")
        void stateUpdated() {
            CheckError.detectErr32(devInfo, algoArgs, debug, 7, 5000L);

            assertEquals(5000L, algoArgs.err32PrevTime);
            assertEquals(7, algoArgs.err32PrevSeq);
        }
    }

    // ======================================================================
    // err8: range/warmup check
    // ======================================================================

    @Nested
    @DisplayName("err8 — range/warmup (inactive in factory-cal mode)")
    class Err8Test {

        @Test
        @DisplayName("always returns 0 in factory-cal-only mode")
        void alwaysZero() {
            CheckError.detectErr8(algoArgs, debug);

            assertEquals(0, debug.errorCode8);
            assertEquals(0, algoArgs.err8ResultPrev);
        }
    }

    // ======================================================================
    // err1: contact/noise detection
    // ======================================================================

    @Nested
    @DisplayName("err1 — contact/noise detection")
    class Err1Test {

        @Test
        @DisplayName("inactive when seq <= err1_seq[0]")
        void inactiveBeforeThreshold() {
            devInfo.err1Seq[0] = 23;

            int bits = CheckError.detectErr1(devInfo, algoArgs, debug, 23);

            assertEquals(0, bits);
            assertEquals(0, debug.errorCode1);
        }

        @Test
        @DisplayName("n increments on each active call")
        void nIncrements() {
            devInfo.err1Seq[0] = 23;
            algoArgs.err1N = 0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            CheckError.detectErr1(devInfo, algoArgs, debug, 24);
            assertEquals(1, algoArgs.err1N);
            assertEquals(1, debug.err1N);

            CheckError.detectErr1(devInfo, algoArgs, debug, 25);
            assertEquals(2, algoArgs.err1N);
        }

        @Test
        @DisplayName("epoch reset seeds thresholds correctly")
        void epochReset() {
            devInfo.err1Seq[0] = 23;
            devInfo.err1NLast = 5;
            devInfo.err1Multi = new int[]{3, 2};

            // Set up accumulators to have known state
            algoArgs.err1N = 5;
            algoArgs.err1ThSseDMean1 = 50.0;  // mean = 10.0
            algoArgs.err1ThDiff1 = 20.0;       // mean = 4.0
            debug.tranInA5min = 99.0;

            CheckError.detectErr1(devInfo, algoArgs, debug, 24);

            // Seeds: sse_seed = 10*3 = 30, diff_seed = 4*2 = 8
            assertEquals(30.0, algoArgs.err1ThSseDMean1, EPS);
            assertEquals(30.0, algoArgs.err1ThSseDMean2, EPS);
            assertEquals(30.0, algoArgs.err1ThSseDMean, EPS);
            assertEquals(8.0, algoArgs.err1ThDiff1, EPS);
            assertEquals(8.0, algoArgs.err1ThDiff2, EPS);
            assertEquals(8.0, algoArgs.err1ThDiff, EPS);

            // Flags set
            assertEquals(1, algoArgs.err1Isfirst0);
            assertEquals(1, algoArgs.err1Isfirst1);
            assertEquals(1, algoArgs.err1Isfirst2);

            // n reset to 0
            assertEquals(0, algoArgs.err1N);
            assertEquals(0, debug.err1N);

            // tran_5min stored for next avg_diff
            assertEquals(99.0, algoArgs.err1ISseDMean4h[99], EPS);
        }

        @Test
        @DisplayName("isfirst2 resets to 0 on first post-reset step")
        void isfirst2ResetAfterFirstStep() {
            devInfo.err1Seq[0] = 23;
            algoArgs.err1N = 0;
            algoArgs.err1Isfirst2 = 1;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            CheckError.detectErr1(devInfo, algoArgs, debug, 24);

            assertEquals(0, algoArgs.err1Isfirst2);
        }

        @Test
        @DisplayName("i_sse_d_mean computed correctly from tran_inA and interpolation")
        void iSseDMeanComputation() {
            devInfo.err1Seq[0] = 0;
            algoArgs.err1N = 0;
            algoArgs.err1PrevLast1minCurr = 100.0;

            // Set up tran_inA_1min: [110, 120, 130, 140, 150]
            debug.tranInA1min = new double[]{110.0, 120.0, 130.0, 140.0, 150.0};

            // Set tran_inA[30] to match linear interpolation exactly => sse=0
            debug.tranInA = new double[30];
            double prev = 100.0;
            for (int k = 0; k < 5; k++) {
                double target = debug.tranInA1min[k];
                double delta = (target - prev) / 6.0;
                for (int j = 0; j < 6; j++) {
                    debug.tranInA[k * 6 + j] = prev + delta * (j + 1);
                }
                prev = target;
            }

            CheckError.detectErr1(devInfo, algoArgs, debug, 1);

            assertEquals(0.0, debug.err1ISseDMean, EPS, "exact match => zero SSE");
        }

        @Test
        @DisplayName("i_sse_d_mean with known deviation")
        void iSseDMeanWithDeviation() {
            devInfo.err1Seq[0] = 0;
            algoArgs.err1N = 0;
            algoArgs.err1PrevLast1minCurr = 100.0;

            debug.tranInA1min = new double[]{100.0, 100.0, 100.0, 100.0, 100.0};

            // All tran_inA values at 100.0 (matching the interpolation)
            debug.tranInA = new double[30];
            java.util.Arrays.fill(debug.tranInA, 100.0);
            // Add deviation of 1.0 at position 0
            debug.tranInA[0] = 101.0;

            CheckError.detectErr1(devInfo, algoArgs, debug, 1);

            // sse = 1^2 / 30 = 1/30
            assertEquals(1.0 / 30.0, debug.err1ISseDMean, EPS);
        }

        @Test
        @DisplayName("first epoch accumulates into th_sse_d_mean1")
        void firstEpochAccumulation() {
            devInfo.err1Seq[0] = 0;
            algoArgs.err1Isfirst0 = 0; // first epoch
            algoArgs.err1N = 0;
            algoArgs.err1PrevLast1minCurr = 0.0;

            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            // First step: n becomes 1, th_sse_d_mean1 = i_sse
            CheckError.detectErr1(devInfo, algoArgs, debug, 1);
            double iSse1 = debug.err1ISseDMean;
            assertEquals(iSse1, algoArgs.err1ThSseDMean1, EPS);
            assertEquals(iSse1, algoArgs.err1ThSseDMean, EPS);

            // Second step: th_sse_d_mean1 += i_sse
            algoArgs.err1PrevLast1minCurr = debug.tranInA1min[4];
            CheckError.detectErr1(devInfo, algoArgs, debug, 2);
            double iSse2 = debug.err1ISseDMean;
            assertEquals(iSse1 + iSse2, algoArgs.err1ThSseDMean1, EPS);
        }

        @Test
        @DisplayName("avg_diff is 0 on first step (n=1)")
        void avgDiffZeroOnFirstStep() {
            devInfo.err1Seq[0] = 0;
            algoArgs.err1N = 0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            CheckError.detectErr1(devInfo, algoArgs, debug, 1);

            assertEquals(0.0, debug.err1CurrentAvgDiff, EPS);
        }

        @Test
        @DisplayName("avg_diff computed from consecutive tran_5min values")
        void avgDiffComputedCorrectly() {
            devInfo.err1Seq[0] = 0;
            algoArgs.err1N = 0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];
            debug.tranInA5min = 50.0;

            CheckError.detectErr1(devInfo, algoArgs, debug, 1);
            // stored tran_5min=50

            debug.tranInA5min = 55.0;
            CheckError.detectErr1(devInfo, algoArgs, debug, 2);

            assertEquals(5.0, debug.err1CurrentAvgDiff, EPS);
        }

        @Test
        @DisplayName("first epoch n=1: th_diff fields become NaN")
        void firstEpochThDiffNaN() {
            devInfo.err1Seq[0] = 0;
            algoArgs.err1Isfirst0 = 0; // first epoch
            algoArgs.err1N = 0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            CheckError.detectErr1(devInfo, algoArgs, debug, 1);

            assertTrue(Double.isNaN(algoArgs.err1ThDiff1));
            assertTrue(Double.isNaN(algoArgs.err1ThDiff2));
            assertTrue(Double.isNaN(algoArgs.err1ThDiff));
        }

        @Test
        @DisplayName("second epoch n=1: only th_diff2 goes NaN")
        void secondEpochThDiff2NaN() {
            devInfo.err1Seq[0] = 0;
            algoArgs.err1Isfirst0 = 1; // second epoch
            algoArgs.err1N = 0;
            algoArgs.err1ThDiff1 = 42.0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            CheckError.detectErr1(devInfo, algoArgs, debug, 1);

            assertEquals(42.0, algoArgs.err1ThDiff1, EPS, "th_diff1 frozen in second epoch");
            assertTrue(Double.isNaN(algoArgs.err1ThDiff2), "th_diff2 goes NaN");
        }
    }

    // ======================================================================
    // err2: rate-of-change / delay error
    // ======================================================================

    @Nested
    @DisplayName("err2 — rate-of-change / delay error")
    class Err2Test {

        @Test
        @DisplayName("all debug fields NaN before activation threshold")
        void allNanBeforeActivation() {
            devInfo.err2Seq[2] = 24;

            int bits = CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 10);

            assertEquals(0, bits);
            assertTrue(Double.isNaN(debug.err2DelayRoc));
            assertTrue(Double.isNaN(debug.err2DelaySlopeSharp));
            assertTrue(Double.isNaN(debug.err2DelayRocCummax));
            assertTrue(Double.isNaN(debug.err2Cummax));
            assertTrue(Double.isNaN(debug.err2CrtCv));
        }

        @Test
        @DisplayName("glucose window shifts correctly each call")
        void glucoseWindowShifts() {
            devInfo.err2Seq[2] = 100; // inactive
            algoArgs.err2CummaxForetime = new double[100];

            // Set initial values
            for (int i = 0; i < 6; i++) {
                algoArgs.err2CummaxForetime[i] = (i + 1) * 10.0;
            }

            CheckError.detectErr2(devInfo, algoArgs, debug, 200.0, 1);

            assertEquals(20.0, algoArgs.err2CummaxForetime[0], EPS);
            assertEquals(60.0, algoArgs.err2CummaxForetime[4], EPS);
            assertEquals(200.0, algoArgs.err2CummaxForetime[5], EPS);
        }

        @Test
        @DisplayName("roc is 0 on first activation step")
        void rocZeroOnFirstStep() {
            devInfo.err2Seq[2] = 5;

            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 5);

            assertEquals(0.0, debug.err2DelayRoc, EPS);
        }

        @Test
        @DisplayName("roc computed from consecutive round(glucose) / 5.0")
        void rocComputed() {
            devInfo.err2Seq[2] = 5;

            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 5);
            CheckError.detectErr2(devInfo, algoArgs, debug, 125.0, 6);

            // roc = (round(125) - round(100)) / 5.0 = 25/5 = 5.0
            assertEquals(5.0, debug.err2DelayRoc, EPS);
        }

        @Test
        @DisplayName("cumulative maxima track absolute values")
        void cummaxTracking() {
            devInfo.err2Seq[2] = 5;

            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 5);
            assertEquals(0.0, debug.err2DelayRocCummax, EPS);
            assertEquals(100.0, debug.err2DelayGluCummax, EPS);

            CheckError.detectErr2(devInfo, algoArgs, debug, 120.0, 6);
            assertEquals(4.0, debug.err2DelayRocCummax, EPS); // |20/5| = 4
            assertEquals(120.0, debug.err2DelayGluCummax, EPS);

            // Lower glucose: cummax should NOT decrease
            CheckError.detectErr2(devInfo, algoArgs, debug, 110.0, 7);
            assertEquals(4.0, debug.err2DelayRocCummax, EPS, "cummax should not decrease");
            assertEquals(120.0, debug.err2DelayGluCummax, EPS, "glu cummax stays");
        }

        @Test
        @DisplayName("CRT does not fire with normal glucose values")
        void crtNoFireNormalGlucose() {
            devInfo.err2Seq[2] = 5;
            devInfo.maximumValue = 500.0f;
            devInfo.err2Cummax = 1;

            // glucose=100 < maximumValue*cummax (500*1=500) + cummax (1) = 501
            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 5);

            assertEquals(0, debug.err2CrtCurrent[1]);
            assertEquals(0, debug.err2Condi[0]);
            assertEquals(0, debug.err2Condi[1]);
        }

        @Test
        @DisplayName("CRT current[1] fires when both current and lagged glucose exceed threshold")
        void crtCurrentFiresOnHighGlucose() {
            devInfo.err2Seq[2] = 5;
            devInfo.maximumValue = 500.0f;
            devInfo.err2Cummax = 1;
            devInfo.err2Seq[1] = 48;
            devInfo.kalmanDeltaT = 5;
            devInfo.err2Glu = 100.0f;

            // gluThrCurr = 500*1 + 1 = 501
            // gluThrBase = 500*1 = 500
            // gluThrG1 = 500*1 + 100/1 = 600
            // Fill errGluArr with high values
            java.util.Arrays.fill(algoArgs.errGluArr, 700.0);

            CheckError.detectErr2(devInfo, algoArgs, debug, 700.0, 5);

            assertEquals(1, debug.err2CrtCurrent[1], "crt_c1 should fire");
        }

        @Test
        @DisplayName("CRT combined condition fires when both current and glu criteria met")
        void crtCombinedFires() {
            devInfo.err2Seq[2] = 5;
            devInfo.maximumValue = 500.0f;
            devInfo.err2Cummax = 1;
            devInfo.err2Seq[1] = 48;
            devInfo.kalmanDeltaT = 5;
            devInfo.err2Glu = 100.0f;
            devInfo.err2StartSeq = 3; // so crtG0Threshold = 1

            // Fill all glucose values high enough
            java.util.Arrays.fill(algoArgs.errGluArr, 700.0);

            int bits = CheckError.detectErr2(devInfo, algoArgs, debug, 700.0, 5);

            // crt_c1=1 (both current and lagged > threshold)
            // crt_g1=1 (both current and lagged > gluThrG1=600)
            // condi[1] = crt_c1 && crt_g1 = 1
            assertEquals(1, debug.err2Condi[1]);
            assertEquals(2, bits, "err2 bit should be set");
        }

        @Test
        @DisplayName("err2_cummax tracks tran_inA_5min from err2_start_seq")
        void err2CummaxTracking() {
            devInfo.err2Seq[2] = 5;
            devInfo.err2StartSeq = 10;

            debug.tranInA5min = 50.0;
            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 8);
            assertTrue(Double.isNaN(debug.err2Cummax), "before start_seq: NaN");

            debug.tranInA5min = 50.0;
            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 10);
            assertEquals(50.0, debug.err2Cummax, EPS, "first at start_seq");

            debug.tranInA5min = 60.0;
            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 11);
            assertEquals(60.0, debug.err2Cummax, EPS, "cummax increases");

            debug.tranInA5min = 40.0;
            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 12);
            assertEquals(60.0, debug.err2Cummax, EPS, "cummax does not decrease");
        }

        @Test
        @DisplayName("slope_sharp computed from linear regression of sliding window")
        void slopeSharpRegression() {
            devInfo.err2Seq[2] = 5;

            // Fill window with known linear: [10, 20, 30, 40, 50, 60]
            for (int i = 0; i < 6; i++) {
                algoArgs.err2CummaxForetime[i] = (i + 1) * 10.0;
            }

            // seq=6 >= 6 => slopeN=6, start=0
            // x=[0,1,2,3,4,5], y=[10,20,30,40,50,60]
            // slope = 10.0
            CheckError.detectErr2(devInfo, algoArgs, debug, 70.0, 6);

            assertEquals(10.0, debug.err2DelaySlopeSharp, EPS);
        }

        @Test
        @DisplayName("delay fields inactive (NaN)")
        void delayFieldsInactive() {
            devInfo.err2Seq[2] = 5;

            CheckError.detectErr2(devInfo, algoArgs, debug, 100.0, 5);

            assertTrue(Double.isNaN(debug.err2DelayRevisedValue));
            assertTrue(Double.isNaN(debug.err2DelayRocTrimmedMean));
            assertTrue(Double.isNaN(debug.err2DelaySlopeTrimmedMean));
            assertTrue(Double.isNaN(debug.err2DelayGluTrimmedMean));
            assertEquals(0, debug.err2DelayFlag);
        }
    }

    // ======================================================================
    // err4: signal quality
    // ======================================================================

    @Nested
    @DisplayName("err4 — signal quality")
    class Err4Test {

        @Test
        @DisplayName("seq=1 initializes min and sets range/minDiff to NaN")
        void seq1Initialization() {
            debug.tranInA5min = 42.0;

            CheckError.detectErr4(devInfo, algoArgs, debug, 1);

            assertEquals(42.0, debug.err4Min, EPS);
            assertTrue(Double.isNaN(debug.err4Range));
            assertTrue(Double.isNaN(debug.err4MinDiff));
            assertEquals(42.0, algoArgs.err4InA[0], EPS, "stored for next step");
        }

        @Test
        @DisplayName("running min tracks minimum tran_5min")
        void runningMinTracked() {
            debug.tranInA5min = 50.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 1);

            debug.tranInA5min = 40.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 2);
            assertEquals(40.0, debug.err4Min, EPS);

            debug.tranInA5min = 45.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 3);
            assertEquals(40.0, debug.err4Min, EPS, "min stays at 40");
        }

        @Test
        @DisplayName("err4_range is consecutive difference (not max-min)")
        void rangeIsConsecutiveDifference() {
            debug.tranInA5min = 50.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 1);

            debug.tranInA5min = 53.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 2);
            assertEquals(3.0, debug.err4Range, EPS);

            debug.tranInA5min = 48.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 3);
            assertEquals(-5.0, debug.err4Range, EPS, "can be negative");
        }

        @Test
        @DisplayName("err4_min_diff: 0 before err345_seq2, then tracked")
        void minDiffTracking() {
            devInfo.err345Seq2 = 5;

            debug.tranInA5min = 50.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 1);

            // seq=2: before err345_seq2
            debug.tranInA5min = 53.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 2);
            assertEquals(0.0, debug.err4MinDiff, EPS, "0 before threshold");

            // seq=3, 4: still before
            debug.tranInA5min = 48.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 3);
            assertEquals(0.0, debug.err4MinDiff, EPS);

            debug.tranInA5min = 40.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 4);
            assertEquals(0.0, debug.err4MinDiff, EPS);

            // seq=5: starts tracking, diff = |40 - 40| = 0
            debug.tranInA5min = 40.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 5);
            assertEquals(0.0, debug.err4MinDiff, EPS, "diff at seq=5");

            // seq=6: diff = |45 - 40| = 5, min_diff stays at 0
            debug.tranInA5min = 45.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 6);
            assertEquals(0.0, debug.err4MinDiff, EPS, "min_diff stays at 0");
        }

        @Test
        @DisplayName("err4_min_diff tracks signed drop on new minimum")
        void minDiffDecreases() {
            devInfo.err345Seq2 = 2;

            // seq=1: init min=50
            debug.tranInA5min = 50.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 1);

            // seq=2: tran5min=55 > min=50, no new minimum -> min_diff=0
            debug.tranInA5min = 55.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 2);
            assertEquals(0.0, debug.err4MinDiff, EPS, "no new minimum");

            // seq=3: tran5min=53 > min=50, no new minimum -> min_diff=0
            debug.tranInA5min = 53.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 3);
            assertEquals(0.0, debug.err4MinDiff, EPS, "no new minimum");

            // seq=4: tran5min=45 < min=50, new minimum -> min_diff = 45-50 = -5
            debug.tranInA5min = 45.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 4);
            assertEquals(-5.0, debug.err4MinDiff, EPS, "new min: signed drop");

            // seq=5: tran5min=43 < min=45, new minimum -> min_diff = 43-45 = -2
            debug.tranInA5min = 43.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 5);
            assertEquals(-2.0, debug.err4MinDiff, EPS, "new min: signed drop");

            // seq=6: tran5min=50 > min=43, no new minimum -> min_diff=0
            debug.tranInA5min = 50.0;
            CheckError.detectErr4(devInfo, algoArgs, debug, 6);
            assertEquals(0.0, debug.err4MinDiff, EPS, "no new minimum");
        }

        @Test
        @DisplayName("err4 never fires (always 0)")
        void neverFires() {
            debug.tranInA5min = 0.0;
            int bits = CheckError.detectErr4(devInfo, algoArgs, debug, 1);

            assertEquals(0, bits);
            assertEquals(0, debug.errorCode4);
        }
    }

    // ======================================================================
    // err128: CGM noise revision
    // ======================================================================

    @Nested
    @DisplayName("err128 — CGM noise revision")
    class Err128Test {

        @Test
        @DisplayName("flag is 0, revised_value = tran_inA_5min, normal = NaN")
        void basicBehavior() {
            debug.tranInA5min = 77.5;

            CheckError.detectErr128(debug);

            assertEquals(0, debug.err128Flag);
            assertEquals(77.5, debug.err128RevisedValue, EPS);
            assertTrue(Double.isNaN(debug.err128Normal));
        }
    }

    // ======================================================================
    // err16: sensor drift / calibration consistency
    // ======================================================================

    @Nested
    @DisplayName("err16 — sensor drift")
    class Err16Test {

        @Test
        @DisplayName("NaN output before activation seq")
        void nanBeforeActivation() {
            devInfo.err345Seq4[2] = 12;

            int bits = CheckError.detectErr16(devInfo, algoArgs, debug, 11);

            assertEquals(0, bits);
            assertTrue(Double.isNaN(debug.err16CgmPlasma));
            assertTrue(Double.isNaN(debug.err16CgmIsfSmooth));
        }

        @Test
        @DisplayName("computes smoothed plasma and ISF from DFT smoother")
        void computesSmoothedValues() {
            devInfo.err345Seq4[2] = 12;
            devInfo.slope100 = 120.0f; // conv_factor = 1.2

            // Fill errGluArr last 12 with known values
            for (int i = 0; i < 12; i++) {
                algoArgs.errGluArr[276 + i] = 100.0;
            }
            // Fill err128 noise buffer last 12
            for (int i = 0; i < 12; i++) {
                algoArgs.err128CgmCNoiseRevisedValue[24 + i] = 60.0;
            }

            CheckError.detectErr16(devInfo, algoArgs, debug, 12);

            // Uniform input => smoother output = input
            // plasma = round(100) = 100
            // ISF_smooth = round(60 / 1.2) = round(50) = 50
            assertEquals(100.0, debug.err16CgmPlasma, EPS);
            assertEquals(50.0, debug.err16CgmIsfSmooth, EPS);
        }

        @Test
        @DisplayName("NaN output when all input zeros")
        void nanOnAllZeros() {
            devInfo.err345Seq4[2] = 12;
            devInfo.slope100 = 100.0f;

            // Both buffers are all zeros (default)

            CheckError.detectErr16(devInfo, algoArgs, debug, 12);

            assertTrue(Double.isNaN(debug.err16CgmPlasma), "zero input => NaN plasma");
            assertTrue(Double.isNaN(debug.err16CgmIsfSmooth), "zero input => NaN ISF");
        }

        @Test
        @DisplayName("err16 never fires (always 0)")
        void neverFires() {
            devInfo.err345Seq4[2] = 12;

            for (int i = 0; i < 12; i++) {
                algoArgs.errGluArr[276 + i] = 100.0;
                algoArgs.err128CgmCNoiseRevisedValue[24 + i] = 50.0;
            }

            int bits = CheckError.detectErr16(devInfo, algoArgs, debug, 12);

            assertEquals(0, bits);
            assertEquals(0, debug.errorCode16);
        }
    }

    // ======================================================================
    // Integration: full checkError
    // ======================================================================

    @Nested
    @DisplayName("checkError — full integration")
    class FullIntegrationTest {

        @Test
        @DisplayName("normal reading returns 0 (no errors)")
        void normalReadingNoErrors() {
            debug.tranInA5min = 50.0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            int errcode = CheckError.checkError(devInfo, algoArgs, debug,
                    100.0, 50.0, 1, 1000L, 0);

            assertEquals(0, errcode);
            assertEquals(1, debug.calAvailableFlag);
        }

        @Test
        @DisplayName("timing gap sets bit 5 (value 32)")
        void timingGapSetsErr32() {
            algoArgs.err32PrevTime = 1000L;
            debug.tranInA5min = 50.0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            // dt = 2001 - 1000 = 1001 > 15*60=900
            int errcode = CheckError.checkError(devInfo, algoArgs, debug,
                    100.0, 50.0, 5, 2001L, 0);

            assertEquals(32, errcode & 32, "err32 bit should be set");
        }

        @Test
        @DisplayName("FIFO arrays are maintained each call")
        void fifoMaintained() {
            debug.tranInA5min = 77.0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];
            algoArgs.errGluArr[287] = 42.0;

            CheckError.checkError(devInfo, algoArgs, debug,
                    150.0, 50.0, 1, 1000L, 0);

            assertEquals(42.0, algoArgs.errGluArr[286], EPS, "old [287] shifted to [286]");
            assertEquals(150.0, algoArgs.errGluArr[287], EPS, "round(150.0) appended");
            assertEquals(77.0, algoArgs.err128CgmCNoiseRevisedValue[35], EPS);
        }

        @Test
        @DisplayName("err128 fields set correctly in integration")
        void err128InIntegration() {
            debug.tranInA5min = 55.0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            CheckError.checkError(devInfo, algoArgs, debug,
                    100.0, 55.0, 1, 1000L, 0);

            assertEquals(0, debug.err128Flag);
            assertEquals(55.0, debug.err128RevisedValue, EPS);
            assertTrue(Double.isNaN(debug.err128Normal));
        }

        @Test
        @DisplayName("multiple error bits can be OR'd together")
        void multipleErrorBits() {
            // Set up for err32 to fire
            algoArgs.err32PrevTime = 1000L;
            debug.tranInA5min = 50.0;
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            // err32 fires (dt > threshold2)
            // err2 CRT fires (high glucose)
            devInfo.err2Seq[2] = 2;
            devInfo.err2StartSeq = 2;
            devInfo.err2Cummax = 1;
            devInfo.maximumValue = 500.0f;
            devInfo.err2Glu = 100.0f;
            devInfo.kalmanDeltaT = 5;
            java.util.Arrays.fill(algoArgs.errGluArr, 700.0);

            int errcode = CheckError.checkError(devInfo, algoArgs, debug,
                    700.0, 50.0, 5, 2001L, 0);

            // err32 (32) + err2 (2) = 34
            assertTrue((errcode & 32) != 0, "err32 should be set");
            assertTrue((errcode & 2) != 0, "err2 should be set");
        }

        @Test
        @DisplayName("sequential calls accumulate state correctly")
        void sequentialCallsAccumulate() {
            debug.tranInA = new double[30];
            debug.tranInA1min = new double[5];

            for (int seq = 1; seq <= 10; seq++) {
                debug.tranInA5min = 50.0 + seq;
                int errcode = CheckError.checkError(devInfo, algoArgs, debug,
                        100.0 + seq, 50.0, seq, 1000L + seq * 300L, 0);

                assertEquals(0, errcode, "no errors in normal operation at seq=" + seq);
            }

            // After 10 calls, last errGluArr should have round(110)
            assertEquals(110.0, algoArgs.errGluArr[287], EPS);
        }
    }
}
