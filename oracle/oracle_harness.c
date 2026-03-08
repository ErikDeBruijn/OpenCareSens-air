/*
 * Oracle Harness — Calls the real libCALCULATION.so and dumps debug output
 *
 * Compiles and runs on ARM (armv7/armhf) via Docker or native device.
 * Uses dlopen/dlsym to call air1_opcal4_algorithm, same as Juggluco does.
 *
 * Output: binary dumps of debug_t, output_t, and arguments_t for each reading,
 * giving us ground truth for every intermediate computation.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>
#include <math.h>
#include <errno.h>
#include <sys/stat.h>

#include "../src/calibration.h"

/* Default device_info matching Juggluco's DeviceInfo2Obj defaults */
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
    /* drift_coefficient: identity-like */
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
    di->sensor_start_time = 1709726400; /* 2024-03-06 12:00:00 UTC */
}

/* Generate synthetic ADC readings for a glucose level */
static void generate_adc_readings(uint16_t *workout, double glucose_mg_dl,
                                  float vref, float eapp, float slope100) {
    /*
     * The real conversion chain (from decompiled code):
     *   normalized = adc / 10.0
     *   current = ((normalized / 65536.0) * vref - eapp) / 10.0 * (slope100 / 100.0)
     *
     * Reverse: given target glucose ≈ target current (simplified):
     *   current = glucose (rough approximation for synthetic data)
     *   (current / (slope100/100)) * 10 + eapp = (adc/10/65536) * vref
     *   adc = ((current / (slope100/100) * 10 + eapp) / vref) * 65536 * 10
     *
     * Typical realistic ranges: ADC 8000-25000 for glucose 40-400 mg/dL.
     * We use a simple linear mapping for synthetic test data.
     */
    /* Linear mapping: glucose 40→ADC 8000, glucose 400→ADC 25000 */
    double adc_base = 8000.0 + (glucose_mg_dl - 40.0) * (25000.0 - 8000.0) / (400.0 - 40.0);
    if (adc_base < 4000) adc_base = 4000;
    if (adc_base > 40000) adc_base = 40000;

    for (int i = 0; i < 30; i++) {
        /* Realistic noise: ~1-2% variation + some systematic drift */
        double noise = (i % 7 - 3) * (adc_base * 0.005)  /* ±0.5% systematic */
                     + ((i * 7 + 13) % 11 - 5) * (adc_base * 0.002); /* ±0.2% random-like */
        double adc_val = adc_base + noise;
        if (adc_val < 100) adc_val = 100;
        if (adc_val > 65000) adc_val = 65000;
        workout[i] = (uint16_t)(adc_val + 0.5);
    }
}

static int write_binary(const char *path, const void *data, size_t size) {
    FILE *f = fopen(path, "wb");
    if (!f) {
        fprintf(stderr, "ERROR: Cannot write %s: %s\n", path, strerror(errno));
        return -1;
    }
    if (fwrite(data, 1, size, f) != size) {
        fprintf(stderr, "ERROR: Short write to %s\n", path);
        fclose(f);
        return -1;
    }
    fclose(f);
    return 0;
}

/*
 * Test scenario: a complete glucose session
 * - 24 warmup readings (glucose ~100 mg/dL)
 * - 100 stable readings (~120 mg/dL)
 * - 50 rising readings (120→200 mg/dL)
 * - 50 stable high readings (~200 mg/dL)
 * - 50 falling readings (200→100 mg/dL)
 * - 126 stable readings (~100 mg/dL)
 * Total: 400 readings
 */
static double glucose_profile(int seq) {
    if (seq <= 24) return 100.0;                           /* warmup */
    if (seq <= 124) return 120.0;                          /* stable normal */
    if (seq <= 174) return 120.0 + (seq - 124) * 1.6;     /* rising */
    if (seq <= 224) return 200.0;                          /* stable high */
    if (seq <= 274) return 200.0 - (seq - 224) * 2.0;     /* falling */
    return 100.0;                                          /* stable low */
}

