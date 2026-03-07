/*
 * OpenCareSens Air - Open-source calibration algorithm
 *
 * Math utility functions and error detection helpers used by the
 * opcal4 calibration pipeline. Ported from the CareSens Air ARM binary.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#ifndef MATH_UTILS_H
#define MATH_UTILS_H

#include <stdint.h>

/* Forward declarations for struct types used by error helpers */
struct air1_opcal4_device_info_t;

/* ── Group A: Simple math functions ── */

/* NaN-aware arithmetic mean. Returns NaN for count=0, skips NaN values. */
double math_mean(double *buffer, uint16_t count);

/* Sample standard deviation (Bessel's correction, N-1).
 * Returns NaN for count=0, 0.0 for count=1. */
double math_std(double *buffer, int count);

/* 2-sigma outlier clipping on 30-element array.
 * Replaces outliers with the mean. Writes result to output. */
void eliminate_peak(double *input, double *output);

/* Remove element at index from double array, shift left, decrement *size. */
void delete_element(double *arr, uint8_t *size, unsigned int index);

/* Round double to nearest integer (as double). NaN returns NaN. */
double math_round(double num);

/* Ceiling (as double). NaN returns NaN. */
double math_ceil(double num);

/* Maximum of array (NaN-aware, skips NaN).
 * NOTE: The original binary only examines the first 2 elements (0x10 bytes).
 * Returns NaN if all values are NaN or the iteration finds none valid. */
double math_max(double *arr, uint16_t len);

/* Minimum of array (NaN-aware, uses len parameter properly).
 * Returns NaN if len==0 or all NaN. */
double math_min(double *arr, uint16_t len);

/* Median: delegates to math_median for size < 30, quick_select otherwise. */
double quick_median(double *arr, unsigned int size);

/* Sort-based median for small arrays (< 300 elements). */
double math_median(double *arr, uint16_t size);

/* QuickSelect algorithm for k-th smallest element (1-indexed). */
double quick_select(double *arr, uint16_t arr_size, uint16_t k);

/* Round a double to N decimal places, returns int64_t.
 * Uses pow(10, N) internally. */
int64_t math_round_digits(double x, uint8_t num_digits);

/* Compare two doubles rounded to N decimal places.
 * Modes: 1=gt, 2=lt, 3=ge, 4=le, 5=eq.
 * Returns 0 if either input is NaN. */
uint8_t fun_comp_decimals(double in1, double in2, uint8_t num_digits, uint8_t mode);

/* Average of array excluding min and max values. */
double cal_average_without_min_max(double *arr, int len);

/* Parallelogram validity check for slope/intercept pair.
 * Uses boundary constants from device_info. */
uint8_t check_boundary(double Cslope_new, double Cycept_new,
                        struct air1_opcal4_device_info_t *dev_info);

/* Percentile with interpolation. Filters out NaN/Inf values first. */
double calcPercentile(double *array, uint16_t size, uint8_t percent);

/* Symmetric percentile trimming.
 * Uses calcPercentile to find bounds, then averages values within bounds. */
double f_trimmed_mean(double *data, uint16_t len, uint8_t th);

/* ── Group B: Error detection helpers ── */

/* Error threshold calculation.
 * Updates threshold values based on accumulated data. */
void cal_threshold(uint16_t *param_n, double *param_mean, double *param_diff,
                   uint8_t *param_is_first, unsigned int n_current,
                   int mode,
                   double val_mean, double val_abs_diff,
                   double accum_mean, double accum_diff,
                   struct air1_opcal4_device_info_t *dev_info);

/* err1 variance tracking update: rotate 90-element arrays. */
void err1_TD_var_update(uint16_t *dest_seq, double *dest_val, uint32_t *dest_time,
                        uint16_t *dest_sum,
                        double *src_val, uint32_t *src_time,
                        uint16_t *src_sum);

/* err1 trio state update: rotate 90 x 3-element trio arrays. */
void err1_TD_trio_update(double *dest_val, uint32_t *dest_time,
                         uint8_t *dest_flag,
                         double *src_val, uint32_t *src_time,
                         uint8_t *src_flag,
                         uint8_t *dest_break_flag,
                         uint8_t *src_any_result);

/* ── Group C: Functions from ARM disassembly ── */

/* Solve NxN linear system using Gaussian elimination with partial pivoting.
 * matrix: n_eq rows of (n_var+1) doubles (augmented matrix, row-major,
 *         stride = n_var doubles per row, but stored interleaved as 6 doubles
 *         per row in the original layout).
 * result: output array of n_var doubles.
 * n_eq:   number of equations (rows), must be >= 1 and <= 5.
 * n_var:  number of variables (columns), must be >= 1 and <= 5. */
void solve_linear(double *row0, double *row1, double *row2, double *row3,
                  double *result, int8_t n_eq, int8_t n_var);

/* Smoothing helper. Applies Savitzky-Golay smoothing and averaging.
 * idx: current index (smoothing window position)
 * data: pointer to double array of signal data (10 elements)
 * output: pointer to 7-element output array
 * dev_info: device info for w_sg coefficients */
void apply_simple_smooth(uint8_t idx, double *data, double *output,
                         struct air1_opcal4_device_info_t *dev_info);

/* Simple linear regression (NaN-aware).
 * x, y: arrays of doubles (length n)
 * n: number of points
 * result: output [slope, intercept] */
void fit_simple_regression(double *x, double *y, int n, double *result);

/* R-squared calculation.
 * coeffs: [slope, intercept] array
 * y_obs: observed y values
 * x_vals: predictor values
 * n: number of data points
 * Returns R-squared value, or NaN on degenerate cases. */
double f_rsq(double *coeffs, double *y_obs, double *x_vals, int n);

#endif /* MATH_UTILS_H */
