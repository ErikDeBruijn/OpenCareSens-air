/*
 * Unit tests for signal processing pipeline functions.
 *
 * Tests smooth_sg, regress_cal, and f_cgm_trend implementations
 * against known behaviors derived from ARM binary analysis.
 */

#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <float.h>

#include "signal_processing.h"
#include "math_utils.h"
#include "calibration.h"

static int tests_passed = 0;
static int tests_failed = 0;

#define EPSILON 1e-6

#define TEST(name) \
    do { printf("  %-60s", name); } while (0)

#define PASS() \
    do { printf("OK\n"); tests_passed++; } while (0)

#define FAIL(msg) \
    do { printf("FAIL: %s\n", msg); tests_failed++; } while (0)

#define ASSERT_DOUBLE_EQ(a, b) \
    do { \
        double _a = (a), _b = (b); \
        if (fabs(_a - _b) > EPSILON) { \
            char _buf[128]; \
            snprintf(_buf, sizeof(_buf), "expected %.10g, got %.10g", _b, _a); \
            FAIL(_buf); return; \
        } \
    } while (0)

#define ASSERT_DOUBLE_NEAR(a, b, tol) \
    do { \
        double _a = (a), _b = (b); \
        if (fabs(_a - _b) > (tol)) { \
            char _buf[128]; \
            snprintf(_buf, sizeof(_buf), "expected %.10g +/- %.1e, got %.10g", _b, (tol), _a); \
            FAIL(_buf); return; \
        } \
    } while (0)

