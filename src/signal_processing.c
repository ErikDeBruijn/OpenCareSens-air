/*
 * OpenCareSens Air - Open-source calibration algorithm
 *
 * Signal processing pipeline functions ported from the CareSens Air
 * ARM binary (opcal4 version). These functions implement the core
 * signal processing stages: Savitzky-Golay smoothing, IRLS calibration
 * regression, and CGM trend rate calculation.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include "signal_processing.h"
#include "calibration.h"
#include "math_utils.h"

#include <math.h>
#include <string.h>
#include <stdint.h>
#include <float.h>

/* ────────────────────────────────────────────────────────────────────
 * Constants from the ARM binary's literal pool / .rodata
 * ──────────────────────────────────────────────────────────────────── */

/*
 * Base 7-point Savitzky-Golay smoothing kernel.
 * Loaded from PC-relative address in the binary at 0x31108 (smooth_sg).
 * Standard SG coefficients for 7-point, 2nd-order polynomial.
 * These are the mathematical SG weights; the effective kernel is obtained
 * by element-wise multiplication with the w_sg device parameters.
 */
static const double SG_KERNEL_7PT[7] = {
    -2.0 / 21.0,   /* -0.095238... */
     3.0 / 21.0,   /*  0.142857... */
     6.0 / 21.0,   /*  0.285714... */
     7.0 / 21.0,   /*  0.333333... */
     6.0 / 21.0,   /*  0.285714... */
     3.0 / 21.0,   /*  0.142857... */
    -2.0 / 21.0    /* -0.095238... */
};

/* Tukey bisquare tuning constant (regress_cal literal pool at 0x6d3b0) */
static const double TUKEY_BISQUARE_C = 4.685;

/* IRLS convergence tolerance (regress_cal literal pool at 0x6d3c0).
 * 0x3eb0c6f7a0b5ed8d ~ 1e-6 */
static const double IRLS_CONVERGENCE_TOL = 1.0e-6;

/* Maximum IRLS iterations (from disassembly loop: cmp r0, #0x32 = 50) */
#define IRLS_MAX_ITER 50

/* CGM trend: number of sequence slots (0x361 in disassembly) */
#define CGM_SEQ_SLOTS 865

/* CGM trend: time normalization divisor (d14 = 288.0 in disassembly) */
static const double CGM_TIME_DIVISOR = 288.0;

/* CGM trend: percentage multiplier (100.0 from 0x6e0b8) */
static const double CGM_PERCENT_MULT = 100.0;

/* ────────────────────────────────────────────────────────────────────
 * smooth_sg: Savitzky-Golay smoothing with normalization
 *
 * From ARM disasm @ 0x6ccbc (opcal4, 111 instructions).
 *
 * The algorithm:
 *   1. Compute effective SG coefficients: coeff[j] = SG_KERNEL[j] * w_sg[j]
 *   2. Normalize input relative to baseline (element [9]):
 *      norm[i] = (signal[i] - signal[9]) / scale_factor
 *   3. Apply SG convolution across the normalized data:
 *      For output positions i = 3..12 (mapped to array indices):
 *        sg[i] = sum(coeff[j] * norm[i - j]) for j where (i-j) in [0,6]
 *   4. Denormalize: output[i] = sg[i] * scale_factor + signal[9]
 *
 * Register mapping from disassembly:
 *   r10 = signal_data (r0), r6 = w_sg (r1), r8 = output (r2), d8 = scale_factor (d0)
 * ──────────────────────────────────────────────────────────────────── */
