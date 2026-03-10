#!/usr/bin/env python3
"""
Compare our reimplementation output with oracle output on real sensor data.

Reads two CSV files (same format) and reports per-reading differences.

Usage:
  python3 tools/compare_real_data.py [--ours build/real_data_output.csv]
                                     [--oracle build/oracle_real_data_output.csv]
                                     [--tolerance 1.0]
                                     [--verbose]
"""

import csv
import sys
import os
import argparse
from collections import defaultdict


def load_csv(path):
    """Load CSV rows, skipping stderr lines (from oracle combined output)."""
    rows = []
    with open(path, 'r') as f:
        # Filter out stderr lines (they don't start with a digit and
        # don't match CSV header)
        lines = []
        for line in f:
            stripped = line.strip()
            if not stripped:
                continue
            # CSV rows start with a digit (pkt_idx) or the header
            if stripped.startswith('pkt_idx') or stripped[0].isdigit():
                lines.append(stripped)

        reader = csv.DictReader(lines)
        for row in reader:
            # Skip truncated rows (from oracle crash)
            if row.get('glucose') is None:
                continue
            rows.append(row)
    return rows


def compare(ours_path, oracle_path, tolerance=1.0, verbose=False):
    ours = load_csv(ours_path)
    oracle = load_csv(oracle_path)

    print(f"Loaded {len(ours)} rows from ours, {len(oracle)} rows from oracle")

    # Index by pkt_idx
    ours_by_pkt = {int(r['pkt_idx']): r for r in ours}
    oracle_by_pkt = {int(r['pkt_idx']): r for r in oracle}

    common_pkts = sorted(set(ours_by_pkt.keys()) & set(oracle_by_pkt.keys()))
    only_ours = sorted(set(ours_by_pkt.keys()) - set(oracle_by_pkt.keys()))
    only_oracle = sorted(set(oracle_by_pkt.keys()) - set(ours_by_pkt.keys()))

    if only_ours:
        print(f"Only in ours: {len(only_ours)} packets "
              f"(first: {only_ours[:5]})")
    if only_oracle:
        print(f"Only in oracle: {len(only_oracle)} packets "
              f"(first: {only_oracle[:5]})")

    print(f"Common packets: {len(common_pkts)}")
    print()

    # Compare fields
    glucose_diffs = []
    errcode_mismatches = []
    trendrate_diffs = []
    stage_mismatches = []
    ret_mismatches = []
    glucose_match_count = 0
    glucose_close_count = 0  # within tolerance
    glucose_far_count = 0

    for pkt_idx in common_pkts:
        o = ours_by_pkt[pkt_idx]
        r = oracle_by_pkt[pkt_idx]

        our_glu = float(o['glucose'])
        orc_glu = float(r['glucose'])
        our_err = int(o['errcode'])
        orc_err = int(r['errcode'])
        our_trend = float(o['trendrate'])
        orc_trend = float(r['trendrate'])
        our_stage = int(o['stage'])
        orc_stage = int(r['stage'])
        our_ret = int(o['ret'])
        orc_ret = int(r['ret'])

        glu_diff = abs(our_glu - orc_glu)
        glucose_diffs.append((pkt_idx, our_glu, orc_glu, glu_diff))

        if glu_diff < 0.05:
            glucose_match_count += 1
        elif glu_diff <= tolerance:
            glucose_close_count += 1
        else:
            glucose_far_count += 1

        if our_err != orc_err:
            errcode_mismatches.append(
                (pkt_idx, int(o['seq_number']), our_err, orc_err))

        if our_ret != orc_ret:
            ret_mismatches.append(
                (pkt_idx, int(o['seq_number']), our_ret, orc_ret))

        if our_stage != orc_stage:
            stage_mismatches.append(
                (pkt_idx, int(o['seq_number']), our_stage, orc_stage))

        trend_diff = abs(our_trend - orc_trend)
        if trend_diff > 0.1:
            trendrate_diffs.append(
                (pkt_idx, int(o['seq_number']), our_trend, orc_trend,
                 trend_diff))

    # Report
    all_diffs = [d[3] for d in glucose_diffs if d[3] > 0]
    if all_diffs:
        avg_diff = sum(all_diffs) / len(all_diffs)
        max_diff = max(all_diffs)
        max_idx = max(glucose_diffs, key=lambda x: x[3])
    else:
        avg_diff = 0
        max_diff = 0
        max_idx = (0, 0, 0, 0)

    print("=== GLUCOSE COMPARISON ===")
    print(f"  Exact match (<0.05):  {glucose_match_count}")
    print(f"  Close (<={tolerance}):        {glucose_close_count}")
    print(f"  Different (>{tolerance}):     {glucose_far_count}")
    if all_diffs:
        print(f"  Average diff:         {avg_diff:.3f} mg/dL")
        print(f"  Max diff:             {max_diff:.3f} mg/dL "
              f"(pkt {max_idx[0]}: ours={max_idx[1]:.1f}, "
              f"oracle={max_idx[2]:.1f})")
    print()

    print("=== ERRCODE COMPARISON ===")
    print(f"  Mismatches: {len(errcode_mismatches)}")
    if errcode_mismatches and verbose:
        for pkt, seq, oe, re in errcode_mismatches[:20]:
            print(f"    pkt {pkt} seq {seq}: ours={oe}, oracle={re}")
    print()

    print("=== RETURN VALUE COMPARISON ===")
    print(f"  Mismatches: {len(ret_mismatches)}")
    if ret_mismatches and verbose:
        for pkt, seq, ov, rv in ret_mismatches[:20]:
            print(f"    pkt {pkt} seq {seq}: ours={ov}, oracle={rv}")
    print()

    print("=== STAGE COMPARISON ===")
    print(f"  Mismatches: {len(stage_mismatches)}")
    print()

    print("=== TRENDRATE COMPARISON (diff > 0.1) ===")
    print(f"  Divergent: {len(trendrate_diffs)}")
    if trendrate_diffs and verbose:
        for pkt, seq, ot, rt, d in trendrate_diffs[:20]:
            print(f"    pkt {pkt} seq {seq}: ours={ot:.4f}, "
                  f"oracle={rt:.4f} (diff={d:.4f})")
    print()

    # Show worst glucose discrepancies
    if glucose_far_count > 0:
        print(f"=== TOP 20 GLUCOSE DISCREPANCIES (>{tolerance} mg/dL) ===")
        sorted_diffs = sorted(glucose_diffs, key=lambda x: -x[3])
        for pkt_idx, our_glu, orc_glu, diff in sorted_diffs[:20]:
            o = ours_by_pkt[pkt_idx]
            r = oracle_by_pkt[pkt_idx]
            print(f"  pkt {pkt_idx:4d} seq {o['seq_number']:>5s}: "
                  f"ours={our_glu:7.1f} oracle={orc_glu:7.1f} "
                  f"diff={diff:6.1f}  "
                  f"err_ours={o['errcode']} err_orc={r['errcode']}")
        print()

    # Summary
    total = len(common_pkts)
    match_pct = (glucose_match_count / total * 100) if total else 0
    close_pct = ((glucose_match_count + glucose_close_count) / total * 100) \
        if total else 0
    print(f"=== SUMMARY ===")
    print(f"  Total compared:      {total}")
    print(f"  Exact match:         {glucose_match_count} ({match_pct:.1f}%)")
    print(f"  Within {tolerance} mg/dL:    "
          f"{glucose_match_count + glucose_close_count} ({close_pct:.1f}%)")
    print(f"  Errcode mismatches:  {len(errcode_mismatches)}")
    print(f"  Return mismatches:   {len(ret_mismatches)}")

    return glucose_far_count == 0 and len(errcode_mismatches) == 0


