/*
 * Unit tests for error detection pipeline (check_error).
 *
 * Tests err8 (boundary/sequence consistency) and err32 (BLE data gap flag)
 * detectors. Uses the same assert()/printf test harness as other tests.
 */

#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <float.h>

#include "check_error.h"
#include "calibration.h"

static int tests_passed = 0;
static int tests_failed = 0;

#define TEST(name) \
    do { printf("  %-60s", name); } while (0)

#define PASS() \
    do { printf("OK\n"); tests_passed++; } while (0)

#define FAIL(msg) \
    do { printf("FAIL: %s\n", msg); tests_failed++; } while (0)

#define ASSERT_EQ(a, b) \
    do { \
        long long _a = (long long)(a), _b = (long long)(b); \
        if (_a != _b) { \
            char _buf[128]; \
            snprintf(_buf, sizeof(_buf), "expected %lld, got %lld", _b, _a); \
            FAIL(_buf); return; \
        } \
    } while (0)

/* ── Helper: allocate and zero-initialize the large structs ── */

static struct air1_opcal4_arguments_t *alloc_args(void)
{
    struct air1_opcal4_arguments_t *p = calloc(1, sizeof(*p));
    assert(p != NULL);
    return p;
}

static struct air1_opcal4_device_info_t *alloc_dev_info(void)
{
    struct air1_opcal4_device_info_t *p = calloc(1, sizeof(*p));
    assert(p != NULL);
    return p;
}

static struct air1_opcal4_debug_t *alloc_debug(void)
{
    struct air1_opcal4_debug_t *p = calloc(1, sizeof(*p));
    assert(p != NULL);
    return p;
}

/* ════════════════════════════════════════════════════════════════════
 * err32 tests
 * ════════════════════════════════════════════════════════════════════ */

