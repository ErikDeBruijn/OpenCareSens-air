#!/usr/bin/env python3
"""
Full end-to-end simulation of the tran_inA processing pipeline.

Validates our reimplementation against the oracle for all 50 sequences.
Maintains state across calls (history, prev3) just like the real library.

Algorithm summary:
  1. Per-sample loop: ADC -> current conversion, outlier removal at indices 4,14,20,28
  2. For seq >= 3 and time_gap < 897.2: IRLS LOESS regression on 90 history points
  3. Running median filter (5 groups of 6, windows [3,4,5,6,5,4])
  4. For seq >= 2 and time_gap < 327.2: FIR filter on medians
  5. cal_average_without_min_max per group of 6

Since we can't perfectly replicate the per-sample loop (it involves ADC conversion
and outlier detection), we use the per-sample output stored in the oracle's args
snapshots. For sequences without args snapshots, we use the debug output to validate
against our forward model.
"""

import struct
import os
import sys
import numpy as np

BASE = '/tmp/caresens-air/oracle/output/lot0'
LIB_PATH = '/tmp/caresens-air/native/lib/armeabi-v7a/libCALCULATION.so'


def read_doubles(data, offset, count):
    return [struct.unpack_from('<d', data, offset + i * 8)[0] for i in range(count)]


def load_loess_kernel_table():
    """Extract the 90x45 LOESS weight table from the ELF binary."""
    with open(LIB_PATH, 'rb') as f:
        f.seek(0x29240)
        data = f.read(32400)
    arr = np.zeros((90, 45))
    for r in range(90):
        for c in range(45):
            arr[r, c] = struct.unpack_from('<d', data, r * 360 + c * 8)[0]
    return arr


def get_kernel_weight(table, eval_pt, data_pt):
    if eval_pt < 45:
        return table[data_pt, eval_pt]
    else:
        return table[89 - data_pt, 89 - eval_pt]


