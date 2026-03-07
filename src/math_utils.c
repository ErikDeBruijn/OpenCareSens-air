/*
 * OpenCareSens Air - Open-source calibration algorithm
 *
 * Math utility functions and error detection helpers ported from the
 * CareSens Air ARM binary (Ghidra decompilation + ARM disassembly).
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include "math_utils.h"
#include "calibration.h"

#include <math.h>
#include <string.h>
#include <stdint.h>
#include <float.h>

/* ────────────────────────────────────────────────────────────────────
 * Group A: Simple math functions
 * ──────────────────────────────────────────────────────────────────── */

/*
 * math_mean: NaN-aware arithmetic mean.
 *
 * From Ghidra @ 0006f250 / 0007c6a0:
 *   - Returns NaN when count == 0.
 *   - Skips NaN values; adds 0.0 for NaN entries.
 *   - Divides sum by the count of valid (non-NaN) values.
 */
double math_mean(double *buffer, uint16_t count)
{
    if (count == 0) {
        return NAN;
    }

    double sum = 0.0;
    uint16_t valid = 0;

    for (unsigned int i = 0; i < count; i++) {
        double val = buffer[i];
        if (!isnan(val)) {
            sum += val;
            valid++;
        }
        /* NaN values contribute 0.0 to sum (skipped) */
    }

    if (valid == 0) {
        return NAN; /* all elements were NaN */
    }

    return sum / (double)valid;
}

/*
 * math_std: Sample standard deviation with Bessel's correction (N-1).
 *
 * From Ghidra @ 0006f1c0 / 0007c610:
 *   - Returns NaN when count == 0.
 *   - Returns 0.0 when count == 1.
 *   - Calls math_mean, then computes sqrt(sum_sq_diff / (N-1)).
 *   - NOTE: Original does NOT skip NaN in the variance loop (uses all N values
 *     after computing a NaN-aware mean). This matches the decompiled code.
 */
double math_std(double *buffer, int count)
{
    if (count == 0) {
        return NAN;
    }
    if (count == 1) {
        return 0.0;
    }

    double mean = math_mean(buffer, (uint16_t)count);
    double sum_sq = 0.0;

    for (int i = 0; i < count; i++) {
        double diff = buffer[i] - mean;
        sum_sq += diff * diff;
    }

    return sqrt(sum_sq / (double)(count - 1));
}

/*
 * eliminate_peak: 2-sigma outlier clipping on 30-element array.
 *
 * From Ghidra @ 0006f2a8 / 0007c6f8:
 *   - Computes mean and std of 30 elements.
 *   - For each element: if value < (mean - 2*std) or value > (mean + 2*std),
 *     replace with mean in output; otherwise copy value.
 *   - Hardcoded 30 elements (0x1e), iterated via byte offset 0xF0 = 240 = 30*8.
 */
void eliminate_peak(double *input, double *output)
{
    double mean = math_mean(input, 30);
    double std = math_std(input, 30);

    double lower = mean - 2.0 * std;
    double upper = mean + 2.0 * std;

    for (int i = 0; i < 30; i++) {
        double val = input[i];
        if (val < lower || val > upper) {
            output[i] = mean;
        } else {
            output[i] = val;
        }
    }
}

/*
 * delete_element: Remove element at index from double array.
 *
 * From Ghidra @ 0006f218 / 0007c668:
 *   - Shifts elements left starting from index.
 *   - Decrements the size counter pointed to by *size.
 *   - No-op if size==0 or index >= size.
 */
void delete_element(double *arr, uint8_t *size, unsigned int index)
{
    unsigned int sz = (unsigned int)*size;

    if (sz == 0 || index >= sz) {
        return;
    }

    for (unsigned int i = index; i < sz - 1; i++) {
        arr[i] = arr[i + 1];
    }

    *size = (uint8_t)(sz - 1);
}

/*
 * math_round: Round double to nearest integer (as double).
 *
 * From Ghidra @ 0006f308 / 0007c758:
 *   - NaN returns NaN.
 *   - Adds +0.5 or -0.5 depending on sign, then truncates to int64,
 *     then converts back to double.
 */
double math_round(double num)
{
    if (isnan(num)) {
        return NAN;
    }

    double offset = (num < 0.0) ? -0.5 : 0.5;
    return (double)(int64_t)(num + offset);
}

/*
 * math_ceil: Ceiling (as double).
 *
 * From Ghidra @ 0006f998 / 0007cde8:
 *   - NaN returns NaN.
 *   - Truncates to int, then adds 1 if the value was positive, non-zero,
 *     and the truncation lost a fractional part.
 */
double math_ceil(double num)
{
    if (isnan(num)) {
        return NAN;
    }

    int64_t trunc = (int64_t)num;
    /* Add 1 if positive, non-zero, and has fractional part */
    if (num > 0.0 && (double)trunc != num) {
        trunc += 1;
    }

    return (double)trunc;
}

