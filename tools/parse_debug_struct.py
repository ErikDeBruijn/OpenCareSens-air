#!/usr/bin/env python3
"""Parse air1_opcal4_debug_t (1579 bytes) and air1_opcal4_output_t (155 bytes)
binary dumps into Python dicts.

Layout extracted from DebugData4Obj.java setValue() byte offsets and
verified against src/calibration.h struct definitions.

All multi-byte values are little-endian (ByteOrder.LITTLE_ENDIAN in Java).
"""

import argparse
import json
import math
import struct
import sys
from pathlib import Path

# --------------------------------------------------------------------------- #
# Field descriptor helpers
# --------------------------------------------------------------------------- #

# Each entry: (name, struct_fmt, count)
#   struct_fmt uses Python struct codes (little-endian assumed):
#     'B' = uint8   (1 byte)
#     'b' = int8    (1 byte, signed)
#     'H' = uint16  (2 bytes)
#     'I' = uint32  (4 bytes)
#     'd' = float64 / double (8 bytes)

# 'count' > 1 means an array field; the dict value will be a list.

# --------------------------------------------------------------------------- #
# debug_t field layout (1579 bytes total)
# --------------------------------------------------------------------------- #

DEBUG_FIELDS = [
    # --- header ---
    ("seq_number_original",  "H", 1),
    ("seq_number_final",     "H", 1),
    ("measurement_time_standard", "I", 1),
    ("data_type",            "B", 1),
    ("stage",                "B", 1),
    # --- sensor data ---
    ("temperature",          "d", 1),
    ("workout",              "H", 30),
    ("tran_inA",             "d", 30),
    ("tran_inA_1min",        "d", 5),
    ("tran_inA_5min",        "d", 1),
    ("ycept",                "d", 1),
    ("corrected_re_current", "d", 1),
    # --- diabetes stats ---
    ("diabetes_mean_x",     "d", 1),
    ("diabetes_M2",         "d", 1),
    ("diabetes_TAR",        "d", 1),
    ("diabetes_TBR",        "d", 1),
    ("diabetes_CV",         "d", 1),
    ("level_diabetes",      "B", 1),
    # --- output / filtering ---
    ("out_iir",             "d", 1),
    ("out_drift",           "d", 1),
    ("curr_baseline",       "d", 1),
    ("initstable_diff_dc",  "d", 1),
    ("initstable_initcnt",  "H", 1),
    ("temp_local_mean",     "d", 1),
    ("slope_ratio_temp",    "d", 1),
    ("init_cg",             "d", 1),
    ("out_rescale",         "d", 1),
    ("opcal_ad",            "d", 1),
    ("state_init_kalman",   "B", 1),
    # --- smoothing ---
    ("smooth_seq",          "H", 6),
    ("smooth_sig",          "d", 6),
    ("smooth_frep",         "B", 6),
    # --- calibration state ---
    ("cal_state",           "B", 1),
    ("state_return_opcal",  "b", 1),   # int8_t (signed)
    ("valid_bg_time",       "I", 1),
    ("valid_bg_value",      "d", 1),
    # --- callog ---
    ("callog_group",        "B", 1),
    ("callog_bgTime",       "I", 1),
    ("callog_bgSeq",        "d", 1),
    ("callog_bgUser",       "d", 1),
    ("callog_bgValid",      "b", 1),   # int8_t (signed) -- Java: get() raw
    ("callog_bgCal",        "d", 1),
    ("callog_cgSeq1m",      "d", 1),
    ("callog_cgIdx",        "H", 1),
    ("callog_cgCal",        "d", 1),
    ("callog_CslopePrev",   "d", 1),
    ("callog_CyceptPrev",   "d", 1),
    ("callog_CslopeNew",    "d", 1),
    ("callog_CyceptNew",    "d", 1),
    ("callog_inlierFlg",    "B", 1),
    # --- cal arrays ---
    ("cal_slope",           "d", 7),
    ("cal_ycept",           "d", 7),
    ("cal_input",           "d", 7),
    ("cal_output",          "d", 7),
    # --- initstable weights ---
    ("initstable_weight_usercal", "d", 1),
    ("initstable_weight_nocal",   "d", 1),
    ("initstable_fixusercal",     "d", 1),
    ("nOpcalState",               "b", 1),  # int8_t (signed)
    ("initstable_init_end_point", "H", 1),
    # --- output weights ---
    ("out_weight_sd",       "d", 6),
    ("out_weight_ad",       "d", 1),
    ("shiftout_ad",         "d", 1),
    # --- error codes ---
    ("error_code1",         "B", 1),
    ("error_code2",         "B", 1),
    ("error_code4",         "B", 1),
    ("error_code8",         "B", 1),
    ("error_code16",        "B", 1),
    ("error_code32",        "B", 1),
    # --- trend ---
    ("trendrate",           "d", 1),
    ("cal_available_flag",  "B", 1),
    # --- err1 fields ---
    ("err1_i_sse_d_mean",   "d", 1),
    ("err1_th_sse_d_mean1", "d", 1),
    ("err1_th_sse_d_mean2", "d", 1),
    ("err1_th_sse_d_mean",  "d", 1),
    ("err1_is_contact_bad", "B", 1),
    ("err1_current_avg_diff", "d", 1),
    ("err1_th_diff1",       "d", 1),
    ("err1_th_diff2",       "d", 1),
    ("err1_th_diff",        "d", 1),
    ("err1_isfirst0",       "B", 1),
    ("err1_isfirst1",       "B", 1),
    ("err1_isfirst2",       "B", 1),
    ("err1_n",              "H", 1),
    ("err1_random_noise_temp_break", "B", 1),
    ("err1_result",         "B", 1),
    ("err1_length_t2_max",  "B", 1),
    ("err1_length_t3_max",  "B", 1),
    ("err1_length_t1_trio", "B", 1),
    ("err1_length_t2_trio", "B", 1),
    ("err1_length_t3_trio", "B", 1),
    ("err1_length_t6_trio", "B", 1),
    ("err1_length_t7_trio", "B", 1),
    ("err1_length_t8_trio", "B", 1),
    ("err1_length_t9_trio", "B", 1),
    ("err1_length_t10_trio","B", 1),
    ("err1_result_TD",      "B", 1),
    ("err1_result_condition_TD", "B", 2),
    ("err1_TD_count",       "H", 1),
    ("err1_TD_temporary_break_flag", "B", 1),
    ("err1_TD_time_trio",   "I", 3),
    ("err1_TD_value_trio",  "d", 3),
    # --- err2 fields ---
    ("err2_delay_revised_value",    "d", 1),
    ("err2_delay_roc",              "d", 1),
    ("err2_delay_slope_sharp",      "d", 1),
    ("err2_delay_roc_cummax",       "d", 1),
    ("err2_delay_roc_trimmed_mean", "d", 1),
    ("err2_delay_slope_cummax",     "d", 1),
    ("err2_delay_slope_trimmed_mean","d", 1),
    ("err2_delay_glu_cummax",       "d", 1),
    ("err2_delay_glu_trimmed_mean", "d", 1),
    ("err2_delay_pre_condi",        "B", 3),
    ("err2_delay_condi",            "B", 3),
    ("err2_delay_flag",             "B", 1),
    ("err2_cummax",                 "d", 1),
    ("err2_crt_current",            "B", 2),
    ("err2_crt_glu",                "B", 2),
    ("err2_crt_cv",                 "d", 1),
    ("err2_condi",                  "B", 2),
    # --- err4 fields ---
    ("err4_min",            "d", 1),
    ("err4_range",          "d", 1),
    ("err4_min_diff",       "d", 1),
    ("err4_condi",          "B", 5),
    ("err4_delay_condi",    "B", 5),
    ("err4_delay_flag",     "B", 1),
    # --- err8 fields ---
    ("err8_condi",          "B", 2),
    # --- err16 fields ---
    ("err16_cal_cons_d_usercal_after", "d", 1),
    ("err16_cal_day_d_temp",           "d", 1),
    ("err16_cal_day_d_ref",            "d", 1),
    ("err16_cal_day_n_ref",            "d", 1),
    ("err16_CGM_plasma",               "d", 1),
    ("err16_CGM_ISF_smooth",           "d", 1),
    ("err16_CGM_ISF_roc_value",        "d", 1),
    ("err16_CGM_ISF_roc_steady",       "d", 1),
    ("err16_CGM_ISF_roc_min_temp",     "d", 1),
    ("err16_CGM_ISF_roc_min",          "d", 1),
    ("err16_CGM_ISF_roc_diff",         "d", 1),
    ("err16_CGM_ISF_roc_ratio",        "d", 1),
    ("err16_CGM_ISF_trend_min_value",  "d", 1),
    ("err16_CGM_ISF_trend_min_slope1", "d", 1),
    ("err16_CGM_ISF_trend_min_slope2", "d", 1),
    ("err16_CGM_ISF_trend_min_rsq1",   "d", 1),
    ("err16_CGM_ISF_trend_min_rsq2",   "d", 1),
    ("err16_CGM_ISF_trend_min_diff",   "d", 1),
    ("err16_CGM_ISF_trend_min_max_temp","d", 1),
    ("err16_CGM_ISF_trend_min_max",    "d", 1),
    ("err16_CGM_ISF_trend_min_ratio",  "d", 1),
    ("err16_CGM_ISF_trend_mode_value", "d", 1),
    ("err16_CGM_ISF_trend_mode_proportion","d", 1),
    ("err16_CGM_ISF_trend_mode_diff",  "d", 1),
    ("err16_CGM_ISF_trend_mode_max_temp","d", 1),
    ("err16_CGM_ISF_trend_mode_max",   "d", 1),
    ("err16_CGM_ISF_trend_mode_ratio", "d", 1),
    ("err16_CGM_ISF_trend_mean_value", "d", 1),
    ("err16_CGM_ISF_trend_mean_slope", "d", 1),
    ("err16_CGM_ISF_trend_mean_rsq",   "d", 1),
    ("err16_CGM_ISF_trend_mean_diff",  "d", 1),
    ("err16_CGM_ISF_trend_mean_max_temp","d", 1),
    ("err16_CGM_ISF_trend_mean_max",   "d", 1),
    ("err16_CGM_ISF_trend_mean_ratio", "d", 1),
    ("err16_CGM_ISF_trend_mean_diff_early","d", 1),
    ("err16_CGM_ISF_trend_mean_max_temp_early","d", 1),
    ("err16_CGM_ISF_trend_mean_max_early","d", 1),
    ("err16_CGM_ISF_trend_mean_ratio_early","d", 1),
    ("err16_condi",         "B", 7),
    # --- err128 fields ---
    ("err128_flag",          "B", 1),
    ("err128_revised_value", "d", 1),
    ("err128_normal",        "d", 1),
]