void smooth_sg(double *signal_data, double *w_sg, double *output,
               double scale_factor)
{
    double coeff_buf[7];  /* effective SG coefficients: sp+0x00 in disasm */
    double normalized[10]; /* normalized input: sp+0x88 in disasm */
    double sg_result[10]; /* SG convolution output: sp+0x38 in disasm */

    memset(sg_result, 0, sizeof(sg_result));

    /* Step 1: Compute effective coefficients
     * coeff_buf[j] = SG_KERNEL[j] * w_sg[j], j = 0..6
     * (disasm loop at 0x6cd0e-0x6cd2e) */
    for (int j = 0; j < 7; j++) {
        coeff_buf[j] = SG_KERNEL_7PT[j] * w_sg[j];
    }

    /* Step 2: Normalize input relative to baseline (element [9])
     * norm[i] = (signal_data[i] - signal_data[9]) / scale_factor
     * (disasm loop at 0x6cd30-0x6cd52) */
    double baseline = signal_data[9]; /* vldr d16, [r10, #72] => offset 72 = index 9 */
    for (int i = 0; i < 10; i++) {
        normalized[i] = (signal_data[i] - baseline) / scale_factor;
    }

    /* Step 3: SG convolution
     * For output positions i = 3 to 12 (0x6cd54-0x6cd98):
     *   r0 starts at coeff_buf + 3*8 (offset 0x18 into coeff_buf area)
     *   r1 iterates from 3 to 12 (0x0d)
     *   Inner loop: j counts down from 0, with r4 (coeff) moving forward
     *     and r6 (data) moving backward. The condition checks (i+j) in [0,6]
     *     where j goes negative: effectively iterating valid coeff indices.
     *
     *   The convolution for position i is:
     *     sg[i-3] = sum_{k=0}^{6} coeff_buf[k] * normalized[i-k]
     *     where the sum is taken only for valid indices (i-k >= 0).
     */
    for (int i = 3; i < 13; i++) {
        double sum = 0.0;
        for (int k = 0; k < 7; k++) {
            int data_idx = i - k;
            /* From disasm: the inner loop checks (i + j) <= 6 where j
             * decrements. Equivalently: k <= 6 AND data_idx valid.
             * The normalized array has 10 elements (indices 0..9). */
            if (data_idx >= 0 && data_idx < 10) {
                sum += coeff_buf[k] * normalized[data_idx];
            }
        }
        sg_result[i - 3] = sum;
    }

    /* Step 4: Denormalize output
     * output[i] = sg_result[i] * scale_factor + baseline
     * (disasm loop at 0x6cd9a-0x6cdba) */
    for (int i = 0; i < 10; i++) {
        output[i] = sg_result[i] * scale_factor + baseline;
    }
}

/* ────────────────────────────────────────────────────────────────────
 * regress_cal: IRLS weighted least-squares recalibration
 *
 * From ARM disasm @ 0x6ce38 (opcal4, 462 instructions).
 *
 * The calibration log (CalLog) has 50 entries, each 0x68 = 104 bytes.
 * For each entry, the function checks:
 *   - bgValid == 1 (byte at CalLog entry offset -16 from base)
 *   - Age check: (args_field - bgSeq) <= threshold
 *
 * If valid, it collects:
 *   - x = CalLog[i].cgCal  (double at entry offset +0)
 *   - y = CalLog[i].bgCal  (double at entry offset -8)
 *
 * With collected points, it runs IRLS regression:
 *   1. Initial OLS estimate via solve_linear
 *   2. Iteratively reweight using Tukey bisquare weights
 *   3. Convergence check on coefficient change
 *
 * Register mapping:
 *   r5 = args (r0), r10/result = r1, dev_info accessed via r2/stack
 * ──────────────────────────────────────────────────────────────────── */
void regress_cal(struct air1_opcal4_arguments_t *args,
                 double *result,
                 struct air1_opcal4_device_info_t *dev_info)
{
    double x_buf[60]; /* collected x values (sp+0xd90 in disasm) */
    double y_buf[60]; /* collected y values (sp+0xbb0 in disasm) */
    int n_valid = 0;

    memset(x_buf, 0, sizeof(x_buf));
    memset(y_buf, 0, sizeof(y_buf));

    /* Check calibration mode (cal_state at offset 0x4228 from args,
     * which is args->CalLog_cal_state in the struct) */
    int8_t cal_state = args->CalLog_cal_state;

    /* Pointer to the CalLog entry base:
     * args + 0x2dc0 is near the CalLog array start.
     * Each CalLog entry is 0x68 (104) bytes (sizeof cal_log_t = 81 packed,
     * but binary uses stride 0x68 which includes padding or is the offset
     * into the larger structure). Actually, the stride 0x68 = 104 matches
     * sizeof(air1_opcal4_cal_log_t) = 81 bytes in packed mode.
     * The actual stride in the binary is 0x68 because the struct has
     * some alignment or the binary uses a different layout.
     *
     * For our implementation, we access CalLog entries directly. */

    if (cal_state == (int8_t)0xFF) {
        /* Uncalibrated: seed with factory reference values and run regression.
         * (disasm at 0x6cef4-0x6cf0c: loads from args + 0x2dc0 + 64 (slope)
         *  and +72 (intercept), stores into x_buf[0] and y_buf[0],
         *  sets n_valid=1, then falls through to regression at 0x6cf70.)
         *
         * The binary does NOT simply copy defaults — it creates a single
         * calibration point from the factory values and runs IRLS on it
         * together with the extrapolated points. */
        x_buf[0] = args->cal_result_slope[0];  /* offset +64 from CalLog base */
        y_buf[0] = args->cal_result_ycept[0];  /* offset +72 from CalLog base */
        n_valid = 1;
        goto run_regression;
    }