/*
 * math_max: Maximum of array (NaN-aware).
 *
 * From ARM disasm @ 0006e400 / 0007e400:
 *   - The original iterates with byte offset 0 to 0x10 step 8,
 *     meaning it only looks at the FIRST 2 elements.
 *   - This is confirmed in both the opcal3 and opcal4 copies.
 *   - Returns NaN if no valid (non-NaN) values found.
 */
double math_max(double *arr, uint16_t len)
{
    (void)len; /* len parameter is ignored in original binary */

    double max_val = 0.0;
    int found = 0;

    /* Original: for (offset = 0; offset != 0x10; offset += 8) => 2 iterations */
    for (int i = 0; i < 2; i++) {
        double val = arr[i];
        if (!isnan(val)) {
            if (!found || val > max_val) {
                max_val = val;
                found = 1;
            }
        }
    }

    if (!found) {
        return NAN;
    }
    return max_val;
}

/*
 * math_min: Minimum of array (NaN-aware, uses len parameter properly).
 *
 * From ARM disasm @ 0006e448 / 0007e448:
 *   - Returns NaN if len == 0.
 *   - Iterates all len elements, skips NaN.
 *   - Returns NaN if all values are NaN.
 */
double math_min(double *arr, uint16_t len)
{
    if (len == 0) {
        return NAN;
    }

    double min_val = 0.0;
    int found = 0;

    for (unsigned int i = 0; i < len; i++) {
        double val = arr[i];
        if (!isnan(val)) {
            if (!found || val < min_val) {
                min_val = val;
                found = 1;
            }
        }
    }

    if (!found) {
        return NAN;
    }
    return min_val;
}

/*
 * math_median: Sort-based median for small arrays (< 300 elements).
 *
 * From Ghidra @ 0006f500 / 0007c950:
 *   - Copies array into local buffer, sorts, returns middle element.
 *   - For even size: returns average of two middle elements.
 *   - For odd size: returns the middle element.
 */
double math_median(double *arr, uint16_t size)
{
    if (size == 0) {
        return NAN;
    }

    double sort_buf[300];
    uint16_t n = (size < 300) ? size : 300;
    memcpy(sort_buf, arr, n * sizeof(double));

    /* Simple insertion sort (adequate for small arrays) */
    for (int i = 1; i < n; i++) {
        double key = sort_buf[i];
        int j = i - 1;
        while (j >= 0 && sort_buf[j] > key) {
            sort_buf[j + 1] = sort_buf[j];
            j--;
        }
        sort_buf[j + 1] = key;
    }

    if (n % 2 == 1) {
        return sort_buf[n / 2];
    } else {
        return (sort_buf[n / 2 - 1] + sort_buf[n / 2]) * 0.5;
    }
}

/*
 * quick_select: QuickSelect algorithm for k-th smallest element.
 *
 * From Ghidra @ 0006f5d0 / 0007ca20:
 *   - k is 1-indexed (k=1 means smallest).
 *   - If arr_size == 1, return arr[0].
 *   - Picks median-of-5 as pivot, partitions into less/equal/greater,
 *     recurses into the appropriate partition.
 */
double quick_select(double *arr, uint16_t arr_size, uint16_t k)
{
    if (arr_size == 1) {
        return arr[0];
    }
    if (arr_size == 0) {
        return NAN;
    }

    /* Pick 5 sample elements for median-of-5 pivot selection */
    double samples[5];
    samples[0] = arr[0];
    samples[1] = arr[arr_size / 4];
    samples[2] = arr[arr_size / 2];
    samples[3] = arr[(unsigned int)(arr_size / 4) * 3];
    samples[4] = arr[arr_size - 1];

    double pivot = math_median(samples, 5);

    /* Partition into less, equal, greater */
    /* Partition arrays sized to match binary's maximum expected input */
    double less[2400];
    double greater[2400];
    uint16_t n_less = 0;
    uint16_t n_equal = 0;
    uint16_t n_greater = 0;

    for (unsigned int i = 0; i < arr_size; i++) {
        double val = arr[i];
        if (val < pivot) {
            if (n_less < 2400) {
                less[n_less++] = val;
            }
        } else if (val > pivot) {
            if (n_greater < 2400) {
                greater[n_greater++] = val;
            }
        } else {
            n_equal++;
        }
    }

    /* Determine which partition contains the k-th element */
    if (k <= n_less) {
        return quick_select(less, n_less, k);
    } else if (k <= n_less + n_equal) {
        return pivot;
    } else {
        return quick_select(greater, n_greater,
                            (uint16_t)(k - n_less - n_equal));
    }
}

/*
 * quick_median: Median that dispatches based on size.
 *
 * From Ghidra @ 0006f350 / 0007c7a0:
 *   - Returns NaN for size == 0.
 *   - For size < 30 (0x1e): uses math_median (sort-based).
 *   - For size >= 30:
 *     - Odd size: quick_select(arr, size, size/2 + 1)
 *     - Even size: average of quick_select(k=size/2) and quick_select(k=size/2+1)
 */
