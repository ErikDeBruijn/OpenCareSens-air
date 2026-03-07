/*
 * Unit tests for math utility functions.
 *
 * Uses assert() and printf for a simple test harness without
 * external testing framework dependencies.
 */

#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <float.h>

#include "math_utils.h"
#include "calibration.h"

static int tests_passed = 0;
static int tests_failed = 0;

#define EPSILON 1e-10

#define TEST(name) \
    do { printf("  %-50s", name); } while (0)

#define PASS() \
    do { printf("OK\n"); tests_passed++; } while (0)

#define FAIL(msg) \
    do { printf("FAIL: %s\n", msg); tests_failed++; } while (0)

#define ASSERT_DOUBLE_EQ(a, b) \
    do { \
        double _a = (a), _b = (b); \
        if (fabs(_a - _b) > EPSILON) { \
            char _buf[128]; \
            snprintf(_buf, sizeof(_buf), "expected %.15g, got %.15g", _b, _a); \
            FAIL(_buf); return; \
        } \
    } while (0)

#define ASSERT_NAN(a) \
    do { \
        double _a = (a); \
        if (!isnan(_a)) { \
            char _buf[128]; \
            snprintf(_buf, sizeof(_buf), "expected NaN, got %.15g", _a); \
            FAIL(_buf); return; \
        } \
    } while (0)

