#include "signal_processing.h"
#include "math_utils.h"
#include "loess_kernel.h"
#include <math.h>
#include <string.h>

/*
 * Savitzky-Golay smoothing filter.
 *
 * Maintains a sliding window of 10 signal values and produces 6 smoothed outputs
 * using weighted convolution with 7 coefficients (w_sg_x100).
 *
 * From the ARM disassembly (smooth_sg @ 0x6ccbc):
 * - Input: 10 signals (sig_in), 10 sequences (seq_in), 10 frep flags
 * - d0 = total weight sum for normalization
 * - Computes differences from last element, weights them, then accumulates
 * - Writes 10 outputs (sig_out), 10 sequences (seq_out), 6 frep flags
 */
void smooth_sg(const double *sig_in, const uint16_t *seq_in, const uint8_t *frep_in,
               double *sig_out, uint16_t *seq_out, uint8_t *frep_out,
               double new_sig, uint16_t new_seq, uint8_t new_frep,
               const uint8_t *w_sg_x100)
{
    /* Compute total weight */
    double total_weight = 0.0;
    double weights[7];
    for (int i = 0; i < 7; i++) {
        weights[i] = (double)w_sg_x100[i] / 100.0;
        total_weight += weights[i];
    }
    if (total_weight <= 0.0)
        total_weight = 1.0;

    /* Shift the input buffers: move [1..9] to [0..8], put new at [9] */
    double sig_buf[10];
    uint16_t seq_buf[10];
    uint8_t frep_buf[10];
    for (int i = 0; i < 9; i++) {
        sig_buf[i] = sig_in[i + 1];
        seq_buf[i] = seq_in[i + 1];
    }
    sig_buf[9] = new_sig;
    seq_buf[9] = new_seq;

    for (int i = 0; i < 5; i++)
        frep_buf[i] = frep_in[i + 1];
    frep_buf[5] = new_frep;

    /* Savitzky-Golay convolution: produce 7 smoothed values from positions 3..9 */
    /* The kernel is centered, so for output[j] we use sig_buf[j-3..j+3] */
    /* But the ARM code computes differences from sig_buf[9] (the last element),
       weights them, accumulates, then adds back sig_buf[9] * total_weight */
    double ref = sig_buf[9]; /* reference signal = last element */

    /* Positions 0-2: keep shifted buffer values (unsmoothed) */
    for (int i = 0; i < 3; i++)
        sig_out[i] = sig_buf[i];

    /* Positions 3-9: SG weighted average using elements 0..6.
     * smoothed = sum(w[k] * (sig_buf[idx] - ref)) for valid idx in [0,6].
     * Normalize by total_weight to get weighted average. */
    for (int j = 3; j < 10; j++) {
        double acc = 0.0;
        for (int k = -3; k <= 3; k++) {
            int idx = j + k;
            if (idx >= 0 && idx <= 6) {
                acc += weights[k + 3] * (sig_buf[idx] - ref);
            }
        }
        sig_out[j] = acc / total_weight + ref;
    }

    /* Copy sequence and frep to output */
    memcpy(seq_out, seq_buf, 10 * sizeof(uint16_t));
    memcpy(frep_out, frep_buf, 6);
}

/*
 * Weighted least-squares recalibration.
 * From ARM disassembly (regress_cal @ 0x6ce38, 462 instructions).
 *
 * Maintains a circular buffer of (input, output, slope, ycept) tuples.
 * Adds new calibration point, performs weighted regression.
 */
void regress_cal(const double *input, const double *output,
                 const double *slope_arr, const double *ycept_arr,
                 uint8_t n, double new_input, double new_output,
                 double *new_slope, double *new_ycept,
                 double *result_input, double *result_output,
                 double *result_slope, double *result_ycept)
{
    /* Simple implementation: if we have at least 2 points, do linear regression */
    double all_in[8], all_out[8];
    int total = 0;

    for (int i = 0; i < n && i < 7; i++) {
        all_in[total] = input[i];
        all_out[total] = output[i];
        total++;
    }
    all_in[total] = new_input;
    all_out[total] = new_output;
    total++;

    if (total >= 2) {
        fit_simple_regression(all_in, all_out, total, new_slope, new_ycept);
    } else {
        *new_slope = 1.0;
        *new_ycept = 0.0;
    }

    /* Copy results back */
    for (int i = 0; i < total && i < 7; i++) {
        result_input[i] = all_in[i];
        result_output[i] = all_out[i];
        result_slope[i] = *new_slope;
        result_ycept[i] = *new_ycept;
    }
}

