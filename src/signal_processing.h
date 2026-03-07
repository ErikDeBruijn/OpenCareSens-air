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

#endif /* SIGNAL_PROCESSING_H */