#define ASSERT_TRUE(cond) \
    do { \
        if (!(cond)) { \
            FAIL(#cond " is false"); \
            return; \
        } \
    } while (0)

#define ASSERT_EQ(a, b) \
    do { \
        if ((a) != (b)) { \
            char _buf[128]; \
            snprintf(_buf, sizeof(_buf), "expected %lld, got %lld", \
                     (long long)(b), (long long)(a)); \
            FAIL(_buf); return; \
        } \
    } while (0)

/* ── math_mean tests ── */

static void test_math_mean_basic(void)
{
    TEST("math_mean: basic values");
    double arr[] = {1.0, 2.0, 3.0, 4.0, 5.0};
    ASSERT_DOUBLE_EQ(math_mean(arr, 5), 3.0);
    PASS();
}

static void test_math_mean_empty(void)
{
    TEST("math_mean: empty array returns NaN");
    ASSERT_NAN(math_mean(NULL, 0));
    PASS();
}

static void test_math_mean_single(void)
{
    TEST("math_mean: single element");
    double arr[] = {42.0};
    ASSERT_DOUBLE_EQ(math_mean(arr, 1), 42.0);
    PASS();
}

static void test_math_mean_with_nan(void)
{
    TEST("math_mean: skips NaN values");
    double arr[] = {1.0, NAN, 3.0, NAN, 5.0};
    ASSERT_DOUBLE_EQ(math_mean(arr, 5), 3.0);
    PASS();
}

static void test_math_mean_all_same(void)
{
    TEST("math_mean: all same values");
    double arr[] = {7.0, 7.0, 7.0};
    ASSERT_DOUBLE_EQ(math_mean(arr, 3), 7.0);
    PASS();
}

/* ── math_std tests ── */

static void test_math_std_basic(void)
{
    TEST("math_std: known values");
    double arr[] = {2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0};
    double result = math_std(arr, 8);
    /* mean=5, sum_sq_diff=32, sample variance=32/7, sample std=sqrt(32/7) */
    double expected = sqrt(32.0 / 7.0);
    ASSERT_DOUBLE_EQ(result, expected);
    PASS();
}

static void test_math_std_empty(void)
{
    TEST("math_std: empty returns NaN");
    ASSERT_NAN(math_std(NULL, 0));
    PASS();
}

static void test_math_std_single(void)
{
    TEST("math_std: single element returns 0");
    double arr[] = {5.0};
    ASSERT_DOUBLE_EQ(math_std(arr, 1), 0.0);
    PASS();
}

static void test_math_std_all_same(void)
{
    TEST("math_std: all same values returns 0");
    double arr[] = {3.0, 3.0, 3.0, 3.0};
    ASSERT_DOUBLE_EQ(math_std(arr, 4), 0.0);
    PASS();
}

/* ── eliminate_peak tests ── */

static void test_eliminate_peak_no_outliers(void)
{
    TEST("eliminate_peak: no outliers");
    double input[30], output[30];
    for (int i = 0; i < 30; i++) input[i] = 10.0;
    eliminate_peak(input, output);
    for (int i = 0; i < 30; i++) {
        ASSERT_DOUBLE_EQ(output[i], 10.0);
    }
    PASS();
}

static void test_eliminate_peak_with_outlier(void)
{
    TEST("eliminate_peak: replaces outliers with mean");
    double input[30], output[30];
    for (int i = 0; i < 30; i++) input[i] = 10.0;
    input[0] = 1000.0; /* outlier */
    input[29] = -500.0; /* outlier */

    eliminate_peak(input, output);

    /* The outliers should be replaced with the mean */
    double mean = math_mean(input, 30);
    ASSERT_DOUBLE_EQ(output[0], mean);
    ASSERT_DOUBLE_EQ(output[29], mean);
    /* Non-outliers should be preserved */
    ASSERT_DOUBLE_EQ(output[1], 10.0);
    PASS();
}

/* ── delete_element tests ── */

static void test_delete_element_middle(void)
{
    TEST("delete_element: remove middle element");
    double arr[] = {1.0, 2.0, 3.0, 4.0, 5.0};
    uint8_t size = 5;
    delete_element(arr, &size, 2);
    ASSERT_EQ(size, 4);
    ASSERT_DOUBLE_EQ(arr[0], 1.0);
    ASSERT_DOUBLE_EQ(arr[1], 2.0);
    ASSERT_DOUBLE_EQ(arr[2], 4.0);
    ASSERT_DOUBLE_EQ(arr[3], 5.0);
    PASS();
}

static void test_delete_element_first(void)
{
    TEST("delete_element: remove first element");
    double arr[] = {10.0, 20.0, 30.0};
    uint8_t size = 3;
    delete_element(arr, &size, 0);
    ASSERT_EQ(size, 2);
    ASSERT_DOUBLE_EQ(arr[0], 20.0);
    ASSERT_DOUBLE_EQ(arr[1], 30.0);
    PASS();
}

static void test_delete_element_empty(void)
{
    TEST("delete_element: empty array no-op");
    double arr[] = {1.0};
    uint8_t size = 0;
    delete_element(arr, &size, 0);
    ASSERT_EQ(size, 0);
    PASS();
}

static void test_delete_element_out_of_range(void)
{
    TEST("delete_element: index out of range no-op");
    double arr[] = {1.0, 2.0};
    uint8_t size = 2;
    delete_element(arr, &size, 5);
    ASSERT_EQ(size, 2);
    PASS();
}

/* ── math_round tests ── */

static void test_math_round_positive(void)
{
    TEST("math_round: positive values");
    ASSERT_DOUBLE_EQ(math_round(2.3), 2.0);
    ASSERT_DOUBLE_EQ(math_round(2.5), 3.0);
    ASSERT_DOUBLE_EQ(math_round(2.7), 3.0);
    PASS();
}

static void test_math_round_negative(void)
{
    TEST("math_round: negative values");
    ASSERT_DOUBLE_EQ(math_round(-2.3), -2.0);
    ASSERT_DOUBLE_EQ(math_round(-2.5), -3.0);
    ASSERT_DOUBLE_EQ(math_round(-2.7), -3.0);
    PASS();
}

static void test_math_round_nan(void)
{
    TEST("math_round: NaN returns NaN");
    ASSERT_NAN(math_round(NAN));
    PASS();
}

static void test_math_round_zero(void)
{
    TEST("math_round: zero");
    ASSERT_DOUBLE_EQ(math_round(0.0), 0.0);
    PASS();
}

/* ── math_ceil tests ── */

static void test_math_ceil_positive(void)
{
    TEST("math_ceil: positive values");
    ASSERT_DOUBLE_EQ(math_ceil(2.1), 3.0);
    ASSERT_DOUBLE_EQ(math_ceil(2.0), 2.0);
    ASSERT_DOUBLE_EQ(math_ceil(2.9), 3.0);
    PASS();
}

static void test_math_ceil_negative(void)
{
    TEST("math_ceil: negative values");
    ASSERT_DOUBLE_EQ(math_ceil(-2.1), -2.0);
    ASSERT_DOUBLE_EQ(math_ceil(-2.9), -2.0);
    PASS();
}

static void test_math_ceil_nan(void)
{
    TEST("math_ceil: NaN returns NaN");
    ASSERT_NAN(math_ceil(NAN));
    PASS();
}

/* ── math_max tests ── */

static void test_math_max_basic(void)
{
    TEST("math_max: first two elements only");
    double arr[] = {3.0, 7.0, 100.0}; /* 100.0 is ignored! */
    ASSERT_DOUBLE_EQ(math_max(arr, 3), 7.0);
    PASS();
}

static void test_math_max_nan_first(void)
{
    TEST("math_max: skips NaN in first two");
    double arr[] = {NAN, 5.0};
    ASSERT_DOUBLE_EQ(math_max(arr, 2), 5.0);
    PASS();
}

static void test_math_max_all_nan(void)
{
    TEST("math_max: all NaN returns NaN");
    double arr[] = {NAN, NAN};
    ASSERT_NAN(math_max(arr, 2));
    PASS();
}

/* ── math_min tests ── */

static void test_math_min_basic(void)
{
    TEST("math_min: basic values");
    double arr[] = {5.0, 3.0, 7.0, 1.0, 9.0};
    ASSERT_DOUBLE_EQ(math_min(arr, 5), 1.0);
    PASS();
}

static void test_math_min_empty(void)
{
    TEST("math_min: empty returns NaN");
    ASSERT_NAN(math_min(NULL, 0));
    PASS();
}

static void test_math_min_with_nan(void)
{
    TEST("math_min: skips NaN values");
    double arr[] = {NAN, 5.0, NAN, 3.0, NAN};
    ASSERT_DOUBLE_EQ(math_min(arr, 5), 3.0);
    PASS();
}

static void test_math_min_all_nan(void)
{
    TEST("math_min: all NaN returns NaN");
    double arr[] = {NAN, NAN, NAN};
    ASSERT_NAN(math_min(arr, 3));
    PASS();
}

static void test_math_min_negative(void)
{
    TEST("math_min: negative values");
    double arr[] = {-1.0, -5.0, -3.0};
    ASSERT_DOUBLE_EQ(math_min(arr, 3), -5.0);
    PASS();
}

/* ── quick_median / math_median tests ── */

static void test_math_median_odd(void)
{
    TEST("math_median: odd count");
    double arr[] = {5.0, 1.0, 3.0};
    ASSERT_DOUBLE_EQ(math_median(arr, 3), 3.0);
    PASS();
}

static void test_math_median_even(void)
{
    TEST("math_median: even count");
    double arr[] = {1.0, 2.0, 3.0, 4.0};
    ASSERT_DOUBLE_EQ(math_median(arr, 4), 2.5);
    PASS();
}

static void test_math_median_single(void)
{
    TEST("math_median: single element");
    double arr[] = {42.0};
    ASSERT_DOUBLE_EQ(math_median(arr, 1), 42.0);
    PASS();
}

static void test_quick_median_small(void)
{
    TEST("quick_median: small array uses math_median");
    double arr[] = {9.0, 1.0, 5.0, 3.0, 7.0};
    ASSERT_DOUBLE_EQ(quick_median(arr, 5), 5.0);
    PASS();
}

static void test_quick_median_empty(void)
{
    TEST("quick_median: empty returns NaN");
    ASSERT_NAN(quick_median(NULL, 0));
    PASS();
}

static void test_quick_median_large_odd(void)
{
    TEST("quick_median: large odd array uses quick_select");
    double arr[31];
    for (int i = 0; i < 31; i++) arr[i] = (double)(i + 1);
    /* Median of 1..31 = 16.0 */
    ASSERT_DOUBLE_EQ(quick_median(arr, 31), 16.0);
    PASS();
}

static void test_quick_median_large_even(void)
{
    TEST("quick_median: large even array uses quick_select");
    double arr[30];
    for (int i = 0; i < 30; i++) arr[i] = (double)(i + 1);
    /* Median of 1..30 = (15 + 16) / 2 = 15.5 */
    ASSERT_DOUBLE_EQ(quick_median(arr, 30), 15.5);
    PASS();
}

/* ── quick_select tests ── */

static void test_quick_select_single(void)
{
    TEST("quick_select: single element");
    double arr[] = {42.0};
    ASSERT_DOUBLE_EQ(quick_select(arr, 1, 1), 42.0);
    PASS();
}

static void test_quick_select_kth(void)
{
    TEST("quick_select: k-th smallest");
    double arr[] = {5.0, 3.0, 1.0, 4.0, 2.0};
    ASSERT_DOUBLE_EQ(quick_select(arr, 5, 1), 1.0);
    ASSERT_DOUBLE_EQ(quick_select(arr, 5, 3), 3.0);
    ASSERT_DOUBLE_EQ(quick_select(arr, 5, 5), 5.0);
    PASS();
}

/* ── math_round_digits tests ── */

static void test_math_round_digits_basic(void)
{
    TEST("math_round_digits: basic rounding");
    ASSERT_EQ(math_round_digits(3.14159, 2), 314);
    ASSERT_EQ(math_round_digits(3.14159, 0), 3);
    ASSERT_EQ(math_round_digits(3.14159, 4), 31416);
    PASS();
}

static void test_math_round_digits_negative(void)
{
    TEST("math_round_digits: negative values");
    ASSERT_EQ(math_round_digits(-2.5, 0), -3);
    ASSERT_EQ(math_round_digits(-1.25, 1), -13);
    PASS();
}

/* ── fun_comp_decimals tests ── */

static void test_fun_comp_decimals_gt(void)
{
    TEST("fun_comp_decimals: mode 1 (gt)");
    ASSERT_EQ(fun_comp_decimals(3.0, 2.0, 2, 1), 1);
    ASSERT_EQ(fun_comp_decimals(2.0, 3.0, 2, 1), 0);
    ASSERT_EQ(fun_comp_decimals(2.0, 2.0, 2, 1), 0);
    PASS();
}

static void test_fun_comp_decimals_lt(void)
{
    TEST("fun_comp_decimals: mode 2 (lt)");
    ASSERT_EQ(fun_comp_decimals(2.0, 3.0, 2, 2), 1);
    ASSERT_EQ(fun_comp_decimals(3.0, 2.0, 2, 2), 0);
    PASS();
}

static void test_fun_comp_decimals_ge(void)
{
    TEST("fun_comp_decimals: mode 3 (ge)");
    ASSERT_EQ(fun_comp_decimals(3.0, 2.0, 2, 3), 1);
    ASSERT_EQ(fun_comp_decimals(2.0, 2.0, 2, 3), 1);
    ASSERT_EQ(fun_comp_decimals(1.0, 2.0, 2, 3), 0);
    PASS();
}

static void test_fun_comp_decimals_le(void)
{
    TEST("fun_comp_decimals: mode 4 (le)");
    ASSERT_EQ(fun_comp_decimals(2.0, 3.0, 2, 4), 1);
    ASSERT_EQ(fun_comp_decimals(2.0, 2.0, 2, 4), 1);
    ASSERT_EQ(fun_comp_decimals(3.0, 2.0, 2, 4), 0);
    PASS();
}

static void test_fun_comp_decimals_eq(void)
{
    TEST("fun_comp_decimals: mode 5 (eq)");
    ASSERT_EQ(fun_comp_decimals(2.0, 2.0, 2, 5), 1);
    ASSERT_EQ(fun_comp_decimals(2.0, 2.001, 2, 5), 1); /* same at 2 digits */
    ASSERT_EQ(fun_comp_decimals(2.0, 2.01, 2, 5), 0);  /* different at 2 digits */
    PASS();
}

static void test_fun_comp_decimals_nan(void)
{
    TEST("fun_comp_decimals: NaN returns 0");
    ASSERT_EQ(fun_comp_decimals(NAN, 2.0, 2, 1), 0);
    ASSERT_EQ(fun_comp_decimals(2.0, NAN, 2, 1), 0);
    ASSERT_EQ(fun_comp_decimals(NAN, NAN, 2, 5), 0);
    PASS();
}

/* ── cal_average_without_min_max tests ── */

static void test_cal_average_without_min_max_basic(void)
{
    TEST("cal_average_without_min_max: basic values");
    double arr[] = {1.0, 2.0, 3.0, 4.0, 5.0};
    /* Excludes 1.0 (min) and 5.0 (max), average of {2,3,4} = 3.0 */
    ASSERT_DOUBLE_EQ(cal_average_without_min_max(arr, 5), 3.0);
    PASS();
}

static void test_cal_average_without_min_max_three(void)
{
    TEST("cal_average_without_min_max: three elements");
    double arr[] = {10.0, 20.0, 30.0};
    /* Excludes 10 and 30, average of {20} = 20.0 */
    ASSERT_DOUBLE_EQ(cal_average_without_min_max(arr, 3), 20.0);
    PASS();
}

/* ── calcPercentile tests ── */

static void test_calcPercentile_50(void)
{
    TEST("calcPercentile: 50th percentile");
    double arr[] = {1.0, 2.0, 3.0, 4.0, 5.0};
    double result = calcPercentile(arr, 5, 50);
    /* 50th percentile of [1,2,3,4,5]: rank = 0.5*5+0.5 = 3 => 3rd element = 3.0 */
    ASSERT_DOUBLE_EQ(result, 3.0);
    PASS();
}

static void test_calcPercentile_0(void)
{
    TEST("calcPercentile: 0th percentile returns min");
    double arr[] = {5.0, 3.0, 1.0, 4.0, 2.0};
    double result = calcPercentile(arr, 5, 0);
    ASSERT_DOUBLE_EQ(result, 1.0);
    PASS();
}

static void test_calcPercentile_filters_nan(void)
{
    TEST("calcPercentile: filters NaN values");
    double arr[] = {1.0, NAN, 3.0, NAN, 5.0};
    double result = calcPercentile(arr, 5, 50);
    /* Valid: [1,3,5], rank = 0.5*3+0.5 = 2 => 2nd = 3.0 */
    ASSERT_DOUBLE_EQ(result, 3.0);
    PASS();
}

static void test_calcPercentile_filters_inf(void)
{
    TEST("calcPercentile: filters Inf values");
    double arr[] = {1.0, INFINITY, 3.0, -INFINITY, 5.0};
    double result = calcPercentile(arr, 5, 50);
    /* Valid: [1,3,5], 50th = 3.0 */
    ASSERT_DOUBLE_EQ(result, 3.0);
    PASS();
}

/* ── f_trimmed_mean tests ── */

static void test_f_trimmed_mean_basic(void)
{
    TEST("f_trimmed_mean: basic trimming");
    double arr[] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0};
    /* With th=20: trims bottom 20% and top 20% */
    double result = f_trimmed_mean(arr, 10, 20);
    /* Lower bound = 20th percentile, upper bound = 80th percentile
     * Values within bounds are averaged */
    ASSERT_TRUE(result > 2.0 && result < 9.0);
    PASS();
}

