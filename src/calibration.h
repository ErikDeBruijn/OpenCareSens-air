/*
 * OpenCareSens Air - Open-source calibration algorithm
 *
 * Struct definitions ported from Juggluco's air.hpp to pure C.
 * Original source: j-kaltes/Juggluco (GPL-3.0)
 *
 * Copyright (C) 2021 Jaap Korthals Altes <jaapkorthalsaltes@gmail.com>
 * Ported to C for the OpenCareSens Air project.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#ifndef CALIBRATION_H
#define CALIBRATION_H

#include <stdint.h>

#pragma pack(push, 1)

/* ── CalLog (used inside arguments_t) ── */
/* air.hpp lines 51-66 */
struct air1_opcal4_cal_log_t {
    uint8_t  group;
    uint32_t bgTime;
    double   bgSeq;
    double   cgSeq1m;
    uint16_t cgIdx;
    double   bgUser;
    double   CslopePrev;
    double   CyceptPrev;
    int8_t   bgValid;
    double   bgCal;
    double   cgCal;
    double   CslopeNew;
    double   CyceptNew;
    uint8_t  inlierFlg;
};

/* ── Arguments (huge ~106 KB struct) ── */
/* air.hpp lines 68-283 */
struct air1_opcal4_arguments_t {
    uint16_t args_seq;
    uint8_t  lot_type;
    uint32_t sensor_start_time;
    uint16_t idx_origin_seq;
    uint32_t time_prev;
    uint16_t seq_prev;
    uint16_t adc_prev[30];
    double   temp_prev;
    uint16_t cumul_sum;
    uint32_t time_10sec_arr[90];
    uint16_t contact_err_start_seq;
    uint16_t prev_contact_err_algo_seq;
    uint32_t time_standard_arr[288];
    uint16_t idx;
    uint16_t accu_seq[865];
    double   prev_current[5];
    double   prev_new_i_sig[5];
    int8_t   outlier_max_index[6];
    double   prev_outlier_removed_curr[60];
    double   prev_mov_median_curr[3];
    double   curr_avg_arr[865];
    uint16_t diabetes_cnt_hi_glu;
    uint16_t diabetes_cnt_low_glu;
    uint16_t diabetes_cnt_idx;
    uint8_t  diabetes_level_diabetes;
    double   diabetes_TAR;
    double   diabetes_TBR;
    double   diabetes_CV;
    double   diabetes_mean_x;
    double   diabetes_M2;
    double   shiftout_ad_prev;
    uint16_t diabetes_before_7days_n_valid;
    uint8_t  diabetes_before_7days_flag;
    double   diabetes_before_7days_eAG;
    double   diabetes_before_7days_M2;
    double   diabetes_before_7days_TAR;
    double   diabetes_before_7days_TIR;
    double   diabetes_before_7days_CV;
    double   sum_curr_for_init_value;
    uint16_t sum_curr_cnt_for_init_value;
    double   sum_curr_for_mdc;
    uint16_t sum_curr_cnt_for_mdc;
    double   iir_x[2];
    double   iir_y;
    uint8_t  iir_start_flag;
    uint16_t mdc_start_idx;
    uint8_t  mdc_first_flag;
    uint8_t  iir_use_flag;
    double   baseline_prev;
    double   slope_ratio_temp_buffer[4];
    double   biastrend[2];
    double   biasIIR[2];
    double   biasavg[2];
    double   nSumtrend;
    uint8_t  state_init_kalman;
    uint16_t warmup_cnt;
    double   out_kalman[3];
    double   kalman_roc[4];
    double   kalman_state_fluctuation;
    double   init_cg_prev;
    double   smooth_sig_in[10];
    uint32_t smooth_time_in[10];
    uint8_t  smooth_f_rep_in[6];
    double   cal_result_input[7];
    double   cal_result_output[7];
    double   cal_result_slope[7];
    double   cal_result_ycept[7];
    double   cal_result_in_smooth_slope[10];
    double   cal_result_in_smooth_ycept[10];
    struct air1_opcal4_cal_log_t CalLog[50];
    int8_t   CalLog_cal_state;
    double   CalLog_CslopeDelta;
    double   CalLog_CyceptDelta;
    int8_t   cal_state;
    int8_t   state_return_opcal;
    double   initstable_weight_usercal;
    double   initstable_weight_nocal;
    double   initstable_fixusercal;
    double   initstable_weight_tempuser;
    double   initstable_weight_usercal_arr[7];
    double   initstable_weight_faccal_arr[7];
    double   initstable_mean_dc[2];
    double   initstable_diff_dc;
    uint8_t  initstable_weightcontrol_onoff;
    uint8_t  initstable_bweightstart;
    uint16_t initstable_control_cnt;
    uint16_t initstable_initcnt;
    uint8_t  initstable_finish_init_flag;
    uint16_t initstable_init_end_point;
    uint8_t  initstable_bFirstInit;
    uint16_t start_seq;
    uint32_t CGM_time_start;
    uint8_t  err_delay_arr[7];
    double   err_glu_arr[288];
    double   err1_th_sse_d_mean1;
    double   err1_th_sse_d_mean2;
    double   err1_th_sse_d_mean;
    double   err1_th_diff1;
    double   err1_th_diff2;
    double   err1_th_diff;
    uint16_t err1_n;
    uint8_t  err1_isfirst0;
    uint8_t  err1_isfirst1;
    uint8_t  err1_isfirst2;
    double   err1_prev_last_1min_curr;
    uint8_t  err1_is_contact_bad1h[100];
    double   err1_i_sse_d_mean4h[100];
    double   err1_current_avg_diff_prev[100];
    double   err1_SG_1min[180];
    uint32_t err1_time_1min[180];
    double   err1_inA_1min[180];
    uint8_t  err1_result_prev;
    uint8_t  err1_TD_temporary_break_flag_past_range[36];
    uint16_t err1_sum_result_condition_TD;
    uint8_t  err1_any_result_condition_TD;
    uint8_t  err2_delay_condi_prev;
    uint8_t  err2_delay_flag_prev[575];
    double   err2_delay_roc_prev[575];
    double   err2_delay_slope_sharp_prev[575];
    double   err2_delay_glucosevalue_prev[575];
    double   err2_delay_roc_cummax_prev;
    double   err2_delay_slope_cummax_prev;
    double   err2_delay_glu_cummax_prev;
    uint8_t  err2_delay_pre_condi_prev[3];
    double   err2_delay_revised_value_prev;
    double   err2_cummax;
    double   err2_cummax_foretime[100];
    uint8_t  err2_result_prev;
    double   err4_inA[390];
    double   err4_min_prev[289];
    double   err4_range_prev[51];
    double   err4_min_diff_prev[289];
    uint8_t  err4_delay_flag_arr[576];
    uint8_t  err4_result_prev;
    uint8_t  err8_result_prev;
    uint8_t  err128_flag_prev[40];
    double   err128_normal_prev;
    double   err128_revised_value_prev;
    double   err128_CGM_c_noise_revised_value[36];
    uint32_t err16_time5_first;
    double   err16_dt_arr[36];
    uint8_t  err16_cal_cons_is_first;
    double   err16_cal_cons_seq[50];
    uint32_t err16_cal_cons_time[50];
    double   err16_cal_cons_bgm[50];
    double   err16_cal_cons_d_usercal_before[50];
    double   err16_cal_cons_d_usercal_after[50];
    uint16_t err16_cal_day_i;
    uint8_t  err16_cal_day_is_first;
    uint8_t  err16_cal_day_idx_ref[30];
    double   err16_cal_day_d_ref;
    double   err16_cal_day_d_temp;
    double   err16_cal_day_d_value[30];
    double   err16_cal_day_n_ref;
    uint16_t err16_cal_day_n_value[30];
    double   err16_CGM_ISF_smooth[865];
    double   err16_CGM_plasma[36];
    double   err16_CGM_ISF_roc_n;
    double   err16_CGM_ISF_roc_value[577];
    double   err16_CGM_ISF_roc_steady[36];
    double   err16_CGM_ISF_roc_min;
    double   err16_CGM_ISF_roc_min_temp[865];
    double   err16_CGM_ISF_roc_min_prev;
    double   err16_CGM_ISF_roc_diff[36];
    double   err16_CGM_ISF_roc_ratio[36];
    double   err16_CGM_ISF_trend_min_n;
    double   err16_CGM_ISF_trend_min_value;
    double   err16_CGM_ISF_trend_min_value_prev;
    double   err16_CGM_ISF_trend_min_value_arr[865];
    double   err16_CGM_ISF_trend_min_slope1[36];
    double   err16_CGM_ISF_trend_min_slope2[36];
    double   err16_CGM_ISF_trend_min_rsq1[36];
    double   err16_CGM_ISF_trend_min_rsq2[36];
    double   err16_CGM_ISF_trend_min_diff[36];
    double   err16_CGM_ISF_trend_min_ratio[36];
    double   err16_CGM_ISF_trend_min_max;
    double   err16_CGM_ISF_trend_min_max_temp[865];
    double   err16_CGM_ISF_trend_min_max_prev;
    double   err16_CGM_ISF_trend_min_max_early;
    double   err16_CGM_ISF_trend_mode_n;
    double   err16_CGM_ISF_trend_mode_value;
    double   err16_CGM_ISF_trend_mode_value_prev;
    double   err16_CGM_ISF_trend_mode_proportion[36];
    double   err16_CGM_ISF_trend_mode_diff[36];
    double   err16_CGM_ISF_trend_mode_ratio[36];
    double   err16_CGM_ISF_trend_mode_max;
    double   err16_CGM_ISF_trend_mode_max_temp[865];
    double   err16_CGM_ISF_trend_mode_max_prev;
    double   err16_CGM_ISF_trend_mode_max_early;
    uint8_t  err16_CGM_ISF_trend_mean_is_first;
    double   err16_CGM_ISF_trend_mean_n;
    double   err16_CGM_ISF_trend_mean_value;
    double   err16_CGM_ISF_trend_mean_value_prev;
    double   err16_CGM_ISF_trend_mean_value_arr[865];
    double   err16_CGM_ISF_trend_mean_slope[36];
    double   err16_CGM_ISF_trend_mean_rsq[36];
    double   err16_CGM_ISF_trend_mean_diff[36];
    double   err16_CGM_ISF_trend_mean_ratio[36];
    double   err16_CGM_ISF_trend_mean_max;
    double   err16_CGM_ISF_trend_mean_max_temp[865];
    double   err16_CGM_ISF_trend_mean_max_prev;
    double   err16_CGM_ISF_trend_mean_max_early;
    double   err16_CGM_ISF_trend_mean_max_early_prev;
    double   err16_CGM_ISF_trend_mean_diff_early[36];
    double   err16_CGM_ISF_trend_mean_max_temp_early[865];
    double   err16_CGM_ISF_trend_mean_ratio_early[36];
    uint8_t  err16_result_prev;
    uint32_t err32_prev_time;
    uint16_t err32_prev_seq;
    uint16_t err32_buff_23[4];
    uint16_t err32_buff_60[2];
    uint16_t err32_buff_600;
    uint8_t  err32_n[3];
    uint8_t  err32_result_prev;
};

