/*
 * OpenCareSens Air - Open-source calibration algorithm
 *
 * Error detection pipeline. The original ARM binary implements all
 * 7 detectors in one 8008-instruction function. We decompose each
 * detector into a separate static function for maintainability.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include "check_error.h"
#include "calibration.h"
#include "math_utils.h"

#include <math.h>
#include <string.h>
#include <stdint.h>

/* ────────────────────────────────────────────────────────────────────
 * err128: Noise/spike revision detector
 *
 * From check_error.asm prologue through ~line 800.
 * Detects and revises signal spikes/noise artifacts.
 * ──────────────────────────────────────────────────────────────────── */
static void check_err128(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    /* TODO: Implement err128 detector (noise/spike revision) */
    (void)args; (void)dev_info; (void)debug;
    (void)seq_current; (void)glucose_value;
}

/* ────────────────────────────────────────────────────────────────────
 * err16: Sensor drift/degradation detector
 *
 * From check_error.asm ~line 800 through ~line 3500.
 * Monitors ISF trend statistics for sensor degradation.
 * ──────────────────────────────────────────────────────────────────── */
static void check_err16(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    /* TODO: Implement err16 detector (sensor drift/degradation) */
    (void)args; (void)dev_info; (void)debug;
    (void)seq_current; (void)glucose_value;
}

/* ────────────────────────────────────────────────────────────────────
 * err1: Contact/noise detector (most complex)
 *
 * From check_error.asm ~line 3500 through ~line 5200.
 * Detects poor sensor contact and excessive noise.
 * ──────────────────────────────────────────────────────────────────── */
static void check_err1(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    /* TODO: Implement err1 detector (contact/noise) */
    (void)args; (void)dev_info; (void)debug;
    (void)seq_current; (void)glucose_value;
}

/* ────────────────────────────────────────────────────────────────────
 * err2: Rate-of-change detector
 *
 * From check_error.asm ~line 5200 through ~line 5700.
 * Detects unrealistic rates of glucose change.
 * ──────────────────────────────────────────────────────────────────── */
static void check_err2(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    /* TODO: Implement err2 detector (rate-of-change) */
    (void)args; (void)dev_info; (void)debug;
    (void)seq_current; (void)glucose_value;
}

/* ────────────────────────────────────────────────────────────────────
 * err4: Signal quality detector
 *
 * From check_error.asm ~line 5700 through ~line 6110.
 * Checks signal quality metrics (min, range, min_diff).
 * ──────────────────────────────────────────────────────────────────── */
static void check_err4(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    /* TODO: Implement err4 detector (signal quality) */
    (void)args; (void)dev_info; (void)debug;
    (void)seq_current; (void)glucose_value;
}

/* ────────────────────────────────────────────────────────────────────
 * err8: Boundary/sequence consistency check
 *
 * From check_error.asm lines 6110-6237 (128 instructions).
 *
 * Multi-stage detector that checks whether enough valid data points
 * exist in a sequence window and validates their values against a
 * dynamic threshold. Includes a latching mechanism (hysteresis).
 *
 * Stages:
 *   1. Count buffer entries in sequence range
 *   2. Compute dynamic threshold from dev_info parameters
 *   3. Validate data values against threshold
 *   4. Sum delay flags from err4 in the window
 *   5. Apply hysteresis (previous result latches)
 *
 * Binary register/offset mapping:
 *   r6+0x7ab  = debug->error_code8
 *   r6+0x88d  = debug->err8_condi[0]
 *   r6+0x88e  = debug->err8_condi[1]
 *   sp+0xf4+0x608 = dev_info->err345_seq1[0] (start_offset)
 *   sp+0xf4+0x60a = dev_info->err345_seq1[1] (window_size)
 *   sp+0xf4+0x60c = dev_info->err345_seq2     (sum_threshold)
 *   sp+0xf4+0x610 = dev_info->err345_seq3[0..2] area (threshold params)
 *   r6+0x0   = debug->seq_number_final (seq_current)
 *   r11+offset+0x6c2 = args->accu_seq entries
 *   args+0x2a68 = err_glu_arr based values
 * ──────────────────────────────────────────────────────────────────── */