double quick_median(double *arr, unsigned int size)
{
    if (size == 0) {
        return NAN;
    }

    if (size < 30) {
        return math_median(arr, (uint16_t)size);
    }

    uint16_t half = (uint16_t)(size >> 1);

    if (size & 1) {
        /* Odd: return the middle element */
        return quick_select(arr, (uint16_t)size, (uint16_t)(half + 1));
    } else {
        /* Even: average of two middle elements */
        double a = quick_select(arr, (uint16_t)size, half);
        double b = quick_select(arr, (uint16_t)size, (uint16_t)(half + 1));
        return (a + b) * 0.5;
    }
}

/*
 * math_round_digits: Round a double to N decimal places, returns int64_t.
 *
 * From Ghidra @ 0006f780 / 0007cbd0:
 *   - Multiplies by pow(10, num_digits).
 *   - Clamps to INT64_MAX / INT64_MIN on overflow.
 *   - Adds +0.5 or -0.5, truncates to int64_t.
 */
int64_t math_round_digits(double x, uint8_t num_digits)
{
    double scale = pow(10.0, (double)num_digits);
    double scaled = scale * x;

    if (scaled >= 0.0) {
        /* Positive: check for overflow at INT64_MAX */
        if (scaled > (double)INT64_MAX) {
            return INT64_MAX;
        }
        return (int64_t)(scaled + 0.5);
    } else {
        /* Negative: check for underflow at INT64_MIN */
        if (scaled < (double)INT64_MIN) {
            return INT64_MIN;
        }
        return (int64_t)(scaled - 0.5);
    }
}

/*
 * fun_comp_decimals: Compare two doubles rounded to N decimal places.
 *
 * From Ghidra @ 0006f3d8 / 0007c828:
 *   - Returns 0 if either input is NaN.
 *   - Rounds both values using math_round_digits.
 *   - If both rounded values would overflow (near INT64_MAX/MIN boundary),
 *     falls back to comparing the original doubles directly.
 *   - Otherwise compares the int64_t rounded values.
 *   - Modes: 1=gt, 2=lt, 3=ge, 4=le, 5=eq.
 */
uint8_t fun_comp_decimals(double in1, double in2, uint8_t num_digits, uint8_t mode)
{
    if (isnan(in1) || isnan(in2)) {
        return 0;
    }

    int64_t r1 = math_round_digits(in1, num_digits);
    int64_t r2 = math_round_digits(in2, num_digits);

    /* Check if either value overflowed (saturated to INT64_MAX or INT64_MIN).
     * The original checks if (value - INT64_MAX) is within a small range.
     * If both overflowed, fall back to direct double comparison. */
    int overflow1 = (r1 == INT64_MAX || r1 == INT64_MIN);
    int overflow2 = (r2 == INT64_MAX || r2 == INT64_MIN);

    if (overflow1 || overflow2) {
        /* Fall back to comparing original doubles */
        switch (mode) {
        case 1: return in1 > in2 ? 1 : 0;
        case 2: return in1 < in2 ? 1 : 0;
        case 3: return in1 >= in2 ? 1 : 0;
        case 4: return in1 <= in2 ? 1 : 0;
        case 5: return in1 == in2 ? 1 : 0;
        default: return in1 == in2 ? 1 : 0;
        }
    }

    switch (mode) {
    case 1: return r1 > r2 ? 1 : 0;
    case 2: return r1 < r2 ? 1 : 0;
    case 3: return r1 >= r2 ? 1 : 0;
    case 4: return r1 <= r2 ? 1 : 0;
    case 5: return r1 == r2 ? 1 : 0;
    default: return r1 == r2 ? 1 : 0;
    }
}

/*
 * cal_average_without_min_max: Average of array excluding min and max.
 *
 * From ARM disasm @ 0006cc68:
 *   - Initializes max = min = arr[0], sum = 0.
 *   - Iterates through all elements: tracks max, min, accumulates sum.
 *   - Returns (sum - min - max) / (len - 2).
 */
double cal_average_without_min_max(double *arr, int len)
{
    /* Original binary does not guard len — it always receives >= 3 elements
     * from the caller. Guard here to prevent UB on degenerate input. */
    if (len < 3) {
        return (len > 0) ? arr[0] : NAN;
    }

    double max_val = arr[0];
    double min_val = arr[0];
    double sum = 0.0;

    for (int i = 0; i < len; i++) {
        double val = arr[i];
        if (val > max_val) {
            max_val = val;
        } else if (val < min_val) {
            min_val = val;
        }
        sum += val;
    }

    sum -= min_val;
    sum -= max_val;
    return sum / (double)(len - 2);
}

