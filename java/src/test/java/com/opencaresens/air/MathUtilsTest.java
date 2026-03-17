package com.opencaresens.air;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Nested;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests for MathUtils — ported from C math_utils.c.
 * Each nested class covers one function group, written RED first.
 */
class MathUtilsTest {

    private static final double EPS = 1e-9;

    // ---------------------------------------------------------------
    // Group 1: mathRound, mathCeil, mathRoundDigits
    // ---------------------------------------------------------------

    @Nested
    class MathRoundTest {
        @Test
        void roundsPositiveHalfUp() {
            assertEquals(3.0, MathUtils.mathRound(2.5));
            assertEquals(3.0, MathUtils.mathRound(2.7));
            assertEquals(2.0, MathUtils.mathRound(2.3));
        }

        @Test
        void roundsNegativeHalfDown() {
            assertEquals(-3.0, MathUtils.mathRound(-2.5));
            assertEquals(-3.0, MathUtils.mathRound(-2.7));
            assertEquals(-2.0, MathUtils.mathRound(-2.3));
        }

        @Test
        void roundsZero() {
            assertEquals(0.0, MathUtils.mathRound(0.0));
        }

        @Test
        void returnsNanForNan() {
            assertTrue(Double.isNaN(MathUtils.mathRound(Double.NaN)));
        }
    }

    @Nested
    class MathRoundEdgeCaseTest {
        @Test
        void extremelyLargeValueNearLongMaxValue() {
            // Values near Long.MAX_VALUE: the cast (long)(x + 0.5) may overflow
            double huge = (double) Long.MAX_VALUE;
            double result = MathUtils.mathRound(huge);
            // Should not produce unexpected negative due to overflow
            assertTrue(Double.isFinite(result), "mathRound of huge value must be finite");

            // Even larger
            double veryHuge = 1e18;
            double result2 = MathUtils.mathRound(veryHuge);
            assertEquals(1e18, result2, 1.0);
        }

        @Test
        void extremelyLargeNegativeValue() {
            double result = MathUtils.mathRound(-1e18);
            assertEquals(-1e18, result, 1.0);
        }
    }

    @Nested
    class MathCeilTest {
        @Test
        void ceilsPositive() {
            assertEquals(3.0, MathUtils.mathCeil(2.1));
            assertEquals(3.0, MathUtils.mathCeil(2.9));
        }

        @Test
        void ceilsExactInteger() {
            assertEquals(3.0, MathUtils.mathCeil(3.0));
        }

        @Test
        void ceilsNegative() {
            // C code: (int)(long long)(-2.1) = -2, since -2.1 > 0 is false, no increment
            assertEquals(-2.0, MathUtils.mathCeil(-2.1));
            assertEquals(-2.0, MathUtils.mathCeil(-2.9));
        }

        @Test
        void returnsNanForNan() {
            assertTrue(Double.isNaN(MathUtils.mathCeil(Double.NaN)));
        }
    }

    @Nested
    class MathRoundDigitsTest {
        @Test
        void roundsToTwoDecimalPlaces() {
            assertEquals(314L, MathUtils.mathRoundDigits(3.14159, 2));
        }

        @Test
        void roundsToZeroDecimalPlaces() {
            assertEquals(3L, MathUtils.mathRoundDigits(3.14, 0));
        }

        @Test
        void roundsNegativeValue() {
            assertEquals(-314L, MathUtils.mathRoundDigits(-3.14159, 2));
        }

        @Test
        void clampsLargePositive() {
            assertEquals(Long.MAX_VALUE, MathUtils.mathRoundDigits(1e19, 2));
        }

        @Test
        void clampsLargeNegative() {
            assertEquals(Long.MIN_VALUE, MathUtils.mathRoundDigits(-1e19, 2));
        }
    }

    // ---------------------------------------------------------------
    // Group 2: mathMean, mathStd
    // ---------------------------------------------------------------

    @Nested
    class MathMeanTest {
        @Test
        void computesMean() {
            assertEquals(2.0, MathUtils.mathMean(new double[]{1, 2, 3}), EPS);
        }

        @Test
        void skipsNan() {
            assertEquals(2.5, MathUtils.mathMean(new double[]{1, Double.NaN, 4}), EPS);
        }

        @Test
        void returnsNanForEmpty() {
            assertTrue(Double.isNaN(MathUtils.mathMean(new double[]{})));
        }

        @Test
        void returnsNanForAllNan() {
            assertTrue(Double.isNaN(MathUtils.mathMean(new double[]{Double.NaN, Double.NaN})));
        }
    }

