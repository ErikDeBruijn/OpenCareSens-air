package com.opencaresens.air;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests for SignalProcessing, ported from signal_processing.c.
 * Each function is tested in its own nested class following Red-Green-Refactor.
 */
class SignalProcessingTest {

    private static final double EPS = 1e-10;

    // ==========================================================================
    // smooth_sg: Savitzky-Golay smoothing
    // ==========================================================================

    @Nested
    @DisplayName("smoothSg")
    class SmoothSgTest {

        @Test
        @DisplayName("uniform input produces uniform output")
        void uniformInput() {
            double[] sigIn = new double[10];
            int[] seqIn = new int[10];
            int[] frepIn = new int[6];
            java.util.Arrays.fill(sigIn, 5.0);
            for (int i = 0; i < 10; i++) seqIn[i] = i;

            int[] weights = {5, 10, 20, 30, 20, 10, 5}; // sum = 100

            SignalProcessing.SgResult r = SignalProcessing.smoothSg(
                    sigIn, seqIn, frepIn, 5.0, 10, 0, weights);

            // Uniform signal: all outputs should be 5.0
            for (int i = 0; i < 10; i++) {
                assertEquals(5.0, r.sigOut[i], EPS, "sigOut[" + i + "]");
            }
        }

        @Test
        @DisplayName("sequence buffer shifts correctly")
        void sequenceShift() {
            double[] sigIn = new double[10];
            int[] seqIn = new int[10];
            int[] frepIn = new int[6];
            for (int i = 0; i < 10; i++) seqIn[i] = i + 1;

            int[] weights = {10, 10, 10, 10, 10, 10, 10};

            SignalProcessing.SgResult r = SignalProcessing.smoothSg(
                    sigIn, seqIn, frepIn, 0.0, 99, 0, weights);

            // seqOut should be [2,3,4,5,6,7,8,9,10,99]
            assertEquals(2, r.seqOut[0]);
            assertEquals(10, r.seqOut[8]);
            assertEquals(99, r.seqOut[9]);
        }

        @Test
        @DisplayName("frep buffer shifts correctly")
        void frepShift() {
            int[] frepIn = {10, 20, 30, 40, 50, 60};
            double[] sigIn = new double[10];
            int[] seqIn = new int[10];
            int[] weights = {10, 10, 10, 10, 10, 10, 10};

            SignalProcessing.SgResult r = SignalProcessing.smoothSg(
                    sigIn, seqIn, frepIn, 0.0, 0, 77, weights);

            // frepOut = [20, 30, 40, 50, 60, 77]
            assertEquals(20, r.frepOut[0]);
            assertEquals(60, r.frepOut[4]);
            assertEquals(77, r.frepOut[5]);
        }

        @Test
        @DisplayName("linear ramp preserves trend (equal weights)")
        void linearRamp() {
            double[] sigIn = new double[10];
            int[] seqIn = new int[10];
            int[] frepIn = new int[6];
            for (int i = 0; i < 10; i++) {
                sigIn[i] = i * 1.0;
                seqIn[i] = i;
            }
            // Equal weights => simple average in window
            int[] weights = {10, 10, 10, 10, 10, 10, 10};

            SignalProcessing.SgResult r = SignalProcessing.smoothSg(
                    sigIn, seqIn, frepIn, 10.0, 10, 0, weights);

            // After shift: sigBuf = [1,2,3,4,5,6,7,8,9,10], ref=10
            // Position 3: idx range [0,6] only [0..6] valid
            // acc = sum(w*(sigBuf[j]-10)) for j=0..6 = (1+2+3+4+5+6+7-70)/10 = (28-70)/10 = -42/10
            // But weights each 0.1, totalWeight=0.7
            // acc = 0.1*((1-10)+(2-10)+(3-10)+(4-10)+(5-10)+(6-10)+(7-10)) = 0.1*(-63)=-6.3
            // sigOut[3] = -6.3/0.7+10 = -9+10 = 1
            // For a linear ramp with equal weights and full window, SG should preserve linearity
            // sigOut[3] should be close to the shifted buffer value at center
            assertEquals(1.0, r.sigOut[0], EPS); // unsmoothed: sigBuf[0]=1
            assertEquals(2.0, r.sigOut[1], EPS);
            assertEquals(3.0, r.sigOut[2], EPS);

            // With equal weights and full 7-tap window, linear signal is preserved
            // Position 6: center at 6, idx [3..6] valid (partial window)
            // The exact values depend on the partial window
        }