static void check_err8(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    (void)glucose_value;

    /*
     * Binary ref: lines 6110-6120 (check_error.asm)
     * Initialize: clear err8_condi and error_code8
     */
    debug->err8_condi[0] = 0;
    debug->err8_condi[1] = 0;
    debug->error_code8 = 0;

    /*
     * Load threshold parameters from dev_info.
     *
     * Binary offset mapping (from sp+0xf4 = dev_info pointer):
     *   dev_info+0x608 = start_offset (uint16_t)
     *   dev_info+0x60a = window_size  (uint16_t)
     *   dev_info+0x60c = sum_threshold (uint16_t)
     *   dev_info+0x610 = threshold_factor (double in binary, but stored
     *                    near err345_seq3 area in our struct)
     *   dev_info+0x618 = threshold_min (double)
     *
     * These offsets in the binary's aligned struct correspond to fields
     * near err345_seq3/err345_seq4 in our packed device_info_t.
     * The exact mapping depends on ARM alignment vs our packed layout.
     *
     * Using err345_seq4[0..4] as the most likely candidate fields:
     *   err345_seq4[0] = start_offset
     *   err345_seq4[1] = window_size
     *   err345_seq4[2] = sum_threshold
     * And err345_filtered[0..1] for the threshold doubles.
     *
     * TODO: Verify exact field mapping with oracle test harness.
     */
    uint16_t start_offset  = dev_info->err345_seq4[0];
    uint16_t window_size   = dev_info->err345_seq4[1];
    uint16_t sum_threshold = dev_info->err345_seq4[2];

    /*
     * STAGE 1: Count buffer entries in sequence range
     *
     * Binary ref: lines 6121-6148
     * lower_bound = seq_current - start_offset
     * upper_bound = ~window_size + seq_current = seq_current - window_size - 1
     *
     * Iterate 865 accu_seq entries:
     *   count_in_range:  entries where lower_bound <= entry <= seq_current
     *   count_in_window: entries where upper_bound <= entry <= seq_current
     */
    int16_t lower_bound = (int16_t)seq_current - (int16_t)start_offset;
    int16_t upper_bound = (int16_t)seq_current - (int16_t)window_size - 1;

    uint16_t count_in_range = 0;
    uint16_t count_in_window = 0;

    for (int i = 0; i < 865; i++) {
        uint16_t entry = args->accu_seq[i];
        if (entry == 0)
            continue;

        /* count_in_range: lower_bound <= entry <= seq_current */
        if (entry <= seq_current && (int16_t)entry >= lower_bound) {
            count_in_range++;
        }

        /* count_in_window: upper_bound <= entry <= seq_current */
        if (entry <= seq_current && (int16_t)entry > upper_bound) {
            count_in_window++;
        }
    }

    /*
     * STAGE 2: Compute dynamic threshold
     *
     * Binary ref: lines 6149-6163
     *   vldr d17, [r0]          ; threshold_factor (double at dev_info+0x610)
     *   vldr d16, [r0, #8]      ; threshold_min (double at dev_info+0x618)
     *   ldr r0, [sp+0xec]       ; pointer to float value
     *   vmov s0, r0 / vcvt      ; convert float to double
     *   vmul d17, d17, d18      ; threshold = factor * float_val
     *   vcmp d17, d16           ; compare threshold vs min
     *   vmovmi d16, d17         ; if threshold < min, use threshold
     *
     * The float value at sp+0xec comes from a parameter computed earlier
     * in the main algorithm. For err8, this is related to a scaling factor.
     *
     * TODO: The exact source of this float value needs verification.
     * Using err345_filtered[0] as threshold_factor and err345_filtered[1]
     * as threshold_min. The float value from sp+0xec is approximated
     * using err345_raw[0] as the scaling factor.
     */
    double threshold_factor = (double)dev_info->err345_filtered[0];
    double threshold_min    = (double)dev_info->err345_filtered[1];
    double scale_float      = (double)dev_info->err345_raw[0];
    double threshold = threshold_factor * scale_float;
    if (threshold < threshold_min) {
        /* threshold stays as is (the min function takes the smaller) */
    } else {
        threshold = threshold_min;
    }

    /*
     * STAGE 3: Count check and data validation
     *
     * Binary ref: lines 6164-6196
     *
     * If count_in_range < start_offset - 1: not enough data, condition1 = 0
     * Else: check previous sequence continuity
     *   If seq_current > prev_seq and prev_seq != 0: condition1 = 0
     *   Else: validate double array entries against threshold
     *     For each of count_in_range entries: check if value <= threshold AND not NaN
     *     condition1 = 1 if ALL pass
     *
     * The double array at binary offset args+0x2a68:
     *   In the binary, r10 = args+0x2a58, and the validation reads from
     *   r10+0x10 = args+0x2a68. This corresponds to err_glu_arr in our
     *   struct (the glucose error array).
     *
     * The validation iterates backward from a position computed as:
     *   base = args_base - count_in_range*8 + 0x2a68
     * This accesses err_glu_arr[N - count_in_range .. N - 1] where N
     * is the current write position in the circular buffer.
     *
     * TODO: Verify that err_glu_arr is the correct array and that the
     * index computation matches the binary exactly.
     */
    uint8_t condition1 = 0;

    if (count_in_range >= start_offset - 1) {
        /* Check previous sequence continuity */
        uint16_t prev_seq = args->seq_prev;
        if (seq_current > prev_seq && prev_seq != 0) {
            /* Sequence gap detected, condition1 stays 0 */
            condition1 = 0;
        } else {
            /*
             * Validate err_glu_arr entries against threshold.
             * Check the last count_in_range entries.
             * All values must be <= threshold AND not NaN.
             *
             * Binary ref: lines 6179-6196
             *   The loop starts from count_in_range and decrements.
             *   vldr d17, [r0]      ; load value
             *   vcmp d17, d16       ; compare with threshold
             *   ble  pass           ; value <= threshold -> continue
             *   movs r5, #0         ; value > threshold -> fail
             *   vcmp d17, d17       ; NaN check
             *   bvs  fail           ; NaN -> fail
             *
             * The array access pattern: base = args_base - count*8 + 0x2a68
             * which reads from err_glu_arr at positions relative to the
             * current data count.
             */
            uint8_t all_pass = 1;
            uint16_t data_count = args->idx;
            for (uint16_t i = 0; i < count_in_range && all_pass; i++) {
                /*
                 * Index into err_glu_arr: read backward from position
                 * (data_count - count_in_range + i).
                 * Clamped to valid range [0, 287].
                 */
                int idx = (int)data_count - (int)count_in_range + (int)i;
                if (idx < 0 || idx >= 288) {
                    all_pass = 0;
                    break;
                }
                double val = args->err_glu_arr[idx];
                /* Check: value <= threshold AND not NaN */
                if (isnan(val) || val > threshold) {
                    all_pass = 0;
                }
            }
            condition1 = all_pass;
        }
    }

    /*
     * STAGE 4: Accumulated delay flag sum
     *
     * Binary ref: lines 6198-6222
     *
     * Sum the last count_in_window entries from err4_delay_flag_arr
     * (reading backward from the end of the populated region).
     *
     *   rsbs r3, r0, #0       ; r3 = -count_in_window
     *   ldrb r2, [r5, r3]     ; load from end of delay flag array
     *   add r0, r2            ; accumulate sum
     *
     * If seq_current <= window_size AND sum >= sum_threshold:
     *   condition2 = 1
     */
    uint8_t condition2 = 0;

    if (count_in_window > 0) {
        uint16_t delay_sum = 0;
        uint16_t arr_len = 576;
        for (uint16_t i = 0; i < count_in_window; i++) {
            int idx = (int)arr_len - (int)count_in_window + (int)i;
            if (idx >= 0 && idx < (int)arr_len) {
                delay_sum += args->err4_delay_flag_arr[idx];
            }
        }

        if (seq_current <= window_size && delay_sum >= sum_threshold) {
            condition2 = 1;
            debug->err8_condi[1] = 1;
        }
    }

    /*
     * STAGE 5: Hysteresis (latching)
     *
     * Binary ref: lines 6223-6237
     *
     * If data_count >= 2 AND args->err8_result_prev == 1:
     *   result = 1 (previous error latches)
     * Else:
     *   result = (condition1 | condition2) == 1 ? 1 : 0
     *
     * data_count is loaded from args at binary offset 0x648,
     * which corresponds to args->idx in our struct.
     */
    uint16_t data_count = args->idx;
    uint8_t result;

    if (data_count >= 2 && args->err8_result_prev == 1) {
        result = 1;
    } else {
        result = (condition1 | condition2) ? 1 : 0;
    }

    /*
     * Store results
     *
     * Binary ref: lines 6232-6237
     *   strb r0, [r6, #0x7ab]  ; debug->error_code8 = result
     *   strb r4, [r6, #0x88d]  ; debug->err8_condi[0] = condition1
     *                          ; (err8_condi[1] already set in stage 4)
     *   strb r0, [r1, #0x249]  ; args->err8_result_prev = result
     */
    debug->error_code8 = result;
    debug->err8_condi[0] = condition1;
    args->err8_result_prev = result;
}

