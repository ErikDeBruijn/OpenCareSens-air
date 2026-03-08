/*
 * Oracle Comparison Driver
 *
 * Loads oracle binary dumps (input, output, debug) and runs our
 * reimplementation with the same inputs, comparing every field.
 *
 * Usage: ./compare_oracle <oracle_dir> [--eapp <val>] [--max <N>] [--verbose]
 *        ./compare_oracle oracle/output/lot0
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <errno.h>
#include <stddef.h>

#include "calibration.h"

/* Our algorithm entry point */
extern unsigned char air1_opcal4_algorithm(
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_cgm_input_t *cgm_input,
    struct air1_opcal4_cal_list_t *cal_input,
    struct air1_opcal4_arguments_t *algo_args,
    struct air1_opcal4_output_t *algo_output,
    struct air1_opcal4_debug_t *algo_debug);

/* Identical to oracle_harness.c to ensure same dev_info */
static void init_default_device_info(struct air1_opcal4_device_info_t *di) {
    memset(di, 0, sizeof(*di));
    di->sensor_version = 1;
    di->ycept = 1.0f;
    di->slope100 = 3.5226f;
    di->slope = 1.0f;
    di->r2 = 0.0f;
    di->t90 = 0.0f;
    di->slope_ratio = 1.0f;
    di->stabilizationInterval = 7200;
    di->cgmDataInterval = 300;
    di->bleAdvInterval = 300;
    di->bleAdvDuration = 10;
    di->age = 18;
    di->allowedList = 1;
    di->maximumValue = 500.0f;
    di->minimumValue = 40.0f;
    di->cLibraryVersion = 3;
    di->parameter_version = 3;
    di->basic_warmup = 24;
    di->basic_ycept = 0.0f;
    di->contact_win_len = 30;
    di->contact_cond_1_x10 = 5;
    di->contact_cond_2_x10 = 1;
    di->contact_cond_3_x10 = 2;
    di->fill_flag = 1;
    di->drift_correction_on = 0;
    di->drift_coefficient[0][2] = 1.0f;
    di->drift_coefficient[1][2] = 1.0f;
    di->drift_coefficient[2][2] = 1.0f;
    di->i_ref_x100 = 100;
    di->coef_length = 1;
    di->div_point = 1;
    di->iir_flag = 1;
    di->iir_st_d_x10 = 90;
    di->correct1_flag = 1;
    di->correct1_coeff[2] = 1.0f;
    di->kalman_t90 = 10;
    di->kalman_delta_t = 5;
    di->kalman_q_x100[0][0] = -115;
    di->kalman_q_x100[1][1] = 1440;
    di->kalman_q_x100[2][2] = 10;
    di->kalman_r_x100 = 200;
    di->bg_cal_ratio = 1.0f;
    di->bg_cal_time_factor = 0;
    di->slope_factor_x10 = 20;
    di->slope_inter_up_x10 = 10;
    di->slope_inter_down_x10 = -20;
    di->slope_multi_v_x10 = 20;
    di->slope_iir_thr = 20;
    di->slope_neg_inter_thr1_x10 = 5;
    di->slope_neg_inter_thr2_x10 = 8;
    di->slope_bg_cal_thr_down = 70;
    di->slope_bg_cal_thr_up = 100;
    di->slope_max_slope_x100 = 76;
    di->slope_min_slope_x100 = 40;
    di->slope_dcal_rate = 0.6f;
    di->slope_dcal_target_length = 108;
    di->slope_dcal_window = 888;
    di->slope_dcal_factory_cal_use = 0;
    di->shift_m_sel = 1;
    di->shift_coeff[2] = 1.0f;
    di->shift_m2_x100[0] = 17;
    di->shift_m2_x100[1] = 2000;
    di->shift_m2_x100[2] = 111;
    di->w_sg_x100[0] = 80;
    di->w_sg_x100[1] = 130;
    di->w_sg_x100[2] = 90;
    di->w_sg_x100[3] = 80;
    di->w_sg_x100[4] = 110;
    di->w_sg_x100[5] = 90;
    di->w_sg_x100[6] = 80;
    di->cal_trendRate = 3;
    di->cal_noise = 3.0f;
    di->errcode_version = 2;
    di->err1_seq[0] = 23; di->err1_seq[1] = 47; di->err1_seq[2] = 11;
    di->err1_contact_bad = 0.5f;
    di->err1_th_diff = 2.0f;
    di->err1_th_sse_dmean[0] = 0.05f;
    di->err1_th_sse_dmean[1] = 0.1f;
    di->err1_th_sse_dmean[2] = 0.5f;
    di->err1_th_n1[0] = 43; di->err1_th_n1[1] = 40;
    di->err1_th_n1[2] = 37; di->err1_th_n1[3] = 34;
    di->err1_th_n2[0][0] = 2; di->err1_th_n2[0][1] = 6;
    di->err1_th_n2[1][0] = 4; di->err1_th_n2[1][1] = 8;
    di->err1_n_consecutive = 6;
    di->err1_i_sse_dmean_now[0] = 3.0f;
    di->err1_i_sse_dmean_now[1] = 0.001f;
    di->err1_count_sse_dmean = 12;
    di->err1_n_last = 288;
    di->err1_multi[0] = 10; di->err1_multi[1] = 10;
    di->err1_current_avg_diff = 1.0E-15f;
    di->err2_start_seq = 289;
    di->err2_seq[0] = 20; di->err2_seq[1] = 11; di->err2_seq[2] = 6;
    di->err2_glu = 800.0f;
    di->err2_cv[0] = 10.0f; di->err2_cv[1] = 0.05f; di->err2_cv[2] = 10.0f;
    di->err2_cummax = 2;
    di->err2_multi = 10;
    di->err2_ycept = 2.0f;
    di->err2_alpha = 2.0f;
    di->err345_seq1[0] = 3; di->err345_seq1[1] = 576;
    di->err345_seq2 = 5;
    di->err345_seq3[0] = 5; di->err345_seq3[1] = 864; di->err345_seq3[2] = 24;
    di->err345_seq4[0] = 11; di->err345_seq4[1] = 23; di->err345_seq4[2] = 12;
    di->err345_seq4[3] = 288; di->err345_seq4[4] = 24;
    di->err345_seq5[0] = 11; di->err345_seq5[1] = 36; di->err345_seq5[2] = 288;
    di->err345_raw[0] = 0.1f; di->err345_raw[1] = 0.5f;
    di->err345_raw[2] = 0.2f; di->err345_raw[3] = 0.7f;
    di->err345_filtered[0] = 0.2f; di->err345_filtered[1] = 1.0f;
    di->err345_min[0] = 0.5f; di->err345_min[1] = 0.3f;
    di->err345_range = -1.0f;
    di->err345_n_range = 2;
    di->err345_md = 0.0f;
    di->err345_n_md = 6;
    di->err6_cal_n_pts = 3;
    di->err6_cal_basic_prct = 0.3f;
    di->err6_cal_basic_seq = 1440;
    di->err6_cal_origin_slope = 30.0f;
    di->err6_cal_in_vitro[0] = 0.0f; di->err6_cal_in_vitro[1] = 2.0f;
    di->err6_CGM_rpd = 0.55f;
    di->err6_CGM_slp = -0.2f;
    di->err6_CGM_low3d_seq = 24;
    di->err6_CGM_low3d_p = 0.32f;
    di->err6_CGM_low1d_seq = 24;
    di->err6_CGM_low1d_p = 0.3f;
    di->err6_CGM_prct[0] = 30; di->err6_CGM_prct[1] = 50; di->err6_CGM_prct[2] = 70;
    di->err6_CGM_day[0] = 1; di->err6_CGM_day[1] = 3;
    di->err6_CGM_BLE_bad[0] = 12; di->err6_CGM_BLE_bad[1] = 96;
    di->err6_CGM_poly2 = 0.7f;
    di->err32_dt[0] = 23; di->err32_dt[1] = 60;
    di->err32_n[0] = 3; di->err32_n[1] = 2;
    di->vref = 1.49594f;
    di->eapp = 0.10067f;
    di->sensor_start_time = 1709726400;
}