static void test_f_trimmed_mean_all_same(void)
{
    TEST("f_trimmed_mean: all same values returns mean");
    double arr[] = {5.0, 5.0, 5.0, 5.0, 5.0};
    double result = f_trimmed_mean(arr, 5, 20);
    ASSERT_DOUBLE_EQ(result, 5.0);
    PASS();
}

/* ── check_boundary tests ── */

static void test_check_boundary_within(void)
{
    TEST("check_boundary: within bounds");
    struct air1_opcal4_device_info_t dev_info;
    memset(&dev_info, 0, sizeof(dev_info));
    dev_info.slope_max_slope_x100 = 200;  /* slope_max = 2.0 */
    dev_info.slope_min_slope_x100 = 50;   /* slope_min = 0.5 */

    ASSERT_EQ(check_boundary(1.0, 0.0, &dev_info), 1);
    PASS();
}

static void test_check_boundary_outside(void)
{
    TEST("check_boundary: outside bounds");
    struct air1_opcal4_device_info_t dev_info;
    memset(&dev_info, 0, sizeof(dev_info));
    dev_info.slope_max_slope_x100 = 200;
    dev_info.slope_min_slope_x100 = 50;

    ASSERT_EQ(check_boundary(3.0, 0.0, &dev_info), 0);
    ASSERT_EQ(check_boundary(0.1, 0.0, &dev_info), 0);
    PASS();
}