/*
 * check_boundary: Parallelogram validity check for slope/intercept.
 *
 * From ARM disasm @ 0006d3d8 (opcal4 version):
 *   The function loads 5 boundary constants from device_info at specific
 *   offsets. Based on the struct layout, these are stored at offsets
 *   within the device_info structure. The parallelogram check:
 *
 *   1. Check Cycept_new is within [ycept_min, ycept_max]
 *   2. Check Cslope_new is within [slope_min, slope_max]
 *   3. Compute the diagonal line: m = (slope_max - slope_min) / (ycept_max - ycept_min)
 *      b = slope_max - m * ycept_max
 *   4. Check: (b - half_width) + m * Cycept_new <= Cslope_new
 *   5. Check: (b + half_width) + m * Cycept_new >= Cslope_new
 *
 *   The boundary constants are read from device_info at offsets that correspond
 *   to fields after the main parameter block. For now we read from the
 *   slope_min_slope_x100/slope_max_slope_x100 region. The exact mapping is:
 *     d16 = ycept_max (upper bound for intercept)
 *     d18 = ycept_min (lower bound for intercept)
 *     d19 = slope_min (lower bound for slope)
 *     d17 = slope_max (upper bound for slope)
 *     d16_2 = half_width (parallelogram half-width)
 *
 *   Since the boundary data is embedded in the binary's data section at
 *   a known offset from device_info, we parameterize this function to
 *   accept the boundary values directly for testability.
 *
 *   In practice this is called with constants loaded from a global pointer
 *   that references the device_info parameter block.
 *
 *   The simplified check from the disassembly (last part of check_boundary):
 *     d19 = d17 - d16   (half_width subtracted from slope intercept)
 *     d19 = d19 + d18 * Cycept_new  (line at lower bound)
 *     if d19 > Cslope_new => fail
 *     d16 = d16 + d17   (half_width added to slope intercept)
 *     d16 = d16 + d18 * Cycept_new  (line at upper bound)
 *     if d16 < Cslope_new => fail
 *     else => pass
 */
uint8_t check_boundary(double Cslope_new, double Cycept_new,
                        struct air1_opcal4_device_info_t *dev_info)
{
    /* Cycept_new will be used once the full parallelogram check is implemented */
    (void)Cycept_new;

    /*
     * From the opcal4 disassembly at 0x6d3d8, the function loads 5 doubles
     * from a base pointer at offsets 752, 744, 736, 728, and 760 bytes.
     * These are boundary constants stored after the device_info struct.
     *
     * For now, we use the slope/intercept boundaries from device_info fields.
     * The actual boundary constants in the binary are:
     *   offset 728: slope_max (d17)
     *   offset 736: slope_min (d19)
     *   offset 744: ycept_min (d18)
     *   offset 752: ycept_max (d16)
     *   offset 760: half_width (d16 later)
     *
     * These constants are sensor-lot-dependent and loaded from the device
     * parameter block. We read them from the calibration constants area
     * of device_info. The fields slope_max_slope_x100, slope_min_slope_x100,
     * etc. provide the raw values.
     *
     * For the C implementation, we follow the structure directly:
     */
    double slope_max = (double)dev_info->slope_max_slope_x100 / 100.0;
    double slope_min = (double)dev_info->slope_min_slope_x100 / 100.0;

    /* The boundary constants for ycept and half_width are stored in the
     * binary's data section. For the C port, we use reasonable defaults
     * that match the observed behavior. These will be refined when we
     * have oracle test data.
     *
     * Based on the disassembly flow:
     *   Step 1: ycept_max >= Cycept_new?    if not, fail
     *   Step 2: ycept_min < Cycept_new?     if not, fail
     *   Step 3: slope_min <= Cslope_new?    if not, fail
     *   Step 4: slope_max > Cslope_new?     if not, fail
     *   Step 5: Parallelogram diagonal check
     */

    /* For now: simple rectangular boundary check.
     * The parallelogram refinement will be added when boundary constants
     * are extracted from oracle runs. */
    if (Cslope_new < slope_min || Cslope_new > slope_max) {
        return 0;
    }

    /* Pass: within boundary */
    return 1;
}

/*
 * calcPercentile: Percentile with interpolation.
 *
 * From Ghidra @ 0007e0e0 / 00070cb8:
 *   1. Filter out NaN and Inf values from input into clean array.
 *   2. Compute rank = percent * 0.01 * valid_count + 0.5 (rounded to int).
 *   3. If rank == 0: return math_min of the clean array.
 *   4. Otherwise: use quick_select to find the rank-th smallest element.
 */
double calcPercentile(double *array, uint16_t size, uint8_t percent)
{
    /* Filter out NaN and Inf values */
    double clean[2400];
    uint16_t valid = 0;

    for (unsigned int i = 0; i < size; i++) {
        double val = array[i];
        /* Original checks: abs(val) != Inf AND !isnan(abs(val)) AND !isnan(Inf)
         * Effectively: not NaN and not Inf */
        if (!isnan(val) && !isinf(val)) {
            clean[valid++] = val;
        }
    }

    /* Compute the rank (1-indexed position in sorted order) */
    double rank_f = (double)percent * 0.01 * (double)valid + 0.5;
    unsigned int rank = (rank_f > 0.0) ? (unsigned int)(int64_t)rank_f : 0;

    if (rank == 0) {
        return math_min(clean, valid);
    }

    /* Use quick_select for the rank-th element */
    return quick_select(clean, valid, (uint16_t)rank);
}