def quick_median(arr):
    s = sorted(arr)
    n = len(s)
    if n % 2 == 1:
        return s[n // 2]
    else:
        return (s[n // 2 - 1] + s[n // 2]) / 2.0


def irls_loess(data90, table, max_iter=3):
    """IRLS LOESS regression on 90 data points. Returns 90 fitted values."""
    n = 90
    x = np.arange(1, n + 1, dtype=float)
    y = np.array(data90)
    bisquare_weights = np.ones(n)
    fitted = np.zeros(n)

    for iteration in range(max_iter):
        has_nan = False

        for e in range(n):
            sum_w = 0.0
            sum_wx = 0.0
            sum_wxx = 0.0
            sum_wy = 0.0
            sum_wxy = 0.0

            for d in range(n):
                kw = get_kernel_weight(table, e, d)
                w = kw * bisquare_weights[d]
                xi = x[d]
                yi = y[d]
                wx = w * xi
                wy = w * yi
                sum_wxx += wx * xi
                sum_wxy += wy * xi
                sum_w += w
                sum_wx += wx
                sum_wy += wy

            det = sum_wxx * sum_w - sum_wx * sum_wx
            if abs(det) < 1e-30:
                fitted[e] = np.mean(y)
            else:
                a0 = (sum_wxx * sum_wy - sum_wx * sum_wxy) / det
                a1 = (sum_w * sum_wxy - sum_wx * sum_wy) / det
                x_eval = float(e + 1)
                fitted[e] = a0 + a1 * x_eval

        residuals = np.abs(y - fitted)
        median_abs_resid = quick_median(list(residuals))
        threshold = median_abs_resid * 6.0

        if threshold < 1e-30:
            break

        for i in range(n):
            u = residuals[i] / threshold
            if u > 1.0:
                u = 1.0
            w = (1.0 - u * u) ** 2
            bisquare_weights[i] = w
            if np.isnan(w):
                has_nan = True

        if has_nan:
            break

    return fitted


def math_median(arr, n=None):
    if n is None:
        n = len(arr)
    s = sorted(arr[:n])
    return s[n // 2] if n % 2 == 1 else (s[n // 2 - 1] + s[n // 2]) / 2.0


def cal_average_without_min_max(arr, n=None):
    if n is None:
        n = len(arr)
    vals = list(arr[:n])
    if n <= 2:
        return sum(vals) / n
    vals.remove(min(vals))
    vals.remove(max(vals))
    return sum(vals) / len(vals)


def compute_running_medians(group6):
    return [
        math_median(group6[0:3], 3), math_median(group6[0:4], 4),
        math_median(group6[0:5], 5), math_median(group6[0:6], 6),
        math_median(group6[1:6], 5), math_median(group6[2:6], 4),
    ]


def compute_all_running_medians(values30):
    medians = []
    for g in range(5):
        medians.extend(compute_running_medians(values30[g * 6:(g + 1) * 6]))
    return medians


FIR_COEFF = [-0.25, 1.0, 1.75, 2.0, 1.75, 1.0, -0.25]


def apply_fir_to_medians(prev3, medians30):
    extended = list(prev3) + list(medians30)
    out = [0.0] * 30
    for k in range(27):
        val = sum(FIR_COEFF[j] * extended[k + j] for j in range(7))
        out[k] = val / 7.0
    v = medians30[24:30]
    out[27] = (-0.25 * v[0] + v[1] + 1.75 * v[2] + 2 * v[3] + 1.75 * v[4] + v[5]) / 7.25
    out[28] = (-0.25 * v[1] + v[2] + 1.75 * v[3] + 2 * v[4] + 1.75 * v[5]) / 6.25
    out[29] = (-0.25 * v[2] + v[3] + 1.75 * v[4] + 2 * v[5]) / 4.5
    return out


def main():
    print("=== Full End-to-End Simulation ===\n")

    table = load_loess_kernel_table()

    # State maintained across calls (like the real library's arguments_t)
    history = [0.0] * 60  # prev_outlier_removed_curr (60 values)
    prev3 = [0.0, 0.0, 0.0]  # prev_mov_median_curr (3 values)
    seq_count = 0  # equivalent to args[0x648]

    max_delta_all = 0.0
    time_interval = 300  # 5 minutes between readings

    for seq in range(1, 51):
        debug_path = os.path.join(BASE, f'seq_{seq:04d}_debug.bin')
        args_path = os.path.join(BASE, f'seq_{seq:04d}_args.bin')

        if not os.path.exists(debug_path):
            break

        debug = open(debug_path, 'rb').read()
        oracle_1min = read_doubles(debug, 318, 5)

        # Get per-sample output from args if available, otherwise from prev args
        if os.path.exists(args_path):
            args = open(args_path, 'rb').read()
            per_sample_output = read_doubles(args, 0x0e58, 30)
        else:
            # For sequences without args, we can't get the per-sample output
            # This shouldn't happen for our dataset
            print(f"  WARNING: No args for seq {seq}, skipping")
            continue

        # Increment sequence counter (at 0x636d8)
        seq_count += 1

        # Determine path: IRLS or simple
        time_gap = time_interval  # constant 300s for our synthetic data
        use_irls = (seq_count > 2) and (time_gap < 897.2)
        use_fir = (seq_count > 1) and (time_gap < 327.2)

        if use_irls:
            # Build 90-point dataset from history (60) + current per-sample (30)
            data90 = np.array(history + list(per_sample_output))
            fitted90 = irls_loess(data90, table)
            intermediate30 = list(fitted90[60:90])
        else:
            # Simple path: use per-sample output directly
            intermediate30 = list(per_sample_output)

        # Running median filter
        medians = compute_all_running_medians(intermediate30)

        # FIR filter on medians
        if use_fir:
            fir_medians = apply_fir_to_medians(prev3, medians)
        else:
            fir_medians = medians

        # cal_average_without_min_max per group of 6
        result_1min = []
        for g in range(5):
            group = fir_medians[g * 6:(g + 1) * 6]
            result_1min.append(cal_average_without_min_max(group))

        # Update prev3 = last 3 RAW (un-FIR'd) medians
        prev3 = medians[27:30]

        # Update history: shift and store
        # At 0x63ede: history[0:30] = history[30:60]
        # At 0x63ef0: history[30:60] = per_sample_output
        history[0:30] = history[30:60]
        history[30:60] = list(per_sample_output)

        # Compute max delta
        max_delta = max(abs(result_1min[g] - oracle_1min[g]) for g in range(5))
        max_delta_all = max(max_delta_all, max_delta)

        path_str = "IRLS" if use_irls else "simple"
        fir_str = "+FIR" if use_fir else ""
        if max_delta > 1e-10 or seq <= 10 or seq in [24, 25, 50]:
            print(f"Seq {seq:3d} [{path_str:6s}{fir_str:4s}]: max_delta={max_delta:.2e}  "
                  f"oracle=[{', '.join(f'{v:.6f}' for v in oracle_1min)}]")
            if max_delta > 1e-10:
                for g in range(5):
                    d = result_1min[g] - oracle_1min[g]
                    print(f"         group {g}: computed={result_1min[g]:.10f} oracle={oracle_1min[g]:.10f} delta={d:+.2e}")

    print(f"\n=== SUMMARY ===")
    print(f"Overall max delta across all sequences: {max_delta_all:.2e}")
    if max_delta_all < 1e-10:
        print("PERFECT MATCH: Our reimplementation matches the oracle exactly!")
    elif max_delta_all < 1e-6:
        print("EXCELLENT MATCH: Differences are within floating-point tolerance.")
    else:
        print("MISMATCH: Some values differ significantly.")


if __name__ == '__main__':
    main()
