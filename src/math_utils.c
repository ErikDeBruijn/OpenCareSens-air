#include "math_utils.h"
#include <math.h>
#include <string.h>

/* NaN-aware arithmetic mean. Skips NaN values. */
double math_mean(const double *buf, uint16_t n)
{
    if (n == 0)
        return NAN;
    double sum = 0.0;
    uint16_t valid = 0;
    for (uint16_t i = 0; i < n; i++) {
        if (isnan(buf[i]))
            continue;
        sum += buf[i];
        valid++;
    }
    if (valid == 0)
        return NAN;
    return sum / (double)valid;
}

/* Sample standard deviation (N-1). Calls math_mean internally. */
double math_std(const double *buf, int n)
{
    if (n == 0)
        return NAN;
    if (n == 1)
        return 0.0;
    double mean = math_mean(buf, (uint16_t)n);
    double sum_sq = 0.0;
    for (int i = 0; i < n; i++) {
        double d = buf[i] - mean;
        sum_sq += d * d;
    }
    return sqrt(sum_sq / (double)(n - 1));
}

/* Round to nearest integer, half-away-from-zero. */
double math_round(double x)
{
    if (isnan(x))
        return NAN;
    double adj = (x < 0.0) ? -0.5 : 0.5;
    return (double)(long long)(x + adj);
}

/* Ceiling. */
double math_ceil(double x)
{
    if (isnan(x))
        return NAN;
    int trunc = (int)(long long)x;
    if (x > 0.0 && (double)trunc != x)
        trunc++;
    return (double)trunc;
}

/* Maximum of array, skipping NaN. */
double math_max(const double *arr, uint16_t len)
{
    double best = 0.0;
    int found = 0;
    for (uint16_t i = 0; i < len; i++) {
        if (isnan(arr[i]))
            continue;
        if (!found || arr[i] > best) {
            best = arr[i];
            found = 1;
        }
    }
    return found ? best : NAN;
}

/* Minimum of array, skipping NaN. */
double math_min(const double *arr, uint16_t len)
{
    if (len == 0)
        return NAN;
    double best = 0.0;
    int found = 0;
    for (uint16_t i = 0; i < len; i++) {
        if (isnan(arr[i]))
            continue;
        if (!found || arr[i] < best) {
            best = arr[i];
            found = 1;
        }
    }
    return found ? best : NAN;
}

/* Comparison function for qsort */
static int cmp_double(const void *a, const void *b)
{
    double da = *(const double *)a;
    double db = *(const double *)b;
    if (da < db) return -1;
    if (da > db) return 1;
    return 0;
}

/* Median via sort (for small arrays). */
double math_median(const double *arr, uint16_t n)
{
    if (n == 0)
        return NAN;
    double tmp[300];
    uint16_t use = (n > 300) ? 300 : n;
    memcpy(tmp, arr, use * sizeof(double));
    qsort(tmp, use, sizeof(double), cmp_double);
    if (use % 2 == 1)
        return tmp[use / 2];
    return (tmp[use / 2 - 1] + tmp[use / 2]) * 0.5;
}

/* Round to num_digits decimal places, return as int64. */
int64_t math_round_digits(double x, uint8_t num_digits)
{
    double scale = pow(10.0, (double)num_digits);
    double scaled = scale * x;
    if (scaled >= 0.0) {
        if (scaled > 9.223372036854776e+18)
            return INT64_MAX;
        return (int64_t)(scaled + 0.5);
    } else {
        if (scaled < -9.223372036854776e+18)
            return INT64_MIN;
        return (int64_t)(scaled - 0.5);
    }
}