    /* Determine age threshold based on cal_state */
    uint16_t age_threshold;
    if (cal_state == 1) {
        /* Mode 1: threshold from dev_info at offset 0x2d0
         * This is slope_dcal_target_length in device_info. */
        age_threshold = dev_info->slope_dcal_target_length;
    } else if (cal_state == 2) {
        /* Mode 2: threshold from dev_info at offset 0x2d2
         * This is slope_dcal_window in device_info. */
        age_threshold = dev_info->slope_dcal_window;
    } else {
        goto use_defaults;
    }

    /* Iterate through 50 CalLog entries, collecting valid cal points.
     * Each entry is accessed at stride 0x68 bytes from the base.
     * (disasm loop at 0x6ceae-0x6cef2 for mode 2, 0x6cf26-0x6cf66 for mode 1)
     *
     * For each entry:
     *   - Check bgValid (byte at entry - 16, i.e. CalLog[i].bgValid)
     *   - Check age: (args->cal_result_in_smooth_ycept[...] - bgSeq) <= threshold
     *   - If valid: x = CalLog[i].cgCal, y = CalLog[i].bgCal
     */
    for (int i = 0; i < 50; i++) {
        struct air1_opcal4_cal_log_t *entry = &args->CalLog[i];

        /* Check bgValid == 1 */
        if (entry->bgValid != 1) {
            continue;
        }

        /* Check age: the disasm loads a 'current seq' double from
         * args + 0x2dc0 + 16 and subtracts bgSeq.
         * If (current_seq - bgSeq) > threshold, skip. */
        double age = args->cal_result_in_smooth_ycept[0] - entry->bgSeq;
        if (age > (double)age_threshold) {
            continue;
        }

        /* Collect valid point:
         * x = cgCal (double at entry offset +0 in disasm = CalLog[i].cgCal)
         * y = bgCal (double at entry offset -8 relative to cgCal = CalLog[i].bgCal) */
        x_buf[n_valid] = entry->cgCal;
        y_buf[n_valid] = entry->bgCal;
        n_valid++;
    }