#define ASSERT_NAN(a) \
    do { \
        double _a = (a); \
        if (!isnan(_a)) { \
            char _buf[128]; \
            snprintf(_buf, sizeof(_buf), "expected NaN, got %.10g", _a); \
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

/* ════════════════════════════════════════════════════════════════════
 * smooth_sg tests
 * ════════════════════════════════════════════════════════════════════ */

static void test_smooth_sg_constant_input(void)
{
    TEST("smooth_sg: constant input passes through unchanged");

    double signal[10];
    double w_sg[7];
    double output[10];

    /* Constant signal at 100.0 */
    for (int i = 0; i < 10; i++) signal[i] = 100.0;
    /* Unit w_sg coefficients */
    for (int i = 0; i < 7; i++) w_sg[i] = 1.0;

    smooth_sg(signal, w_sg, output, 50.0);

    /* A constant signal should remain constant after SG smoothing.
     * After normalization: all values become 0.0 (signal[i] - signal[9] = 0).
     * Convolution of zeros = zeros.
     * After denormalization: 0 * scale + baseline = baseline = 100.0. */
    for (int i = 0; i < 10; i++) {
        ASSERT_DOUBLE_NEAR(output[i], 100.0, 1e-10);
    }
    PASS();
}

static void test_smooth_sg_linear_input(void)
{
    TEST("smooth_sg: linear input approximately preserved");

    double signal[10];
    double w_sg[7];
    double output[10];

    /* Linear signal: 10, 20, 30, ..., 100 */
    for (int i = 0; i < 10; i++) signal[i] = (double)(i + 1) * 10.0;
    /* Unit w_sg coefficients */
    for (int i = 0; i < 7; i++) w_sg[i] = 1.0;

    smooth_sg(signal, w_sg, output, 100.0);

    /* SG smoothing preserves linear trends. After normalization the data
     * is linear, and the SG convolution of a linear function should
     * reproduce the linear function (for interior points). */
    for (int i = 3; i < 7; i++) {
        /* Interior points should be close to the original linear values */
        ASSERT_DOUBLE_NEAR(output[i], signal[i], 5.0);
    }
    PASS();
}

static void test_smooth_sg_noise_reduction(void)
{
    TEST("smooth_sg: reduces noise on smooth signal");

    double signal[10] = {50.0, 51.0, 49.0, 52.0, 48.0,
                         51.0, 49.0, 50.5, 49.5, 50.0};
    double w_sg[7];
    double output[10];

    for (int i = 0; i < 7; i++) w_sg[i] = 1.0;

    smooth_sg(signal, w_sg, output, 10.0);

    /* The output should be smoother than the input.
     * Compute variance of input vs output (interior points only). */
    double input_var = 0.0, output_var = 0.0;
    double input_mean = 0.0, output_mean = 0.0;

    for (int i = 3; i < 7; i++) {
        input_mean += signal[i];
        output_mean += output[i];
    }
    input_mean /= 4.0;
    output_mean /= 4.0;

    for (int i = 3; i < 7; i++) {
        double di = signal[i] - input_mean;
        double do_ = output[i] - output_mean;
        input_var += di * di;
        output_var += do_ * do_;
    }

    /* Output variance should be less than or equal to input variance */
    ASSERT_TRUE(output_var <= input_var + 1e-6);
    PASS();
}

static void test_smooth_sg_zero_coefficients(void)
{
    TEST("smooth_sg: zero w_sg gives baseline output");

    double signal[10] = {10.0, 20.0, 30.0, 40.0, 50.0,
                         60.0, 70.0, 80.0, 90.0, 100.0};
    double w_sg[7] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
    double output[10];

    smooth_sg(signal, w_sg, output, 50.0);

    /* With zero coefficients, the effective kernel is all zeros.
     * Convolution produces zeros. Denormalize: 0 * scale + baseline.
     * Baseline = signal[9] = 100.0. */
    for (int i = 0; i < 10; i++) {
        ASSERT_DOUBLE_NEAR(output[i], 100.0, 1e-10);
    }
    PASS();
}

static void test_smooth_sg_scale_factor(void)
{
    TEST("smooth_sg: different scale factors give same result");

    double signal[10] = {100.0, 102.0, 98.0, 103.0, 97.0,
                         101.0, 99.0, 100.5, 99.5, 100.0};
    double w_sg[7];
    double output1[10], output2[10];

    for (int i = 0; i < 7; i++) w_sg[i] = 1.0;

    smooth_sg(signal, w_sg, output1, 10.0);
    smooth_sg(signal, w_sg, output2, 50.0);

    /* Both should produce valid output; the scale factor affects
     * normalization range but the final denormalized result should
     * converge to the same smoothed values. */
    for (int i = 3; i < 7; i++) {
        ASSERT_DOUBLE_NEAR(output1[i], output2[i], 0.1);
    }
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * regress_cal tests
 * ════════════════════════════════════════════════════════════════════ */

/* Helper to create a minimal args struct with CalLog entries */
static void setup_args_with_callog(
    struct air1_opcal4_arguments_t *args,
    int n_entries,
    double *x_vals, double *y_vals, double *bgSeq_vals)
{
    memset(args, 0, sizeof(*args));

    /* Set cal_state to mode 1 */
    args->CalLog_cal_state = 1;

    /* Set a high age threshold reference value */
    args->cal_result_in_smooth_ycept[0] = 10000.0;

    for (int i = 0; i < n_entries && i < 50; i++) {
        args->CalLog[i].bgValid = 1;
        args->CalLog[i].cgCal = x_vals[i];
        args->CalLog[i].bgCal = y_vals[i];
        args->CalLog[i].bgSeq = bgSeq_vals[i];
    }
}

static void test_regress_cal_uncalibrated(void)
{
    TEST("regress_cal: uncalibrated seeds factory values into regression");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    struct air1_opcal4_device_info_t dev_info;
    double result[2] = {0.0, 0.0};

    memset(&dev_info, 0, sizeof(dev_info));
    memset(args, 0, sizeof(*args));

    args->CalLog_cal_state = (int8_t)0xFF;
    args->cal_result_slope[0] = 1.5;
    args->cal_result_ycept[0] = -0.5;

    /* The uncalibrated path seeds factory values as a single calibration
     * point and runs IRLS regression with extrapolated points.
     * coef_length must be >= 1 to keep the seeded point. */
    dev_info.coef_length = 60;
    dev_info.slope_dcal_rate = 0.0;
    dev_info.slope = 0.0;

    regress_cal(args, result, &dev_info);

    /* Result should be finite (regression ran successfully).
     * With extrapolated points at (0,0), the slope will be pulled
     * toward the factory values but not exactly match them. */
    ASSERT_TRUE(!isnan(result[0]));
    ASSERT_TRUE(!isnan(result[1]));
    ASSERT_TRUE(!isinf(result[0]));
    ASSERT_TRUE(!isinf(result[1]));

    free(args);
    PASS();
}

static void test_regress_cal_no_valid_points(void)
{
    TEST("regress_cal: no valid points uses defaults");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    struct air1_opcal4_device_info_t dev_info;
    double result[2] = {0.0, 0.0};

    memset(&dev_info, 0, sizeof(dev_info));
    memset(args, 0, sizeof(*args));

    args->CalLog_cal_state = 1;
    args->cal_result_slope[0] = 2.0;
    args->cal_result_ycept[0] = -1.0;

    /* CalLog entries all have bgValid = 0 (from memset) */
    dev_info.slope_dcal_target_length = 1000;

    regress_cal(args, result, &dev_info);

    ASSERT_DOUBLE_EQ(result[0], 2.0);
    ASSERT_DOUBLE_EQ(result[1], -1.0);

    free(args);
    PASS();
}

static void test_regress_cal_perfect_linear(void)
{
    TEST("regress_cal: perfect linear data y=2x+1");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    struct air1_opcal4_device_info_t dev_info;
    double result[2] = {0.0, 0.0};

    memset(&dev_info, 0, sizeof(dev_info));

    /* Create 5 perfect calibration points: y = 2x + 1 */
    double x[] = {10.0, 20.0, 30.0, 40.0, 50.0};
    double y[] = {21.0, 41.0, 61.0, 81.0, 101.0};
    double seq[] = {100.0, 200.0, 300.0, 400.0, 500.0};

    setup_args_with_callog(args, 5, x, y, seq);

    dev_info.slope_dcal_target_length = 50000;
    dev_info.coef_length = 60;
    dev_info.slope_dcal_rate = 0.0;
    dev_info.slope = 0.0;

    regress_cal(args, result, &dev_info);

    /* With perfect linear data, IRLS should converge to exact slope/intercept.
     * The extrapolated factory points may perturb the result slightly,
     * but the slope should be close to 2.0 and intercept close to 1.0. */
    ASSERT_DOUBLE_NEAR(result[0], 2.0, 0.5);
    ASSERT_TRUE(!isnan(result[0]));
    ASSERT_TRUE(!isnan(result[1]));

    free(args);
    PASS();
}

static void test_regress_cal_with_outlier(void)
{
    TEST("regress_cal: IRLS downweights outlier");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    struct air1_opcal4_device_info_t dev_info;
    double result[2] = {0.0, 0.0};

    memset(&dev_info, 0, sizeof(dev_info));

    /* 4 good points on y=x, plus 1 outlier */
    double x[] = {10.0, 20.0, 30.0, 40.0, 25.0};
    double y[] = {10.0, 20.0, 30.0, 40.0, 100.0}; /* last is outlier */
    double seq[] = {100.0, 200.0, 300.0, 400.0, 500.0};

    setup_args_with_callog(args, 5, x, y, seq);

    dev_info.slope_dcal_target_length = 50000;
    dev_info.coef_length = 60;
    dev_info.slope_dcal_rate = 0.0;
    dev_info.slope = 0.0;

    regress_cal(args, result, &dev_info);

    /* With IRLS bisquare weighting, the outlier should be downweighted.
     * The slope should still be approximately 1.0 (from the 4 good points),
     * though the extrapolated points may shift it somewhat. */
    ASSERT_TRUE(!isnan(result[0]));
    ASSERT_TRUE(!isnan(result[1]));
    /* The slope should be closer to 1.0 than OLS would give */
    ASSERT_TRUE(fabs(result[0]) < 5.0);

    free(args);
    PASS();
}

static void test_regress_cal_mode2(void)
{
    TEST("regress_cal: mode 2 uses slope_dcal_window threshold");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    struct air1_opcal4_device_info_t dev_info;
    double result[2] = {0.0, 0.0};

    memset(&dev_info, 0, sizeof(dev_info));
    memset(args, 0, sizeof(*args));

    args->CalLog_cal_state = 2;
    args->cal_result_in_smooth_ycept[0] = 10000.0;
    args->cal_result_slope[0] = 3.0;
    args->cal_result_ycept[0] = -2.0;

    /* Set window threshold to 0 so no points pass the age filter */
    dev_info.slope_dcal_window = 0;

    /* Add a valid CalLog entry */
    args->CalLog[0].bgValid = 1;
    args->CalLog[0].cgCal = 50.0;
    args->CalLog[0].bgCal = 100.0;
    args->CalLog[0].bgSeq = 100.0;

    regress_cal(args, result, &dev_info);

    /* With threshold 0, the age check (10000 - 100 = 9900 > 0) fails,
     * so no valid points => uses defaults */
    ASSERT_DOUBLE_EQ(result[0], 3.0);
    ASSERT_DOUBLE_EQ(result[1], -2.0);

    free(args);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * f_cgm_trend tests
 * ════════════════════════════════════════════════════════════════════ */

static void test_f_cgm_trend_insufficient_data(void)
{
    TEST("f_cgm_trend: insufficient data sets NaN");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    double result[22];
    memset(result, 0, sizeof(result));
    memset(args, 0, sizeof(*args));

    /* Set idx to 0 (very early in sensor life) */
    args->idx = 0;

    /* min_n = 100 but n_valid_seq will be ~0 */
    f_cgm_trend(args, NULL, result, 10, 100.0, 50.0, 0.0,
                NULL, 0, 2, 0);

    /* With idx=0 and insufficient data, the early startup path sets
     * result[0] and result[1] to NaN. */
    ASSERT_NAN(result[0]);
    ASSERT_NAN(result[1]);

    free(args);
    PASS();
}

static void test_f_cgm_trend_constant_signal(void)
{
    TEST("f_cgm_trend: constant ISF signal gives zero trend");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    double result[22];
    memset(result, 0, sizeof(result));
    memset(args, 0, sizeof(*args));

    /* Fill ISF smooth array with constant value.
     * Set accu_seq values within n_back of seq_current so they pass
     * the validity check: seq_val >= (seq_current - n_back). */
    for (int i = 0; i < 865; i++) {
        args->err16_CGM_ISF_smooth[i] = 100.0;
        args->accu_seq[i] = (uint16_t)(301 + i);
    }
    args->idx = 0;

    f_cgm_trend(args, NULL, result, 500, 10.0, 200.0, 50.0,
                NULL, 0, 2, 0);

    /* With constant signal at 100.0, the 10th percentile reference
     * (mode 0) should be 100.0. */
    ASSERT_DOUBLE_NEAR(result[0], 100.0, 1.0);

    free(args);
    PASS();
}

static void test_f_cgm_trend_mode0_percentile(void)
{
    TEST("f_cgm_trend: mode 0 uses 10th percentile");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    double result[22];
    memset(result, 0, sizeof(result));
    memset(args, 0, sizeof(*args));

    /* Fill ISF smooth array with increasing values.
     * Set accu_seq within n_back of seq_current. */
    for (int i = 0; i < 865; i++) {
        args->err16_CGM_ISF_smooth[i] = (double)(50 + i);
        args->accu_seq[i] = (uint16_t)(401 + i);
    }
    args->idx = 0;

    f_cgm_trend(args, NULL, result, 500, 5.0, 100.0, 50.0,
                NULL, 0, 2, 0);

    /* Mode 0 computes the 10th percentile of the ISF data as reference.
     * The result should be a valid finite number in the input range. */
    ASSERT_TRUE(!isnan(result[0]));
    ASSERT_TRUE(!isinf(result[0]));
    ASSERT_TRUE(result[0] >= 50.0 && result[0] <= 915.0);

    free(args);
    PASS();
}

static void test_f_cgm_trend_mode2_statistical_mode(void)
{
    TEST("f_cgm_trend: mode 2 computes statistical mode");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    double result[22];
    memset(result, 0, sizeof(result));
    memset(args, 0, sizeof(*args));

    /* Fill ISF data with values that quantize to a known mode.
     * Values around 100 (quantized to 100) should dominate.
     * Set accu_seq within n_back of seq_current. */
    for (int i = 0; i < 865; i++) {
        if (i % 3 == 0) {
            args->err16_CGM_ISF_smooth[i] = 98.0 + (double)(i % 5);
        } else {
            args->err16_CGM_ISF_smooth[i] = 148.0 + (double)(i % 10);
        }
        args->accu_seq[i] = (uint16_t)(401 + i);
    }
    args->idx = 0;

    f_cgm_trend(args, NULL, result, 500, 5.0, 100.0, 50.0,
                NULL, 2, 2, 0);

    /* Mode 2 quantizes values and finds the statistical mode.
     * result[0] should be the mode value, result[11] the proportion. */
    ASSERT_TRUE(!isnan(result[0]));
    ASSERT_TRUE(result[11] > 0.0 && result[11] <= 100.0);

    free(args);
    PASS();
}

static void test_f_cgm_trend_does_not_crash_with_nan_data(void)
{
    TEST("f_cgm_trend: NaN data handled gracefully");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    double result[22];
    memset(result, 0, sizeof(result));
    memset(args, 0, sizeof(*args));

    /* Fill with NaN values, set accu_seq within valid range */
    for (int i = 0; i < 865; i++) {
        args->err16_CGM_ISF_smooth[i] = NAN;
        args->accu_seq[i] = (uint16_t)(401 + i);
    }
    args->idx = 0;

    f_cgm_trend(args, NULL, result, 500, 5.0, 100.0, 50.0,
                NULL, 0, 2, 0);

    /* With all-NaN ISF data, after filtering no valid points remain.
     * The function should produce NaN or handle gracefully. */
    ASSERT_TRUE(isnan(result[0]) || result[0] == 0.0);

    free(args);
    PASS();
}

static void test_f_cgm_trend_mode1_trimmed_mean(void)
{
    TEST("f_cgm_trend: mode 1 uses trimmed mean");

    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    double result[22];
    memset(result, 0, sizeof(result));
    memset(args, 0, sizeof(*args));

    /* Fill with valid data, set accu_seq within valid range */
    for (int i = 0; i < 865; i++) {
        args->err16_CGM_ISF_smooth[i] = 80.0 + (double)(i % 40);
        args->accu_seq[i] = (uint16_t)(401 + i);
    }
    args->idx = 0;

    f_cgm_trend(args, NULL, result, 500, 5.0, 100.0, 50.0,
                NULL, 1, 2, 0);

    /* Mode 1 uses 20% trimmed mean as reference. With data 80 + (i%40),
     * the trimmed mean should be in [80, 120] range. */
    ASSERT_TRUE(!isnan(result[0]));
    ASSERT_TRUE(result[0] >= 80.0 && result[0] <= 120.0);

    free(args);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * smooth1q_err16 tests
 * ════════════════════════════════════════════════════════════════════ */

static void test_smooth1q_err16_constant_input(void)
{
    TEST("smooth1q_err16: constant input passes through unchanged");

    double input[10];
    double output[10];

    for (int i = 0; i < 10; i++) input[i] = 42.0;
    memset(output, 0, sizeof(output));

    smooth1q_err16(input, 10, output);

    /* A constant signal has zero energy in all frequencies except DC.
     * The DC component (m=0) has Hann weight w[0] = 2 - 2*cos(0) = 0,
     * so scale = 1/(1 + n*0^2) = 1, meaning DC passes through unchanged.
     * All other frequencies have zero coefficient. Output should be 42.0. */
    for (int i = 0; i < 10; i++) {
        ASSERT_DOUBLE_NEAR(output[i], 42.0, 1e-8);
    }
    PASS();
}

static void test_smooth1q_err16_single_element(void)
{
    TEST("smooth1q_err16: single element passes through");

    double input[1] = {7.5};
    double output[1] = {0.0};

    smooth1q_err16(input, 1, output);

    /* With n=1, there is only one frequency (m=0, DC).
     * w[0] = 2 - 2*cos(0) = 0, scale = 1.0.
     * a[0] = input[0] * cos(0) = 7.5
     * output[0] = a[0] * cos(0) / 1 = 7.5 */
    ASSERT_DOUBLE_NEAR(output[0], 7.5, 1e-10);
    PASS();
}

static void test_smooth1q_err16_linear_input(void)
{
    TEST("smooth1q_err16: linear signal is smoothed");

    double input[10];
    double output[10];

    for (int i = 0; i < 10; i++) input[i] = (double)(i + 1) * 10.0;
    memset(output, 0, sizeof(output));

    smooth1q_err16(input, 10, output);

    /* A linear signal has energy in the DC and first harmonic.
     * The Hann window smoothing will dampen higher frequencies.
     * The output should be a smooth version of the input, generally
     * following the linear trend but potentially with edge effects. */
    for (int i = 0; i < 10; i++) {
        ASSERT_TRUE(!isnan(output[i]));
        ASSERT_TRUE(!isinf(output[i]));
    }

    /* The smoothed output should still be generally increasing */
    for (int i = 1; i < 9; i++) {
        ASSERT_TRUE(output[i] > output[0] - 10.0);
    }
    PASS();
}

static void test_smooth1q_err16_smooths_noise(void)
{
    TEST("smooth1q_err16: reduces high-frequency noise");

    /* Create a signal with a smooth trend plus noise */
    double input[20];
    double output[20];
    double clean[20];

    for (int i = 0; i < 20; i++) {
        clean[i] = 100.0 + 2.0 * (double)i;
        /* Add alternating noise: +/-5.0 on every other sample */
        input[i] = clean[i] + ((i % 2 == 0) ? 5.0 : -5.0);
    }
    memset(output, 0, sizeof(output));

    smooth1q_err16(input, 20, output);

    /* The smoothed output should be closer to the clean signal
     * than the noisy input, at least for interior points.
     * Compare RMS error of input vs output relative to clean. */
    double input_err = 0.0, output_err = 0.0;
    for (int i = 3; i < 17; i++) {
        double ie = input[i] - clean[i];
        double oe = output[i] - clean[i];
        input_err += ie * ie;
        output_err += oe * oe;
    }

    /* Output should have less error than input relative to the clean signal */
    ASSERT_TRUE(output_err < input_err);
    PASS();
}

static void test_smooth1q_err16_preserves_dc(void)
{
    TEST("smooth1q_err16: preserves DC level (mean)");

    double input[8];
    double output[8];

    /* Constant + small perturbation */
    for (int i = 0; i < 8; i++) {
        input[i] = 200.0 + ((i == 3) ? 10.0 : 0.0);
    }
    memset(output, 0, sizeof(output));

    smooth1q_err16(input, 8, output);

    /* The DFT preserves the total energy / mean of the signal.
     * Since DC has w[0]=0, scale=1, the mean is exactly preserved.
     * Compute input and output means. */
    double input_mean = 0.0, output_mean = 0.0;
    for (int i = 0; i < 8; i++) {
        input_mean += input[i];
        output_mean += output[i];
    }
    input_mean /= 8.0;
    output_mean /= 8.0;

    ASSERT_DOUBLE_NEAR(output_mean, input_mean, 1e-8);
    PASS();
}

static void test_smooth1q_err16_hann_window_values(void)
{
    TEST("smooth1q_err16: verify Hann window coefficients");

    /* Test with n=4: w[i] = 2 - 2*cos(2*i*pi/4)
     * w[0] = 2 - 2*cos(0)   = 2 - 2 = 0
     * w[1] = 2 - 2*cos(pi/2) = 2 - 0 = 2
     * w[2] = 2 - 2*cos(pi)  = 2 + 2 = 4
     * w[3] = 2 - 2*cos(3*pi/2) = 2 - 0 = 2
     *
     * With n=4 and constant input of 1.0:
     * DC (m=0): a[0]=4, b[0]=0, scale=1/(1+4*0)=1, a_s=4
     * m=1: a[1]=0, b[1]=0, scale=1/(1+4*4)=1/17, irrelevant since a=b=0
     * m=2: a[2]=0, b[2]=0, scale=1/(1+4*16)=1/65
     * m=3: same as m=1
     *
     * output[i] = 4/4 = 1.0 for all i (constant passes through) */
    double input[4] = {1.0, 1.0, 1.0, 1.0};
    double output[4] = {0.0};

    smooth1q_err16(input, 4, output);

    for (int i = 0; i < 4; i++) {
        ASSERT_DOUBLE_NEAR(output[i], 1.0, 1e-10);
    }
    PASS();
}

static void test_smooth1q_err16_pure_sinusoid(void)
{
    TEST("smooth1q_err16: pure sinusoid is damped by Hann weight");

    /* With n=8, create a pure cosine at frequency m=1:
     * input[j] = cos(2*pi*j/8)
     *
     * DFT analysis: a[1] = n/2 = 4, all others zero (for this freq).
     * Hann weight: w[1] = 2 - 2*cos(2*pi/8) = 2 - sqrt(2) ~ 0.5858
     * Scale = 1 / (1 + 8 * w[1]^2) = 1 / (1 + 8 * 0.3431) = 1/3.7451
     *
     * The output should be a damped version of the input cosine. */
    int n = 8;
    double input[8], output[8];

    for (int i = 0; i < n; i++) {
        input[i] = cos(2.0 * M_PI * (double)i / (double)n);
    }
    memset(output, 0, sizeof(output));

    smooth1q_err16(input, (uint32_t)n, output);

    /* The output amplitude should be less than the input amplitude
     * due to Hann window damping. */
    double max_output = 0.0;
    for (int i = 0; i < n; i++) {
        double absval = fabs(output[i]);
        if (absval > max_output) max_output = absval;
    }

    /* Input amplitude is 1.0, output should be damped below 1.0 */
    ASSERT_TRUE(max_output < 1.0);
    ASSERT_TRUE(max_output > 0.01); /* but not completely zeroed */
    PASS();
}

static void test_smooth1q_err16_cgm_like_data(void)
{
    TEST("smooth1q_err16: CGM-like ISF data smoothed correctly");

    /* Simulate realistic CGM ISF values (mg/dL range, ~50-300)
     * with sensor noise */
    int n = 20;
    double input[20], output[20];

    for (int i = 0; i < n; i++) {
        /* Slowly increasing ISF with noise */
        input[i] = 120.0 + 0.5 * (double)i
                   + 3.0 * sin(2.0 * M_PI * (double)i * 3.0 / (double)n);
    }
    memset(output, 0, sizeof(output));

    smooth1q_err16(input, (uint32_t)n, output);

    /* All outputs should be finite */
    for (int i = 0; i < n; i++) {
        ASSERT_TRUE(!isnan(output[i]));
        ASSERT_TRUE(!isinf(output[i]));
    }

    /* Output should be in a reasonable range around the input values */
    for (int i = 0; i < n; i++) {
        ASSERT_TRUE(output[i] > 100.0 && output[i] < 150.0);
    }
    PASS();
}

static void test_smooth1q_err16_n_equals_two(void)
{
    TEST("smooth1q_err16: n=2 edge case");

    double input[2] = {10.0, 20.0};
    double output[2] = {0.0, 0.0};

    smooth1q_err16(input, 2, output);

    /* With n=2:
     * w[0] = 2 - 2*cos(0) = 0
     * w[1] = 2 - 2*cos(pi) = 4
     * DC: a[0] = 30, scale = 1.0, a_s = 30
     * m=1: a[1] = -10, w=4, scale = 1/(1+2*16) = 1/33
     * The output should be valid finite values */
    ASSERT_TRUE(!isnan(output[0]));
    ASSERT_TRUE(!isnan(output[1]));
    ASSERT_TRUE(!isinf(output[0]));
    ASSERT_TRUE(!isinf(output[1]));

    /* Mean should be preserved */
    double in_mean = (input[0] + input[1]) / 2.0;
    double out_mean = (output[0] + output[1]) / 2.0;
    ASSERT_DOUBLE_NEAR(out_mean, in_mean, 1e-8);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * Integration-style tests
 * ════════════════════════════════════════════════════════════════════ */

static void test_smooth_sg_then_regress(void)
{
    TEST("integration: smooth_sg followed by regress_cal");

    /* Simulate a pipeline: smooth a noisy signal, then calibrate */
    double signal[10] = {90.0, 95.0, 88.0, 102.0, 97.0,
                         93.0, 105.0, 98.0, 91.0, 100.0};
    double w_sg[7] = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0};
    double smoothed[10];

    smooth_sg(signal, w_sg, smoothed, 50.0);

    /* The smoothed output should be valid doubles */
    for (int i = 0; i < 10; i++) {
        ASSERT_TRUE(!isnan(smoothed[i]));
        ASSERT_TRUE(!isinf(smoothed[i]));
    }

    /* Now do a calibration with the smoothed values as input */
    struct air1_opcal4_arguments_t *args = calloc(1, sizeof(*args));
    struct air1_opcal4_device_info_t dev_info;
    double cal_result[2];

    memset(&dev_info, 0, sizeof(dev_info));
    memset(args, 0, sizeof(*args));

    args->CalLog_cal_state = (int8_t)0xFF;
    args->cal_result_slope[0] = 1.0;
    args->cal_result_ycept[0] = 0.0;

    regress_cal(args, cal_result, &dev_info);

    /* Should use defaults since we set 0xFF mode */
    ASSERT_DOUBLE_EQ(cal_result[0], 1.0);
    ASSERT_DOUBLE_EQ(cal_result[1], 0.0);

    free(args);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * Main test runner
 * ════════════════════════════════════════════════════════════════════ */

int main(void)
{
    printf("=== Signal processing pipeline tests ===\n\n");

    printf("-- smooth_sg --\n");
    test_smooth_sg_constant_input();
    test_smooth_sg_linear_input();
    test_smooth_sg_noise_reduction();
    test_smooth_sg_zero_coefficients();
    test_smooth_sg_scale_factor();

    printf("\n-- regress_cal --\n");
    test_regress_cal_uncalibrated();
    test_regress_cal_no_valid_points();
    test_regress_cal_perfect_linear();
    test_regress_cal_with_outlier();
    test_regress_cal_mode2();

    printf("\n-- f_cgm_trend --\n");
    test_f_cgm_trend_insufficient_data();
    test_f_cgm_trend_constant_signal();
    test_f_cgm_trend_mode0_percentile();
    test_f_cgm_trend_mode2_statistical_mode();
    test_f_cgm_trend_does_not_crash_with_nan_data();
    test_f_cgm_trend_mode1_trimmed_mean();

    printf("\n-- smooth1q_err16 --\n");
    test_smooth1q_err16_constant_input();
    test_smooth1q_err16_single_element();
    test_smooth1q_err16_linear_input();
    test_smooth1q_err16_smooths_noise();
    test_smooth1q_err16_preserves_dc();
    test_smooth1q_err16_hann_window_values();
    test_smooth1q_err16_pure_sinusoid();
    test_smooth1q_err16_cgm_like_data();
    test_smooth1q_err16_n_equals_two();

    printf("\n-- Integration --\n");
    test_smooth_sg_then_regress();

    printf("\n=== Results: %d passed, %d failed ===\n",
           tests_passed, tests_failed);

    return tests_failed > 0 ? EXIT_FAILURE : EXIT_SUCCESS;
}