/* Comparison result tracking */
struct field_stats {
    const char *name;
    int offset;         /* byte offset in oracle binary */
    int our_offset;     /* byte offset in our struct (-1 = same as offset) */
    char type;          /* 'd'=double, 'B'=uint8, 'H'=uint16, 'I'=uint32, 'b'=int8 */
    int total;
    int match;
    int mismatch;
    double max_abs_err; /* for doubles */
    double max_rel_err; /* for doubles */
    int first_mismatch_seq;
};

/* Define ALL debug_t fields for comparison.
 * 'offset' = byte offset in oracle binary (ground truth)
 * 'our_offset' = offsetof in our struct (-1 = same as oracle offset)
 */
#define OUR(field) (int)offsetof(struct air1_opcal4_debug_t, field)

static struct field_stats debug_fields[] = {
    {"seq_number_original", 0, -1, 'H', 0,0,0, 0,0, 0},
    {"seq_number_final", 2, -1, 'H', 0,0,0, 0,0, 0},
    {"measurement_time_standard", 4, -1, 'I', 0,0,0, 0,0, 0},
    {"data_type", 8, -1, 'B', 0,0,0, 0,0, 0},
    {"stage", 9, -1, 'B', 0,0,0, 0,0, 0},
    {"temperature", 10, -1, 'd', 0,0,0, 0,0, 0},
    {"tran_inA_1min[0]", 318, OUR(tran_inA_1min[0]), 'd', 0,0,0, 0,0, 0},
    {"tran_inA_1min[1]", 326, OUR(tran_inA_1min[1]), 'd', 0,0,0, 0,0, 0},
    {"tran_inA_1min[2]", 334, OUR(tran_inA_1min[2]), 'd', 0,0,0, 0,0, 0},
    {"tran_inA_1min[3]", 342, OUR(tran_inA_1min[3]), 'd', 0,0,0, 0,0, 0},
    {"tran_inA_1min[4]", 350, OUR(tran_inA_1min[4]), 'd', 0,0,0, 0,0, 0},
    {"tran_inA_5min", 358, -1, 'd', 0,0,0, 0,0, 0},
    {"ycept", 366, -1, 'd', 0,0,0, 0,0, 0},
    {"corrected_re_current", 374, -1, 'd', 0,0,0, 0,0, 0},
    {"diabetes_mean_x", 382, -1, 'd', 0,0,0, 0,0, 0},
    {"diabetes_M2", 390, -1, 'd', 0,0,0, 0,0, 0},
    {"diabetes_TAR", 398, -1, 'd', 0,0,0, 0,0, 0},
    {"diabetes_TBR", 406, -1, 'd', 0,0,0, 0,0, 0},
    {"diabetes_CV", 414, -1, 'd', 0,0,0, 0,0, 0},
    {"level_diabetes", 422, -1, 'B', 0,0,0, 0,0, 0},
    {"out_iir", 423, -1, 'd', 0,0,0, 0,0, 0},
    {"out_drift", 431, -1, 'd', 0,0,0, 0,0, 0},
    {"curr_baseline", 439, -1, 'd', 0,0,0, 0,0, 0},
    {"initstable_diff_dc", 447, -1, 'd', 0,0,0, 0,0, 0},
    {"initstable_initcnt", 455, -1, 'H', 0,0,0, 0,0, 0},
    {"temp_local_mean", 457, -1, 'd', 0,0,0, 0,0, 0},
    {"slope_ratio_temp", 465, -1, 'd', 0,0,0, 0,0, 0},
    {"init_cg", 473, -1, 'd', 0,0,0, 0,0, 0},
    {"out_rescale", 481, -1, 'd', 0,0,0, 0,0, 0},
    {"opcal_ad", 489, -1, 'd', 0,0,0, 0,0, 0},
    {"state_init_kalman", 497, -1, 'B', 0,0,0, 0,0, 0},
    {"cal_state", 564, -1, 'B', 0,0,0, 0,0, 0},
    {"state_return_opcal", 565, -1, 'b', 0,0,0, 0,0, 0},
    {"valid_bg_time", 566, -1, 'I', 0,0,0, 0,0, 0},
    {"valid_bg_value", 570, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_group", 578, -1, 'B', 0,0,0, 0,0, 0},
    {"callog_bgTime", 579, -1, 'I', 0,0,0, 0,0, 0},
    {"callog_bgSeq", 583, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_bgUser", 591, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_bgValid", 599, -1, 'b', 0,0,0, 0,0, 0},
    {"callog_bgCal", 600, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_cgSeq1m", 608, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_cgIdx", 616, -1, 'H', 0,0,0, 0,0, 0},
    {"callog_cgCal", 618, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_CslopePrev", 626, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_CyceptPrev", 634, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_CslopeNew", 642, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_CyceptNew", 650, -1, 'd', 0,0,0, 0,0, 0},
    {"callog_inlierFlg", 658, -1, 'B', 0,0,0, 0,0, 0},
    {"initstable_weight_usercal", 883, -1, 'd', 0,0,0, 0,0, 0},
    {"initstable_weight_nocal", 891, -1, 'd', 0,0,0, 0,0, 0},
    {"initstable_fixusercal", 899, -1, 'd', 0,0,0, 0,0, 0},
    {"nOpcalState", 907, -1, 'b', 0,0,0, 0,0, 0},
    {"initstable_init_end_point", 908, -1, 'H', 0,0,0, 0,0, 0},
    {"out_weight_ad", 958, -1, 'd', 0,0,0, 0,0, 0},
    {"shiftout_ad", 966, -1, 'd', 0,0,0, 0,0, 0},
    {"error_code1", 974, -1, 'B', 0,0,0, 0,0, 0},
    {"error_code2", 975, -1, 'B', 0,0,0, 0,0, 0},
    {"error_code4", 976, -1, 'B', 0,0,0, 0,0, 0},
    {"error_code8", 977, -1, 'B', 0,0,0, 0,0, 0},
    {"error_code16", 978, -1, 'B', 0,0,0, 0,0, 0},
    {"error_code32", 979, -1, 'B', 0,0,0, 0,0, 0},
    {"trendrate", 980, -1, 'd', 0,0,0, 0,0, 0},
    {"cal_available_flag", 988, -1, 'B', 0,0,0, 0,0, 0},
    /* err1 debug fields */
    {"err1_i_sse_d_mean", 989, OUR(err1_i_sse_d_mean), 'd', 0,0,0, 0,0, 0},
    {"err1_th_sse_d_mean1", 997, OUR(err1_th_sse_d_mean1), 'd', 0,0,0, 0,0, 0},
    {"err1_th_sse_d_mean2", 1005, OUR(err1_th_sse_d_mean2), 'd', 0,0,0, 0,0, 0},
    {"err1_th_sse_d_mean", 1013, OUR(err1_th_sse_d_mean), 'd', 0,0,0, 0,0, 0},
    {"err1_is_contact_bad", 1021, OUR(err1_is_contact_bad), 'B', 0,0,0, 0,0, 0},
    {"err1_current_avg_diff", 1022, OUR(err1_current_avg_diff), 'd', 0,0,0, 0,0, 0},
    {"err1_th_diff1", 1030, OUR(err1_th_diff1), 'd', 0,0,0, 0,0, 0},
    {"err1_th_diff2", 1038, OUR(err1_th_diff2), 'd', 0,0,0, 0,0, 0},
    {"err1_th_diff", 1046, OUR(err1_th_diff), 'd', 0,0,0, 0,0, 0},
    {"err1_isfirst0", 1054, OUR(err1_isfirst0), 'B', 0,0,0, 0,0, 0},
    {"err1_isfirst1", 1055, OUR(err1_isfirst1), 'B', 0,0,0, 0,0, 0},
    {"err1_isfirst2", 1056, OUR(err1_isfirst2), 'B', 0,0,0, 0,0, 0},
    {"err1_n", 1057, OUR(err1_n), 'H', 0,0,0, 0,0, 0},
    {"err1_random_noise_temp_break", 1059, OUR(err1_random_noise_temp_break), 'B', 0,0,0, 0,0, 0},
    {"err1_result", 1060, OUR(err1_result), 'B', 0,0,0, 0,0, 0},
    {"err1_result_TD", 1070, OUR(err1_result_TD), 'B', 0,0,0, 0,0, 0},
    /* err2 debug fields — oracle offsets verified from binary */
    {"err2_delay_revised_value", 1076, OUR(err2_delay_revised_value), 'd', 0,0,0, 0,0, 0},
    {"err2_delay_roc", 1084, OUR(err2_delay_roc), 'd', 0,0,0, 0,0, 0},
    {"err2_delay_slope_sharp", 1092, OUR(err2_delay_slope_sharp), 'd', 0,0,0, 0,0, 0},
    {"err2_delay_roc_cummax", 1100, OUR(err2_delay_roc_cummax), 'd', 0,0,0, 0,0, 0},
    {"err2_delay_flag", 1132, OUR(err2_delay_flag), 'B', 0,0,0, 0,0, 0},
    {"err2_cummax", 1133, OUR(err2_cummax), 'd', 0,0,0, 0,0, 0},
    /* err4 debug fields */
    {"err4_min", 1155, OUR(err4_min), 'd', 0,0,0, 0,0, 0},
    {"err4_range", 1163, OUR(err4_range), 'd', 0,0,0, 0,0, 0},
    {"err4_min_diff", 1171, OUR(err4_min_diff), 'd', 0,0,0, 0,0, 0},
    /* err16 debug fields */
    {"err16_CGM_plasma", 1219, OUR(err16_CGM_plasma), 'd', 0,0,0, 0,0, 0},
    {"err16_CGM_ISF_smooth", 1227, OUR(err16_CGM_ISF_smooth), 'd', 0,0,0, 0,0, 0},
    /* err128 */
    {"err128_flag", 1555, OUR(err128_flag), 'B', 0,0,0, 0,0, 0},
    {"err128_revised_value", 1556, OUR(err128_revised_value), 'd', 0,0,0, 0,0, 0},
    {"err128_normal", 1564, OUR(err128_normal), 'd', 0,0,0, 0,0, 0},
    {NULL, 0, -1, 0, 0,0,0, 0,0, 0}
};

/* Output fields — offsets match between our struct and oracle binary */
static struct field_stats output_fields[] = {
    {"seq_number_original", 0, -1, 'H', 0,0,0, 0,0, 0},
    {"seq_number_final", 2, -1, 'H', 0,0,0, 0,0, 0},
    {"measurement_time_standard", 4, -1, 'I', 0,0,0, 0,0, 0},
    {"result_glucose", 68, -1, 'd', 0,0,0, 0,0, 0},
    {"trendrate", 76, -1, 'd', 0,0,0, 0,0, 0},
    {"current_stage", 84, -1, 'B', 0,0,0, 0,0, 0},
    {"errcode", 151, -1, 'H', 0,0,0, 0,0, 0},
    {"cal_available_flag", 153, -1, 'B', 0,0,0, 0,0, 0},
    {"data_type", 154, -1, 'B', 0,0,0, 0,0, 0},
    {NULL, 0, -1, 0, 0,0,0, 0,0, 0}
};

static int load_file(const char *path, void *buf, size_t expected_size) {
    FILE *f = fopen(path, "rb");
    if (!f) return -1;
    size_t n = fread(buf, 1, expected_size, f);
    fclose(f);
    return (n == expected_size) ? 0 : -1;
}

/* Compare a single field between our struct bytes and oracle bytes.
 * Uses fs->offset for oracle binary, fs->our_offset for our struct
 * (our_offset == -1 means same as oracle offset). */
static void compare_field(struct field_stats *fs, const uint8_t *ours,
                          const uint8_t *oracle, int seq, int verbose) {
    fs->total++;
    int o_off = fs->offset;            /* oracle offset */
    int u_off = (fs->our_offset >= 0) ? fs->our_offset : fs->offset;  /* our offset */

    switch (fs->type) {
    case 'B': {
        uint8_t a, b;
        memcpy(&a, ours + u_off, 1);
        memcpy(&b, oracle + o_off, 1);
        if (a == b) { fs->match++; }
        else {
            fs->mismatch++;
            if (fs->first_mismatch_seq == 0) fs->first_mismatch_seq = seq;
            if (verbose)
                printf("  DIFF seq %3d %-35s: ours=%u oracle=%u\n",
                       seq, fs->name, a, b);
        }
        break;
    }
    case 'b': {
        int8_t a, b;
        memcpy(&a, ours + u_off, 1);
        memcpy(&b, oracle + o_off, 1);
        if (a == b) { fs->match++; }
        else {
            fs->mismatch++;
            if (fs->first_mismatch_seq == 0) fs->first_mismatch_seq = seq;
            if (verbose)
                printf("  DIFF seq %3d %-35s: ours=%d oracle=%d\n",
                       seq, fs->name, a, b);
        }
        break;
    }
    case 'H': {
        uint16_t a, b;
        memcpy(&a, ours + u_off, 2);
        memcpy(&b, oracle + o_off, 2);
        if (a == b) { fs->match++; }
        else {
            fs->mismatch++;
            if (fs->first_mismatch_seq == 0) fs->first_mismatch_seq = seq;
            if (verbose)
                printf("  DIFF seq %3d %-35s: ours=%u oracle=%u\n",
                       seq, fs->name, a, b);
        }
        break;
    }
    case 'I': {
        uint32_t a, b;
        memcpy(&a, ours + u_off, 4);
        memcpy(&b, oracle + o_off, 4);
        if (a == b) { fs->match++; }
        else {
            fs->mismatch++;
            if (fs->first_mismatch_seq == 0) fs->first_mismatch_seq = seq;
            if (verbose)
                printf("  DIFF seq %3d %-35s: ours=%u oracle=%u\n",
                       seq, fs->name, a, b);
        }
        break;
    }
    case 'd': {
        double a, b;
        memcpy(&a, ours + u_off, 8);
        memcpy(&b, oracle + o_off, 8);
        if ((isnan(a) && isnan(b)) || a == b) {
            fs->match++;
        } else if (isnan(a) || isnan(b)) {
            fs->mismatch++;
            if (fs->first_mismatch_seq == 0) fs->first_mismatch_seq = seq;
            if (verbose)
                printf("  DIFF seq %3d %-35s: ours=%g oracle=%g\n",
                       seq, fs->name, a, b);
        } else {
            double abs_err = fabs(a - b);
            double rel_err = (fabs(b) > 1e-10) ? abs_err / fabs(b) : abs_err;
            if (abs_err > fs->max_abs_err) fs->max_abs_err = abs_err;
            if (rel_err > fs->max_rel_err) fs->max_rel_err = rel_err;
            if (abs_err < 1e-12 || rel_err < 1e-10) {
                fs->match++;
            } else {
                fs->mismatch++;
                if (fs->first_mismatch_seq == 0) fs->first_mismatch_seq = seq;
                if (verbose)
                    printf("  DIFF seq %3d %-35s: ours=%.10g oracle=%.10g "
                           "(abs=%.2e rel=%.2e)\n",
                           seq, fs->name, a, b, abs_err, rel_err);
            }
        }
        break;
    }
    }
}

static void print_report(const char *section, struct field_stats *fields) {
    printf("\n=== %s Field Match Report ===\n", section);
    printf("%-40s %6s %6s %6s %8s %8s %s\n",
           "Field", "Total", "Match", "Miss", "MaxAbsE", "MaxRelE", "FirstMiss");
    printf("%-40s %6s %6s %6s %8s %8s %s\n",
           "-----", "-----", "-----", "----", "-------", "-------", "---------");

    int total_match = 0, total_mismatch = 0, total_total = 0;
    for (int i = 0; fields[i].name != NULL; i++) {
        struct field_stats *f = &fields[i];
        total_match += f->match;
        total_mismatch += f->mismatch;
        total_total += f->total;

        char abs_buf[16] = "-", rel_buf[16] = "-", first_buf[16] = "-";
        if (f->type == 'd' && f->max_abs_err > 0)
            snprintf(abs_buf, sizeof(abs_buf), "%.1e", f->max_abs_err);
        if (f->type == 'd' && f->max_rel_err > 0)
            snprintf(rel_buf, sizeof(rel_buf), "%.1e", f->max_rel_err);
        if (f->first_mismatch_seq > 0)
            snprintf(first_buf, sizeof(first_buf), "seq %d", f->first_mismatch_seq);

        const char *status = (f->mismatch == 0) ? " OK" : " FAIL";
        printf("%-40s %6d %6d %6d %8s %8s %-10s%s\n",
               f->name, f->total, f->match, f->mismatch,
               abs_buf, rel_buf, first_buf, status);
    }

    printf("\n  TOTAL: %d/%d fields match (%.1f%%)\n",
           total_match, total_total,
           total_total ? 100.0 * total_match / total_total : 0.0);
}

/* Also compare tran_inA array (30 doubles at offset 78) */
static struct field_stats tran_inA_stats = {"tran_inA[30]", 0, 'd', 0,0,0, 0,0, 0};

static void compare_tran_inA(const uint8_t *ours, const uint8_t *oracle,
                              int seq, int verbose) {
    for (int i = 0; i < 30; i++) {
        int off = 78 + i * 8;
        double a, b;
        memcpy(&a, ours + off, 8);
        memcpy(&b, oracle + off, 8);

        tran_inA_stats.total++;
        if (a == b || (isnan(a) && isnan(b))) {
            tran_inA_stats.match++;
        } else {
            double abs_err = fabs(a - b);
            double rel_err = (fabs(b) > 1e-10) ? abs_err / fabs(b) : abs_err;
            if (abs_err > tran_inA_stats.max_abs_err)
                tran_inA_stats.max_abs_err = abs_err;
            if (abs_err < 1e-12 || rel_err < 1e-10) {
                tran_inA_stats.match++;
            } else {
                tran_inA_stats.mismatch++;
                if (tran_inA_stats.first_mismatch_seq == 0)
                    tran_inA_stats.first_mismatch_seq = seq;
                if (verbose && i == 0)
                    printf("  DIFF seq %3d tran_inA[0]: ours=%.10g oracle=%.10g\n",
                           seq, a, b);
            }
        }
    }
}

int main(int argc, char **argv) {
    const char *oracle_dir = NULL;
    float eapp_override = 0.0f;
    int max_seq = 400;
    int verbose = 0;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--eapp") == 0 && i+1 < argc)
            eapp_override = (float)atof(argv[++i]);
        else if (strcmp(argv[i], "--max") == 0 && i+1 < argc)
            max_seq = atoi(argv[++i]);
        else if (strcmp(argv[i], "--verbose") == 0 || strcmp(argv[i], "-v") == 0)
            verbose = 1;
        else if (argv[i][0] != '-')
            oracle_dir = argv[i];
    }

