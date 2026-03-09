#ifndef CARESENS_CHECK_ERROR_H
#define CARESENS_CHECK_ERROR_H

#include "calibration.h"

/* Master error detection function.
 * Evaluates 7 independent error conditions (err1, err2, err4, err8, err16, err32, err128).
 * Sets individual error_code fields in debug_t and returns combined errcode bitmask.
 *
 * This is the largest single function in the binary (8008 ARM instructions).
 * Must be verified field-by-field against the oracle debug_t output.
 */
uint16_t check_error(
    struct air1_opcal4_device_info_t *dev_info,
    struct air1_opcal4_arguments_t *algo_args,
    struct air1_opcal4_debug_t *debug,
    double current_glucose,
    double corrected_current,
    uint16_t seq,
    uint32_t time_now,
    uint8_t stage
);

#endif