/*
 * f_trimmed_mean: Symmetric percentile trimming.
 *
 * From Ghidra @ 0007e170 / 00070d48:
 *   1. Compute lower bound = calcPercentile(data, len, th)
 *   2. Compute upper bound = calcPercentile(data, len, 100 - th)
 *      (Note: 'd' - th in source = 100 - th, since 'd' = 100 in ASCII)
 *   3. If lower == upper: return math_mean(data, len)
 *   4. Otherwise: average values where lower <= val <= upper
 *      (using fun_comp_decimals with 10 digits, modes 3 and 4)
 */
double f_trimmed_mean(double *data, uint16_t len, uint8_t th)
{
    double lower = calcPercentile(data, len, th);
    double upper = calcPercentile(data, len, (uint8_t)(100 - th));

    if (lower == upper) {
        return math_mean(data, len);
    }

    double sum = 0.0;
    uint16_t count = 0;

    for (unsigned int i = 0; i < len; i++) {
        double val = data[i];
        /* Check val >= lower (mode 3) and val <= upper (mode 4),
         * using 10 decimal digits of precision */
        uint8_t ge = fun_comp_decimals(val, lower, 10, 3);
        uint8_t le = fun_comp_decimals(val, upper, 10, 4);
        if (ge && le) {
            sum += val;
            count++;
        }
    }

    if (count == 0) {
        return math_mean(data, len); /* no values in range — fall back to full mean */
    }

    return sum / (double)count;
}

/* ────────────────────────────────────────────────────────────────────
 * Group B: Error detection helpers
 * ──────────────────────────────────────────────────────────────────── */

/*
 * cal_threshold: Error threshold calculation.
 *
 * From Ghidra @ 0007e908 (opcal4) and ARM disasm @ 0006e908:
 *
 * Parameters (mapped from ARM calling convention):
 *   param_1 (r0) -> param_n:       pointer to uint16_t counter
 *   param_2 (r1) -> param_mean:    pointer to accumulated mean value
 *   param_3 (r2) -> param_diff:    pointer to accumulated diff threshold
 *   param_4 (r3) -> param_is_first: pointer to uint8_t is-first flag
 *   param_5 (stack) -> n_current:  current observation count
 *   param_6 (stack) -> mode:       operation mode (1 = special)
 *   d0 -> val_mean:   current mean-related value
 *   d1 -> val_abs_diff: absolute difference value (abs taken internally)
 *   d2 -> accum_mean: accumulated mean from previous state
 *   d3 -> accum_diff: accumulated diff from previous state
 *
 * The function references device_info for:
 *   - err1_n_last: threshold count at offset 0x47a (uint16_t)
 *   - err1_th_sse_dmean boundary at offset 0x480 (double)
 *   - err1_count_sse_dmean at offset 0x47c (uint8_t)
 *   - err1_th_n2 at offset 0x47d (uint8_t)
 */
void cal_threshold(uint16_t *param_n, double *param_mean, double *param_diff,
                   uint8_t *param_is_first, unsigned int n_current,
                   int mode,
                   double val_mean, double val_abs_diff,
                   double accum_mean, double accum_diff,
                   struct air1_opcal4_device_info_t *dev_info)
{
    /* Take absolute value of val_abs_diff (from ARM: vneg + vcmp + vmovmi) */
    if (val_abs_diff < 0.0) {
        val_abs_diff = -val_abs_diff;
    }

    uint8_t is_first = *param_is_first;
    double current_diff = *param_diff;

    uint16_t err1_n_last = dev_info->err1_n_last;

    if (n_current < err1_n_last) {
        /* Still accumulating: before reaching threshold count */
        if (n_current == 0) {
            /* First observation */
            *param_n = 1;
            accum_mean = val_mean;
            /* Check if val_abs_diff > boundary value */
            /* The boundary is loaded from dev_info err1_th_sse_dmean area */
            /* For now: just set the diff threshold */
            current_diff = val_abs_diff;
        } else {
            /* Subsequent observation */
            *param_n = (uint16_t)(n_current + 1);

            if (isnan(accum_mean)) {
                accum_mean = 0.0; /* Original loads -0.0 for NaN replacement */
            }
            accum_mean = accum_mean + val_mean;

            if (!isnan(accum_diff)) {
                current_diff = val_abs_diff + accum_diff;
            } else {
                /* accum_diff is NaN: check boundary */
                double boundary = (double)dev_info->err1_th_sse_dmean[0];
                if (val_abs_diff > boundary) {
                    current_diff = val_abs_diff;
                }
                /* else keep current_diff unchanged */
            }
        }
    } else {
        /* Past threshold count */
        *param_n = *param_n; /* Keep existing count */
        if (err1_n_last == n_current) {
            /* Exactly at threshold: normalize */
            if (mode == 1) {
                is_first = 1;
                current_diff = accum_diff;
            } else {
                is_first = 1;
                current_diff = (accum_diff / (double)n_current) *
                               (double)dev_info->err1_th_n2[0][1];
                accum_mean = (accum_mean / (double)n_current) *
                             (double)dev_info->err1_th_n2[0][0];
            }
        } else {
            /* Past threshold: use stored value */
            accum_mean = *param_mean;
        }
    }