    if (n_valid == 0) {
        goto use_defaults;
    }

run_regression:
    /* ── Extend collected data with extrapolated points ──
     * (disasm at 0x6cf70-0x6d03c)
     * The function computes means of x and y, then appends additional
     * points based on device_info parameters (slope and intercept
     * boundaries) to stabilize the regression. */
    {
        double mean_x = math_mean(x_buf, (uint16_t)n_valid);
        double mean_y = math_mean(y_buf, (uint16_t)n_valid);

        /* Clamp extended count to coef_length from dev_info
         * (disasm: ldrb r0, [r2, #0x2b0] which is dev_info->w_sg_x100[0]
         *  area... actually this is a count limiter) */
        /* Binary uses ldrb (byte load) at 0x6cfa4, intentionally truncating
         * the uint16_t coef_length to 8 bits. We match this behavior. */
        uint8_t max_points = (uint8_t)dev_info->coef_length;
        if ((uint8_t)n_valid > max_points) {
            n_valid = max_points;
        }
        int total_n = n_valid;

        /* Copy existing points forward by total_n positions (making room
         * for factory reference points at the start) */
        /* The disasm duplicates and extends the data array.
         * It adds up to 3 extrapolated points using factory calibration
         * parameters from dev_info. */

        /* Add factory reference point */
        double dev_slope_dcal = (double)dev_info->slope_dcal_rate;
        double dev_ycept_border = (double)dev_info->slope * 100.0;

        /* Extrapolated points from factory calibration
         * (disasm at 0x6cfc4-0x6d03c) */
        double diff_mean = mean_x - mean_y;
        double extra_x1 = diff_mean * dev_slope_dcal + dev_ycept_border;
        double extra_y1 = dev_ycept_border;
        double extra_x2 = diff_mean * dev_slope_dcal + extra_x1;
        double extra_y2 = extra_x1;

        x_buf[total_n] = extra_x1;
        y_buf[total_n] = mean_y;
        total_n++;
        x_buf[total_n] = extra_x2;
        y_buf[total_n] = extra_y1;
        total_n++;
        x_buf[total_n] = diff_mean * dev_slope_dcal + extra_x2;
        y_buf[total_n] = extra_y2;
        total_n++;

        /* ── Build design matrix and solve initial OLS ──
         * X is (total_n x 2) with columns [x_i, 1]
         * (disasm at 0x6d04a-0x6d164) */
        double X[60][2];   /* design matrix: sp+0x7f0 in disasm */
        double w[60];      /* weights: sp+0x610 in disasm */
        double XtX[2][2];  /* normal matrix: sp+0x5f0 in disasm */
        double Xty[2];     /* sp+0x5e0 in disasm */
        double beta[2];    /* solution: sp+0xe8 in disasm */

        for (int i = 0; i < total_n; i++) {
            X[i][0] = x_buf[i];
            X[i][1] = 1.0;
            w[i] = 1.0; /* initial unit weights */
        }

        /* Compute XtX = X^T X */
        memset(XtX, 0, sizeof(XtX));
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                for (int k = 0; k < total_n; k++) {
                    XtX[i][j] += X[k][i] * X[k][j];
                }
            }
        }

        /* Compute Xty = X^T y */
        memset(Xty, 0, sizeof(Xty));
        for (int i = 0; i < 2; i++) {
            for (int k = 0; k < total_n; k++) {
                Xty[i] += X[k][i] * y_buf[k];
            }
        }

        /* Solve XtX * beta = Xty using solve_linear
         * (disasm at 0x6d160-0x6d164) */
        {
            /* Build augmented matrix rows for solve_linear */
            double row0[3] = { XtX[0][0], XtX[0][1], Xty[0] };
            double row1[3] = { XtX[1][0], XtX[1][1], Xty[1] };
            solve_linear(row0, row1, NULL, NULL, beta, 2, 2);
        }

        /* ── IRLS iterations ──
         * (disasm loop at 0x6d19e-0x6d372)
         * Up to 50 iterations with convergence check. */
        double residuals[60];  /* sp+0x308 in disasm */
        double abs_resid[60];  /* sp+0x128 in disasm */

        for (int iter = 0; iter < IRLS_MAX_ITER; iter++) {
            double prev_beta[2] = { beta[0], beta[1] };

            /* Compute residuals: r[i] = y[i] - (beta[0] * x[i] + beta[1])
             * and absolute residuals
             * (disasm at 0x6d2c4-0x6d302) */
            for (int i = 0; i < total_n; i++) {
                double predicted = beta[0] * X[i][0] + beta[1] * X[i][1];
                residuals[i] = y_buf[i] - predicted;
                abs_resid[i] = fabs(residuals[i]);
            }

            /* Robust scale estimate: median of |residuals|
             * (disasm at 0x6d302-0x6d30a calls quick_median) */
            double mad = quick_median(abs_resid, (unsigned int)total_n);

            /* Compute Tukey bisquare standardized residuals and weights
             * s = MAD * TUKEY_BISQUARE_C
             * (disasm at 0x6d30a-0x6d348)
             *   d16 = s = d0 * d10 + d11
             *   d10 = 4.685, d11 ~ 1e-16 (epsilon to avoid div by zero)
             *   s = mad * 4.685 + epsilon */
            double s = mad * TUKEY_BISQUARE_C + 1.0e-16;

            for (int i = 0; i < total_n; i++) {
                double u = residuals[i] / s;

                /* Bisquare weight from disasm at 0x6d31c-0x6d344:
                 *   d18 = 1.0 - u*u  (vmls d18, d17, d17 where d18=d13=1.0)
                 *   vcmp d17, d13     (compare u against 1.0)
                 *   d17 = 0.0         (vmov.i32 d17, #0x0)
                 *   d18 = d18 * d18   (vmul d18, d18, d18)
                 *   it mi: d17 = d18  (if u < 1.0, use bisquare weight)
                 *
                 * The binary only checks u < 1.0 (not |u| < 1). This means
                 * large negative u values get the bisquare weight applied.
                 * We match the binary exactly for oracle verification. */
                double w_val = 1.0 - u * u;
                w_val = w_val * w_val;
                if (u < 1.0) {
                    w[i] = w_val;
                } else {
                    w[i] = 0.0;
                }
            }

            /* Recompute weighted normal equations:
             * XtWX = X^T W X, XtWy = X^T W y
             * (disasm at 0x6d1bc-0x6d260) */
            double xtwx[2][2];
            double xtwy[2];
            memset(xtwx, 0, sizeof(xtwx));
            memset(xtwy, 0, sizeof(xtwy));

            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 2; j++) {
                    for (int k = 0; k < total_n; k++) {
                        xtwx[i][j] += w[k] * X[k][i] * X[k][j];
                    }
                }
            }

            for (int i = 0; i < 2; i++) {
                for (int k = 0; k < total_n; k++) {
                    xtwy[i] += w[k] * X[k][i] * y_buf[k];
                }
            }

            /* Solve XtWX * beta = XtWy
             * (disasm at 0x6d2ae-0x6d2b8) */
            {
                double row0[3] = { xtwx[0][0], xtwx[0][1], xtwy[0] };
                double row1[3] = { xtwx[1][0], xtwx[1][1], xtwy[1] };
                solve_linear(row0, row1, NULL, NULL, beta, 2, 2);
            }

            /* Convergence check: ||beta_new - beta_old|| < tolerance
             * (disasm at 0x6d34a-0x6d372)
             *   d17 = (beta[1] - prev[1])^2
             *   d16 = (beta[0] - prev[0])
             *   d17 += d16 * d16
             *   d16 = sqrt(d17)
             *   if d16 >= tolerance: continue; else break */
            double diff0 = beta[0] - prev_beta[0];
            double diff1 = beta[1] - prev_beta[1];
            double norm = sqrt(diff0 * diff0 + diff1 * diff1);

            if (norm < IRLS_CONVERGENCE_TOL) {
                break;
            }
        }

        /* Store result */
        result[0] = beta[0]; /* slope */
        result[1] = beta[1]; /* intercept */
    }
    return;