/*
 * Parallelogram boundary check for calibration slope/intercept validity.
 * From Ghidra decompilation (check_boundary @ 0x6ffb0).
 *
 * Checks if (slope, ycept) falls within a parallelogram defined by:
 * - slope_min <= slope <= slope_max
 * - ycept_min <= ycept <= ycept_max
 * - Additional diagonal constraint from corner_offset
 */
uint8_t check_boundary(double slope, double ycept,
                       double slope_min, double slope_max,
                       double ycept_min, double ycept_max,
                       double corner_offset)
{
    if (ycept < ycept_min || ycept > ycept_max)
        return 0;
    if (slope < slope_min || slope > slope_max)
        return 0;

    /* Diagonal constraint: compute the parallelogram edge */
    double diag_slope = (slope_max - slope_min) / (ycept_min - ycept_max);
    double diag_intercept = slope_max - diag_slope * ycept_min;

    double lower_bound = diag_intercept - corner_offset + diag_slope * ycept;
    double upper_bound = corner_offset + diag_intercept + diag_slope * ycept;

    if (slope < lower_bound || slope > upper_bound)
        return 0;

    return 1;
}

/*
 * Simple exponential smoothing.
 * From ARM disassembly (apply_simple_smooth @ 0x6d608):
 *
 * 1. If array length > threshold (from config), use last 7 elements
 * 2. Compute std; if too low (< ~1e-8), just use last 7 elements
 * 3. Otherwise: apply smooth_sg, then average adjacent pairs with 0.5 weight
 * 4. Output the middle 7 elements
 */
void apply_simple_smooth(double *buffer, uint16_t n, double alpha)
{
    if (n <= 7) return;

    /* The binary checks std(buffer) < threshold (~1e-8) */
    double std_val = math_std(buffer, n);
    if (std_val < 1e-8) {
        /* Just use the last 7 elements as-is */
        return;
    }

    /* Apply Savitzky-Golay smoothing through smooth_sg */
    /* Then average adjacent pairs */
    double tmp[10];
    memcpy(tmp, buffer, n * sizeof(double));

    for (int i = 1; i < n - 1; i++) {
        buffer[i] = (tmp[i] + tmp[i + 1]) * 0.5;
    }
}

/*
 * Regularized DFT smoother for err16 drift detection.
 * From ARM disassembly (smooth1q_err16 @ 0x6d740).
 *
 * Algorithm:
 *   1. Compute Hann penalty weights: w[k] = 2 - 2*cos(2*pi*k/N)
 *   2. For each frequency k, compute DFT coefficients (cos/sin sums),
 *      then apply Tikhonov regularization: coeff / (1 + N * w[k]^2)
 *   3. Inverse DFT reconstruction, normalized by 1/N.
 *
 * This penalizes high-frequency components via the Hann spectral weight,
 * producing a smooth estimate of the underlying signal.
 *
 * Parameters:
 *   in  - input data array (N elements)
 *   out - output smoothed array (N elements, may alias in)
 *   n   - number of data points (N)
 */
void smooth1q_err16(const double *in, double *out, uint16_t n)
{
    if (n == 0) return;

    /* Clear output */
    memset(out, 0, n * sizeof(double));

    for (uint16_t k = 0; k < n; k++) {
        /* DFT: compute cosine and sine coefficients for frequency k */
        double cos_sum = 0.0;
        double sin_sum = 0.0;
        for (uint16_t j = 0; j < n; j++) {
            double angle = 2.0 * M_PI * k * j / n;
            cos_sum += in[j] * cos(angle);
            sin_sum += in[j] * sin(angle);
        }

        /* Hann penalty weight for this frequency */
        double w = 2.0 - 2.0 * cos(2.0 * M_PI * k / n);

        /* Tikhonov regularization: suppress high frequencies */
        double reg = 1.0 / (1.0 + n * w * w);
        cos_sum *= reg;
        sin_sum *= reg;

        /* Inverse DFT: accumulate contribution to each output sample */
        for (uint16_t j = 0; j < n; j++) {
            double angle = 2.0 * M_PI * k * j / n;
            out[j] += cos_sum * cos(angle) + sin_sum * sin(angle);
        }
    }

    /* Normalize */
    for (uint16_t j = 0; j < n; j++) {
        out[j] /= n;
    }
}