DEBUG_EXPECTED_SIZE = 1579

# --------------------------------------------------------------------------- #
# output_t field layout (155 bytes total)
# --------------------------------------------------------------------------- #

OUTPUT_FIELDS = [
    ("seq_number_original",      "H", 1),
    ("seq_number_final",         "H", 1),
    ("measurement_time_standard","I", 1),
    ("workout",                  "H", 30),
    ("result_glucose",           "d", 1),
    ("trendrate",                "d", 1),
    ("current_stage",            "B", 1),
    ("smooth_fixed_flag",        "B", 6),
    ("smooth_seq",               "H", 6),
    ("smooth_result_glucose",    "d", 6),
    ("errcode",                  "H", 1),
    ("cal_available_flag",       "B", 1),
    ("data_type",                "B", 1),
]

OUTPUT_EXPECTED_SIZE = 155

# --------------------------------------------------------------------------- #
# Generic parser
# --------------------------------------------------------------------------- #

_FMT_SIZE = {
    "B": 1, "b": 1,
    "H": 2, "h": 2,
    "I": 4, "i": 4,
    "d": 8, "f": 4,
}


def _compute_expected_size(fields):
    """Sum of all field sizes for a field list."""
    total = 0
    for _name, fmt, count in fields:
        total += _FMT_SIZE[fmt] * count
    return total


