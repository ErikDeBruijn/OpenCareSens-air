/*
 * OpenCareSens Air - Open-source calibration algorithm
 *
 * Signal processing pipeline functions ported from the CareSens Air
 * ARM binary (opcal4 version).
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#ifndef SIGNAL_PROCESSING_H
#define SIGNAL_PROCESSING_H

#include <stdint.h>

/* Forward declarations */
struct air1_opcal4_device_info_t;
struct air1_opcal4_arguments_t;

/*
 * smooth_sg: Savitzky-Golay smoothing with normalization.
 *
 * From ARM disasm @ 0x6ccbc (opcal4, 111 instructions).
 *
 * Parameters:
 *   signal_data:  10-element double array of input signal values.
 *                 Element [9] is used as the baseline/reference value.
 *   w_sg:         7-element double array of SG weighting coefficients
 *                 (pre-converted from dev_info->w_sg_x100).
 *   output:       10-element double array for smoothed output.
 *   scale_factor: Normalization divisor (d0 register in ARM).
 *
 * Algorithm:
 *   1. Compute effective coefficients: coeff_buf[j] = SG_KERNEL[j] * w_sg[j]
 *      where SG_KERNEL is the base 7-point SG filter from the binary's .rodata.
 *   2. Normalize input: norm[i] = (signal_data[i] - signal_data[9]) / scale_factor
 *   3. Convolve: for each output position i (3..12), apply the SG kernel
 *   4. Denormalize: output[i] = convolution[i] * scale_factor + signal_data[9]
 */
void smooth_sg(double *signal_data, double *w_sg, double *output,
               double scale_factor);

/*
 * regress_cal: IRLS weighted least-squares recalibration.
 *
 * From ARM disasm @ 0x6ce38 (opcal4, 462 instructions).
 *
 * Parameters:
 *   args:     Pointer to arguments_t struct (contains CalLog, cal_state, etc.)
 *   result:   Output array of 2 doubles: [slope, intercept]
 *   dev_info: Device info struct (calibration parameters, thresholds)
 *
 * Algorithm:
 *   - Checks calibration mode (args->CalLog_cal_state):
 *     * 0xFF (uncalibrated): copy factory defaults from args
 *     * 1: filter cal points by age threshold from dev_info field at offset 0x2d0
 *     * 2: filter cal points by age threshold from dev_info field at offset 0x2d2
 *   - Collects valid x/y pairs from CalLog (50 entries, stride 0x68)
 *   - If no valid points: use default slope/intercept from args
 *   - If valid points: run IRLS regression
 *     * Build design matrix X (Nx2: [x_i, 1])
 *     * Initial OLS via solve_linear: XtX * beta = Xty
 *     * Iteratively reweight using Tukey bisquare weights:
 *       - Compute residuals, absolute residuals
 *       - Robust scale via quick_median of |residuals|
 *       - Bisquare weight = (1 - (r/s)^2)^2 if |r/s| < 1, else 0
 *       - Re-solve weighted system: XtWX * beta = XtWy
 *       - Convergence check: ||delta_beta|| < 1e-6
 *       - Max 50 iterations
 */
void regress_cal(struct air1_opcal4_arguments_t *args,
                 double *result,
                 struct air1_opcal4_device_info_t *dev_info);

/*
 * f_cgm_trend: CGM trend rate calculation.
 *
 * From ARM disasm @ 0x6d950 (opcal4, 636 instructions).
 *
 * Computes the rate of change of the CGM signal (trend arrow) and
 * related statistics used by error detection (err16).
 *
 * Parameters:
 *   args:        Pointer to arguments_t (signal history, accu_seq, etc.)
 *   result:      Output struct pointer with trend data fields:
 *                  [0] = trend value (mode value or smoothed)
 *                  [3] = trend_n counter
 *                  [5] = trend reference value
 *                  [7] = trend diff
 *                  [9] = trend ratio (percentage)
 *                  Plus additional fields for the second trend pass.
 *   trend_state: Pointer to per-trend-type state (slope, rsq, etc.)
 *   mode:        Trend computation mode (0, 1, or 2)
 *   min_n:       Minimum number of valid points required (d0)
 *   n_back:      Number of historical points to use (d1)
 *   seq_current: Current sequence number
 *   args5..argsN: Additional stack parameters for the computation
 *
 * This function is called by the err16 detector for computing ISF trend
 * statistics (min trend, mode trend, mean trend).
 */
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
                 uint16_t cal_trendRate);