int main(int argc, char **argv) {
    const char *so_path = "./libCALCULATION.so";
    const char *output_dir = "./output";
    int num_readings = 400;
    float eapp_override = 0.0f; /* 0 = use default */
    int shift_m2_override[3] = {-1, -1, -1}; /* -1 = use default */
    int slope_factor_override = -1;
    int correct1_override = -1;

    /* Parse args */
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--so") == 0 && i+1 < argc)
            so_path = argv[++i];
        else if (strcmp(argv[i], "--output") == 0 && i+1 < argc)
            output_dir = argv[++i];
        else if (strcmp(argv[i], "--readings") == 0 && i+1 < argc)
            num_readings = atoi(argv[++i]);
        else if (strcmp(argv[i], "--eapp") == 0 && i+1 < argc)
            eapp_override = (float)atof(argv[++i]);
        else if (strcmp(argv[i], "--shift_m2_0") == 0 && i+1 < argc)
            shift_m2_override[0] = atoi(argv[++i]);
        else if (strcmp(argv[i], "--shift_m2_1") == 0 && i+1 < argc)
            shift_m2_override[1] = atoi(argv[++i]);
        else if (strcmp(argv[i], "--shift_m2_2") == 0 && i+1 < argc)
            shift_m2_override[2] = atoi(argv[++i]);
        else if (strcmp(argv[i], "--slope_factor") == 0 && i+1 < argc)
            slope_factor_override = atoi(argv[++i]);
        else if (strcmp(argv[i], "--correct1") == 0 && i+1 < argc)
            correct1_override = atoi(argv[++i]);
        else if (strcmp(argv[i], "--help") == 0) {
            printf("Usage: %s [--so path] [--output dir] [--readings N] [--eapp val] [--shift_m2_0 N] [--shift_m2_1 N] [--shift_m2_2 N]\n", argv[0]);
            return 0;
        }
    }

    /* Load library */
    printf("Loading %s...\n", so_path);
    void *lib = dlopen(so_path, RTLD_NOW);
    if (!lib) {
        fprintf(stderr, "FATAL: dlopen failed: %s\n", dlerror());
        return 1;
    }

    air1_opcal4_algorithm_fn algo =
        (air1_opcal4_algorithm_fn)dlsym(lib, "air1_opcal4_algorithm");
    if (!algo) {
        fprintf(stderr, "FATAL: dlsym failed: %s\n", dlerror());
        dlclose(lib);
        return 1;
    }
    printf("Found air1_opcal4_algorithm at %p\n", (void*)algo);

    /* Create output directory */
    mkdir(output_dir, 0755);

    /* Initialize structs */
    struct air1_opcal4_device_info_t dev_info;
    init_default_device_info(&dev_info);
    if (eapp_override != 0.0f) {
        dev_info.eapp = eapp_override;
        printf("Using eapp override: %f\n", eapp_override);
    }
    for (int k = 0; k < 3; k++) {
        if (shift_m2_override[k] >= 0) {
            dev_info.shift_m2_x100[k] = (int16_t)shift_m2_override[k];
            printf("shift_m2_x100[%d] = %d\n", k, shift_m2_override[k]);
        }
    }
    if (slope_factor_override >= 0) {
        dev_info.slope_factor_x10 = (int16_t)slope_factor_override;
        printf("slope_factor_x10 = %d\n", slope_factor_override);
    }
    if (correct1_override >= 0) {
        dev_info.correct1_flag = (uint8_t)correct1_override;
        printf("correct1_flag = %d\n", correct1_override);
    }

    /* arguments_t is ~106KB, must be zeroed and persistent across calls */
    struct air1_opcal4_arguments_t *algo_args =
        (struct air1_opcal4_arguments_t *)calloc(1, sizeof(*algo_args));
    if (!algo_args) {
        fprintf(stderr, "FATAL: Cannot allocate arguments_t (%zu bytes)\n",
                sizeof(*algo_args));
        return 1;
    }

    printf("Struct sizes: dev_info=%zu, cgm_input=%zu, cal_list=%zu, "
           "arguments=%zu, output=%zu, debug=%zu\n",
           sizeof(dev_info),
           sizeof(struct air1_opcal4_cgm_input_t),
           sizeof(struct air1_opcal4_cal_list_t),
           sizeof(*algo_args),
           sizeof(struct air1_opcal4_output_t),
           sizeof(struct air1_opcal4_debug_t));

    uint32_t base_time = dev_info.sensor_start_time;
    int success_count = 0;
    int error_count = 0;

    printf("Running %d sequential readings (eapp=%.5f)...\n",
           num_readings, dev_info.eapp);

    for (int seq = 1; seq <= num_readings; seq++) {
        struct air1_opcal4_cgm_input_t cgm_input;
        struct air1_opcal4_cal_list_t cal_input;
        struct air1_opcal4_output_t output;
        struct air1_opcal4_debug_t debug;

        memset(&cgm_input, 0, sizeof(cgm_input));
        memset(&cal_input, 0, sizeof(cal_input));
        memset(&output, 0, sizeof(output));
        memset(&debug, 0, sizeof(debug));

        /* Set up input */
        cgm_input.seq_number = (uint16_t)seq;
        cgm_input.measurement_time_standard = base_time + seq * 300; /* 5 min intervals */
        cgm_input.temperature = 36.5; /* body temperature in °C */

        double target_glucose = glucose_profile(seq);
        generate_adc_readings(cgm_input.workout, target_glucose,
                              dev_info.vref, dev_info.eapp, dev_info.slope100);

        /* Call the real algorithm */
        unsigned char result = algo(&dev_info, &cgm_input, &cal_input,
                                    algo_args, &output, &debug);

        /* Save binary outputs */
        char path[512];

        snprintf(path, sizeof(path), "%s/seq_%04d_input.bin", output_dir, seq);
        write_binary(path, &cgm_input, sizeof(cgm_input));

        snprintf(path, sizeof(path), "%s/seq_%04d_output.bin", output_dir, seq);
        write_binary(path, &output, sizeof(output));

        snprintf(path, sizeof(path), "%s/seq_%04d_debug.bin", output_dir, seq);
        write_binary(path, &debug, sizeof(debug));

        /* Save arguments checkpoint: every reading for full validation */
        if (1) {
            snprintf(path, sizeof(path), "%s/seq_%04d_args.bin", output_dir, seq);
            write_binary(path, algo_args, sizeof(*algo_args));
        }

        /* Print progress */
        if (!output.errcode) {
            success_count++;
        } else {
            error_count++;
        }
        if (seq <= 30 || seq % 50 == 0 || output.errcode) {
            printf("  seq %4d: ret=%d glucose=%u errcode=%d (err1=%d err2=%d err4=%d err8=%d err16=%d err32=%d) "
                   "stage=%d trend=%.3f (target=%.0f)\n",
                   seq, result, (unsigned)output.result_glucose, output.errcode,
                   debug.error_code1, debug.error_code2, debug.error_code4,
                   debug.error_code8, debug.error_code16, debug.error_code32,
                   (int)output.current_stage, output.trendrate, target_glucose);
        }
    }

    printf("\nDone. %d readings: %d success, %d with errors\n",
           num_readings, success_count, error_count);
    printf("Output saved to %s/ (%d input + %d output + %d debug files)\n",
           output_dir, num_readings, num_readings, num_readings);

    /* Save final arguments state */
    {
        char fpath[512];
        snprintf(fpath, sizeof(fpath), "%s/final_args.bin", output_dir);
        write_binary(fpath, algo_args, sizeof(*algo_args));
        printf("Final arguments_t saved (%zu bytes)\n", sizeof(*algo_args));
    }

    free(algo_args);
    dlclose(lib);
    return 0;
}