/* ── Output ── */
/* air.hpp lines 300-314 */
struct air1_opcal4_output_t {
    uint16_t seq_number_original;
    uint16_t seq_number_final;
    uint32_t measurement_time_standard;
    uint16_t workout[30];
    double   result_glucose;
    double   trendrate;
    uint8_t  current_stage;
    uint8_t  smooth_fixed_flag[6];
    uint16_t smooth_seq[6];
    double   smooth_result_glucose[6];
    uint16_t errcode;
    uint8_t  cal_available_flag;
    uint8_t  data_type;
};

/* ── Debug ── */
/* air.hpp lines 316-484 */
struct air1_opcal4_debug_t {
    uint16_t seq_number_original;
    uint16_t seq_number_final;
    uint32_t measurement_time_standard;
    uint8_t  data_type;
    uint8_t  stage;
    double   temperature;
    uint16_t workout[30];
    double   tran_inA[30];
    double   tran_inA_1min[5];
    double   tran_inA_5min;
    double   ycept;
    double   corrected_re_current;
    double   diabetes_mean_x;
    double   diabetes_M2;
    double   diabetes_TAR;
    double   diabetes_TBR;
    double   diabetes_CV;
    uint8_t  level_diabetes;
    double   out_iir;
    double   out_drift;
    double   curr_baseline;
    double   initstable_diff_dc;
    uint16_t initstable_initcnt;
    double   temp_local_mean;
    double   slope_ratio_temp;
    double   init_cg;
    double   out_rescale;
    double   opcal_ad;
    uint8_t  state_init_kalman;
    uint16_t smooth_seq[6];
    double   smooth_sig[6];
    uint8_t  smooth_frep[6];
    uint8_t  cal_state;
    int8_t   state_return_opcal;
    uint32_t valid_bg_time;
    double   valid_bg_value;
    uint8_t  callog_group;
    uint32_t callog_bgTime;
    double   callog_bgSeq;
    double   callog_bgUser;
    int8_t   callog_bgValid;
    double   callog_bgCal;
    double   callog_cgSeq1m;
    uint16_t callog_cgIdx;
    double   callog_cgCal;
    double   callog_CslopePrev;
    double   callog_CyceptPrev;
    double   callog_CslopeNew;
    double   callog_CyceptNew;
    uint8_t  callog_inlierFlg;
    double   cal_slope[7];
    double   cal_ycept[7];
    double   cal_input[7];
    double   cal_output[7];
    double   initstable_weight_usercal;
    double   initstable_weight_nocal;
    double   initstable_fixusercal;
    int8_t   nOpcalState;
    uint16_t initstable_init_end_point;
    double   out_weight_sd[6];
    double   out_weight_ad;
    double   shiftout_ad;
    uint8_t  error_code1;
    uint8_t  error_code2;
    uint8_t  error_code4;
    uint8_t  error_code8;
    uint8_t  error_code16;
    uint8_t  error_code32;
    double   trendrate;
    uint8_t  cal_available_flag;
    double   err1_i_sse_d_mean;
    double   err1_th_sse_d_mean1;
    double   err1_th_sse_d_mean2;
    double   err1_th_sse_d_mean;
    uint8_t  err1_is_contact_bad;
    double   err1_current_avg_diff;
    double   err1_th_diff1;
    double   err1_th_diff2;
    double   err1_th_diff;
    uint8_t  err1_isfirst0;
    uint8_t  err1_isfirst1;
    uint8_t  err1_isfirst2;
    uint16_t err1_n;
    uint8_t  err1_random_noise_temp_break;
    uint8_t  err1_result;
    uint8_t  err1_length_t2_max;
    uint8_t  err1_length_t3_max;
    uint8_t  err1_length_t1_trio;
    uint8_t  err1_length_t2_trio;
    uint8_t  err1_length_t3_trio;
    uint8_t  err1_length_t6_trio;
    uint8_t  err1_length_t7_trio;
    uint8_t  err1_length_t8_trio;
    uint8_t  err1_length_t9_trio;
    uint8_t  err1_length_t10_trio;
    uint8_t  err1_result_TD;
    uint8_t  err1_result_condition_TD[2];
    uint16_t err1_TD_count;
    uint8_t  err1_TD_temporary_break_flag;
    uint32_t err1_TD_time_trio[3];
    double   err1_TD_value_trio[3];
    double   err2_delay_revised_value;
    double   err2_delay_roc;
    double   err2_delay_slope_sharp;
    double   err2_delay_roc_cummax;
    double   err2_delay_roc_trimmed_mean;
    double   err2_delay_slope_cummax;
    double   err2_delay_slope_trimmed_mean;
    double   err2_delay_glu_cummax;
    double   err2_delay_glu_trimmed_mean;
    uint8_t  err2_delay_pre_condi[3];
    uint8_t  err2_delay_condi[3];
    uint8_t  err2_delay_flag;
    double   err2_cummax;
    uint8_t  err2_crt_current[2];
    uint8_t  err2_crt_glu[2];
    double   err2_crt_cv;
    uint8_t  err2_condi[2];
    double   err4_min;
    double   err4_range;
    double   err4_min_diff;
    uint8_t  err4_condi[5];
    uint8_t  err4_delay_condi[5];
    uint8_t  err4_delay_flag;
    uint8_t  err8_condi[2];
    double   err16_cal_cons_d_usercal_after;
    double   err16_cal_day_d_temp;
    double   err16_cal_day_d_ref;
    double   err16_cal_day_n_ref;
    double   err16_CGM_plasma;
    double   err16_CGM_ISF_smooth;
    double   err16_CGM_ISF_roc_value;
    double   err16_CGM_ISF_roc_steady;
    double   err16_CGM_ISF_roc_min_temp;
    double   err16_CGM_ISF_roc_min;
    double   err16_CGM_ISF_roc_diff;
    double   err16_CGM_ISF_roc_ratio;
    double   err16_CGM_ISF_trend_min_value;
    double   err16_CGM_ISF_trend_min_slope1;
    double   err16_CGM_ISF_trend_min_slope2;
    double   err16_CGM_ISF_trend_min_rsq1;
    double   err16_CGM_ISF_trend_min_rsq2;
    double   err16_CGM_ISF_trend_min_diff;
    double   err16_CGM_ISF_trend_min_max_temp;
    double   err16_CGM_ISF_trend_min_max;
    double   err16_CGM_ISF_trend_min_ratio;
    double   err16_CGM_ISF_trend_mode_value;
    double   err16_CGM_ISF_trend_mode_proportion;
    double   err16_CGM_ISF_trend_mode_diff;
    double   err16_CGM_ISF_trend_mode_max_temp;
    double   err16_CGM_ISF_trend_mode_max;
    double   err16_CGM_ISF_trend_mode_ratio;
    double   err16_CGM_ISF_trend_mean_value;
    double   err16_CGM_ISF_trend_mean_slope;
    double   err16_CGM_ISF_trend_mean_rsq;
    double   err16_CGM_ISF_trend_mean_diff;
    double   err16_CGM_ISF_trend_mean_max_temp;
    double   err16_CGM_ISF_trend_mean_max;
    double   err16_CGM_ISF_trend_mean_ratio;
    double   err16_CGM_ISF_trend_mean_diff_early;
    double   err16_CGM_ISF_trend_mean_max_temp_early;
    double   err16_CGM_ISF_trend_mean_max_early;
    double   err16_CGM_ISF_trend_mean_ratio_early;
    uint8_t  err16_condi[7];
    uint8_t  err128_flag;
    double   err128_revised_value;
    double   err128_normal;
};