    @Nested
    class MathStdTest {
        @Test
        void computesSampleStd() {
            // {2, 4, 4, 4, 5, 5, 7, 9} -> mean=5, var=32/7, std=sqrt(32/7)
            double[] data = {2, 4, 4, 4, 5, 5, 7, 9};
            assertEquals(Math.sqrt(32.0 / 7.0), MathUtils.mathStd(data), EPS);
        }

        @Test
        void returnsZeroForSingleElement() {
            assertEquals(0.0, MathUtils.mathStd(new double[]{42.0}));
        }

        @Test
        void returnsNanForEmpty() {
            assertTrue(Double.isNaN(MathUtils.mathStd(new double[]{})));
        }

        @Test
        void nanInArrayPropagates() {
            // NaN in the array affects the mean, which propagates through
            double[] data = {1.0, 2.0, Double.NaN, 4.0};
            double result = MathUtils.mathStd(data);
            // mathMean skips NaN (returns mean of {1,2,4}=2.333...)
            // but mathStd does NOT skip NaN: buf[2]-mean = NaN-2.333 = NaN
            // sumSq += NaN => NaN, sqrt(NaN) = NaN
            assertTrue(Double.isNaN(result),
                    "mathStd with NaN in array should produce NaN");
        }
    }

    // ---------------------------------------------------------------
    // Group 3: mathMin, mathMax
    // ---------------------------------------------------------------

    @Nested
    class MathMinTest {
        @Test
        void findsMinimum() {
            assertEquals(1.0, MathUtils.mathMin(new double[]{3, 1, 2}), EPS);
        }

        @Test
        void skipsNan() {
            assertEquals(1.0, MathUtils.mathMin(new double[]{Double.NaN, 1, 2}), EPS);
        }

        @Test
        void returnsNanForEmpty() {
            assertTrue(Double.isNaN(MathUtils.mathMin(new double[]{})));
        }

        @Test
        void returnsNanForAllNan() {
            assertTrue(Double.isNaN(MathUtils.mathMin(new double[]{Double.NaN})));
        }
    }

    @Nested
    class MathMaxTest {
        @Test
        void findsMaximum() {
            assertEquals(3.0, MathUtils.mathMax(new double[]{3, 1, 2}), EPS);
        }

        @Test
        void skipsNan() {
            assertEquals(2.0, MathUtils.mathMax(new double[]{Double.NaN, 1, 2}), EPS);
        }

        @Test
        void returnsNanForAllNan() {
            assertTrue(Double.isNaN(MathUtils.mathMax(new double[]{Double.NaN})));
        }
    }

    // ---------------------------------------------------------------
    // Group 4: mathMedian, quickSelect, quickMedian
    // ---------------------------------------------------------------

    @Nested
    class MathMedianTest {
        @Test
        void medianOfOddCount() {
            assertEquals(2.0, MathUtils.mathMedian(new double[]{3, 1, 2}), EPS);
        }

        @Test
        void medianOfEvenCount() {
            assertEquals(2.5, MathUtils.mathMedian(new double[]{3, 1, 2, 4}), EPS);
        }

        @Test
        void medianOfSingle() {
            assertEquals(42.0, MathUtils.mathMedian(new double[]{42}), EPS);
        }

        @Test
        void returnsNanForEmpty() {
            assertTrue(Double.isNaN(MathUtils.mathMedian(new double[]{})));
        }
    }

    @Nested
    class QuickSelectTest {
        @Test
        void findsKthSmallest() {
            double[] arr = {5, 3, 1, 4, 2};
            assertEquals(1.0, MathUtils.quickSelect(arr.clone(), 5, 1), EPS);
        }

        @Test
        void findsMedianElement() {
            double[] arr = {5, 3, 1, 4, 2};
            assertEquals(3.0, MathUtils.quickSelect(arr.clone(), 5, 3), EPS);
        }

        @Test
        void findsLargest() {
            double[] arr = {5, 3, 1, 4, 2};
            assertEquals(5.0, MathUtils.quickSelect(arr.clone(), 5, 5), EPS);
        }

        @Test
        void singleElement() {
            assertEquals(7.0, MathUtils.quickSelect(new double[]{7.0}, 1, 1), EPS);
        }
    }

    @Nested
    class QuickMedianTest {
        @Test
        void smallArrayUsesMedian() {
            // n < 30 -> delegates to mathMedian
            double[] arr = {5, 3, 1, 4, 2};
            assertEquals(3.0, MathUtils.quickMedian(arr, 5), EPS);
        }