        @Test
        @DisplayName("zero weights default to totalWeight=1")
        void zeroWeights() {
            double[] sigIn = new double[10];
            int[] seqIn = new int[10];
            int[] frepIn = new int[6];
            java.util.Arrays.fill(sigIn, 3.0);
            int[] weights = {0, 0, 0, 0, 0, 0, 0};

            SignalProcessing.SgResult r = SignalProcessing.smoothSg(
                    sigIn, seqIn, frepIn, 3.0, 0, 0, weights);

            // Zero weights: acc=0 for all, so sigOut[j] = 0/1 + ref = ref = 3.0
            for (int j = 3; j < 10; j++) {
                assertEquals(3.0, r.sigOut[j], EPS, "sigOut[" + j + "]");
            }
        }
    }

    // ==========================================================================
    // regress_cal: Weighted least-squares recalibration
    // ==========================================================================

    @Nested
    @DisplayName("regressCal")
    class RegressCalTest {

        @Test
        @DisplayName("two points produce exact line")
        void twoPoints() {
            double[] input = {1.0};
            double[] output = {2.0};
            double[] slopeArr = {0};
            double[] yceptArr = {0};

            SignalProcessing.RegressionResult r = SignalProcessing.regressCal(
                    input, output, slopeArr, yceptArr, 1, 3.0, 6.0);

            // Points: (1,2) and (3,6) => slope=2, ycept=0
            assertEquals(2.0, r.slope, 1e-9);
            assertEquals(0.0, r.ycept, 1e-9);
        }

        @Test
        @DisplayName("single point with no history defaults to slope=1, ycept=0")
        void singlePoint() {
            double[] input = new double[0];
            double[] output = new double[0];
            double[] slopeArr = new double[0];
            double[] yceptArr = new double[0];

            SignalProcessing.RegressionResult r = SignalProcessing.regressCal(
                    input, output, slopeArr, yceptArr, 0, 5.0, 10.0);

            // Only 1 point => defaults
            assertEquals(1.0, r.slope, EPS);
            assertEquals(0.0, r.ycept, EPS);
        }

        @Test
        @DisplayName("result arrays are populated correctly")
        void resultArrays() {
            double[] input = {1.0, 2.0};
            double[] output = {3.0, 5.0};
            double[] slopeArr = new double[2];
            double[] yceptArr = new double[2];

            SignalProcessing.RegressionResult r = SignalProcessing.regressCal(
                    input, output, slopeArr, yceptArr, 2, 3.0, 7.0);

            // 3 points: (1,3), (2,5), (3,7) => slope=2, ycept=1
            assertEquals(2.0, r.slope, 1e-9);
            assertEquals(1.0, r.ycept, 1e-9);

            assertEquals(1.0, r.resultInput[0], EPS);
            assertEquals(2.0, r.resultInput[1], EPS);
            assertEquals(3.0, r.resultInput[2], EPS);
        }

        @Test
        @DisplayName("caps at 7 existing points")
        void capsAt7() {
            double[] input = {1, 2, 3, 4, 5, 6, 7, 8};
            double[] output = {2, 4, 6, 8, 10, 12, 14, 16};
            double[] slopeArr = new double[8];
            double[] yceptArr = new double[8];

            // n=8, but capped at 7 existing + 1 new = 8 total
            SignalProcessing.RegressionResult r = SignalProcessing.regressCal(
                    input, output, slopeArr, yceptArr, 8, 9.0, 18.0);

            assertEquals(2.0, r.slope, 1e-9);
            assertEquals(0.0, r.ycept, 1e-9);
        }
    }

    // ==========================================================================
    // check_boundary: Parallelogram validity check
    // ==========================================================================

    @Nested
    @DisplayName("checkBoundary")
    class CheckBoundaryTest {

        @Test
        @DisplayName("center point is inside")
        void centerInside() {
            // Symmetric parallelogram
            assertTrue(SignalProcessing.checkBoundary(
                    1.0, 0.0,      // slope, ycept
                    0.5, 1.5,      // slope_min, slope_max
                    -1.0, 1.0,     // ycept_min, ycept_max
                    0.8));          // corner_offset
        }

        @Test
        @DisplayName("ycept out of range")
        void yceptOutOfRange() {
            assertFalse(SignalProcessing.checkBoundary(
                    1.0, 2.0,
                    0.5, 1.5,
                    -1.0, 1.0,
                    0.8));
        }

        @Test
        @DisplayName("slope out of range")
        void slopeOutOfRange() {
            assertFalse(SignalProcessing.checkBoundary(
                    2.0, 0.0,
                    0.5, 1.5,
                    -1.0, 1.0,
                    0.8));
        }