/*
 * Error threshold calculation helper.
 * From Ghidra decompilation (cal_threshold @ 0x7e908).
 */
void cal_threshold(int16_t *n_ptr, double *mean_ptr, double *max_ptr,
                   uint8_t *flag_ptr, uint32_t seq, int mode,
                   double value, double abs_value,
                   double running_mean, double running_max,
                   uint16_t threshold_seq, uint8_t multi1, uint8_t multi2)
{
    if (seq < threshold_seq) {
        if (seq == 0) {
            *n_ptr = 1;
            running_mean = value;
            if (abs_value > running_max)
                running_max = abs_value;
        } else {
            *n_ptr = (int16_t)(seq + 1);
            if (!isnan(running_mean))
                running_mean += value;
            else
                running_mean = value;
            if (!isnan(running_max) && abs_value > running_max)
                running_max = abs_value;
            else if (isnan(running_max))
                running_max = abs_value;
        }
    } else if (seq == threshold_seq) {
        *flag_ptr = 1;
        if (mode == 1) {
            /* Use accumulated max */
        } else {
            /* Normalize: mean * multi1, max * multi2 */
            running_mean = (running_mean / (double)seq) * (double)multi1;
            running_max = (running_max / (double)seq) * (double)multi2;
        }
    }

    *mean_ptr = running_mean;
    *max_ptr = running_max;
}

/*
 * err1 trio state update - rotates trio arrays.
 * From Ghidra decompilation (err1_TD_trio_update @ 0x7ea48).
 */
void err1_TD_trio_update(double *dst_trio, uint32_t *dst_time,
                         uint8_t *dst_flag, double *src_trio,
                         uint32_t *src_time, uint8_t *src_flag,
                         uint8_t *break_flag, uint8_t *break_flag2)
{
    for (int i = 0; i < 90; i++) {
        for (int j = 0; j < 3; j++) {
            dst_trio[i * 3 + j] = src_trio[i * 3 + j];
            dst_time[i * 3 + j] = src_time[i * 3 + j];
            src_time[i * 3 + j] = 0;
            src_trio[i * 3 + j] = 0.0;
        }
        dst_flag[i] = 0;
    }
    *break_flag = *break_flag2;
    *break_flag2 = 0;
    *dst_flag = 0; /* extra reset */
}

/*
 * err1 variance state update - rotates variance arrays.
 * From Ghidra decompilation (err1_TD_var_update @ 0x7e9fc).
 */
void err1_TD_var_update(uint16_t *dst_seq, double *dst_val,
                        uint32_t *dst_time, uint16_t *dst_count,
                        double *src_val, uint32_t *src_time,
                        uint16_t *src_count)
{
    for (int i = 0; i < 90; i++) {
        dst_val[i] = src_val[i];
        dst_time[i] = src_time[i];
        dst_seq[i] = 0;
        src_time[i] = 0;
        src_val[i] = 0.0;
    }
    *dst_count = *src_count;
    *src_count = 0;
}

/*
 * Average excluding min and max values.
 * From ARM disassembly (cal_average_without_min_max @ 0x6cc68).
 *
 * Iterates through array tracking min, max, and sum.
 * Returns (sum - min - max) / (n - 2).
 */
double cal_average_without_min_max_asm(const double *arr, uint16_t n)
{
    if (n == 0) return 0.0;
    if (n <= 2) return math_mean(arr, n);

    double mn = arr[0], mx = arr[0], sum = 0.0;
    for (uint16_t i = 0; i < n; i++) {
        if (arr[i] > mx) mx = arr[i];
        else if (arr[i] < mn) mn = arr[i];
        sum += arr[i];
    }
    return (sum - mn - mx) / (double)(n - 2);
}

/*
 * Get LOESS kernel weight for evaluation point e and data point d.
 * Table is 90x45; symmetric access pattern:
 *   Forward (e < 45): table[d][e]
 *   Backward (e >= 45): table[89-d][89-e]
 */