        @Test
        void largeOddArray() {
            // 31 elements: 1..31, median should be 16
            double[] arr = new double[31];
            for (int i = 0; i < 31; i++) arr[i] = i + 1;
            assertEquals(16.0, MathUtils.quickMedian(arr, 31), EPS);
        }

        @Test
        void largeEvenArray() {
            // 30 elements: 1..30, median should be 15.5
            double[] arr = new double[30];
            for (int i = 0; i < 30; i++) arr[i] = i + 1;
            assertEquals(15.5, MathUtils.quickMedian(arr.clone(), 30), EPS);
        }

        @Test
        void returnsNanForEmpty() {
            assertTrue(Double.isNaN(MathUtils.quickMedian(new double[]{}, 0)));
        }
    }

    // ---------------------------------------------------------------
    // Group 5: calcPercentile, fTrimmedMean
    // ---------------------------------------------------------------

    @Nested
    class CalcPercentileTest {
        @Test
        void percentile50IsMedian() {
            double[] arr = {1, 2, 3, 4, 5};
            assertEquals(3.0, MathUtils.calcPercentile(arr, 5, 50), EPS);
        }

        @Test
        void percentile0ReturnsMin() {
            double[] arr = {5, 1, 3};
            assertEquals(1.0, MathUtils.calcPercentile(arr, 3, 0), EPS);
        }

        @Test
        void percentile100ReturnsMax() {
            double[] arr = {5, 1, 3};
            assertEquals(5.0, MathUtils.calcPercentile(arr, 3, 100), EPS);
        }

        @Test
        void filtersNanAndInf() {
            double[] arr = {Double.NaN, 1, Double.POSITIVE_INFINITY, 3, 5};
            // After filter: {1, 3, 5}, percentile 50 -> rank = 50*0.01*3+0.5=2.0 -> (int)2.0=2 -> quick_select(2)=3
            assertEquals(3.0, MathUtils.calcPercentile(arr, 5, 50), EPS);
        }

        @Test
        void returnsNanForAllNan() {
            assertTrue(Double.isNaN(MathUtils.calcPercentile(
                    new double[]{Double.NaN}, 1, 50)));
        }
    }

    @Nested
    class FTrimmedMeanTest {
        @Test
        void trimmedMeanWithThreshold() {
            // 10 elements, th=10 -> percentile(10) and percentile(90)
            double[] arr = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
            double result = MathUtils.fTrimmedMean(arr, 10, 10);
            // percentile(10): rank = 10*0.01*10+0.5 = 1.5 -> (int)1.5=1 -> qs(1)=1
            // percentile(90): rank = 90*0.01*10+0.5 = 9.5 -> (int)9.5=9 -> qs(9)=9
            // Values >= 1 and <= 9: 1..9, mean = 5.0
            assertEquals(5.0, result, EPS);
        }

        @Test
        void fallsBackToMeanWhenLoEqualsHi() {
            double[] arr = {5, 5, 5};
            assertEquals(5.0, MathUtils.fTrimmedMean(arr, 3, 10), EPS);
        }
    }

    // ---------------------------------------------------------------
    // Group 6: eliminatePeak, deleteElement
    // ---------------------------------------------------------------

    @Nested
    class EliminatePeakTest {
        @Test
        void replacesOutliersWithMean() {
            double[] in = new double[30];
            for (int i = 0; i < 30; i++) in[i] = 10.0;
            in[0] = 1000.0; // outlier

            double[] out = MathUtils.eliminatePeak(in);
            double mean = MathUtils.mathMean(in, 30);
            assertEquals(mean, out[0], EPS); // outlier replaced
            assertEquals(10.0, out[1], EPS); // normal value kept
        }

        @Test
        void keepsValuesWithinRange() {
            double[] in = new double[30];
            for (int i = 0; i < 30; i++) in[i] = i;
            double[] out = MathUtils.eliminatePeak(in);
            // Mean ~14.5, std ~8.8, range ~[-3.1, 32.1] -> all values within
            for (int i = 0; i < 30; i++) {
                assertEquals((double) i, out[i], EPS);
            }
        }
    }

    @Nested
    class DeleteElementTest {
        @Test
        void deletesMiddleElement() {
            double[] arr = {1, 2, 3, 4, 5, 0, 0, 0};
            int newCount = MathUtils.deleteElement(arr, 5, 2);
            assertEquals(4, newCount);
            assertEquals(1.0, arr[0], EPS);
            assertEquals(2.0, arr[1], EPS);
            assertEquals(4.0, arr[2], EPS);
            assertEquals(5.0, arr[3], EPS);
        }