    *param_mean = accum_mean;
    *param_diff = current_diff;
    *param_is_first = is_first;
}

/*
 * err1_TD_var_update: Rotate 90-element variance tracking arrays.
 *
 * From Ghidra @ 0007e9fc and ARM disasm @ 0006e9fc:
 *   For i = 0..89:
 *     dest_time[i] = src_time[i]
 *     dest_val[i]  = src_val[i]
 *     dest_seq[i]  = 0
 *     src_time[i]  = 0
 *     src_val[i]   = 0.0
 *   dest_sum = src_sum
 *   src_sum = 0
 */
void err1_TD_var_update(uint16_t *dest_seq, double *dest_val, uint32_t *dest_time,
                        uint16_t *dest_sum,
                        double *src_val, uint32_t *src_time,
                        uint16_t *src_sum)
{
    for (int i = 0; i < 90; i++) {
        dest_time[i] = src_time[i];
        dest_val[i] = src_val[i];
        dest_seq[i] = 0;
        src_time[i] = 0;
        src_val[i] = 0.0;
        /* The original also zeros two adjacent 4-byte words of src_val,
         * which is the same as zeroing the 8-byte double */
    }
    *dest_sum = *src_sum;
    *src_sum = 0;
}

/*
 * err1_TD_trio_update: Rotate 90 x 3-element trio state arrays.
 *
 * From Ghidra @ 0007ea48 and ARM disasm @ 0006ea48:
 *   For i = 0..89:
 *     For j = 0..2:
 *       dest_time[i*3+j] = src_time[i*3+j]
 *       src_time[i*3+j]  = 0
 *       dest_val[i*3+j]  = src_val[i*3+j]
 *       src_val[i*3+j]   = 0.0
 *     dest_break_flag[i]  = 0
 *   dest_flag = src_flag
 *   src_flag  = 0
 *   src_any_result = 0
 *
 * Note: The original uses offset increments:
 *   param_1 (dest_val) += 0x18 (24 bytes = 3 doubles) per outer iteration
 *   param_4 (src_val) += 0x18 per outer iteration
 *   param_2 (dest_time) += 0x0c (12 bytes = 3 uint32_t) per outer iteration
 *   param_5 (src_time) += 0x0c per outer iteration
 */
void err1_TD_trio_update(double *dest_val, uint32_t *dest_time,
                         uint8_t *dest_flag,
                         double *src_val, uint32_t *src_time,
                         uint8_t *src_flag,
                         uint8_t *dest_break_flag,
                         uint8_t *src_any_result)
{
    for (int i = 0; i < 90; i++) {
        for (int j = 0; j < 3; j++) {
            int idx = i * 3 + j;
            dest_time[idx] = src_time[idx];
            src_time[idx] = 0;
            dest_val[idx] = src_val[idx];
            src_val[idx] = 0.0;
        }
        dest_break_flag[i] = 0;
    }
    *dest_flag = *src_flag;
    *src_flag = 0;
    *src_any_result = 0;
}

/* ────────────────────────────────────────────────────────────────────
 * Group C: Functions from ARM disassembly
 * ──────────────────────────────────────────────────────────────────── */

/*
 * solve_linear: Gaussian elimination with partial pivoting for NxN system.
 *
 * From ARM disasm @ 0006d458 / 00060030:
 *
 * The function solves a linear system Ax = b using Gaussian elimination.
 * The augmented matrix [A|b] is passed as separate row pointers.
 *
 * Layout: Each row has (n_var + 1) doubles = the row of A plus the RHS value.
 *         The stride per row is 6 doubles (0x30 bytes) in the original.
 *
 * The algorithm:
 *   1. Validation: n_eq >= 1, n_var >= 1, n_eq <= 5, n_var <= 5
 *   2. Forward elimination with partial pivoting (find max |pivot|)
 *   3. Back substitution to produce result vector
 *
 * Parameters:
 *   row0..row3: pointers to the first 4 rows (additional rows on stack)
 *   result: output array of n_var doubles
 *   n_eq: number of equations
 *   n_var: number of variables
 */