/*
 * smooth1q_err16: Hann window + Fourier decomposition smoothing.
 *
 * From ARM disasm @ 0x6d740 (opcal4, 162 instructions).
 *
 * Used by the err16 (sensor drift/degradation) error detector
 * to smooth ISF data. Called exactly 2 times from check_error.
 *
 * Parameters:
 *   input:  Pointer to input array of n doubles.
 *   n:      Number of data points (must be > 0).
 *   output: Pointer to output array of n doubles.
 *
 * Algorithm:
 *   1. Compute Hann window coefficients:
 *      w[i] = 2.0 - 2.0 * cos(2*i * pi / n)  for i = 0..n-1
 *
 *   2. Fourier analysis: compute DFT coefficients with Hann damping
 *      For each frequency m = 0..n-1:
 *        a[m] = sum_j(input[j] * cos(2*pi*m*j / n))
 *        b[m] = sum_j(input[j] * sin(2*pi*m*j / n))
 *        scale = 1.0 / (1.0 + n * w[m]^2)
 *        a_s[m] = a[m] * scale
 *        b_s[m] = b[m] * scale
 *
 *   3. Fourier synthesis: reconstruct smoothed signal
 *      For each output position i = 0..n-1:
 *        output[i] = sum_m[ (a_s[m]*cos(2*pi*i*m/n)
 *                          + b_s[m]*sin(2*pi*i*m/n)) / n ]
 *
 * Constants from literal pool:
 *   pi (0x6d928), -2*pi (0x6d930), -0.0 (0x6d938), 2*pi (0x6d940)
 *   d10 = 2.0, d11 = 1.0
 *
 * Stack usage: ~0x4e8 bytes (Hann coefficients at sp+0x350,
 *              Fourier coefficient pairs at sp+0x30).
 *
 * Maximum n: 50 (limited by stack array sizes:
 *            sp+0x350 holds 50 doubles for Hann coefficients,
 *            sp+0x30 holds 50 pairs = 100 doubles).
 */
void smooth1q_err16(double *input, uint32_t n, double *output);

/*
 * f_check_cgm_trend: CGM trend validation for error detection (err16).
 *
 * From ARM disasm @ 0x6e498 (opcal4, 409 instructions).
 *
 * Validates computed CGM trend data against threshold criteria.
 * Called 3 times from check_error (by the err16 detector) to validate
 * min trend, mode trend, and mean trend data.
 *
 * Parameters:
 *   mode:        Validation mode. Determines which code path is taken:
 *                  100: simple 2-array le check (min trend slope1/slope2)
 *                  <= 2: 3-array first pass (le, le, gt) + optional 6-check second pass
 *                  > 2:  4-array SIMD-style check + optional extended validation (mode > 5)
 *   args:        Pointer to arguments_t (contains accu_seq for validity checking)
 *   seq_current: Current sequence number (used for validity window)
 *   n_back:      Lookback parameter: entries with seq > (seq_current - n_back) are valid
 *   arrays:      Array of pointers to 36-element double arrays to validate.
 *                The number and meaning depend on mode:
 *                  mode 100: arrays[0]=slope1, arrays[1]=slope2
 *                  mode <= 2 (first pass): arrays[0]=slope1, arrays[1]=slope2, arrays[2]=proportion/diff
 *                  mode <= 2 (second pass, if entered): arrays[3..8] for rsq/diff/ratio checks
 *                  mode > 2: arrays[0..3] for 4-way check (diff, ratio, slope1, slope2)
 *                  mode > 5: arrays[4..9] for extended check
 *   n_arrays:    Total number of array pointers in arrays[].
 *   thresholds:  Array of threshold doubles for comparisons.
 *                The number depends on mode:
 *                  mode 100: 2 thresholds
 *                  mode <= 2: 3 first-pass + up to 7 second-pass thresholds
 *                  mode > 2: 4 thresholds + up to 6 extended thresholds
 *   n_thresholds: Total number of thresholds.
 *   comp_modes:  Array of fun_comp_decimals modes (1=gt, 2=lt, 3=ge, 4=le, 5=eq)
 *                for each comparison. Length matches n_thresholds.
 *
 * Returns:
 *   1 if the trend data passes all validation checks, 0 otherwise.
 *
 * Validity counting:
 *   Before checking data, counts how many of the 865 accu_seq entries
 *   satisfy: seq_val > 0, seq_val <= seq_current, seq_val > (seq_current - n_back).
 *   Only the last n_valid entries (out of 36) are checked.
 */
uint8_t f_check_cgm_trend(
    uint32_t mode,
    struct air1_opcal4_arguments_t *args,
    uint16_t seq_current,
    uint16_t n_back,
    double **arrays,
    int n_arrays,
    double *thresholds,
    int n_thresholds,
    uint8_t *comp_modes);

#endif /* SIGNAL_PROCESSING_H */