static double get_kernel_weight(int e, int d)
{
    if (e < 45)
        return loess_kernel_table[d][e];
    return loess_kernel_table[89 - d][89 - e];
}

/*
 * IRLS LOESS regression on 90 data points.
 * Up to 3 iterations of Tukey bisquare reweighting.
 * Uses 1-based x values (1..90) and pre-computed kernel weights.
 * Outputs 90 fitted values.
 */
static void irls_loess(const double *data90, double *fitted90)
{
    double bisquare_w[90];
    double residuals[90];
    double abs_resid[90];

    for (int i = 0; i < 90; i++)
        bisquare_w[i] = 1.0;

    for (int iter = 0; iter < 3; iter++) {
        for (int e = 0; e < 90; e++) {
            double sw = 0, swx = 0, swxx = 0, swy = 0, swxy = 0;
            for (int d = 0; d < 90; d++) {
                double kw = get_kernel_weight(e, d);
                double w = kw * bisquare_w[d];
                double xi = (double)(d + 1);
                double yi = data90[d];
                double wx = w * xi;
                double wy = w * yi;
                swxx += wx * xi;
                swxy += wy * xi;
                sw += w;
                swx += wx;
                swy += wy;
            }
            double det = swxx * sw - swx * swx;
            if (fabs(det) < 1e-30) {
                double sum = 0;
                for (int i = 0; i < 90; i++) sum += data90[i];
                fitted90[e] = sum / 90.0;
            } else {
                double a0 = (swxx * swy - swx * swxy) / det;
                double a1 = (sw * swxy - swx * swy) / det;
                fitted90[e] = a0 + a1 * (double)(e + 1);
            }
        }

        /* Compute absolute residuals */
        for (int i = 0; i < 90; i++) {
            residuals[i] = data90[i] - fitted90[i];
            abs_resid[i] = fabs(residuals[i]);
        }

        double median_ar = quick_median(abs_resid, 90);
        double threshold = median_ar * 6.0;
        if (threshold < 1e-30)
            break;

        int has_nan = 0;
        for (int i = 0; i < 90; i++) {
            double u = abs_resid[i] / threshold;
            if (u > 1.0) u = 1.0;
            double w = (1.0 - u * u);
            w = w * w;
            bisquare_w[i] = w;
            if (isnan(w)) has_nan = 1;
        }
        if (has_nan) break;
    }
}

/*
 * Running median filter: for each group of 6, compute 6 medians
 * with expanding/shrinking windows [3, 4, 5, 6, 5, 4].
 * Input: 30 values, output: 30 medians.
 */
static void running_medians(const double *in30, double *out30)
{
    for (int g = 0; g < 5; g++) {
        const double *grp = in30 + g * 6;
        double tmp[6];

        /* Window of 3: grp[0..2] */
        memcpy(tmp, grp, 3 * sizeof(double));
        out30[g * 6 + 0] = math_median(tmp, 3);

        /* Window of 4: grp[0..3] */
        memcpy(tmp, grp, 4 * sizeof(double));
        out30[g * 6 + 1] = math_median(tmp, 4);

        /* Window of 5: grp[0..4] */
        memcpy(tmp, grp, 5 * sizeof(double));
        out30[g * 6 + 2] = math_median(tmp, 5);

        /* Window of 6: grp[0..5] */
        memcpy(tmp, grp, 6 * sizeof(double));
        out30[g * 6 + 3] = math_median(tmp, 6);

        /* Window of 5: grp[1..5] */
        memcpy(tmp, grp + 1, 5 * sizeof(double));
        out30[g * 6 + 4] = math_median(tmp, 5);

        /* Window of 4: grp[2..5] */
        memcpy(tmp, grp + 2, 4 * sizeof(double));
        out30[g * 6 + 5] = math_median(tmp, 4);
    }
}

/*
 * FIR filter on running medians.
 * 7-tap coefficients: [-0.25, 1.0, 1.75, 2.0, 1.75, 1.0, -0.25]
 * Uses 3 overlap values from previous call (prev3).
 * Input: 30 medians, output: 30 filtered values.
 */
