#ifndef CARESENS_MATH_UTILS_H
#define CARESENS_MATH_UTILS_H

#include <stdint.h>

/* NaN-aware arithmetic mean. Skips NaN values. Returns NaN if n==0. */
double math_mean(const double *buf, uint16_t n);

/* Sample standard deviation (N-1 denominator). Returns NaN if n==0, 0 if n==1. */
double math_std(const double *buf, int n);

/* Round to nearest integer (half-away-from-zero). Returns NaN for NaN input. */
double math_round(double x);

/* Ceiling function. Returns NaN for NaN input. */
double math_ceil(double x);

/* Maximum of array elements, skipping NaN. Returns NaN if all NaN. */
double math_max(const double *arr, uint16_t len);

/* Minimum of array elements, skipping NaN. Returns NaN if all NaN. */
double math_min(const double *arr, uint16_t len);

/* Median via copy+sort for small arrays (up to 300 elements). */
double math_median(const double *arr, uint16_t n);

/* Round x to num_digits decimal places, return as int64. */
int64_t math_round_digits(double x, uint8_t num_digits);

/* QuickSelect: find k-th smallest element (1-indexed). */
double quick_select(double *arr, uint16_t n, uint16_t k);

/* Median using quick_select for large arrays, math_median for small (<30). */
double quick_median(double *arr, uint16_t n);

/* Replace outliers outside [mean-2*std, mean+2*std] with mean. Always 30 elements. */
void eliminate_peak(const double *in, double *out);

/* Remove element at index from array, shift remaining, decrement count. */
void delete_element(double *arr, uint8_t *count, uint32_t index);

/* Compare two doubles rounded to num_digits decimals.
   met_sel: 0=equal, 1=greater, 2=less, 3=greater-or-equal, 4=less-or-equal */
uint8_t fun_comp_decimals(double in1, double in2, uint8_t num_digits, uint8_t met_sel);

/* Trimmed mean: average values between percentile(th) and percentile(100-th). */
double f_trimmed_mean(const double *data, uint16_t len, uint8_t th);

/* Percentile with quick_select. Filters NaN/Inf. percent is 0-100. */
double calcPercentile(const double *arr, uint16_t n, uint8_t percent);

/* Average excluding the single min and max values from array. */
double cal_average_without_min_max(const double *arr, uint16_t n);

/* Byte-by-byte memory copy. */
void copy_mem(void *dst, const void *src, uint16_t n);

/* Simple linear regression: y = slope*x + intercept. NaN-aware.
   Outputs slope, intercept. x and y are swapped vs convention (matches binary). */
void fit_simple_regression(const double *x, const double *y, uint16_t n,
                           double *slope, double *intercept);

/* R-squared (coefficient of determination) for a regression. */
double f_rsq(const double *x, const double *y, uint16_t n,
             double slope, double intercept);

/* Solve 2x2 linear system: [a b; c d] * [x; y] = [e; f] */
void solve_linear(double a, double b, double c, double d,
                  double e, double f, double *x, double *y);

#endif
