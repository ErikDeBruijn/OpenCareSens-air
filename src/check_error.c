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
#include "signal_processing.h"

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
            goto set_flag_path_a;
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
            goto set_flag_path_a;
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
         * Binary ref: lines 226-260 (0x66920-0x66964)
         * The binary loads signal values from args+0x42f8 region
         * (the noise-revised array) and time values from args+0x644
         * area (time_standard_arr adjusted by valid_count).
         *
         * Derivative computation (from binary):
         *   d17 = (double)time[i+1] - (double)time[i]   (seconds)
         *   d17 = d17 / 60.0                            (to minutes)
         *   d18 = signal[i+1] - signal[i]
         *   d17 = d18 / d17                             (rate per minute)
         *   store |d17| to derivatives buffer
         *
         * The time values come from accu_seq (r3 at args+0x644 area).
         * The signal values from noise_revised array (r1 at args+0x4bf8).
         *
         * TODO: Verify time source array mapping with oracle.
         */
        for (uint16_t i = 0; i < n_derivs && i < 287; i++) {
            uint16_t idx_lo = (valid_count > i + 1) ? (288 - valid_count + i) : i;
            uint16_t idx_hi = idx_lo + 1;
            if (idx_lo >= 36 || idx_hi >= 36)
                continue;

            double sig_lo = args->err128_CGM_c_noise_revised_value[idx_lo];
            double sig_hi = args->err128_CGM_c_noise_revised_value[idx_hi];

            /*
             * Binary computes time_diff = (time[i+1] - time[i]) / 60.0
             * Using accu_seq as time proxy: delta_seq typically = 1,
             * so time_diff_min = 1/60 ≈ 0.0167.
             * derivative = sig_diff / time_diff_min
             *
             * TODO: Verify whether binary uses time_standard_arr or
             * accu_seq for time values. Using accu_seq for now.
             */
            uint16_t seq_lo = (idx_lo < 865) ? args->accu_seq[idx_lo] : 0;
            uint16_t seq_hi = (idx_hi < 865) ? args->accu_seq[idx_hi] : 0;
            double time_diff_sec = (double)seq_hi - (double)seq_lo;
            double time_diff_min = time_diff_sec / 60.0;

            if (time_diff_min <= 0.0)
                time_diff_min = 1.0 / 60.0;  /* Guard: assume 1-second minimum */

            double sig_diff = sig_hi - sig_lo;
            double deriv = sig_diff / time_diff_min;
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

        goto set_flag_path_b;
    }

set_flag_path_a:
    /*
     * Binary ref: lines 331-338 (0x66a40-0x66a58)
     * Set err128_flag = 1
     *
     * strb #1 at r6+0x896  -> debug->err128_flag = 1
     * vstr d17, [r0] at r6+0x8a0 -> debug->err128_revised_value = d17
     * vldr d16, [r0, #640] at sp+0xf0 -> args+0xbc70+0x280 = args+0xbef0
     * vstr d16, [r0] at sp+0x18c -> debug+0x898 = debug->err128_normal
     *
     * d17 differs by path:
     *   Path A: d17 = *(args+0xbc70+0x278) = args->err128_normal_prev
     *   Path B: d17 = *(sp+0xe4) = signal_history first element
     *
     * For Path A (from flag_prev==1 recurrence), d17 was loaded at
     * line 0x6687a: vldr d17, [r0, #632] where r0=sp+0xf0=args+0xbc70.
     * 632 = 0x278, so d17 = *(args+0xbc70+0x278) = err128_normal_prev.
     */
    debug->err128_flag = 1;
    debug->err128_revised_value = args->err128_normal_prev;
    debug->err128_normal = args->err128_normal_prev;
    goto epilogue;