void solve_linear(double *row0, double *row1, double *row2, double *row3,
                  double *result, int8_t n_eq, int8_t n_var)
{
    if (n_eq < 1 || n_var < 1 || n_eq > 5 || n_var > 5) {
        return;
    }

    /* Copy rows into local augmented matrix.
     * Row stride = 6 doubles (matching the original 0x30 byte stride).
     * We use n_var + 1 columns (coefficients + RHS). */
    int cols = n_var + 1;
    double matrix[5][6]; /* max 5 rows, 6 cols */
    memset(matrix, 0, sizeof(matrix));

    /* The original passes rows via r0-r3 (first 4) and stack (5th).
     * We receive row0..row3 directly. */
    double *rows[5] = { row0, row1, row2, row3, NULL };
    for (int i = 0; i < n_eq && i < 4; i++) {
        if (rows[i]) {
            for (int j = 0; j < cols; j++) {
                matrix[i][j] = rows[i][j];
            }
        }
    }

    /* Forward elimination with partial pivoting */
    for (int col = 0; col < n_eq - 1; col++) {
        /* Find pivot row: max absolute value in column */
        int max_row = col;
        double max_val = fabs(matrix[col][col]);
        for (int row = col + 1; row < n_eq; row++) {
            double abs_val = fabs(matrix[row][col]);
            if (abs_val > max_val) {
                max_val = abs_val;
                max_row = row;
            }
        }

        /* Swap rows if needed */
        if (max_row != col) {
            for (int j = 0; j < cols; j++) {
                double tmp = matrix[col][j];
                matrix[col][j] = matrix[max_row][j];
                matrix[max_row][j] = tmp;
            }
        }

        /* Eliminate below pivot */
        for (int row = col + 1; row < n_eq; row++) {
            double factor = -matrix[row][col] / matrix[col][col];
            for (int j = 0; j < cols; j++) {
                matrix[row][j] += factor * matrix[col][j];
            }
        }
    }

    /* Back substitution */
    for (int i = n_eq - 1; i >= 0; i--) {
        double val = matrix[i][n_var]; /* RHS */
        for (int j = i + 1; j < n_var; j++) {
            val -= matrix[i][j] * result[j];
        }
        result[i] = val / matrix[i][i];
    }
}

/*
 * apply_simple_smooth: Smoothing helper.
 *
 * From ARM disasm @ 0006d608 / 000601e0:
 *
 * Parameters:
 *   idx (r0/r5): current index position
 *   data (r1/r8): pointer to 10-element double array of signal data
 *   output (r2/r4): pointer to 7-element output array
 *   dev_info: device info (for w_sg coefficients and coef_length)
 *
 * Algorithm:
 *   1. If coef_length > idx (not enough data):
 *      Copy 7 doubles from data[coef_length-7] into output.
 *   2. Else compute std of the data array:
 *      a. If std < threshold (0x3ee4f8b5_88e368f1 ~ 1e-8):
 *         Copy 7 doubles from data[3] into output (pass-through).
 *      b. Else:
 *         - Apply Savitzky-Golay smoothing (smooth_sg) with the w_sg coefficients.
 *         - Average adjacent pairs: smooth_avg[i] = (sg[i] + sg[i+2]) * 0.5
 *         - Copy 7 elements from smooth_avg[3..9] into output.
 */
void apply_simple_smooth(uint8_t idx, double *data, double *output,
                         struct air1_opcal4_device_info_t *dev_info)
{
    uint8_t coef_len = (uint8_t)dev_info->coef_length;

    if (coef_len > idx) {
        /* Not enough data: copy last 7 elements from data */
        for (int i = 0; i < 7; i++) {
            output[i] = data[coef_len - 7 + i];
        }
        return;
    }

    /* Compute std of the 10-element data array */
    double std = math_std(data, 10);

    /* Threshold from the literal pool: 0x3ee4f8b5_88e368f1 ~ 1e-8 */
    double threshold = 1.0e-8;

    if (std < threshold) {
        /* Low variance: pass through data[3..9] directly */
        for (int i = 0; i < 7; i++) {
            output[i] = data[3 + i];
        }
        return;
    }

    /* Apply Savitzky-Golay smoothing */
    double sg[10];
    double smoothed[10];
    memset(sg, 0, sizeof(sg));
    memset(smoothed, 0, sizeof(smoothed));

    /* SG convolution: for each output position, apply the w_sg coefficients.
     * The w_sg_x100 array in device_info has 7 coefficients. */
    double w[7];
    for (int i = 0; i < 7; i++) {
        w[i] = (double)dev_info->w_sg_x100[i] / 100.0;
    }

    /* Apply the SG filter: convolve data with the coefficient window */
    for (int i = 3; i < 10; i++) {
        double val = 0.0;
        for (int j = 0; j < 7; j++) {
            int di = i - 3 + j;
            if (di >= 0 && di < 10) {
                val += w[j] * data[di];
            }
        }
        sg[i] = val;
    }

    /* Copy SG result to smoothed buffer */
    for (int i = 0; i < 10; i++) {
        smoothed[i] = sg[i];
    }

    /* Average adjacent pairs with stride 2:
     * smooth_avg[i] = (smoothed[i] + smoothed[i+2]) * 0.5
     * for i = 1..8 (offset by 1 from the original) */
    double smooth_avg[10];
    memset(smooth_avg, 0, sizeof(smooth_avg));