/* QuickSelect: find k-th smallest (1-indexed). Median-of-5 pivot. */
double quick_select(double *arr, uint16_t n, uint16_t k)
{
    if (n == 1)
        return arr[0];

    /* Median-of-5 pivot selection */
    double pivots[5];
    pivots[0] = arr[0];
    pivots[1] = arr[n - 1];
    pivots[2] = arr[n >> 2];
    pivots[3] = arr[(n & 0x3ffffffe) >> 1]; /* n/2 rounded down to even */
    pivots[4] = arr[((uint32_t)(n >> 2)) * 3];
    double pivot = math_median(pivots, 5);

    double less[1024], greater[1024];
    uint16_t n_less = 0, n_greater = 0, n_equal = 0;

    for (uint16_t i = 0; i < n; i++) {
        if (arr[i] < pivot)
            less[n_less++] = arr[i];
        else if (arr[i] > pivot)
            greater[n_greater++] = arr[i];
        else
            n_equal++;
    }

    if (k <= n_less)
        return quick_select(less, n_less, k);
    else if (k <= n_less + n_equal)
        return pivot;
    else {
        memcpy(arr, greater, n_greater * sizeof(double));
        return quick_select(arr, n_greater, k - n_less - n_equal);
    }
}

/* Median: quick_select for large, math_median for small (<30). */
double quick_median(double *arr, uint16_t n)
{
    if (n == 0)
        return NAN;
    if (n < 30)
        return math_median(arr, n);
    uint16_t half = n / 2;
    if (n % 2 != 0)
        return quick_select(arr, n, half + 1);
    double a = quick_select(arr, n, half);
    double b = quick_select(arr, n, half + 1);
    return (a + b) * 0.5;
}

/* Replace outliers outside [mean-2*std, mean+2*std] with mean. Always 30 elements. */
void eliminate_peak(const double *in, double *out)
{
    double mean = math_mean(in, 30);
    double std = math_std(in, 30);
    double lo = mean - 2.0 * std;
    double hi = mean + 2.0 * std;
    for (int i = 0; i < 30; i++) {
        if (in[i] < lo || in[i] > hi)
            out[i] = mean;
        else
            out[i] = in[i];
    }
}

/* Remove element at index, shift left, decrement count. */
void delete_element(double *arr, uint8_t *count, uint32_t index)
{
    uint8_t n = *count;
    if (n == 0 || index >= n)
        return;
    for (uint32_t i = index; i < (uint32_t)(n - 1); i++)
        arr[i] = arr[i + 1];
    *count = n - 1;
}

/* Compare two doubles rounded to num_digits decimal places.
   met_sel: 0=eq, 1=gt, 2=lt, 3=ge, 4=le */
uint8_t fun_comp_decimals(double in1, double in2, uint8_t num_digits, uint8_t met_sel)
{
    if (isnan(in1) || isnan(in2))
        return 0;

    int64_t a = math_round_digits(in1, num_digits);
    int64_t b = math_round_digits(in2, num_digits);

    /* If either overflowed, fall back to direct double comparison */
    if (a == INT64_MAX || a == INT64_MIN || b == INT64_MAX || b == INT64_MIN) {
        switch (met_sel) {
        case 0: return in1 == in2;
        case 1: return in1 > in2;
        case 2: return in1 < in2;
        case 3: return in1 >= in2;
        case 4: return in1 <= in2;
        default: return in1 == in2;
        }
    }

    switch (met_sel) {
    case 0: return a == b;
    case 1: return a > b;
    case 2: return a < b;
    case 3: return a >= b;
    case 4: return a <= b;
    default: return a == b;
    }
}

/* Percentile: filters NaN/Inf, then uses quick_select. */
double calcPercentile(const double *arr, uint16_t n, uint8_t percent)
{
    double filtered[1024];
    uint16_t cnt = 0;

    for (uint16_t i = 0; i < n; i++) {
        if (!isnan(arr[i]) && !isinf(arr[i]))
            filtered[cnt++] = arr[i];
    }

    if (cnt == 0)
        return NAN;

    /* Compute rank: percent * 0.01 * count + 0.5, truncated to positive int */
    double rank_f = (double)percent * 0.01 * (double)cnt + 0.5;
    uint32_t rank = (rank_f > 0.0) ? (uint32_t)(long long)rank_f : 0;

    if (rank == 0)
        return math_min(filtered, cnt);
    if (rank > cnt)
        rank = cnt;

    return quick_select(filtered, cnt, (uint16_t)rank);
}