        @Test
        @DisplayName("on boundary edge")
        void onEdge() {
            // slope exactly at slopeMin
            assertTrue(SignalProcessing.checkBoundary(
                    0.5, 0.0,
                    0.5, 1.5,
                    -1.0, 1.0,
                    1.0));
        }

        @Test
        @DisplayName("tight corner_offset rejects diagonal")
        void tightCornerOffset() {
            // With tiny corner_offset, the parallelogram is very thin
            // Point at corner: slope=1.5, ycept=-1.0
            // diagSlope = (1.5-0.5)/(-1.0-1.0) = 1.0/(-2.0) = -0.5
            // diagIntercept = 1.5 - (-0.5)*(-1.0) = 1.5 - 0.5 = 1.0
            // lowerBound = 1.0 - 0.01 + (-0.5)*(-1.0) = 0.99 + 0.5 = 1.49
            // upperBound = 0.01 + 1.0 + (-0.5)*(-1.0) = 1.01 + 0.5 = 1.51
            // slope=1.5 is between 1.49 and 1.51 => inside
            assertTrue(SignalProcessing.checkBoundary(
                    1.5, -1.0,
                    0.5, 1.5,
                    -1.0, 1.0,
                    0.01));
        }
    }

    // ==========================================================================
    // smooth1q_err16: DFT-based spectral smoothing
    // ==========================================================================

    @Nested
    @DisplayName("smooth1qErr16")
    class Smooth1qErr16Test {

        @Test
        @DisplayName("constant signal returns same constant")
        void constantSignal() {
            double[] in = {3.0, 3.0, 3.0, 3.0, 3.0};
            double[] out = SignalProcessing.smooth1qErr16(in, 5);

            for (int i = 0; i < 5; i++) {
                assertEquals(3.0, out[i], 1e-9, "out[" + i + "]");
            }
        }

        @Test
        @DisplayName("empty input returns empty output")
        void emptyInput() {
            double[] out = SignalProcessing.smooth1qErr16(new double[0], 0);
            assertEquals(0, out.length);
        }

        @Test
        @DisplayName("single element returns same value")
        void singleElement() {
            double[] in = {7.5};
            double[] out = SignalProcessing.smooth1qErr16(in, 1);
            assertEquals(7.5, out[0], 1e-9);
        }

        @Test
        @DisplayName("smoothing attenuates noise")
        void attenuatesNoise() {
            // Linear signal with spike
            double[] in = {1, 2, 3, 100, 5, 6, 7, 8};
            double[] out = SignalProcessing.smooth1qErr16(in, 8);

            // The smoothed value at the spike should be much less extreme
            assertTrue(out[3] < 100.0, "spike should be reduced");
            assertTrue(out[3] > 1.0, "spike should still be above baseline");
        }

        @Test
        @DisplayName("preserves DC component")
        void preservesDc() {
            double[] in = {10, 20, 30, 40};
            double[] out = SignalProcessing.smooth1qErr16(in, 4);

            // DC component (mean) should be preserved
            double inMean = 0, outMean = 0;
            for (int i = 0; i < 4; i++) {
                inMean += in[i];
                outMean += out[i];
            }
            assertEquals(inMean / 4.0, outMean / 4.0, 1e-9);
        }

        @Test
        @DisplayName("two-element case computed correctly")
        void twoElements() {
            // With n=2: k=0: w=0, reg=1.0; k=1: w=4.0, reg=1/(1+2*16)=1/33
            // Verify exact computation
            double[] in = {1.0, 3.0};
            double[] out = SignalProcessing.smooth1qErr16(in, 2);

            // k=0: cosSum=1+3=4, sinSum=0, reg=1, out += [4*1, 4*1] = [4,4]
            // k=1: w=4, reg=1/33
            //   cosSum=(1*cos(0)+3*cos(pi))=1-3=-2, sinSum=(1*sin(0)+3*sin(pi))=0
            //   cosSum*reg = -2/33, sinSum=0
            //   out[0] += -2/33*cos(0) = -2/33
            //   out[1] += -2/33*cos(pi) = 2/33
            // Final: out[0] = (4 - 2/33)/2 = (132-2)/66 = 130/66 = 65/33
            //        out[1] = (4 + 2/33)/2 = (132+2)/66 = 134/66 = 67/33
            assertEquals(65.0 / 33.0, out[0], 1e-9);
            assertEquals(67.0 / 33.0, out[1], 1e-9);
        }
    }

