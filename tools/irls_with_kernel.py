#!/usr/bin/env python3
"""
IRLS regression using the LOESS kernel table extracted from libCALCULATION.so.

From the disassembly at 0x63cf2-0x63eba:
  - 90 data points (history[0:30] + history[30:60] + per_sample_output[0:30])
  - LOESS kernel weights pre-computed in air1_opcal4_loess_weight_arr (90x45 doubles)
  - Up to 3 iterations of Tukey bisquare reweighting
  - Local linear regression (weighted least squares) at each of 90 evaluation points
  - Takes last 30 fitted values as output

The kernel table is symmetric:
  - For eval points 0..44: weight[eval][data] = table[data][eval]
  - For eval points 45..89: weight[eval][data] = table[89-data][89-eval]

The IRLS uses bisquare reweighting:
  - Compute residuals
  - Find median absolute residual
  - u = residual / (6 * median_abs_residual)
  - bisquare weight = (1 - min(u, 1)^2)^2
  - Multiply kernel weight by bisquare weight for next iteration

Data points use 1-based x values (x = 1, 2, ..., 90).
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
        f.seek(0x29240)  # air1_opcal4_loess_weight_arr
        data = f.read(32400)  # 90 * 45 * 8

    arr = np.zeros((90, 45))
    for r in range(90):
        for c in range(45):
            arr[r, c] = struct.unpack_from('<d', data, r * 360 + c * 8)[0]
    return arr


def get_kernel_weight(table, eval_pt, data_pt):
    """Get the LOESS kernel weight for an evaluation point and data point.

    eval_pt: 0..89 (evaluation point index)
    data_pt: 0..89 (data point index)

    From the disassembly:
      Forward (eval < 45): read table[data_pt][eval_pt]
      Backward (eval >= 45): read table[89-data_pt][89-eval_pt]
    """
    if eval_pt < 45:
        return table[data_pt, eval_pt]
    else:
        return table[89 - data_pt, 89 - eval_pt]


def quick_median(arr):
    """Compute median of array (matching quick_median from the library)."""
    s = sorted(arr)
    n = len(s)
    if n % 2 == 1:
        return s[n // 2]
    else:
        return (s[n // 2 - 1] + s[n // 2]) / 2.0


def irls_loess(data90, table, max_iter=3):
    """IRLS LOESS regression on 90 data points.

    From the disassembly (0x63d4e-0x63eba):
      - Outer loop: up to 3 iterations (r8 = 0, 1, 2)
      - For each evaluation point (r2 = 0 to 89):
        - Inner loop: compute weighted sums over all 90 data points
        - x values are 1-based: x = 1, 2, ..., 90
        - Weights = kernel_weight * bisquare_weight
        - Solve local linear regression: y = a0 + a1*x
        - Store fitted value at eval point
      - After all eval points: compute residuals, update bisquare weights
      - If no NaN in bisquare weights, continue; else break

    Returns: 90 fitted values
    """
    n = 90
    x = np.arange(1, n + 1, dtype=float)  # 1-based x values
    y = np.array(data90)

    # Initialize bisquare weights to 1.0
    # From disassembly at 0x63d2e-0x63d44: initializes sp+0x8d0 buffer
    # The initial value comes from a pool constant at 0x64078.
    # Let's check what that constant is. It initializes 90 doubles.
    # The code stores r4=0 (low word) and r2 (from pool at 0x64078) (high word)
    # to each 8-byte slot. This constructs a double from two 32-bit words.
    # We need to know the pool value at 0x64078.
    # From the binary: let me read it.
    with open(LIB_PATH, 'rb') as f:
        f.seek(0x64078 - 0x616e8 + 0x616e8)  # file offset = VMA for this ELF
        f.seek(0x64078)
        pool_val = struct.unpack('<I', f.read(4))[0]

    # The code does: str r4=0 at [r11, r0], str r2=pool at [r1, #4]
    # This stores 0x00000000 as low word and pool_val as high word
    # For IEEE 754 double: sign(1) + exp(11) + frac(52)
    # If high word = 0x3FF00000, low = 0x00000000 -> double = 1.0
    init_double = struct.unpack('<d', struct.pack('<II', 0, pool_val))[0]
    print(f"Initial bisquare weight: {init_double} (pool=0x{pool_val:08x})")

    bisquare_weights = np.full(n, init_double)
    fitted = np.zeros(n)

    for iteration in range(max_iter):
        has_nan = False

        for e in range(n):
            # Weighted sums for local linear regression
            sum_w = 0.0    # d19
            sum_wx = 0.0   # d20
            sum_wxx = 0.0  # d18
            sum_wy = 0.0   # d16
            sum_wxy = 0.0  # d17

            for d in range(n):
                kw = get_kernel_weight(table, e, d)
                w = kw * bisquare_weights[d]  # d22 * d21 = combined weight
                xi = x[d]  # 1-based x value
                yi = y[d]

                wx = w * xi        # d23 = d21 * d22(converted)
                wy = w * yi        # d24 = d21 * d24

                sum_wxx += wx * xi  # d18 += d23 * d22
                sum_wxy += wy * xi  # d17 += d24 * d22
                sum_w += w          # d19 += d21
                sum_wx += wx        # d20 += d23
                sum_wy += wy        # d16 += d24

            # Solve WLS: y = a0 + a1*x
            # From disassembly (0x63dde-0x63e28):
            #   det = sum_wxx * sum_w - sum_wx * sum_wx  (d21 = d18*d19 - d20*d20)
            #   neg_sum_wx = -sum_wx
            #   c0 = sum_w / det     (d19 = d19 / d21) -> but this is wrong?
            #
            # Actually, the code computes the regression coefficients differently.
            # Let me trace more carefully:
            #   d21 = d18 * d19           -> sum_wxx * sum_w
            #   d21 = d21 - d20 * d20     -> det = sum_wxx * sum_w - sum_wx^2
            #   d20 = -d20                -> neg_sum_wx
            #   d19 = d19 / d21           -> sum_w / det
            #   d20 = d20 / d21           -> neg_sum_wx / det = -sum_wx / det
            #   d18 = d18 / d21           -> sum_wxx / det
            #   d19 = d17 * d19           -> sum_wxy * (sum_w / det)
            #   d17 = d17 * d20           -> sum_wxy * (-sum_wx / det)
            #   d19 = d19 + d20 * d16     -> sum_wxy*sum_w/det + (-sum_wx/det)*sum_wy
            #                              = (sum_wxy*sum_w - sum_wx*sum_wy) / det = a1
            #   d17 = d17 + d18 * d16     -> sum_wxy*(-sum_wx/det) + (sum_wxx/det)*sum_wy
            #                              = (sum_wxx*sum_wy - sum_wx*sum_wxy) / det = a0
            #   d16 = (double)(e + 1)     -> eval x value (1-based)
            #   d17 = d17 + d19 * d16     -> a0 + a1 * x_eval = fitted value

            det = sum_wxx * sum_w - sum_wx * sum_wx
            if abs(det) < 1e-30:
                fitted[e] = np.mean(y)
            else:
                a0 = (sum_wxx * sum_wy - sum_wx * sum_wxy) / det
                a1 = (sum_w * sum_wxy - sum_wx * sum_wy) / det
                x_eval = float(e + 1)  # 1-based
                fitted[e] = a0 + a1 * x_eval

        # Store fitted values in output buffer (sp+0xba0)

        # Compute residuals and update bisquare weights
        # From disassembly (0x63e2c-0x63e56 and 0x63e58-0x63eac):
        residuals = np.abs(y - fitted)  # sp+0x600

        # 0x63e58: call quick_median on residuals (90 values)
        # d14 was set earlier, let's find what it is
        # Actually, the disassembly shows: d0 = quick_median(residuals, 90)
        # Then d16 = d0 * d14, where d14 is the Tukey constant (typically 6.0)
        median_abs_resid = quick_median(list(residuals))

        # From disassembly: d16 = d0 * d14
        # d14 is loaded earlier. Let me check... at 0x63cf2 or before.
        # d14 is commonly the Tukey constant c = 6.0 for bisquare
        # Let me check d14/d15 values from before the IRLS loop
        tukey_c = 6.0  # standard Tukey bisquare constant
        threshold = median_abs_resid * tukey_c

        if threshold < 1e-30:
            break

        # Update bisquare weights
        # From 0x63e68-0x63eac:
        #   For each residual:
        #     u = residual / threshold  (d17 = d17 / d16)
        #     if u > 1.0: u = 1.0      (cmp d17 with d15=1.0, movgt)
        #     w = (1 - u^2)^2           (vmls d18 = 1.0 - u*u, then d17 = d18*d18)
        #     Check for NaN (vcmp d17, d17; vs -> set r9=1)
        #     Store weight

        for i in range(n):
            u = residuals[i] / threshold
            if u > 1.0:
                u = 1.0
            w = (1.0 - u * u) ** 2
            bisquare_weights[i] = w
            if np.isnan(w):
                has_nan = True

        # Check if should continue (0x63eb4)
        if not has_nan:
            continue  # bne -> loop back to next iteration
        else:
            break  # has NaN, exit IRLS

    return fitted


def math_median(arr, n=None):
    if n is None:
        n = len(arr)
    s = sorted(arr[:n])
    if n % 2 == 1:
        return s[n // 2]
    else:
        return (s[n // 2 - 1] + s[n // 2]) / 2.0


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
        math_median(group6[0:3], 3),
        math_median(group6[0:4], 4),
        math_median(group6[0:5], 5),
        math_median(group6[0:6], 6),
        math_median(group6[1:6], 5),
        math_median(group6[2:6], 4),
    ]


def compute_all_running_medians(values30):
    medians = []
    for g in range(5):
        group = values30[g * 6:(g + 1) * 6]
        medians.extend(compute_running_medians(group))
    return medians


FIR_COEFF = [-0.25, 1.0, 1.75, 2.0, 1.75, 1.0, -0.25]
FIR_SUM = 7.0


def apply_fir_to_medians(prev3, medians30):
    extended = list(prev3) + list(medians30)
    out = [0.0] * 30
    for k in range(27):
        val = 0.0
        for j in range(7):
            val += FIR_COEFF[j] * extended[k + j]
        out[k] = val / FIR_SUM
    v = medians30[24:30]
    out[27] = (-0.25*v[0] + v[1] + 1.75*v[2] + 2*v[3] + 1.75*v[4] + v[5]) / 7.25
    out[28] = (-0.25*v[1] + v[2] + 1.75*v[3] + 2*v[4] + 1.75*v[5]) / 6.25
    out[29] = (-0.25*v[2] + v[3] + 1.75*v[4] + 2*v[5]) / 4.5
    return out


def forward_model(values30, prev3, apply_fir=True):
    """Full forward model: values30 -> running medians -> FIR -> cal_avg -> 1min values."""
    medians = compute_all_running_medians(list(values30))
    if apply_fir:
        fir_medians = apply_fir_to_medians(prev3, medians)
    else:
        fir_medians = medians
    result = []
    for g in range(5):
        group = fir_medians[g * 6:(g + 1) * 6]
        avg = cal_average_without_min_max(group)
        result.append(avg)
    return result, medians


def main():
    print("=== Loading LOESS kernel table ===")
    table = load_loess_kernel_table()
    print(f"Table shape: {table.shape}")
    print(f"Table[0][0] = {table[0, 0]}")
    print(f"Table[44][44] = {table[44, 44]}")
    print()

    # Process sequences
    for seq in [3, 4, 5, 6, 7, 8, 9, 10]:
        args_path = os.path.join(BASE, f'seq_{seq:04d}_args.bin')
        debug_path = os.path.join(BASE, f'seq_{seq:04d}_debug.bin')
        if not os.path.exists(args_path):
            continue
        args = open(args_path, 'rb').read()
        debug = open(debug_path, 'rb').read()

        oracle_1min = read_doubles(debug, 318, 5)

        # Previous args for prev3
        prev_args_path = os.path.join(BASE, f'seq_{seq-1:04d}_args.bin')
        prev_args = open(prev_args_path, 'rb').read()
        prev3 = read_doubles(prev_args, 0x0f48, 3)

        # Build the 90-point dataset
        # IMPORTANT: The args snapshot is taken AFTER the call. During the IRLS:
        #   - r8 points to args+0xd68 which has the PRE-CALL history (60 values)
        #   - The history shift happens AFTER the IRLS at 0x63ede
        #   - args+0xe58 is overwritten AFTER the IRLS at 0x63ef0
        #
        # So the correct PRE-CALL history is from prev_args (seq-1 snapshot):
        #   data90[0:60] = prev_args+0xd68 (60 doubles = history before current call)
        #   data90[60:90] = args+0xe58 (per-sample output = what gets stored after call)
        history_60 = np.array(read_doubles(prev_args, 0x0d68, 60))
        per_sample_30 = np.array(read_doubles(args, 0x0e58, 30))
        data90 = np.concatenate([history_60, per_sample_30])

        print(f"=== Seq {seq} ===")

        # Run IRLS regression
        fitted90 = irls_loess(data90, table)

        # Take last 30 fitted values as the intermediate array
        intermediate30 = fitted90[60:90]

        # Apply forward model (median + FIR + cal_avg)
        result, medians = forward_model(intermediate30, prev3)

        max_delta = max(abs(result[g] - oracle_1min[g]) for g in range(5))

        # Check prev3 match
        cur_prev3 = read_doubles(args, 0x0f48, 3)
        prev3_delta = max(abs(medians[27+i] - cur_prev3[i]) for i in range(3))

        print(f"  Max delta:  {max_delta:.10f}")
        print(f"  prev3 delta: {prev3_delta:.10f}")
        for g in range(5):
            d = result[g] - oracle_1min[g]
            print(f"  group {g}: computed={result[g]:.10f} oracle={oracle_1min[g]:.10f} delta={d:+.10f}")
        print()


if __name__ == '__main__':
    main()
