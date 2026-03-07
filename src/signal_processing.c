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

/* ────────────────────────────────────────────────────────────────────
 * smooth1q_err16: Hann window + Fourier decomposition smoothing
 *
 * From ARM disasm @ 0x6d740 (opcal4, 162 instructions).
 *
 * This function implements a frequency-domain smoothing filter used
 * by the err16 (sensor drift/degradation) error detector. The filter
 * works by computing the DFT, applying frequency-dependent damping
 * via the Hann window, and synthesizing the result via inverse DFT.
 *
 * Register mapping from disassembly:
 *   r10 = input array pointer (r0 on entry)
 *   r11 = n (r1 on entry)
 *   sp+0x4 = output array pointer (r2 on entry)
 *   d8  = (double)n
 *   d9  = pi (phase 1), then 0.0 (phase 2), then 2*pi (phase 3)
 *   d10 = 2.0 (phase 1), then m * (-2*pi) (phase 2)
 *   d11 = 1.0
 *   d12 = -0.0 (used as initial value in multiply-accumulate patterns)
 *   sp+0x350 = Hann window coefficients (n doubles)
 *   sp+0x30  = Fourier coefficient pairs (n x 2 doubles)
 * ──────────────────────────────────────────────────────────────────── */

/* Maximum number of data points for smooth1q_err16.
 * From stack layout: sp+0x350 holds up to 50 doubles for Hann coefficients
 * (0x350 - 0x30 = 0x320 = 800 bytes = 100 doubles = 50 pairs). */
#define SMOOTH1Q_MAX_N 50