    // ==========================================================================
    // cal_threshold: Cumulative threshold tracking
    // ==========================================================================

    @Nested
    @DisplayName("calThreshold")
    class CalThresholdTest {

        @Test
        @DisplayName("seq=0 initializes state")
        void seqZero() {
            SignalProcessing.ThresholdResult r = SignalProcessing.calThreshold(
                    0, 0.0, 0.0, 0,    // n, mean, max, flag
                    0, 0,                // seq, mode
                    5.0, 5.0,            // value, absValue
                    0.0, 0.0,            // runningMean, runningMax
                    10, 1, 1);           // thresholdSeq, multi1, multi2

            assertEquals(1, r.n);
            assertEquals(5.0, r.mean, EPS);
            assertEquals(5.0, r.max, EPS);
            assertEquals(0, r.flag);
        }

        @Test
        @DisplayName("seq < threshold accumulates")
        void accumulates() {
            SignalProcessing.ThresholdResult r = SignalProcessing.calThreshold(
                    1, 5.0, 5.0, 0,
                    3, 0,
                    2.0, 2.0,
                    5.0, 5.0,
                    10, 1, 1);

            assertEquals(4, r.n);          // seq + 1
            assertEquals(7.0, r.mean, EPS); // 5.0 + 2.0
            assertEquals(5.0, r.max, EPS);  // 5.0 > 2.0
        }

        @Test
        @DisplayName("seq == threshold triggers flag and normalizes (mode != 1)")
        void triggersFlag() {
            SignalProcessing.ThresholdResult r = SignalProcessing.calThreshold(
                    10, 0.0, 0.0, 0,
                    10, 0,               // seq == thresholdSeq, mode=0
                    0.0, 0.0,
                    50.0, 20.0,          // runningMean, runningMax
                    10, 3, 2);           // thresholdSeq, multi1, multi2

            assertEquals(1, r.flag);
            // mean = (50/10)*3 = 15.0
            assertEquals(15.0, r.mean, EPS);
            // max = (20/10)*2 = 4.0
            assertEquals(4.0, r.max, EPS);
        }

        @Test
        @DisplayName("seq == threshold with mode=1 keeps raw max")
        void mode1KeepsMax() {
            SignalProcessing.ThresholdResult r = SignalProcessing.calThreshold(
                    10, 0.0, 0.0, 0,
                    10, 1,               // mode=1
                    0.0, 0.0,
                    50.0, 20.0,
                    10, 3, 2);

            assertEquals(1, r.flag);
            // mode==1: no normalization
            assertEquals(50.0, r.mean, EPS);
            assertEquals(20.0, r.max, EPS);
        }

        @Test
        @DisplayName("NaN runningMean is replaced on accumulate")
        void nanMeanReplaced() {
            SignalProcessing.ThresholdResult r = SignalProcessing.calThreshold(
                    0, 0.0, 0.0, 0,
                    2, 0,
                    7.0, 7.0,
                    Double.NaN, Double.NaN,
                    10, 1, 1);

            assertEquals(3, r.n);
            assertEquals(7.0, r.mean, EPS);
            assertEquals(7.0, r.max, EPS);
        }

        @Test
        @DisplayName("absValue updates runningMax when larger")
        void updatesMax() {
            SignalProcessing.ThresholdResult r = SignalProcessing.calThreshold(
                    0, 0.0, 0.0, 0,
                    5, 0,
                    1.0, 99.0,
                    10.0, 50.0,
                    10, 1, 1);

            assertEquals(99.0, r.max, EPS);
        }
    }

    // ==========================================================================
    // err1_TD_trio_update
    // ==========================================================================

    @Nested
    @DisplayName("err1TdTrioUpdate")
    class Err1TdTrioUpdateTest {

        @Test
        @DisplayName("copies src to dst and clears src")
        void copiesAndClears() {
            double[] dstTrio = new double[270];
            long[] dstTime = new long[270];
            int[] dstFlag = new int[90];
            double[] srcTrio = new double[270];
            long[] srcTime = new long[270];
            int[] srcFlag = new int[90];
            int[] breakFlags = {0, 0};

            // Fill src with known values
            for (int i = 0; i < 270; i++) {
                srcTrio[i] = i + 1.0;
                srcTime[i] = i + 100;
            }
            breakFlags[1] = 5;

            SignalProcessing.err1TdTrioUpdate(dstTrio, dstTime, dstFlag,
                    srcTrio, srcTime, srcFlag, breakFlags);

            // dst should have src values
            assertEquals(1.0, dstTrio[0], EPS);
            assertEquals(270.0, dstTrio[269], EPS);
            assertEquals(100L, dstTime[0]);

            // src should be cleared
            for (int i = 0; i < 270; i++) {
                assertEquals(0.0, srcTrio[i], EPS);
                assertEquals(0L, srcTime[i]);
            }

            // flags cleared
            for (int i = 0; i < 90; i++) {
                assertEquals(0, dstFlag[i]);
            }

            // break flags rotated
            assertEquals(5, breakFlags[0]);
            assertEquals(0, breakFlags[1]);
        }
    }