/* ── Device info ── */
/* air.hpp lines 485-602 */
struct air1_opcal4_device_info_t {
    uint8_t  sensor_version;
    float    ycept;
    float    slope100;
    float    slope;
    float    r2;
    float    t90;
    float    slope_ratio;
    char     lot[10];
    char     sensor_id[12];
    char     expiry_date[6];
    uint16_t stabilizationInterval;
    uint16_t cgmDataInterval;
    uint16_t bleAdvInterval;
    uint8_t  bleAdvDuration;
    uint8_t  age;
    uint16_t allowedList;
    float    maximumValue;
    float    minimumValue;
    uint8_t  cLibraryVersion;
    uint8_t  parameter_version;
    uint8_t  basic_warmup;
    float    basic_ycept;
    uint8_t  contact_win_len;
    uint8_t  contact_cond_1_x10;
    uint8_t  contact_cond_2_x10;
    uint8_t  contact_cond_3_x10;
    uint8_t  fill_flag;
    uint8_t  drift_correction_on;
    float    drift_coefficient[3][3];
    int16_t  i_ref_x100;
    uint16_t coef_length;
    uint16_t div_point;
    uint8_t  iir_flag;
    uint8_t  iir_st_d_x10;
    uint8_t  correct1_flag;
    float    correct1_coeff[4];
    uint8_t  kalman_t90;
    uint8_t  kalman_delta_t;
    int16_t  kalman_q_x100[3][3];
    int16_t  kalman_r_x100;
    float    bg_cal_ratio;
    uint8_t  bg_cal_time_factor;
    uint8_t  slope_factor_x10;
    uint8_t  slope_inter_up_x10;
    int8_t   slope_inter_down_x10;
    uint8_t  slope_multi_v_x10;
    uint8_t  slope_iir_thr;
    uint8_t  slope_neg_inter_thr1_x10;
    uint8_t  slope_neg_inter_thr2_x10;
    uint8_t  slope_bg_cal_thr_down;
    uint8_t  slope_bg_cal_thr_up;
    uint16_t slope_max_slope_x100;
    uint16_t slope_min_slope_x100;
    float    slope_dcal_rate;
    uint16_t slope_dcal_target_length;
    uint16_t slope_dcal_window;
    uint8_t  slope_dcal_factory_cal_use;
    uint8_t  shift_m_sel;
    float    shift_coeff[4];
    uint16_t shift_m2_x100[3];
    uint8_t  w_sg_x100[7];
    uint8_t  cal_trendRate;
    float    cal_noise;
    uint8_t  errcode_version;
    uint8_t  err1_seq[3];
    float    err1_contact_bad;
    float    err1_th_diff;
    float    err1_th_sse_dmean[3];
    uint8_t  err1_th_n1[4];
    uint8_t  err1_th_n2[2][2];
    uint8_t  err1_n_consecutive;
    float    err1_i_sse_dmean_now[2];
    uint8_t  err1_count_sse_dmean;
    uint16_t err1_n_last;
    uint8_t  err1_multi[2];
    float    err1_current_avg_diff;
    uint16_t err2_start_seq;
    uint8_t  err2_seq[3];
    float    err2_glu;
    float    err2_cv[3];
    uint8_t  err2_cummax;
    uint8_t  err2_multi;
    float    err2_ycept;
    float    err2_alpha;
    uint16_t err345_seq1[2];
    uint8_t  err345_seq2;
    uint16_t err345_seq3[3];
    uint16_t err345_seq4[5];
    uint16_t err345_seq5[3];
    float    err345_raw[4];
    float    err345_filtered[2];
    float    err345_min[2];
    float    err345_range;
    uint8_t  err345_n_range;
    float    err345_md;
    uint16_t err345_n_md;
    uint8_t  err6_cal_n_pts;
    float    err6_cal_basic_prct;
    uint16_t err6_cal_basic_seq;
    float    err6_cal_origin_slope;
    float    err6_cal_in_vitro[2];
    float    err6_CGM_rpd;
    float    err6_CGM_slp;
    uint8_t  err6_CGM_low3d_seq;
    float    err6_CGM_low3d_p;
    uint8_t  err6_CGM_low1d_seq;
    float    err6_CGM_low1d_p;
    uint8_t  err6_CGM_prct[3];
    uint8_t  err6_CGM_day[2];
    uint16_t err6_CGM_BLE_bad[2];
    float    err6_CGM_poly2;
    uint8_t  err32_dt[2];
    uint8_t  err32_n[2];
    float    vref;
    float    eapp;
    uint32_t sensor_start_time;
};

