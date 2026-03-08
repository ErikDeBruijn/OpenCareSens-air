#!/usr/bin/env python3
"""
Parse oracle binary output files and display debug_t fields.
Used to verify our reimplementation against the real libCALCULATION.so output.

Usage:
    python3 parse_oracle.py <output_dir> [seq_number]
    python3 parse_oracle.py /tmp/caresens-air/oracle/output/lot0 1
    python3 parse_oracle.py /tmp/caresens-air/oracle/output/lot0  # show summary
"""

import struct
import sys
import os

# output_t field layout (155 bytes, packed)
OUTPUT_FIELDS = [
    (0, 'H', 'seq_number_original'),
    (2, 'H', 'seq_number_final'),
    (4, 'I', 'measurement_time_standard'),
    # workout[30] at offset 8 (60 bytes)
    (68, 'd', 'result_glucose'),
    (76, 'd', 'trendrate'),
    (84, 'B', 'current_stage'),
    # smooth_fixed_flag[6] at 85
    # smooth_seq[6] at 91
    # smooth_result_glucose[6] at 103
    (151, 'H', 'errcode'),
    (153, 'B', 'cal_available_flag'),
    (154, 'B', 'data_type'),
]

# debug_t field layout (1579 bytes, packed)
DEBUG_FIELDS = [
    (0, 'H', 'seq_number_original'),
    (2, 'H', 'seq_number_final'),
    (4, 'I', 'measurement_time_standard'),
    (8, 'B', 'data_type'),
    (9, 'B', 'stage'),
    (10, 'd', 'temperature'),
    # workout[30] at offset 18 (60 bytes)
    # tran_inA[30] at offset 78 (240 bytes)
    # tran_inA_1min[5] at offset 318 (40 bytes)
    (358, 'd', 'tran_inA_5min'),
    (366, 'd', 'ycept'),
    (374, 'd', 'corrected_re_current'),
    (382, 'd', 'diabetes_mean_x'),
    (390, 'd', 'diabetes_M2'),
    (398, 'd', 'diabetes_TAR'),
    (406, 'd', 'diabetes_TBR'),
    (414, 'd', 'diabetes_CV'),
    (422, 'B', 'level_diabetes'),
    (423, 'd', 'out_iir'),
    (431, 'd', 'out_drift'),
    (439, 'd', 'curr_baseline'),
    (447, 'd', 'initstable_diff_dc'),
    (455, 'H', 'initstable_initcnt'),
    (457, 'd', 'temp_local_mean'),
    (465, 'd', 'slope_ratio_temp'),
    (473, 'd', 'init_cg'),
    (481, 'd', 'out_rescale'),
    (489, 'd', 'opcal_ad'),
    (497, 'B', 'state_init_kalman'),
    # smooth_seq[6] at 498 (12 bytes)
    # smooth_sig[6] at 510 (48 bytes)
    # smooth_frep[6] at 558 (6 bytes)
    (564, 'B', 'cal_state'),
    (565, 'b', 'state_return_opcal'),
    (566, 'I', 'valid_bg_time'),
    (570, 'd', 'valid_bg_value'),
    # callog fields...
    (578, 'B', 'callog_group'),
    (579, 'I', 'callog_bgTime'),
    (583, 'd', 'callog_bgSeq'),
    (591, 'd', 'callog_bgUser'),
    (599, 'b', 'callog_bgValid'),
    (600, 'd', 'callog_bgCal'),
    (608, 'd', 'callog_cgSeq1m'),
    (616, 'H', 'callog_cgIdx'),
    (618, 'd', 'callog_cgCal'),
    (626, 'd', 'callog_CslopePrev'),
    (634, 'd', 'callog_CyceptPrev'),
    (642, 'd', 'callog_CslopeNew'),
    (650, 'd', 'callog_CyceptNew'),
    (658, 'B', 'callog_inlierFlg'),
    # cal_slope[7] at 659 (56 bytes)
    # cal_ycept[7] at 715 (56 bytes)
    # cal_input[7] at 771 (56 bytes)
    # cal_output[7] at 827 (56 bytes)
    (883, 'd', 'initstable_weight_usercal'),
    (891, 'd', 'initstable_weight_nocal'),
    (899, 'd', 'initstable_fixusercal'),
    (907, 'b', 'nOpcalState'),
    (908, 'H', 'initstable_init_end_point'),
    # out_weight_sd[6] at 910 (48 bytes)
    (958, 'd', 'out_weight_ad'),
    (966, 'd', 'shiftout_ad'),
]

# Error codes start at known offsets (we can compute from struct)
# After shiftout_ad (966+8=974):
ERROR_FIELDS = [
    (974, 'B', 'error_code1'),
    (975, 'B', 'error_code2'),
    (976, 'B', 'error_code4'),
    (977, 'B', 'error_code8'),
    (978, 'B', 'error_code16'),
    (979, 'B', 'error_code32'),
    (980, 'd', 'trendrate_debug'),
    (988, 'B', 'cal_available_flag'),
]

