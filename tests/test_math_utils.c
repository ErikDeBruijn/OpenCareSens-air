#include <stdio.h>
#include <math.h>
#include <string.h>
#include "math_utils.h"

static int tests_run = 0, tests_passed = 0;

#define ASSERT_NEAR(a, b, tol, name) do { \
    tests_run++; \
    double _a = (a), _b = (b); \
    if (fabs(_a - _b) <= (tol)) { tests_passed++; } \
    else { printf("FAIL: %s: %.10g != %.10g (tol=%.1e)\n", name, _a, _b, (tol)); } \
} while(0)

#define ASSERT_EQ(a, b, name) do { \
    tests_run++; \
    if ((a) == (b)) { tests_passed++; } \
    else { printf("FAIL: %s: %lld != %lld\n", name, (long long)(a), (long long)(b)); } \
} while(0)

int main(void) {
    /* math_mean */
    {
        double arr[] = {1.0, 2.0, 3.0, 4.0, 5.0};
        ASSERT_NEAR(math_mean(arr, 5), 3.0, 1e-15, "mean_basic");
    }

    /* math_std */
    {
        double arr[] = {2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0};
        ASSERT_NEAR(math_std(arr, 8), 2.138089935, 0.001, "std_basic"); /* sample std (N-1) */
    }

    /* math_round */
    ASSERT_NEAR(math_round(2.5), 3.0, 1e-15, "round_half_up");
    ASSERT_NEAR(math_round(-2.5), -3.0, 1e-15, "round_half_neg");

    /* math_median */
    {
        double arr[] = {5.0, 1.0, 3.0, 2.0, 4.0};
        ASSERT_NEAR(math_median(arr, 5), 3.0, 1e-15, "median_odd");
    }

    /* eliminate_peak */
    {
        double in[30], out[30];
        for (int i = 0; i < 30; i++) in[i] = 100.0;
        in[15] = 999.0; /* outlier */
        eliminate_peak(in, out);
        /* Outlier should be replaced with mean */
        double mean_with_outlier = (29 * 100.0 + 999.0) / 30.0;
        ASSERT_NEAR(out[15], mean_with_outlier, 1e-10, "eliminate_peak_outlier");
        ASSERT_NEAR(out[0], 100.0, 1e-15, "eliminate_peak_normal");
    }

    /* fun_comp_decimals */
    ASSERT_EQ(fun_comp_decimals(1.005, 1.004, 2, 0), 1, "comp_eq_2digits");
    ASSERT_EQ(fun_comp_decimals(1.005, 1.006, 2, 0), 0, "comp_eq_2digits_2"); /* FP: 1.005*100=100.49→100, 1.006*100=100.59→101 */
    ASSERT_EQ(fun_comp_decimals(1.0, 2.0, 2, 2), 1, "comp_lt");

    /* cal_average_without_min_max */
    {
        double arr[] = {1.0, 5.0, 3.0, 2.0, 4.0};
        ASSERT_NEAR(cal_average_without_min_max(arr, 5), 3.0, 1e-15,
                    "avg_without_min_max");
    }

    /* fit_simple_regression */
    {
        double x[] = {1.0, 2.0, 3.0, 4.0};
        double y[] = {2.0, 4.0, 6.0, 8.0};
        double slope, intercept;
        fit_simple_regression(x, y, 4, &slope, &intercept);
        ASSERT_NEAR(slope, 2.0, 1e-10, "regression_slope");
        ASSERT_NEAR(intercept, 0.0, 1e-10, "regression_intercept");
    }

    /* solve_linear */
    {
        double x, y;
        solve_linear(2.0, 1.0, 1.0, 3.0, 5.0, 10.0, &x, &y);
        ASSERT_NEAR(x, 1.0, 1e-10, "solve_linear_x");
        ASSERT_NEAR(y, 3.0, 1e-10, "solve_linear_y");
    }

    printf("\n%d/%d tests passed\n", tests_passed, tests_run);
    return tests_passed == tests_run ? 0 : 1;
}