def main():
    parser = argparse.ArgumentParser(
        description='Compare reimplementation vs oracle on real sensor data')
    parser.add_argument('--ours', default='build/real_data_output.csv',
                        help='Path to our output CSV')
    parser.add_argument('--oracle', default='build/oracle_real_data_output.csv',
                        help='Path to oracle output CSV')
    parser.add_argument('--tolerance', type=float, default=1.0,
                        help='Glucose tolerance in mg/dL (default: 1.0)')
    parser.add_argument('--verbose', '-v', action='store_true',
                        help='Show detailed mismatches')
    args = parser.parse_args()

    if not os.path.exists(args.ours):
        print(f"ERROR: Our output not found: {args.ours}")
        print("Run: ./build/test_real_data --data-dir build "
              "--csv build/real_data_output.csv")
        sys.exit(1)

    if not os.path.exists(args.oracle):
        print(f"NOTE: Oracle output not found: {args.oracle}")
        print("Run: cd oracle && ./run_oracle_real_data.sh")
        print()
        print("Showing our output summary instead:")
        ours = load_csv(args.ours)
        valid = [r for r in ours if float(r['glucose']) > 0]
        errors = [r for r in ours if int(r['errcode']) != 0]
        print(f"  Total readings: {len(ours)}")
        print(f"  Valid glucose:  {len(valid)}")
        print(f"  With errors:    {len(errors)}")
        if valid:
            glucoses = [float(r['glucose']) for r in valid]
            print(f"  Glucose range:  {min(glucoses):.1f} - "
                  f"{max(glucoses):.1f} mg/dL")
            print(f"  Glucose mean:   "
                  f"{sum(glucoses)/len(glucoses):.1f} mg/dL")
        sys.exit(0)

    success = compare(args.ours, args.oracle, args.tolerance, args.verbose)
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