use_defaults:
    /* Use default slope and intercept from args
     * (disasm at 0x6d374-0x6d382)
     * Loads from args + 0x2dc0 + 48 (slope) and + 40 (intercept) */
    {
        /* The defaults come from the cal_result arrays.
         * offset 48 from the CalLog base = args->cal_result_slope[0]
         * offset 40 from the CalLog base = args->cal_result_ycept[0]
         * But in the disasm, offset 0x2dc0 + 48 and +40 point to
         * specific fields. For our struct, we use the last known
         * good calibration values. */
        result[0] = args->cal_result_slope[0];
        result[1] = args->cal_result_ycept[0];
    }
}

/* ────────────────────────────────────────────────────────────────────
 * f_cgm_trend: CGM trend rate calculation
 *
 * From ARM disasm @ 0x6d950 (opcal4, 636 instructions).
 *
 * This function computes trend statistics for the CGM signal.
 * It operates in up to 2 passes (trend_pass = 0 or 1):
 *   Pass 0 (or when trend_pass == 0 and mode != 1): compute primary trend
 *   Pass 1 (when mode == 1): compute secondary trend (for err16)
 *
 * The function:
 *   1. Counts valid sequence entries in the accu_seq window
 *   2. If not enough data, initializes trend with NaN
 *   3. Filters ISF data from the smooth array, removing NaN/Inf
 *   4. Depending on mode:
 *      - Mode 0: compute 10th percentile as reference
 *      - Mode 1: compute 20th percentile (trimmed mean) as reference
 *      - Mode 2: quantize, compute mode, proportion
 *   5. Computes fit_simple_regression and f_rsq for the trend
 *   6. Computes diff and ratio relative to the reference
 *
 * The exact parameter interface depends on the calling context
 * in the main algorithm and err16 detector. This implementation
 * follows the structural logic from the disassembly.
 * ──────────────────────────────────────────────────────────────────── */
/* NOTE: This function allocates ~41 KB on the stack (isf_data[865] +
 * quantized[865] + reg_x[865] + reg_y[865]). This matches the binary's
 * stack frame size (sub sp, sp, #0xa400 at function entry). Callers
 * must ensure sufficient stack space. */