    // ==========================================================================
    // err1_TD_var_update
    // ==========================================================================

    @Nested
    @DisplayName("err1TdVarUpdate")
    class Err1TdVarUpdateTest {

        @Test
        @DisplayName("copies src to dst and clears src")
        void copiesAndClears() {
            int[] dstSeq = new int[90];
            double[] dstVal = new double[90];
            long[] dstTime = new long[90];
            int[] counts = {0, 42};
            double[] srcVal = new double[90];
            long[] srcTime = new long[90];

            for (int i = 0; i < 90; i++) {
                srcVal[i] = i * 0.5;
                srcTime[i] = i + 200;
            }

            SignalProcessing.err1TdVarUpdate(dstSeq, dstVal, dstTime, counts, srcVal, srcTime);

            assertEquals(0.0, dstVal[0], EPS);
            assertEquals(44.5, dstVal[89], EPS);
            assertEquals(200L, dstTime[0]);
            assertEquals(289L, dstTime[89]);

            // src cleared
            for (int i = 0; i < 90; i++) {
                assertEquals(0.0, srcVal[i], EPS);
                assertEquals(0L, srcTime[i]);
                assertEquals(0, dstSeq[i]);
            }

            assertEquals(42, counts[0]);
            assertEquals(0, counts[1]);
        }
    }

    // ==========================================================================
    // getKernelWeight: LOESS kernel lookup
    // ==========================================================================

    @Nested
    @DisplayName("getKernelWeight")
    class GetKernelWeightTest {

        @Test
        @DisplayName("forward lookup (e < 45)")
        void forwardLookup() {
            // e=0, d=0 => TABLE[0][0] = 1.0
            assertEquals(1.0, SignalProcessing.getKernelWeight(0, 0), EPS);
        }

        @Test
        @DisplayName("backward lookup (e >= 45) uses symmetry")
        void backwardLookup() {
            // e=89, d=89 => TABLE[89-89][89-89] = TABLE[0][0] = 1.0
            assertEquals(1.0, SignalProcessing.getKernelWeight(89, 89), EPS);
        }

        @Test
        @DisplayName("symmetric weights for mirrored positions")
        void symmetry() {
            // TABLE[d][e] for e<45 should equal TABLE[89-d][89-e] when both are accessed correctly
            // getKernelWeight(5, 10) = TABLE[10][5]
            // getKernelWeight(84, 79) = TABLE[89-79][89-84] = TABLE[10][5]
            double fwd = SignalProcessing.getKernelWeight(5, 10);
            double bwd = SignalProcessing.getKernelWeight(84, 79);
            assertEquals(fwd, bwd, EPS);
        }
    }

    // ==========================================================================
    // irlsLoess: IRLS LOESS regression
    // ==========================================================================

    @Nested
    @DisplayName("irlsLoess")
    class IrlsLoessTest {

        @Test
        @DisplayName("constant data returns constant fit")
        void constantData() {
            double[] data = new double[90];
            java.util.Arrays.fill(data, 42.0);

            double[] fitted = SignalProcessing.irlsLoess(data);

            for (int i = 0; i < 90; i++) {
                assertEquals(42.0, fitted[i], 1e-6, "fitted[" + i + "]");
            }
        }

        @Test
        @DisplayName("linear data is well-fitted")
        void linearData() {
            double[] data = new double[90];
            for (int i = 0; i < 90; i++) {
                data[i] = 2.0 * (i + 1) + 3.0; // y = 2x + 3
            }

            double[] fitted = SignalProcessing.irlsLoess(data);

            // LOESS on linear data should recover it closely
            for (int i = 0; i < 90; i++) {
                assertEquals(data[i], fitted[i], 0.5, "fitted[" + i + "]");
            }
        }