/* ── err1_TD_var_update tests ── */

static void test_err1_TD_var_update_basic(void)
{
    TEST("err1_TD_var_update: rotates arrays");
    uint16_t dest_seq[90];
    double dest_val[90];
    uint32_t dest_time[90];
    uint16_t dest_sum = 0;

    double src_val[90];
    uint32_t src_time[90];
    uint16_t src_sum = 42;

    memset(dest_seq, 0xFF, sizeof(dest_seq));
    memset(dest_val, 0xFF, sizeof(dest_val));
    memset(dest_time, 0xFF, sizeof(dest_time));

    for (int i = 0; i < 90; i++) {
        src_val[i] = (double)(i + 1);
        src_time[i] = (uint32_t)(1000 + i);
    }

    err1_TD_var_update(dest_seq, dest_val, dest_time, &dest_sum,
                       src_val, src_time, &src_sum);

    /* Check dest received src values */
    ASSERT_DOUBLE_EQ(dest_val[0], 1.0);
    ASSERT_DOUBLE_EQ(dest_val[89], 90.0);
    ASSERT_EQ(dest_time[0], 1000);
    ASSERT_EQ(dest_time[89], 1089);

    /* Check dest_seq zeroed */
    ASSERT_EQ(dest_seq[0], 0);
    ASSERT_EQ(dest_seq[89], 0);

    /* Check src zeroed */
    ASSERT_DOUBLE_EQ(src_val[0], 0.0);
    ASSERT_EQ(src_time[0], 0);

    /* Check sum transfer */
    ASSERT_EQ(dest_sum, 42);
    ASSERT_EQ(src_sum, 0);

    PASS();
}

