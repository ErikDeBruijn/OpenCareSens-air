/*
 * Test Real Sensor Data — Adapter for Jaap's Juggluco BLE captures
 *
 * Reads pre-processed binary files:
 *   - device_info.bin   (446 bytes, from run6_0.h)
 *   - arguments_init.bin (117312 bytes, from run6_3.h)
 *   - real_data_packets.bin (extracted C5 BLE packets from data.hpp)
 *
 * Runs each reading through our reimplemented air1_opcal4_algorithm()
 * and outputs CSV: seq,timestamp,glucose,errcode,trendrate,stage
 *
 * Preprocessing: run extract_raw_arrays.py and extract_ble_packets.py first.
 *
 * Build:
 *   cc -O2 -Isrc tools/test_real_data.c src/calibration.c src/math_utils.c \
 *      src/signal_processing.c src/check_error.c -lm -o build/test_real_data
 *
 * Run:
 *   ./build/test_real_data [--data-dir build/] [--csv output.csv] [--verbose]
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <errno.h>

#include "calibration.h"

/* Our algorithm entry point */
extern unsigned char air1_opcal4_algorithm(
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_cgm_input_t *cgm_input,
    struct air1_opcal4_cal_list_t *cal_input,
    struct air1_opcal4_arguments_t *algo_args,
    struct air1_opcal4_output_t *algo_output,
    struct air1_opcal4_debug_t *algo_debug);

/* ---- AirData BLE packet layout (packed, little-endian) ---- */
/* Matches the struct in Juggluco's air.hpp */
#pragma pack(push, 1)
struct ble_air_data {
    uint8_t  reg0;              /* 0xC5 for sensor data */
    uint8_t  reg1;              /* always 0x01 */
    int8_t   deviceErrorCode;
    uint8_t  r_count;
    uint32_t a_count;
    uint32_t misc;
    uint32_t sequenceNumber;
    uint32_t time;
    uint16_t battery;
    uint16_t temperature;       /* actual temp * 100 */
    uint16_t glucose_array[30];
};
#pragma pack(pop)

/* ---- Binary packet file format ---- */
/* Header: 'BLEP' + uint32_t count */
/* Per record: uint32_t nowsec + uint16_t pktlen + pktlen bytes */

static int read_file(const char *path, void *buf, size_t expected) {
    FILE *f = fopen(path, "rb");
    if (!f) {
        fprintf(stderr, "ERROR: Cannot open %s: %s\n", path, strerror(errno));
        return -1;
    }
    size_t got = fread(buf, 1, expected, f);
    fclose(f);
    if (got != expected) {
        fprintf(stderr, "ERROR: %s: expected %zu bytes, got %zu\n",
                path, expected, got);
        return -1;
    }
    return 0;
}

static void *read_file_alloc(const char *path, size_t *out_size) {
    FILE *f = fopen(path, "rb");
    if (!f) {
        fprintf(stderr, "ERROR: Cannot open %s: %s\n", path, strerror(errno));
        return NULL;
    }
    fseek(f, 0, SEEK_END);
    long sz = ftell(f);
    fseek(f, 0, SEEK_SET);
    void *buf = malloc(sz);
    if (!buf) {
        fclose(f);
        return NULL;
    }
    size_t got = fread(buf, 1, sz, f);
    fclose(f);
    if ((long)got != sz) {
        free(buf);
        return NULL;
    }
    if (out_size) *out_size = (size_t)sz;
    return buf;
}