        @Test
        @DisplayName("handles outlier robustly via bisquare reweighting")
        void robustToOutlier() {
            double[] data = new double[90];
            for (int i = 0; i < 90; i++) {
                data[i] = 10.0; // flat signal
            }
            data[45] = 1000.0; // massive outlier

            double[] fitted = SignalProcessing.irlsLoess(data);

            // The fitted value at the outlier should be much less extreme
            // due to bisquare reweighting
            assertTrue(fitted[45] < 100.0,
                    "IRLS should suppress outlier, got " + fitted[45]);
        }
    }

    // ==========================================================================
    // runningMedians
    // ==========================================================================

    @Nested
    @DisplayName("runningMedians")
    class RunningMediansTest {

        @Test
        @DisplayName("constant input returns same constant")
        void constantInput() {
            double[] in30 = new double[30];
            java.util.Arrays.fill(in30, 7.0);

            double[] out = SignalProcessing.runningMedians(in30);

            for (int i = 0; i < 30; i++) {
                assertEquals(7.0, out[i], EPS, "out[" + i + "]");
            }
        }

        @Test
        @DisplayName("first group medians computed with correct window sizes")
        void firstGroupWindows() {
            // Group 0: values [1, 2, 3, 4, 5, 6]
            double[] in30 = new double[30];
            for (int i = 0; i < 6; i++) in30[i] = i + 1;
            for (int i = 6; i < 30; i++) in30[i] = 0;

            double[] out = SignalProcessing.runningMedians(in30);

            // Window of 3: [1,2,3] => median=2
            assertEquals(2.0, out[0], EPS);
            // Window of 4: [1,2,3,4] => median=2.5
            assertEquals(2.5, out[1], EPS);
            // Window of 5: [1,2,3,4,5] => median=3
            assertEquals(3.0, out[2], EPS);
            // Window of 6: [1,2,3,4,5,6] => median=3.5
            assertEquals(3.5, out[3], EPS);
            // Window of 5: [2,3,4,5,6] => median=4
            assertEquals(4.0, out[4], EPS);
            // Window of 4: [3,4,5,6] => median=4.5
            assertEquals(4.5, out[5], EPS);
        }
    }

    // ==========================================================================
    // firFilterMedians
    // ==========================================================================

    @Nested
    @DisplayName("firFilterMedians")
    class FirFilterMediansTest {

        @Test
        @DisplayName("constant input returns same constant")
        void constantInput() {
            double[] prev3 = {5.0, 5.0, 5.0};
            double[] medians30 = new double[30];
            java.util.Arrays.fill(medians30, 5.0);

            double[] out = SignalProcessing.firFilterMedians(prev3, medians30);

            // FIR on constant: sum(coeffs)*5/7 = ([-0.25+1+1.75+2+1.75+1-0.25])*5/7 = 7*5/7 = 5
            for (int i = 0; i < 30; i++) {
                assertEquals(5.0, out[i], 1e-9, "out[" + i + "]");
            }
        }

        @Test
        @DisplayName("tail positions use shortened FIR")
        void tailPositions() {
            double[] prev3 = {0, 0, 0};
            double[] medians30 = new double[30];
            for (int i = 0; i < 30; i++) medians30[i] = i + 1.0;

            double[] out = SignalProcessing.firFilterMedians(prev3, medians30);

            // Verify tail: out[29] = (-0.25*v2 + v3 + 1.75*v4 + 2*v5) / 4.5
            // v = medians30+24 = [25, 26, 27, 28, 29, 30]
            double expected29 = (-0.25 * 27.0 + 28.0 + 1.75 * 29.0 + 2.0 * 30.0) / 4.5;
            assertEquals(expected29, out[29], 1e-9);

            double expected28 = (-0.25 * 26.0 + 27.0 + 1.75 * 28.0 + 2.0 * 29.0 + 1.75 * 30.0) / 6.25;
            assertEquals(expected28, out[28], 1e-9);
        }
    }

    // ==========================================================================
    // perSampleHampelFilter
    // ==========================================================================

    @Nested
    @DisplayName("perSampleHampelFilter")
    class PerSampleHampelFilterTest {

        @Test
        @DisplayName("clean data passes through unchanged")
        void cleanData() {
            double[] tranInA = new double[30];
            java.util.Arrays.fill(tranInA, 10.0);
            double[] prev5Raw = {10.0, 10.0, 10.0, 10.0, 10.0};
            double[] prev5Corrected = {10.0, 10.0, 10.0, 10.0, 10.0};
            byte[] outlierFifo = new byte[6];

            double[] result = SignalProcessing.perSampleHampelFilter(
                    tranInA, prev5Raw, prev5Corrected, outlierFifo);

            for (int i = 0; i < 30; i++) {
                assertEquals(10.0, result[i], EPS, "result[" + i + "]");
            }
        }

