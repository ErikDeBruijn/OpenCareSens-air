/*
 * Oracle Test Harness for CareSens Air Calibration Algorithm
 *
 * This program dlopen's the proprietary libCALCULATION.so and calls
 * air1_opcal4_algorithm with synthetic test vectors, capturing the
 * complete debug_t, output_t, and arguments_t structs for each call.
 *
 * Usage: oracle_harness <path-to-libCALCULATION.so> <output-dir>
 *
 * The harness runs multiple test sessions with different lot_types,
 * each with sequential readings that exercise warmup, stable, rising,
 * falling, and edge-case glucose scenarios.
 *
 * This file is part of the OpenCareSens Air project (GPL-2.0+).
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <dlfcn.h>
#include <sys/stat.h>
#include <errno.h>
#include <math.h>
#include <time.h>

/* Include the struct definitions from src/ */
#include "../src/calibration.h"

/* ──────────────────────────────────────────────────────────────────
 * Configuration
 * ────────────────────────────────────────────────────────────────── */

/*
 * Number of readings per test session. A full 15-day sensor session
 * has 4320 readings (5-minute intervals). We run a shorter session
 * for faster iteration but long enough to exercise all code paths:
 * - Warmup phase: readings 1-24
 * - Stable phase: readings 25-100
 * - Rising phase: readings 101-200
 * - Falling phase: readings 201-300
 * - Spike/noise: readings 301-320
 * - Back to stable: readings 321-400
 * Total: 400 readings (~33 hours of sensor data)
 */
#define SESSION_READINGS  400

/* Checkpoints at which to save full arguments_t state */
static const uint16_t args_checkpoints[] = {
    1, 24, 25, 50, 100, 150, 200, 250, 300, 350, 400
};
#define NUM_CHECKPOINTS (sizeof(args_checkpoints) / sizeof(args_checkpoints[0]))

/* Starting unix timestamp (arbitrary but reproducible) */
#define SESSION_START_TIME 1700000000U  /* 2023-11-14 22:13:20 UTC */

/* 5-minute interval between readings */
#define READING_INTERVAL_SEC 300

/* ──────────────────────────────────────────────────────────────────
 * lot_type determination (from disassembly analysis)
 *
 * The algorithm uses eapp to determine lot_type on the first call:
 *   eapp < 0.075  => lot_type 2
 *   eapp == 0.075 => lot_type 0
 *   eapp > 0.075  => lot_type 1
 *
 * We test all three with distinct eapp values.
 * ────────────────────────────────────────────────────────────────── */

struct session_config {
    const char *name;
    float eapp;
    uint8_t expected_lot_type;
};

static const struct session_config sessions[] = {
    { "session_lottype0", 0.075f,   0 },
    { "session_lottype1", 0.10067f, 1 },  /* Default from sensor */
    { "session_lottype2", 0.050f,   2 },
};
#define NUM_SESSIONS (sizeof(sessions) / sizeof(sessions[0]))

/* ──────────────────────────────────────────────────────────────────
 * Utility functions
 * ────────────────────────────────────────────────────────────────── */

static int mkdirs(const char *path) {
    char tmp[512];
    char *p = NULL;
    size_t len;

    snprintf(tmp, sizeof(tmp), "%s", path);
    len = strlen(tmp);
    if (tmp[len - 1] == '/')
        tmp[len - 1] = '\0';

    for (p = tmp + 1; *p; p++) {
        if (*p == '/') {
            *p = '\0';
            if (mkdir(tmp, 0755) != 0 && errno != EEXIST)
                return -1;
            *p = '/';
        }
    }
    return mkdir(tmp, 0755) != 0 && errno != EEXIST ? -1 : 0;
}

