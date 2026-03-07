/*
 * OpenCareSens Air - Open-source calibration algorithm
 *
 * Error detection pipeline functions ported from the CareSens Air
 * ARM binary (opcal4 version). The original check_error is a single
 * 8008-instruction function; we decompose it into per-detector
 * sub-functions for clarity and testability.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#ifndef CHECK_ERROR_H
#define CHECK_ERROR_H

#include <stdint.h>

/* Forward declarations */
struct air1_opcal4_arguments_t;
struct air1_opcal4_device_info_t;
struct air1_opcal4_debug_t;

/*
 * check_error: Main error detection pipeline.
 *
 * From ARM disasm @ 0x66688 (opcal4, 8008 instructions).
 *
 * Runs all 7 error detectors in sequence, then shifts err_delay_arr
 * and stores error_code32 into the debug struct.
 *
 * Processing order:
 *   1. err128 (noise/spike revision)
 *   2. err16  (sensor drift/degradation)
 *   3. err1   (contact/noise — most complex)
 *   4. err2   (rate-of-change)
 *   5. err4   (signal quality)
 *   6. err8   (boundary/sequence consistency)
 *   7. err32  (BLE data gap flag)
 *   8. Epilogue: shift err_delay_arr, store error_code32
 *
 * Note: The final errcode bitmask (err1|err2|err4|err8|err16) is
 * assembled in the main algorithm, NOT here. err32 controls
 * output.data_type rather than the errcode bitmask.
 *
 * Parameters:
 *   args:        Algorithm arguments struct (mutable state)
 *   dev_info:    Device/sensor configuration parameters
 *   debug:       Debug output struct (receives error codes and diagnostics)
 *   seq_current: Current sequence number
 *   glucose_value: Current glucose estimate (used by some detectors)
 */
void check_error(
    struct air1_opcal4_arguments_t *args,
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_debug_t *debug,
    uint16_t seq_current,
    double glucose_value);

#endif /* CHECK_ERROR_H */