    if (!oracle_dir) {
        fprintf(stderr, "Usage: %s <oracle_dir> [--eapp <val>] [--max <N>] [-v]\n",
                argv[0]);
        return 1;
    }

    /* Verify struct sizes match oracle */
    printf("Struct sizes: input=%zu output=%zu debug=%zu args=%zu\n",
           sizeof(struct air1_opcal4_cgm_input_t),
           sizeof(struct air1_opcal4_output_t),
           sizeof(struct air1_opcal4_debug_t),
           sizeof(struct air1_opcal4_arguments_t));

    if (sizeof(struct air1_opcal4_cgm_input_t) != 74 ||
        sizeof(struct air1_opcal4_output_t) != 155 ||
        sizeof(struct air1_opcal4_debug_t) != 1579) {
        fprintf(stderr, "ERROR: Struct size mismatch! Cannot compare against oracle.\n");
        fprintf(stderr, "  Expected: input=74 output=155 debug=1579\n");
        return 1;
    }

    /* Initialize device info identically to oracle harness */
    struct air1_opcal4_device_info_t dev_info;
    init_default_device_info(&dev_info);
    if (eapp_override != 0.0f) {
        dev_info.eapp = eapp_override;
        printf("Using eapp override: %f\n", eapp_override);
    }

    /* Allocate persistent state */
    struct air1_opcal4_arguments_t *algo_args = calloc(1, sizeof(*algo_args));
    if (!algo_args) {
        fprintf(stderr, "FATAL: Cannot allocate arguments_t (%zu bytes)\n",
                sizeof(*algo_args));
        return 1;
    }