/* ────────────────────────────────────────────────────────────────────
 * err32: BLE data gap flag check
 *
 * From check_error.asm lines 6238-6245, 6271-6274 (trivially simple).
 *
 * Checks 3 boolean flags set by other detectors. If any is set,
 * error_code32 = 1 (which controls output.data_type, not errcode).
 *
 * Binary flag sources:
 *   sp+0x13c = flag1 (from err4 section) -> debug->err4_delay_flag
 *   r6+0x800 = flag2 (from err1 section) -> debug->err1_is_contact_bad
 *   r6+0x7c8 = flag3 (intermediate)      -> debug->err1_random_noise_temp_break
 *
 * TODO: Verify exact field mapping for flag2 (r6+0x800) and flag3
 * (r6+0x7c8) once err1 and err4 are implemented and validated
 * against the oracle test harness.
 * ──────────────────────────────────────────────────────────────────── */
static void check_err32(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    (void)args; (void)dev_info;
    (void)seq_current; (void)glucose_value;

    /*
     * Binary ref: lines 6238-6245, 6271-6274
     *
     *   ldr  r0, [sp, #0x13c]       ; flag1
     *   cmp  r0, #1
     *   itt  ne
     *   ldrbne r0, [r6, #0x800]     ; flag2 (only if flag1 != 1)
     *   cmpne  r0, #1
     *   bne  check_flag3            ; if neither == 1, check flag3
     *   movs r0, #1
     *   strb r0, [r6, #0x7ad]       ; error_code32 = 1
     *   ...
     * check_flag3:
     *   ldrb r0, [r6, #0x7c8]       ; flag3
     *   cmp  r0, #1
     *   beq  set_err32              ; if flag3 == 1, error_code32 = 1
     *   b    skip                   ; else error_code32 stays 0
     *
     * Equivalent: error_code32 = (flag1 || flag2 || flag3) ? 1 : 0
     */
    uint8_t flag1 = debug->err4_delay_flag;
    uint8_t flag2 = debug->err1_is_contact_bad;
    uint8_t flag3 = debug->err1_random_noise_temp_break;

    debug->error_code32 = (flag1 == 1 || flag2 == 1 || flag3 == 1) ? 1 : 0;
}