static void fir_filter_medians(const double *prev3, const double *medians30,
                               double *out30)
{
    static const double fir_c[7] = {-0.25, 1.0, 1.75, 2.0, 1.75, 1.0, -0.25};
    double extended[33]; /* prev3[3] + medians30[30] */
    memcpy(extended, prev3, 3 * sizeof(double));
    memcpy(extended + 3, medians30, 30 * sizeof(double));

    /* Main FIR: positions 0..26 */
    for (int k = 0; k < 27; k++) {
        double val = 0;
        for (int j = 0; j < 7; j++)
            val += fir_c[j] * extended[k + j];
        out30[k] = val / 7.0;
    }

    /* Tail: shortened FIR for positions 27..29 */
    const double *v = medians30 + 24; /* last 6 medians */
    out30[27] = (-0.25*v[0] + v[1] + 1.75*v[2] + 2*v[3] + 1.75*v[4] + v[5]) / 7.25;
    out30[28] = (-0.25*v[1] + v[2] + 1.75*v[3] + 2*v[4] + 1.75*v[5]) / 6.25;
    out30[29] = (-0.25*v[2] + v[3] + 1.75*v[4] + 2*v[5]) / 4.5;
}

/*
 * Modified Hampel filter for per-sample outlier removal.
 *
 * From ARM disassembly (0x639d0-0x63c0c in air1_opcal4_algorithm):
 * - Sliding window of 6 from buffer [prev5, tran_inA[0:30]]
 * - z = (value - median) / scaled_MAD, threshold |z| > 1.5
 * - Replacement: buf[i+4] ± scaled_MAD
 * - Updates replacement buffer as it goes (later iterations see corrected values)
 * - Skipped for call_count <= 1 (first call)
 */
static void per_sample_hampel_filter(const double *tran_inA,
                                     double *per_sample,
                                     double *prev5_raw,
                                     double *prev5_corrected,
                                     int8_t *outlier_fifo)
{
    /* Determine detection buffer: use corrected if recent outlier history is heavy */
    int fifo_sum = 0;
    for (int i = 0; i < 6; i++)
        fifo_sum += (outlier_fifo[i] < 0) ? -outlier_fifo[i] : outlier_fifo[i];
    const double *prev5 = (fifo_sum >= 4) ? prev5_corrected : prev5_raw;

    /* Build detection buffer: [prev5, tran_inA] = 35 values */
    double buffer[35];
    memcpy(buffer, prev5, 5 * sizeof(double));
    memcpy(buffer + 5, tran_inA, 30 * sizeof(double));

    /* Build replacement buffer (modified in-place as outliers are found) */
    double repl_buf[35];
    memcpy(repl_buf, prev5_corrected, 5 * sizeof(double));
    memcpy(repl_buf + 5, tran_inA, 30 * sizeof(double));

    memcpy(per_sample, tran_inA, 30 * sizeof(double));
    int max_outlier_idx = -1;

    for (int i = 0; i < 30; i++) {
        /* Sliding window of 6 consecutive values from buffer[i:i+6] */
        double window[6];
        memcpy(window, buffer + i, 6 * sizeof(double));

        /* Sort window to find median */
        double sw[6];
        memcpy(sw, window, 6 * sizeof(double));
        for (int a = 0; a < 5; a++)
            for (int b = a + 1; b < 6; b++)
                if (sw[a] > sw[b]) {
                    double t = sw[a]; sw[a] = sw[b]; sw[b] = t;
                }
        double median = (sw[2] + sw[3]) / 2.0;

        /* Compute MAD (median absolute deviation) */
        double abs_dev[6];
        for (int j = 0; j < 6; j++)
            abs_dev[j] = fabs(window[j] - median);
        for (int a = 0; a < 5; a++)
            for (int b = a + 1; b < 6; b++)
                if (abs_dev[a] > abs_dev[b]) {
                    double t = abs_dev[a]; abs_dev[a] = abs_dev[b]; abs_dev[b] = t;
                }
        double mad = (abs_dev[2] + abs_dev[3]) / 2.0;

        /* Compute scaled MAD with fallbacks */
        double scaled_mad;
        if (mad >= 1e-14) {
            scaled_mad = mad * 1.486;
        } else {
            double mean_ad = 0;
            for (int j = 0; j < 6; j++)
                mean_ad += fabs(window[j] - median);
            mean_ad /= 6.0;
            if (mean_ad > 0.001)
                scaled_mad = mean_ad * 1.253314;
            else
                continue; /* No outlier possible */
        }

        double z = (tran_inA[i] - median) / scaled_mad;

        if (z > 1.5) {
            per_sample[i] = repl_buf[i + 4] + scaled_mad;
            repl_buf[i + 5] = per_sample[i];
            max_outlier_idx = i;
        } else if (z < -1.5) {
            per_sample[i] = repl_buf[i + 4] - scaled_mad;
            repl_buf[i + 5] = per_sample[i];
            max_outlier_idx = i;
        }
    }

    /* Update state for next call */
    memcpy(prev5_raw, tran_inA + 25, 5 * sizeof(double));
    memcpy(prev5_corrected, per_sample + 25, 5 * sizeof(double));

    /* Shift outlier FIFO left by 1, append new marker */
    memmove(outlier_fifo, outlier_fifo + 1, 5);
    outlier_fifo[5] = 0;
}