static int write_bin(const char *path, const void *data, size_t size) {
    FILE *f = fopen(path, "wb");
    if (!f) {
        fprintf(stderr, "ERROR: Cannot open %s for writing: %s\n", path, strerror(errno));
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

static int is_checkpoint(uint16_t seq) {
    for (size_t i = 0; i < NUM_CHECKPOINTS; i++) {
        if (args_checkpoints[i] == seq)
            return 1;
    }
    return 0;
}

/* ──────────────────────────────────────────────────────────────────
 * Device info initialization
 *
 * Matches DeviceInfo2Obj defaults from air.hpp (lines 604-720)
 * exactly, then overrides eapp/vref/sensor_start_time per session.
 * ────────────────────────────────────────────────────────────────── */

static void init_device_info(struct air1_opcal4_device_info_t *di, const struct session_config *cfg) {
    memset(di, 0, sizeof(*di));

    di->sensor_version = 1;
    di->ycept = 1.0f;
    di->slope100 = 3.5226f;
    di->slope = 1.0f;
    di->r2 = 0.0f;
    di->t90 = 0.0f;
    di->slope_ratio = 1.0f;
    /* lot, sensor_id, expiry_date: leave zeroed */
    di->stabilizationInterval = 1800;  /* Juggluco overrides default 7200 to 1800 in airSaveSensorInfo */
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
    /* drift_coefficient: all zero except [i][2] = 1.0f */
    di->drift_coefficient[0][0] = 0.0f;
    di->drift_coefficient[0][1] = 0.0f;
    di->drift_coefficient[0][2] = 1.0f;
    di->drift_coefficient[1][0] = 0.0f;
    di->drift_coefficient[1][1] = 0.0f;
    di->drift_coefficient[1][2] = 1.0f;
    di->drift_coefficient[2][0] = 0.0f;
    di->drift_coefficient[2][1] = 0.0f;
    di->drift_coefficient[2][2] = 1.0f;
    di->i_ref_x100 = 100;
    di->coef_length = 1;
    di->div_point = 1;
    di->iir_flag = 1;
    di->iir_st_d_x10 = 90;
    di->correct1_flag = 1;
    di->correct1_coeff[0] = 0.0f;
    di->correct1_coeff[1] = 0.0f;
    di->correct1_coeff[2] = 1.0f;
    di->correct1_coeff[3] = 0.0f;
    di->kalman_t90 = 10;
    di->kalman_delta_t = 5;
    di->kalman_q_x100[0][0] = -115;
    di->kalman_q_x100[0][1] = 0;
    di->kalman_q_x100[0][2] = 0;
    di->kalman_q_x100[1][0] = 0;
    di->kalman_q_x100[1][1] = 1440;
    di->kalman_q_x100[1][2] = 0;
    di->kalman_q_x100[2][0] = 0;
    di->kalman_q_x100[2][1] = 0;
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
    di->shift_coeff[0] = 0.0f;
    di->shift_coeff[1] = 0.0f;
    di->shift_coeff[2] = 1.0f;
    di->shift_coeff[3] = 0.0f;
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
    di->err1_seq[0] = 23;
    di->err1_seq[1] = 47;
    di->err1_seq[2] = 11;
    di->err1_contact_bad = 0.5f;
    di->err1_th_diff = 2.0f;
    di->err1_th_sse_dmean[0] = 0.05f;
    di->err1_th_sse_dmean[1] = 0.1f;
    di->err1_th_sse_dmean[2] = 0.5f;
    di->err1_th_n1[0] = 43;
    di->err1_th_n1[1] = 40;
    di->err1_th_n1[2] = 37;
    di->err1_th_n1[3] = 34;
    di->err1_th_n2[0][0] = 2;
    di->err1_th_n2[0][1] = 6;
    di->err1_th_n2[1][0] = 4;
    di->err1_th_n2[1][1] = 8;
    di->err1_n_consecutive = 6;
    di->err1_i_sse_dmean_now[0] = 3.0f;
    di->err1_i_sse_dmean_now[1] = 0.001f;
    di->err1_count_sse_dmean = 12;
    di->err1_n_last = 288;
    di->err1_multi[0] = 10;
    di->err1_multi[1] = 10;
    di->err1_current_avg_diff = 1.0E-15f;
    di->err2_start_seq = 289;
    di->err2_seq[0] = 20;
    di->err2_seq[1] = 11;
    di->err2_seq[2] = 6;
    di->err2_glu = 800.0f;
    di->err2_cv[0] = 10.0f;
    di->err2_cv[1] = 0.05f;
    di->err2_cv[2] = 10.0f;
    di->err2_cummax = 2;
    di->err2_multi = 10;
    di->err2_ycept = 2.0f;
    di->err2_alpha = 2.0f;
    di->err345_seq1[0] = 3;
    di->err345_seq1[1] = 576;
    di->err345_seq2 = 5;
    di->err345_seq3[0] = 5;
    di->err345_seq3[1] = 864;
    di->err345_seq3[2] = 24;
    di->err345_seq4[0] = 11;
    di->err345_seq4[1] = 23;
    di->err345_seq4[2] = 12;
    di->err345_seq4[3] = 288;
    di->err345_seq4[4] = 24;
    di->err345_seq5[0] = 11;
    di->err345_seq5[1] = 36;
    di->err345_seq5[2] = 288;
    di->err345_raw[0] = 0.1f;
    di->err345_raw[1] = 0.5f;
    di->err345_raw[2] = 0.2f;
    di->err345_raw[3] = 0.7f;
    di->err345_filtered[0] = 0.2f;
    di->err345_filtered[1] = 1.0f;
    di->err345_min[0] = 0.5f;
    di->err345_min[1] = 0.3f;
    di->err345_range = -1.0f;
    di->err345_n_range = 2;
    di->err345_md = 0.0f;
    di->err345_n_md = 6;
    di->err6_cal_n_pts = 3;
    di->err6_cal_basic_prct = 0.3f;
    di->err6_cal_basic_seq = 1440;
    di->err6_cal_origin_slope = 30.0f;
    di->err6_cal_in_vitro[0] = 0.0f;
    di->err6_cal_in_vitro[1] = 2.0f;
    di->err6_CGM_rpd = 0.55f;
    di->err6_CGM_slp = -0.2f;
    di->err6_CGM_low3d_seq = 24;
    di->err6_CGM_low3d_p = 0.32f;
    di->err6_CGM_low1d_seq = 24;
    di->err6_CGM_low1d_p = 0.3f;
    di->err6_CGM_prct[0] = 30;
    di->err6_CGM_prct[1] = 50;
    di->err6_CGM_prct[2] = 70;
    di->err6_CGM_day[0] = 1;
    di->err6_CGM_day[1] = 3;
    di->err6_CGM_BLE_bad[0] = 12;
    di->err6_CGM_BLE_bad[1] = 96;
    di->err6_CGM_poly2 = 0.7f;
    di->err32_dt[0] = 23;
    di->err32_dt[1] = 60;
    di->err32_n[0] = 3;
    di->err32_n[1] = 2;

    /* Per-session overrides */
    di->vref = 1.49594f;
    di->eapp = cfg->eapp;
    di->sensor_start_time = SESSION_START_TIME;
}

/* ──────────────────────────────────────────────────────────────────
 * Test vector generation
 *
 * Generates synthetic ADC readings that produce physiologically
 * plausible glucose traces. The ADC-to-current formula is:
 *   current = (ADC * vref / 65536 - eapp) * slope100 / 100
 *
 * For typical parameters (vref=1.49594, eapp=0.10067, slope100=3.5226):
 *   current ~= (ADC * 0.00002283 - 0.10067) * 0.035226
 *
 * A glucose of ~100 mg/dL maps to a current of roughly 5-8 nA.
 * ADC around 8000-12000 gives reasonable glucose values.
 * ────────────────────────────────────────────────────────────────── */

static uint16_t glucose_to_adc_approx(double target_glucose_mgdl) {
    /*
     * Approximate inverse: from target glucose to ADC.
     * The exact relationship depends on the algorithm's internal
     * calibration state, but for synthetic data we aim for
     * reasonable ADC values. The important thing is that readings
     * are internally consistent and sequential.
     *
     * Rough mapping from Juggluco observation:
     *   ADC ~8000 => ~80 mg/dL
     *   ADC ~10000 => ~120 mg/dL
     *   ADC ~12000 => ~160 mg/dL
     *   ADC ~14000 => ~200 mg/dL
     *
     * Linear approximation: ADC = 50 * glucose + 3000
     */
    double adc = 50.0 * target_glucose_mgdl + 3000.0;
    if (adc < 1000.0) adc = 1000.0;
    if (adc > 60000.0) adc = 60000.0;
    return (uint16_t)adc;
}

/*
 * Generate the ADC workout array for a given reading.
 *
 * All 30 sub-readings are set to the same base value with small
 * deterministic variation (no randomness for reproducibility).
 */
static void generate_workout(uint16_t workout[30], uint16_t base_adc, uint16_t seq) {
    for (int i = 0; i < 30; i++) {
        /* Small deterministic variation: +/- up to 50 ADC counts
         * based on position and sequence number */
        int16_t variation = (int16_t)((i * 7 + seq * 3) % 101) - 50;
        int32_t val = (int32_t)base_adc + variation;
        if (val < 0) val = 0;
        if (val > 65535) val = 65535;
        workout[i] = (uint16_t)val;
    }
}

/*
 * Generate the target glucose for a given sequence number.
 * This creates a realistic glucose trace:
 *
 * Seq 1-24:    Warmup - sensor stabilizing, ADC values start low and rise
 * Seq 25-100:  Stable - ~120 mg/dL (normal fasting glucose)
 * Seq 101-200: Rising - 120 -> 250 mg/dL (post-meal spike)
 * Seq 201-300: Falling - 250 -> 90 mg/dL (insulin response)
 * Seq 301-310: Spike - brief contact error (very low ADC)
 * Seq 311-320: Recovery - back to normal
 * Seq 321-400: Stable - ~110 mg/dL
 */
static double target_glucose(uint16_t seq) {
    if (seq <= 24) {
        /* Warmup: ramp from 60 to 120 */
        return 60.0 + (120.0 - 60.0) * (seq - 1) / 23.0;
    } else if (seq <= 100) {
        /* Stable at ~120 with small sinusoidal variation */
        return 120.0 + 5.0 * sin((double)(seq - 25) * 0.1);
    } else if (seq <= 200) {
        /* Rising: 120 -> 250 */
        return 120.0 + 130.0 * (seq - 100) / 100.0;
    } else if (seq <= 300) {
        /* Falling: 250 -> 90 */
        return 250.0 - 160.0 * (seq - 200) / 100.0;
    } else if (seq <= 310) {
        /* Contact error: very low signal (simulates sensor detach) */
        return 30.0;
    } else if (seq <= 320) {
        /* Recovery: 30 -> 110 */
        return 30.0 + 80.0 * (seq - 310) / 10.0;
    } else {
        /* Stable at ~110 */
        return 110.0 + 3.0 * sin((double)(seq - 321) * 0.08);
    }
}

static void generate_cgm_input(struct air1_opcal4_cgm_input_t *input,
                                uint16_t seq) {
    memset(input, 0, sizeof(*input));

    input->seq_number = seq;
    input->measurement_time_standard = SESSION_START_TIME + (uint32_t)seq * READING_INTERVAL_SEC;

    double glucose = target_glucose(seq);
    uint16_t base_adc = glucose_to_adc_approx(glucose);
    generate_workout(input->workout, base_adc, seq);

    /* Temperature: 32-34 C (skin temperature), slight variation */
    input->temperature = 33.0 + 0.5 * sin((double)seq * 0.05);
}

/* ──────────────────────────────────────────────────────────────────
 * Main: load library, run sessions, save oracle data
 * ────────────────────────────────────────────────────────────────── */

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <path-to-libCALCULATION.so> <output-dir>\n", argv[0]);
        fprintf(stderr, "\nExample:\n");
        fprintf(stderr, "  %s ./libCALCULATION.so ./oracle_output\n", argv[0]);
        return 1;
    }

    const char *lib_path = argv[1];
    const char *output_dir = argv[2];

    /* Verify struct sizes at runtime (before dlopen, useful for validation) */
    printf("Struct size verification:\n");
    printf("  device_info_t: %zu (expected 446)\n", sizeof(struct air1_opcal4_device_info_t));
    printf("  cgm_input_t:   %zu (expected 74)\n", sizeof(struct air1_opcal4_cgm_input_t));
    printf("  cal_list_t:    %zu (expected 751)\n", sizeof(struct air1_opcal4_cal_list_t));
    printf("  arguments_t:   %zu (expected 116030)\n", sizeof(struct air1_opcal4_arguments_t));
    printf("  output_t:      %zu (expected 155)\n", sizeof(struct air1_opcal4_output_t));
    printf("  debug_t:       %zu (expected 1579)\n", sizeof(struct air1_opcal4_debug_t));

    if (sizeof(struct air1_opcal4_device_info_t) != 446 ||
        sizeof(struct air1_opcal4_cgm_input_t) != 74 ||
        sizeof(struct air1_opcal4_cal_list_t) != 751 ||
        sizeof(struct air1_opcal4_arguments_t) != 116030 ||
        sizeof(struct air1_opcal4_output_t) != 155 ||
        sizeof(struct air1_opcal4_debug_t) != 1579) {
        fprintf(stderr, "ERROR: Struct size mismatch! Cannot proceed.\n");
        return 1;
    }
    printf("  All sizes OK.\n\n");

    /* Load the proprietary library */
    printf("Loading library: %s\n", lib_path);
    void *handle = dlopen(lib_path, RTLD_NOW);
    if (!handle) {
        fprintf(stderr, "ERROR: dlopen failed: %s\n", dlerror());
        return 1;
    }

    /* Resolve the algorithm function */
    air1_opcal4_algorithm_fn algo =
        (air1_opcal4_algorithm_fn)dlsym(handle, "air1_opcal4_algorithm");
    if (!algo) {
        fprintf(stderr, "ERROR: dlsym failed: %s\n", dlerror());
        dlclose(handle);
        return 1;
    }
    printf("Resolved air1_opcal4_algorithm at %p\n\n", (void *)algo);

    /* Allocate the large arguments struct on the heap */
    struct air1_opcal4_arguments_t *algo_args =
        (struct air1_opcal4_arguments_t *)calloc(1, sizeof(struct air1_opcal4_arguments_t));
    if (!algo_args) {
        fprintf(stderr, "ERROR: Failed to allocate arguments_t (%zu bytes)\n",
                sizeof(struct air1_opcal4_arguments_t));
        dlclose(handle);
        return 1;
    }

    int total_errors = 0;

    /* Run each test session */
    for (size_t s = 0; s < NUM_SESSIONS; s++) {
        const struct session_config *cfg = &sessions[s];
        printf("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");
        printf("Session: %s (eapp=%.5f, expected lot_type=%d)\n",
               cfg->name, cfg->eapp, cfg->expected_lot_type);
        printf("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");

        /* Create session output directory */
        char session_dir[512];
        snprintf(session_dir, sizeof(session_dir), "%s/%s", output_dir, cfg->name);
        if (mkdirs(session_dir) != 0) {
            fprintf(stderr, "ERROR: Cannot create directory %s: %s\n",
                    session_dir, strerror(errno));
            total_errors++;
            continue;
        }

        /* Initialize device_info for this session */
        struct air1_opcal4_device_info_t dev_info;
        init_device_info(&dev_info, cfg);

        /* Save the device_info */
        char path[640];
        snprintf(path, sizeof(path), "%s/input_device_info.bin", session_dir);
        if (write_bin(path, &dev_info, sizeof(dev_info)) != 0) {
            total_errors++;
            continue;
        }

        /* Zero the persistent algorithm state for fresh session */
        memset(algo_args, 0, sizeof(*algo_args));

        /* Empty calibration list (factory calibration only, same as Juggluco) */
        struct air1_opcal4_cal_list_t cal_list;
        memset(&cal_list, 0, sizeof(cal_list));

        int session_errors = 0;

        /* Run all readings sequentially */
        for (uint16_t seq = 1; seq <= SESSION_READINGS; seq++) {
            /* Generate input for this reading */
            struct air1_opcal4_cgm_input_t cgm_input;
            generate_cgm_input(&cgm_input, seq);

            /* Zero output and debug structs (same as Juggluco) */
            struct air1_opcal4_output_t output;
            struct air1_opcal4_debug_t debug;
            memset(&output, 0, sizeof(output));
            memset(&debug, 0, sizeof(debug));

            /* Call the algorithm */
            unsigned char res = algo(&dev_info, &cgm_input, &cal_list,
                                     algo_args, &output, &debug);

            /* Save input */
            snprintf(path, sizeof(path), "%s/seq_%04d_input.bin", session_dir, seq);
            if (write_bin(path, &cgm_input, sizeof(cgm_input)) != 0) {
                session_errors++;
                continue;
            }

            /* Save output */
            snprintf(path, sizeof(path), "%s/seq_%04d_output.bin", session_dir, seq);
            if (write_bin(path, &output, sizeof(output)) != 0) {
                session_errors++;
                continue;
            }

            /* Save debug (THE ORACLE) */
            snprintf(path, sizeof(path), "%s/seq_%04d_debug.bin", session_dir, seq);
            if (write_bin(path, &debug, sizeof(debug)) != 0) {
                session_errors++;
                continue;
            }

            /* Save arguments checkpoint if applicable */
            if (is_checkpoint(seq)) {
                snprintf(path, sizeof(path), "%s/seq_%04d_args_checkpoint.bin",
                         session_dir, seq);
                if (write_bin(path, algo_args, sizeof(*algo_args)) != 0) {
                    session_errors++;
                }
                printf("  [checkpoint] seq=%04d args saved (%zu bytes)\n",
                       seq, sizeof(*algo_args));
            }

            /* Print progress summary */
            if (seq <= 5 || seq == 24 || seq == 25 || seq == 100 ||
                seq == 200 || seq == 300 || seq == 310 || seq == 320 ||
                seq == SESSION_READINGS || (seq % 50 == 0)) {
                printf("  seq=%04d: res=%d errcode=%d glucose=%.1f trend=%.3f "
                       "stage=%d lot_type=%d\n",
                       seq, res, output.errcode, output.result_glucose,
                       output.trendrate, output.current_stage,
                       algo_args->lot_type);
            }
        }

        /* Verify lot_type was set as expected */
        if (algo_args->lot_type != cfg->expected_lot_type) {
            fprintf(stderr, "WARNING: %s: lot_type=%d (expected %d)\n",
                    cfg->name, algo_args->lot_type, cfg->expected_lot_type);
        } else {
            printf("  lot_type=%d (confirmed)\n", algo_args->lot_type);
        }

        printf("  Session complete: %d readings, %d errors\n\n",
               SESSION_READINGS, session_errors);
        total_errors += session_errors;
    }

    /* Summary */
    printf("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");
    printf("Oracle generation complete.\n");
    printf("  Sessions: %zu\n", NUM_SESSIONS);
    printf("  Readings per session: %d\n", SESSION_READINGS);
    printf("  Total files: %zu\n",
           NUM_SESSIONS * (1 + SESSION_READINGS * 3 + NUM_CHECKPOINTS));
    printf("  Errors: %d\n", total_errors);
    printf("  Output: %s\n", output_dir);
    printf("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");

    free(algo_args);
    dlclose(handle);
    return total_errors > 0 ? 1 : 0;
}