def parse_binary(data, fields, expected_size, struct_name="struct"):
    """Parse a binary buffer into an dict using the given field list.

    Args:
        data: bytes object
        fields: list of (name, fmt_char, count) tuples
        expected_size: expected byte length
        struct_name: name for error messages

    Returns:
        dict mapping field names to values (scalars or lists).
    """
    if len(data) != expected_size:
        raise ValueError(
            f"{struct_name}: expected {expected_size} bytes, got {len(data)}"
        )

    result = dict()
    offset = 0

    for name, fmt, count in fields:
        elem_size = _FMT_SIZE[fmt]
        total_size = elem_size * count

        if count == 1:
            value = struct.unpack_from(f"<{fmt}", data, offset)[0]
            result[name] = value
        else:
            values = []
            for i in range(count):
                v = struct.unpack_from(f"<{fmt}", data, offset + i * elem_size)[0]
                values.append(v)
            result[name] = values

        offset += total_size

    assert offset == expected_size, (
        f"{struct_name}: parsed {offset} bytes but expected {expected_size}"
    )
    return result


def parse_debug(data):
    """Parse a 1579-byte debug_t binary dump."""
    return parse_binary(data, DEBUG_FIELDS, DEBUG_EXPECTED_SIZE,
                        "air1_opcal4_debug_t")


def parse_output(data):
    """Parse a 155-byte output_t binary dump."""
    return parse_binary(data, OUTPUT_FIELDS, OUTPUT_EXPECTED_SIZE,
                        "air1_opcal4_output_t")


# --------------------------------------------------------------------------- #
# Field type classification
# --------------------------------------------------------------------------- #

# Build lookup: field_name -> fmt_char (public API, used by compare_debug.py)
DEBUG_FIELD_TYPES = {name: fmt for name, fmt, _count in DEBUG_FIELDS}
OUTPUT_FIELD_TYPES = {name: fmt for name, fmt, _count in OUTPUT_FIELDS}


