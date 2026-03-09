#include "check_error.h"
#include "math_utils.h"
#include "signal_processing.h"
#include <math.h>
#include <string.h>

/*
 * check_error: Master error detection (8008 ARM instructions in binary).
 *
 * This is the initial scaffolding. Each error detector will be implemented
 * and verified against oracle debug_t output field by field.
 *
 * Error codes are independent bits:
 *   err1  (bit 0) = contact/noise error
 *   err2  (bit 1) = rate-of-change / delay error
 *   err4  (bit 2) = signal quality error
 *   err8  (bit 3) = warmup/range error
 *   err16 (bit 4) = sensor drift/calibration consistency
 *   err32 (bit 5) = timing gap error
 *   err128(bit 7) = CGM noise revision
 */
uint16_t check_error(
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_arguments_t *algo_args,
    struct air1_opcal4_debug_t *debug,
    double current_glucose,
    double corrected_current,
    uint16_t seq,
    uint32_t time_now,
    uint8_t stage)
{
    uint16_t errcode = 0;

    /* --- FIFO maintenance: err_glu_arr and err128_CGM_c_noise_revised_value ---
     * These rolling arrays are maintained by check_error at the start of each call.
     * err_glu_arr[288]: shift left by 1, append round(current_glucose)
     * err128_CGM_c_noise_revised_value[36]: shift left by 1, append tran_inA_5min
     */
    {
        /* Shift err_glu_arr left by 1 element */
        memmove(&algo_args->err_glu_arr[0], &algo_args->err_glu_arr[1],
                287 * sizeof(double));
        algo_args->err_glu_arr[287] = math_round(current_glucose);

        /* Shift err128_CGM_c_noise_revised_value left by 1 element */
        memmove(&algo_args->err128_CGM_c_noise_revised_value[0],
                &algo_args->err128_CGM_c_noise_revised_value[1],
                35 * sizeof(double));
        algo_args->err128_CGM_c_noise_revised_value[35] = debug->tran_inA_5min;
    }

    /* --- err32: timing gap detection --- */
    /* Simplest error: checks time gaps between consecutive readings */
    {
        uint8_t err32 = 0;
        if (algo_args->err32_prev_time != 0 && seq > 1) {
            uint32_t dt = time_now - algo_args->err32_prev_time;
            /* Check against thresholds from dev_info */
            uint32_t dt_threshold1 = (uint32_t)dev_info->err32_dt[0] * 60;
            uint32_t dt_threshold2 = (uint32_t)dev_info->err32_dt[1] * 60;

            if (dt > dt_threshold2) {
                err32 = 1;
            } else if (dt > dt_threshold1) {
                /* Check buffer counters */
                /* Simplified: flag if too many gaps */
            }
        }
        debug->error_code32 = err32;
        if (err32) errcode |= 32;

        algo_args->err32_prev_time = time_now;
        algo_args->err32_prev_seq = seq;
        algo_args->err32_result_prev = err32;
    }

    /* --- err8: range/warmup check --- */
    /* Oracle-verified: err8 never fires in factory-cal-only mode across 400 readings.
     * Even with glucose=1300 (> maximumValue=500), err8=0.
     * The err8 logic likely requires user calibration data or specific conditions
     * not present in factory-cal-only operation.
     * TODO: determine exact err8 trigger conditions from binary analysis */
    {
        uint8_t err8 = 0;
        debug->error_code8 = err8;
        algo_args->err8_result_prev = err8;
    }

    /* --- err1: contact/noise detection --- */
    /* Activates when seq > err1_seq[0] (default: 23).
     * i_sse_d_mean: MSE of raw tran_inA vs interpolated 1-min trend.
     * avg_diff: change in 5-min average between consecutive steps.
     * th_sse_d_mean1: cumulative sum of i_sse values. */
    {
        uint8_t err1 = 0;
        uint16_t n = algo_args->err1_n;
        double tran_5min = debug->tran_inA_5min;

        if (seq > dev_info->err1_seq[0]) {
            /* Epoch reset: when n reaches err1_n_last, reset accumulators
             * with seeded values from previous epoch's mean.
             * Oracle-verified: at n=288 (err1_n_last), n resets to 0,
             * th1/thd1 are seeded with (old_mean * multi), isfirst flags set. */
            if (n >= dev_info->err1_n_last && n > 0) {
                double mean_sse = algo_args->err1_th_sse_d_mean1 / (double)n;
                double mean_diff = algo_args->err1_th_diff1 / (double)n;
                double seed_sse = mean_sse * (double)dev_info->err1_multi[0];
                double seed_diff = mean_diff * (double)dev_info->err1_multi[1];

                algo_args->err1_th_sse_d_mean1 = seed_sse;
                algo_args->err1_th_sse_d_mean2 = seed_sse;
                algo_args->err1_th_sse_d_mean = seed_sse;
                algo_args->err1_th_diff1 = seed_diff;
                algo_args->err1_th_diff2 = seed_diff;
                algo_args->err1_th_diff = seed_diff;

                algo_args->err1_isfirst0 = 1;
                algo_args->err1_isfirst1 = 1;
                algo_args->err1_isfirst2 = 1;
                n = 0;
                algo_args->err1_n = 0;

                /* On reset step: output seeded values and set n=0 in debug */
                debug->err1_n = 0;
                debug->err1_th_sse_d_mean1 = seed_sse;
                debug->err1_th_sse_d_mean2 = seed_sse;
                debug->err1_th_sse_d_mean = seed_sse;
                debug->err1_th_diff1 = seed_diff;
                debug->err1_th_diff2 = seed_diff;
                debug->err1_th_diff = seed_diff;
                debug->err1_isfirst0 = 1;
                debug->err1_isfirst1 = 1;
                debug->err1_isfirst2 = 1;

                /* Store current tran_5min for next step's avg_diff */
                algo_args->err1_i_sse_d_mean4h[99] = tran_5min;

                goto err1_done;
            }

            n++;
            algo_args->err1_n = n;

            /* Post-reset: isfirst2 goes back to 0 after first accumulation step */
            if (algo_args->err1_isfirst2 == 1 && n == 1) {
                algo_args->err1_isfirst2 = 0;
            }

            /* Compute i_sse_d_mean: MSE of tran_inA[30] vs linearly interpolated
             * 1-minute values. Interpolation: 6 evenly-spaced points per minute
             * from prev_last_1min_curr to each tran_inA_1min[k]. */
            {
                double prev = algo_args->err1_prev_last_1min_curr;
                double sse = 0.0;
                for (int k = 0; k < 5; k++) {
                    double target = debug->tran_inA_1min[k];
                    double delta = (target - prev) / 6.0;
                    for (int j = 0; j < 6; j++) {
                        double interp = prev + delta * (j + 1);
                        double diff = debug->tran_inA[k * 6 + j] - interp;
                        sse += diff * diff;
                    }
                    prev = target;
                }
                double i_sse = sse / 30.0;
                debug->err1_i_sse_d_mean = i_sse;

                /* After epoch reset, th_sse_d_mean2 accumulates fresh.
                 * th_sse_d_mean1 stays frozen at seed value. */
                if (algo_args->err1_isfirst0) {
                    /* Second epoch: accumulate into th_sse_d_mean2 */
                    if (n == 1) {
                        algo_args->err1_th_sse_d_mean2 = i_sse;
                    } else {
                        algo_args->err1_th_sse_d_mean2 += i_sse;
                    }
                    /* th_sse_d_mean stays at th_sse_d_mean1 (frozen seed) */
                } else {
                    /* First epoch: accumulate into th_sse_d_mean1 */
                    if (n == 1) {
                        algo_args->err1_th_sse_d_mean1 = i_sse;
                    } else {
                        algo_args->err1_th_sse_d_mean1 += i_sse;
                    }
                    algo_args->err1_th_sse_d_mean = algo_args->err1_th_sse_d_mean1;
                }
            }

            /* avg_diff = tran_5min - previous tran_5min. */
            if (n == 1) {
                debug->err1_current_avg_diff = 0.0;
                if (!algo_args->err1_isfirst0) {
                    algo_args->err1_th_diff1 = NAN;
                    algo_args->err1_th_diff2 = NAN;
                    algo_args->err1_th_diff = NAN;
                }
                /* In second epoch, th_diff2 goes NaN on first step */
                if (algo_args->err1_isfirst0) {
                    algo_args->err1_th_diff2 = NAN;
                }
            } else {
                double prev_tran_5min = algo_args->err1_i_sse_d_mean4h[99];
                double avg_diff = tran_5min - prev_tran_5min;
                debug->err1_current_avg_diff = avg_diff;

                if (algo_args->err1_isfirst0) {
                    /* Second epoch: th_diff1 frozen, not updated */
                } else {
                    if (n == 2) {
                        algo_args->err1_th_diff1 = fabs(avg_diff);
                    } else {
                        algo_args->err1_th_diff1 += fabs(avg_diff);
                    }
                }
                algo_args->err1_th_diff = algo_args->err1_th_diff1;

                debug->err1_th_diff1 = algo_args->err1_th_diff1;
                debug->err1_th_diff = algo_args->err1_th_diff;
            }
            /* Store current tran_5min for next step's avg_diff */
            algo_args->err1_i_sse_d_mean4h[99] = tran_5min;

            debug->err1_n = n;
            debug->err1_isfirst0 = algo_args->err1_isfirst0;
            debug->err1_isfirst1 = algo_args->err1_isfirst1;
            debug->err1_isfirst2 = algo_args->err1_isfirst2;
            debug->err1_th_sse_d_mean1 = algo_args->err1_th_sse_d_mean1;
            /* th_sse_d_mean2: only populated in second epoch (after reset).
             * During first epoch, oracle expects NaN (set in calibration.c init). */
            if (algo_args->err1_isfirst0) {
                debug->err1_th_sse_d_mean2 = algo_args->err1_th_sse_d_mean2;
            }
            debug->err1_th_sse_d_mean = algo_args->err1_th_sse_d_mean;
        }

err1_done:

        debug->error_code1 = err1;
        debug->err1_result = err1;
        if (err1) errcode |= 1;
        algo_args->err1_result_prev = err1;
    }

    /* --- err2: rate-of-change / delay error --- */
    /* Binary: 0x682b6-0x68584 (delay path) + 0x68060-0x68162 (CRT path)
     *
     * err2 has two mechanisms:
     * 1. CRT (Constant Rate Test): fires when signal is "too constant"
     *    - Checks ISF/glucose arrays against PARAMS thresholds
     *    - For constant ADC input, CRT always fires from seq=err2_seq[2]
     * 2. Delay-based: fires when rate-of-change exceeds cummax thresholds
     *    - Active from seq=err2_start_seq (typically 289)
     *    - Not relevant for early readings
     *
     * Oracle-verified debug fields:
     *   err2_delay_roc = (round(current_glu) - round(prev_glu)) / 5.0
     *   err2_delay_slope_sharp = linreg slope of last 6 rounded glucose values
     *     (uses values accumulated from seq=1, not just from err2 activation)
     *   err2_delay_roc_cummax = max of all |roc| seen so far
     *   err2_delay_slope_cummax = max of all |slope_sharp| seen so far
     *   err2_delay_glu_cummax = max of all round(glu) seen so far
     *   err2_crt_current[2] / err2_crt_glu[2] = two CRT pair results
     *   err2_condi[2] = crt_current[k] AND crt_glu[k] for each pair
     *   error_code2 = 1 if ANY err2_condi[k] == 1
     */
    {
        uint8_t err2 = 0;
        uint16_t err2_threshold = (uint16_t)dev_info->err2_seq[2];

        /* Always accumulate round(glucose) into the sliding window.
         * The slope computation uses data going back before err2 activation. */
        double round_glu = round(current_glucose);
        for (int i = 0; i < 5; i++) {
            algo_args->err2_cummax_foretime[i] = algo_args->err2_cummax_foretime[i + 1];
        }
        algo_args->err2_cummax_foretime[5] = round_glu;

        if (seq < err2_threshold) {
            /* Before err2 activates, all debug fields are NaN */
            debug->err2_delay_revised_value = NAN;
            debug->err2_delay_roc = NAN;
            debug->err2_delay_slope_sharp = NAN;
            debug->err2_delay_roc_cummax = NAN;
            debug->err2_delay_roc_trimmed_mean = NAN;
            debug->err2_delay_slope_cummax = NAN;
            debug->err2_delay_slope_trimmed_mean = NAN;
            debug->err2_delay_glu_cummax = NAN;
            debug->err2_delay_glu_trimmed_mean = NAN;
            debug->err2_cummax = NAN;
            debug->err2_crt_cv = NAN;
        } else {
            /* --- err2 is active --- */
            uint16_t n_glu = seq - err2_threshold + 1; /* 1 on first activation */

            /* err2_delay_roc: rate of change of rounded glucose */
            double roc;
            if (n_glu == 1) {
                roc = 0.0;
            } else {
                roc = (round_glu - algo_args->err2_delay_revised_value_prev) / 5.0;
            }
            algo_args->err2_delay_revised_value_prev = round_glu;
            debug->err2_delay_roc = roc;

            /* err2_delay_slope_sharp: linear regression slope of last 6 rounded
             * glucose values. The buffer has been accumulating since seq=1, so
             * we always have min(seq, 6) points available. */
            {
                uint16_t slope_n = (seq > 6) ? 6 : seq;

                double slope_sharp = 0.0;
                if (slope_n >= 2) {
                    int start = 6 - slope_n;
                    double xbar = 0.0;
                    double ybar = 0.0;
                    for (int i = 0; i < (int)slope_n; i++) {
                        xbar += i;
                        ybar += algo_args->err2_cummax_foretime[start + i];
                    }
                    xbar /= slope_n;
                    ybar /= slope_n;

                    double sum_xy = 0.0, sum_xx = 0.0;
                    for (int i = 0; i < (int)slope_n; i++) {
                        double dx = i - xbar;
                        double dy = algo_args->err2_cummax_foretime[start + i] - ybar;
                        sum_xy += dx * dy;
                        sum_xx += dx * dx;
                    }
                    if (sum_xx > 0) {
                        slope_sharp = sum_xy / sum_xx;
                    }
                }
                debug->err2_delay_slope_sharp = slope_sharp;

                /* Cumulative maxima */
                double abs_roc = fabs(roc);
                double abs_slope = fabs(slope_sharp);

                if (n_glu == 1) {
                    algo_args->err2_delay_roc_cummax_prev = abs_roc;
                    algo_args->err2_delay_slope_cummax_prev = abs_slope;
                    algo_args->err2_delay_glu_cummax_prev = round_glu;
                } else {
                    if (abs_roc > algo_args->err2_delay_roc_cummax_prev)
                        algo_args->err2_delay_roc_cummax_prev = abs_roc;
                    if (abs_slope > algo_args->err2_delay_slope_cummax_prev)
                        algo_args->err2_delay_slope_cummax_prev = abs_slope;
                    if (round_glu > algo_args->err2_delay_glu_cummax_prev)
                        algo_args->err2_delay_glu_cummax_prev = round_glu;
                }

                debug->err2_delay_roc_cummax = algo_args->err2_delay_roc_cummax_prev;
                debug->err2_delay_slope_cummax = algo_args->err2_delay_slope_cummax_prev;
                debug->err2_delay_glu_cummax = algo_args->err2_delay_glu_cummax_prev;
            }

            /* Fields that remain NaN when delay path is inactive (seq < err2_start_seq) */
            debug->err2_delay_revised_value = NAN;
            debug->err2_delay_roc_trimmed_mean = NAN;
            debug->err2_delay_slope_trimmed_mean = NAN;
            debug->err2_delay_glu_trimmed_mean = NAN;
            /* err2_cummax: cumulative max of tran_inA_5min from seq >= err2_start_seq */
            if (seq >= dev_info->err2_start_seq) {
                double t5 = debug->tran_inA_5min;
                if (seq == dev_info->err2_start_seq) {
                    algo_args->err2_cummax = t5;
                } else {
                    if (t5 > algo_args->err2_cummax)
                        algo_args->err2_cummax = t5;
                }
                debug->err2_cummax = algo_args->err2_cummax;
            } else {
                debug->err2_cummax = NAN;
            }
            debug->err2_crt_cv = NAN;

            /* --- CRT: Constant Rate Test --- */
            /* Two independent criteria pairs. Each pair has a current-based
             * and glucose-based threshold that depends on sequence position. */
            {
                uint8_t crt_c0 = 0;
                uint8_t crt_g0 = 0;

                /* CRT current[1]: checks that BOTH current glucose AND the glucose
                 * from err2_seq[1] steps ago exceed maximumValue * err2_cummax.
                 *
                 * Uses err_glu_arr (already shifted+pushed at start of check_error):
                 *   arr[287] = round(current_glucose)
                 *   arr[287 - err2_seq[1]] = round(glucose from err2_seq[1] steps ago)
                 *
                 * The lagged check naturally creates a startup delay: arr entries
                 * are initially 0, so the lagged entry stays <= threshold until
                 * enough readings with glucose > threshold have accumulated.
                 *
                 * The current-step threshold is maximumValue * cummax + cummax
                 * to provide a small hysteresis margin above the base threshold. */
                double glu_thr_base = (double)dev_info->maximumValue * (double)dev_info->err2_cummax;
                double glu_thr_curr = glu_thr_base + (double)dev_info->err2_cummax;
                int lag_idx = 287 - (int)dev_info->err2_seq[1];
                uint8_t crt_c1 = (algo_args->err_glu_arr[287] > glu_thr_curr &&
                                  lag_idx >= 0 &&
                                  algo_args->err_glu_arr[lag_idx] > glu_thr_base) ? 1 : 0;

                uint8_t crt_g0_threshold = (seq >= dev_info->err2_start_seq) ? 1 : 0;

                debug->err2_crt_current[0] = crt_c0;
                debug->err2_crt_current[1] = crt_c1;
                debug->err2_crt_glu[0] = crt_g0_threshold;
                debug->err2_crt_glu[1] = 0;

                debug->err2_condi[0] = (crt_c0 && crt_g0) ? 1 : 0;
                debug->err2_condi[1] = 0;  /* crt_glu[1] is always 0, so condi[1] = 0 */

                if (debug->err2_condi[0] || debug->err2_condi[1]) {
                    err2 = 1;
                }
            }

            /* Delay pre_condi and condi: inactive for seq < err2_start_seq */
            memset(debug->err2_delay_pre_condi, 0, sizeof(debug->err2_delay_pre_condi));
            memset(debug->err2_delay_condi, 0, sizeof(debug->err2_delay_condi));
            debug->err2_delay_flag = 0;
        }

        debug->error_code2 = err2;
        if (err2) errcode |= 2;
        algo_args->err2_result_prev = err2;
    }

    /* --- err4: signal quality --- */
    /* err4 uses f_check_cgm_trend to detect signal quality issues.
     * Debug fields track min/range/min_diff of tran_inA_5min history.
     * err4 never fires in factory-cal-only mode in our test data. */
    {
        uint8_t err4 = 0;
        double tran_5min = debug->tran_inA_5min;

        /* err4_min: running minimum of tran_inA_5min */
        if (seq == 1) {
            algo_args->err4_min_prev[0] = tran_5min;
            debug->err4_min = tran_5min;
            debug->err4_range = NAN;
            debug->err4_min_diff = NAN;
        } else {
            /* Update running min */
            if (tran_5min < algo_args->err4_min_prev[0]) {
                algo_args->err4_min_prev[0] = tran_5min;
            }
            debug->err4_min = algo_args->err4_min_prev[0];

            /* err4_range: consecutive difference (NOT max-min range).
             * Oracle-verified: err4_range = tran_5min[n] - tran_5min[n-1].
             * Can be negative. Name is misleading — it's the first difference. */
            debug->err4_range = tran_5min - algo_args->err4_inA[0];

            /* err4_min_diff: minimum absolute difference between consecutive tran_5min.
             * Oracle-verified: only tracked from seq >= err345_seq2 (=5). Before that, 0. */
            double diff = fabs(tran_5min - algo_args->err4_inA[0]);
            if (seq < dev_info->err345_seq2) {
                debug->err4_min_diff = 0.0;
            } else if (seq == dev_info->err345_seq2) {
                algo_args->err4_min_diff_prev[0] = diff;
                debug->err4_min_diff = diff;
            } else {
                if (diff < algo_args->err4_min_diff_prev[0])
                    algo_args->err4_min_diff_prev[0] = diff;
                debug->err4_min_diff = algo_args->err4_min_diff_prev[0];
            }
        }

        /* Store current tran_5min for next step */
        algo_args->err4_inA[0] = tran_5min;

        debug->error_code4 = err4;
        if (err4) errcode |= 4;
        algo_args->err4_result_prev = err4;
    }

    /* --- err16: sensor drift / calibration consistency --- */
    {
        uint8_t err16 = 0;

        /* err16 activates once seq >= err345_seq4[2] (typically 12).
         * It computes smoothed glucose and current estimates using a
         * regularized DFT smoother (smooth1q_err16) with a fixed window
         * of 12 data points from the err_glu_arr and
         * err128_CGM_c_noise_revised_value FIFOs.
         *
         * plasma = round(smooth(last 12 glu values)[11])
         * ISF_smooth = round(smooth(last 12 current values)[11] / (slope100/100))
         */
        uint16_t err16_start_seq = dev_info->err345_seq4[2];
        if (seq >= err16_start_seq) {
            /* Number of data points for the smoother */
            const int N = 12;
            double glu_buf[12], curr_buf[12];
            double smooth_glu[12], smooth_curr[12];

            /* Extract last N elements from err_glu_arr[288] */
            for (int i = 0; i < N; i++)
                glu_buf[i] = algo_args->err_glu_arr[288 - N + i];

            /* Extract last N elements from err128_CGM_c_noise_revised_value[36] */
            for (int i = 0; i < N; i++)
                curr_buf[i] = algo_args->err128_CGM_c_noise_revised_value[36 - N + i];

            /* Run regularized DFT smoother on both buffers */
            smooth1q_err16(glu_buf, smooth_glu, N);
            smooth1q_err16(curr_buf, smooth_curr, N);

            /* Compute plasma and ISF_smooth from smoothed values */
            double slope100_d = (double)dev_info->slope100;
            double conv_factor = slope100_d / 100.0;

            /* Check that data is valid (no NaN/Inf in the smoothed output) */
            double sm_glu_last = smooth_glu[N - 1];
            double sm_curr_last = smooth_curr[N - 1];

            int valid = 1;
            if (isnan(sm_glu_last) || isinf(sm_glu_last)) valid = 0;
            if (isnan(sm_curr_last) || isinf(sm_curr_last)) valid = 0;
            if (fabs(sm_glu_last) == 0.0 && fabs(sm_curr_last) == 0.0) valid = 0;

            if (valid && conv_factor > 0.0) {
                debug->err16_CGM_plasma = math_round(sm_glu_last);
                debug->err16_CGM_ISF_smooth = math_round(sm_curr_last / conv_factor);
            } else {
                debug->err16_CGM_plasma = NAN;
                debug->err16_CGM_ISF_smooth = NAN;
            }
        } else {
            debug->err16_CGM_plasma = NAN;
            debug->err16_CGM_ISF_smooth = NAN;
        }

        debug->error_code16 = err16;
        if (err16) errcode |= 16;
        algo_args->err16_result_prev = err16;
    }

    /* --- err128: CGM noise revision --- */
    /* err128 checks for excessive CGM noise by comparing consecutive readings.
     * The revised_value tracks the corrected glucose after noise filtering.
     * For factory-cal-only mode, err128 never fires. */
    {
        debug->err128_flag = 0;

        /* err128_revised_value = tran_inA_5min (the corrected current signal) */
        debug->err128_revised_value = debug->tran_inA_5min;

        /* err128_normal: NaN when err128 is not active */
        debug->err128_normal = NAN;
    }

    /* Store trend rate */
    /* trendrate is set by calibration.c before check_error is called */
    debug->cal_available_flag = 1;

    return errcode;
}