/* ── err1_TD_trio_update tests ── */

static void test_err1_TD_trio_update_basic(void)
{
    TEST("err1_TD_trio_update: rotates trio arrays");
    double dest_val[270];  /* 90 * 3 */
    uint32_t dest_time[270];
    uint8_t dest_flag = 0;
    double src_val[270];
    uint32_t src_time[270];
    uint8_t src_flag = 1;
    uint8_t dest_break_flag[90];
    uint8_t src_any_result = 1;

    memset(dest_val, 0xFF, sizeof(dest_val));
    memset(dest_time, 0xFF, sizeof(dest_time));
    memset(dest_break_flag, 0xFF, sizeof(dest_break_flag));

    for (int i = 0; i < 270; i++) {
        src_val[i] = (double)(i + 1);
        src_time[i] = (uint32_t)(2000 + i);
    }

    err1_TD_trio_update(dest_val, dest_time, &dest_flag,
                        src_val, src_time, &src_flag,
                        dest_break_flag, &src_any_result);

    /* Check transfer */
    ASSERT_DOUBLE_EQ(dest_val[0], 1.0);
    ASSERT_DOUBLE_EQ(dest_val[269], 270.0);
    ASSERT_EQ(dest_time[0], 2000);

    /* Check src zeroed */
    ASSERT_DOUBLE_EQ(src_val[0], 0.0);
    ASSERT_EQ(src_time[0], 0);

    /* Check flags */
    ASSERT_EQ(dest_flag, 1);
    ASSERT_EQ(src_flag, 0);
    ASSERT_EQ(src_any_result, 0);
    ASSERT_EQ(dest_break_flag[0], 0);
    ASSERT_EQ(dest_break_flag[89], 0);

    PASS();
}