ALL_DEBUG_FIELDS = DEBUG_FIELDS + ERROR_FIELDS

TYPE_SIZES = {'B': 1, 'b': 1, 'H': 2, 'h': 2, 'I': 4, 'i': 4, 'f': 4, 'd': 8}


def parse_struct(data, fields):
    result = {}
    for offset, fmt, name in fields:
        try:
            val = struct.unpack_from(f'<{fmt}', data, offset)[0]
            result[name] = val
        except struct.error:
            result[name] = None
    return result


def parse_workout_from_debug(data):
    """Parse 30 uint16_t workout values from debug_t (offset 18)"""
    return [struct.unpack_from('<H', data, 18 + i * 2)[0] for i in range(30)]


def parse_tran_inA(data):
    """Parse 30 double tran_inA values from debug_t (offset 78)"""
    return [struct.unpack_from('<d', data, 78 + i * 8)[0] for i in range(30)]


def show_reading(output_dir, seq):
    """Display full details for a single reading"""
    debug_path = os.path.join(output_dir, f'seq_{seq:04d}_debug.bin')
    output_path = os.path.join(output_dir, f'seq_{seq:04d}_output.bin')
    input_path = os.path.join(output_dir, f'seq_{seq:04d}_input.bin')

    with open(output_path, 'rb') as f:
        output_data = f.read()
    with open(debug_path, 'rb') as f:
        debug_data = f.read()
    with open(input_path, 'rb') as f:
        input_data = f.read()

    out = parse_struct(output_data, OUTPUT_FIELDS)
    dbg = parse_struct(debug_data, ALL_DEBUG_FIELDS)
    workout_dbg = parse_workout_from_debug(debug_data)
    tran_inA = parse_tran_inA(debug_data)

    # Input
    inp_seq = struct.unpack_from('<H', input_data, 0)[0]
    inp_time = struct.unpack_from('<I', input_data, 2)[0]
    inp_workout = [struct.unpack_from('<H', input_data, 10 + i*2)[0] for i in range(30)]
    inp_temp = struct.unpack_from('<d', input_data, 70)[0] if len(input_data) >= 78 else 0

    print(f"=== Reading seq {seq} ===")
    print(f"\n--- Input ---")
    print(f"  seq_number: {inp_seq}")
    print(f"  time: {inp_time}")
    print(f"  temperature: {inp_temp:.1f}")
    print(f"  workout (first 5): {inp_workout[:5]}")
    print(f"  workout mean: {sum(inp_workout)/len(inp_workout):.1f}")

    print(f"\n--- Output (155 bytes) ---")
    for _, fmt, name in OUTPUT_FIELDS:
        val = out[name]
        if val is None:
            print(f"  {name}: <error>")
        elif isinstance(val, float):
            print(f"  {name}: {val:.6f}")
        else:
            print(f"  {name}: {val}")

    print(f"\n--- Debug key fields ---")
    for _, fmt, name in ALL_DEBUG_FIELDS:
        val = dbg[name]
        if val is None:
            print(f"  {name}: <error>")
        elif isinstance(val, float):
            if abs(val) > 1e10 or (val != 0 and abs(val) < 1e-10):
                print(f"  {name}: {val:.6e}")
            else:
                print(f"  {name}: {val:.6f}")
        else:
            print(f"  {name}: {val}")

    print(f"\n--- tran_inA (converted currents) ---")
    for i, v in enumerate(tran_inA[:10]):
        print(f"  [{i}]: {v:.6f}")
    if any(v != 0 for v in tran_inA):
        print(f"  mean: {sum(tran_inA)/len(tran_inA):.6f}")

    print(f"\n--- Debug workout (echoed back) ---")
    print(f"  first 5: {workout_dbg[:5]}")


def show_summary(output_dir):
    """Show summary of all readings"""
    files = sorted([f for f in os.listdir(output_dir) if f.endswith('_output.bin')])
    print(f"=== Summary: {output_dir} ({len(files)} readings) ===")
    print(f"{'seq':>4s} {'glucose':>10s} {'err':>5s} {'stage':>5s} {'trend':>10s}")
    print('-' * 40)

    for fname in files:
        seq = int(fname.split('_')[1])
        with open(os.path.join(output_dir, fname), 'rb') as f:
            data = f.read()
        out = parse_struct(data, OUTPUT_FIELDS)
        if seq <= 30 or seq % 50 == 0 or out['errcode']:
            glu = out['result_glucose']
            glu_str = f"{glu:.1f}" if glu is not None else "?"
            print(f"{seq:4d} {glu_str:>10s} {out['errcode']:5d} "
                  f"{out['current_stage']:5d} {out['trendrate']:10.3f}")


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    output_dir = sys.argv[1]

    if len(sys.argv) >= 3:
        show_reading(output_dir, int(sys.argv[2]))
    else:
        show_summary(output_dir)