/* ────────────────────────────────────────────────────────────────────
 * check_error: Main error detection pipeline
 *
 * Calls all 7 detectors in sequence, then performs the epilogue:
 *   1. Shift err_delay_arr left by 1 byte (6 bytes moved)
 *   2. Store error_code32 into the debug struct
 *
 * Binary ref: check_error.asm lines 6246-6254
 *   movw r0, #0x42ed              ; offset of err_delay_arr in args
 *   movs r1, #6                   ; 6 bytes to shift
 *   ... loop: ldrb/strb shift ... ; memmove by 1 position
 *   ldrb r0, [r6, #0x7ad]        ; load error_code32
 *   strb r0, [r12, #0xe]         ; store to output (data_type field)
 * ──────────────────────────────────────────────────────────────────── */
void check_error(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    /* Run all error detectors in binary execution order */
    check_err128(args, dev_info, debug, seq_current, glucose_value);
    check_err16(args, dev_info, debug, seq_current, glucose_value);
    check_err1(args, dev_info, debug, seq_current, glucose_value);
    check_err2(args, dev_info, debug, seq_current, glucose_value);
    check_err4(args, dev_info, debug, seq_current, glucose_value);
    check_err8(args, dev_info, debug, seq_current, glucose_value);
    check_err32(args, dev_info, debug, seq_current, glucose_value);

    /*
     * Epilogue: Shift err_delay_arr left by 1 byte.
     *
     * Binary ref: lines 6246-6253
     *   err_delay_arr[0..5] = err_delay_arr[1..6]
     *   (err_delay_arr[6] is left unchanged — it will be overwritten
     *    by the next call's detector before shifting occurs again)
     */
    memmove(args->err_delay_arr, args->err_delay_arr + 1, 6);
}