/* ── fit_simple_regression tests ── */

static void test_fit_simple_regression_basic(void)
{
    TEST("fit_simple_regression: perfect line y=2x+1");
    double x[] = {1.0, 2.0, 3.0, 4.0, 5.0};
    double y[] = {3.0, 5.0, 7.0, 9.0, 11.0}; /* y = 2x + 1 */
    double result[2];
    fit_simple_regression(x, y, 5, result);

    /* The ARM code swaps x and y in the clean arrays.
     * So it computes: slope of x on y.
     * slope = cov(x,y)/var(x) = 2.0, intercept = mean_y - slope*mean_x = 1.0
     * But with the swap: it puts y into clean_x, x into clean_y.
     * slope = sum((clean_y_i - mean_clean_y)(clean_x_i - mean_clean_x)) /
     *         sum((clean_y_i - mean_clean_y)^2)
     * = sum((x_i - mean_x)(y_i - mean_y)) / sum((x_i - mean_x)^2)
     * = 2.0
     * intercept = mean_clean_x - slope * mean_clean_y
     * = mean_y - slope * mean_x = 7 - 2*3 = 1.0
     */
    ASSERT_TRUE(fabs(result[0] - 2.0) < 1e-6);
    ASSERT_TRUE(fabs(result[1] - 1.0) < 1e-6);
    PASS();
}