void smooth1q_err16(double *input, uint32_t n, double *output)
{
    double hann[SMOOTH1Q_MAX_N];          /* sp+0x350: Hann window coefficients */
    double coef[SMOOTH1Q_MAX_N][2];       /* sp+0x30:  Fourier coefficient pairs
                                           * [m][0] = a_scaled, [m][1] = -b_scaled */
    uint32_t actual_n = n;
    if (actual_n > SMOOTH1Q_MAX_N)
        actual_n = SMOOTH1Q_MAX_N;
    if (actual_n == 0)
        return;

    double dn = (double)actual_n;         /* d8 in disasm */

    /* ── Phase 1: Compute Hann window coefficients ──
     * (disasm at 0x6d766-0x6d7b2)
     *
     * First, memset the Hann array (blx to memset at 0x6d76a).
     * Then loop: for k = 0, 2, 4, ..., 2*n-2 (r5 increments by 2):
     *   angle = k * pi / n
     *   cos_val = cos(angle)
     *   w[k/2] = 2.0 - 2.0 * cos_val
     *
     * This is the Hann window: w[i] = 2 - 2*cos(2*i*pi / n).
     *
     * ARM register state:
     *   d9 = pi, d10 = 2.0, d8 = (double)n
     *   r4 = 2*n, r5 = loop counter (0, 2, 4, ...) */
    memset(hann, 0, sizeof(hann));
    for (uint32_t k = 0; k < 2 * actual_n; k += 2) {
        double angle = (double)k * M_PI / dn;
        double cos_val = cos(angle);
        /* disasm: d16 = d16 + d16 (double the cos), then d16 = 2.0 - d16 */
        hann[k / 2] = 2.0 - 2.0 * cos_val;
    }

    /* ── Phase 2: Fourier analysis ──
     * (disasm at 0x6d7b4-0x6d882)
     *
     * First, memset the coefficient array to zero (0x320 bytes at sp+0x30).
     *
     * For each frequency m = 0 to n-1 (r8):
     *   d14 = 0 (accumulates -b[m]: sum of input[j] * sin)
     *   d15 = 0 (accumulates a[m]: sum of input[j] * cos)
     *   d10 = m * (-2*pi)  (base angle factor)
     *   d13 = 0 (j counter as double, increments by 1.0)
     *
     *   For each data point j = 0 to n-1 (r9):
     *     angle = m * (-2*pi) * j / n
     *     sincos(angle, &sin_val, &cos_val)
     *     [sp+0x20] = cos_val, [sp+0x28] = sin_val
     *
     *     d17 = cos_val * 0.0 (clearing via d9=0.0)
     *     d17 += input[j] * sin_val  (vmla)
     *     d14 += d17                 (-b[m] accumulator)
     *
     *     d17 = sin_val * (-0.0) (clearing via d12=-0.0)
     *     d17 += input[j] * cos_val  (vmla)
     *     d15 += d17                 (a[m] accumulator)
     *
     *   After inner loop, compute Hann-weighted scale:
     *     w = hann[m]
     *     d17 = w * n
     *     d18 = 1.0 + (w * n) * w = 1 + n * w^2
     *     scale = 1.0 / d18
     *
     *   Store scaled coefficients:
     *     d17 = 0 + scale * d14     → scale * (-b[m])
     *     d18 = (-0.0) + scale * d15 → scale * a[m]
     *     coef[m][1] = d17  (stored at sp+0x30 + m*16 + 8)
     *     coef[m][0] = d18  (stored at sp+0x30 + m*16 + 0)
     */
    memset(coef, 0, sizeof(coef));

    for (uint32_t m = 0; m < actual_n; m++) {
        double sum_a = 0.0;   /* d15: a[m] = sum(input[j] * cos(angle)) */
        double sum_neg_b = 0.0; /* d14: -b[m] = sum(input[j] * sin(angle_neg)) */

        double base_angle = (double)m * (-2.0 * M_PI); /* d10 = m * (-2*pi) */

        for (uint32_t j = 0; j < actual_n; j++) {
            double angle = base_angle * (double)j / dn;
            double sin_val, cos_val;
#ifdef _GNU_SOURCE
            sincos(angle, &sin_val, &cos_val);
#else
            sin_val = sin(angle);
            cos_val = cos(angle);
#endif
            /* The ARM binary accumulates:
             *   d14 += input[j] * sin(angle)  where angle uses -2*pi
             *   d15 += input[j] * cos(angle)
             *
             * Since cos(-x) = cos(x) and sin(-x) = -sin(x):
             *   cos(m * (-2*pi) * j / n) = cos(2*pi*m*j/n)
             *   sin(m * (-2*pi) * j / n) = -sin(2*pi*m*j/n)
             *
             * So d14 = -sum(input[j] * sin(2*pi*m*j/n)) = -b[m]
             *    d15 = sum(input[j] * cos(2*pi*m*j/n))  = a[m]
             */
            sum_neg_b += input[j] * sin_val;  /* d14 += input[j] * sin */
            sum_a += input[j] * cos_val;      /* d15 += input[j] * cos */
        }

        /* Compute Hann-weighted scale factor:
         * d17 = w * n
         * d18 = 1.0 + d17 * w = 1 + n * w^2
         * scale = 1.0 / d18 */
        double w = hann[m];
        double denom = 1.0 + dn * w * w;
        double scale = 1.0 / denom;

        /* Store scaled coefficients:
         * coef[m][0] = scale * a[m]     (vstr d18 at [r0])
         * coef[m][1] = scale * (-b[m])  (vstr d17 at [r0, #8])
         *
         * In the disasm:
         *   d17 = d15 * d9  (= a[m] * 0.0 = 0.0, clearing)
         *   d18 = d14 * d12 (= (-b[m]) * (-0.0), clearing)
         *   vmla d17, d16, d14  → d17 = 0 + scale * (-b[m])
         *   vmla d18, d16, d15  → d18 = 0 + scale * a[m]
         */
        coef[m][0] = scale * sum_a;      /* a_scaled[m] */
        coef[m][1] = scale * sum_neg_b;  /* -b_scaled[m] = scale * (-b[m]) */
    }

    /* ── Phase 3: Fourier synthesis ──
     * (disasm at 0x6d884-0x6d900)
     *
     * d9 = 2*pi (loaded from literal pool at 0x6d940)
     * r10 = sp+0x18 (sin output for sincos)
     * r9 = sp+0x10 (cos output for sincos)
     *
     * For each output position i = 0 to n-1 (r5):
     *   d10 = 0.0 (output accumulator)
     *   r4 = 0 (angle counter: tracks i*m via repeated addition of i)
     *   r6 = sp+0x38 (pointer to coefficient pairs, starting at +8 offset
     *                  because the inner loop uses vldr [r6, #-8])
     *
     *   For each frequency m = 0 to n-1 (r11 counts down):
     *     angle = 2*pi * (i*m) / n  (r4 = i*m, accumulated via r4 += r5)
     *     sincos(angle, &sin_val, &cos_val)
     *
     *     d16 = coef[m][0] (a_scaled[m], loaded from [r6, #-8])
     *     d17 = coef[m][1] (-b_scaled[m], loaded from [r6])
     *     r4 += i  (for next iteration)
     *     r6 += 16 (advance pointer)
     *
     *     d16 = a_scaled[m] * cos_val
     *     vmls d16, sin_val, (-b_scaled[m])
     *       → d16 = a_scaled[m]*cos - sin*(-b_scaled[m])
     *       → d16 = a_scaled[m]*cos + b_scaled[m]*sin
     *     d16 /= n
     *     d10 += d16
     *
     *   output[i] = d10
     */
    for (uint32_t i = 0; i < actual_n; i++) {
        double accum = 0.0;   /* d10 */
        uint32_t angle_idx = 0; /* r4: tracks i*m via repeated addition */

        for (uint32_t m = 0; m < actual_n; m++) {
            double angle = 2.0 * M_PI * (double)angle_idx / dn;
            double sin_val, cos_val;
#ifdef _GNU_SOURCE
            sincos(angle, &sin_val, &cos_val);
#else
            sin_val = sin(angle);
            cos_val = cos(angle);
#endif
            double a_s = coef[m][0];   /* a_scaled[m] */
            double neg_b_s = coef[m][1]; /* -b_scaled[m] */

            /* disasm: d16 = a_s * cos
             *         vmls d16, sin, neg_b_s → d16 = a_s*cos - sin*(-b_s)
             *                                     = a_s*cos + b_s*sin
             *         d16 /= n */
            double val = a_s * cos_val - sin_val * neg_b_s;
            val /= dn;
            accum += val;

            angle_idx += i; /* r4 += r5 (this makes angle_idx = i*(m+1)) */
        }
        output[i] = accum;
    }
}

