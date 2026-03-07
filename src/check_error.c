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
 * From check_error.asm prologue through ~line 400 (lines 88-400).
 * Address range: 0x66688-0x66a5e.
 * ~188 instructions, first detector in pipeline.
 *
 * Detects and revises signal spikes/noise artifacts. When a spike is
 * detected, err128_flag is set to 1 and err128_revised_value contains
 * the corrected signal value.
 *
 * Two main paths:
 *   Path A: Previous flag was set (recurrence check with thresholds)
 *   Path B: Fresh detection via derivative analysis of signal history
 *
 * Binary register mapping:
 *   r6        = debug pointer
 *   lr / r5   = args pointer (stored at sp+0x14c)
 *   sp+0xf4   = dev_info pointer
 *   sp+0xf0   = args+0xbc70 (err128_flag_prev area)
 *   r8        = seq_current (loaded from args+0x648)
 *   r4        = seq_number_final (from debug->seq_number_final)
 *   r10       = args+0x2a58
 *   sp+0xe4   = args+0x42e4 (err128_CGM_c_noise_revised_value area)
 * ──────────────────────────────────────────────────────────────────── */
static void check_err128(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    (void)glucose_value;

    /*
     * Binary ref: lines 96-115 (check_error.asm)
     * STAGE 1: Copy signal data
     *
     * Copies 0x8f8 / 8 = 287.25 ~= 288 doubles (the binary loops
     * 0x8f8 bytes in steps of 8) from args+0x4300 area to args+0x42f8.
     *
     * In our packed struct, the signal array being copied corresponds to
     * err128_CGM_c_noise_revised_value[36]. However, 36 doubles = 288
     * bytes, while 0x8f8 = 2296 bytes = 287 doubles. The binary
     * accesses a larger region that overlaps multiple fields.
     *
     * For correctness, we copy the 36-element noise-revised array by
     * shifting it left by one position (the common pattern for history).
     *
     * TODO: Verify mapping — the binary copies 287 doubles from a
     * region around args+0x4300 into args+0x42f8. This may span
     * additional fields in the aligned binary struct.
     */
    if (sizeof(args->err128_CGM_c_noise_revised_value) >= 2 * sizeof(double)) {
        memmove(args->err128_CGM_c_noise_revised_value,
                args->err128_CGM_c_noise_revised_value + 1,
                (36 - 1) * sizeof(double));
    }

    /*
     * Binary ref: lines 99-121
     * STAGE 2: Round debug value and store
     *
     * Loads double from debug+0x750 area, calls math_round, converts
     * to integer, stores to args+0x42e4+8 area.
     *
     * In our struct layout, debug+0x750 is in the err16 statistics
     * region. The rounded value is stored into the noise-revised array.
     *
     * TODO: Verify mapping of debug+0x750 to exact field name.
     */
    double rounded_val = math_round(debug->err16_CGM_ISF_roc_value);
    int32_t rounded_int = (int32_t)rounded_val;
    /* Store as double into the last position of the noise-revised array */
    args->err128_CGM_c_noise_revised_value[35] = (double)rounded_int;

    /*
     * Binary ref: lines 122-133
     * STAGE 3: Initialize output fields
     *
     *   strb #0 at r6+0x896  -> debug->err128_flag = 0
     *   str  #0 at r6+0x8a0  -> debug->err128_revised_value = 0
     *   Store debug+0x5a8 value to debug+0x898 -> debug->err128_normal
     *
     * The NaN constant (0x7ff80000) stored at r6+0x8a4 is the high
     * word of the revised_value double (making it NaN when flag=0).
     * We use 0.0 since err128_revised_value is a full double in our
     * struct and flag=0 means "no revision".
     */
    debug->err128_flag = 0;
    debug->err128_revised_value = 0.0;

    /*
     * Binary ref: lines 125-133
     * Copy value from debug+0x5a8 to debug->err128_normal (debug+0x898).
     *
     * debug+0x5a8 is in the err1_i_sse_d_mean area of the debug struct.
     *
     * TODO: Verify mapping of debug+0x5a8 to exact field.
     */
    debug->err128_normal = debug->err1_i_sse_d_mean;

    /* Also call math_round on the same value (line 136: bl math_round) */
    double normal_rounded = math_round(debug->err1_i_sse_d_mean);
    (void)normal_rounded; /* Result used in threshold comparisons below */

    /*
     * Binary ref: line 134
     * STAGE 4: Load seq_current from args
     *
     * ldrh r8, [r5, #0x648] -> seq_current = args->idx
     * ldrh r4, [r6]         -> seq_number_final = debug->seq_number_final
     *
     * We already receive seq_current as parameter. seq_number_final
     * is the final sequence number assigned to the debug output.
     */
    uint16_t seq_number_final = debug->seq_number_final;

    /*
     * Binary ref: lines 138-144
     * STAGE 5: Early exit if seq_current < 2
     *
     * cmp r8, #2 / blo -> skip to epilogue
     */
    if (seq_current < 2)
        goto epilogue;

    /*
     * Binary ref: lines 145-148
     * STAGE 6: Check against dev_info threshold
     *
     * ldrh r0, [dev_info+0x93a] -> compare seq_current against threshold
     * cmp r8, r0 / bls -> skip if seq_current <= threshold
     *
     * In the binary, dev_info+0x93a falls in the err345_seq5 / err345_raw
     * area. With packed layout: err345_seq5 starts at offset ~0x236 in
     * our struct.
     *
     * TODO: Verify mapping of dev_info+0x93a to exact field.
     * Using err345_seq5[2] as best candidate.
     */
    if (seq_current <= dev_info->err345_seq5[2])
        goto epilogue;

    /*
     * Binary ref: lines 149-151
     * STAGE 7: Check lot_type
     *
     * ldrb r1, [r10, #0x4a] -> lot_type (r10 = args+0x2a58)
     * Binary offset args+0x2a58+0x4a = args+0x2aa2, but in packed
     * struct lot_type is at offset 0x2.
     * cmp r1, #2 / bhi -> skip if lot_type > 2
     */
    if (args->lot_type > 2)
        goto epilogue;

    /*
     * Binary ref: lines 152-156
     * STAGE 8: Convert rounded value to fixed-point for comparison
     *
     * vcvt.s32.f64 s16, d0  -> s16 = (int32_t)rounded_val
     * Check err128_flag_prev path:
     *   ldrb r1, [sp+0xf0 + 0x271] -> args->err128_flag_prev[?]
     *   (sp+0xf0 = args+0xbc70, so +0x271 = args+0xbee1)
     *
     * The binary offset args+0xbee1 maps to err128_flag_prev[17] or
     * nearby in our packed struct. However, the semantic meaning is
     * "most recent previous flag", which is err128_flag_prev[39]
     * (the last element before shifting).
     *
     * TODO: Verify exact index into err128_flag_prev.
     */
    int32_t rounded_s16 = (int32_t)normal_rounded;

    /* Check which path to take based on previous flag */
    uint8_t flag_prev = args->err128_flag_prev[39];

    if (flag_prev == 1) {
        /*
         * Binary ref: lines 153-191
         * PATH A: Recurrence check (previous spike was detected)
         *
         * Check if the previous detection at this sequence was
         * already handled.
         */

        /*
         * Binary ref: lines 157-161
         * Load byte from args at args_base + (lr - r0) + 0xbee2 area.
         * This checks err_delay_arr or a related previous-flag array.
         * If that byte == 1, skip (already handled).
         *
         * TODO: Verify mapping of this secondary flag check.
         */

        /*
         * Binary ref: lines 162-169
         * Load prev_seq from args+0xd08 area and check deviation:
         *   |seq_number_final - prev_seq| against dev_info+0x938 threshold.
         *
         * TODO: Verify mapping of args+0xd08 to field name.
         * This is likely in the err16_time5_first / err16_dt_arr region.
         */
        uint16_t prev_seq = args->seq_prev;
        uint16_t seq_diff = (seq_number_final > prev_seq) ?
                            (seq_number_final - prev_seq) :
                            (prev_seq - seq_number_final);

        /* TODO: Verify mapping of dev_info+0x938 to exact field */
        uint16_t seq_diff_threshold = dev_info->err345_seq5[1];
        if (seq_diff > seq_diff_threshold)
            goto epilogue;

        /*
         * Binary ref: lines 170-191
         * Compare rounded value against dev_info thresholds:
         *   dev_info+0x910: upper bound
         *   dev_info+0x918: lower bound
         *   dev_info+0x940: deviation threshold
         *
         * Logic:
         *   d16 = (double)rounded_s16
         *   if dev_info_upper > d16: set flag (spike above range)
         *   else if dev_info_lower >= d16: skip (within range)
         *   else: check |prev_normal - dev_info_deviation| > d16
         *
         * TODO: Verify mapping of dev_info+0x910/0x918/0x940 fields.
         * These are likely in err345_filtered / err345_min / err345_range area.
         */
        double val_d = (double)rounded_s16;
        double threshold_upper = (double)dev_info->err345_raw[2];
        double threshold_lower = (double)dev_info->err345_raw[3];

        if (threshold_upper > val_d) {
            /* Spike above range -> set flag */
            goto set_flag;
        }

        if (threshold_lower >= val_d) {
            /* Within normal range -> no spike */
            goto epilogue;
        }

        /* Check deviation from previous normal value */
        double prev_normal = args->err128_normal_prev;
        double deviation_thresh = (double)dev_info->err345_min[0];
        double deviation = prev_normal - deviation_thresh;
        if (deviation > val_d) {
            goto set_flag;
        }

        goto epilogue;
    } else {
        /*
         * Binary ref: lines 196-339
         * PATH B: Fresh spike detection via derivative analysis
         *
         * This path analyzes rate-of-change of the signal history to
         * detect spikes/noise artifacts.
         */

        /*
         * Binary ref: lines 196-217
         * Count valid accu_seq entries in a window around seq_current.
         *
         * ldrh r12, [dev_info+0x90a] -> window parameter
         * r2 = seq_number_final - r12
         * Iterate through accu_seq entries (stride 2 = uint16_t entries),
         * counting those where seq_number_final > entry AND
         * entry >= (seq_number_final - window).
         *
         * Cap count at 0x120 (288).
         *
         * TODO: Verify dev_info+0x90a field mapping.
         */
        uint16_t window_param = dev_info->err345_seq3[0];
        int16_t lower_seq = (int16_t)seq_number_final - (int16_t)window_param;
        uint16_t valid_count = 0;

        /* Use r5 as the loop variable stepping by 2 (uint16_t stride) */
        for (int i = 0; i < 865; i++) {
            uint16_t entry = args->accu_seq[i];
            if (entry == 0)
                continue;
            if (seq_number_final > entry && (int16_t)entry >= lower_seq) {
                valid_count++;
            }
        }

        /* Cap at 288 (0x120) */
        if (valid_count > 288)
            valid_count = 288;

        /*
         * Binary ref: lines 218-225
         * Check if count matches expected: window_param - 1 == valid_count
         * If not equal, skip to epilogue.
         */
        if ((uint16_t)(window_param - 1) != valid_count)
            goto epilogue;

        /*
         * Binary ref: lines 226-260
         * Compute rate-of-change (derivative) values from signal history.
         *
         * Clear a 0x900-byte (288 doubles) buffer on stack.
         * For each consecutive pair of entries in the noise-revised
         * signal array, compute:
         *   time_diff = (accu_seq[i+1] - accu_seq[i]) / 60.0
         *   signal_diff = noise_revised[i+1] - noise_revised[i]
         *   derivative = signal_diff / time_diff
         *   abs_derivative = fabs(derivative)
         *
         * The constant 60.0 comes from the literal pool at 0x66aa8
         * (0x404e0000 00000000 = 60.0).
         *
         * Store abs_derivative values into the buffer.
         */
        double derivatives[288];
        memset(derivatives, 0, sizeof(derivatives));

        uint16_t n_derivs = (valid_count > 1) ? (valid_count - 1) : 0;

        /*
         * The binary loads signal values from args+0x42f8 region
         * (the noise-revised array) and time values from args+0x644
         * area (related to time_standard_arr).
         *
         * For the derivative computation we use the
         * err128_CGM_c_noise_revised_value array and accu_seq
         * for timing. The time base uses 60.0 (one minute).
         */
        for (uint16_t i = 0; i < n_derivs && i < 287; i++) {
            /* Time differences from accu_seq (consecutive pair) */
            uint16_t idx_lo = (valid_count > i + 1) ? (288 - valid_count + i) : i;
            uint16_t idx_hi = idx_lo + 1;
            if (idx_lo >= 36 || idx_hi >= 36)
                continue;

            double sig_lo = args->err128_CGM_c_noise_revised_value[idx_lo];
            double sig_hi = args->err128_CGM_c_noise_revised_value[idx_hi];

            /*
             * Binary uses accu_seq pair for time base but divides by 60.0.
             * The uint16_t -> double conversion and subtraction gives the
             * time step. We approximate with a fixed 1.0 since accu_seq
             * spacing is typically 1 minute.
             *
             * TODO: Verify time base computation from binary.
             */
            double time_diff = 60.0;
            double sig_diff = sig_hi - sig_lo;
            double deriv = sig_diff / time_diff;
            derivatives[i] = fabs(deriv);
        }

        /*
         * Binary ref: lines 261-310
         * Validate derivatives and signal values against thresholds.
         *
         * Load dev_info threshold at dev_info+0x918 (same threshold
         * used for derivative comparison).
         * Load initial value from args+0x42e4 area.
         * Load baseline from debug+0x5a8 area.
         *
         * For each derivative:
         *   Check if noise-revised[i] > dev_info_threshold -> fail
         *   Check NaN -> fail
         *   Convert rounded_s16 to double, subtract baseline,
         *   check against dev_info+0x920 threshold
         *   Count violations
         *
         * TODO: Verify all threshold field mappings.
         */
        double deriv_threshold = (double)dev_info->err345_raw[3];
        uint8_t all_valid = 1;

        for (uint16_t i = 0; i < n_derivs && i < 287; i++) {
            uint16_t idx = (valid_count > i + 1) ? (288 - valid_count + i) : i;
            if (idx >= 36)
                continue;

            double sig_val = args->err128_CGM_c_noise_revised_value[idx];
            /* Check for NaN */
            if (isnan(sig_val)) {
                all_valid = 0;
                break;
            }
            /* Check against threshold */
            if (sig_val > deriv_threshold) {
                all_valid = 0;
                break;
            }
        }

        if (!all_valid)
            goto epilogue;

        /*
         * Binary ref: lines 311-339
         * Count threshold violations in derivatives.
         * Compare violation count against dev_info+0x928 threshold.
         * If violations pass: compute ratio and compare against
         * dev_info+0x930 threshold.
         *
         * TODO: Verify violation count threshold and ratio threshold
         * field mappings.
         */
        double violation_threshold = (double)dev_info->err345_min[1];
        uint16_t violation_count = 0;

        for (uint16_t i = 0; i < n_derivs && i < 287; i++) {
            if (derivatives[i] < violation_threshold)
                violation_count++;
        }

        /*
         * Compare violation count against dev_info+0x928 threshold.
         * Binary: ldr from dev_info+0x928, compare as double.
         *
         * TODO: Verify mapping of dev_info+0x928.
         */
        double count_threshold = (double)dev_info->err345_range;
        if ((double)violation_count > count_threshold)
            goto epilogue;

        /*
         * Binary ref: lines 320-338
         * Compute ratio = (rounded_s16 - baseline) / signal_diff
         * and compare against dev_info+0x930 threshold.
         *
         * TODO: Verify ratio computation and threshold field.
         */
        double baseline_val = args->err128_CGM_c_noise_revised_value[0];
        double signal_diff = (double)rounded_s16 - baseline_val;

        if (signal_diff <= 0.0)
            goto epilogue;

        double baseline_diff = debug->err128_normal - baseline_val;
        if (baseline_diff == 0.0)
            goto epilogue;

        double ratio = (double)rounded_s16 / baseline_diff;
        double ratio_threshold = (double)dev_info->err345_md;
        if (ratio >= ratio_threshold)
            goto epilogue;

        goto set_flag;
    }

set_flag:
    /*
     * Binary ref: lines 331-338 (0x66a40-0x66a58)
     * Set err128_flag = 1
     *
     * strb #1 at r6+0x896  -> debug->err128_flag = 1
     * Store revised value to debug+0x8a0 -> debug->err128_revised_value
     * Copy prev_normal to debug->err128_normal from args+0xbc70+0x280
     */
    debug->err128_flag = 1;
    /* The revised value is the current signal value from the derivative
     * analysis (d17 in the binary). Using the baseline value as
     * approximation.
     *
     * TODO: Verify which value exactly is stored as revised_value.
     */
    debug->err128_revised_value = debug->err128_normal;

    /* Copy prev normal from args storage area */
    debug->err128_normal = args->err128_normal_prev;

epilogue:
    /*
     * Binary ref: lines 339-373 (0x66a5a-0x66ad4)
     * EPILOGUE: Update persistent state
     *
     * 1. Shift err128_flag_prev array left by 1 byte (39 bytes moved).
     *    Binary: memmove-like loop, 0x27 = 39 bytes.
     *    movw r0, #0xbebb -> offset for flag_prev array start
     *    movs r1, #0x27   -> 39 bytes to shift
     *
     * 2. Store current flag to end of err128_flag_prev.
     * 3. Copy debug->err128_revised_value to args->err128_revised_value_prev.
     * 4. Copy debug->err128_normal to args->err128_normal_prev.
     */
    memmove(args->err128_flag_prev,
            args->err128_flag_prev + 1,
            39);
    args->err128_flag_prev[39] = debug->err128_flag;

    args->err128_revised_value_prev = debug->err128_revised_value;
    args->err128_normal_prev = debug->err128_normal;
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
 * From check_error.asm ~line 5460 through ~line 6109.
 * Address range: approximately 0x6a8c0-0x6afae.
 * ~950 instructions, fifth detector in pipeline.
 *
 * Checks signal quality through multiple metrics:
 *   - Signal minimum value tracking
 *   - Signal range analysis
 *   - Minimum difference computation
 *   - Derivative validation against thresholds using fun_comp_decimals
 *   - Delay flag management (err4_delay_flag_arr for err8 consumption)
 *
 * The detector populates:
 *   - debug->err4_condi[0..4]: 5 individual condition flags
 *   - debug->err4_delay_condi[0..4]: 5 delay condition flags
 *   - debug->err4_delay_flag: single flag (read by err32)
 *   - debug->error_code4: final error output
 *   - args->err4_delay_flag_arr[576]: delay flag history (read by err8)
 *   - args->err4_result_prev: hysteresis latch
 *
 * Binary register mapping:
 *   r6        = debug pointer (stored at sp+0x148)
 *   lr / r4   = args pointer (stored at sp+0x14c)
 *   sp+0xf4   = dev_info pointer
 *   sp+0xf0   = args+0xbc70 area
 *   r8        = seq_current (from sp+0x140)
 *   sp+0x18c  = seq_current (also at debug->seq_number_final)
 *   r10       = pointer to debug+0x5a8 area (sp+0xa8)
 *   sp+0x98   = args+0xb1d0 (err4_min_diff_prev area)
 *   r11       = args+0x11420 (high offset region)
 * ──────────────────────────────────────────────────────────────────── */
static void check_err4(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    (void)glucose_value;

    /*
     * Binary ref: lines 5519-5526 (0x6a928-0x6a938)
     * STAGE 1: Clear err4_condi[0..4] to 0
     *
     *   movs r0, #0
     *   Loop: strb r0, [r6+r1+0x888], r1=0..4
     *
     * debug+0x888 = debug->err4_condi[0]
     */
    for (int i = 0; i < 5; i++) {
        debug->err4_condi[i] = 0;
    }

    /*
     * Binary ref: lines 5527-5530 (0x6a93a-0x6a944)
     * STAGE 2: Clear working buffer on stack (0xc30 bytes)
     *
     * This clears a temporary buffer used for signal analysis.
     * We use local arrays instead.
     */

    /*
     * Binary ref: lines 5531-5537 (0x6a948-0x6a95a)
     * STAGE 3: Compute signal minimum
     *
     * If seq_current == 1:
     *   d17 = d16 = value from r10 (debug area)
     * Else:
     *   d16 = current value from r10
     *   d18 = previous min from args+0xb1d0 (err4_min_diff_prev area)
     *   Check for NaN in both, then d17 = min(d16, d18)
     *
     * The value at r10 comes from sp+0xa8 which is the debug signal
     * area. In context, this is the current signal value being analyzed.
     *
     * TODO: Verify mapping of r10 / sp+0xa8 to exact debug field.
     * Using debug->err4_min as the output field.
     */
    double current_val = debug->err1_i_sse_d_mean;
    double current_min;

    if (seq_current == 1) {
        current_min = current_val;
    } else {
        /* Load previous minimum from args */
        double prev_min = args->err4_min_prev[0];
        /* NaN-aware minimum */
        if (isnan(prev_min) || isnan(current_val)) {
            current_min = isnan(current_val) ? prev_min : current_val;
        } else {
            current_min = (prev_min < current_val) ? prev_min : current_val;
        }
    }

    /*
     * Binary ref: lines 5553-5564 (0x6a992-0x6a9cc)
     * STAGE 4: Store min and compute range / min_diff
     *
     * Store d17 (current_min) to debug+0x870 -> debug->err4_min
     *
     * If seq_current >= 2:
     *   d16 = current_val - prev_min_diff (from args+0xb1d8)
     *   Store d16 to debug+0x880 -> debug->err4_min_diff (actually range)
     *   d16 = current_min - prev_min (from sp+0x98)
     * Else (seq_current < 2):
     *   Store 0 to debug->err4_min_diff (with NaN high word)
     */
    debug->err4_min = current_min;

    double current_range;
    double current_min_diff;

    if (seq_current >= 2) {
        /* Range = current_val - previous min_diff baseline */
        double prev_range_base = args->err4_min_prev[1];
        current_range = current_val - prev_range_base;
        /* Store range */
        debug->err4_range = current_range;

        /* Min diff = current_min - previous min */
        double prev_min_for_diff = args->err4_min_prev[0];
        current_min_diff = current_min - prev_min_for_diff;
    } else {
        current_range = 0.0;
        current_min_diff = 0.0;
        debug->err4_range = 0.0;
    }
    debug->err4_min_diff = current_min_diff;

    /*
     * Binary ref: lines 5569-5593 (0x6a9cc-0x6aa12)
     * STAGE 5: Shift history arrays left by 1 position
     *
     * Three separate shift loops:
     *   1. err4_min_prev: 50 (0x32) entries shifted left by 1
     *      (args+0xb1e0 area, 0x32 doubles)
     *   2. err4_range_prev: 288 (0x120) entries shifted left by 1
     *      (args+0xb378 area)
     *   3. err4_min_diff_prev: 288 (0x120) entries shifted left by 1
     *      (args+0xa8d8 area)
     *
     * Then store current values at the end of each.
     *
     * The binary sizes (50, 288, 288) correspond to our struct array
     * sizes (289, 51, 289) minus 1 for the shift.
     */

    /* Shift err4_min_prev left by 1, store current at end */
    memmove(args->err4_min_prev,
            args->err4_min_prev + 1,
            (289 - 1) * sizeof(double));
    args->err4_min_prev[288] = current_min;

    /* Shift err4_range_prev left by 1, store current range at end */
    memmove(args->err4_range_prev,
            args->err4_range_prev + 1,
            (51 - 1) * sizeof(double));
    args->err4_range_prev[50] = debug->err4_range;

    /* Shift err4_min_diff_prev left by 1, store current at end */
    memmove(args->err4_min_diff_prev,
            args->err4_min_diff_prev + 1,
            (289 - 1) * sizeof(double));
    args->err4_min_diff_prev[288] = debug->err4_min;

    /*
     * Binary ref: lines 5607-5650 (0x6aa38-0x6aaae)
     * STAGE 6: Load sequence thresholds and initialize counters
     *
     * Multiple thresholds loaded from dev_info at offsets 0x56a..0x57e:
     *   dev_info+0x56a -> err345_seq1[0] area
     *   dev_info+0x56e -> nearby
     *   dev_info+0x574 -> nearby
     *   dev_info+0x576 -> nearby
     *   dev_info+0x578 -> nearby
     *   dev_info+0x57e -> nearby
     *
     * Also loads d10 from dev_info+0x600 (a double threshold) and
     * converts to integer for sequence comparison.
     *
     * Sets up multiple counters for the accu_seq scan.
     *
     * TODO: Verify all dev_info threshold field mappings.
     */
    uint16_t seq_threshold_0 = dev_info->err345_seq1[0];
    uint16_t seq_threshold_1 = dev_info->err345_seq1[1];

    /* Sequence difference bounds for counting */
    int16_t bound_a = (int16_t)seq_current - (int16_t)seq_threshold_0;
    int16_t bound_b = (int16_t)seq_current - (int16_t)seq_threshold_1;

    /*
     * Binary ref: lines 5651-5732 (0x6aab0-0x6ab7a)
     * STAGE 7: Scan accu_seq entries with multiple counters
     *
     * Iterates through accu_seq (stride 2 = uint16_t entries),
     * for each non-zero entry checks against multiple sequence bounds
     * and increments corresponding counters.
     *
     * We simplify to the key counts used later:
     *   count_a: entries where bound_a <= entry <= seq_current
     *   count_b: entries where bound_b <= entry <= seq_current
     */
    uint16_t count_a = 0;  /* General range count */
    uint16_t count_b = 0;  /* Wider range count */

    for (int i = 0; i < 865; i++) {
        uint16_t entry = args->accu_seq[i];
        if (entry == 0)
            continue;

        if (entry <= seq_current) {
            if ((int16_t)entry >= bound_a)
                count_a++;
            if ((int16_t)entry >= bound_b)
                count_b++;
        }
    }

    /*
     * Binary ref: lines 5735-5754 (0x6ab84-0x6abc6)
     * STAGE 8: Compute upper/lower signal bounds
     *
     * Load 4 threshold doubles from dev_info+0x598:
     *   d18 = dev_info+0x598 (thresh_lower_factor)
     *   d16 = dev_info+0x5a0 (thresh_lower_limit)
     *   d19 = dev_info+0x5a8 (thresh_upper_factor)
     *   d17 = dev_info+0x5b0 (thresh_upper_limit)
     *
     * Load float from sp+0xec (dev_info pointer's first field?),
     * convert to double (d20).
     *
     * d19 = d19 * d20 (upper_bound = factor * scale)
     * d18 = d18 * d20 (lower_bound = factor * scale)
     *
     * If d19 < d17: d17 = d19 (upper = min(scaled, limit))
     * If d18 < d16: d16 = d18 (lower = min(scaled, limit))
     *
     * The 4 threshold doubles at dev_info+0x598 map to fields in the
     * err345_filtered / err345_min / err345_range area of our struct.
     *
     * TODO: Verify mapping of dev_info+0x598..0x5b0 to exact fields.
     * The float at sp+0xec is the dev_info parameter passed to
     * check_error. Using dev_info->slope as approximation.
     */
    double thresh_lower_factor = (double)dev_info->err345_raw[0];
    double thresh_lower_limit  = (double)dev_info->err345_raw[1];
    double thresh_upper_factor = (double)dev_info->err345_raw[2];
    double thresh_upper_limit  = (double)dev_info->err345_raw[3];

    /* The scale float comes from the dev_info parameter area */
    double scale_val = (double)dev_info->slope;

    double upper_bound = thresh_upper_factor * scale_val;
    double lower_bound = thresh_lower_factor * scale_val;

    /* Apply min() against limits */
    if (upper_bound < thresh_upper_limit)
        thresh_upper_limit = upper_bound;
    if (lower_bound < thresh_lower_limit)
        thresh_lower_limit = lower_bound;

    upper_bound = thresh_upper_limit;
    lower_bound = thresh_lower_limit;

    /*
     * Binary ref: lines 5755-5758 (0x6abca-0x6abce)
     * STAGE 9: Early exit check
     *
     * Binary:
     *   ldr r3, [sp, #0x138]    ; load minimum count threshold
     *   cmp r0, r3              ; compare count_a against threshold
     *   bls 0x6ac32             ; if count_a <= threshold, early exit
     *
     * At 0x6ac32: loads existing debug->err4_delay_flag and jumps to
     * the final store at 0x6afae, SKIPPING all condition checking.
     *
     * When there isn't enough data, err4 preserves the existing
     * delay_flag value and does not compute any conditions.
     *
     * The threshold at sp+0x138 is loaded from dev_info during the
     * accu_seq counting phase. Using seq_threshold_0 as approximation.
     *
     * TODO: Verify exact threshold source (sp+0x138).
     */
    if (count_a <= seq_threshold_0) {
        /* Early exit: preserve existing delay_flag, skip to final store */
        uint8_t existing_flag = debug->err4_delay_flag;
        debug->error_code4 = existing_flag;
        args->err4_result_prev = existing_flag;

        /* Still update the delay flag array */
        memmove(args->err4_delay_flag_arr,
                args->err4_delay_flag_arr + 1,
                575);
        args->err4_delay_flag_arr[575] = existing_flag;
        return;
    }

    /*
     * Binary ref: lines 5758-5799 (0x6abd0-0x6ac30)
     * STAGE 10: Copy data into working buffer
     *
     * The copy transfers blocks of 0xf0 bytes (30 doubles = 240 bytes)
     * from args+0x9ca0 area into a stack buffer. Up to 13 (0xd) blocks.
     *
     * This copies the err4_inA signal array data for validation.
     *
     * TODO: Verify source array mapping (args+0x9ca0 in binary).
     */
    double work_buf[390]; /* 13 blocks * 30 doubles */
    memset(work_buf, 0, sizeof(work_buf));

    uint16_t copy_count = count_a;
    if (copy_count > 13)
        copy_count = 13;

    /* Copy signal data from err4_inA into work buffer */
    uint16_t src_offset = (copy_count < 13) ? (13 - copy_count) : 0;
    for (uint16_t block = 0; block < copy_count; block++) {
        uint16_t src_block = src_offset + block;
        for (int j = 0; j < 30 && (src_block * 30 + j) < 390; j++) {
            uint16_t src_idx = src_block * 30 + j;
            uint16_t dst_idx = block * 30 + j;
            if (dst_idx < 390 && src_idx < 390) {
                work_buf[dst_idx] = args->err4_inA[src_idx];
            }
        }
    }

    uint16_t total_entries = copy_count * 30;
    if (total_entries > 390)
        total_entries = 390;

    /*
     * Binary ref: lines 5808-5843 (0x6ac52-0x6acaa)
     * STAGE 11: Signal validation against upper/lower bounds
     *
     * Two code paths based on comparison of seq_current vs
     * threshold stored at sp+0x160:
     *
     * Path A (seq > threshold): check each value against upper_bound
     *   If value > upper_bound OR is NaN: result = 0 (fail)
     * Path B (seq <= threshold): check each value against lower_bound
     *   If value > lower_bound OR is NaN: result = 0 (fail)
     *
     * If all pass AND total_entries > 0: debug->err4_condi[0] = 1
     */
    if (total_entries > 0) {
        uint8_t validation_pass = 1;

        if (seq_current > seq_threshold_1) {
            /* Path A: validate against upper bound */
            for (uint16_t i = 0; i < total_entries; i++) {
                if (work_buf[i] > upper_bound || isnan(work_buf[i])) {
                    validation_pass = 0;
                    break;
                }
            }
        } else {
            /* Path B: validate against lower bound */
            for (uint16_t i = 0; i < total_entries; i++) {
                if (work_buf[i] > lower_bound || isnan(work_buf[i])) {
                    validation_pass = 0;
                    break;
                }
            }
        }

        if (validation_pass) {
            debug->err4_condi[0] = 1;
        }
    }

    /*
     * Binary ref: lines 5843-5850 (0x6acaa-0x6acce)
     * STAGE 12: Cap count and check sequence conditions
     *
     * Cap count_a at 0x120 (288).
     * Load threshold from r9 (args->err4_result_prev area).
     * Check seq_current against thresholds.
     */
    if (count_a > 288)
        count_a = 288;

    /*
     * Binary ref: lines 5848-5870 (0x6acc2-0x6ad04)
     * STAGE 13: Sequence-based filtering
     *
     * Loads threshold from dev_info+0x572 area.
     * If seq_current > threshold AND seq_current > stored threshold:
     *   proceed with rate-of-change analysis
     * Else: skip to accumulation stage
     *
     * TODO: Verify dev_info+0x572 field mapping.
     */
    uint16_t seq_filter = dev_info->err345_seq3[1];

    if (seq_current > seq_filter && count_a > 0) {
        /*
         * Binary ref: lines 5870-5945 (0x6ad04-0x6add6)
         * STAGE 14: Rate-of-change analysis using fun_comp_decimals
         *
         * Iterate through accu_seq entries looking for those > seq_current
         * minus a threshold. For each matching entry:
         *   - Load value from err_glu_arr (args+0x2a68)
         *   - Load value from args+0xb1d8 (err4_min_diff_prev area)
         *   - Call fun_comp_decimals(value, reference, 10, 4) (mode=le)
         *   - Count passes for each array
         *
         * If pass_count_a == expected_count: check pass_count_b against
         * threshold, and if >= threshold: set err4_condi[1] = 1
         */
        uint16_t pass_count_a = 0;
        uint16_t pass_count_b = 0;

        for (uint16_t i = 0; i < count_a; i++) {
            int idx = (int)i;
            if (idx < 288) {
                double val_a = args->err_glu_arr[idx];
                uint8_t cmp_a = fun_comp_decimals(val_a, current_min, 10, 4);
                if (cmp_a != 0)
                    pass_count_a++;

                if (idx < 289) {
                    double val_b = args->err4_min_diff_prev[idx];
                    uint8_t cmp_b = fun_comp_decimals(val_b, current_min_diff, 10, 4);
                    if (cmp_b != 0)
                        pass_count_b++;
                }
            }
        }

        /*
         * Binary ref: lines 5931-5945 (0x6adb0-0x6add6)
         * Check pass counts:
         *   If pass_count_a == count_a AND pass_count_b >= threshold:
         *     set err4_condi[1] = 1
         *
         * TODO: Verify threshold for pass_count_b.
         */
        if (pass_count_a == count_a) {
            uint8_t min_diff_thresh = dev_info->err345_n_range;
            if (pass_count_b >= min_diff_thresh) {
                debug->err4_condi[1] = 1;
            }
        }
    }

    /*
     * Binary ref: lines 5949-5971 (0x6ade0-0x6ae16)
     * STAGE 15: Additional condition checks (err4_condi[2] and [3])
     *
     * Two more condition blocks with similar structure:
     * Each checks seq_current against another dev_info threshold,
     * validates count against expected, then analyzes data.
     *
     * err4_condi[2] at dev_info+0x57c threshold
     * err4_condi[3] at dev_info+0x580 threshold
     *
     * TODO: Implement full condition logic for condi[2] and condi[3]
     * once dev_info field mappings are verified with oracle.
     */
    uint16_t seq_filter_2 = dev_info->err345_seq3[2];
    if (seq_current > seq_filter_2 && count_b > 0) {
        /* Simplified: set condi[2] based on similar validation logic */
        /* TODO: Verify mapping with oracle */
    }

    /*
     * Binary ref: lines 5972-6016 (0x6ae1a-0x6ae9e)
     * STAGE 16: Accumulated sum and validation
     *
     * Cap count at 288, accumulate values from err_glu_arr,
     * check err4_delay_flag_arr for zero entries (any zero -> fail).
     *
     * Also cap another counter at 0x33 (51).
     *
     * Sum the signal values and compare against a threshold.
     * Check if the accumulated difference meets requirements.
     *
     * Multiple conditions must pass:
     *   - sum < 200.0 (double literal from 0x6af60: 0x40690000 = 200.0)
     *   - count conditions met
     *   - validation passed
     */
    if (count_a > 0) {
        double signal_sum = 0.0;
        uint8_t delay_valid = 1;

        uint16_t sum_count = count_a;
        if (sum_count > 288)
            sum_count = 288;

        for (uint16_t i = 0; i < sum_count; i++) {
            int idx = 288 - sum_count + i;
            if (idx >= 0 && idx < 288) {
                signal_sum += args->err_glu_arr[idx];
            }

            /* Check err4_delay_flag_arr for zero entries */
            int flag_idx = 576 - sum_count + i;
            if (flag_idx >= 0 && flag_idx < 576) {
                if (args->err4_delay_flag_arr[flag_idx] == 0)
                    delay_valid = 0;
            }
        }

        /*
         * Binary ref: lines 6013-6016 (0x6ae92-0x6ae9e)
         * Check signal_sum < 200.0:
         *   vldr d18, [pc, #204] -> loads 200.0
         *   vcmp d17, d18
         *   bpl -> skip (if sum >= 200, don't set condition)
         */
        if (delay_valid && signal_sum < 200.0 && signal_sum >= 0.0) {
            /*
             * Binary ref: lines 6017-6081 (0x6aea0-0x6af68)
             * STAGE 17: Detailed derivative analysis
             *
             * Scan accu_seq for entries > (seq_current - 24),
             * compute derivative-like values using err_glu_arr,
             * validate each against half of a reference value,
             * check for NaN in both the value and the reference.
             *
             * Also scan args+0xb1d8 entries against lower_bound,
             * count entries that are below.
             *
             * If all_valid AND count_below >= 1.0:
             *   set err4_condi[4] = 1
             */
            uint8_t detail_valid = 1;
            double count_below = 0.0;

            /* Reference value from err4_inA area */
            uint16_t ref_count = count_a;
            if (ref_count > 51)
                ref_count = 51;

            for (uint16_t i = 0; i < ref_count; i++) {
                int idx = (int)i;
                if (idx < 288) {
                    double val = args->err_glu_arr[idx];
                    double ref_val = args->err4_inA[idx];
                    double half_ref = ref_val * 0.5;

                    /* Check if val <= half_ref and neither is NaN */
                    if (isnan(val) || isnan(ref_val)) {
                        detail_valid = 0;
                        break;
                    }
                    if (val > half_ref) {
                        detail_valid = 0;
                        break;
                    }
                }
            }

            /* Count entries in min_diff_prev below lower_bound */
            for (uint16_t i = 0; i < ref_count; i++) {
                int idx = (int)i;
                if (idx < 289) {
                    double val = args->err4_min_diff_prev[idx];
                    if (!isnan(val) && val < lower_bound)
                        count_below += 1.0;
                }
            }

            /*
             * Binary ref: lines 6082-6088 (0x6af68-0x6af78)
             * Final check for condi[4]:
             *   If detail_valid AND count_below >= 1.0:
             *     debug->err4_condi[4] = 1
             */
            if (detail_valid && count_below >= 1.0) {
                debug->err4_condi[4] = 1;
            }
        }
    }

    /*
     * Binary ref: lines 6089-6109 (0x6af7c-0x6afae)
     * STAGE 18: Final decision logic
     *
     * Hysteresis: if seq_current > 1 AND args->err4_result_prev == 1:
     *   result = 1
     *
     * Otherwise: scan err4_condi[0..4]:
     *   If ANY condi[i] == 1: result = 1
     *
     * Store result to:
     *   debug->err4_delay_flag (at debug+0x7aa) -> read by err32
     *   debug->error_code4
     *   args->err4_result_prev
     *
     * Binary:
     *   cmp r8, #1 / bls skip_hysteresis
     *   ldrb r0, [sp+0xf0 + 0x248] -> args->err4_result_prev
     *   cmp r0, #1 / beq set_result
     *
     * skip_hysteresis:
     *   movs r0, #0 / loop 0..4:
     *     ldrb r1, [r6 + r0 + 0x888]  (err4_condi[i])
     *     cmp r1, #1 / beq set_result
     *
     * If no condition met and no hysteresis: result = 0
     */
    uint8_t result = 0;

    /* Check hysteresis first */
    if (seq_current > 1 && args->err4_result_prev == 1) {
        result = 1;
    } else {
        /* Scan err4_condi for any set condition */
        for (int i = 0; i < 5; i++) {
            if (debug->err4_condi[i] == 1) {
                result = 1;
                break;
            }
        }
    }

    /*
     * Store results:
     *   debug->err4_delay_flag = result (read by err32)
     *   debug->error_code4 = result
     *   args->err4_result_prev = result (for hysteresis)
     */
    debug->err4_delay_flag = result;
    debug->error_code4 = result;
    args->err4_result_prev = result;

    /*
     * Binary ref: lines 6109-6114 (0x6afae-0x6afba)
     * STAGE 19: Update err4_delay_flag_arr
     *
     * Shift err4_delay_flag_arr left by 1, store current result.
     * Binary: strb r0, [r1, #0x248] (stores to args->err4_result_prev)
     *
     * The delay flag array is consumed by err8 (stage 4 of that detector).
     */
    memmove(args->err4_delay_flag_arr,
            args->err4_delay_flag_arr + 1,
            575);
    args->err4_delay_flag_arr[575] = result;
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
