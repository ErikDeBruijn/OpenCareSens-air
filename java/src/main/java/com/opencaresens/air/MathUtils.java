package com.opencaresens.air;

import java.util.Arrays;

/**
 * Stateless math utility functions ported from C (math_utils.c).
 * All methods are static. Behavior matches the C implementation exactly.
 */
final class MathUtils {

    private MathUtils() {} // prevent instantiation

    // ------------------------------------------------------------------
    // Basic math
    // ------------------------------------------------------------------

    /** Round to nearest integer, half-away-from-zero. */
    public static double mathRound(double x) {
        if (Double.isNaN(x)) return Double.NaN;
        double adj = (x < 0.0) ? -0.5 : 0.5;
        return (double) (long) (x + adj);
    }

    /** Ceiling function matching C truncation semantics. */
    public static double mathCeil(double x) {
        if (Double.isNaN(x)) return Double.NaN;
        int trunc = (int) (long) x;
        if (x > 0.0 && (double) trunc != x) {
            trunc++;
        }
        return (double) trunc;
    }

    /** Round x to numDigits decimal places, return as long. Clamps on overflow. */
    public static long mathRoundDigits(double x, int numDigits) {
        double scale = Math.pow(10.0, numDigits);
        double scaled = scale * x;
        if (scaled >= 0.0) {
            if (scaled > 9.223372036854776e+18) return Long.MAX_VALUE;
            return (long) (scaled + 0.5);
        } else {
            if (scaled < -9.223372036854776e+18) return Long.MIN_VALUE;
            return (long) (scaled - 0.5);
        }
    }

    // ------------------------------------------------------------------
    // Statistics basics
    // ------------------------------------------------------------------

    /** NaN-aware arithmetic mean. */
    public static double mathMean(double[] buf) {
        return mathMean(buf, buf.length);
    }

    /** NaN-aware arithmetic mean of first n elements. */
    public static double mathMean(double[] buf, int n) {
        if (n == 0) return Double.NaN;
        double sum = 0.0;
        int valid = 0;
        for (int i = 0; i < n; i++) {
            if (Double.isNaN(buf[i])) continue;
            sum += buf[i];
            valid++;
        }
        if (valid == 0) return Double.NaN;
        return sum / valid;
    }

    /** Sample standard deviation (N-1 denominator). */
    public static double mathStd(double[] buf) {
        return mathStd(buf, buf.length);
    }

    /** Sample standard deviation of first n elements. */
    public static double mathStd(double[] buf, int n) {
        if (n == 0) return Double.NaN;
        if (n == 1) return 0.0;
        double mean = mathMean(buf, n);
        double sumSq = 0.0;
        for (int i = 0; i < n; i++) {
            double d = buf[i] - mean;
            sumSq += d * d;
        }
        return Math.sqrt(sumSq / (n - 1));
    }

    // ------------------------------------------------------------------
    // Extremes
    // ------------------------------------------------------------------

    /** Maximum of first len elements, skipping NaN. */
    public static double mathMax(double[] arr) {
        return mathMax(arr, arr.length);
    }

    public static double mathMax(double[] arr, int len) {
        double best = 0.0;
        boolean found = false;
        for (int i = 0; i < len; i++) {
            if (Double.isNaN(arr[i])) continue;
            if (!found || arr[i] > best) {
                best = arr[i];
                found = true;
            }
        }
        return found ? best : Double.NaN;
    }

    /** Minimum of first len elements, skipping NaN. */
    public static double mathMin(double[] arr) {
        return mathMin(arr, arr.length);
    }

    public static double mathMin(double[] arr, int len) {
        if (len == 0) return Double.NaN;
        double best = 0.0;
        boolean found = false;
        for (int i = 0; i < len; i++) {
            if (Double.isNaN(arr[i])) continue;
            if (!found || arr[i] < best) {
                best = arr[i];
                found = true;
            }
        }
        return found ? best : Double.NaN;
    }

    // ------------------------------------------------------------------
    // Order statistics
    // ------------------------------------------------------------------

    /** Median via sort (for small arrays, up to 300 elements). */
    public static double mathMedian(double[] arr) {
        return mathMedian(arr, arr.length);
    }

    public static double mathMedian(double[] arr, int n) {
        if (n == 0) return Double.NaN;
        int use = Math.min(n, 300);
        double[] tmp = Arrays.copyOf(arr, use);
        Arrays.sort(tmp);
        if (use % 2 == 1) return tmp[use / 2];
        return (tmp[use / 2 - 1] + tmp[use / 2]) * 0.5;
    }