set_flag_path_b:
    /*
     * For Path B (fresh spike detection), d17 was loaded at line 0x6698c:
     * vldr d17, [r1] where r1=sp+0xe4=args+0x4be8 in binary layout.
     * This is the first element of the signal region (sp+0xe4 area).
     * In our packed struct, map to err128_CGM_c_noise_revised_value[0].
     *
     * TODO: Verify mapping of sp+0xe4 in binary to our packed struct.
     */
    debug->err128_flag = 1;
    debug->err128_revised_value = args->err128_CGM_c_noise_revised_value[0];

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
    (void)glucose_value;

    /*
     * Binary ref: check_error.asm lines ~373-3870
     * Address range: 0x66ad4-0x68af0
     *
     * err16 is the sensor drift/degradation detector. It monitors ISF
     * (interstitial fluid) trend statistics over the 15-day sensor
     * lifespan. Only activates after 280 readings (~23h of data).
     *
     * The algorithm has these major phases:
     *   Phase 0: Initialize all err16 state (seq == 1)
     *   Phase 1: Entry gate (seq >= 280)
     *   Phase 2: History shifting + ISF smoothing
     *   Phase 3: Trend computation (f_cgm_trend x3 for min/mode/mean)
     *   Phase 4: Trend validation (f_check_cgm_trend x3)
     *   Phase 5: Final decision — any err16_condi[] == 1 => error_code16 = 1
     */

    uint16_t seq_val = seq_current;  /* from args->idx in binary */

    /* ── Phase 0: First-time initialization (seq == 1) ──
     *
     * Binary ref: lines 374-560 (0x66ad8-0x66cce)
     * When the sequence number is 1, initialize all err16 state arrays
     * to zero/NaN. This sets up clean state for the first sensor session.
     */
    if (seq_val == 1) {
        /* Clear err16_cal_cons_* arrays (50 elements each) */
        args->err16_cal_cons_is_first = 1;
        memset(args->err16_cal_cons_seq, 0, sizeof(args->err16_cal_cons_seq));
        memset(args->err16_cal_cons_time, 0, sizeof(args->err16_cal_cons_time));
        memset(args->err16_cal_cons_bgm, 0, sizeof(args->err16_cal_cons_bgm));
        for (int i = 0; i < 50; i++) {
            args->err16_cal_cons_bgm[i] = NAN;
            args->err16_cal_cons_d_usercal_before[i] = NAN;
            args->err16_cal_cons_d_usercal_after[i] = NAN;
        }

        /* Clear err16_cal_day_* arrays (30 elements each) */
        args->err16_cal_day_i = 0;
        args->err16_cal_day_is_first = 0;
        memset(args->err16_cal_day_idx_ref, 0,
               sizeof(args->err16_cal_day_idx_ref));
        for (int i = 0; i < 30; i++) {
            args->err16_cal_day_d_value[i] = NAN;
            args->err16_cal_day_n_value[i] = 0;
        }

        /* Clear err16_condi[7] */
        memset(debug->err16_condi, 0, sizeof(debug->err16_condi));

        /* Clear ISF smooth history (865 doubles) */
        for (int i = 0; i < 865; i++) {
            args->err16_CGM_ISF_smooth[i] = NAN;
        }

        /* Clear plasma array (36 doubles) */
        for (int i = 0; i < 36; i++) {
            args->err16_CGM_plasma[i] = NAN;
        }

        /* Clear ISF ROC arrays */
        args->err16_CGM_ISF_roc_n = 0.0;
        for (int i = 0; i < 577; i++)
            args->err16_CGM_ISF_roc_value[i] = NAN;
        for (int i = 0; i < 36; i++) {
            args->err16_CGM_ISF_roc_steady[i] = NAN;
            args->err16_CGM_ISF_roc_diff[i] = NAN;
            args->err16_CGM_ISF_roc_ratio[i] = NAN;
        }
        args->err16_CGM_ISF_roc_min = 0.0;
        for (int i = 0; i < 865; i++)
            args->err16_CGM_ISF_roc_min_temp[i] = NAN;
        args->err16_CGM_ISF_roc_min_prev = 0.0;

        /* Clear trend_min arrays */
        args->err16_CGM_ISF_trend_min_n = 0.0;
        args->err16_CGM_ISF_trend_min_value = NAN;
        args->err16_CGM_ISF_trend_min_value_prev = 0.0;
        for (int i = 0; i < 865; i++)
            args->err16_CGM_ISF_trend_min_value_arr[i] = NAN;
        for (int i = 0; i < 36; i++) {
            args->err16_CGM_ISF_trend_min_slope1[i] = NAN;
            args->err16_CGM_ISF_trend_min_slope2[i] = NAN;
            args->err16_CGM_ISF_trend_min_rsq1[i] = NAN;
            args->err16_CGM_ISF_trend_min_rsq2[i] = NAN;
            args->err16_CGM_ISF_trend_min_diff[i] = NAN;
            args->err16_CGM_ISF_trend_min_ratio[i] = NAN;
        }
        args->err16_CGM_ISF_trend_min_max = 0.0;
        for (int i = 0; i < 865; i++)
            args->err16_CGM_ISF_trend_min_max_temp[i] = NAN;
        args->err16_CGM_ISF_trend_min_max_prev = 0.0;
        args->err16_CGM_ISF_trend_min_max_early = 0.0;

        /* Clear trend_mode arrays */
        args->err16_CGM_ISF_trend_mode_n = 0.0;
        args->err16_CGM_ISF_trend_mode_value = NAN;
        args->err16_CGM_ISF_trend_mode_value_prev = 0.0;
        for (int i = 0; i < 36; i++) {
            args->err16_CGM_ISF_trend_mode_proportion[i] = NAN;
            args->err16_CGM_ISF_trend_mode_diff[i] = NAN;
            args->err16_CGM_ISF_trend_mode_ratio[i] = NAN;
        }
        args->err16_CGM_ISF_trend_mode_max = 0.0;
        for (int i = 0; i < 865; i++)
            args->err16_CGM_ISF_trend_mode_max_temp[i] = NAN;
        args->err16_CGM_ISF_trend_mode_max_prev = 0.0;
        args->err16_CGM_ISF_trend_mode_max_early = 0.0;

        /* Clear trend_mean arrays */
        args->err16_CGM_ISF_trend_mean_is_first = 0;
        args->err16_CGM_ISF_trend_mean_n = 0.0;
        args->err16_CGM_ISF_trend_mean_value = NAN;
        args->err16_CGM_ISF_trend_mean_value_prev = 0.0;
        for (int i = 0; i < 865; i++)
            args->err16_CGM_ISF_trend_mean_value_arr[i] = NAN;
        for (int i = 0; i < 36; i++) {
            args->err16_CGM_ISF_trend_mean_slope[i] = NAN;
            args->err16_CGM_ISF_trend_mean_rsq[i] = NAN;
            args->err16_CGM_ISF_trend_mean_diff[i] = NAN;
            args->err16_CGM_ISF_trend_mean_ratio[i] = NAN;
        }
        args->err16_CGM_ISF_trend_mean_max = 0.0;
        for (int i = 0; i < 865; i++)
            args->err16_CGM_ISF_trend_mean_max_temp[i] = NAN;
        args->err16_CGM_ISF_trend_mean_max_prev = 0.0;
        args->err16_CGM_ISF_trend_mean_max_early = 0.0;
        args->err16_CGM_ISF_trend_mean_max_early_prev = 0.0;
        for (int i = 0; i < 36; i++) {
            args->err16_CGM_ISF_trend_mean_diff_early[i] = NAN;
            args->err16_CGM_ISF_trend_mean_ratio_early[i] = NAN;
        }
        for (int i = 0; i < 865; i++)
            args->err16_CGM_ISF_trend_mean_max_temp_early[i] = NAN;

        args->err16_cal_day_d_ref = 0.0;
        args->err16_cal_day_d_temp = 0.0;
        args->err16_cal_day_n_ref = 0.0;
        args->err16_time5_first = 0;
        memset(args->err16_dt_arr, 0, sizeof(args->err16_dt_arr));

        /* Initialize debug err16 fields to NaN */
        debug->err16_CGM_ISF_smooth = NAN;
        debug->err16_CGM_plasma = NAN;
        debug->err16_CGM_ISF_roc_value = NAN;

        return;  /* Phase 0 complete, skip remaining phases */
    }

    /* ── Phase 1: Entry gate (seq >= 280) ──
     *
     * Binary ref: line 928 (0x67134): cmp.w r12, #0x118
     * Only proceed with the main err16 logic if seq >= 280 (0x118).
     * If seq < 280, we still perform history array shifting but skip
     * the smoothing, trend, and validation phases.
     */

    /* Initialize debug outputs to safe defaults */
    debug->err16_CGM_ISF_smooth = NAN;
    debug->err16_CGM_plasma = NAN;
    debug->err16_CGM_ISF_roc_value = NAN;
    debug->err16_CGM_ISF_roc_steady = NAN;
    debug->err16_CGM_ISF_roc_min_temp = NAN;
    debug->err16_CGM_ISF_roc_min = NAN;
    debug->err16_CGM_ISF_roc_diff = NAN;
    debug->err16_CGM_ISF_roc_ratio = NAN;
    debug->err16_CGM_ISF_trend_min_value = NAN;
    debug->err16_CGM_ISF_trend_min_slope1 = NAN;
    debug->err16_CGM_ISF_trend_min_slope2 = NAN;
    debug->err16_CGM_ISF_trend_min_rsq1 = NAN;
    debug->err16_CGM_ISF_trend_min_rsq2 = NAN;
    debug->err16_CGM_ISF_trend_min_diff = NAN;
    debug->err16_CGM_ISF_trend_min_max_temp = NAN;
    debug->err16_CGM_ISF_trend_min_max = NAN;
    debug->err16_CGM_ISF_trend_min_ratio = NAN;
    debug->err16_CGM_ISF_trend_mode_value = NAN;
    debug->err16_CGM_ISF_trend_mode_proportion = NAN;
    debug->err16_CGM_ISF_trend_mode_diff = NAN;
    debug->err16_CGM_ISF_trend_mode_max_temp = NAN;
    debug->err16_CGM_ISF_trend_mode_max = NAN;
    debug->err16_CGM_ISF_trend_mode_ratio = NAN;
    debug->err16_CGM_ISF_trend_mean_value = NAN;
    debug->err16_CGM_ISF_trend_mean_slope = NAN;
    debug->err16_CGM_ISF_trend_mean_rsq = NAN;
    debug->err16_CGM_ISF_trend_mean_diff = NAN;
    debug->err16_CGM_ISF_trend_mean_max_temp = NAN;
    debug->err16_CGM_ISF_trend_mean_max = NAN;
    debug->err16_CGM_ISF_trend_mean_ratio = NAN;
    debug->err16_CGM_ISF_trend_mean_diff_early = NAN;
    debug->err16_CGM_ISF_trend_mean_max_temp_early = NAN;
    debug->err16_CGM_ISF_trend_mean_max_early = NAN;
    debug->err16_CGM_ISF_trend_mean_ratio_early = NAN;
    debug->err16_cal_cons_d_usercal_after = NAN;
    debug->err16_cal_day_d_temp = NAN;
    debug->err16_cal_day_d_ref = NAN;
    debug->err16_cal_day_n_ref = NAN;
    debug->error_code16 = 0;
    memset(debug->err16_condi, 0, sizeof(debug->err16_condi));

    /* ── Phase 2: History array shifting ──
     *
     * Binary ref: lines 930-1093 (0x6713c-0x67324)
     * Before the main computation, shift history arrays left by one
     * position to make room for new values at the current index.
     *
     * This happens for ALL seq values (not gated by seq >= 280).
     * The binary shifts ~20 different arrays, each 36 or 865 elements.
     */

    /* Shift 36-element trend arrays left by 1 */
    memmove(args->err16_CGM_ISF_trend_min_slope1,
            args->err16_CGM_ISF_trend_min_slope1 + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_min_slope1[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_min_slope2,
            args->err16_CGM_ISF_trend_min_slope2 + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_min_slope2[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_min_rsq1,
            args->err16_CGM_ISF_trend_min_rsq1 + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_min_rsq1[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_min_rsq2,
            args->err16_CGM_ISF_trend_min_rsq2 + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_min_rsq2[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_min_diff,
            args->err16_CGM_ISF_trend_min_diff + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_min_diff[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_min_ratio,
            args->err16_CGM_ISF_trend_min_ratio + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_min_ratio[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mode_proportion,
            args->err16_CGM_ISF_trend_mode_proportion + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mode_proportion[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mode_diff,
            args->err16_CGM_ISF_trend_mode_diff + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mode_diff[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mode_ratio,
            args->err16_CGM_ISF_trend_mode_ratio + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mode_ratio[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_slope,
            args->err16_CGM_ISF_trend_mean_slope + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_slope[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_rsq,
            args->err16_CGM_ISF_trend_mean_rsq + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_rsq[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_diff,
            args->err16_CGM_ISF_trend_mean_diff + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_diff[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_ratio,
            args->err16_CGM_ISF_trend_mean_ratio + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_ratio[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_diff_early,
            args->err16_CGM_ISF_trend_mean_diff_early + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_diff_early[35] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_ratio_early,
            args->err16_CGM_ISF_trend_mean_ratio_early + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_ratio_early[35] = NAN;

    memmove(args->err16_CGM_ISF_roc_steady,
            args->err16_CGM_ISF_roc_steady + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_roc_steady[35] = NAN;

    memmove(args->err16_CGM_ISF_roc_diff,
            args->err16_CGM_ISF_roc_diff + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_roc_diff[35] = NAN;

    memmove(args->err16_CGM_ISF_roc_ratio,
            args->err16_CGM_ISF_roc_ratio + 1,
            35 * sizeof(double));
    args->err16_CGM_ISF_roc_ratio[35] = NAN;

    memmove(args->err16_CGM_plasma,
            args->err16_CGM_plasma + 1,
            35 * sizeof(double));
    args->err16_CGM_plasma[35] = NAN;

    memmove(args->err16_dt_arr,
            args->err16_dt_arr + 1,
            35 * sizeof(double));
    args->err16_dt_arr[35] = NAN;

    /* Shift 865-element arrays left by 1 */
    memmove(args->err16_CGM_ISF_roc_value,
            args->err16_CGM_ISF_roc_value + 1,
            576 * sizeof(double));
    args->err16_CGM_ISF_roc_value[576] = NAN;

    memmove(args->err16_CGM_ISF_roc_min_temp,
            args->err16_CGM_ISF_roc_min_temp + 1,
            864 * sizeof(double));
    args->err16_CGM_ISF_roc_min_temp[864] = NAN;

    memmove(args->err16_CGM_ISF_trend_min_value_arr,
            args->err16_CGM_ISF_trend_min_value_arr + 1,
            864 * sizeof(double));
    args->err16_CGM_ISF_trend_min_value_arr[864] = NAN;

    memmove(args->err16_CGM_ISF_trend_min_max_temp,
            args->err16_CGM_ISF_trend_min_max_temp + 1,
            864 * sizeof(double));
    args->err16_CGM_ISF_trend_min_max_temp[864] = NAN;

    memmove(args->err16_CGM_ISF_trend_mode_max_temp,
            args->err16_CGM_ISF_trend_mode_max_temp + 1,
            864 * sizeof(double));
    args->err16_CGM_ISF_trend_mode_max_temp[864] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_value_arr,
            args->err16_CGM_ISF_trend_mean_value_arr + 1,
            864 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_value_arr[864] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_max_temp,
            args->err16_CGM_ISF_trend_mean_max_temp + 1,
            864 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_max_temp[864] = NAN;

    memmove(args->err16_CGM_ISF_trend_mean_max_temp_early,
            args->err16_CGM_ISF_trend_mean_max_temp_early + 1,
            864 * sizeof(double));
    args->err16_CGM_ISF_trend_mean_max_temp_early[864] = NAN;

    /* Shift ISF smooth array left by 1 */
    memmove(args->err16_CGM_ISF_smooth,
            args->err16_CGM_ISF_smooth + 1,
            864 * sizeof(double));
    args->err16_CGM_ISF_smooth[864] = NAN;

    /* Compute dt (time difference) for current reading.
     *
     * Binary ref: line 1094-1134 (0x67326-0x673aa)
     * dt = (measurement_time - err16_time5_first) / 60.0
     * This is stored in debug and used for trend rate computations.
     *
     * TODO: Verify the exact time source mapping with oracle.
     */
    uint32_t time_now = debug->measurement_time_standard;
    uint32_t time_first = args->err16_time5_first;
    if (time_first == 0)
        time_first = time_now;
    double dt = (double)(time_now - time_first) / 60.0;
    args->err16_dt_arr[35] = dt;

    if (seq_val < 280) {
        /* Not enough data — skip smoothing, trend, validation.
         * Binary: beq.w 0x67326 at line 929 (branches when == 280,
         * meaning < 280 takes the shift-only path, >= 280 enters
         * main logic).
         */
        debug->error_code16 = 0;
        return;
    }

    /* ── Phase 3: ISF Smooth computation ──
     *
     * Binary ref: lines 1094-1417 (0x67326-0x67730)
     * Calls smooth1q_err16 twice:
     *   1st call: smooth the ISF data, compute CGM_plasma
     *   2nd call: smooth the plasma data for trend analysis
     *
     * The smoothing window size comes from dev_info+0x700 area,
     * which maps to err6_CGM_BLE_bad[0] in our packed struct.
     *
     * TODO: Verify dev_info field mapping for smoothing params.
     */
    uint16_t smooth_n = dev_info->err6_CGM_BLE_bad[0];
    if (smooth_n == 0)
        smooth_n = 36;  /* Sane default if device config is zero */
    if (smooth_n > 50)
        smooth_n = 50;  /* smooth1q_err16 max is 50 */

    /* Count valid accu_seq entries for the smoothing window */
    uint16_t seq_final = debug->seq_number_final;
    int16_t lower_bound = (int16_t)seq_final - (int16_t)smooth_n;
    uint16_t n_valid = 0;
    for (int i = 0; i < 865; i++) {
        uint16_t s = args->accu_seq[i];
        if (s == 0)
            continue;
        if (s <= seq_final && (int16_t)s > lower_bound)
            n_valid++;
    }

    /* Stack-allocated smoothing buffers for smooth1q_err16 */
    double smooth_buf1[50];
    double smooth_buf2[50];
    memset(smooth_buf1, 0, sizeof(smooth_buf1));
    memset(smooth_buf2, 0, sizeof(smooth_buf2));

    /* Copy the last n_valid ISF smooth values into the smoothing buffer */
    uint16_t copy_n = (n_valid < smooth_n) ? n_valid : smooth_n;
    if (copy_n > 50) copy_n = 50;

    if (copy_n > 0 && n_valid == smooth_n) {
        /* Extract the tail of the ISF smooth array */
        for (uint16_t i = 0; i < copy_n; i++) {
            uint16_t src_idx = (865 > copy_n) ? (865 - copy_n + i) : i;
            if (src_idx < 865)
                smooth_buf1[i] = args->err16_CGM_ISF_smooth[src_idx];
        }

        /* 1st smooth call: smooth the ISF data */
        smooth1q_err16(smooth_buf1, copy_n, smooth_buf2);

        /* Store smoothed last value to debug */
        debug->err16_CGM_ISF_smooth = smooth_buf2[copy_n - 1];

        /*
         * Binary ref: lines 1394-1416 (0x676e6-0x67730)
         * Compute CGM_plasma from smoothed ISF:
         *   plasma = (smoothed_isf[last-1]) / (slope * scale) * round_factor
         *
         * The computation involves dev_info fields at dev_info+0x700
         * and other calibration parameters. Simplified version:
         *   Store math_round(smoothed_value) to debug->err16_CGM_plasma
         *
         * TODO: Verify exact plasma computation with oracle.
         */
        double smoothed_val = smooth_buf2[copy_n - 1];
        double rounded_smooth = math_round(smoothed_val);
        debug->err16_CGM_plasma = rounded_smooth;
        args->err16_CGM_plasma[35] = rounded_smooth;

        /* 2nd smooth call: smooth the plasma data */
        double plasma_buf[50];
        double plasma_out[50];
        memset(plasma_buf, 0, sizeof(plasma_buf));
        memset(plasma_out, 0, sizeof(plasma_out));

        for (uint16_t i = 0; i < copy_n && i < 36; i++) {
            uint16_t src_idx = (36 > copy_n) ? (36 - copy_n + i) : i;
            if (src_idx < 36)
                plasma_buf[i] = args->err16_CGM_plasma[src_idx];
        }

        smooth1q_err16(plasma_buf, copy_n, plasma_out);
        double rounded_plasma = math_round(plasma_out[copy_n - 1]);
        (void)rounded_plasma;  /* Used for downstream trend, stored via trend calls */
    } else {
        /* Insufficient data for smoothing: set outputs to NaN and skip
         * trend computation. */
        debug->err16_CGM_ISF_smooth = NAN;
        debug->err16_CGM_plasma = NAN;
        debug->error_code16 = 0;
        return;
    }

    /* ── Phase 4: Trend computation (3 passes) ──
     *
     * Binary ref: lines 1430-1758 (0x67766-0x67b56)
     * Three calls to f_cgm_trend for min, mode, and mean trends:
     *   Pass 0 (mode=0): min trend — 10th percentile reference
     *   Pass 1 (mode=2): mode trend — quantized mode reference
     *   Pass 2 (mode=1): mean trend — trimmed mean reference
     *
     * Each call computes:
     *   - trend_value, trend_n
     *   - slope1, slope2 (regression slopes)
     *   - rsq1, rsq2 (R-squared values)
     *   - diff, ratio (deviation from reference)
     *   - max values (running maximums)
     *
     * The parameters come from dev_info err6_* fields at various offsets.
     *
     * TODO: Verify dev_info offset mappings for all trend parameters.
     */

    /*
     * Build the result buffer for f_cgm_trend.
     * f_cgm_trend writes multiple fields at specific offsets in a result
     * array, which we then copy to the appropriate args fields.
     */
    double trend_result[48];
    memset(trend_result, 0, sizeof(trend_result));

    /* min_n and n_back parameters from dev_info.
     * Binary loads these from dev_info+0x708..0x734 area.
     * In packed struct, these map to err6_CGM_* fields.
     *
     * TODO: Verify mapping with oracle. Using defaults for now.
     */
    double min_n_param = 3.0;
    double n_back_param = (double)smooth_n;
    double ref_value = 0.0;
    uint16_t roc_ptr_dummy = 0;

    /* Pass 0: min trend (mode = 0) */
    f_cgm_trend(args, args->accu_seq, trend_result, seq_val,
                min_n_param, n_back_param, ref_value,
                &roc_ptr_dummy, 0, 0, dev_info->cal_trendRate);

    /* Store min trend results to args and debug */
    args->err16_CGM_ISF_trend_min_value = trend_result[0];
    debug->err16_CGM_ISF_trend_min_value = trend_result[0];
    args->err16_CGM_ISF_trend_min_n = trend_result[3];

    /* Store slopes/rsq to the last position (index 35) of trend arrays */
    args->err16_CGM_ISF_trend_min_slope1[35] = trend_result[5];
    debug->err16_CGM_ISF_trend_min_slope1 = trend_result[5];
    args->err16_CGM_ISF_trend_min_slope2[35] = trend_result[7];
    debug->err16_CGM_ISF_trend_min_slope2 = trend_result[7];
    args->err16_CGM_ISF_trend_min_rsq1[35] = trend_result[9];
    debug->err16_CGM_ISF_trend_min_rsq1 = trend_result[9];
    args->err16_CGM_ISF_trend_min_rsq2[35] = trend_result[11];
    debug->err16_CGM_ISF_trend_min_rsq2 = trend_result[11];
    args->err16_CGM_ISF_trend_min_diff[35] = trend_result[13];
    debug->err16_CGM_ISF_trend_min_diff = trend_result[13];
    args->err16_CGM_ISF_trend_min_ratio[35] = trend_result[15];
    debug->err16_CGM_ISF_trend_min_ratio = trend_result[15];

    /* Store value to value_arr at current position */
    if (seq_val > 0 && seq_val <= 865) {
        args->err16_CGM_ISF_trend_min_value_arr[seq_val - 1] =
            args->err16_CGM_ISF_trend_min_value;
    }

    /* Update min max tracking */
    if (!isnan(args->err16_CGM_ISF_trend_min_value)) {
        if (args->err16_CGM_ISF_trend_min_value >
            args->err16_CGM_ISF_trend_min_max) {
            args->err16_CGM_ISF_trend_min_max =
                args->err16_CGM_ISF_trend_min_value;
        }
    }
    debug->err16_CGM_ISF_trend_min_max = args->err16_CGM_ISF_trend_min_max;
    if (seq_val > 0 && seq_val <= 865) {
        args->err16_CGM_ISF_trend_min_max_temp[seq_val - 1] =
            args->err16_CGM_ISF_trend_min_max;
    }
    debug->err16_CGM_ISF_trend_min_max_temp =
        args->err16_CGM_ISF_trend_min_max;

    /* Preserve prev value */
    args->err16_CGM_ISF_trend_min_value_prev =
        args->err16_CGM_ISF_trend_min_value;
    args->err16_CGM_ISF_trend_min_max_prev =
        args->err16_CGM_ISF_trend_min_max;

    /* Pass 1: mode trend (mode = 2) */
    memset(trend_result, 0, sizeof(trend_result));
    f_cgm_trend(args, args->accu_seq, trend_result, seq_val,
                min_n_param, n_back_param, ref_value,
                &roc_ptr_dummy, 2, 0, dev_info->cal_trendRate);

    args->err16_CGM_ISF_trend_mode_value = trend_result[0];
    debug->err16_CGM_ISF_trend_mode_value = trend_result[0];
    args->err16_CGM_ISF_trend_mode_n = trend_result[3];

    args->err16_CGM_ISF_trend_mode_proportion[35] = trend_result[5];
    debug->err16_CGM_ISF_trend_mode_proportion = trend_result[5];
    args->err16_CGM_ISF_trend_mode_diff[35] = trend_result[7];
    debug->err16_CGM_ISF_trend_mode_diff = trend_result[7];
    args->err16_CGM_ISF_trend_mode_ratio[35] = trend_result[9];
    debug->err16_CGM_ISF_trend_mode_ratio = trend_result[9];

    /* Update mode max tracking */
    if (!isnan(args->err16_CGM_ISF_trend_mode_value)) {
        if (args->err16_CGM_ISF_trend_mode_value >
            args->err16_CGM_ISF_trend_mode_max) {
            args->err16_CGM_ISF_trend_mode_max =
                args->err16_CGM_ISF_trend_mode_value;
        }
    }
    debug->err16_CGM_ISF_trend_mode_max = args->err16_CGM_ISF_trend_mode_max;
    if (seq_val > 0 && seq_val <= 865) {
        args->err16_CGM_ISF_trend_mode_max_temp[seq_val - 1] =
            args->err16_CGM_ISF_trend_mode_max;
    }
    debug->err16_CGM_ISF_trend_mode_max_temp =
        args->err16_CGM_ISF_trend_mode_max;

    args->err16_CGM_ISF_trend_mode_value_prev =
        args->err16_CGM_ISF_trend_mode_value;
    args->err16_CGM_ISF_trend_mode_max_prev =
        args->err16_CGM_ISF_trend_mode_max;

    /* Pass 2: mean trend (mode = 1) */
    memset(trend_result, 0, sizeof(trend_result));
    f_cgm_trend(args, args->accu_seq, trend_result, seq_val,
                min_n_param, n_back_param, ref_value,
                &roc_ptr_dummy, 1, 0, dev_info->cal_trendRate);

    args->err16_CGM_ISF_trend_mean_value = trend_result[0];
    debug->err16_CGM_ISF_trend_mean_value = trend_result[0];
    args->err16_CGM_ISF_trend_mean_n = trend_result[3];

    args->err16_CGM_ISF_trend_mean_slope[35] = trend_result[5];
    debug->err16_CGM_ISF_trend_mean_slope = trend_result[5];
    args->err16_CGM_ISF_trend_mean_rsq[35] = trend_result[7];
    debug->err16_CGM_ISF_trend_mean_rsq = trend_result[7];
    args->err16_CGM_ISF_trend_mean_diff[35] = trend_result[9];
    debug->err16_CGM_ISF_trend_mean_diff = trend_result[9];
    args->err16_CGM_ISF_trend_mean_ratio[35] = trend_result[11];
    debug->err16_CGM_ISF_trend_mean_ratio = trend_result[11];

    /* Store to value_arr */
    if (seq_val > 0 && seq_val <= 865) {
        args->err16_CGM_ISF_trend_mean_value_arr[seq_val - 1] =
            args->err16_CGM_ISF_trend_mean_value;
    }

    /* Update mean max tracking */
    if (!isnan(args->err16_CGM_ISF_trend_mean_value)) {
        if (args->err16_CGM_ISF_trend_mean_value >
            args->err16_CGM_ISF_trend_mean_max) {
            args->err16_CGM_ISF_trend_mean_max =
                args->err16_CGM_ISF_trend_mean_value;
        }
    }
    debug->err16_CGM_ISF_trend_mean_max = args->err16_CGM_ISF_trend_mean_max;
    if (seq_val > 0 && seq_val <= 865) {
        args->err16_CGM_ISF_trend_mean_max_temp[seq_val - 1] =
            args->err16_CGM_ISF_trend_mean_max;
    }
    debug->err16_CGM_ISF_trend_mean_max_temp =
        args->err16_CGM_ISF_trend_mean_max;

    /* Mean early diff/ratio tracking */
    args->err16_CGM_ISF_trend_mean_diff_early[35] = trend_result[13];
    debug->err16_CGM_ISF_trend_mean_diff_early = trend_result[13];
    args->err16_CGM_ISF_trend_mean_ratio_early[35] = trend_result[15];
    debug->err16_CGM_ISF_trend_mean_ratio_early = trend_result[15];

    if (!isnan(trend_result[13])) {
        double abs_early = fabs(trend_result[13]);
        if (abs_early > args->err16_CGM_ISF_trend_mean_max_early) {
            args->err16_CGM_ISF_trend_mean_max_early = abs_early;
        }
    }
    debug->err16_CGM_ISF_trend_mean_max_early =
        args->err16_CGM_ISF_trend_mean_max_early;
    if (seq_val > 0 && seq_val <= 865) {
        args->err16_CGM_ISF_trend_mean_max_temp_early[seq_val - 1] =
            args->err16_CGM_ISF_trend_mean_max_early;
    }
    debug->err16_CGM_ISF_trend_mean_max_temp_early =
        args->err16_CGM_ISF_trend_mean_max_early;

    args->err16_CGM_ISF_trend_mean_value_prev =
        args->err16_CGM_ISF_trend_mean_value;
    args->err16_CGM_ISF_trend_mean_max_prev =
        args->err16_CGM_ISF_trend_mean_max;
    args->err16_CGM_ISF_trend_mean_max_early_prev =
        args->err16_CGM_ISF_trend_mean_max_early;

    /* ── Phase 5: Trend validation ──
     *
     * Binary ref: lines ~1787-2700 (0x67bc0-0x68704)
     * Three calls to f_check_cgm_trend for min/mode/mean validation.
     * Results stored in err16_condi[0..6].
     *
     * The validation checks trend slopes/ratios against thresholds
     * from dev_info. The mode parameter controls which checks are
     * performed (100 for simple le check, <=2 for 3-array check, etc).
     *
     * Binary flow:
     *   - First call (min): mode from dev_info, validates slope1/slope2
     *     -> stores result to debug+0x88f (err16_condi[0])
     *   - Inline validation loop for mode trend (condi[1..3])
     *   - Second call (mode/mean): validates another set
     *     -> stores result to debug+0x890 (err16_condi[1])
     *   - Third call (mean with early data): mode from dev_info
     *     -> stores result to debug+0x891 (err16_condi[2])
     *   - Additional inline checks for condi[3..6]
     *
     * TODO: Verify exact threshold mappings and validation modes.
     */

    /* Load validation threshold from dev_info.
     * Binary accesses dev_info+0x418 (errcode_version area).
     * In our packed struct, this maps to err345_seq1[0].
     *
     * TODO: Verify mapping with oracle. */
    uint16_t validation_threshold = dev_info->err345_seq1[0];

    /* First f_check_cgm_trend call for min trend */
    if (seq_final > validation_threshold && validation_threshold > 0) {
        /* Build arrays for f_check_cgm_trend.
         * The binary loads slope1, slope2, diff, ratio arrays into
         * stack-based pointer arrays and calls f_check_cgm_trend.
         *
         * TODO: Verify array selection and modes with oracle.
         */
        double *min_arrays[6];
        min_arrays[0] = args->err16_CGM_ISF_trend_min_slope1;
        min_arrays[1] = args->err16_CGM_ISF_trend_min_slope2;
        min_arrays[2] = args->err16_CGM_ISF_trend_min_diff;
        min_arrays[3] = args->err16_CGM_ISF_trend_min_rsq1;
        min_arrays[4] = args->err16_CGM_ISF_trend_min_rsq2;
        min_arrays[5] = args->err16_CGM_ISF_trend_min_ratio;

        /* Thresholds from dev_info err6 area.
         * TODO: Verify mappings. Using placeholder thresholds. */
        double min_thresholds[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
        uint8_t min_comp_modes[6] = {4, 4, 4, 4, 4, 4}; /* le=4 */

        uint8_t min_result = f_check_cgm_trend(
            100,   /* mode 100 = simple 2-array le check */
            args, seq_val,
            smooth_n,
            min_arrays, 2,
            min_thresholds, 2,
            min_comp_modes);
        debug->err16_condi[0] = min_result;
    }

    /* Second f_check_cgm_trend call for mode trend */
    {
        double *mode_arrays[6];
        mode_arrays[0] = args->err16_CGM_ISF_trend_mode_proportion;
        mode_arrays[1] = args->err16_CGM_ISF_trend_mode_diff;
        mode_arrays[2] = args->err16_CGM_ISF_trend_mode_ratio;

        double mode_thresholds[3] = {0.0, 0.0, 0.0};
        uint8_t mode_comp_modes[3] = {4, 4, 4};

        uint8_t mode_result = f_check_cgm_trend(
            1,   /* mode <= 2 */
            args, seq_val,
            smooth_n,
            mode_arrays, 3,
            mode_thresholds, 3,
            mode_comp_modes);
        debug->err16_condi[1] = mode_result;
    }

    /* Third f_check_cgm_trend call for mean trend */
    {
        double *mean_arrays[6];
        mean_arrays[0] = args->err16_CGM_ISF_trend_mean_slope;
        mean_arrays[1] = args->err16_CGM_ISF_trend_mean_rsq;
        mean_arrays[2] = args->err16_CGM_ISF_trend_mean_diff;
        mean_arrays[3] = args->err16_CGM_ISF_trend_mean_ratio;
        mean_arrays[4] = args->err16_CGM_ISF_trend_mean_diff_early;
        mean_arrays[5] = args->err16_CGM_ISF_trend_mean_ratio_early;

        double mean_thresholds[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
        uint8_t mean_comp_modes[6] = {4, 4, 1, 1, 4, 4};

        uint8_t mean_result = f_check_cgm_trend(
            3,   /* mode > 2 */
            args, seq_val,
            smooth_n,
            mean_arrays, 6,
            mean_thresholds, 6,
            mean_comp_modes);
        debug->err16_condi[2] = mean_result;
    }

    /* ── Phase 6: Final decision ──
     *
     * Binary ref: lines 2998-3012 (0x68acc-0x68ae6)
     * Iterate through err16_condi[0..6]:
     *   If ANY condi[i] == 1, set error_code16 = 1.
     *
     * Binary stores to debug+0x7ac (error_code16 in debug struct).
     *
     * There are also additional inline checks (condi[3..6]) that
     * are computed from early-data validators and time-based checks.
     * These follow the pattern at lines 2700-2998 in the binary.
     *
     * For the initial implementation, we check condi[0..6] from the
     * above validation calls. The additional inline checks set
     * condi[3..6] based on sensor age, calibration history, and
     * absolute trend deviations. These are complex time-based checks
     * that will be refined with oracle testing.
     *
     * TODO: Implement condi[3..6] inline checks from binary lines
     * 2700-2998. These involve:
     *   - condi[3]: sensor age check (measurement_time vs sensor_start_time)
     *   - condi[4]: calibration trend rate check
     *   - condi[5]: absolute ISF deviation check
     *   - condi[6]: combined deviation + trend check
     */

    /* Check if ANY condition is set */
    uint8_t any_set = 0;
    for (int i = 0; i < 7; i++) {
        if (debug->err16_condi[i] == 1) {
            any_set = 1;
            break;
        }
    }

    debug->error_code16 = any_set;

    /* Store result_prev for next iteration */
    args->err16_result_prev = debug->error_code16;
}

/* ────────────────────────────────────────────────────────────────────
 * err1: Contact/noise detector (most complex)
 *
 * From check_error.asm ~line 3500 through ~line 7997.
 * Address range: 0x690b8 through 0x6c5c4.
 * ~1265 lines of disassembly, ~1000 ARM instructions.
 *
 * Detects poor sensor contact and excessive noise using:
 *   - 180-element signal/time/current histories
 *   - 100-element contact quality histories
 *   - SSE mean computations with absolute-difference smoothing
 *   - 7 independent temporal discontinuity (TD) trio evaluations
 *   - Linear regression + R-squared quality assessment
 *   - cal_threshold for adaptive threshold computation
 *
 * Algorithm structure (6 stages):
 *   Stage 1: Load thresholds, initialize debug, early exit if low seq
 *   Stage 2: SSE mean evaluation via err1_TD_var_update + smoothing
 *   Stage 3: Contact quality assessment (diff vs threshold)
 *   Stage 4: 180-element signal history update
 *   Stage 5: Temporal Discontinuity detection (7 trio evaluations)
 *   Stage 6: Final decision with hysteresis
 *
 * Binary register mapping (during TD section):
 *   r6 / sp+0x148  = debug pointer
 *   sp+0x14c       = args pointer
 *   sp+0xf4        = dev_info pointer
 *   sp+0x9c        = args pointer (alternate)
 *   d8             = threshold for TD trio comparisons
 *   d9             = SSE mean / current avg diff
 *   d13            = SSE threshold
 *   d15            = time divisor (60.0 for seconds-to-minutes)
 *   sp+0x194       = var_count (uint16_t, TD var element count)
 *   sp+0x196       = total_count (uint16_t, running sum)
 *   sp+0x191       = break_flag_count (uint8_t)
 *   sp+0x192       = trio_flag (uint8_t)
 *   sp+0x193       = trio_count (uint8_t)
 * ──────────────────────────────────────────────────────────────────── */
static void check_err1(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    (void)seq_current;  /* seq_val computed from args->idx */
    (void)glucose_value;

    /*
     * ── STAGE 1: Initialization ──
     *
     * Binary ref: lines ~3500-3520 (combined with the cal_threshold setup)
     *
     * Load device_info thresholds and compute derived values.
     * Initialize debug outputs to safe defaults.
     * Check sequence threshold for early exit.
     */

    /* Load thresholds from device_info */
    uint8_t err1_seq0 = dev_info->err1_seq[0];
    uint8_t err1_seq1 = dev_info->err1_seq[1];
    uint8_t err1_seq2 = dev_info->err1_seq[2];
    double th_diff_devinfo = (double)dev_info->err1_th_diff;
    double th_sse_dmean0 = (double)dev_info->err1_th_sse_dmean[0];
    double th_sse_dmean1 = (double)dev_info->err1_th_sse_dmean[1];
    double th_sse_dmean2 = (double)dev_info->err1_th_sse_dmean[2];
    double current_avg_diff_threshold = (double)dev_info->err1_current_avg_diff;

    /*
     * Initialize output fields that the binary always sets, even
     * when taking the early-exit path (seq below threshold).
     * These are the "gate" fields that downstream detectors read.
     */
    debug->err1_is_contact_bad = 0;
    debug->err1_random_noise_temp_break = 0;
    debug->err1_result = 0;
    debug->error_code1 = 0;

    /*
     * Load sequence value from args->idx.
     * Binary ref: lines ~3904-3912 (0x695a4: ldrsh.w r4, [lr, #0x648])
     * 0x648 is offset of idx in binary's aligned args struct.
     *
     * TODO: Verify idx mapping — binary reads from args+0x648.
     */
    uint16_t seq_val = args->idx;

    /*
     * Variables that must be visible at all labels (final_decision, epilogue).
     * Declared here before any goto targets.
     */
    uint8_t is_contact_bad = 0;
    uint16_t total_breaks = 0;
    uint8_t result_condition_TD0 = 0;
    uint8_t result_condition_TD1 = 0;
    uint16_t n_last_threshold = dev_info->err1_n_last;

    /* Early exit: if seq is below minimum threshold, skip */
    if (seq_val < (uint16_t)err1_seq0) {
        /* Store updated state and return */
        goto epilogue;
    }

    /*
     * ── Main-body debug initialization ──
     *
     * Initialize debug output fields to safe defaults. These are only
     * written when err1 does its full processing (seq >= threshold).
     * The binary does not touch these fields on the early-exit path,
     * so downstream detectors see whatever was already in the debug
     * struct (e.g., values from a previous call).
     */
    debug->err1_i_sse_d_mean = NAN;
    debug->err1_th_sse_d_mean1 = NAN;
    debug->err1_th_sse_d_mean2 = NAN;
    debug->err1_th_sse_d_mean = NAN;
    debug->err1_current_avg_diff = NAN;
    debug->err1_th_diff1 = NAN;
    debug->err1_th_diff2 = NAN;
    debug->err1_th_diff = NAN;
    debug->err1_isfirst0 = args->err1_isfirst0;
    debug->err1_isfirst1 = args->err1_isfirst1;
    debug->err1_isfirst2 = args->err1_isfirst2;
    debug->err1_n = args->err1_n;
    debug->err1_length_t2_max = 0;
    debug->err1_length_t3_max = 0;
    debug->err1_length_t1_trio = 0;
    debug->err1_length_t2_trio = 0;
    debug->err1_length_t3_trio = 0;
    debug->err1_length_t6_trio = 0;
    debug->err1_length_t7_trio = 0;
    debug->err1_length_t8_trio = 0;
    debug->err1_length_t9_trio = 0;
    debug->err1_length_t10_trio = 0;
    debug->err1_result_TD = 0;
    debug->err1_result_condition_TD[0] = 0;
    debug->err1_result_condition_TD[1] = 0;
    debug->err1_TD_count = 0;
    debug->err1_TD_temporary_break_flag = 0;
    memset(debug->err1_TD_time_trio, 0, sizeof(debug->err1_TD_time_trio));
    memset(debug->err1_TD_value_trio, 0, sizeof(debug->err1_TD_value_trio));

    /*
     * ── STAGE 2: SSE Mean Evaluation ──
     *
     * Binary ref: lines ~3500-3700 (0x690b8-0x693b4)
     *
     * The binary calls cal_threshold twice to compute adaptive
     * SSE-difference-mean and current-difference thresholds. This
     * updates args->err1_th_sse_d_mean{1,2}, err1_th_diff{1,2},
     * err1_isfirst{0,1,2}, and err1_n.
     *
     * The SSE computation works on the curr_avg_arr history, computing
     * absolute differences between consecutive elements, then deriving
     * mean and accumulated statistics.
     *
     * We compute the current average difference from the curr_avg_arr
     * using the most recent entries.
     *
     * TODO: The exact SSE computation involves a Hann-window smoothed
     * loop that the binary does at lines 6750-6775. The binary computes
     * abs(arr[i+1] - arr[i]) for 0x598/8 = 179 elements, storing to
     * a temp buffer. This implements a difference-based SSE metric.
     * Exact binary-to-struct mapping needs oracle verification.
     */

    /*
     * Compute absolute-difference array from curr_avg_arr[0..179].
     *
     * Binary ref: lines 6750-6775 (0x6b6ea-0x6b738)
     *   The binary loads from args+0x5b58 area (curr_avg_arr in binary layout),
     *   computes |arr[i+1] - arr[i]| for i = 0..178, stores to temp buffer.
     *   Loop count: 0x598/8 = 179 iterations.
     *
     * TODO: Verify that curr_avg_arr is the correct source array.
     * In our packed struct, curr_avg_arr is at offset 0xf53 while the
     * binary accesses args+0x5b58. The offset difference reflects
     * different struct alignment.
     */
    double abs_diff_buf[180];
    memset(abs_diff_buf, 0, sizeof(abs_diff_buf));

    /* Compute absolute differences of consecutive curr_avg_arr entries */
    for (int i = 0; i < 179; i++) {
        double diff = args->curr_avg_arr[i + 1] - args->curr_avg_arr[i];
        abs_diff_buf[i] = fabs(diff);
    }

    /*
     * ── err1_TD_var_update #1 ──
     *
     * Binary ref: line 6748 (0x6b6dc: bl err1_TD_var_update)
     *
     * Rotates 90-element variance tracking arrays. The first call uses
     * stack arrays as source and destination, corresponding to the
     * "current window" and "previous window" of the TD analysis.
     *
     * In our C model, these stack arrays map to the err1 180-element
     * signal/time/current arrays split into two 90-element halves.
     *
     * We model this by shifting the 180-element histories.
     */

    /* TD var state: use the sequence counts for the var tracking */
    uint16_t var_seq_buf[90];
    double   var_val_buf[90];
    uint32_t var_time_buf[90];
    uint16_t var_seq_buf2[90];
    double   var_val_buf2[90];
    uint32_t var_time_buf2[90];
    uint16_t var_sum1 = 0;
    uint16_t var_sum2 = 0;

    memset(var_seq_buf, 0, sizeof(var_seq_buf));
    memset(var_val_buf, 0, sizeof(var_val_buf));
    memset(var_time_buf, 0, sizeof(var_time_buf));
    memset(var_seq_buf2, 0, sizeof(var_seq_buf2));
    memset(var_val_buf2, 0, sizeof(var_val_buf2));
    memset(var_time_buf2, 0, sizeof(var_time_buf2));

    /* First var_update: copy from "src" (current) to "dest" (previous) */
    err1_TD_var_update(var_seq_buf, var_val_buf, var_time_buf, &var_sum1,
                       var_val_buf2, var_time_buf2, &var_sum2);

    /*
     * ── Absolute-difference accumulation loop ──
     *
     * Binary ref: lines 6750-6775 (0x6b6ea-0x6b73a)
     * The binary loads entries from the curr_avg_arr area (args+0x5b58)
     * and computes absolute differences. It then accumulates a count
     * (stored at sp+0x194) of valid (non-NaN, below-threshold) entries.
     *
     * This determines the "density" of the signal — how many consecutive
     * readings show small changes (good contact) vs large jumps (noise).
     */

    (void)0;  /* var_count (sp+0x194 in binary) used internally by TD processing */

    /*
     * Binary ref: lines 6776-6835 (0x6b73a-0x6b7e2)
     *
     * The binary computes a refined count by iterating over the var arrays
     * and filtering based on multiple criteria:
     *   1. Match sequence indices against a 180-element reference array
     *   2. Check values against threshold (d13 = SSE threshold)
     *   3. Filter NaN entries
     *
     * The result is stored into total_count (sp+0x196).
     */

    /* Compute the current average difference for contact quality check */
    double curr_avg_now = 0.0;
    double curr_avg_prev = args->err1_prev_last_1min_curr;
    uint16_t n_curr = args->err1_n;

    /* Look at the most recent curr_avg_arr entries to compute a difference */
    if (seq_val > 0 && seq_val <= 865) {
        curr_avg_now = args->curr_avg_arr[seq_val - 1];
    }
    double current_avg_diff = fabs(curr_avg_now - curr_avg_prev);

    /*
     * ── cal_threshold calls ──
     *
     * Binary ref: lines ~3540-3568 (0x6914a, 0x69196)
     *
     * Two calls to cal_threshold:
     *   1. For SSE-difference-mean thresholds (mode 1)
     *   2. For current-difference thresholds (mode 0)
     *
     * cal_threshold updates:
     *   - args->err1_n (accumulation count)
     *   - args->err1_th_sse_d_mean / err1_th_diff (threshold values)
     *   - args->err1_isfirst{0,1,2} (initialization flags)
     *
     * The binary passes the abs-diff SSE metric and the current_avg_diff
     * to the two cal_threshold calls respectively.
     */

    /* Compute SSE-like metric: mean of absolute differences */
    double sse_d_mean = 0.0;
    int sse_count = 0;
    for (int i = 0; i < 179; i++) {
        if (!isnan(abs_diff_buf[i]) && abs_diff_buf[i] > 0.0) {
            sse_d_mean += abs_diff_buf[i];
            sse_count++;
        }
    }
    if (sse_count > 0) {
        sse_d_mean /= (double)sse_count;
    }

    /* First cal_threshold call: SSE-difference-mean threshold */
    cal_threshold(&args->err1_n,
                  &args->err1_th_sse_d_mean1,
                  &args->err1_th_diff1,
                  &args->err1_isfirst0,
                  n_curr,
                  1, /* mode = 1 */
                  sse_d_mean,
                  current_avg_diff,
                  args->err1_th_sse_d_mean2,
                  args->err1_th_diff2,
                  dev_info);

    /* Second cal_threshold call: current-diff threshold */
    cal_threshold(&args->err1_n,
                  &args->err1_th_sse_d_mean2,
                  &args->err1_th_diff2,
                  &args->err1_isfirst1,
                  n_curr,
                  0, /* mode = 0 */
                  sse_d_mean,
                  current_avg_diff,
                  args->err1_th_sse_d_mean,
                  args->err1_th_diff,
                  dev_info);

    /* Store intermediate debug results */
    debug->err1_i_sse_d_mean = sse_d_mean;
    debug->err1_current_avg_diff = current_avg_diff;
    debug->err1_th_sse_d_mean1 = args->err1_th_sse_d_mean1;
    debug->err1_th_sse_d_mean2 = args->err1_th_sse_d_mean2;
    debug->err1_th_sse_d_mean = args->err1_th_sse_d_mean;
    debug->err1_th_diff1 = args->err1_th_diff1;
    debug->err1_th_diff2 = args->err1_th_diff2;
    debug->err1_th_diff = args->err1_th_diff;
    debug->err1_isfirst0 = args->err1_isfirst0;
    debug->err1_isfirst1 = args->err1_isfirst1;
    debug->err1_isfirst2 = args->err1_isfirst2;
    debug->err1_n = args->err1_n;

    /*
     * ── STAGE 3: Contact Quality Assessment ──
     *
     * Binary ref: lines 3608-3815 (0x69220-0x69480)
     *
     * Compare SSE mean against multiple thresholds from dev_info:
     *   - err1_th_sse_dmean[0] (at dev_info+0x438 in binary)
     *   - err1_th_sse_dmean[1] (at dev_info+0x440)
     *   - err1_th_sse_dmean[2] (at dev_info+0x448)
     *
     * Compare current_avg_diff against dev_info->err1_current_avg_diff
     * (at dev_info+0x468 in binary).
     *
     * The is_contact_bad flag is set if:
     *   1. SSE mean exceeds thresholds in a specific pattern, AND
     *   2. Current avg diff exceeds its threshold
     *
     * Binary ref: line 3707 (0x69340): strb r0, [r6, #0x7c9]
     *   Stores is_contact_bad to debug struct.
     *
     * TODO: The exact multi-threshold comparison logic from the binary
     * is complex (lines 3608-3700). The thresholds are checked in
     * cascade: if SSE < th0, use config A; elif SSE < th1, use B; etc.
     * Oracle verification will confirm the exact conditions.
     */

    /* Determine the SSE threshold to use based on SSE magnitude */
    double sse_threshold;
    if (sse_d_mean < th_sse_dmean0) {
        sse_threshold = th_sse_dmean0;
    } else if (sse_d_mean < th_sse_dmean1) {
        sse_threshold = th_sse_dmean1;
    } else {
        sse_threshold = th_sse_dmean2;
    }

    /* Check contact quality: current_avg_diff vs threshold */
    if (current_avg_diff > current_avg_diff_threshold) {
        is_contact_bad = 1;
    }

    /*
     * Additional SSE-based contact check:
     *
     * Binary ref: lines 3690-3707 (0x69324-0x69340)
     *   The binary counts how many entries in the is_contact_bad1h[100]
     *   and i_sse_d_mean4h[100] history arrays exceed thresholds, then
     *   sets is_contact_bad if the count exceeds err1_n_consecutive.
     *
     * TODO: Exact counting logic needs oracle verification.
     */
    uint8_t sse_bad_count = 0;
    for (int i = 0; i < 100; i++) {
        if (args->err1_i_sse_d_mean4h[i] > sse_threshold &&
            !isnan(args->err1_i_sse_d_mean4h[i])) {
            sse_bad_count++;
        }
    }

    uint8_t contact_bad_1h_count = 0;
    for (int i = 0; i < 100; i++) {
        if (args->err1_is_contact_bad1h[i] != 0) {
            contact_bad_1h_count++;
        }
    }

    /* Combined contact quality evaluation */
    uint8_t n_consecutive = dev_info->err1_n_consecutive;
    if (sse_bad_count >= n_consecutive) {
        is_contact_bad = 1;
    }

    /*
     * Check SSE against err1_i_sse_dmean_now thresholds:
     *
     * Binary ref: lines ~3638-3650
     * If the current SSE mean exceeds err1_i_sse_dmean_now[0] or [1],
     * this also contributes to contact bad assessment.
     */
    if (sse_d_mean > (double)dev_info->err1_i_sse_dmean_now[0] &&
        sse_d_mean > (double)dev_info->err1_i_sse_dmean_now[1]) {
        if (contact_bad_1h_count >= dev_info->err1_count_sse_dmean) {
            is_contact_bad = 1;
        }
    }

    debug->err1_is_contact_bad = is_contact_bad;

    /*
     * Binary ref: lines 3815-3869 (0x69480-0x6952a)
     * STAGE 3b: Update 100-element history arrays
     *
     * Shift the three 100-element history arrays left by 1:
     *   err1_is_contact_bad1h[100]
     *   err1_i_sse_d_mean4h[100]
     *   err1_current_avg_diff_prev[100]
     *
     * Then append current values to position [99].
     *
     * Binary ref: lines 3816-3832 (0x69484-0x694b2)
     *   Uses interleaved loop copying from args+0x4fc8 / args+0x4c39
     *   which correspond to the packed history arrays.
     */
    memmove(args->err1_is_contact_bad1h,
            args->err1_is_contact_bad1h + 1,
            99 * sizeof(uint8_t));
    args->err1_is_contact_bad1h[99] = is_contact_bad;

    memmove(args->err1_i_sse_d_mean4h,
            args->err1_i_sse_d_mean4h + 1,
            99 * sizeof(double));
    args->err1_i_sse_d_mean4h[99] = sse_d_mean;

    memmove(args->err1_current_avg_diff_prev,
            args->err1_current_avg_diff_prev + 1,
            99 * sizeof(double));
    args->err1_current_avg_diff_prev[99] = current_avg_diff;

    /* Update previous last current value */
    args->err1_prev_last_1min_curr = curr_avg_now;

    /*
     * ── Check for random noise / temporary break ──
     *
     * Binary ref: lines 3812-3815 (0x69478-0x69484)
     *   If all 100 entries in err1_i_sse_d_mean4h exceed the
     *   err1_current_avg_diff threshold from dev_info, then
     *   err1_random_noise_temp_break = 1.
     *
     * This checks if there's a persistent pattern of noise.
     */
    uint8_t all_exceed = 1;
    for (int i = 0; i < 100; i++) {
        double val = args->err1_i_sse_d_mean4h[i];
        if (isnan(val) || val < current_avg_diff_threshold) {
            all_exceed = 0;
            break;
        }
    }
    if (all_exceed && seq_val >= err1_seq1) {
        debug->err1_random_noise_temp_break = 1;
    }

    /*
     * ── STAGE 4: Signal History Update (180-element arrays) ──
     *
     * Binary ref: lines 3839-3869 (0x694b4-0x6952a)
     *
     * Shift err1_SG_1min[180], err1_time_1min[180], err1_inA_1min[180]
     * left by 1 position and append current values.
     *
     * These track 3-hour windows of signal/time/current values.
     *
     * TODO: Verify signal source. The binary copies from
     * debug+0x5a0/0x7b0/0x7c0 areas. We use curr_avg_arr and
     * measurement_time_standard as approximations.
     */
    memmove(args->err1_SG_1min,
            args->err1_SG_1min + 1,
            179 * sizeof(double));
    args->err1_SG_1min[179] = curr_avg_now;

    memmove(args->err1_time_1min,
            args->err1_time_1min + 1,
            179 * sizeof(uint32_t));
    args->err1_time_1min[179] = debug->measurement_time_standard;

    memmove(args->err1_inA_1min,
            args->err1_inA_1min + 1,
            179 * sizeof(double));
    /* inA_1min stores tran_inA_1min[0] from the debug output */
    args->err1_inA_1min[179] = debug->tran_inA_1min[0];

    /*
     * ── Check if enough data for TD processing ──
     *
     * Binary ref: lines 6727-6732 (0x6b69a-0x6b6aa)
     *   r0 = uxth(r10)   ; count
     *   cmp r0, #2
     *   blo 0x69502       ; if count < 2, skip TD section
     *
     * The "count" (total_count / r10 / sp+0x196) represents the number
     * of valid data segments available for TD analysis. If < 2, we
     * cannot compute differences and skip the TD section entirely.
     *
     * We approximate total_count from the number of non-zero time entries.
     */
    uint16_t total_count = 0;
    for (int i = 0; i < 180; i++) {
        if (args->err1_time_1min[i] != 0) {
            total_count++;
        }
    }

    /* Store the count to debug fields before checking */
    debug->err1_n = (uint16_t)total_count;

    if (total_count < 2) {
        /* Not enough data for TD processing */
        goto final_decision;
    }

    /*
     * ════════════════════════════════════════════════════════════════════
     * STAGE 5: Temporal Discontinuity (TD) Detection
     *
     * Binary ref: lines 6733-7997 (0x6b6ae-0x6c5c4)
     *
     * This is the most complex part of err1. It uses 7 independent
     * err1_TD_trio_update calls to evaluate temporal patterns in the
     * signal data. Each trio evaluation checks for "spike" patterns
     * where the middle value differs significantly from its neighbors.
     *
     * The TD processing operates on stack-allocated arrays that mirror
     * the persistent err1_TD_temporary_break_flag_past_range[36] state
     * in the arguments struct.
     *
     * Terminology:
     *   - "trio" = group of 3 consecutive values [prev, current, next]
     *   - "break" = a trio where differences exceed threshold d8
     *   - "TD var" = variance tracking across 90-element windows
     * ════════════════════════════════════════════════════════════════════
     */

    /*
     * ── err1_TD_var_update #1 (line 6748) ──
     *
     * Binary ref: 0x6b6dc: bl err1_TD_var_update
     * Rotates the first set of 90-element variance arrays.
     *
     * The source arrays come from the signal history (SG_1min,
     * time_1min) and the destination arrays are on the stack.
     */

    /* Build working arrays from the 180-element histories */
    double   td_val[180];
    uint32_t td_time[180];
    double   td_inA[180];
    memcpy(td_val,  args->err1_SG_1min,   180 * sizeof(double));
    memcpy(td_time, args->err1_time_1min,  180 * sizeof(uint32_t));
    memcpy(td_inA,  args->err1_inA_1min,   180 * sizeof(double));

    /*
     * ── Absolute-difference smoothing (lines 6750-6775) ──
     *
     * Binary ref: 0x6b6ea-0x6b738
     * The binary computes |val[i+1] - val[i]| for 0x598/8 = 179
     * elements, producing the smoothed difference array.
     *
     * This is already computed above in abs_diff_buf[].
     */

    /*
     * ── Sequence-to-index mapping (lines 6776-6835) ──
     *
     * Binary ref: 0x6b73a-0x6b7e2
     *
     * The binary maps sequence indices into the time array (td_time)
     * to find matching positions. It builds a unique-sorted index array
     * and a count (var_count at sp+0x194, total_count at sp+0x196).
     *
     * This effectively compresses the 180-element window into only
     * the elements that have valid, non-duplicate timestamps.
     */

    /* Build a compressed array of valid entries */
    uint16_t valid_indices[180];
    uint16_t n_valid = 0;
    for (int i = 0; i < 180; i++) {
        if (td_time[i] != 0) {
            valid_indices[n_valid++] = (uint16_t)i;
        }
    }

    /*
     * Binary ref: line 6836 (0x6b7e4)
     *   strb r1, [r6, #0x7f4]
     *
     * Stores the var_count to debug. In our mapping, this corresponds
     * to debug->err1_length_t2_max.
     *
     * TODO: Verify exact debug field mapping with oracle testing.
     */
    debug->err1_length_t2_max = (uint8_t)(n_valid < 255 ? n_valid : 255);

    /* If still < 2 valid entries, skip */
    if (n_valid < 2) {
        goto final_decision;
    }

    /*
     * ── err1_TD_var_update #2 (line 6849) ──
     *
     * Binary ref: 0x6b80e: bl err1_TD_var_update
     * Second rotation of the variance arrays.
     */

    /*
     * ── Build trio arrays for TD evaluation ──
     *
     * Binary ref: lines 6851-6932 (0x6b812-0x6b920)
     *
     * The binary builds arrays of (value, time, inA) triples from the
     * compressed valid entries. These triples are organized into groups
     * of 3 for the trio evaluation.
     *
     * For n valid entries, we get (n-1) consecutive pairs and
     * (n-2) consecutive triples.
     */

    /* Build trio evaluation arrays: differences between consecutive valid points */
    (void)0;  /* n_pairs = (n_valid - 1) implicitly used via n_trios */
    uint16_t n_trios = (n_valid > 2) ? (n_valid - 2) : 0;

    /* Allocate trio value arrays */
    double trio_val[270];   /* max 90 trios * 3 values each */
    uint32_t trio_time[270];
    memset(trio_val, 0, sizeof(trio_val));
    memset(trio_time, 0, sizeof(trio_time));

    uint16_t trio_count = 0;
    if (n_trios > 0 && n_trios <= 90) {
        for (uint16_t i = 0; i < n_trios && i < 90; i++) {
            uint16_t idx0 = valid_indices[i];
            uint16_t idx1 = valid_indices[i + 1];
            uint16_t idx2 = valid_indices[i + 2];

            trio_val[i * 3 + 0] = td_val[idx0];
            trio_val[i * 3 + 1] = td_val[idx1];
            trio_val[i * 3 + 2] = td_val[idx2];

            trio_time[i * 3 + 0] = td_time[idx0];
            trio_time[i * 3 + 1] = td_time[idx1];
            trio_time[i * 3 + 2] = td_time[idx2];
        }
        trio_count = (n_trios < 90) ? n_trios : 90;
    }

    /*
     * ── TD Threshold (d8 in binary) ──
     *
     * Binary ref: line 6999-7000 (constant pool at 0x6b9d0)
     *   .word 0x47ae147b, 0x3f947ae1
     * This encodes the double 0.02 (2^-6 * 1.28 ~= 0.02).
     * Actually: 0x3f947ae147ae147b = 0.02
     *
     * Wait, let me decode: 0x3f94 7ae1 47ae 147b
     * But the pool has: 0x47ae147b (low word), 0x3f947ae1 (high word)
     * So the double is 0x3F947AE147AE147B = 0.02
     *
     * The binary multiplies this by d9 (the SSE mean or current metric)
     * to get the TD threshold d8.
     *
     * Binary ref: line 7001-7005 (0x6b9d8-0x6b9ea)
     *   vldr d16, [pc, #-12]   ; d16 = 0.02
     *   vmul d16, d9, d16      ; d8 = d9 * 0.02
     *
     * TODO: Verify the threshold computation. The exact source of d9
     * at this point depends on the preceding cal_threshold results.
     */
    double td_threshold = sse_d_mean * 0.02;
    if (td_threshold < 0.0001) {
        td_threshold = th_diff_devinfo;
    }

    /*
     * ── Trio Evaluation Loop 1 (pre-update, lines 6998-7060) ──
     *
     * Binary ref: 0x6b9d8-0x6ba9a
     *
     * For each trio (3 consecutive values), check:
     *   |val[2] - val[1]| < threshold  (close values = continuity)
     *   |val[0] - val[1]| < threshold  (consistent pattern)
     *
     * If BOTH differences are below threshold, this trio is "stable" and
     * gets copied into the output array. Otherwise it's filtered out.
     *
     * The surviving trios and a count (trio_count) are passed to
     * err1_TD_trio_update.
     */

    uint8_t trio_flags[90];
    memset(trio_flags, 0, sizeof(trio_flags));

    /* First trio filtering: check for stable trios */
    (void)0;  /* stable_count tracked implicitly */
    for (uint16_t i = 0; i < trio_count; i++) {
        double v0 = trio_val[i * 3 + 0];
        double v1 = trio_val[i * 3 + 1];
        double v2 = trio_val[i * 3 + 2];

        double diff_21 = fabs(v2 - v1);
        double diff_01 = fabs(v0 - v1);

        if (diff_21 < td_threshold && diff_01 < td_threshold) {
            trio_flags[i] = 1;  /* stable trio */
        }
    }

    /*
     * ── err1_TD_trio_update #1 (line 7187) ──
     *
     * Binary ref: 0x6bc2c: bl err1_TD_trio_update
     *
     * The first trio_update call rotates the trio state arrays.
     * Arguments are the stack-allocated trio arrays.
     */

    /* Use the persistent break_flag array from args */
    uint8_t break_flags[36];
    memcpy(break_flags, args->err1_TD_temporary_break_flag_past_range,
           sizeof(break_flags));

    /*
     * ── Trio Evaluation Loops 2-7 ──
     *
     * Binary ref: lines 7187-7823 (0x6bc2c-0x6c3de)
     *
     * The binary performs 7 independent err1_TD_trio_update calls,
     * each with different criteria for what constitutes a "break":
     *
     * Trio update 1 (line 7187): Basic trio evaluation
     *   Checks |val[i-1] - val[i]| > d8 AND |val[i] - val[i+1]| < d8
     *   AND |val[i-1] - val[i+1]| < d8
     *   (spike at position i: differs from before but next returns)
     *
     * Trio update 2 (line 7275): Reversed direction spike
     *   Checks |val[i] - val[i-1]| > d8 AND |val[i+1] - val[i]| > d8
     *   AND both differ but val[i-1] ~= val[i+1]
     *
     * Trio update 3 (line 7372): Time-based evaluation
     *   Checks time differences AND value differences exceed d8
     *   Also checks that times[i] != times[i+1] (not same timestamp)
     *
     * Trio update 4 (line 7488): Additional pattern with time constraint
     *
     * Trio update 5 (line 7593): R-squared quality check
     *   After the trio evaluation, performs fit_simple_regression + f_rsq
     *   If R^2 < threshold, the trio is considered valid
     *
     * Trio update 6 (line 7712): Time-gap based evaluation
     *
     * Trio update 7 (line 7771): Combined absolute-difference check
     *   Checks |val[1] - val[0]| >= threshold AND
     *          |val[1] - val[2]| >= threshold
     *
     * Each evaluation produces:
     *   - A count of "break" events (stored to corresponding debug field)
     *   - Break flag indices (stored to break_flags)
     *   - An updated trio count
     *
     * The debug fields err1_length_t{1-10}_trio record the counts from
     * each evaluation.
     *
     * TODO: The exact criteria for each of the 7 trio evaluations need
     * careful per-instruction verification. The patterns above are
     * reconstructed from the ARM disassembly but may have subtle
     * differences in comparison directions (>, >=, <, <=) and sign
     * handling. Oracle testing will catch discrepancies.
     */

    /* Count various types of temporal discontinuities */
    uint8_t td_break_count1 = 0;  /* spike: middle differs from neighbors */
    uint8_t td_break_count2 = 0;  /* reversed spike */
    uint8_t td_break_count3 = 0;  /* time-based */
    uint8_t td_break_count4 = 0;  /* time-constrained */
    uint8_t td_break_count5 = 0;  /* regression quality */
    uint8_t td_break_count6 = 0;  /* time-gap */
    uint8_t td_break_count7 = 0;  /* absolute difference */

    /* The time divisor (d15) converts timestamp differences to minutes */
    double time_divisor = 60.0;

    /*
     * Trio evaluation 1: Spike detection (middle differs from both neighbors)
     *
     * Binary ref: lines 7193-7215 (0x6bc42-0x6bc8c)
     *   vldr d17, [r9, #-16]   ; val[i-1]
     *   vldr d16, [r9, #-8]    ; val[i]
     *   vsub d17, d17, d16     ; d17 = val[i-1] - val[i]
     *   vcmp d17, d8           ; compare with threshold
     *   ble skip               ; if <= threshold, not a spike
     *   vldr d17, [r9]         ; val[i+1]
     *   vsub d16, d17, d16     ; d16 = val[i+1] - val[i]
     *   vcmp d16, d8
     *   bpl skip               ; if >= threshold, not a return
     *   vldr d16, [r9, #8]     ; val[i+2]
     *   vsub d16, d16, d17     ; d16 = val[i+2] - val[i+1]
     *   vcmp d16, d8
     *   ittt gt                ; if > threshold:
     *     store break index
     *     increment count
     *
     * Pattern: val[i-1] significantly > val[i], val[i+1] returns close to
     * val[i-1], val[i+2] continues the trend => spike at val[i].
     */
    for (uint16_t i = 0; i + 2 < trio_count; i++) {
        double v0 = trio_val[i * 3 + 0];
        double v1 = trio_val[i * 3 + 1];
        double v2 = trio_val[i * 3 + 2];

        /* Check for spike pattern: v0-v1 > th, v1-v2 < -th (opposite sign) */
        if ((v0 - v1) > td_threshold &&
            (v2 - v1) > td_threshold &&
            fabs(v2 - v0) > td_threshold) {
            td_break_count1++;
        }
    }

    /*
     * Trio evaluation 2: Time-differentiated discontinuity
     *
     * Binary ref: lines 7275-7313 (0x6bd3a-0x6bdba)
     *   Uses trio values AND time arrays. Checks that:
     *   |val[i] - val[i+1]| > threshold AND
     *   |val[i+1] - val[i+2]| > abs(threshold) (with sign check) AND
     *   time[i] != time[i+1] (different measurement times)
     */
    for (uint16_t i = 1; i < trio_count; i++) {
        double v0 = trio_val[i * 3 + 0];  /* prev */
        double v1 = trio_val[i * 3 + 1];  /* current */
        double v2 = trio_val[i * 3 + 2];  /* next */

        double d01 = v0 - v1;
        double d12 = v1 - v2;

        if (d01 > td_threshold) {
            if (fabs(d12) > td_threshold) {
                double d02 = v2 - v0;
                if (d02 > td_threshold) {
                    uint32_t t0 = trio_time[i * 3 + 0];
                    uint32_t t1 = trio_time[i * 3 + 1];
                    if (t0 != t1) {
                        td_break_count2++;
                    }
                }
            }
        }
    }

    /*
     * Trio evaluation 3: Time-gap equal pattern
     *
     * Binary ref: lines 7372-7388 (0x6be6a-0x6be98)
     *   Checks time[i] == time[i+1] (same timestamp entries) and
     *   if so, marks as a break.
     */
    for (uint16_t i = 0; i < trio_count; i++) {
        uint32_t t0 = trio_time[i * 3 + 0];
        uint32_t t1 = trio_time[i * 3 + 1];
        if (t0 == t1 && t0 != 0) {
            td_break_count3++;
        }
    }

    /*
     * Trio evaluation 4: Combined regression analysis
     *
     * Binary ref: lines 7488-7569 (0x6bfba-0x6c0ba)
     *
     * This evaluation uses fit_simple_regression + f_rsq to check
     * the quality of the trio fits. For each group of 3 consecutive
     * trios, fit a regression line. If R^2 is below a threshold
     * (loaded from stack constant at sp+0x180), the group has poor
     * linearity and indicates a discontinuity.
     *
     * Binary ref: lines 7527-7538 (0x6c038-0x6c050)
     *   bl fit_simple_regression  ; fit line to 3 points
     *   bl f_rsq                  ; compute R^2
     *   vldr d16, [sp, #384]      ; load R^2 threshold
     *   vcmp d0, d16              ; compare R^2 vs threshold
     *   bpl skip                  ; if R^2 >= threshold, skip
     *
     * The R^2 threshold is loaded from sp+0x180, which is a stack
     * variable set earlier (TODO: determine exact value).
     */
    double rsq_threshold = 0.5;  /* TODO: Verify R^2 threshold from binary */

    if (trio_count >= 3) {
        /* Prepare arrays for regression on trio midpoints */
        double reg_x[3];
        double reg_y[3];
        double reg_result[2];  /* [slope, intercept] */

        for (uint16_t i = 0; i + 2 < trio_count; i++) {
            /* Use 3 consecutive trio midpoints */
            for (int j = 0; j < 3; j++) {
                uint32_t t = trio_time[(i + j) * 3 + 1];
                uint32_t t_base = trio_time[i * 3 + 1];
                reg_x[j] = (double)(t - t_base) / time_divisor;
                reg_y[j] = trio_val[(i + j) * 3 + 1];
            }

            fit_simple_regression(reg_x, reg_y, 3, reg_result);
            double rsq = f_rsq(reg_result, reg_y, reg_x, 3);

            if (!isnan(rsq) && rsq < rsq_threshold) {
                td_break_count4++;
            }
        }
    }

    /*
     * Trio evaluation 5: Time-normalized difference
     *
     * Binary ref: lines 7593-7666 (0x6c0bc-0x6c1f0)
     *
     * Checks time differences normalized by 60 seconds. If the
     * time gap between entries exceeds a threshold (20.1 from the
     * constant pool at 0x6c4c0: 0x40341999 9999999a = 20.1),
     * the pair is considered a break.
     *
     * Also checks if consecutive time entries are identical and
     * the gap to the next is > 20.1 minutes.
     */
    double time_gap_threshold = 20.1;  /* From constant pool at 0x6c4c0 */

    for (uint16_t i = 0; i + 1 < trio_count; i++) {
        uint32_t t0 = trio_time[i * 3 + 1];
        uint32_t t1 = trio_time[i * 3 + 2];
        uint32_t t2 = trio_time[(i + 1) * 3 + 2];

        if (t1 == t2 && t1 != 0) {
            double gap = (double)(t2 - t0) / time_divisor;
            if (gap < time_gap_threshold) {
                td_break_count5++;
            }
        }
    }

    /*
     * Trio evaluation 6: Large absolute difference
     *
     * Binary ref: lines 7771-7822 (0x6c332-0x6c3dc)
     *
     * Checks |val[1] - val[0]| >= threshold AND |val[1] - val[2]| >= threshold.
     * Uses a different threshold from sp+0x17c (another constant).
     *
     * The threshold is loaded from sp+0x178 (constant pool at sp+376):
     * Decoded as d19 in the binary.
     *
     * TODO: Determine exact threshold value.
     */
    double td_threshold_large = td_threshold * 5.0;
    /* TODO: Verify multiplier with oracle testing */

    for (uint16_t i = 0; i < trio_count; i++) {
        double v0 = trio_val[i * 3 + 0];
        double v1 = trio_val[i * 3 + 1];
        double v2 = trio_val[i * 3 + 2];

        double d10 = fabs(v1 - v0);
        double d12 = fabs(v1 - v2);

        if (d10 >= td_threshold_large && d12 >= td_threshold_large) {
            td_break_count6++;
        }
    }

    /*
     * Trio evaluation 7: Sorted break-flag deduplication
     *
     * Binary ref: lines 7823-7909 (0x6c3de-0x6c4d4)
     *
     * The binary performs a bubble-sort of the break indices collected
     * from all previous trio evaluations (stored in a 90-element
     * uint8_t array). Then it deduplicates and builds a final list
     * of unique break positions.
     *
     * This is used for the final TD count and the regression-based
     * quality check on the unique break positions.
     *
     * The output count (r8 at line 7913) is stored to debug->err1_result_TD.
     */

    /* Combine all break counts */
    total_breaks = (uint16_t)(td_break_count1 + td_break_count2 +
                              td_break_count3 + td_break_count4 +
                              td_break_count5 + td_break_count6 +
                              td_break_count7);

    /* Store individual trio counts to debug */
    debug->err1_length_t1_trio = td_break_count1;
    debug->err1_length_t2_trio = td_break_count2;
    debug->err1_length_t3_trio = td_break_count3;
    debug->err1_length_t6_trio = td_break_count4;
    debug->err1_length_t7_trio = td_break_count5;
    debug->err1_length_t8_trio = td_break_count6;
    debug->err1_length_t9_trio = td_break_count7;
    debug->err1_length_t3_max = (uint8_t)(total_breaks < 255 ? total_breaks : 255);

    /* Store combined result TD */
    uint8_t result_TD = (total_breaks > 0) ? 1 : 0;
    debug->err1_result_TD = result_TD;
    debug->err1_TD_count = total_breaks;

    /*
     * ── Final TD value/time trio storage ──
     *
     * Binary ref: lines 7910-7932 (0x6c4d6-0x6c51c)
     *
     * If result_TD != 0, the binary stores the last trio's values
     * and times into debug->err1_TD_value_trio[3] and
     * debug->err1_TD_time_trio[3]. These represent the most recent
     * temporal discontinuity found.
     */
    if (result_TD && trio_count > 0) {
        uint16_t last_trio = trio_count - 1;
        for (int j = 0; j < 3; j++) {
            debug->err1_TD_time_trio[j] = trio_time[last_trio * 3 + j];
            debug->err1_TD_value_trio[j] = trio_val[last_trio * 3 + j];
        }
    }

    /*
     * ── STAGE 5b: Update persistent TD state ──
     *
     * Binary ref: lines 7935-7942 (0x6c51e-0x6c530)
     *
     * Update err1_sum_result_condition_TD (args->err1_sum_result_condition_TD)
     * and err1_any_result_condition_TD.
     *
     * The binary checks dev_info->err1_n_last against the total breaks
     * count and updates the condition flags.
     *
     * Binary ref: lines 7935-7942 (0x6c51e-0x6c530)
     *   ldr r0, [sp, #0xf4]           ; dev_info
     *   ldrh r0, [r0, #0x4bc]         ; err1_n_last
     *   cmp r0, r10                    ; compare n_last vs total breaks
     *   blo ...                        ; if n_last < breaks, condition met
     *   ldr r0, [sp, #0x9c]           ; args
     *   ldrb r0, [r0, #0xe3c]         ; err1_result_prev
     *   cmp r0, #0                     ; if prev_result == 0
     *   beq skip                       ; skip if no previous error
     */
    uint8_t td_condition = 0;

    if (total_breaks > n_last_threshold) {
        td_condition = 1;
    } else if (args->err1_result_prev != 0) {
        td_condition = 1;
    }

    /*
     * Binary ref: lines 7943-7970 (0x6c532-0x6c580)
     *
     * Additional conditions based on n_last threshold comparisons:
     *   If total_breaks == n_last AND prev_result:
     *     Check break_flag history (36-element array)
     *     Sum break flags; if sum < err1_th_n1[2], condition = 1
     *
     *   If total_breaks <= 4 AND prev_result == 1:
     *     Check break_flag_past_range[36] sum against threshold
     *     err1_result_condition_TD[0] = (sum < threshold) ? 1 : 0
     *
     *   If total_breaks > n_last:
     *     err1_sum_result_condition_TD += 1
     *     If sum_result >= 2: err1_any_result_condition_TD = 1
     */
    if (td_condition) {
        /* Check the break flag history */
        uint16_t break_flag_sum = 0;
        for (int i = 0; i < 36; i++) {
            break_flag_sum += args->err1_TD_temporary_break_flag_past_range[i];
        }

        uint8_t th_n1_val = dev_info->err1_th_n1[2];
        if (break_flag_sum < th_n1_val) {
            result_condition_TD0 = 1;
        }

        /*
         * Check with n_last exact match
         *
         * Binary ref: lines 7943-7949 (0x6c532-0x6c544)
         */
        if (total_breaks == n_last_threshold && args->err1_result_prev != 0) {
            result_condition_TD1 = 1;
        }
    }

    /*
     * Binary ref: lines 7951-7973 (0x6c548-0x6c580)
     *
     * If total_breaks <= 4 AND prev_result == 1:
     *   Iterate through break_flag_past_range, summing all bytes (36 entries)
     *   Compare sum against dev_info->err1_th_n1[2]
     *   If sum < threshold: set result_condition_TD[1] = 1
     *
     * If total_breaks > err1_n_last:
     *   Store 0x101 (257) to err1_sum_result_condition_TD
     */
    if (total_breaks <= 4 && args->err1_result_prev == 1) {
        uint16_t flag_sum = 0;
        for (int i = 0; i < 36; i++) {
            flag_sum += args->err1_TD_temporary_break_flag_past_range[i];
        }
        if (flag_sum < dev_info->err1_th_n1[2]) {
            result_condition_TD1 = 1;
        }
    }

    if (total_breaks > n_last_threshold) {
        args->err1_sum_result_condition_TD += 1;
        if (args->err1_sum_result_condition_TD >= 2) {
            args->err1_any_result_condition_TD = 1;
        }
    }

    debug->err1_result_condition_TD[0] = result_condition_TD0;
    debug->err1_result_condition_TD[1] = result_condition_TD1;

    /*
     * ── Update break flag history ──
     *
     * Binary ref: lines 6860-6868 (shift pattern for TD_temporary_break_flag_past_range)
     *
     * Shift the 36-element break flag array left by 1 and append
     * the current break status.
     */
    memmove(args->err1_TD_temporary_break_flag_past_range,
            args->err1_TD_temporary_break_flag_past_range + 1,
            35 * sizeof(uint8_t));
    args->err1_TD_temporary_break_flag_past_range[35] =
        (total_breaks > 0) ? 1 : 0;

    debug->err1_TD_temporary_break_flag = (total_breaks > 0) ? 1 : 0;

    /*
     * ════════════════════════════════════════════════════════════════════
     * STAGE 6: Final Decision
     *
     * Binary ref: lines 7983-7997 (0x6c59c-0x6c5c4)
     *
     * The final error code is determined by combining:
     *   1. Contact quality (is_contact_bad)
     *   2. TD results (result_TD, result_condition_TD)
     *   3. Hysteresis from err1_result_prev
     *
     * Binary decision logic (0x6c59c-0x6c5b8):
     *   If is_contact_bad == 1 AND
     *      (result_condition_TD[0] == 1 OR result_condition_TD[1] == 1
     *       OR total_breaks > n_last):
     *     error_code1 = 1
     *     is_contact_bad = 1 (confirm in debug)
     *     sum_result_condition_TD += 1
     *     if (sum_result >= 2): err1_any_result_condition_TD = 1
     *   Else if prev_result == 1 AND seq_val >= err1_seq[2]:
     *     error_code1 = 1  (hysteresis: latch previous error)
     *   Else:
     *     error_code1 = 0
     *
     * Binary ref: line 7986 (0x6c5a0): strb r0, [r6, #0x7f0]
     *   Stores final error_code1 to debug->error_code1.
     *
     * TODO: The exact condition evaluation order may differ from the
     * binary. Oracle testing will validate the final decision logic.
     * ════════════════════════════════════════════════════════════════════
     */

final_decision:
    ;  /* C requires a statement after label */

    uint8_t final_result = 0;

    if (is_contact_bad) {
        /* Contact is bad — check if TD conditions also indicate error */
        if (result_condition_TD0 || result_condition_TD1 ||
            total_breaks > n_last_threshold) {
            final_result = 1;
        }
    }

    /* Hysteresis: if previous result was 1, latch unless conditions clear */
    if (args->err1_result_prev == 1 && seq_val >= err1_seq2) {
        if (args->err1_sum_result_condition_TD >= 2) {
            final_result = 1;
        }
    }

    debug->error_code1 = final_result;
    debug->err1_result = final_result;

    /*
     * ── EPILOGUE: Update persistent state ──
     *
     * Binary ref: lines 7986-7994 (0x6c5a0-0x6c5b8)
     *
     * Store final result to args for next iteration's hysteresis.
     * Update err1_any_result_condition_TD if conditions met.
     */
epilogue:
    args->err1_result_prev = debug->error_code1;

    /* Store updated debug state */
    debug->err1_is_contact_bad = is_contact_bad;
}

/* ────────────────────────────────────────────────────────────────────
 * err2: Rate-of-change detector
 *
 * From check_error.asm lines ~3870-5515 (address 0x6952e-0x6a924).
 * ~900 instructions, fourth detector in pipeline.
 *
 * Detects unrealistic rates of glucose change using 575-element
 * delay buffers, trimmed means, cumulative maximums, and multiple
 * condition evaluation.
 *
 * Algorithm phases:
 *   1. Initialize debug outputs
 *   2. Compute rate-of-change (ROC) and slope from signal history
 *   3. Build working buffers and compute trimmed means for ROC,
 *      slope, and glucose metrics
 *   4. Compute cumulative maximums and evaluate conditions
 *   5. Evaluate final flag and conditions (delay_condi, delay_flag)
 *   6. Compute cummax foretime and final err2 conditions
 *   7. Buffer rotation (shift 575-element arrays left by 1)
 *   8. Store results (error_code2, update prev state)
 *
 * Binary register mapping:
 *   r6 / sp+0x148 = debug pointer
 *   sp+0x14c      = args pointer
 *   sp+0xf4       = dev_info pointer
 *   sp+0x18c      = seq_current (lr in some phases)
 *   sp+0xa4       = pointer to args->err2_delay_condi_prev
 *   sp+0xd4       = pointer to args->err2_delay_pre_condi_prev area
 *   sp+0xa8       = pointer to debug->err2_delay_roc area (r10)
 *   r9            = stack buffer for working data
 *   d15           = time divisor (from dev_info)
 *   d8, d9, d11   = ROC, slope, glucose values
 *   d10, d12, d13 = cummax / threshold intermediates
 * ──────────────────────────────────────────────────────────────────── */
static void check_err2(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value)
{
    (void)seq_current;  /* seq_val computed from args->idx */

    /*
     * Binary ref: lines 3870-3903 (0x6952e-0x695a4)
     * STAGE 1: Initialize debug output fields
     *
     * The binary initializes:
     *   - High words of debug doubles to NaN pattern (0x7ff80000)
     *   - Low words to 0
     * For bytes, stores 0.
     *
     * debug+0x808..0x84c covers err2_delay_roc through err2_delay_glu_trimmed_mean
     * plus err2_delay_pre_condi, err2_delay_condi, err2_delay_flag, err2_cummax
     *
     * Lines 3881-3889: stores NaN high word (0x7ff8xxxx) to debug+0x80c,
     *   0x814, 0x81c, 0x824, 0x82c, 0x834, 0x83c, 0x844, 0x84c, 0x85c
     * Lines 3894-3903: stores 0 to debug+0x808, 0x810, 0x818, 0x820,
     *   0x828, 0x830, 0x838, 0x840, 0x848, 0x858
     *
     * In our struct, these correspond to the err2 debug fields.
     * We initialize all err2 debug outputs to safe defaults.
     */
    debug->err2_delay_revised_value = NAN;
    debug->err2_delay_roc = NAN;
    debug->err2_delay_slope_sharp = NAN;
    debug->err2_delay_roc_cummax = NAN;
    debug->err2_delay_roc_trimmed_mean = NAN;
    debug->err2_delay_slope_cummax = NAN;
    debug->err2_delay_slope_trimmed_mean = NAN;
    debug->err2_delay_glu_cummax = NAN;
    debug->err2_delay_glu_trimmed_mean = NAN;
    debug->err2_delay_pre_condi[0] = 0;
    debug->err2_delay_pre_condi[1] = 0;
    debug->err2_delay_pre_condi[2] = 0;
    debug->err2_delay_condi[0] = 0;
    debug->err2_delay_condi[1] = 0;
    debug->err2_delay_condi[2] = 0;
    debug->err2_delay_flag = 0;
    debug->err2_cummax = NAN;
    debug->err2_crt_current[0] = 0;
    debug->err2_crt_current[1] = 0;
    debug->err2_crt_glu[0] = 0;
    debug->err2_crt_glu[1] = 0;
    debug->err2_crt_cv = NAN;
    debug->err2_condi[0] = 0;
    debug->err2_condi[1] = 0;
    debug->error_code2 = 0;

    /*
     * Binary ref: lines 3904-3912 (0x695a4-0x695c0)
     * STAGE 2: Load sequence from args and check against dev_info threshold
     *
     * r4 = args->idx (signed, loaded from args+0x648 at 0x695a4)
     * lr = (uint16_t)r4 (seq for this context, stored at sp+0x18c)
     * r0 = dev_info->err2_start_seq (dev_info+0x502)
     * r11 = (int16_t)r0
     *
     * If r4 <= r11: skip main computation, branch to 0x69614
     */
    int16_t seq_idx = (int16_t)args->idx;  /* TODO: Verify mapping with oracle */
    uint16_t seq_val = (uint16_t)seq_idx;

    uint16_t err2_start = dev_info->err2_start_seq;

    if (seq_idx <= (int16_t)err2_start) {
        /*
         * Binary ref: lines 3939-3945 (0x69614-0x69628)
         * Early path: seq below threshold. Jump to main loop at 0x6996e
         * with d11=0.0 (glucose_value placeholder), d8/d9 uninitialized
         * but will be set in the main convergence point.
         *
         * This skips the ROC computation and goes directly to the
         * trimmed mean / buffer rotation phase.
         */
        goto phase_trimmed_mean;
    }

    /*
     * Binary ref: lines 3913-3938 (0x695c2-0x69612)
     * STAGE 3: Iterate through glucose/ROC buffer
     *
     * Computes ROC values from the glucose value buffer and stores
     * them into a working buffer on the stack (r9).
     *
     * The loop at 0x695e4 iterates through glucose values stored in
     * the args struct (at args+0x4bf0 area, which is within
     * err2_delay_glucosevalue_prev), comparing against a threshold
     * from dev_info+0x550 (err2_cv area).
     *
     * Values >= threshold are stored to the working buffer; values
     * below are stored as {0, NaN}.
     *
     * r8 counts valid entries; r4 counts valid entries with good values.
     *
     * After the loop completes or if condition met, falls through to
     * 0x6962a (ROC computation).
     */

    /*
     * Binary ref: lines 3946-3968 (0x6962a-0x69692)
     * STAGE 4: Compute rate of change (ROC) and slope
     *
     * At 0x6962a:
     *   r0 = dev_info (from sp+0xf4)
     *   r2 = 0x11f (= 287)
     *   r3 = debug (from sp+0x148)
     *   r10 = (uint8_t)r8
     *
     * Load dev_info+0x500 (err2_start_seq), compute index:
     *   r2 = 0x11f - dev_info->err2_start_seq
     *   Load float from args[r2] area (at offset 0x1c8 from lr)
     *   Convert to double -> d16
     *
     * Load float from debug+0x4 area -> d10
     *   d16 = d10 - d16 (signal difference)
     *   d16 = d16 / d15 (divide by time base)
     *
     * Compare d16 against dev_info+0x508 threshold (d17)
     *   If d16 > d17: d8 = NaN (set from literal pool)
     *   Else: compute slope from buffer entries
     *
     * The ROC is the change in glucose divided by the time base.
     * The slope is computed from a pair of working buffer entries.
     *
     * Store d8 (slope) to debug+0x808 -> debug->err2_delay_slope_sharp
     *
     * TODO: Verify mapping of args float array offsets and dev_info+0x508
     */
    {
        /* Compute ROC from signal difference divided by time base */
        uint16_t start = dev_info->err2_start_seq;
        uint16_t buf_idx = (uint16_t)(287 - start);

        /* Load time divisor from dev_info err2_cv area */
        /* TODO: Verify mapping — dev_info+0x508 is 6 bytes past err2_seq[3] */
        double time_div = (double)dev_info->err2_cv[0];
        if (time_div == 0.0) time_div = 1.0;  /* Guard against div-by-zero */

        /* The signal difference comes from glucose buffer values */
        double sig_current = glucose_value;
        double sig_prev = 0.0;
        if (buf_idx < 575) {
            sig_prev = args->err2_delay_glucosevalue_prev[buf_idx];
        }
        double roc = (sig_current - sig_prev) / time_div;

        /* Check against threshold */
        double roc_thresh = (double)dev_info->err2_cv[1];  /* TODO: Verify mapping with oracle */
        double d8_slope;  /* slope_sharp */
        double d9_roc;    /* roc */
        double d11_glu;   /* glucose value for delay */

        if (roc > roc_thresh) {
            d8_slope = NAN;
            d9_roc = NAN;
            d11_glu = glucose_value;
        } else {
            /*
             * Binary ref: lines 3966-3976 (0x69670-0x69696)
             * Compute slope from adjacent buffer entries:
             *   r0 = r10 - 1
             *   d17 = working_buf[r0]
             *   d18 = working_buf[r0 - start]
             *   d17 = d17 - d18
             *   d8 = d17 / d16  (slope = value_diff / roc)
             *
             * Then store d8 to debug+0x808
             */
            d9_roc = roc;
            d11_glu = glucose_value;

            /* Simplified slope computation */
            /* TODO: Verify exact buffer index computation with oracle */
            if (seq_val > 0 && seq_val > start) {
                uint16_t idx_a = seq_val - 1;
                uint16_t idx_b = idx_a - start;
                double val_a = 0.0, val_b = 0.0;
                if (idx_a < 575)
                    val_a = args->err2_delay_glucosevalue_prev[idx_a];
                if (idx_b < 575)
                    val_b = args->err2_delay_glucosevalue_prev[idx_b];
                double val_diff = val_a - val_b;
                if (roc != 0.0)
                    d8_slope = val_diff / roc;
                else
                    d8_slope = NAN;
            } else {
                d8_slope = NAN;
            }
        }

        /*
         * Binary ref: lines 3976-4040 (0x69696-0x6976c)
         * STAGE 5: Fill working buffer and run regression
         *
         * Build integer sequence 1..r10 in working buffer.
         * Clear a second buffer to zero.
         *
         * Compute d11 * 0.5, round it, compare against r4 (uint8_t).
         * If rounded(d11 * 0.5) >= 0 (bpl): skip regression, go to 0x69790
         * Else:
         *   Call fit_simple_regression with the working buffers
         *   Store slope to debug+0x810 (err2_delay_roc)
         *   d8 = result from debug+0x808 (err2_delay_slope_sharp)
         *
         * At 0x69790-0x6979e: restore pointers, branch to convergence.
         *
         * Convergence at 0x6979e:
         *   Load d11 from working_buf[r10-1] (glucose from r9 buffer)
         *
         * Then check lr (err2_delay_condi_prev):
         *   If lr == 1: take absolute values of d9, d8
         *   Else if prev_condi_prev == 1: load d8,d9,d0 from
         *     pre_condi_prev area
         *   Else: compute abs + fmax for d8, d9
         *
         * The key outputs stored are:
         *   debug->err2_delay_roc = d9
         *   debug->err2_delay_slope_sharp = d8
         *   debug->err2_delay_revised_value = d0 (glucose)
         *
         * Then at 0x69954-0x6996a:
         *   Store d0 to debug+0x840 (err2_delay_glu_cummax area)
         *   Store d9 to debug+0x830 (err2_delay_slope_cummax area)
         *   Store d8 to debug+0x820 (err2_delay_roc_cummax area)
         */

        /*
         * Check condition: previous delay condition
         * Binary at 0x697a2: cmp lr, #1 (lr = err2_delay_condi_prev value)
         */
        uint8_t condi_prev = args->err2_delay_condi_prev;

        if (condi_prev == 1) {
            /* Take absolute values */
            if (d9_roc < 0.0) d9_roc = -d9_roc;
            if (d8_slope < 0.0) d8_slope = -d8_slope;
        } else {
            /*
             * Binary ref: lines 4070-4079 (0x697da-0x697f4)
             * Check args->err2_delay_pre_condi_prev[0]
             * If == 1: load d8, d9, d0 from pre_condi_prev data area
             *   (args->err2_delay_roc_cummax_prev etc.)
             *
             * Otherwise (0x698ca): compute abs values with fmax against
             * cummax prev values, calling fmax (blx r4 at 0x698fa etc.)
             */
            uint8_t pre_condi_0 = args->err2_delay_pre_condi_prev[0];
            if (pre_condi_0 == 1) {
                /* Load cached values from previous state */
                d8_slope = args->err2_delay_roc_cummax_prev;
                d9_roc = args->err2_delay_slope_cummax_prev;
                d11_glu = args->err2_delay_glu_cummax_prev;
                /* TODO: Verify mapping — disasm loads from sp+0xd4 + offsets */
            } else {
                /*
                 * Binary ref: lines 4147-4194 (0x698ca-0x6996a)
                 * Compute absolute values and fmax against previous cummaxes
                 *
                 * |d8| = abs(d8_slope)
                 * call fmax(|d8|, prev_roc_cummax) -> d8
                 *
                 * |d9| = abs(d9_roc)
                 * call fmax(|d9|, prev_slope_cummax) -> d9
                 *
                 * call fmax(d11_glu, prev_glu_cummax) -> d0
                 *
                 * Then store to debug fields at 0x69954-0x6996a.
                 */
                double abs_slope = fabs(d8_slope);
                double abs_roc = fabs(d9_roc);

                /* Cummax: max of current absolute value and previous cummax */
                double prev_roc_cm = args->err2_delay_roc_cummax_prev;
                double prev_slope_cm = args->err2_delay_slope_cummax_prev;
                double prev_glu_cm = args->err2_delay_glu_cummax_prev;

                d8_slope = fmax(abs_slope, prev_roc_cm);
                d9_roc = fmax(abs_roc, prev_slope_cm);
                d11_glu = fmax(glucose_value, prev_glu_cm);
            }
        }

        /* Store ROC values to debug */
        debug->err2_delay_revised_value = d11_glu;
        debug->err2_delay_slope_sharp = d9_roc;
        debug->err2_delay_roc = d8_slope;

        /*
         * Binary ref: lines 4189-4194 (0x69954-0x6996a)
         * Store cummax-related values:
         *   debug+0x840 = d0 (glu cummax)
         *   debug+0x830 = d9 (slope cummax)
         *   debug+0x820 = d8 (roc cummax)
         */
        debug->err2_delay_roc_cummax = d8_slope;
        debug->err2_delay_slope_cummax = d9_roc;
        debug->err2_delay_glu_cummax = d11_glu;
    }

phase_trimmed_mean:
    /*
     * Binary ref: lines 4195-4200 (0x6996e-0x6997e)
     * STAGE 6: Check sequence against dev_info threshold
     *
     * Load dev_info+0x506 (err2_seq[2]) as r5/r11.
     * Compare signed lr (seq) against signed r11.
     * If seq <= r11: skip to 0x69eb4 (buffer rotation).
     */
    ;
    {
        uint16_t err2_seq2 = dev_info->err2_seq[2];
        int16_t signed_seq = (int16_t)seq_val;
        int16_t signed_th = (int16_t)err2_seq2;

        if (signed_seq <= signed_th) {
            goto phase_buffer_rotation;
        }
    }

    /*
     * Binary ref: lines 4201-4232 (0x69982-0x699e2)
     * STAGE 7: Clear working buffer, prepare for trimmed mean #1 (ROC)
     *
     * Clear 0x11f8 bytes on stack (the working buffer).
     * Load args->err2_delay_flag_prev offset and args->err2_delay_roc_prev offset.
     * Compute loop bounds from dev_info->err2_seq[1] and err2_seq[2].
     *
     * Loop from i=0 to (err2_seq2 - err2_seq1):
     *   If err2_delay_flag_prev[i] != 0: skip (only count unflagged entries)
     *   Else: load err2_delay_roc_prev[i], compute |value|, store to buffer
     *   Increment valid count
     *
     * After loop: check if err2_seq2 * 0.5 > valid_count
     *   If so: skip trimmed mean (not enough data)
     *   Else: call f_trimmed_mean(buffer, count, 5)
     *   Store result to debug+0x828 (err2_delay_roc_trimmed_mean)
     */
    {
        uint16_t seq1 = dev_info->err2_seq[0];  /* TODO: Verify mapping with oracle */
        uint16_t seq2 = dev_info->err2_seq[2];
        int range = (int)seq2 - (int)seq1;

        /* --- Trimmed mean #1: ROC values --- */
        double work_buf[575];
        uint16_t valid_count = 0;

        for (int i = 0; i <= range && i < 575; i++) {
            if (args->err2_delay_flag_prev[i] != 0)
                continue;
            double val = args->err2_delay_roc_prev[i];
            /* Compute absolute value */
            if (val < 0.0) val = -val;
            if (valid_count < 575) {
                work_buf[valid_count] = val;
                valid_count++;
            }
        }

        /* Check data sufficiency: seq2 * 0.5 must be <= valid_count */
        double half_seq = (double)seq2 * 0.5;
        double half_rounded = math_round(half_seq);
        if (half_rounded <= (double)valid_count && valid_count > 0) {
            debug->err2_delay_roc_trimmed_mean =
                f_trimmed_mean(work_buf, valid_count, 5);
        }

        /*
         * Binary ref: lines 4255-4299 (0x69a30-0x69abe)
         * STAGE 8: Trimmed mean #2 (slope)
         *
         * Same pattern: iterate delay_flag_prev, load delay_slope_sharp_prev,
         * compute abs, collect into buffer, then f_trimmed_mean.
         * Store result to debug+0x838 (err2_delay_slope_trimmed_mean).
         */
        valid_count = 0;
        for (int i = 0; i <= range && i < 575; i++) {
            if (args->err2_delay_flag_prev[i] != 0)
                continue;
            double val = args->err2_delay_slope_sharp_prev[i];
            if (val < 0.0) val = -val;
            if (valid_count < 575) {
                work_buf[valid_count] = val;
                valid_count++;
            }
        }

        half_seq = (double)seq2 * 0.5;
        if (math_round(half_seq) <= (double)valid_count && valid_count > 0) {
            debug->err2_delay_slope_trimmed_mean =
                f_trimmed_mean(work_buf, valid_count, 5);
        }

        /*
         * Binary ref: lines 4303-4350 (0x69aca-0x69b62)
         * STAGE 9: Trimmed mean #3 (glucose)
         *
         * Same pattern with delay_glucosevalue_prev.
         * Store result to debug+0x848 (err2_delay_glu_trimmed_mean).
         *
         * After this, check if seq2 * 0.5 > count (using d9 from prev count):
         *   If so: skip to buffer rotation (0x69eb4).
         */
        valid_count = 0;
        for (int i = 0; i <= range && i < 575; i++) {
            if (args->err2_delay_flag_prev[i] != 0)
                continue;
            double val = args->err2_delay_glucosevalue_prev[i];
            if (val < 0.0) val = -val;
            if (valid_count < 575) {
                work_buf[valid_count] = val;
                valid_count++;
            }
        }

        double glu_half = (double)seq2 * 0.5;
        double glu_count_d = (double)valid_count;
        if (math_round(glu_half) > glu_count_d) {
            goto phase_buffer_rotation;
        }
        if (valid_count > 0) {
            debug->err2_delay_glu_trimmed_mean =
                f_trimmed_mean(work_buf, valid_count, 5);
        }

        /*
         * Binary ref: lines 4355-4422 (0x69b72-0x69c5e)
         * STAGE 10: Cummax computation and condition evaluation
         *
         * Build pairs for cummax:
         *   pair1 = (roc_trimmed * dev_info->err2_cv[2], roc_cummax)
         *     -> call fmax -> new roc cummax
         *   pair2 = (slope_trimmed * dev_info->err2_cv[3], slope_cummax)
         *     -> call fmax -> new slope cummax
         *   pair3 = (glu_trimmed * dev_info->err2_cv[4], glu_cummax)
         *     -> call fmax -> new glu cummax
         *
         * The binary loads factors from dev_info+0x518, +0x528, +0x540
         * which correspond to threshold fields.
         *
         * After cummax update, evaluate conditions:
         *
         * At 0x69c42: Check if d8 (debug+0x808 = slope_sharp value) is NaN
         *   If NaN: branch to NaN handler at 0x6c5da
         *
         * At 0x69c4e: d17 = roc_cummax * d13 (factor from dev_info)
         *   Compare d16 (slope value) >= d17
         *   If so: set debug->err2_delay_pre_condi[0] = 1 (debug+0x860)
         *
         * At 0x69c60: Compare d11 (glucose) > dev_info+0x550 threshold
         *   If so AND prev condition: set debug+0x860 = 1
         *
         * TODO: Verify factor field mappings (dev_info+0x518, 0x528, 0x540)
         */
        double roc_tm = debug->err2_delay_roc_trimmed_mean;
        double slope_tm = debug->err2_delay_slope_trimmed_mean;
        double glu_tm = debug->err2_delay_glu_trimmed_mean;

        /* Load cummax factors from dev_info */
        /* dev_info+0x518 area -> near err2_cv[2] */
        /* TODO: Verify mapping with oracle */
        double roc_factor = (double)dev_info->err2_cv[2];
        double slope_factor = roc_factor;  /* TODO: Verify separate factor */

        /* Compute cummax pairs using fmax */
        double roc_cm_new = isnan(roc_tm) ? debug->err2_delay_roc_cummax :
            fmax(roc_tm * roc_factor, debug->err2_delay_roc_cummax);
        double slope_cm_new = isnan(slope_tm) ? debug->err2_delay_slope_cummax :
            fmax(slope_tm * slope_factor, debug->err2_delay_slope_cummax);
        double glu_cm_new = isnan(glu_tm) ? debug->err2_delay_glu_cummax :
            fmax(glu_tm, debug->err2_delay_glu_cummax);

        debug->err2_delay_roc_cummax = roc_cm_new;
        debug->err2_delay_slope_cummax = slope_cm_new;
        debug->err2_delay_glu_cummax = glu_cm_new;

        /*
         * Binary ref: lines 4415-4432 (0x69c42-0x69c7c)
         * STAGE 11: Pre-condition evaluation
         *
         * Check debug+0x808 (err2_delay_slope_sharp / d8) for NaN.
         *   If NaN -> handler sets condition and branches back
         *
         * d17 = roc_cummax * d13 (factor)
         * If d16 (slope) >= d17: set err2_delay_pre_condi[0] = 1
         *
         * Also: check d11 (glucose) > dev_info+0x550 (err2_glu threshold)
         *   If both conditions true: set err2_delay_pre_condi[0] = 1
         */
        double slope_val = debug->err2_delay_slope_sharp;
        double glu_val = debug->err2_delay_revised_value;

        if (!isnan(slope_val)) {
            double roc_cm = debug->err2_delay_roc_cummax;
            /* TODO: Verify factor from dev_info */
            double factor = (double)dev_info->err2_alpha;  /* TODO: Verify mapping with oracle */
            double thresh = roc_cm * factor;

            if (slope_val >= thresh) {
                /* Also check glucose against threshold */
                double glu_thresh = (double)dev_info->err2_glu;
                if (glu_val > glu_thresh) {
                    debug->err2_delay_pre_condi[0] = 1;
                }
            }
        }

        /*
         * Binary ref: lines 4432-4444 (0x69c7c-0x69ca8)
         * STAGE 12: Pre-condition[1] (slope cummax check)
         *
         * Load debug+0x810 (err2_delay_roc = d8 in binary context)
         * Check for NaN -> handler
         * d16 = slope_cummax_new * d15 (another factor)
         * If d8 >= d16: set err2_delay_pre_condi[1] = 1
         */
        double roc_val = debug->err2_delay_roc;
        if (!isnan(roc_val)) {
            double slope_cm = debug->err2_delay_slope_cummax;
            /* TODO: Verify factor mapping with oracle */
            double factor2 = (double)dev_info->err2_alpha;  /* TODO: Verify */
            double thresh2 = slope_cm * factor2;

            if (roc_val >= thresh2) {
                debug->err2_delay_pre_condi[1] = 1;
            }
        }

        /*
         * Binary ref: lines 4445-4457 (0x69ca8-0x69cce)
         * STAGE 13: Pre-condition[2] via fun_comp_decimals
         *
         * Load dev_info+0x538 threshold (err2_ycept area)
         * Call fun_comp_decimals(d8, threshold, 10, 3) -> mode 3 = ge
         * If result != 0: set err2_delay_pre_condi[2] = 1
         */
        {
            double thresh_val = (double)dev_info->err2_ycept;  /* TODO: Verify mapping with oracle */
            if (!isnan(roc_val)) {
                uint8_t cmp_result = fun_comp_decimals(roc_val, thresh_val, 10, 3);
                if (cmp_result != 0) {
                    debug->err2_delay_pre_condi[2] = 1;
                }
            }
        }

        /*
         * Binary ref: lines 4458-4492 (0x69cd0-0x69d2c)
         * STAGE 14: Previous condition override
         *
         * If seq >= 2 AND delay_pre_condi_prev[i] == 1:
         *   Check sign of d8 (roc_val):
         *   If d8 >= 0: force err2_delay_pre_condi[i] = 1
         *   Else: force err2_delay_pre_condi[i] = 0
         *
         * This is done for all 3 pre_condi indices.
         */
        if (seq_val >= 2) {
            for (int i = 0; i < 3; i++) {
                if (args->err2_delay_pre_condi_prev[i] == 1) {
                    if (!isnan(roc_val) && roc_val >= 0.0) {
                        debug->err2_delay_pre_condi[i] = 1;
                    } else {
                        debug->err2_delay_pre_condi[i] = 0;
                    }
                }
            }
        }

        /*
         * Binary ref: lines 4493-4536 (0x69d30-0x69dac)
         * STAGE 15: Combine conditions into delay_condi and delay_flag
         *
         * debug->err2_delay_condi[0]:
         *   If pre_condi[0] == 1 AND pre_condi[2] == 1: condi[0] = 1
         *   Store at debug+0x7fd
         *
         * debug->err2_delay_condi[1]:
         *   If pre_condi[1] == 1 AND pre_condi[2] == 1: condi[1] = 1
         *   Store at debug+0x7fe
         *
         * Compute delay_flag (debug+0x7ff):
         *   If d12 (glu cummax) is not NaN:
         *     d16 = d9 (slope_cummax) * d16 (factor from sp+0x180)
         *     If d11 (glucose) >= d16: delay_flag = 1
         *   Else: delay_flag from existing
         *
         * Then combine:
         *   If condi[0] AND delay_flag: set debug->err2_delay_flag = 1
         *   Else if condi[1] AND delay_flag: set debug->err2_delay_flag = 1
         */
        uint8_t pre0 = debug->err2_delay_pre_condi[0];
        uint8_t pre1 = debug->err2_delay_pre_condi[1];
        uint8_t pre2 = debug->err2_delay_pre_condi[2];

        if (pre0 == 1 && pre2 == 1)
            debug->err2_delay_condi[0] = 1;
        if (pre1 == 1 && pre2 == 1)
            debug->err2_delay_condi[1] = 1;

        /*
         * Delay flag computation from cummax check
         * Binary ref: lines 4512-4536 (0x69d60-0x69dac)
         *
         * Check d12 (glu cummax) for NaN. If NaN: skip.
         * d16 = d9 * factor (slope_trimmed * threshold)
         * If glucose >= d16: delay_flag_val = 1
         *
         * Then final: if (condi[0] && delay_flag) || (condi[1] && delay_flag):
         *   set debug->err2_delay_flag = 1
         */
        uint8_t delay_flag_val = 0;

        if (!isnan(debug->err2_delay_glu_cummax)) {
            /* TODO: Verify factor from dev_info */
            double slope_cm = debug->err2_delay_slope_cummax;
            /* TODO: Verify factor source (dev_info+0x528+8 area) */
            double glu_factor = (double)dev_info->err2_alpha;  /* TODO: Verify mapping with oracle */
            double glu_thresh_val = slope_cm * glu_factor;

            if (glu_val >= glu_thresh_val) {
                delay_flag_val = 1;
            }
        }

        /* Store delay_flag_val to debug->err2_delay_condi[2] area */
        debug->err2_delay_condi[2] = delay_flag_val;

        /* Final flag: combine condi[0|1] with delay_flag_val */
        uint8_t condi0 = debug->err2_delay_condi[0];
        uint8_t condi1 = debug->err2_delay_condi[1];
        uint8_t condi2 = debug->err2_delay_condi[2];

        if ((condi0 == 1 && condi2 == 1) || (condi1 == 1 && condi2 == 1)) {
            debug->err2_delay_flag = 1;
        }
    }

    /*
     * Binary ref: lines 4537-4549 (0x69dac-0x69dd4)
     * STAGE 16: Revised value update
     *
     * If delay_condi_prev != 0:
     *   Load revised_value from args->err2_delay_revised_value_prev
     *   If not NaN: use it as d11 (glucose)
     *   Store to debug+0x818 (err2_delay_revised_value)
     *
     * Else (delay_condi_prev == 0):
     *   Store d11 to debug+0x818
     *   Then load previous cummax values from args and store to debug
     */
    {
        uint8_t condi_prev_flag = args->err2_delay_condi_prev;

        if (condi_prev_flag != 0) {
            double prev_revised = args->err2_delay_revised_value_prev;
            if (!isnan(prev_revised)) {
                debug->err2_delay_revised_value = prev_revised;
            }
            /* Also update cummax values from prev state */
            /* debug->err2_delay_roc_cummax already set above */
        } else {
            /* Store current glucose to revised value */
            debug->err2_delay_revised_value = glucose_value;
            /* Load prev cummax values into debug */
            debug->err2_delay_roc_cummax = args->err2_delay_roc_cummax_prev;
            debug->err2_delay_slope_cummax = args->err2_delay_slope_cummax_prev;
            debug->err2_delay_glu_cummax = args->err2_delay_glu_cummax_prev;
        }
    }

phase_buffer_rotation:
    /*
     * Binary ref: lines 4630-4660 (0x69eb4-0x69f18)
     * STAGE 17: Buffer rotation for 575-element delay arrays
     *
     * Three arrays are shifted left by 1 element:
     *   1. err2_delay_flag_prev[575] (bytes)
     *   2. err2_delay_roc_prev[575] (doubles)
     *   3. err2_delay_slope_sharp_prev[575] (doubles)
     *
     * Binary pattern for each (lines 4631-4654):
     *   r0 = args + flag_offset + 0x611b (for flag_prev)
     *   r1 = args + roc_offset + 0x6360 (for roc_prev)
     *   r2 = args + slope_offset + 0x8758 (for slope_prev)
     *   r3 = 0xfffffdc2 = -574 (loop counter)
     *
     *   Loop while r3 != 0:
     *     flag_prev[r3 + 0x23e] -> flag_prev[r3 + 0x23d]  (shift left by 1)
     *     roc_prev[r1+8] -> roc_prev[r1]                   (shift left by 1)
     *     slope_prev gets similar treatment
     *     r3++
     *
     * After rotation, store current values at end:
     *   flag_prev[574] = debug->err2_delay_flag
     *   roc_prev[574] = debug->err2_delay_roc (from debug+0x808)
     *   slope_prev[574] = debug->err2_delay_slope_sharp
     *   glucosevalue_prev[574] = debug->err2_delay_revised_value
     *
     * Also store pre_condi values and revised_value to args prev arrays.
     */
    memmove(args->err2_delay_flag_prev,
            args->err2_delay_flag_prev + 1,
            574 * sizeof(uint8_t));
    args->err2_delay_flag_prev[574] = debug->err2_delay_flag;

    memmove(args->err2_delay_roc_prev,
            args->err2_delay_roc_prev + 1,
            574 * sizeof(double));
    args->err2_delay_roc_prev[574] = debug->err2_delay_roc;

    memmove(args->err2_delay_slope_sharp_prev,
            args->err2_delay_slope_sharp_prev + 1,
            574 * sizeof(double));
    args->err2_delay_slope_sharp_prev[574] = debug->err2_delay_slope_sharp;

    /* Also rotate glucose value delay array */
    memmove(args->err2_delay_glucosevalue_prev,
            args->err2_delay_glucosevalue_prev + 1,
            574 * sizeof(double));
    args->err2_delay_glucosevalue_prev[574] = debug->err2_delay_revised_value;

    /*
     * Binary ref: lines 4661-4699 (0x69f18-0x69f9e)
     * STAGE 18: Store results to args prev state
     *
     * Copy debug->err2_delay_flag to args->err2_delay_condi_prev
     * Copy debug->err2_delay_roc to args roc prev
     * Copy debug->err2_delay_slope_sharp to args slope prev
     *
     * Store cummax values:
     *   args->err2_delay_roc_cummax_prev = debug->err2_delay_roc_cummax
     *     (but check against threshold: if < dev_info+0x550, set to NaN)
     *   args->err2_delay_slope_cummax_prev = debug->err2_delay_slope_cummax
     *   args->err2_delay_glu_cummax_prev = debug->err2_delay_glu_cummax
     *
     * Copy pre_condi[0..2] to args->err2_delay_pre_condi_prev[0..2]
     * Copy revised_value to args->err2_delay_revised_value_prev
     */
    args->err2_delay_condi_prev = debug->err2_delay_flag;

    /* Store cummax values to args prev, with threshold check */
    {
        double roc_cm = debug->err2_delay_roc_cummax;
        double glu_thresh = (double)dev_info->err2_glu;  /* TODO: Verify mapping with oracle */

        /*
         * Binary ref: 0x69f4e-0x69f64
         * Compare err2_delay_roc_cummax against threshold:
         *   If roc_cm < threshold: set to NaN
         */
        if (!isnan(roc_cm) && roc_cm < glu_thresh) {
            roc_cm = NAN;
        }
        args->err2_delay_roc_cummax_prev = roc_cm;
    }

    args->err2_delay_slope_cummax_prev = debug->err2_delay_slope_cummax;
    args->err2_delay_glu_cummax_prev = debug->err2_delay_glu_cummax;

    /* Store pre_condi to args */
    args->err2_delay_pre_condi_prev[0] = debug->err2_delay_pre_condi[0];
    args->err2_delay_pre_condi_prev[1] = debug->err2_delay_pre_condi[1];
    args->err2_delay_pre_condi_prev[2] = debug->err2_delay_pre_condi[2];

    args->err2_delay_revised_value_prev = debug->err2_delay_revised_value;

    /*
     * Binary ref: lines 4703-4840 (0x69fae-0x6a14a)
     * STAGE 19: err2_cummax foretime computation
     *
     * This section computes the cummax over a sliding window and
     * evaluates final conditions for err2.
     *
     * First: compare seq against dev_info->err2_start_seq + offset
     *   (dev_info+0x4d6 area)
     * If seq > threshold:
     *   Check accu_seq entries in a range for valid count
     *   Build working buffers from cummax_foretime array
     *   Validate entries against threshold
     *   Set debug->err2_condi[0] and err2_condi[1]
     *
     * Then: shift err2_cummax_foretime[100] left by 1
     *   Store current cummax at end
     *
     * Binary at 0x6a14a-0x6a17e:
     *   Initialize NaN into args cummax area
     *   Shift err2_cummax_foretime left by 0x63 (99) entries
     *   Store current err2_cummax at end
     *
     * Then store err2_result_prev from debug->err2_delay_flag (or err2_condi)
     */

    /*
     * Shift err2_cummax_foretime left by 1, store NaN default
     */
    args->err2_cummax = NAN;

    memmove(args->err2_cummax_foretime,
            args->err2_cummax_foretime + 1,
            99 * sizeof(double));
    args->err2_cummax_foretime[99] = NAN;

    /*
     * Store final err2 result
     * Binary at 0x6a176-0x6a17e:
     *   Load debug->err2_delay_flag (or combined result from err2_condi)
     *   Store to args->err2_result_prev
     */
    args->err2_result_prev = debug->err2_delay_flag;

    /*
     * Binary ref: 0x6a17e+ continues into err2_cummax foretime
     * rotation and then err4.
     *
     * Store error_code2 = debug->err2_delay_flag
     * (The error code is the delay flag result)
     */
    debug->error_code2 = debug->err2_delay_flag;
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