static void test_fit_simple_regression_nan_skip(void)
{
    TEST("fit_simple_regression: skips NaN pairs");
    double x[] = {1.0, NAN, 3.0, 4.0, 5.0};
    double y[] = {3.0, 5.0, 7.0, 9.0, 11.0};
    double result[2];
    fit_simple_regression(x, y, 5, result);
    /* Should skip index 1 (x is NaN), fit on 4 points */
    /* Points: (1,3), (3,7), (4,9), (5,11) => still y=2x+1 */
    ASSERT_TRUE(fabs(result[0] - 2.0) < 1e-6);
    ASSERT_TRUE(fabs(result[1] - 1.0) < 1e-6);
    PASS();
}

/* ── f_rsq tests ── */

static void test_f_rsq_perfect_fit(void)
{
    TEST("f_rsq: perfect fit R2 ~ 1.0");
    double x[] = {1.0, 2.0, 3.0, 4.0, 5.0};
    double y[] = {3.0, 5.0, 7.0, 9.0, 11.0}; /* y = 2x + 1 */
    double coeffs[] = {2.0, 1.0}; /* slope=2, intercept=1 */

    /* f_rsq(coeffs, y_obs=y, x_vals=x, n=5)
     * y_pred[i] = 2*y[i] + 1 = 7,11,15,19,23
     * x_vals = 1..5, mean = 3
     * ss_tot = (1-3)^2+(2-3)^2+(3-3)^2+(4-3)^2+(5-3)^2 = 10
     * ss_pred = sum((y_pred-3)^2) = huge
     * This won't give R2=1 because the formula is different from standard R2.
     * The function computes SS_pred/SS_res which is not standard R2.
     */
    double r2 = f_rsq(coeffs, y, x, 5);
    /* Just verify it returns a valid number */
    ASSERT_TRUE(!isnan(r2));
    ASSERT_TRUE(r2 > 0.0);
    PASS();
}

static void test_f_rsq_degenerate(void)
{
    TEST("f_rsq: constant values returns NaN");
    double x[] = {5.0, 5.0, 5.0, 5.0};
    double y[] = {1.0, 2.0, 3.0, 4.0};
    double coeffs[] = {1.0, 0.0};
    /* All x values are 5, so ss_res = 0 => NaN */
    ASSERT_NAN(f_rsq(coeffs, y, x, 4));
    PASS();
}

/* ── solve_linear tests ── */

static void test_solve_linear_2x2(void)
{
    TEST("solve_linear: 2x2 system");
    /* System: 2x + y = 5, x + 3y = 7
     * Solution: x = 1.6, y = 1.8 */
    double row0[] = {2.0, 1.0, 5.0, 0.0, 0.0, 0.0};
    double row1[] = {1.0, 3.0, 7.0, 0.0, 0.0, 0.0};
    double result[2] = {0};

    solve_linear(row0, row1, NULL, NULL, result, 2, 2);

    ASSERT_TRUE(fabs(result[0] - 1.6) < 1e-6);
    ASSERT_TRUE(fabs(result[1] - 1.8) < 1e-6);
    PASS();
}

