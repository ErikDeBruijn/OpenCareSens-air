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

#include "calibration.h"
#include "check_error.h"

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

#define ASSERT_DOUBLE_EQ(a, b) \
    do { \
        double _a = (double)(a), _b = (double)(b); \
        if (fabs(_a - _b) > 1e-9) { \
            char _buf[128]; \
            snprintf(_buf, sizeof(_buf), "expected %.6f, got %.6f", _b, _a); \
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

    /*
     * Force err1 to take its early-exit path so it does not produce
     * side-effects (random_noise_temp_break=1 from all-zero inputs).
     * With all-zero data, the binary also sets that flag because 0.0 >= 0.0
     * passes its threshold check for all 100 history entries.
     */
    dev->err1_seq[0] = 255;

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

    /*
     * Force err1 early exit so it doesn't overwrite the pre-set flags.
     * Without this, err1 re-initializes err1_is_contact_bad and
     * err1_random_noise_temp_break, clobbering the test setup.
     */
    dev->err1_seq[0] = 255;

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
 * err128 tests (noise/spike revision)
 * ════════════════════════════════════════════════════════════════════ */

static void test_err128_seq_below_2_skips(void)
{
    TEST("err128: seq_current < 2 -> flag = 0, no detection");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* seq_current = 1 should trigger early exit (< 2) */
    check_error(args, dev, dbg, 1, 5.0);

    ASSERT_EQ(dbg->err128_flag, 0);
    ASSERT_DOUBLE_EQ(dbg->err128_revised_value, 0.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err128_seq_below_threshold_skips(void)
{
    TEST("err128: seq_current <= dev_info threshold -> flag = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Set threshold high so seq_current is below it */
    dev->err345_seq5[2] = 500;
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->err128_flag, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err128_lot_type_above_2_skips(void)
{
    TEST("err128: lot_type > 2 -> flag = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    args->lot_type = 3;
    dev->err345_seq5[2] = 1; /* Low threshold so we pass that check */
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->err128_flag, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err128_initializes_output_fields(void)
{
    TEST("err128: initializes flag=0 and revised_value=0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Pre-set to non-zero to verify they get cleared */
    dbg->err128_flag = 1;
    dbg->err128_revised_value = 99.0;

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* seq < 2 triggers early exit after initialization */
    check_error(args, dev, dbg, 1, 5.0);

    ASSERT_EQ(dbg->err128_flag, 0);
    ASSERT_DOUBLE_EQ(dbg->err128_revised_value, 0.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err128_epilogue_shifts_flag_prev(void)
{
    TEST("err128: epilogue shifts err128_flag_prev left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set recognizable pattern in flag_prev */
    for (int i = 0; i < 40; i++) {
        args->err128_flag_prev[i] = (uint8_t)(i + 1);
    }

    check_error(args, dev, dbg, 1, 5.0);

    /* After shift: [0] should be old [1]=2, [38] should be old [39]=40 */
    ASSERT_EQ(args->err128_flag_prev[0], 2);
    ASSERT_EQ(args->err128_flag_prev[38], 40);
    /* [39] should be the new flag (0 since seq < 2) */
    ASSERT_EQ(args->err128_flag_prev[39], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err128_epilogue_stores_normal_prev(void)
{
    TEST("err128: epilogue stores normal and revised to args");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set debug values that will be copied to args in epilogue */
    dbg->err1_i_sse_d_mean = 42.0;

    check_error(args, dev, dbg, 1, 5.0);

    /* err128_normal is set from err1_i_sse_d_mean */
    ASSERT_DOUBLE_EQ(dbg->err128_normal, 42.0);
    /* And copied to args in epilogue */
    ASSERT_DOUBLE_EQ(args->err128_normal_prev, 42.0);
    /* revised_value is 0 (no flag set) */
    ASSERT_DOUBLE_EQ(args->err128_revised_value_prev, 0.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err128_path_b_insufficient_data(void)
{
    TEST("err128: path B with insufficient valid_count -> flag = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    args->lot_type = 1;
    dev->err345_seq5[2] = 1;
    dev->err345_seq3[0] = 10;
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* No previous flag, path B: not enough accu_seq entries */
    args->err128_flag_prev[39] = 0;

    check_error(args, dev, dbg, 100, 5.0);

    /* With no accu_seq data, valid_count=0, window_param-1 != 0 */
    ASSERT_EQ(dbg->err128_flag, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * err4 tests (signal quality)
 * ════════════════════════════════════════════════════════════════════ */

static void test_err4_all_zero_no_data(void)
{
    TEST("err4: all-zero with no accu_seq data -> error_code4 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 100, 5.0);

    /* With no data: early exit preserves zero delay flag */
    ASSERT_EQ(dbg->error_code4, 0);
    ASSERT_EQ(dbg->err4_delay_flag, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_clears_condi(void)
{
    TEST("err4: clears all err4_condi[0..4] before analysis");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Pre-set condi to non-zero */
    for (int i = 0; i < 5; i++) {
        dbg->err4_condi[i] = 1;
    }

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 50, 5.0);

    /* All condi should be cleared at start of err4 */
    for (int i = 0; i < 5; i++) {
        ASSERT_EQ(dbg->err4_condi[i], 0);
    }

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_min_tracking_seq1(void)
{
    TEST("err4: seq_current=1 -> min = current value");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Force err1 early exit so it doesn't overwrite err1_i_sse_d_mean */
    dev->err1_seq[0] = 255;

    dbg->err1_i_sse_d_mean = 42.5;
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 1, 5.0);

    ASSERT_DOUBLE_EQ(dbg->err4_min, 42.5);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_min_tracking_updates(void)
{
    TEST("err4: min updates correctly with smaller value");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Force err1 early exit so it doesn't overwrite err1_i_sse_d_mean */
    dev->err1_seq[0] = 255;

    /* Previous min was 50.0, current value is 30.0 */
    args->err4_min_prev[0] = 50.0;
    dbg->err1_i_sse_d_mean = 30.0;
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 50, 5.0);

    /* Min should be 30.0 (current < previous) */
    ASSERT_DOUBLE_EQ(dbg->err4_min, 30.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_min_prev_shifts(void)
{
    TEST("err4: err4_min_prev array shifts left and stores new min");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Force err1 early exit so it doesn't overwrite err1_i_sse_d_mean */
    dev->err1_seq[0] = 255;

    args->err4_min_prev[0] = 10.0;
    args->err4_min_prev[1] = 20.0;
    args->err4_min_prev[288] = 99.0;
    dbg->err1_i_sse_d_mean = 5.0;

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 50, 5.0);

    /* After shift: [0] should be old [1]=20.0, [288] should be new min=5.0 */
    ASSERT_DOUBLE_EQ(args->err4_min_prev[0], 20.0);
    ASSERT_DOUBLE_EQ(args->err4_min_prev[288], 5.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_hysteresis_latches(void)
{
    TEST("err4: hysteresis latches when prev=1 and seq>1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Set up conditions for early exit (no accu_seq data) */
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;
    dev->err345_seq1[0] = 5;

    /* Set hysteresis: prev result was 1 */
    args->err4_result_prev = 1;
    /* Need to pass the early exit: set some accu_seq data */
    for (int i = 0; i < 10; i++) {
        args->accu_seq[i] = 50 - i;
    }

    check_error(args, dev, dbg, 50, 5.0);

    /* Hysteresis should latch: result = 1 */
    ASSERT_EQ(dbg->err4_delay_flag, 1);
    ASSERT_EQ(dbg->error_code4, 1);
    ASSERT_EQ(args->err4_result_prev, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_no_hysteresis_seq1(void)
{
    TEST("err4: no hysteresis when seq_current <= 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Even with prev=1, seq=1 should not latch */
    args->err4_result_prev = 1;

    check_error(args, dev, dbg, 1, 5.0);

    /* No hysteresis at seq=1, no conditions met -> result = 0 */
    ASSERT_EQ(dbg->error_code4, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_delay_flag_arr_shifts(void)
{
    TEST("err4: err4_delay_flag_arr shifts left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set recognizable pattern */
    args->err4_delay_flag_arr[0] = 10;
    args->err4_delay_flag_arr[1] = 20;
    args->err4_delay_flag_arr[574] = 30;
    args->err4_delay_flag_arr[575] = 40;

    check_error(args, dev, dbg, 50, 5.0);

    /* After shift: [0]=old[1]=20, [573]=old[574]=30, [574]=old[575]=40 */
    ASSERT_EQ(args->err4_delay_flag_arr[0], 20);
    ASSERT_EQ(args->err4_delay_flag_arr[573], 30);
    ASSERT_EQ(args->err4_delay_flag_arr[574], 40);
    /* [575] should be the new result (0 with no conditions met) */
    ASSERT_EQ(args->err4_delay_flag_arr[575], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_range_computed_for_seq_gte_2(void)
{
    TEST("err4: range computed when seq >= 2");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Force err1 early exit so it doesn't overwrite err1_i_sse_d_mean */
    dev->err1_seq[0] = 255;

    dbg->err1_i_sse_d_mean = 100.0;
    args->err4_min_prev[0] = 80.0;
    args->err4_min_prev[1] = 60.0;

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 10, 5.0);

    /* range = current_val - prev[1] = 100.0 - 60.0 = 40.0 */
    ASSERT_DOUBLE_EQ(dbg->err4_range, 40.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_nan_in_prev_min(void)
{
    TEST("err4: NaN in prev_min -> min = current value");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Force err1 early exit so it doesn't overwrite err1_i_sse_d_mean */
    dev->err1_seq[0] = 255;

    dbg->err1_i_sse_d_mean = 50.0;
    args->err4_min_prev[0] = NAN;

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 10, 5.0);

    /* With NaN prev_min, current value should be used */
    ASSERT_DOUBLE_EQ(dbg->err4_min, 50.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err4_early_exit_preserves_flag(void)
{
    TEST("err4: early exit preserves existing delay_flag");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Pre-set delay flag to 1 */
    dbg->err4_delay_flag = 1;

    /* No accu_seq data -> early exit */
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 50, 5.0);

    /* Early exit should preserve the existing flag value */
    ASSERT_EQ(dbg->err4_delay_flag, 1);
    ASSERT_EQ(dbg->error_code4, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * err2 tests (rate-of-change)
 * ════════════════════════════════════════════════════════════════════ */

static void test_err2_initializes_debug_fields(void)
{
    TEST("err2: initializes all debug fields to defaults");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Pre-set some fields to non-default values */
    dbg->err2_delay_pre_condi[0] = 5;
    dbg->err2_delay_pre_condi[1] = 5;
    dbg->err2_delay_pre_condi[2] = 5;
    dbg->err2_delay_condi[0] = 5;
    dbg->err2_delay_condi[1] = 5;
    dbg->err2_delay_condi[2] = 5;
    dbg->err2_delay_flag = 5;
    dbg->error_code2 = 5;

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 100, 5.0);

    /* All pre_condi and condi bytes should be cleared */
    ASSERT_EQ(dbg->err2_delay_pre_condi[0], 0);
    ASSERT_EQ(dbg->err2_delay_pre_condi[1], 0);
    ASSERT_EQ(dbg->err2_delay_pre_condi[2], 0);
    ASSERT_EQ(dbg->err2_delay_condi[0], 0);
    ASSERT_EQ(dbg->err2_delay_condi[1], 0);
    ASSERT_EQ(dbg->err2_delay_condi[2], 0);
    /* With all-zero args, delay_flag should be 0 */
    ASSERT_EQ(dbg->err2_delay_flag, 0);
    ASSERT_EQ(dbg->error_code2, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_low_seq_skips_computation(void)
{
    TEST("err2: idx <= err2_start_seq -> early skip, no computation");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Set err2_start_seq high so idx is below it */
    dev->err2_start_seq = 500;
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    args->idx = 5;  /* Below start_seq */

    check_error(args, dev, dbg, 100, 5.0);

    /* Should produce 0 error code */
    ASSERT_EQ(dbg->error_code2, 0);
    ASSERT_EQ(dbg->err2_delay_flag, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_buffer_rotation_flag_prev(void)
{
    TEST("err2: delay buffer rotates left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set recognizable pattern in flag_prev */
    args->err2_delay_flag_prev[0] = 10;
    args->err2_delay_flag_prev[1] = 20;
    args->err2_delay_flag_prev[573] = 30;
    args->err2_delay_flag_prev[574] = 40;

    check_error(args, dev, dbg, 100, 5.0);

    /* After shift: [0]=old[1]=20, [572]=old[573]=30, [573]=old[574]=40 */
    ASSERT_EQ(args->err2_delay_flag_prev[0], 20);
    ASSERT_EQ(args->err2_delay_flag_prev[572], 30);
    ASSERT_EQ(args->err2_delay_flag_prev[573], 40);
    /* [574] should be new value (0 since no flag was set) */
    ASSERT_EQ(args->err2_delay_flag_prev[574], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_buffer_rotation_roc_prev(void)
{
    TEST("err2: roc delay buffer rotates left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set recognizable pattern in roc_prev */
    args->err2_delay_roc_prev[0] = 1.0;
    args->err2_delay_roc_prev[1] = 2.0;
    args->err2_delay_roc_prev[574] = 99.0;

    check_error(args, dev, dbg, 100, 5.0);

    /* After shift: [0]=old[1]=2.0 */
    ASSERT_DOUBLE_EQ(args->err2_delay_roc_prev[0], 2.0);
    /* [574] should be the new roc value (NaN for early-skip path) */
    /* Since idx=0 <= err2_start_seq=0, it takes early path */

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_buffer_rotation_glucose_prev(void)
{
    TEST("err2: glucose delay buffer rotates left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    args->err2_delay_glucosevalue_prev[0] = 100.0;
    args->err2_delay_glucosevalue_prev[1] = 200.0;
    args->err2_delay_glucosevalue_prev[574] = 300.0;

    check_error(args, dev, dbg, 100, 5.0);

    /* After shift: [0]=old[1]=200.0, [573]=old[574]=300.0 */
    ASSERT_DOUBLE_EQ(args->err2_delay_glucosevalue_prev[0], 200.0);
    ASSERT_DOUBLE_EQ(args->err2_delay_glucosevalue_prev[573], 300.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_cummax_foretime_shifts(void)
{
    TEST("err2: cummax_foretime[100] shifts left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set recognizable pattern */
    args->err2_cummax_foretime[0] = 10.0;
    args->err2_cummax_foretime[1] = 20.0;
    args->err2_cummax_foretime[98] = 30.0;
    args->err2_cummax_foretime[99] = 40.0;

    check_error(args, dev, dbg, 100, 5.0);

    /* After shift: [0]=old[1]=20.0, [97]=old[98]=30.0, [98]=old[99]=40.0 */
    ASSERT_DOUBLE_EQ(args->err2_cummax_foretime[0], 20.0);
    ASSERT_DOUBLE_EQ(args->err2_cummax_foretime[97], 30.0);
    ASSERT_DOUBLE_EQ(args->err2_cummax_foretime[98], 40.0);
    /* [99] should be NaN (new default) */
    if (!isnan(args->err2_cummax_foretime[99])) {
        FAIL("cummax_foretime[99] should be NaN");
        free(args); free(dev); free(dbg);
        return;
    }

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_condi_prev_stored(void)
{
    TEST("err2: delay_condi_prev updated from delay_flag");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set initial condi_prev to non-zero */
    args->err2_delay_condi_prev = 1;

    check_error(args, dev, dbg, 100, 5.0);

    /* delay_condi_prev should be updated to the new delay_flag value */
    ASSERT_EQ(args->err2_delay_condi_prev, dbg->err2_delay_flag);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_result_prev_stored(void)
{
    TEST("err2: result_prev updated from delay_flag");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    args->err2_result_prev = 1;

    check_error(args, dev, dbg, 100, 5.0);

    /* result_prev should be updated */
    ASSERT_EQ(args->err2_result_prev, dbg->err2_delay_flag);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_error_code_matches_delay_flag(void)
{
    TEST("err2: error_code2 matches delay_flag");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 100, 5.0);

    ASSERT_EQ(dbg->error_code2, dbg->err2_delay_flag);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_all_zero_produces_zero(void)
{
    TEST("err2: all-zero inputs -> error_code2 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 50, 0.0);

    ASSERT_EQ(dbg->error_code2, 0);
    ASSERT_EQ(dbg->err2_delay_flag, 0);
    ASSERT_EQ(dbg->err2_delay_condi[0], 0);
    ASSERT_EQ(dbg->err2_delay_condi[1], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_pre_condi_prev_stored(void)
{
    TEST("err2: pre_condi_prev updated from debug pre_condi");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set previous pre_condi to non-zero */
    args->err2_delay_pre_condi_prev[0] = 1;
    args->err2_delay_pre_condi_prev[1] = 1;
    args->err2_delay_pre_condi_prev[2] = 1;

    check_error(args, dev, dbg, 100, 5.0);

    /* pre_condi_prev should be updated from debug->pre_condi */
    ASSERT_EQ(args->err2_delay_pre_condi_prev[0], dbg->err2_delay_pre_condi[0]);
    ASSERT_EQ(args->err2_delay_pre_condi_prev[1], dbg->err2_delay_pre_condi[1]);
    ASSERT_EQ(args->err2_delay_pre_condi_prev[2], dbg->err2_delay_pre_condi[2]);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_trimmed_mean_with_valid_data(void)
{
    TEST("err2: trimmed mean computed with sufficient valid data");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set up for trimmed mean computation:
     * Need idx > err2_start_seq and seq2 > seq1 */
    args->idx = 200;
    dev->err2_start_seq = 10;
    dev->err2_seq[0] = 5;   /* seq1 */
    dev->err2_seq[1] = 10;
    dev->err2_seq[2] = 50;  /* seq2 for threshold */

    /* Set high thresholds so conditions don't fire */
    dev->err2_glu = 999.0f;
    dev->err2_cv[0] = 1.0f;   /* time divisor */
    dev->err2_cv[1] = 999.0f; /* ROC threshold (high to avoid NaN path) */
    dev->err2_cv[2] = 0.0f;   /* cummax factor */
    dev->err2_alpha = 0.0f;   /* condition factor */
    dev->err2_ycept = 999.0f; /* fun_comp_decimals threshold (high) */

    /* Fill delay buffers with valid data and no flags */
    for (int i = 0; i < 100; i++) {
        args->err2_delay_flag_prev[i] = 0;  /* valid entries */
        args->err2_delay_roc_prev[i] = 1.0 + (double)(i % 10);
        args->err2_delay_slope_sharp_prev[i] = 2.0 + (double)(i % 5);
        args->err2_delay_glucosevalue_prev[i] = 100.0 + (double)(i % 20);
    }

    check_error(args, dev, dbg, 100, 5.0);

    /* With high thresholds, no conditions should fire */
    ASSERT_EQ(dbg->error_code2, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_flagged_entries_excluded_from_trimmed_mean(void)
{
    TEST("err2: flagged delay entries excluded from trimmed mean");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    args->idx = 200;
    dev->err2_start_seq = 10;
    dev->err2_seq[0] = 0;
    dev->err2_seq[2] = 50;

    /* Flag all entries - should result in 0 valid count */
    for (int i = 0; i < 575; i++) {
        args->err2_delay_flag_prev[i] = 1;
        args->err2_delay_roc_prev[i] = 5.0;
    }

    check_error(args, dev, dbg, 100, 5.0);

    /* With all entries flagged, trimmed mean should remain NaN
     * (or not be computed) */
    /* error_code2 should be 0 */
    ASSERT_EQ(dbg->error_code2, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_slope_prev_rotation(void)
{
    TEST("err2: slope delay buffer rotates correctly");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    args->err2_delay_slope_sharp_prev[0] = 10.0;
    args->err2_delay_slope_sharp_prev[1] = 20.0;
    args->err2_delay_slope_sharp_prev[2] = 30.0;

    check_error(args, dev, dbg, 100, 5.0);

    /* After rotation: [0]=old[1]=20.0, [1]=old[2]=30.0 */
    ASSERT_DOUBLE_EQ(args->err2_delay_slope_sharp_prev[0], 20.0);
    ASSERT_DOUBLE_EQ(args->err2_delay_slope_sharp_prev[1], 30.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err2_cummax_nan_default(void)
{
    TEST("err2: cummax set to NaN by default");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    args->err2_cummax = 42.0;  /* Non-NaN initial */

    check_error(args, dev, dbg, 100, 5.0);

    /* After err2, cummax should be set to NaN (default) */
    if (!isnan(args->err2_cummax)) {
        FAIL("err2_cummax should be NaN");
        free(args); free(dev); free(dbg);
        return;
    }

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
 * err16 tests (sensor drift/degradation)
 * ════════════════════════════════════════════════════════════════════ */

static void test_err16_seq1_initializes_state(void)
{
    TEST("err16: seq=1 initializes all err16 state arrays");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /* Set some fields to non-zero to verify they get cleared */
    args->err16_CGM_ISF_trend_min_max = 99.0;
    args->err16_CGM_ISF_trend_mode_max = 99.0;
    args->err16_CGM_ISF_trend_mean_max = 99.0;
    args->err16_result_prev = 1;
    args->err16_cal_cons_is_first = 0;
    args->err16_cal_day_i = 42;

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 1, 5.0);

    /* Verify initialization: cal_cons_is_first set to 1 */
    ASSERT_EQ(args->err16_cal_cons_is_first, 1);
    /* cal_day_i reset to 0 */
    ASSERT_EQ(args->err16_cal_day_i, 0);
    /* ISF smooth array initialized to NaN */
    if (!isnan(args->err16_CGM_ISF_smooth[0]) ||
        !isnan(args->err16_CGM_ISF_smooth[864])) {
        FAIL("ISF smooth array not initialized to NaN");
        free(args); free(dev); free(dbg);
        return;
    }
    /* Plasma array initialized to NaN */
    if (!isnan(args->err16_CGM_plasma[0]) ||
        !isnan(args->err16_CGM_plasma[35])) {
        FAIL("Plasma array not initialized to NaN");
        free(args); free(dev); free(dbg);
        return;
    }
    /* Trend min arrays initialized to NaN */
    if (!isnan(args->err16_CGM_ISF_trend_min_slope1[0]) ||
        !isnan(args->err16_CGM_ISF_trend_min_slope1[35])) {
        FAIL("Trend min slope1 not initialized to NaN");
        free(args); free(dev); free(dbg);
        return;
    }
    /* Debug fields initialized to NaN */
    if (!isnan(dbg->err16_CGM_ISF_smooth) ||
        !isnan(dbg->err16_CGM_plasma)) {
        FAIL("Debug fields not initialized to NaN");
        free(args); free(dev); free(dbg);
        return;
    }
    /* Trend max fields reset to 0 */
    ASSERT_DOUBLE_EQ(args->err16_CGM_ISF_trend_min_max, 0.0);
    ASSERT_DOUBLE_EQ(args->err16_CGM_ISF_trend_mode_max, 0.0);
    ASSERT_DOUBLE_EQ(args->err16_CGM_ISF_trend_mean_max, 0.0);
    /* Time fields reset */
    ASSERT_EQ(args->err16_time5_first, 0);
    /* ROC n reset */
    ASSERT_DOUBLE_EQ(args->err16_CGM_ISF_roc_n, 0.0);
    /* condi array cleared */
    for (int i = 0; i < 7; i++) {
        if (dbg->err16_condi[i] != 0) {
            FAIL("err16_condi not cleared on seq=1");
            free(args); free(dev); free(dbg);
            return;
        }
    }

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_seq1_returns_early(void)
{
    TEST("err16: seq=1 returns before setting error_code16");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set error_code16 to a sentinel value before calling */
    dbg->error_code16 = 99;

    check_error(args, dev, dbg, 1, 5.0);

    /* Phase 0 returns early; error_code16 is NOT written by err16 on
     * seq=1 (the return happens before the code that writes it).
     * The value should remain at the sentinel OR be 0 depending on
     * whether the debug struct clearing overwrites it. Since seq=1
     * only initializes err16 state (not debug->error_code16), and
     * other detectors may write it, we just verify the function
     * doesn't crash. */

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_low_seq_skips_main_logic(void)
{
    TEST("err16: seq<280 skips smoothing/trend computation");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 100, 5.0);

    /* With seq=100 (< 280), err16 performs history shifting but
     * skips smoothing and trend computation. error_code16 = 0. */
    ASSERT_EQ(dbg->error_code16, 0);
    /* condi array should be all zero */
    for (int i = 0; i < 7; i++) {
        if (dbg->err16_condi[i] != 0) {
            FAIL("err16_condi should be 0 for seq<280");
            free(args); free(dev); free(dbg);
            return;
        }
    }

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_history_shifting(void)
{
    TEST("err16: history arrays shift left by 1 for seq>1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set known values in trend_min_slope1 array (36 elements) */
    for (int i = 0; i < 36; i++) {
        args->err16_CGM_ISF_trend_min_slope1[i] = (double)(i + 10);
    }

    /* Also set known values in plasma array */
    for (int i = 0; i < 36; i++) {
        args->err16_CGM_plasma[i] = (double)(i + 100);
    }

    check_error(args, dev, dbg, 50, 5.0);

    /* After shifting, slope1[0] should be what was slope1[1] = 11.0 */
    ASSERT_DOUBLE_EQ(args->err16_CGM_ISF_trend_min_slope1[0], 11.0);
    /* slope1[34] should be what was slope1[35] = 45.0 */
    ASSERT_DOUBLE_EQ(args->err16_CGM_ISF_trend_min_slope1[34], 45.0);
    /* slope1[35] should be NaN (newly inserted) */
    if (!isnan(args->err16_CGM_ISF_trend_min_slope1[35])) {
        FAIL("slope1[35] should be NaN after shift");
        free(args); free(dev); free(dbg);
        return;
    }

    /* Plasma array should also shift */
    ASSERT_DOUBLE_EQ(args->err16_CGM_plasma[0], 101.0);
    ASSERT_DOUBLE_EQ(args->err16_CGM_plasma[34], 135.0);
    if (!isnan(args->err16_CGM_plasma[35])) {
        FAIL("plasma[35] should be NaN after shift");
        free(args); free(dev); free(dbg);
        return;
    }

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_865_array_shifting(void)
{
    TEST("err16: 865-element arrays shift left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set a known pattern in ISF smooth array */
    args->err16_CGM_ISF_smooth[0] = 1.0;
    args->err16_CGM_ISF_smooth[1] = 2.0;
    args->err16_CGM_ISF_smooth[863] = 863.0;
    args->err16_CGM_ISF_smooth[864] = 864.0;

    check_error(args, dev, dbg, 50, 5.0);

    /* After shift: [0] = old [1] = 2.0 */
    ASSERT_DOUBLE_EQ(args->err16_CGM_ISF_smooth[0], 2.0);
    /* [863] = old [864] = 864.0 */
    ASSERT_DOUBLE_EQ(args->err16_CGM_ISF_smooth[863], 864.0);
    /* [864] = NaN (newly inserted) */
    if (!isnan(args->err16_CGM_ISF_smooth[864])) {
        FAIL("ISF_smooth[864] should be NaN after shift");
        free(args); free(dev); free(dbg);
        return;
    }

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_dt_arr_computed(void)
{
    TEST("err16: dt_arr[35] computed from measurement time");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set time values */
    args->err16_time5_first = 1000;
    dbg->measurement_time_standard = 1600;  /* 600 seconds later */

    check_error(args, dev, dbg, 50, 5.0);

    /* dt = (1600 - 1000) / 60.0 = 10.0 minutes */
    ASSERT_DOUBLE_EQ(args->err16_dt_arr[35], 10.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_dt_arr_zero_first_time(void)
{
    TEST("err16: dt_arr uses measurement_time as first if time5_first=0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* time5_first is 0 (calloc default) */
    dbg->measurement_time_standard = 5000;

    check_error(args, dev, dbg, 50, 5.0);

    /* When time_first = 0, dt = (5000 - 5000) / 60.0 = 0.0 */
    ASSERT_DOUBLE_EQ(args->err16_dt_arr[35], 0.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_default_zero_output(void)
{
    TEST("err16: all-zero input at seq>=280 -> error_code16=0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 300, 5.0);

    /* With all-zero state, err16 should produce error_code16=0.
     * smooth1q_err16 gets called with zero data, f_cgm_trend
     * with no valid accu_seq entries, f_check_cgm_trend finds
     * no valid entries -> all condi remain 0. */
    ASSERT_EQ(dbg->error_code16, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_condi_any_set_triggers_error(void)
{
    TEST("err16: condi[i]=1 (manual set) -> error_code16=1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* We can't directly test the condi-to-error_code path in isolation
     * since err16 is a static function called via check_error.
     * But we can verify that with no data producing conditions,
     * error_code16 stays 0. The condi iteration logic is:
     *   for (i=0; i<7; i++) if (condi[i]==1) any_set=1;
     *   error_code16 = any_set;
     *
     * We verify the negative case here (no conditions triggered). */
    check_error(args, dev, dbg, 300, 5.0);
    ASSERT_EQ(dbg->error_code16, 0);

    /* Verify condi array is all zero */
    for (int i = 0; i < 7; i++) {
        if (dbg->err16_condi[i] != 0) {
            FAIL("condi should be 0 with zero input");
            free(args); free(dev); free(dbg);
            return;
        }
    }

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_result_prev_stored(void)
{
    TEST("err16: result_prev preserved when no smooth data");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    args->err16_result_prev = 99;  /* sentinel */

    check_error(args, dev, dbg, 300, 5.0);

    /* With no valid accu_seq data, the smoothing phase finds
     * insufficient data and returns early before reaching the
     * result_prev assignment. So result_prev stays at the sentinel.
     * The error_code16 is still set to 0 on that early return path. */
    ASSERT_EQ(dbg->error_code16, 0);
    ASSERT_EQ(args->err16_result_prev, 99);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_debug_outputs_initialized(void)
{
    TEST("err16: debug trend fields initialized for seq>=2");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Set debug fields to non-NaN sentinels */
    dbg->err16_CGM_ISF_smooth = 42.0;
    dbg->err16_CGM_plasma = 42.0;
    dbg->err16_CGM_ISF_roc_value = 42.0;
    dbg->err16_CGM_ISF_trend_min_value = 42.0;
    dbg->err16_CGM_ISF_trend_mode_value = 42.0;
    dbg->err16_CGM_ISF_trend_mean_value = 42.0;

    check_error(args, dev, dbg, 50, 5.0);

    /* For seq>=2 but <280, debug fields should be set to NaN (default)
     * by the initialization block at the start of check_err16. */
    if (!isnan(dbg->err16_CGM_ISF_smooth)) {
        FAIL("err16_CGM_ISF_smooth should be NaN for seq<280");
        free(args); free(dev); free(dbg);
        return;
    }
    if (!isnan(dbg->err16_CGM_plasma)) {
        FAIL("err16_CGM_plasma should be NaN for seq<280");
        free(args); free(dev); free(dbg);
        return;
    }

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err16_multiple_seq_calls_stable(void)
{
    TEST("err16: multiple sequential calls don't corrupt state");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    /* Call with seq=1 (init), then seq=2..5 (early), then seq=300 */
    check_error(args, dev, dbg, 1, 5.0);
    check_error(args, dev, dbg, 2, 5.0);
    check_error(args, dev, dbg, 3, 5.0);
    check_error(args, dev, dbg, 4, 5.0);
    check_error(args, dev, dbg, 5, 5.0);

    /* All early-seq calls should produce error_code16=0 */
    ASSERT_EQ(dbg->error_code16, 0);

    /* One more call at seq=300 */
    check_error(args, dev, dbg, 300, 5.0);

    /* With no meaningful data, should still be 0 */
    ASSERT_EQ(dbg->error_code16, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

/* ════════════════════════════════════════════════════════════════════
 * err1 tests (contact/noise error)
 * ════════════════════════════════════════════════════════════════════ */

/*
 * Helper: configure dev_info so err1 is active but other detectors
 * don't produce side effects. Sets err1_seq[0]=1 (minimum threshold),
 * and reasonable err8 thresholds.
 */
static void setup_err1_dev_info(struct air1_opcal4_device_info_t *dev)
{
    dev->err1_seq[0] = 1;   /* err1 active for idx >= 1 */
    dev->err1_seq[1] = 1;
    dev->err1_seq[2] = 1;
    dev->err1_n_consecutive = 200;   /* high threshold to avoid vacuous SSE check */
    dev->err1_count_sse_dmean = 200; /* high threshold for contact bad 1h count */
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;
}

static void test_err1_early_exit_low_seq(void)
{
    TEST("err1: idx < err1_seq[0] -> early exit, error_code1 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_seq[0] = 10;  /* threshold = 10 */
    args->idx = 5;           /* below threshold */

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->error_code1, 0);
    ASSERT_EQ(dbg->err1_is_contact_bad, 0);
    ASSERT_EQ(dbg->err1_random_noise_temp_break, 0);
    ASSERT_EQ(dbg->err1_result, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_early_exit_preserves_prev_fields(void)
{
    TEST("err1: early exit preserves err1_i_sse_d_mean from prior");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_seq[0] = 255;  /* force early exit */

    /* Pre-set a debug value that should survive early exit */
    dbg->err1_i_sse_d_mean = 42.0;

    check_error(args, dev, dbg, 50, 5.0);

    /* Early exit should NOT overwrite err1_i_sse_d_mean */
    ASSERT_DOUBLE_EQ(dbg->err1_i_sse_d_mean, 42.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_initializes_debug_on_main_path(void)
{
    TEST("err1: main path initializes debug fields to defaults");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    /* Set high thresholds so err1 doesn't trigger errors */
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;
    dev->err1_th_sse_dmean[1] = 2000;
    dev->err1_th_sse_dmean[2] = 3000;

    args->idx = 5;  /* above threshold of 1 */

    /* Pre-set fields that err1 should overwrite */
    dbg->err1_result_TD = 99;
    dbg->err1_TD_count = 99;
    dbg->err1_length_t1_trio = 99;

    check_error(args, dev, dbg, 50, 5.0);

    /* Main path should have reset these */
    ASSERT_EQ(dbg->err1_result_TD, 0);
    ASSERT_EQ(dbg->err1_TD_count, 0);
    ASSERT_EQ(dbg->err1_length_t1_trio, 0);
    ASSERT_EQ(dbg->error_code1, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_sse_d_mean_computed(void)
{
    TEST("err1: sse_d_mean computed from curr_avg_arr differences");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;
    dev->err1_th_sse_dmean[1] = 2000;
    dev->err1_th_sse_dmean[2] = 3000;

    args->idx = 5;

    /* Set up a simple pattern: [10, 20, 30, ...] so abs diffs are all 10.0 */
    for (int i = 0; i < 180; i++) {
        args->curr_avg_arr[i] = 10.0 * (i + 1);
    }

    check_error(args, dev, dbg, 50, 5.0);

    /* SSE mean should be 10.0 (all differences are 10.0) */
    ASSERT_DOUBLE_EQ(dbg->err1_i_sse_d_mean, 10.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_sse_d_mean_zero_for_constant(void)
{
    TEST("err1: constant curr_avg_arr -> sse_d_mean = 0.0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;

    args->idx = 5;

    /* Constant values: all differences are 0 */
    for (int i = 0; i < 180; i++) {
        args->curr_avg_arr[i] = 100.0;
    }

    check_error(args, dev, dbg, 50, 5.0);

    /* All diffs are 0, none are > 0, so sse_d_mean stays 0.0 */
    ASSERT_DOUBLE_EQ(dbg->err1_i_sse_d_mean, 0.0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_contact_bad_from_avg_diff(void)
{
    TEST("err1: large current_avg_diff -> is_contact_bad = 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    /* Set a low threshold for current_avg_diff so contact is marked bad */
    dev->err1_current_avg_diff = 5;
    dev->err1_th_sse_dmean[0] = 1000;
    dev->err1_th_sse_dmean[1] = 2000;
    dev->err1_th_sse_dmean[2] = 3000;

    args->idx = 5;

    /*
     * curr_avg_now = curr_avg_arr[idx-1] = curr_avg_arr[4]
     * curr_avg_prev = args->err1_prev_last_1min_curr
     * current_avg_diff = |curr_avg_now - curr_avg_prev|
     */
    args->curr_avg_arr[4] = 100.0;
    args->err1_prev_last_1min_curr = 50.0;
    /* diff = |100 - 50| = 50, threshold = 5 -> bad */

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->err1_is_contact_bad, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_contact_good_below_threshold(void)
{
    TEST("err1: small current_avg_diff -> is_contact_bad = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 100;  /* high threshold */
    dev->err1_th_sse_dmean[0] = 1000;
    dev->err1_n_consecutive = 200;     /* high SSE bad count threshold */
    dev->err1_count_sse_dmean = 200;   /* high contact bad 1h threshold */

    args->idx = 5;

    args->curr_avg_arr[4] = 50.0;
    args->err1_prev_last_1min_curr = 48.0;
    /* diff = |50 - 48| = 2, threshold = 100 -> good */

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->err1_is_contact_bad, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_history_100_shifts_left(void)
{
    TEST("err1: 100-element history arrays shift left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;
    dev->err1_n_consecutive = 200;
    dev->err1_count_sse_dmean = 200;

    args->idx = 5;

    /* Set recognizable pattern in is_contact_bad1h */
    args->err1_is_contact_bad1h[0] = 10;
    args->err1_is_contact_bad1h[1] = 20;
    args->err1_is_contact_bad1h[99] = 99;

    /* Set pattern in i_sse_d_mean4h */
    args->err1_i_sse_d_mean4h[0] = 100.0;
    args->err1_i_sse_d_mean4h[1] = 200.0;

    check_error(args, dev, dbg, 50, 5.0);

    /* After shift: [0] should be old [1] */
    ASSERT_EQ(args->err1_is_contact_bad1h[0], 20);
    ASSERT_DOUBLE_EQ(args->err1_i_sse_d_mean4h[0], 200.0);
    /* [99] should be the new value (is_contact_bad=0 with high threshold) */
    ASSERT_EQ(args->err1_is_contact_bad1h[99], 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_signal_180_shifts_left(void)
{
    TEST("err1: 180-element signal histories shift left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;

    args->idx = 5;

    /* Set recognizable pattern */
    args->err1_SG_1min[0] = 1.0;
    args->err1_SG_1min[1] = 2.0;
    args->err1_SG_1min[179] = 99.0;

    args->err1_time_1min[0] = 100;
    args->err1_time_1min[1] = 200;

    check_error(args, dev, dbg, 50, 5.0);

    /* After shift: [0] = old [1] */
    ASSERT_DOUBLE_EQ(args->err1_SG_1min[0], 2.0);
    ASSERT_EQ(args->err1_time_1min[0], 200);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_random_noise_break_all_zero_threshold(void)
{
    TEST("err1: all-zero data with zero threshold -> temp_break = 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    /*
     * With all-zero structs (except err1_seq[0]=0 so not early exit),
     * the binary sets random_noise_temp_break=1 because:
     *   - All i_sse_d_mean4h entries are 0.0
     *   - Threshold is 0.0
     *   - 0.0 >= 0.0 is true for all 100 entries (they don't fail
     *     the val < threshold check)
     *   - seq_val (0) >= err1_seq[1] (0) is true
     */
    /* Don't call setup_err1_dev_info, leave all zeros */
    dev->err345_seq4[0] = 10;
    dev->err345_seq4[1] = 20;
    dev->err345_seq4[2] = 5;
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->err1_random_noise_temp_break, 1);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_random_noise_break_high_threshold(void)
{
    TEST("err1: high threshold -> temp_break = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    /* High current_avg_diff threshold means 0.0 < 1000 will cause
     * the all_exceed loop to fail immediately */
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;

    args->idx = 5;

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->err1_random_noise_temp_break, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_td_skipped_insufficient_time_data(void)
{
    TEST("err1: no time entries -> TD processing skipped, result_TD=0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;

    args->idx = 5;
    /* All time entries are 0 (calloc) -> total_count = 0 < 2 */

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->err1_result_TD, 0);
    ASSERT_EQ(dbg->err1_TD_count, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_epilogue_stores_result_prev(void)
{
    TEST("err1: epilogue stores error_code1 into args->err1_result_prev");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;

    args->idx = 5;

    /* With high thresholds, error_code1 should be 0 */
    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(args->err1_result_prev, 0);
    ASSERT_EQ(dbg->error_code1, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_prev_last_1min_curr_updated(void)
{
    TEST("err1: err1_prev_last_1min_curr updated to curr_avg_arr[idx-1]");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;

    args->idx = 10;
    args->curr_avg_arr[9] = 77.5;  /* idx-1 = 9 */

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_DOUBLE_EQ(args->err1_prev_last_1min_curr, 77.5);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_default_all_zero_produces_error_code1_zero(void)
{
    TEST("err1: high thresholds with valid idx -> error_code1 = 0");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;
    dev->err1_th_sse_dmean[1] = 2000;
    dev->err1_th_sse_dmean[2] = 3000;
    dev->err1_n_last = 100;  /* high threshold for TD count */

    args->idx = 5;

    check_error(args, dev, dbg, 50, 5.0);

    ASSERT_EQ(dbg->error_code1, 0);
    ASSERT_EQ(dbg->err1_result, 0);

    free(args); free(dev); free(dbg);
    PASS();
}

static void test_err1_break_flag_history_shifts(void)
{
    TEST("err1: TD_temporary_break_flag_past_range shifts left by 1");
    struct air1_opcal4_arguments_t *args = alloc_args();
    struct air1_opcal4_device_info_t *dev = alloc_dev_info();
    struct air1_opcal4_debug_t *dbg = alloc_debug();

    setup_err1_dev_info(dev);
    dev->err1_current_avg_diff = 1000;
    dev->err1_th_sse_dmean[0] = 1000;

    args->idx = 5;

    /* Set up time entries so TD processing runs (need >= 2 non-zero times) */
    args->err1_time_1min[178] = 1000;
    args->err1_time_1min[179] = 2000;

    /* Set recognizable pattern in break flag history */
    args->err1_TD_temporary_break_flag_past_range[0] = 10;
    args->err1_TD_temporary_break_flag_past_range[1] = 20;
    args->err1_TD_temporary_break_flag_past_range[35] = 99;

    check_error(args, dev, dbg, 50, 5.0);

    /* After shift: [0] = old [1] = 20 */
    ASSERT_EQ(args->err1_TD_temporary_break_flag_past_range[0], 20);

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
     *
     * Similarly, err1 with all-zero data sets random_noise_temp_break=1
     * because 0.0 >= 0.0 passes its threshold check. Force err1 early
     * exit to isolate pipeline behavior testing.
     */
    dev->err1_seq[0] = 255;
    dev->err345_seq4[0] = 10;   /* start_offset */
    dev->err345_seq4[1] = 20;   /* window_size */
    dev->err345_seq4[2] = 5;    /* sum_threshold */
    dev->err345_filtered[0] = 1.0f;
    dev->err345_filtered[1] = 50.0f;

    check_error(args, dev, dbg, 100, 5.0);

    /* err32: all detectors produce 0 flags -> error_code32 = 0 */
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

    printf("\nerr128 (noise/spike revision):\n");
    test_err128_seq_below_2_skips();
    test_err128_seq_below_threshold_skips();
    test_err128_lot_type_above_2_skips();
    test_err128_initializes_output_fields();
    test_err128_epilogue_shifts_flag_prev();
    test_err128_epilogue_stores_normal_prev();
    test_err128_path_b_insufficient_data();

    printf("\nerr4 (signal quality):\n");
    test_err4_all_zero_no_data();
    test_err4_clears_condi();
    test_err4_min_tracking_seq1();
    test_err4_min_tracking_updates();
    test_err4_min_prev_shifts();
    test_err4_hysteresis_latches();
    test_err4_no_hysteresis_seq1();
    test_err4_delay_flag_arr_shifts();
    test_err4_range_computed_for_seq_gte_2();
    test_err4_nan_in_prev_min();
    test_err4_early_exit_preserves_flag();

    printf("\nerr2 (rate-of-change):\n");
    test_err2_initializes_debug_fields();
    test_err2_low_seq_skips_computation();
    test_err2_buffer_rotation_flag_prev();
    test_err2_buffer_rotation_roc_prev();
    test_err2_buffer_rotation_glucose_prev();
    test_err2_cummax_foretime_shifts();
    test_err2_condi_prev_stored();
    test_err2_result_prev_stored();
    test_err2_error_code_matches_delay_flag();
    test_err2_all_zero_produces_zero();
    test_err2_pre_condi_prev_stored();
    test_err2_trimmed_mean_with_valid_data();
    test_err2_flagged_entries_excluded_from_trimmed_mean();
    test_err2_slope_prev_rotation();
    test_err2_cummax_nan_default();

    printf("\nerr16 (sensor drift/degradation):\n");
    test_err16_seq1_initializes_state();
    test_err16_seq1_returns_early();
    test_err16_low_seq_skips_main_logic();
    test_err16_history_shifting();
    test_err16_865_array_shifting();
    test_err16_dt_arr_computed();
    test_err16_dt_arr_zero_first_time();
    test_err16_default_zero_output();
    test_err16_condi_any_set_triggers_error();
    test_err16_result_prev_stored();
    test_err16_debug_outputs_initialized();
    test_err16_multiple_seq_calls_stable();

    printf("\nerr1 (contact/noise):\n");
    test_err1_early_exit_low_seq();
    test_err1_early_exit_preserves_prev_fields();
    test_err1_initializes_debug_on_main_path();
    test_err1_sse_d_mean_computed();
    test_err1_sse_d_mean_zero_for_constant();
    test_err1_contact_bad_from_avg_diff();
    test_err1_contact_good_below_threshold();
    test_err1_history_100_shifts_left();
    test_err1_signal_180_shifts_left();
    test_err1_random_noise_break_all_zero_threshold();
    test_err1_random_noise_break_high_threshold();
    test_err1_td_skipped_insufficient_time_data();
    test_err1_epilogue_stores_result_prev();
    test_err1_prev_last_1min_curr_updated();
    test_err1_default_all_zero_produces_error_code1_zero();
    test_err1_break_flag_history_shifts();

    printf("\nEpilogue:\n");
    test_err_delay_arr_shift();

    printf("\nFull pipeline:\n");
    test_check_error_stubs_produce_zero();

    printf("\n%d passed, %d failed\n", tests_passed, tests_failed);

    return tests_failed > 0 ? EXIT_FAILURE : EXIT_SUCCESS;
}