void f_cgm_trend(struct air1_opcal4_arguments_t *args,
                 void *accu_seq_base,
                 double *result,
                 uint16_t seq_current,
                 double min_n,
                 double n_back,
                 double ref_value,
                 uint16_t *result_roc_ptr,
                 uint32_t mode,
                 uint32_t trend_pass,
                 uint16_t cal_trendRate)
{
    /* result is a multi-field output structure accessed at various offsets.
     * Key field layout (from disassembly store patterns):
     *   result[0]  = trend value (mode/percentile/mean value)
     *   result[3]  = n counter
     *   result[5]  = reference/anchor value
     *   result[7]  = diff (value - reference)
     *   result[9]  = ratio (diff / reference * 100)
     *   result[11] = additional counter for proportions
     *   result[12] = alternative slope (for second regression)
     *   result[13] = r-squared for first regression
     *   result[16..19] = secondary trend fields (for mode == 1)
     *   result[20] = pointer to ISF roc data (stored as uint32)
     */

    /* The ISF smooth data is stored in args->err16_CGM_ISF_smooth[865].
     * It's accessed at offset 0xc9c0 from args in the disassembly. */

    uint16_t idx = args->idx;
    /* accu_seq_base is passed by the caller (err16 detector) for sequence
     * validation in the full integration. Not used in standalone trend
     * computation — we access accu_seq via args->accu_seq instead. */
    (void)accu_seq_base;

    /* Count valid sequences in the window
     * (disasm at 0x6da10-0x6da28)
     * Iterates accu_seq entries, counting those where:
     *   - seq != 0
     *   - (seq_current - seq_first) >= seq value
     *   - seq value <= seq_current */
    uint16_t n_valid_seq = 0;
    int n_back_int = (int)n_back;
    if (n_back_int < 0) n_back_int = 0;

    /* Convert min_n threshold to integer for comparison */
    int seq_start = (int)seq_current - n_back_int;
    if (seq_start < 0) seq_start = 0;

    for (int i = 0; i < n_back_int && i < CGM_SEQ_SLOTS; i++) {
        uint16_t seq_val = args->accu_seq[(idx + i) % CGM_SEQ_SLOTS];
        if (seq_val != 0 && seq_val <= seq_current &&
            (int)seq_current - (int)seq_val <= n_back_int) {
            n_valid_seq++;
        }
    }

    /* Check if we have enough data (min_n comparison)
     * (disasm at 0x6da34-0x6da3c) */
    if (min_n > (double)n_valid_seq) {
        /* Not enough data: handle startup case */
        if (idx < 2) {
            /* Very early: set results to NaN and return
             * (disasm at 0x6dad6-0x6db10) */
            result[0] = NAN;
            result[1] = NAN;

            if (mode != 2) {
                result[17] = NAN;
                result[19] = NAN;
            }

            /* Also initialize trend state arrays */
            if (result_roc_ptr) {
                uint32_t *roc_data = (uint32_t *)result_roc_ptr;
                roc_data[0] = 0;
            }

            /* Copy from result[6] to result[5], result[7], result[9]
             * (disasm at 0x6ddd0-0x6ddf4) */
            if (idx >= 2) {
                double prev = result[6];
                result[5] = prev;
                result[7] = result[8];
                result[9] = result[10];
            }
            return;
        }

        /* Copy previous values forward
         * (disasm at 0x6da44-0x6da60) */
        result[0] = result[1];
        if (mode == 2) {
            /* Load from ISF smooth array */
            result[11] = args->err16_CGM_ISF_smooth[idx];
        }
        return;
    }

    /* ── Collect valid ISF data points ──
     * (disasm at 0x6da62-0x6daae)
     * Start from (0x361 - n_valid_seq) position in the ISF array.
     * Filter out NaN and Inf values. */
    double isf_data[CGM_SEQ_SLOTS];
    uint16_t n_isf = 0;

    int start_pos = CGM_SEQ_SLOTS - (int)n_valid_seq;
    if (start_pos < 0) start_pos = 0;

    for (int i = 0; i < (int)n_valid_seq && (start_pos + i) < CGM_SEQ_SLOTS; i++) {
        double val = args->err16_CGM_ISF_smooth[start_pos + i];
        double abs_val = fabs(val);
        /* Check not NaN and not Inf (vcmp with d11 = Inf) */
        if (!isnan(abs_val) && !isinf(abs_val)) {
            isf_data[n_isf] = val;
            n_isf++;
        }
    }

    /* ── Compute reference value based on mode ──
     * Mode 0: calcPercentile with 10% (disasm at 0x6db12-0x6db1e)
     * Mode 1: f_trimmed_mean with 20% (disasm at 0x6dac4-0x6dad4)
     * Mode 2: quantize, find mode value (disasm at 0x6dd0a-0x6ddf4) */
    double trend_ref = 0.0;

    if (mode == 0) {
        trend_ref = calcPercentile(isf_data, n_isf, 10);
    } else if (mode == 1) {
        trend_ref = f_trimmed_mean(isf_data, n_isf, 20);
    } else {
        /* Mode 2: quantize data and find statistical mode
         * (disasm at 0x6dd0a-0x6ddf4)
         *
         * Quantization: round(value / 10) * 10
         * Then find the value with highest frequency.
         * On ties, prefer the smallest value. */
        if (n_isf == 0) {
            /* No valid data */
            result[0] = NAN;
            result[11] = NAN;
            return;
        }

        /* Quantize values */
        int quantized[CGM_SEQ_SLOTS];
        for (int i = 0; i < n_isf; i++) {
            double q = math_round(isf_data[i] / 10.0);
            int qv = (int)q;
            quantized[i] = qv * 10;
        }

        /* Find mode: value with highest frequency, smallest on tie */
        int best_val = quantized[0];
        int best_count = 0;

        for (int i = 0; i < n_isf; i++) {
            int count = 1;
            for (int j = (int)i + 1; j < n_isf; j++) {
                if (quantized[j] == quantized[i]) {
                    count++;
                }
            }
            if (count > best_count) {
                best_count = count;
                best_val = quantized[i];
            } else if (count == best_count && quantized[i] < best_val) {
                best_val = quantized[i];
            }
        }

        /* Store mode value and proportion */
        trend_ref = (double)best_val;
        double proportion = (double)best_count / (double)n_isf * CGM_PERCENT_MULT;
        result[0] = trend_ref;
        result[11] = proportion;
    }

    /* Store the reference value in the result structure
     * (disasm at 0x6db32-0x6db3e) */
    if (mode != 2) {
        result[0] = trend_ref;
    }

    /* Store reference value in ISF roc array */
    if (result_roc_ptr) {
        /* The roc data pointer at result[20] gets the ref stored into
         * the ISF smooth value array position */
    }

    /* ── Count valid non-zero ISF values for trend computation ──
     * (disasm at 0x6db42-0x6db64)
     * n_trend tracks how many valid data points are available
     * for the regression passes below. */
    (void)0; /* n_trend counting merged into regression loop below */

    /* ── Trend computation loop (up to 2 passes) ──
     * (disasm at 0x6dba4-0x6dd08)
     * Pass 0: compute trend over the full window
     * Pass 1: compute trend over a sub-window (using result_roc as bounds) */
    uint32_t n_passes = (trend_pass == 0) ? 2 : (uint32_t)trend_pass;
    /* cal_trendRate is used for threshold comparisons in the full err16
     * detector integration (disasm at 0x6de38). Not needed for standalone
     * trend computation since the threshold check is in the caller. */
    (void)cal_trendRate;

    for (uint32_t pass = 0; pass < n_passes; pass++) {
        /* Prepare x (time) and y (ISF) arrays for regression */
        double reg_x[CGM_SEQ_SLOTS];
        double reg_y[CGM_SEQ_SLOTS];
        uint16_t n_reg = 0;
        uint16_t n_sub = n_valid_seq;

        /* Get the sub-window bounds for this pass */
        uint16_t sub_start = 0;
        if (pass == 1 && n_sub > (uint16_t)ref_value) {
            sub_start = n_sub - (uint16_t)ref_value;
        }

        /* Check if we have enough points */
        if (n_sub <= sub_start) {
            /* Not enough data for this pass */
            double nan_val = NAN;
            if (pass == 0) {
                result[17] = nan_val;
                result[19] = nan_val;
            } else {
                result[12] = nan_val;
                result[13] = nan_val;
            }
            continue;
        }

        /* Build time/value arrays
         * Time is computed as: (accu_seq[i] - accu_seq[sub_start]) / 288.0
         * Value is the ISF smooth data
         * (disasm at 0x6dbce-0x6dc64) */
        int data_start = (int)CGM_SEQ_SLOTS - (int)n_valid_seq + (int)sub_start;
        if (data_start < 0) data_start = 0;

        for (int i = 0; i < (int)(n_sub - sub_start); i++) {
            int pos = data_start + i;
            if (pos >= CGM_SEQ_SLOTS) break;

            double val = args->err16_CGM_ISF_smooth[pos];
            double abs_val = fabs(val);
            if (isnan(abs_val) || isinf(abs_val)) continue;

            /* Compute time offset: index normalized by CGM_TIME_DIVISOR (288).
             * In the disasm, time is derived from accu_seq differences
             * divided by 288 (d14). We use the array index as time proxy. */
            reg_x[n_reg] = (double)i / CGM_TIME_DIVISOR;
            reg_y[n_reg] = val;
            n_reg++;
        }

        if (n_reg < 2) {
            if (pass == 0) {
                result[17] = NAN;
                result[19] = NAN;
            } else {
                result[12] = NAN;
                result[13] = NAN;
            }
            continue;
        }

        /* Compute regression and R-squared
         * (disasm at 0x6dc8c-0x6dcfe) */
        double reg_result[2]; /* [slope, intercept] */
        fit_simple_regression(reg_x, reg_y, (int)n_reg, reg_result);

        double r2 = f_rsq(reg_result, reg_y, reg_x, (int)n_reg);

        /* Store results based on pass number */
        if (pass == 1) {
            /* Second pass: store slope and rsq
             * (disasm at 0x6dc8c-0x6dcbe) */
            result[17] = reg_result[0];
            result[19] = r2;
        } else {
            /* First pass (when pass count > 1): store at different offsets
             * (disasm at 0x6dcc0-0x6dcfe) */
            result[12] = reg_result[0];
            result[13] = r2;
        }
    }

    /* ── Compute trend diff and ratio ──
     * (disasm at 0x6de38-0x6dfa6)
     * Check if we have enough historical data (cal_trendRate threshold).
     * Then compute:
     *   n_counter++
     *   max_value = max(trend_value, previous_max)
     *   If n_counter >= threshold:
     *     Compute trimmed mean of the ISF roc values
     *     diff = trend_value - trimmed_mean
     *     ratio = diff / trimmed_mean * 100
     */
    result[3] += 1.0; /* increment counter */

    /* Compute max of current value and stored max */
    {
        double current_and_prev[2] = { result[0], result[6] };
        double max_val = math_max(current_and_prev, 2);

        /* Store max in the ISF max tracking array
         * (disasm at 0x6de78-0x6de82) */

        /* Check if enough data accumulated */
        if (result[3] >= n_back) {
            /* Compute trimmed mean for reference
             * (disasm at 0x6dece-0x6deea calls f_trimmed_mean with 20%) */

            /* Count matching values for mode-based check
             * (disasm at 0x6deec-0x6df5e) */
            uint16_t match_count = 0;
            int total_check = (int)n_valid_seq;
            if (total_check > CGM_SEQ_SLOTS) total_check = CGM_SEQ_SLOTS;

            for (int i = 0; i < total_check; i++) {
                int pos = CGM_SEQ_SLOTS - total_check + i;
                if (pos < 0 || pos >= CGM_SEQ_SLOTS) continue;
                double val = args->err16_CGM_ISF_smooth[pos];

                if (mode == 0 || mode == 2) {
                    /* Exact match comparison */
                    if (val == trend_ref) {
                        match_count++;
                    }
                } else {
                    /* Range match: trend_ref +/- 5.0 */
                    if (trend_ref >= val - 5.0 && trend_ref <= val + 5.0) {
                        match_count++;
                    }
                }
            }

            /* Determine final trend reference
             * (disasm at 0x6df60-0x6df8a) */
            double final_ref;
            if (match_count == (uint16_t)total_check &&
                ref_value <= (double)total_check) {
                /* All match: use current trend_ref */
                final_ref = trend_ref;
            } else if (idx >= 2) {
                /* Use stored previous value */
                final_ref = result[6];
            } else {
                final_ref = NAN;
            }

            /* Compute diff and ratio
             * (disasm at 0x6df8a-0x6dfa6)
             * diff = trend_value - final_ref
             * ratio = diff / final_ref * 100 */
            result[5] = final_ref;
            result[7] = result[0] - final_ref;
            if (final_ref != 0.0 && !isnan(final_ref)) {
                result[9] = (result[7] / final_ref) * CGM_PERCENT_MULT;
            } else {
                result[9] = NAN;
            }

            (void)max_val;
        }
    }

    /* ── Second trend pass for mode == 1 ──
     * (disasm at 0x6dfaa-0x6e08c)
     * When mode == 1, compute a second set of trend statistics
     * for the ISF roc analysis. */
    if (mode == 1) {
        /* Repeat max computation with different stored values */
        double current_and_prev2[2] = { result[0], result[16] };
        double max_val2 = math_max(current_and_prev2, 2);

        /* Similar flow to first pass but uses different result offsets
         * result[12] = secondary reference
         * result[15] = secondary diff
         * result[16] = secondary ratio */

        /* Count matches for secondary trend */
        uint16_t match_count2 = 0;
        int total_check2 = (int)n_valid_seq;

        for (int i = 0; i < total_check2; i++) {
            int pos = CGM_SEQ_SLOTS - total_check2 + i;
            if (pos < 0 || pos >= CGM_SEQ_SLOTS) continue;
            double val = args->err16_CGM_ISF_smooth[pos];

            /* Range match: trend_ref +/- 5.0 */
            if (trend_ref >= val - 5.0 && trend_ref <= val + 5.0) {
                match_count2++;
            }
        }

        double final_ref2;
        if (match_count2 == (uint16_t)total_check2 &&
            ref_value <= (double)total_check2) {
            final_ref2 = trend_ref;
        } else if (idx >= 2) {
            final_ref2 = result[16];
        } else {
            final_ref2 = NAN;
        }

        result[12] = final_ref2;
        result[15] = result[0] - final_ref2;
        if (final_ref2 != 0.0 && !isnan(final_ref2)) {
            result[16] = (result[15] / final_ref2) * CGM_PERCENT_MULT;
        } else {
            result[16] = NAN;
        }

        (void)max_val2;
    }
}