        @Test
        void deletesFirstElement() {
            double[] arr = {1, 2, 3, 0, 0};
            int newCount = MathUtils.deleteElement(arr, 3, 0);
            assertEquals(2, newCount);
            assertEquals(2.0, arr[0], EPS);
            assertEquals(3.0, arr[1], EPS);
        }

        @Test
        void noOpForOutOfRange() {
            double[] arr = {1, 2, 3};
            int newCount = MathUtils.deleteElement(arr, 3, 5);
            assertEquals(3, newCount);
        }

        @Test
        void noOpForZeroCount() {
            double[] arr = {1};
            int newCount = MathUtils.deleteElement(arr, 0, 0);
            assertEquals(0, newCount);
        }
    }

    // ---------------------------------------------------------------
    // Group 7: fitSimpleRegression, fRsq, solveLinear
    // ---------------------------------------------------------------

    @Nested
    class FitSimpleRegressionTest {
        @Test
        void perfectLinearFit() {
            double[] x = {1, 2, 3, 4, 5};
            double[] y = {2, 4, 6, 8, 10}; // y = 2x
            double[] result = MathUtils.fitSimpleRegression(x, y, 5);
            assertEquals(2.0, result[0], EPS); // slope
            assertEquals(0.0, result[1], EPS); // intercept
        }

        @Test
        void withIntercept() {
            double[] x = {1, 2, 3};
            double[] y = {3, 5, 7}; // y = 2x + 1
            double[] result = MathUtils.fitSimpleRegression(x, y, 3);
            assertEquals(2.0, result[0], EPS);
            assertEquals(1.0, result[1], EPS);
        }

        @Test
        void skipsNanPairs() {
            double[] x = {1, Double.NaN, 3};
            double[] y = {2, 4, 6}; // only (1,2) and (3,6) used -> y = 2x
            double[] result = MathUtils.fitSimpleRegression(x, y, 3);
            assertEquals(2.0, result[0], EPS);
            assertEquals(0.0, result[1], EPS);
        }

        @Test
        void returnsNanForTooFewPoints() {
            double[] x = {1};
            double[] y = {2};
            double[] result = MathUtils.fitSimpleRegression(x, y, 1);
            assertTrue(Double.isNaN(result[0]));
            assertTrue(Double.isNaN(result[1]));
        }

        @Test
        void returnsNanForConstantX() {
            double[] x = {5, 5, 5};
            double[] y = {1, 2, 3};
            double[] result = MathUtils.fitSimpleRegression(x, y, 3);
            assertTrue(Double.isNaN(result[0]));
        }
    }

    @Nested
    class FRsqTest {
        @Test
        void perfectFitReturnsOne() {
            double[] x = {1, 2, 3, 4, 5};
            double[] y = {2, 4, 6, 8, 10};
            assertEquals(1.0, MathUtils.fRsq(x, y, 5, 2.0, 0.0), EPS);
        }

        @Test
        void returnsNanForTooFewPoints() {
            assertTrue(Double.isNaN(MathUtils.fRsq(new double[]{1}, new double[]{2}, 1, 1.0, 0.0)));
        }

        @Test
        void returnsNanForConstantY() {
            double[] x = {1, 2, 3};
            double[] y = {5, 5, 5};
            assertTrue(Double.isNaN(MathUtils.fRsq(x, y, 3, 0.0, 5.0)));
        }
    }

    @Nested
    class SolveLinearTest {
        @Test
        void solvesSimpleSystem() {
            // x + y = 3, x - y = 1 -> x=2, y=1
            // [1 1; 1 -1] * [x;y] = [3;1]
            double[] result = MathUtils.solveLinear(1, 1, 1, -1, 3, 1);
            assertEquals(2.0, result[0], EPS);
            assertEquals(1.0, result[1], EPS);
        }

        @Test
        void returnsNanForSingularMatrix() {
            // [1 2; 2 4] is singular (det=0)
            double[] result = MathUtils.solveLinear(1, 2, 2, 4, 1, 1);
            assertTrue(Double.isNaN(result[0]));
            assertTrue(Double.isNaN(result[1]));
        }
    }

    // ---------------------------------------------------------------
    // Group 8: funCompDecimals
    // ---------------------------------------------------------------