    printf("Running comparison against %s (up to %d readings)...\n",
           oracle_dir, max_seq);

    int readings_compared = 0;
    int byte_match_total = 0, byte_mismatch_total = 0;

    for (int seq = 1; seq <= max_seq; seq++) {
        char path[512];

        /* Load oracle input */
        struct air1_opcal4_cgm_input_t cgm_input;
        snprintf(path, sizeof(path), "%s/seq_%04d_input.bin", oracle_dir, seq);
        if (load_file(path, &cgm_input, sizeof(cgm_input)) != 0) {
            if (seq == 1) {
                fprintf(stderr, "Cannot load %s\n", path);
                free(algo_args);
                return 1;
            }
            break; /* No more readings */
        }

        /* Load oracle output and debug for comparison */
        uint8_t oracle_output[155];
        uint8_t oracle_debug[1579];
        snprintf(path, sizeof(path), "%s/seq_%04d_output.bin", oracle_dir, seq);
        if (load_file(path, oracle_output, 155) != 0) break;
        snprintf(path, sizeof(path), "%s/seq_%04d_debug.bin", oracle_dir, seq);
        if (load_file(path, oracle_debug, 1579) != 0) break;

        /* Run OUR algorithm */
        struct air1_opcal4_cal_list_t cal_input;
        struct air1_opcal4_output_t our_output;
        struct air1_opcal4_debug_t our_debug;
        memset(&cal_input, 0, sizeof(cal_input));
        memset(&our_output, 0, sizeof(our_output));
        memset(&our_debug, 0, sizeof(our_debug));

        unsigned char ret = air1_opcal4_algorithm(
            &dev_info, &cgm_input, &cal_input, algo_args, &our_output, &our_debug);

        /* Compare debug fields */
        uint8_t *our_debug_bytes = (uint8_t *)&our_debug;
        for (int i = 0; debug_fields[i].name != NULL; i++) {
            compare_field(&debug_fields[i], our_debug_bytes, oracle_debug,
                          seq, verbose);
        }

        /* Compare tran_inA array */
        compare_tran_inA(our_debug_bytes, oracle_debug, seq, verbose);

        /* Compare output fields */
        uint8_t *our_output_bytes = (uint8_t *)&our_output;
        for (int i = 0; output_fields[i].name != NULL; i++) {
            compare_field(&output_fields[i], our_output_bytes, oracle_output,
                          seq, verbose);
        }

        /* Raw byte-level comparison */
        int debug_bytes_match = 0;
        for (int i = 0; i < 1579; i++) {
            if (our_debug_bytes[i] == oracle_debug[i])
                debug_bytes_match++;
        }
        byte_match_total += debug_bytes_match;
        byte_mismatch_total += (1579 - debug_bytes_match);

        /* Progress: show first 5, then every 50 */
        if (seq <= 5 || seq % 50 == 0 || seq == max_seq) {
            double oracle_glu, our_glu;
            memcpy(&oracle_glu, oracle_output + 68, 8);
            our_glu = our_output.result_glucose;

            uint16_t oracle_err, our_err;
            memcpy(&oracle_err, oracle_output + 151, 2);
            our_err = our_output.errcode;

            printf("  seq %3d: glu ours=%.2f oracle=%.2f | err ours=%d oracle=%d | "
                   "debug bytes %d/1579 (%.0f%%)\n",
                   seq, our_glu, oracle_glu, our_err, oracle_err,
                   debug_bytes_match,
                   100.0 * debug_bytes_match / 1579.0);
        }

        readings_compared++;
    }

    printf("\n%d readings compared.\n", readings_compared);

    /* Print field-level reports */
    print_report("DEBUG", debug_fields);

    /* tran_inA summary */
    printf("\n%-40s %6d %6d %6d %8.1e %8s %s\n",
           tran_inA_stats.name,
           tran_inA_stats.total, tran_inA_stats.match, tran_inA_stats.mismatch,
           tran_inA_stats.max_abs_err, "-",
           tran_inA_stats.first_mismatch_seq ?
               "seq X" : "-");

    print_report("OUTPUT", output_fields);

    /* Byte-level summary */
    int total_bytes = byte_match_total + byte_mismatch_total;
    printf("\nByte-level debug match: %d/%d (%.1f%%)\n",
           byte_match_total, total_bytes,
           total_bytes ? 100.0 * byte_match_total / total_bytes : 0.0);

    free(algo_args);
    return 0;
}