    /**
     * QuickSelect: find k-th smallest element (1-indexed).
     * Uses median-of-5 pivot selection matching the C implementation.
     * Note: modifies the input array.
     */
    public static double quickSelect(double[] arr, int n, int k) {
        if (n == 1) return arr[0];

        // Median-of-5 pivot selection
        double[] pivots = new double[5];
        pivots[0] = arr[0];
        pivots[1] = arr[n - 1];
        pivots[2] = arr[n >> 2];
        pivots[3] = arr[(n & 0x3ffffffe) >> 1]; // n/2 rounded down to even
        pivots[4] = arr[((n >> 2)) * 3];
        double pivot = mathMedian(pivots, 5);

        double[] less = new double[n];
        double[] greater = new double[n];
        int nLess = 0, nGreater = 0, nEqual = 0;

        for (int i = 0; i < n; i++) {
            if (arr[i] < pivot) less[nLess++] = arr[i];
            else if (arr[i] > pivot) greater[nGreater++] = arr[i];
            else nEqual++;
        }

        if (k <= nLess) {
            return quickSelect(less, nLess, k);
        } else if (k <= nLess + nEqual) {
            return pivot;
        } else {
            System.arraycopy(greater, 0, arr, 0, nGreater);
            return quickSelect(arr, nGreater, k - nLess - nEqual);
        }
    }

    /** Median: quickSelect for large arrays, mathMedian for small (<30). */
    public static double quickMedian(double[] arr, int n) {
        if (n == 0) return Double.NaN;
        if (n < 30) return mathMedian(arr, n);
        int half = n / 2;
        if (n % 2 != 0) {
            return quickSelect(arr.clone(), n, half + 1);
        }
        double a = quickSelect(arr.clone(), n, half);
        double b = quickSelect(arr.clone(), n, half + 1);
        return (a + b) * 0.5;
    }

    // ------------------------------------------------------------------
    // Percentile-based
    // ------------------------------------------------------------------

    /** Percentile: filters NaN/Inf, then uses quickSelect. */
    public static double calcPercentile(double[] arr, int n, int percent) {
        double[] filtered = new double[n];
        int cnt = 0;
        for (int i = 0; i < n; i++) {
            if (!Double.isNaN(arr[i]) && !Double.isInfinite(arr[i])) {
                filtered[cnt++] = arr[i];
            }
        }
        if (cnt == 0) return Double.NaN;

        double rankF = percent * 0.01 * cnt + 0.5;
        int rank = (rankF > 0.0) ? (int) (long) rankF : 0;

        if (rank == 0) return mathMin(filtered, cnt);
        if (rank > cnt) rank = cnt;

        return quickSelect(filtered, cnt, rank);
    }

    /** Trimmed mean: average values between percentile(th) and percentile(100-th). */
    public static double fTrimmedMean(double[] data, int len, int th) {
        double lo = calcPercentile(data, len, th);
        double hi = calcPercentile(data, len, 100 - th);

        if (lo == hi) return mathMean(data, len);

        double sum = 0.0;
        int cnt = 0;
        for (int i = 0; i < len; i++) {
            if (funCompDecimals(data[i], lo, 10, 3) &&   // data[i] >= lo
                funCompDecimals(data[i], hi, 10, 4)) {   // data[i] <= hi
                sum += data[i];
                cnt++;
            }
        }
        if (cnt == 0) return Double.NaN;
        return sum / cnt;
    }

    // ------------------------------------------------------------------
    // Array manipulation
    // ------------------------------------------------------------------

    /** Replace outliers outside [mean-2*std, mean+2*std] with mean. Always 30 elements. */
    public static double[] eliminatePeak(double[] in) {
        double mean = mathMean(in, 30);
        double std = mathStd(in, 30);
        double lo = mean - 2.0 * std;
        double hi = mean + 2.0 * std;
        double[] out = new double[30];
        for (int i = 0; i < 30; i++) {
            out[i] = (in[i] < lo || in[i] > hi) ? mean : in[i];
        }
        return out;
    }

    /**
     * Remove element at index, shift left, return new count.
     * Matches C void delete_element(double*, uint8_t*, uint32_t).
     */
    public static int deleteElement(double[] arr, int count, int index) {
        if (count == 0 || index >= count) return count;
        System.arraycopy(arr, index + 1, arr, index, count - 1 - index);
        return count - 1;
    }

    // ------------------------------------------------------------------
    // Regression
    // ------------------------------------------------------------------