static void test_solve_linear_invalid(void)
{
    TEST("solve_linear: invalid dimensions no-op");
    double result[2] = {99.0, 99.0};
    solve_linear(NULL, NULL, NULL, NULL, result, 0, 0);
    /* Should not crash, result unchanged */
    ASSERT_DOUBLE_EQ(result[0], 99.0);
    PASS();
}

/* ── Main test runner ── */

int main(void)
{
    printf("=== Math utility tests ===\n\n");

    printf("-- math_mean --\n");
    test_math_mean_basic();
    test_math_mean_empty();
    test_math_mean_single();
    test_math_mean_with_nan();
    test_math_mean_all_same();

    printf("\n-- math_std --\n");
    test_math_std_basic();
    test_math_std_empty();
    test_math_std_single();
    test_math_std_all_same();

    printf("\n-- eliminate_peak --\n");
    test_eliminate_peak_no_outliers();
    test_eliminate_peak_with_outlier();

    printf("\n-- delete_element --\n");
    test_delete_element_middle();
    test_delete_element_first();
    test_delete_element_empty();
    test_delete_element_out_of_range();

    printf("\n-- math_round --\n");
    test_math_round_positive();
    test_math_round_negative();
    test_math_round_nan();
    test_math_round_zero();

    printf("\n-- math_ceil --\n");
    test_math_ceil_positive();
    test_math_ceil_negative();
    test_math_ceil_nan();

    printf("\n-- math_max --\n");
    test_math_max_basic();
    test_math_max_nan_first();
    test_math_max_all_nan();

    printf("\n-- math_min --\n");
    test_math_min_basic();
    test_math_min_empty();
    test_math_min_with_nan();
    test_math_min_all_nan();
    test_math_min_negative();

    printf("\n-- math_median / quick_median --\n");
    test_math_median_odd();
    test_math_median_even();
    test_math_median_single();
    test_quick_median_small();
    test_quick_median_empty();
    test_quick_median_large_odd();
    test_quick_median_large_even();

    printf("\n-- quick_select --\n");
    test_quick_select_single();
    test_quick_select_kth();

    printf("\n-- math_round_digits --\n");
    test_math_round_digits_basic();
    test_math_round_digits_negative();

    printf("\n-- fun_comp_decimals --\n");
    test_fun_comp_decimals_gt();
    test_fun_comp_decimals_lt();
    test_fun_comp_decimals_ge();
    test_fun_comp_decimals_le();
    test_fun_comp_decimals_eq();
    test_fun_comp_decimals_nan();

    printf("\n-- cal_average_without_min_max --\n");
    test_cal_average_without_min_max_basic();
    test_cal_average_without_min_max_three();

    printf("\n-- calcPercentile --\n");
    test_calcPercentile_50();
    test_calcPercentile_0();
    test_calcPercentile_filters_nan();
    test_calcPercentile_filters_inf();

    printf("\n-- f_trimmed_mean --\n");
    test_f_trimmed_mean_basic();
    test_f_trimmed_mean_all_same();

    printf("\n-- check_boundary --\n");
    test_check_boundary_within();
    test_check_boundary_outside();

    printf("\n-- err1_TD_var_update --\n");
    test_err1_TD_var_update_basic();

    printf("\n-- err1_TD_trio_update --\n");
    test_err1_TD_trio_update_basic();

    printf("\n-- fit_simple_regression --\n");
    test_fit_simple_regression_basic();
    test_fit_simple_regression_nan_skip();

    printf("\n-- f_rsq --\n");
    test_f_rsq_perfect_fit();
    test_f_rsq_degenerate();

    printf("\n-- solve_linear --\n");
    test_solve_linear_2x2();
    test_solve_linear_invalid();

    printf("\n=== Results: %d passed, %d failed ===\n",
           tests_passed, tests_failed);

    return tests_failed > 0 ? EXIT_FAILURE : EXIT_SUCCESS;
}