static void test_err32_all_flags_zero(void)
{
    TEST("err32: all flags zero -> error_code32 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* All debug fields zeroed by calloc */
    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->error_code32, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err32_flag1_set(void)
{
    TEST("err32: flag1 (err4_delay_flag) = 1 -> error_code32 = 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /*
     * err4_delay_flag is set by check_err4 (stub = noop).
     * We set it manually before calling check_error, but note that
     * check_err4 runs BEFORE check_err32 in the pipeline, so in a
     * real scenario err4 would set this. For testing err32's logic,
     * we need the flag set before err32 reads it.
     *
     * Since stubs don't clear debug fields, pre-setting it works
     * if check_err4 stub doesn't overwrite it.
     */
    dbg->err4_delay_flag = 1;

    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->error_code32, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err32_flag2_set(void)
{
    TEST("err32: flag2 (err1_is_contact_bad) = 1 -> error_code32 = 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dbg->err1_is_contact_bad = 1;

    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->error_code32, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err32_flag3_set(void)
{
    TEST("err32: flag3 (err1_random_noise_temp_break) = 1 -> error_code32 = 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dbg->err1_random_noise_temp_break = 1;

    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->error_code32, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err32_all_flags_set(void)
{
    TEST("err32: all 3 flags set -> error_code32 = 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dbg->err4_delay_flag = 1;
    dbg->err1_is_contact_bad = 1;
    dbg->err1_random_noise_temp_break = 1;

    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->error_code32, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err32_nonone_values(void)
{
    TEST("err32: flags set to 2 (not 1) -> error_code32 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* The binary checks cmp r0, #1 exactly, not just nonzero */
    dbg->err4_delay_flag = 2;
    dbg->err1_is_contact_bad = 2;
    dbg->err1_random_noise_temp_break = 2;

    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->error_code32, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * err8 tests
 * ════════════════════════════════════════════════════════════════════ */

static void test_err8_empty_accu_seq(void)
{
    TEST("err8: empty accu_seq -> error_code8 = 0, both condi = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Set threshold params to reasonable values */
    dev->err345_seq4[0] = 10;   /* start_offset */
    dev->err345_seq4[1] = 20;   /* window_size */
    dev->err345_seq4[2] = 5;    /* sum_threshold */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 100.0f;

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->error_code8, 0);
    ASSERT_EQ(dbg->err8_condi[0], 0);
    ASSERT_EQ(dbg->err8_condi[1], 0);
    ASSERT_EQ(args->err8_result_prev, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_insufficient_data(void)
{
    TEST("err8: count_in_range < start_offset-1 -> condition1 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;   /* start_offset */
    dev->err345_seq4[1] = 20;   /* window_size */
    dev->err345_seq4[2] = 5;    /* sum_threshold */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 100.0f;

    /* Put only 5 entries in range (need >= 9 for start_offset=10) */
    uint16_t seq = 100;
    for (int i = 0; i < 5; i++) {
        args->accu_seq[i] = seq - i;
    }

    check_error(args, dev, dbg, seq, 5.0);

    ASSERT_EQ(dbg->err8_condi[0], 0);
    ASSERT_EQ(dbg->error_code8, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_values_within_threshold(void)
{
    TEST("err8: all values <= threshold -> condition1 = 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 5;    /* start_offset */
    dev->err345_seq4[1] = 20;   /* window_size */
    dev->err345_seq4[2] = 100;  /* sum_threshold (high, won't trigger) */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;
    dev->err345_raw[0] = 10.0f; /* scale -> threshold = min(1*10, 50) = 10 */

    uint16_t seq = 100;
    /* Put enough entries in range */
    for (int i = 0; i < 10; i++) {
        args->accu_seq[i] = seq - i;
    }

    /* Set idx (data count) and err_glu_arr values below threshold */
    args->idx = 10;
    for (int i = 0; i < 10; i++) {
        args->err_glu_arr[i] = 5.0;  /* well below threshold of 10 */
    }

    /* seq_prev = 0 to skip the sequence continuity check path */
    args->seq_prev = 0;

    check_error(args, dev, dbg, seq, 5.0);

    ASSERT_EQ(dbg->err8_condi[0], 1);
    /* err8 result should be 1 since condition1 = 1 */
    ASSERT_EQ(dbg->error_code8, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_values_exceed_threshold(void)
{
    TEST("err8: values > threshold -> condition1 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 5;    /* start_offset */
    dev->err345_seq4[1] = 20;   /* window_size */
    dev->err345_seq4[2] = 100;  /* sum_threshold (high, won't trigger) */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;
    dev->err345_raw[0] = 10.0f; /* threshold = min(10, 50) = 10 */

    uint16_t seq = 100;
    for (int i = 0; i < 10; i++) {
        args->accu_seq[i] = seq - i;
    }

    args->idx = 10;
    /* Set one value above threshold within the checked range.
     * With idx=10 and count_in_range=6, indices 4..9 are validated. */
    for (int i = 0; i < 10; i++) {
        args->err_glu_arr[i] = 5.0;
    }
    args->err_glu_arr[6] = 15.0;  /* exceeds threshold of 10 */

    args->seq_prev = 0;

    check_error(args, dev, dbg, seq, 5.0);

    ASSERT_EQ(dbg->err8_condi[0], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_nan_value_fails(void)
{
    TEST("err8: NaN in err_glu_arr -> condition1 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 5;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 100;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;
    dev->err345_raw[0] = 10.0f;

    uint16_t seq = 100;
    for (int i = 0; i < 10; i++) {
        args->accu_seq[i] = seq - i;
    }

    args->idx = 10;
    /* With idx=10 and count_in_range=6, indices 4..9 are validated. */
    for (int i = 0; i < 10; i++) {
        args->err_glu_arr[i] = 5.0;
    }
    args->err_glu_arr[5] = NAN;  /* NaN should fail validation */

    args->seq_prev = 0;

    check_error(args, dev, dbg, seq, 5.0);

    ASSERT_EQ(dbg->err8_condi[0], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_hysteresis_latches(void)
{
    TEST("err8: hysteresis latches when prev=1 and data_count>=2");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 100;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* No data in range -> conditions would be 0 */
    /* But hysteresis should latch: data_count >= 2 and prev = 1 */
    args->idx = 5;  /* data_count >= 2 */
    args->err8_result_prev = 1;

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->error_code8, 1);
    ASSERT_EQ(args->err8_result_prev, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_hysteresis_no_latch_low_count(void)
{
    TEST("err8: no latch when data_count < 2 even if prev=1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 100;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    args->idx = 1;  /* data_count < 2 */
    args->err8_result_prev = 1;

    check_error(args, dev, dbg, 50, 5.0);

    /* No conditions met and no latch -> 0 */
    ASSERT_EQ(dbg->error_code8, 0);
    ASSERT_EQ(args->err8_result_prev, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_delay_flag_sum(void)
{
    TEST("err8: delay flag sum triggers condition2");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 5;   /* start_offset */
    dev->err345_seq4[1] = 50;  /* window_size (seq must be <= this) */
    dev->err345_seq4[2] = 3;   /* sum_threshold */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    uint16_t seq = 30;  /* seq_current <= window_size (30 <= 50) */

    /* Put entries in the window range */
    for (int i = 0; i < 10; i++) {
        args->accu_seq[i] = seq - i;
    }

    /* Set delay flags so sum >= sum_threshold */
    for (int i = 570; i < 576; i++) {
        args->err4_delay_flag_arr[i] = 1;
    }

    check_error(args, dev, dbg, seq, 5.0);

    ASSERT_EQ(dbg->err8_condi[1], 1);
    ASSERT_EQ(dbg->error_code8, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_delay_flag_below_threshold(void)
{
    TEST("err8: delay flag sum below threshold -> condition2 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 5;
    dev->err345_seq4[1] = 50;
    dev->err345_seq4[2] = 10;  /* high threshold */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    uint16_t seq = 30;

    for (int i = 0; i < 10; i++) {
        args->accu_seq[i] = seq - i;
    }

    /* Only 2 delay flags set (below threshold of 10) */
    args->err4_delay_flag_arr[574] = 1;
    args->err4_delay_flag_arr[575] = 1;

    check_error(args, dev, dbg, seq, 5.0);

    ASSERT_EQ(dbg->err8_condi[1], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err8_seq_above_window_no_condition2(void)
{
    TEST("err8: seq_current > window_size -> condition2 never set");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 5;
    dev->err345_seq4[1] = 20;  /* window_size */
    dev->err345_seq4[2] = 1;   /* very low threshold */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    uint16_t seq = 100;  /* seq_current > window_size (100 > 20) */

    for (int i = 0; i < 10; i++) {
        args->accu_seq[i] = seq - i;
    }

    /* Set lots of delay flags */
    for (int i = 0; i < 576; i++) {
        args->err4_delay_flag_arr[i] = 1;
    }

    check_error(args, dev, dbg, seq, 5.0);

    /* condition2 should NOT be set because seq > window_size */
    ASSERT_EQ(dbg->err8_condi[1], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * Epilogue tests
 * ════════════════════════════════════════════════════════════════════ */

static void test_err_delay_arr_shift(void)
{
    TEST("epilogue: err_delay_arr shifts left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Set recognizable pattern */
    args->err_delay_arr[0] = 10;
    args->err_delay_arr[1] = 20;
    args->err_delay_arr[2] = 30;
    args->err_delay_arr[3] = 40;
    args->err_delay_arr[4] = 50;
    args->err_delay_arr[5] = 60;
    args->err_delay_arr[6] = 70;

    check_error(args, dev, dbg, 100, 5.0);

    /* After memmove(arr, arr+1, 6): */
    ASSERT_EQ(args->err_delay_arr[0], 20);
    ASSERT_EQ(args->err_delay_arr[1], 30);
    ASSERT_EQ(args->err_delay_arr[2], 40);
    ASSERT_EQ(args->err_delay_arr[3], 50);
    ASSERT_EQ(args->err_delay_arr[4], 60);
    ASSERT_EQ(args->err_delay_arr[5], 70);
    /* arr[6] is unchanged (still 70 because memmove only moves 6 bytes) */

    free(args); free(dev); free(dbg);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * Full pipeline default behavior test
 * ════════════════════════════════════════════════════════════════════ */

static void test_check_error_stubs_produce_zero(void)
{
    TEST("check_error: stubs + reasonable config -> error_code32 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /*
     * With all-zero dev_info, err8 produces 1 because start_offset=0
     * makes the data sufficiency check vacuously true. Use reasonable
     * threshold values to get the expected default behavior.
     */
    dev->err345_seq4[0] = 10;   /* start_offset */
    dev->err345_seq4[1] = 20;   /* window_size */
    dev->err345_seq4[2] = 5;    /* sum_threshold */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 100, 5.0);

    /* err32: all stubs produce 0 flags -> error_code32 = 0 */
    ASSERT_EQ(dbg->error_code32, 0);
    /* err8: no accu_seq data, reasonable thresholds -> error_code8 = 0 */
    ASSERT_EQ(dbg->error_code8, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

/* ── main ── */

int main(void)
{
    printf("=== check_error tests ===\n\n");

    printf("err32 (BLE data gap flag):\n");
    test_err32_all_flags_zero();
    test_err32_flag1_set();
    test_err32_flag2_set();
    test_err32_flag3_set();
    test_err32_all_flags_set();
    test_err32_nonone_values();

    printf("\nerr8 (boundary/sequence consistency):\n");
    test_err8_empty_accu_seq();
    test_err8_insufficient_data();
    test_err8_values_within_threshold();
    test_err8_values_exceed_threshold();
    test_err8_nan_value_fails();
    test_err8_hysteresis_latches();
    test_err8_hysteresis_no_latch_low_count();
    test_err8_delay_flag_sum();
    test_err8_delay_flag_below_threshold();
    test_err8_seq_above_window_no_condition2();

    printf("\nEpilogue:\n");
    test_err_delay_arr_shift();

    printf("\nFull pipeline:\n");
    test_check_error_stubs_produce_zero();

    printf("\n%d passed, %d failed\n", tests_passed, tests_failed);

    return tests_failed > 0 ? EXIT_FAILURE : EXIT_SUCCESS;
}