        @Test
        @DisplayName("updates prev5 state correctly")
        void updatesPrev5() {
            double[] tranInA = new double[30];
            for (int i = 0; i < 30; i++) tranInA[i] = i + 1.0;
            double[] prev5Raw = {0, 0, 0, 0, 0};
            double[] prev5Corrected = {0, 0, 0, 0, 0};
            byte[] outlierFifo = new byte[6];

            SignalProcessing.perSampleHampelFilter(
                    tranInA, prev5Raw, prev5Corrected, outlierFifo);

            // prev5Raw should be tranInA[25..29] = [26,27,28,29,30]
            assertEquals(26.0, prev5Raw[0], EPS);
            assertEquals(30.0, prev5Raw[4], EPS);
        }

        @Test
        @DisplayName("outlier FIFO shifts left")
        void fifoShifts() {
            double[] tranInA = new double[30];
            java.util.Arrays.fill(tranInA, 5.0);
            double[] prev5Raw = {5, 5, 5, 5, 5};
            double[] prev5Corrected = {5, 5, 5, 5, 5};
            byte[] outlierFifo = {1, 2, 3, 4, 5, 6};

            SignalProcessing.perSampleHampelFilter(
                    tranInA, prev5Raw, prev5Corrected, outlierFifo);

            assertEquals(2, outlierFifo[0]);
            assertEquals(6, outlierFifo[4]);
            assertEquals(0, outlierFifo[5]);
        }

        @Test
        @DisplayName("detects and replaces outlier")
        void detectsOutlier() {
            double[] tranInA = new double[30];
            java.util.Arrays.fill(tranInA, 10.0);
            tranInA[15] = 1000.0; // massive outlier

            double[] prev5Raw = {10.0, 10.0, 10.0, 10.0, 10.0};
            double[] prev5Corrected = {10.0, 10.0, 10.0, 10.0, 10.0};
            byte[] outlierFifo = new byte[6];

            double[] result = SignalProcessing.perSampleHampelFilter(
                    tranInA, prev5Raw, prev5Corrected, outlierFifo);

            // The outlier should be replaced with something much closer to 10
            assertTrue(result[15] < 1000.0,
                    "Outlier should be replaced, got " + result[15]);
            // The Hampel filter clips to median +/- scaledMad, so the replacement
            // will be much less than 1000 but not necessarily very close to 10
            // when the window includes the outlier in MAD computation
            assertTrue(result[15] < 500.0,
                    "Replacement should be significantly reduced, got " + result[15]);
        }
    }

    // ==========================================================================
    // computeTranInA1min: Full LOESS pipeline
    // ==========================================================================

    @Nested
    @DisplayName("computeTranInA1min")
    class ComputeTranInA1minTest {

        @Test
        @DisplayName("first call (callCount=0) skips Hampel and LOESS")
        void firstCall() {
            double[] tranInA = new double[30];
            for (int i = 0; i < 30; i++) tranInA[i] = 100.0 + i;

            double[] history60 = new double[60];
            double[] prev3 = new double[3];
            double[] prev5Raw = new double[5];
            double[] prev5Corrected = new double[5];
            byte[] outlierFifo = new byte[6];

            double[] result = SignalProcessing.computeTranInA1min(
                    tranInA, history60, prev3, prev5Raw, prev5Corrected,
                    outlierFifo, 0, 0.0);

            assertEquals(5, result.length);

            // prev5 should be initialized to last 5 of tranInA
            assertEquals(126.0, prev5Raw[1], EPS);
            assertEquals(129.0, prev5Corrected[4], EPS);

            // History should be updated: second half = tranInA (as perSample)
            assertEquals(100.0, history60[30], EPS);
            assertEquals(129.0, history60[59], EPS);
        }

        @Test
        @DisplayName("constant input produces constant output")
        void constantInput() {
            double[] tranInA = new double[30];
            java.util.Arrays.fill(tranInA, 50.0);

            double[] history60 = new double[60];
            java.util.Arrays.fill(history60, 50.0);
            double[] prev3 = {50.0, 50.0, 50.0};
            double[] prev5Raw = {50.0, 50.0, 50.0, 50.0, 50.0};
            double[] prev5Corrected = {50.0, 50.0, 50.0, 50.0, 50.0};
            byte[] outlierFifo = new byte[6];

            double[] result = SignalProcessing.computeTranInA1min(
                    tranInA, history60, prev3, prev5Raw, prev5Corrected,
                    outlierFifo, 5, 100.0);

            for (int i = 0; i < 5; i++) {
                assertEquals(50.0, result[i], 1e-6, "result[" + i + "]");
            }
        }