/* Trimmed mean: average values between percentile(th) and percentile(100-th). */
double f_trimmed_mean(const double *data, uint16_t len, uint8_t th)
{
    double lo = calcPercentile(data, len, th);
    double hi = calcPercentile(data, len, 100 - th);

    if (lo == hi)
        return math_mean(data, len);

    double sum = 0.0;
    uint16_t cnt = 0;
    for (uint16_t i = 0; i < len; i++) {
        if (fun_comp_decimals(data[i], lo, 10, 3) &&   /* data[i] >= lo */
            fun_comp_decimals(data[i], hi, 10, 4)) {    /* data[i] <= hi */
            sum += data[i];
            cnt++;
        }
    }
    if (cnt == 0)
        return NAN;
    return sum / (double)cnt;
}

/* Average excluding min and max. */
double cal_average_without_min_max(const double *arr, uint16_t n)
{
    if (n <= 2)
        return math_mean(arr, n);

    double mn = arr[0], mx = arr[0];
    double sum = arr[0];
    for (uint16_t i = 1; i < n; i++) {
        sum += arr[i];
        if (arr[i] < mn) mn = arr[i];
        if (arr[i] > mx) mx = arr[i];
    }
    return (sum - mn - mx) / (double)(n - 2);
}

/* Byte-by-byte memory copy. */
void copy_mem(void *dst, const void *src, uint16_t n)
{
    const uint8_t *s = (const uint8_t *)src;
    uint8_t *d = (uint8_t *)dst;
    for (uint16_t i = 0; i < n; i++)
        d[i] = s[i];
}

/* Simple linear regression. NaN-aware.
   Matches the binary's convention where x/y may be swapped. */
void fit_simple_regression(const double *x, const double *y, uint16_t n,
                           double *slope, double *intercept)
{
    if (n < 2) {
        *slope = NAN;
        *intercept = NAN;
        return;
    }

    double sx = 0, sy = 0, sxy = 0, sxx = 0;
    uint16_t valid = 0;
    for (uint16_t i = 0; i < n; i++) {
        if (isnan(x[i]) || isnan(y[i]))
            continue;
        sx += x[i];
        sy += y[i];
        sxy += x[i] * y[i];
        sxx += x[i] * x[i];
        valid++;
    }

    if (valid < 2) {
        *slope = NAN;
        *intercept = NAN;
        return;
    }

    double denom = (double)valid * sxx - sx * sx;
    if (fabs(denom) < 1e-30) {
        *slope = NAN;
        *intercept = NAN;
        return;
    }

    *slope = ((double)valid * sxy - sx * sy) / denom;
    *intercept = (sy - *slope * sx) / (double)valid;
}

/* R-squared calculation. */
double f_rsq(const double *x, const double *y, uint16_t n,
             double slope, double intercept)
{
    if (n < 2)
        return NAN;

    double ss_tot = 0, ss_res = 0;
    double y_mean = math_mean(y, n);
    for (uint16_t i = 0; i < n; i++) {
        if (isnan(x[i]) || isnan(y[i]))
            continue;
        double y_pred = slope * x[i] + intercept;
        double res = y[i] - y_pred;
        double tot = y[i] - y_mean;
        ss_res += res * res;
        ss_tot += tot * tot;
    }
    if (ss_tot < 1e-30)
        return NAN;
    return 1.0 - ss_res / ss_tot;
}

/* Solve 2x2 linear system using Cramer's rule. */
void solve_linear(double a, double b, double c, double d,
                  double e, double f, double *x, double *y)
{
    double det = a * d - b * c;
    if (fabs(det) < 1e-30) {
        *x = NAN;
        *y = NAN;
        return;
    }
    *x = (e * d - b * f) / det;
    *y = (a * f - e * c) / det;
}