/*
 * Full LOESS pipeline: tran_inA[30] → tran_inA_1min[5].
 *
 * Algorithm (from ARM disassembly):
 *   1. Modified Hampel filter for per-sample outlier removal (seq >= 2)
 *   2. If call_count >= 3 and time_gap < 897.2: IRLS LOESS on history[60]+per_sample[30]
 *   3. Running median filter (5 groups of 6)
 *   4. If call_count >= 2 and time_gap < 327.2: FIR filter using prev3
 *   5. cal_average_without_min_max per group of 6
 *   6. Update state: shift history, store per_sample, store last 3 medians
 */
void compute_tran_inA_1min(const double *tran_inA,
                           double *tran_inA_1min,
                           double *history60,
                           double *prev3,
                           double *prev5_raw,
                           double *prev5_corrected,
                           int8_t *outlier_fifo,
                           uint32_t call_count,
                           double time_gap)
{
    /* Step 1: Per-sample outlier removal (Modified Hampel filter) */
    double per_sample[30];
    if (call_count >= 2) {
        per_sample_hampel_filter(tran_inA, per_sample,
                                 prev5_raw, prev5_corrected, outlier_fifo);
    } else {
        memcpy(per_sample, tran_inA, 30 * sizeof(double));
        /* Initialize prev5 state on first call */
        memcpy(prev5_raw, tran_inA + 25, 5 * sizeof(double));
        memcpy(prev5_corrected, tran_inA + 25, 5 * sizeof(double));
        memmove(outlier_fifo, outlier_fifo + 1, 5);
        outlier_fifo[5] = 0;
    }

    /* Step 2: IRLS LOESS or pass-through */
    double intermediate30[30];
    if (call_count >= 3 && time_gap < 897.2) {
        double data90[90];
        memcpy(data90, history60, 60 * sizeof(double));
        memcpy(data90 + 60, per_sample, 30 * sizeof(double));

        double fitted90[90];
        irls_loess(data90, fitted90);
        memcpy(intermediate30, fitted90 + 60, 30 * sizeof(double));
    } else {
        memcpy(intermediate30, per_sample, 30 * sizeof(double));
    }

    /* Step 3: Running median filter */
    double medians30[30];
    running_medians(intermediate30, medians30);

    /* Step 4: FIR filter */
    double fir_out[30];
    if (call_count >= 2 && time_gap < 327.2) {
        fir_filter_medians(prev3, medians30, fir_out);
    } else {
        memcpy(fir_out, medians30, 30 * sizeof(double));
    }

    /* Step 5: cal_average_without_min_max per group of 6 */
    for (int g = 0; g < 5; g++)
        tran_inA_1min[g] = cal_average_without_min_max(fir_out + g * 6, 6);

    /* Step 6: Update state */
    /* Shift history: [0:30] = [30:60], [30:60] = per_sample */
    memmove(history60, history60 + 30, 30 * sizeof(double));
    memcpy(history60 + 30, per_sample, 30 * sizeof(double));

    /* Store last 3 raw medians (pre-FIR) for next call's FIR overlap */
    prev3[0] = medians30[27];
    prev3[1] = medians30[28];
    prev3[2] = medians30[29];
}