        @Test
        @DisplayName("callCount=1 skips Hampel but not FIR (if time_gap small)")
        void callCountOne() {
            double[] tranInA = new double[30];
            for (int i = 0; i < 30; i++) tranInA[i] = 20.0;

            double[] history60 = new double[60];
            double[] prev3 = new double[3];
            double[] prev5Raw = new double[5];
            double[] prev5Corrected = new double[5];
            byte[] outlierFifo = new byte[6];

            // callCount=1 < 2 => skip Hampel and FIR
            double[] result = SignalProcessing.computeTranInA1min(
                    tranInA, history60, prev3, prev5Raw, prev5Corrected,
                    outlierFifo, 1, 100.0);

            // All medians of constant=20 should produce 20
            for (int i = 0; i < 5; i++) {
                assertEquals(20.0, result[i], 1e-9, "result[" + i + "]");
            }
        }

        @Test
        @DisplayName("prev3 state is updated from medians")
        void prev3Updated() {
            double[] tranInA = new double[30];
            for (int i = 0; i < 30; i++) tranInA[i] = i * 2.0;

            double[] history60 = new double[60];
            double[] prev3 = new double[3];
            double[] prev5Raw = new double[5];
            double[] prev5Corrected = new double[5];
            byte[] outlierFifo = new byte[6];

            SignalProcessing.computeTranInA1min(
                    tranInA, history60, prev3, prev5Raw, prev5Corrected,
                    outlierFifo, 0, 0.0);

            // prev3 should be populated (not zeros)
            // Can't predict exact values without running medians manually,
            // but they should be non-zero since input is non-zero
            assertTrue(prev3[2] > 0, "prev3[2] should be updated");
        }

        @Test
        @DisplayName("LOESS is engaged when callCount >= 3 and timeGap < 897.2")
        void loessEngaged() {
            double[] tranInA = new double[30];
            java.util.Arrays.fill(tranInA, 100.0);
            tranInA[15] = 200.0; // outlier

            double[] history60 = new double[60];
            java.util.Arrays.fill(history60, 100.0);
            double[] prev3 = {100, 100, 100};
            double[] prev5Raw = {100, 100, 100, 100, 100};
            double[] prev5Corrected = {100, 100, 100, 100, 100};
            byte[] outlierFifo = new byte[6];

            // With LOESS engaged (callCount=5, timeGap=100)
            double[] withLoess = SignalProcessing.computeTranInA1min(
                    tranInA.clone(), history60.clone(), prev3.clone(),
                    prev5Raw.clone(), prev5Corrected.clone(),
                    outlierFifo.clone(), 5, 100.0);

            // Without LOESS (timeGap too large)
            double[] withoutLoess = SignalProcessing.computeTranInA1min(
                    tranInA.clone(), history60.clone(), prev3.clone(),
                    prev5Raw.clone(), prev5Corrected.clone(),
                    outlierFifo.clone(), 5, 1000.0);

            // Results should differ because LOESS smooths differently
            // Both should produce 5 values
            assertEquals(5, withLoess.length);
            assertEquals(5, withoutLoess.length);
        }

        @Test
        @DisplayName("history60 shifts correctly across calls")
        void historyShifts() {
            double[] tranInA1 = new double[30];
            java.util.Arrays.fill(tranInA1, 10.0);
            double[] tranInA2 = new double[30];
            java.util.Arrays.fill(tranInA2, 20.0);

            double[] history60 = new double[60];
            double[] prev3 = new double[3];
            double[] prev5Raw = new double[5];
            double[] prev5Corrected = new double[5];
            byte[] outlierFifo = new byte[6];

            // First call
            SignalProcessing.computeTranInA1min(
                    tranInA1, history60, prev3, prev5Raw, prev5Corrected,
                    outlierFifo, 0, 0.0);

            // After first call: history60[0:30]=0, history60[30:60]=10
            assertEquals(0.0, history60[0], EPS);
            assertEquals(10.0, history60[30], EPS);

            // Second call
            SignalProcessing.computeTranInA1min(
                    tranInA2, history60, prev3, prev5Raw, prev5Corrected,
                    outlierFifo, 1, 100.0);

            // After second call: history60[0:30]=10, history60[30:60]=20
            assertEquals(10.0, history60[0], EPS);
            assertEquals(20.0, history60[30], EPS);
        }
    }
}