    /**
     * Simple linear regression: y = slope*x + intercept. NaN-aware.
     * Returns double[]{slope, intercept}.
     */
    public static double[] fitSimpleRegression(double[] x, double[] y, int n) {
        if (n < 2) return new double[]{Double.NaN, Double.NaN};

        double sx = 0, sy = 0, sxy = 0, sxx = 0;
        int valid = 0;
        for (int i = 0; i < n; i++) {
            if (Double.isNaN(x[i]) || Double.isNaN(y[i])) continue;
            sx += x[i];
            sy += y[i];
            sxy += x[i] * y[i];
            sxx += x[i] * x[i];
            valid++;
        }

        if (valid < 2) return new double[]{Double.NaN, Double.NaN};

        double denom = (double) valid * sxx - sx * sx;
        if (Math.abs(denom) < 1e-30) return new double[]{Double.NaN, Double.NaN};

        double slope = ((double) valid * sxy - sx * sy) / denom;
        double intercept = (sy - slope * sx) / valid;
        return new double[]{slope, intercept};
    }

    /** R-squared (coefficient of determination) for a regression. */
    public static double fRsq(double[] x, double[] y, int n, double slope, double intercept) {
        if (n < 2) return Double.NaN;

        double ssTot = 0, ssRes = 0;
        double yMean = mathMean(y, n);
        for (int i = 0; i < n; i++) {
            if (Double.isNaN(x[i]) || Double.isNaN(y[i])) continue;
            double yPred = slope * x[i] + intercept;
            double res = y[i] - yPred;
            double tot = y[i] - yMean;
            ssRes += res * res;
            ssTot += tot * tot;
        }
        if (ssTot < 1e-30) return Double.NaN;
        return 1.0 - ssRes / ssTot;
    }

    /**
     * Solve 2x2 linear system using Cramer's rule.
     * [a b; c d] * [x; y] = [e; f]
     * Returns double[]{x, y}.
     */
    public static double[] solveLinear(double a, double b, double c, double d,
                                        double e, double f) {
        double det = a * d - b * c;
        if (Math.abs(det) < 1e-30) return new double[]{Double.NaN, Double.NaN};
        return new double[]{(e * d - b * f) / det, (a * f - e * c) / det};
    }

    // ------------------------------------------------------------------
    // Comparison utility
    // ------------------------------------------------------------------

    /**
     * Compare two doubles rounded to numDigits decimal places.
     * metSel: 0=eq, 1=gt, 2=lt, 3=ge, 4=le
     */
    public static boolean funCompDecimals(double in1, double in2, int numDigits, int metSel) {
        if (Double.isNaN(in1) || Double.isNaN(in2)) return false;

        long a = mathRoundDigits(in1, numDigits);
        long b = mathRoundDigits(in2, numDigits);

        // If either overflowed, fall back to direct double comparison
        if (a == Long.MAX_VALUE || a == Long.MIN_VALUE || b == Long.MAX_VALUE || b == Long.MIN_VALUE) {
            switch (metSel) {
                case 0: return in1 == in2;
                case 1: return in1 > in2;
                case 2: return in1 < in2;
                case 3: return in1 >= in2;
                case 4: return in1 <= in2;
                default: return in1 == in2;
            }
        }

        switch (metSel) {
            case 0: return a == b;
            case 1: return a > b;
            case 2: return a < b;
            case 3: return a >= b;
            case 4: return a <= b;
            default: return a == b;
        }
    }

    // ------------------------------------------------------------------
    // Specialty average
    // ------------------------------------------------------------------

    /** Average excluding the single min and max values from array. */
    public static double calAverageWithoutMinMax(double[] arr, int n) {
        if (n <= 2) return mathMean(arr, n);

        double mn = arr[0], mx = arr[0];
        double sum = arr[0];
        for (int i = 1; i < n; i++) {
            sum += arr[i];
            if (arr[i] < mn) mn = arr[i];
            if (arr[i] > mx) mx = arr[i];
        }
        return (sum - mn - mx) / (n - 2);
    }

    // ------------------------------------------------------------------
    // Exponential smoothing
    // ------------------------------------------------------------------

    /**
     * Simple smoothing: average adjacent pairs for interior elements.
     * From signal_processing.c apply_simple_smooth.
     * Modifies buffer in-place.
     */
    public static void applySimpleSmooth(double[] buffer, int n, double alpha) {
        if (n <= 7) return;

        double stdVal = mathStd(buffer, n);
        if (stdVal < 1e-8) return;

        double[] tmp = Arrays.copyOf(buffer, n);
        for (int i = 1; i < n - 1; i++) {
            buffer[i] = (tmp[i] + tmp[i + 1]) * 0.5;
        }
    }
}