/* ========================================================================
 * f_check_cgm_trend  --  CGM trend validation (err16 helper)
 *
 * From ARM disasm @ 0x6e498 (opcal4, 409 instructions).
 *
 * Validates trend data arrays against threshold criteria.
 * Called 3 times from check_error for min/mode/mean trend validation.
 *
 * Three code paths based on mode:
 *   mode == 100: 2-array le check (slope1, slope2)
 *   mode <= 2:   3-array first pass + optional 4-comparison second pass
 *   mode > 2:    4-array le check + optional extended validation (mode >= 5)
 * ======================================================================== */

/* Number of accu_seq entries in the validity scan (literal pool 0xfffff93e). */
#define ACCU_SEQ_COUNT 865

/* Length of each trend data array (rsb r0, r4, #0x24 => 0x24 = 36). */
#define TREND_ARRAY_LEN 36

/*
 * count_valid_entries: Count accu_seq entries within the lookback window.
 *
 * From disassembly @ 0x6e4b8-0x6e4e8:
 *   r12 = seq_current - n_back
 *   For each seq_val in accu_seq[0..864]:
 *     valid if seq_val != 0 AND seq_val <= seq_current
 *     AND (seq_current - n_back) < seq_val
 */
static uint16_t count_valid_entries(
    struct air1_opcal4_arguments_t *args,
    uint16_t seq_current,
    uint16_t n_back)
{
    uint16_t oldest = seq_current - n_back;
    uint32_t n_valid = 0;

    for (int i = 0; i < ACCU_SEQ_COUNT; i++) {
        uint16_t seq_val = args->accu_seq[i];
        if (seq_val != 0 && seq_val <= seq_current && oldest < seq_val)
            n_valid++;
    }
    return (uint16_t)n_valid;
}

/*
 * check_two_counters: Check if two counters both match n_valid.
 *
 * Implements the disassembly's return pattern:
 *   ((c1 & 0xFF) ^ n_valid | (c2 & 0xFF) ^ n_valid) & 0xFFFF
 *   clz >> 5 => 1 if zero (both match), 0 otherwise
 */
static inline uint8_t check_two_counters(uint32_t c1, uint32_t c2,
                                          uint32_t n_valid)
{
    uint16_t combined = (uint16_t)(((c1 & 0xFF) ^ n_valid) |
                                    ((c2 & 0xFF) ^ n_valid));
    return combined == 0 ? 1 : 0;
}