    @Nested
    class FunCompDecimalsTest {
        @Test
        void equalWhenRoundedSame() {
            assertTrue(MathUtils.funCompDecimals(1.004, 1.005, 2, 0));  // round to 2dp: 100 vs 101 -> not equal
            assertTrue(MathUtils.funCompDecimals(1.004, 1.004, 2, 0));  // 100 vs 100 -> equal
        }

        @Test
        void greaterThan() {
            assertTrue(MathUtils.funCompDecimals(2.0, 1.0, 2, 1));
            assertFalse(MathUtils.funCompDecimals(1.0, 2.0, 2, 1));
        }

        @Test
        void lessThan() {
            assertTrue(MathUtils.funCompDecimals(1.0, 2.0, 2, 2));
            assertFalse(MathUtils.funCompDecimals(2.0, 1.0, 2, 2));
        }

        @Test
        void greaterOrEqual() {
            assertTrue(MathUtils.funCompDecimals(2.0, 1.0, 2, 3));
            assertTrue(MathUtils.funCompDecimals(1.0, 1.0, 2, 3));
        }

        @Test
        void lessOrEqual() {
            assertTrue(MathUtils.funCompDecimals(1.0, 2.0, 2, 4));
            assertTrue(MathUtils.funCompDecimals(1.0, 1.0, 2, 4));
        }

        @Test
        void returnsFalseForNan() {
            assertFalse(MathUtils.funCompDecimals(Double.NaN, 1.0, 2, 0));
            assertFalse(MathUtils.funCompDecimals(1.0, Double.NaN, 2, 0));
        }
    }

    // ---------------------------------------------------------------
    // Group 9: calAverageWithoutMinMax
    // ---------------------------------------------------------------

    @Nested
    class CalAverageWithoutMinMaxTest {
        @Test
        void excludesMinAndMax() {
            double[] arr = {1, 2, 3, 4, 5};
            // Excludes 1 and 5, mean of {2,3,4} = 3.0
            assertEquals(3.0, MathUtils.calAverageWithoutMinMax(arr, 5), EPS);
        }

        @Test
        void twoElementsReturnsMean() {
            assertEquals(2.5, MathUtils.calAverageWithoutMinMax(new double[]{2, 3}, 2), EPS);
        }

        @Test
        void singleElementReturnsSelf() {
            assertEquals(7.0, MathUtils.calAverageWithoutMinMax(new double[]{7}, 1), EPS);
        }

        @Test
        void nanValuesInArray() {
            // NaN is neither < min nor > max, so it stays in the sum.
            // This tests that NaN propagation is understood.
            double[] arr = {1.0, Double.NaN, 3.0, 4.0, 5.0};
            double result = MathUtils.calAverageWithoutMinMax(arr, 5);
            // min=1.0 (NaN not < 1.0), max=5.0 => sum-1-5 / 3
            // But NaN + anything = NaN, so result is NaN
            assertTrue(Double.isNaN(result),
                    "calAverageWithoutMinMax with NaN in array propagates NaN");
        }
    }

    // ---------------------------------------------------------------
    // Group 10: applySimpleSmooth
    // ---------------------------------------------------------------

    @Nested
    class ApplySimpleSmoothTest {
        @Test
        void smoothsAdjacentPairs() {
            double[] buf = {1, 2, 3, 4, 5, 6, 7, 8};
            MathUtils.applySimpleSmooth(buf, 8, 0.5);
            // buf[0] unchanged (i=0 skipped)
            assertEquals(1.0, buf[0], EPS);
            // buf[1] = (2+3)*0.5 = 2.5
            assertEquals(2.5, buf[1], EPS);
            // buf[6] = (7+8)*0.5 = 7.5
            assertEquals(7.5, buf[6], EPS);
            // buf[7] unchanged (i=n-1 skipped)
            assertEquals(8.0, buf[7], EPS);
        }

        @Test
        void noOpForSmallArray() {
            double[] buf = {1, 2, 3};
            MathUtils.applySimpleSmooth(buf, 3, 0.5);
            assertEquals(1.0, buf[0], EPS);
            assertEquals(2.0, buf[1], EPS);
            assertEquals(3.0, buf[2], EPS);
        }

        @Test
        void noOpForLowStd() {
            double[] buf = {5, 5, 5, 5, 5, 5, 5, 5};
            MathUtils.applySimpleSmooth(buf, 8, 0.5);
            for (double v : buf) assertEquals(5.0, v, EPS);
        }
    }
}