def is_float_field(name, field_types=None):
    """Return True if the field is a floating-point type.

    Raises KeyError if the field name is not known (protects against typos
    silently changing comparison mode in safety-critical verification).
    """
    if field_types is None:
        field_types = DEBUG_FIELD_TYPES
    if name not in field_types:
        raise KeyError(f"Unknown field name: {name!r}")
    return field_types[name] in ("d", "f")


def is_integer_field(name, field_types=None):
    """Return True if the field is an integer type."""
    return not is_float_field(name, field_types)


# --------------------------------------------------------------------------- #
# Pretty-print
# --------------------------------------------------------------------------- #

def _fmt_value(v):
    """Format a single value for display."""
    if isinstance(v, float):
        if math.isnan(v):
            return "NaN"
        if math.isinf(v):
            return "Inf" if v > 0 else "-Inf"
        # Show enough precision for doubles
        return f"{v:.15g}"
    return str(v)


def _fmt_field(name, value):
    """Format a field for display."""
    if isinstance(value, list):
        if len(value) <= 8:
            items = ", ".join(_fmt_value(v) for v in value)
            return f"  {name}: [{items}]"
        # For long arrays, show first 4 and last 2
        head = ", ".join(_fmt_value(v) for v in value[:4])
        tail = ", ".join(_fmt_value(v) for v in value[-2:])
        return f"  {name}[{len(value)}]: [{head}, ... {tail}]"
    return f"  {name}: {_fmt_value(value)}"


def print_parsed(parsed, struct_name="debug_t"):
    """Pretty-print a parsed struct dict."""
    print(f"--- {struct_name} ({len(parsed)} fields) ---")
    for name, value in parsed.items():
        print(_fmt_field(name, value))


# --------------------------------------------------------------------------- #
# Self-test: verify field list sizes match expected struct sizes
# --------------------------------------------------------------------------- #

def _verify_field_lists():
    """Verify at import time that field lists sum to expected sizes."""
    debug_size = _compute_expected_size(DEBUG_FIELDS)
    assert debug_size == DEBUG_EXPECTED_SIZE, (
        f"DEBUG_FIELDS sum to {debug_size}, expected {DEBUG_EXPECTED_SIZE}"
    )
    output_size = _compute_expected_size(OUTPUT_FIELDS)
    assert output_size == OUTPUT_EXPECTED_SIZE, (
        f"OUTPUT_FIELDS sum to {output_size}, expected {OUTPUT_EXPECTED_SIZE}"
    )


_verify_field_lists()

# --------------------------------------------------------------------------- #
# CLI
# --------------------------------------------------------------------------- #

def main():
    parser = argparse.ArgumentParser(
        description="Parse binary dumps of air1_opcal4_debug_t or output_t structs."
    )
    parser.add_argument(
        "binary_file",
        help="Path to the binary dump file"
    )
    parser.add_argument(
        "--type", "-t",
        choices=["debug", "output"],
        default=None,
        help="Struct type to parse. Auto-detected from file size if omitted."
    )
    parser.add_argument(
        "--json", "-j",
        action="store_true",
        help="Output as JSON instead of human-readable format"
    )

    args = parser.parse_args()

    path = Path(args.binary_file)
    if not path.exists():
        print(f"Error: file not found: {path}", file=sys.stderr)
        sys.exit(1)

    data = path.read_bytes()
    file_size = len(data)

    # Determine struct type
    struct_type = args.type
    if struct_type is None:
        if file_size == DEBUG_EXPECTED_SIZE:
            struct_type = "debug"
        elif file_size == OUTPUT_EXPECTED_SIZE:
            struct_type = "output"
        else:
            print(
                f"Error: file size {file_size} does not match debug_t "
                f"({DEBUG_EXPECTED_SIZE}) or output_t ({OUTPUT_EXPECTED_SIZE}). "
                f"Use --type to specify.",
                file=sys.stderr
            )
            sys.exit(1)

    if struct_type == "debug":
        parsed = parse_debug(data)
        struct_name = "air1_opcal4_debug_t"
    else:
        parsed = parse_output(data)
        struct_name = "air1_opcal4_output_t"

    if args.json:
        # Convert dict to regular dict for JSON serialization
        # Handle NaN/Inf which are not valid JSON
        def sanitize(obj):
            if isinstance(obj, float):
                if math.isnan(obj):
                    return "NaN"
                if math.isinf(obj):
                    return "Infinity" if obj > 0 else "-Infinity"
            if isinstance(obj, list):
                return [sanitize(v) for v in obj]
            return obj

        output = {k: sanitize(v) for k, v in parsed.items()}
        print(json.dumps(output, indent=2))
    else:
        print_parsed(parsed, struct_name)


if __name__ == "__main__":
    main()