    for (int i = 0; i < 8; i++) {
        smooth_avg[i + 1] = (sg[i] + sg[i + 2]) * 0.5;
    }

    /* Copy 7 elements from smooth_avg[3..9] into output */
    for (int i = 0; i < 7; i++) {
        output[i] = smooth_avg[3 + i];
    }
}

/*
 * fit_simple_regression: Simple linear regression (NaN-aware).
 *
 * From ARM disasm @ 0006e210:
 *
 * Parameters:
 *   x (r0/r4): array of x values
 *   y (r1/r6): array of y values
 *   n (r2/r5): number of data points
 *   result (r3/r8): output [slope, intercept]
 *
 * Algorithm:
 *   1. Filter: skip pairs where either x[i] or y[i] is NaN.
 *   2. Compute means of valid x and y values.
 *   3. Compute slope = sum((x[i]-mean_x)(y[i]-mean_y)) / sum((x[i]-mean_x)^2)
 *   4. Compute intercept = mean_y - slope * mean_x.
 *
 * The ARM code allocates 2 * 0x960 = 4800 bytes on stack (300 doubles each
 * for cleaned x and y arrays).
 */
void fit_simple_regression(double *x, double *y, int n, double *result)
{
    /* Filter NaN pairs and compute sums simultaneously */
    double clean_x[300];
    double clean_y[300];
    int valid = 0;

    double sum_x = 0.0;
    double sum_y = 0.0;

    for (int i = 0; i < n; i++) {
        /* Only include if both x[i] and y[i] are not NaN */
        if (!isnan(y[i]) && !isnan(x[i])) {
            clean_x[valid] = y[i]; /* Note: y goes into clean_x (matches ARM register assignment) */
            clean_y[valid] = x[i]; /* Note: x goes into clean_y */
            sum_x += y[i];
            sum_y += x[i];
            valid++;
        }
    }

    /* Use int for count — original binary uses uint8_t register but n is
     * always <= 300 due to the clean array size. Using int avoids silent
     * wraparound if n > 255. */
    int count = valid;
    double mean_x = sum_x / (double)count;
    double mean_y = sum_y / (double)count;

    /* Compute slope: sum((y_i - mean_y)(x_i - mean_x)) / sum((y_i - mean_y)^2) */
    double num = 0.0;
    double den = 0.0;

    for (int i = 0; i < valid; i++) {
        double dx = clean_x[i] - mean_x;
        double dy = clean_y[i] - mean_y;
        num += dy * dx;
        den += dy * dy;
    }

    double slope = num / den;
    double intercept = mean_x - slope * mean_y;

    result[0] = slope;
    result[1] = intercept;
}

/*
 * f_rsq: R-squared calculation.
 *
 * From ARM disasm @ 0006e310:
 *
 * Parameters:
 *   coeffs (r0/r5): [slope, intercept] array
 *   y_obs (r1/r6): observed y values (the predictor for predicted values)
 *   x_vals (r2/r8): actual x values (observed outcomes)
 *   n (r3/r9): number of data points
 *
 * Algorithm:
 *   1. Compute predicted values: y_pred[i] = slope * y_obs[i] + intercept
 *   2. Compute mean of x_vals (actual observed values).
 *   3. Compute SS_res = sum((x_vals[i] - mean)^2)
 *      and SS_pred = sum((y_pred[i] - mean)^2)
 *   4. If SS_res < epsilon (~1e-14): return NaN.
 *   5. R2 = SS_pred / SS_res
 *   6. If |R2| == Inf or isnan(R2): return NaN.
 *   7. Return R2.
 *
 * The threshold constant at 0x6e3e8 is 0x3e45798e_e2308c3a ~ 1e-8.
 * The Inf constant at 0x6e3f0 is 0x7ff00000_00000000.
 */
double f_rsq(double *coeffs, double *y_obs, double *x_vals, int n)
{
    double slope = coeffs[0];
    double intercept = coeffs[1];

    /* Compute predicted values */
    double y_pred[300];
    for (int i = 0; i < n; i++) {
        y_pred[i] = slope * y_obs[i] + intercept;
    }

    /* Compute mean of x_vals */
    double mean = math_mean(x_vals, (uint16_t)n);

    /* Compute sum of squared residuals and predictions */
    double ss_res = 0.0;  /* sum((x_vals[i] - mean)^2) = SS_tot */
    double ss_pred = 0.0; /* sum((y_pred[i] - mean)^2) */

    for (int i = 0; i < n; i++) {
        double dx = x_vals[i] - mean;
        ss_res += dx * dx;

        double dp = y_pred[i] - mean;
        ss_pred += dp * dp;
    }

    /* Check for degenerate case: very small total sum of squares */
    double epsilon = 1.0e-8;
    if (ss_res < epsilon) {
        return NAN;
    }

    /* Compute R-squared */
    double r2 = ss_pred / ss_res;

    /* Check for infinity or NaN */
    if (isinf(r2) || isnan(r2)) {
        return NAN;
    }

    return r2;
}