/* ── CGM input ── */
/* air.hpp lines 730-735 */
struct air1_opcal4_cgm_input_t {
    uint16_t seq_number;
    uint32_t measurement_time_standard;
    uint16_t workout[30];
    double   temperature;
};

/* ── Calibration list ── */
/* air.hpp lines 737-743 */
struct air1_opcal4_cal_list_t {
    uint16_t idx[50];
    double   value[50];
    uint32_t time[50];
    uint8_t  cal_list_length;
    uint8_t  cal_flag[50];
};

#pragma pack(pop)

/* ── Struct size assertions ── */
/* debug_t must be exactly 1579 bytes (from DebugData4Obj.java MAX_LENGTH).
 * Other sizes are computed from the packed field layout. */
_Static_assert(sizeof(struct air1_opcal4_cal_log_t) == 81,
    "air1_opcal4_cal_log_t must be 81 bytes (packed)");
_Static_assert(sizeof(struct air1_opcal4_arguments_t) == 116030,
    "air1_opcal4_arguments_t must be 116030 bytes (packed)");
_Static_assert(sizeof(struct air1_opcal4_output_t) == 155,
    "air1_opcal4_output_t must be 155 bytes (packed)");
_Static_assert(sizeof(struct air1_opcal4_debug_t) == 1579,
    "air1_opcal4_debug_t must be 1579 bytes (from DebugData4Obj.java MAX_LENGTH)");
_Static_assert(sizeof(struct air1_opcal4_device_info_t) == 446,
    "air1_opcal4_device_info_t must be 446 bytes (packed)");
_Static_assert(sizeof(struct air1_opcal4_cgm_input_t) == 74,
    "air1_opcal4_cgm_input_t must be 74 bytes (packed)");
_Static_assert(sizeof(struct air1_opcal4_cal_list_t) == 751,
    "air1_opcal4_cal_list_t must be 751 bytes (packed)");

/* ── Main algorithm function signature ── */
typedef unsigned char (*air1_opcal4_algorithm_fn)(
    struct air1_opcal4_device_info_t  *dev_info,
    struct air1_opcal4_cgm_input_t    *cgm_input,
    struct air1_opcal4_cal_list_t     *cal_input,
    struct air1_opcal4_arguments_t    *algo_args,
    struct air1_opcal4_output_t       *algo_output,
    struct air1_opcal4_debug_t        *algo_debug
);

#endif /* CALIBRATION_H */