int main(int argc, char **argv) {
    const char *data_dir = "build";
    const char *csv_path = NULL;
    int verbose = 0;
    int max_readings = 0;  /* 0 = all */

    /* Parse arguments */
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--data-dir") == 0 && i + 1 < argc)
            data_dir = argv[++i];
        else if (strcmp(argv[i], "--csv") == 0 && i + 1 < argc)
            csv_path = argv[++i];
        else if (strcmp(argv[i], "--verbose") == 0 || strcmp(argv[i], "-v") == 0)
            verbose = 1;
        else if (strcmp(argv[i], "--max") == 0 && i + 1 < argc)
            max_readings = atoi(argv[++i]);
        else if (strcmp(argv[i], "--help") == 0) {
            printf("Usage: %s [--data-dir DIR] [--csv FILE] [--verbose] [--max N]\n",
                   argv[0]);
            printf("\nPreprocess first:\n");
            printf("  python3 tools/extract_raw_arrays.py\n");
            printf("  python3 tools/extract_ble_packets.py\n");
            return 0;
        }
    }

    /* ---- Load device_info ---- */
    char path[512];
    struct air1_opcal4_device_info_t dev_info;
    snprintf(path, sizeof(path), "%s/device_info.bin", data_dir);
    if (read_file(path, &dev_info, sizeof(dev_info)) < 0)
        return 1;
    printf("Loaded device_info: sensor_version=%d, slope100=%.4f, ycept=%.4f\n",
           dev_info.sensor_version, dev_info.slope100, dev_info.ycept);
    printf("  lot=%.10s  sensor_id=%.12s  expiry=%.6s\n",
           dev_info.lot, dev_info.sensor_id, dev_info.expiry_date);
    printf("  vref=%.5f  eapp=%.5f  sensor_start_time=%u\n",
           dev_info.vref, dev_info.eapp, dev_info.sensor_start_time);
    printf("  slope=%.4f  slope_ratio=%.4f  basic_warmup=%d\n",
           dev_info.slope, dev_info.slope_ratio, dev_info.basic_warmup);

    /* ---- Load initial arguments ---- */
    struct air1_opcal4_arguments_t *algo_args =
        (struct air1_opcal4_arguments_t *)calloc(1, sizeof(*algo_args));
    if (!algo_args) {
        fprintf(stderr, "FATAL: Cannot allocate arguments_t (%zu bytes)\n",
                sizeof(*algo_args));
        return 1;
    }
    snprintf(path, sizeof(path), "%s/arguments_init.bin", data_dir);
    if (read_file(path, algo_args, sizeof(*algo_args)) < 0) {
        free(algo_args);
        return 1;
    }
    printf("Loaded arguments_t: args_seq=%u, start_seq=%u\n",
           algo_args->args_seq, algo_args->start_seq);

    /* ---- Load BLE packets ---- */
    size_t pkt_file_size = 0;
    snprintf(path, sizeof(path), "%s/real_data_packets.bin", data_dir);
    uint8_t *pkt_data = (uint8_t *)read_file_alloc(path, &pkt_file_size);
    if (!pkt_data) {
        free(algo_args);
        return 1;
    }

    /* Parse header */
    if (pkt_file_size < 8 || memcmp(pkt_data, "BLEP", 4) != 0) {
        fprintf(stderr, "ERROR: Invalid packet file (bad magic)\n");
        free(pkt_data);
        free(algo_args);
        return 1;
    }
    uint32_t num_packets;
    memcpy(&num_packets, pkt_data + 4, 4);
    printf("Loaded %u C5 BLE packets\n", num_packets);

    /* ---- Open CSV output ---- */
    FILE *csv = NULL;
    if (csv_path) {
        csv = fopen(csv_path, "w");
        if (!csv) {
            fprintf(stderr, "ERROR: Cannot open %s: %s\n", csv_path, strerror(errno));
            free(pkt_data);
            free(algo_args);
            return 1;
        }
    } else {
        csv = stdout;
    }

    /* CSV header */
    fprintf(csv, "pkt_idx,seq_number,timestamp,glucose,errcode,trendrate,"
                 "stage,ret,seq_final,err1,err2,err4,err8,err16,err32,"
                 "temperature,deviceErrorCode,"
                 "tran_inA_5min,corrected_re_current,ycept,out_iir,out_drift,"
                 "curr_baseline,slope_ratio_temp,init_cg,opcal_ad\n");

    /* ---- Process packets ---- */
    size_t offset = 8;  /* past header */
    int success_count = 0;
    int error_count = 0;
    int skip_count = 0;
    int processed = 0;

    for (uint32_t pkt_idx = 0; pkt_idx < num_packets; pkt_idx++) {
        if (max_readings > 0 && processed >= max_readings)
            break;

        /* Read record header */
        if (offset + 6 > pkt_file_size) {
            fprintf(stderr, "ERROR: Unexpected end of packet file at pkt %u\n",
                    pkt_idx);
            break;
        }
        uint32_t nowsec;
        uint16_t pkt_len;
        memcpy(&nowsec, pkt_data + offset, 4);
        memcpy(&pkt_len, pkt_data + offset + 4, 2);
        offset += 6;

        if (offset + pkt_len > pkt_file_size) {
            fprintf(stderr, "ERROR: Packet %u truncated\n", pkt_idx);
            break;
        }

        const uint8_t *raw = pkt_data + offset;
        offset += pkt_len;

        /* Validate minimum size */
        if (pkt_len < sizeof(struct ble_air_data)) {
            if (verbose)
                fprintf(stderr, "  pkt %u: too short (%u < %zu), skipping\n",
                        pkt_idx, pkt_len, sizeof(struct ble_air_data));
            skip_count++;
            continue;
        }

        /* Parse AirData from raw bytes */
        const struct ble_air_data *air =
            (const struct ble_air_data *)raw;

        /* Verify it's a C5 packet */
        if (air->reg0 != 0xC5 || air->reg1 != 0x01) {
            skip_count++;
            continue;
        }

        /* Skip if device error */
        if (air->deviceErrorCode != 0) {
            if (verbose)
                fprintf(stderr, "  pkt %u: deviceErrorCode=%d, skipping\n",
                        pkt_idx, air->deviceErrorCode);
            skip_count++;

            /* Still output a row for tracking */
            fprintf(csv, "%u,%u,%u,0,0,0.0,0,0,0,0,0,0,0,0,0,%.2f,%d\n",
                    pkt_idx, air->sequenceNumber, air->time,
                    air->temperature / 100.0, air->deviceErrorCode);
            continue;
        }

        /* ---- Construct cgm_input from BLE data ---- */
        /* Following testdata.cpp lines 343-348 */
        struct air1_opcal4_cgm_input_t cgm_input;
        memset(&cgm_input, 0, sizeof(cgm_input));

        uint32_t mtime = air->time;
        /* Time sanity check (from testdata.cpp line 334) */
        if (mtime < 31532400) {
            /* Use nowsec as fallback (approximate) */
            mtime = nowsec;
        }

        cgm_input.seq_number = (uint16_t)air->sequenceNumber;
        cgm_input.measurement_time_standard = mtime;
        /* Copy glucose array (workout = glucose_array in the API) */
        memcpy(cgm_input.workout, air->glucose_array,
               sizeof(cgm_input.workout));
        cgm_input.temperature = air->temperature / 100.0;

        /* Empty calibration list */
        struct air1_opcal4_cal_list_t cal_input;
        memset(&cal_input, 0, sizeof(cal_input));

        /* Zero output and debug */
        struct air1_opcal4_output_t output;
        struct air1_opcal4_debug_t debug;
        memset(&output, 0, sizeof(output));
        memset(&debug, 0, sizeof(debug));

        /* ---- Call our algorithm ---- */
        unsigned char ret = air1_opcal4_algorithm(
            &dev_info, &cgm_input, &cal_input, algo_args, &output, &debug);

        processed++;

        if (ret && !output.errcode) {
            success_count++;
        } else {
            error_count++;
        }

        /* Output CSV row */
        fprintf(csv, "%u,%u,%u,%.6f,%u,%.6f,%u,%u,%u,%u,%u,%u,%u,%u,%u,%.2f,%d,"
                     "%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f\n",
                pkt_idx,
                (unsigned)cgm_input.seq_number,
                cgm_input.measurement_time_standard,
                output.result_glucose,
                output.errcode,
                output.trendrate,
                (unsigned)output.current_stage,
                (unsigned)ret,
                (unsigned)output.seq_number_final,
                (unsigned)debug.error_code1,
                (unsigned)debug.error_code2,
                (unsigned)debug.error_code4,
                (unsigned)debug.error_code8,
                (unsigned)debug.error_code16,
                (unsigned)debug.error_code32,
                cgm_input.temperature,
                air->deviceErrorCode,
                /* debug intermediates */
                debug.tran_inA_5min,
                debug.corrected_re_current,
                debug.ycept,
                debug.out_iir,
                debug.out_drift,
                debug.curr_baseline,
                debug.slope_ratio_temp,
                debug.init_cg,
                debug.opcal_ad);

        /* Progress */
        if (verbose ||
            processed <= 30 || processed % 100 == 0 ||
            output.errcode) {
            fprintf(stderr, "  pkt %4u seq %4u: ret=%d glucose=%.1f "
                    "errcode=%u (e1=%d e2=%d e4=%d e8=%d e16=%d e32=%d) "
                    "stage=%d trend=%.3f temp=%.1f\n",
                    pkt_idx,
                    (unsigned)cgm_input.seq_number,
                    (int)ret,
                    output.result_glucose,
                    output.errcode,
                    debug.error_code1, debug.error_code2, debug.error_code4,
                    debug.error_code8, debug.error_code16, debug.error_code32,
                    (int)output.current_stage,
                    output.trendrate,
                    cgm_input.temperature);
        }
    }

    fprintf(stderr, "\nDone. Processed %d readings: %d success, %d with errors, "
            "%d skipped\n", processed, success_count, error_count, skip_count);

    if (csv != stdout && csv)
        fclose(csv);
    free(pkt_data);
    free(algo_args);
    return 0;
}