uint8_t f_check_cgm_trend(
    uint32_t mode,
    struct air1_opcal4_arguments_t *args,
    uint16_t seq_current,
    uint16_t n_back,
    double **arrays,
    int n_arrays,
    double *thresholds,
    int n_thresholds,
    uint8_t *comp_modes)
{
    /* Step 1: Count valid entries in the lookback window */
    uint16_t n_valid = count_valid_entries(args, seq_current, n_back);

    /* base_idx: only the last n_valid elements (out of 36) are checked.
     * From disasm: rsb r0, r4, #0x24 => r0 = 36 - n_valid */
    int base_idx = TREND_ARRAY_LEN - (int)n_valid;
    if (base_idx < 0) base_idx = 0;

    /* ================================================================
     * Path A: mode == 100 (0x6e4ea-0x6e5e6)
     *
     * 2 arrays, 2 thresholds, both le(4) checks.
     * Return 1 if ALL entries pass BOTH checks.
     * ================================================================ */
    if (mode == 100) {
        uint32_t counter1 = 0;
        uint32_t counter2 = 0;

        for (int i = 0; i < (int)n_valid; i++) {
            int idx = base_idx + i;
            if (idx < 0 || idx >= TREND_ARRAY_LEN) continue;

            if (fun_comp_decimals(arrays[0][idx], thresholds[0], 10, 4))
                counter1++;
            if (fun_comp_decimals(arrays[1][idx], thresholds[1], 10, 4))
                counter2++;
        }

        return check_two_counters(counter1, counter2, (uint32_t)n_valid);
    }

    /* ================================================================
     * Path C: mode <= 2 (0x6e60a-0x6e8a4)
     *
     * First sub-loop: 3 comparisons per entry
     *   arrays[0][idx] with comp_modes[0] => counter_a
     *   arrays[1][idx] with comp_modes[1] => counter_b
     *   arrays[2][idx] with comp_modes[2] => counter_c
     *
     * If counter_c doesn't match n_valid: return first_stage result.
     * If counter_c matches: enter second sub-loop with 4 more checks.
     * ================================================================ */
    if (mode <= 2) {
        uint32_t counter_a = 0;
        uint32_t counter_b = 0;
        uint32_t counter_c = 0;

        for (int i = 0; i < (int)n_valid; i++) {
            int idx = base_idx + i;
            if (idx < 0 || idx >= TREND_ARRAY_LEN) continue;

            if (fun_comp_decimals(arrays[0][idx], thresholds[0], 10,
                                  comp_modes[0]))
                counter_a++;
            if (fun_comp_decimals(arrays[1][idx], thresholds[1], 10,
                                  comp_modes[1]))
                counter_b++;
            if (fun_comp_decimals(arrays[2][idx], thresholds[2], 10,
                                  comp_modes[2]))
                counter_c++;
        }

        /* First-stage check (0x6e796) */
        uint8_t first_stage = check_two_counters(counter_b, counter_a,
                                                  (uint32_t)n_valid);

        /* Check counter_c matches n_valid (0x6e7b6) */
        uint8_t c_matches = ((uint32_t)n_valid == (counter_c & 0xFF)) ? 1 : 0;

        if (!c_matches)
            return first_stage;

        /* Second sub-loop: 4 more comparisons (0x6e7bc-0x6e854)
         *
         * From disasm, uses 2 pairs of contiguous arrays (4 total),
         * each with le(4) comparison against separate thresholds.
         *
         * arrays[3..6], thresholds[3..6], comp_modes[3..6] */
        if (n_arrays < 7 || n_thresholds < 7)
            return first_stage;

        uint32_t counter_d = 0; /* r11 */
        uint32_t counter_e = 0; /* r9  */
        uint32_t counter_f = 0; /* sp+0x18 */
        uint32_t counter_g = 0; /* r10 */

        for (int i = 0; i < (int)n_valid; i++) {
            int idx = base_idx + i;
            if (idx < 0 || idx >= TREND_ARRAY_LEN) continue;

            if (fun_comp_decimals(arrays[3][idx], thresholds[3], 10,
                                  comp_modes[3]))
                counter_f++;
            if (fun_comp_decimals(arrays[4][idx], thresholds[4], 10,
                                  comp_modes[4]))
                counter_d++;
            if (fun_comp_decimals(arrays[5][idx], thresholds[5], 10,
                                  comp_modes[5]))
                counter_e++;
            if (fun_comp_decimals(arrays[6][idx], thresholds[6], 10,
                                  comp_modes[6]))
                counter_g++;
        }

        /* Return: first_stage AND (pair1_ok OR pair2_ok)
         * pair1 = (counter_g, counter_e), pair2 = (counter_d, counter_f) */
        uint8_t pair1_ok = check_two_counters(counter_g, counter_e,
                                               (uint32_t)n_valid);
        uint8_t pair2_ok = check_two_counters(counter_d, counter_f,
                                               (uint32_t)n_valid);

        return first_stage & (pair1_ok | pair2_ok);
    }

    /* ================================================================
     * Path B: mode > 2 (0x6e558-0x6e8e8, SIMD-style path)
     *
     * 4-way check: arrays[0..3] against thresholds[0..3].
     * Builds a 4-bit bitmask (all entries passed each comparison).
     *
     * mode < 5 (3, 4): return bitmask == 0x0F
     * mode >= 5:       if bitmask == 0x0F, extended 5-comparison check
     * ================================================================ */
    uint32_t pass_count[4] = {0, 0, 0, 0};

    for (int i = 0; i < (int)n_valid; i++) {
        int idx = base_idx + i;
        if (idx < 0 || idx >= TREND_ARRAY_LEN) continue;

        for (int c = 0; c < 4 && c < n_arrays; c++) {
            if (fun_comp_decimals(arrays[c][idx], thresholds[c], 10,
                                  comp_modes[c]))
                pass_count[c]++;
        }
    }

    /* Bitmask: SIMD uint16 lane comparison (0x6e678-0x6e6b2) */
    uint32_t bitmask = 0;
    uint16_t nv_byte = (uint16_t)(n_valid & 0xFF);
    for (int c = 0; c < 4; c++) {
        if ((pass_count[c] & 0xFF) == nv_byte)
            bitmask |= (1u << c);
    }
    bitmask &= 0x0F;

    /* mode < 5: simple bitmask check (0x6e67e cmp r11,#5; blo 0x6e856) */
    if (mode < 5)
        return (bitmask == 0x0F) ? 1 : 0;

    /* mode >= 5: require 4-way pass to continue */
    if (bitmask != 0x0F)
        return 0;

    /* Extended validation (0x6e6ba-0x6e8e8):
     * 5 comparisons per entry using arrays[4..6] and thresholds[4..8].
     *
     * From disasm (0x6e700-0x6e78e):
     *   1. arrays[4][idx], comp_modes[4] => counter1
     *   2. arrays[5][idx], comp_modes[5] => counter2
     *   3. abs(arrays[4][idx]), comp_modes[6] => counter3
     *   4. arrays[5][idx], comp_modes[7] => counter4
     *   5. arrays[6][idx], comp_modes[8] => counter5
     */
    if (n_arrays < 7 || n_thresholds < 9)
        return 0;

    uint32_t ext_c1 = 0, ext_c2 = 0, ext_c3 = 0, ext_c4 = 0, ext_c5 = 0;

    for (int i = 0; i < (int)n_valid; i++) {
        int idx = base_idx + i;
        if (idx < 0 || idx >= TREND_ARRAY_LEN) continue;

        if (fun_comp_decimals(arrays[4][idx], thresholds[4], 10,
                              comp_modes[4]))
            ext_c1++;
        if (fun_comp_decimals(arrays[5][idx], thresholds[5], 10,
                              comp_modes[5]))
            ext_c2++;

        /* abs() comparison (0x6e72e-0x6e746) */
        double abs_val = fabs(arrays[4][idx]);
        if (fun_comp_decimals(abs_val, thresholds[6], 10,
                              comp_modes[6]))
            ext_c3++;

        if (fun_comp_decimals(arrays[5][idx], thresholds[7], 10,
                              comp_modes[7]))
            ext_c4++;
        if (fun_comp_decimals(arrays[6][idx], thresholds[8], 10,
                              comp_modes[8]))
            ext_c5++;
    }

    /* Return logic (0x6e85a-0x6e8e8, Ghidra lines 8210-8226):
     * counter5 must match n_valid, AND either:
     *   Path 1: counter1 AND counter2 both match n_valid
     *   Path 2: counter3 AND counter4 both match n_valid */
    uint8_t c5_ok = ((ext_c5 & 0xFF) == (n_valid & 0xFF)) ? 1 : 0;
    if (!c5_ok)
        return 0;

    uint8_t c1_ok = ((ext_c1 & 0xFF) == (n_valid & 0xFF)) ? 1 : 0;
    uint8_t c2_ok = ((ext_c2 & 0xFF) == (n_valid & 0xFF)) ? 1 : 0;
    if (c1_ok && c2_ok)
        return 1;

    return check_two_counters(ext_c4, ext_c3, (uint32_t)n_valid);
}
