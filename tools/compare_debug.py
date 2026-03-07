#!/usr/bin/env python3
"""Field-by-field comparison of air1_opcal4_debug_t and output_t binary dumps.

Compares two binary files (reference vs test) and reports which fields
match and which differ. Supports configurable tolerance for float fields
when running cross-platform verification.

Exit code: 0 if all fields match, 1 if any differ.
"""

import argparse
import math
import sys
from collections import OrderedDict
from pathlib import Path

from parse_debug_struct import (
    DEBUG_EXPECTED_SIZE,
    DEBUG_FIELDS,
    OUTPUT_EXPECTED_SIZE,
    OUTPUT_FIELDS,
    _DEBUG_FIELD_TYPES,
    _OUTPUT_FIELD_TYPES,
    is_float_field,
    parse_debug,
    parse_output,
)


# --------------------------------------------------------------------------- #
# Comparison logic
# --------------------------------------------------------------------------- #

def compare_field(name, expected, actual, field_types=None, cross_platform=False):
    """Compare a single field value.

    Integer fields: exact match (zero tolerance for error codes, flags, etc.).
    Float fields:
      - Same platform (ARM-to-ARM): bit-exact match.
      - Cross-platform (e.g. Python on x86 vs ARM binary): relative tolerance 1e-10.

    Returns:
        (match: bool, detail: str or None)
        detail is None when values match, otherwise a description of the difference.
    """
    if isinstance(expected, list):
        # Array field: compare element by element
        if len(expected) != len(actual):
            return False, f"array length mismatch: {len(expected)} vs {len(actual)}"

        mismatches = []
        for i, (e, a) in enumerate(zip(expected, actual)):
            ok, detail = _compare_scalar(
                f"{name}[{i}]", e, a, name, field_types, cross_platform
            )
            if not ok:
                mismatches.append((i, e, a, detail))

        if mismatches:
            parts = []
            for idx, e, a, detail in mismatches[:5]:  # Show first 5 mismatches
                parts.append(f"  [{idx}]: {detail}")
            if len(mismatches) > 5:
                parts.append(f"  ... and {len(mismatches) - 5} more")
            return False, (
                f"{len(mismatches)}/{len(expected)} elements differ:\n"
                + "\n".join(parts)
            )
        return True, None

    return _compare_scalar(name, expected, actual, name, field_types, cross_platform)


def _compare_scalar(element_name, expected, actual, field_name,
                     field_types=None, cross_platform=False):
    """Compare two scalar values.

    Returns (match: bool, detail: str or None).
    """
    float_field = is_float_field(field_name, field_types)

    if float_field:
        return _compare_float(element_name, expected, actual, cross_platform)

    # Integer / boolean field: exact match, zero tolerance
    if expected == actual:
        return True, None
    return False, f"expected {expected}, got {actual}"


def _compare_float(name, expected, actual, cross_platform=False):
    """Compare two float values with appropriate tolerance.

    Returns (match: bool, detail: str or None).
    """
    # Both NaN
    if math.isnan(expected) and math.isnan(actual):
        return True, None

    # One NaN, other not
    if math.isnan(expected) or math.isnan(actual):
        return False, f"expected {_fmt(expected)}, got {_fmt(actual)} (NaN mismatch)"

    # Both Inf (same sign)
    if math.isinf(expected) and math.isinf(actual):
        if (expected > 0) == (actual > 0):
            return True, None
        return False, f"expected {_fmt(expected)}, got {_fmt(actual)} (Inf sign mismatch)"

    # One Inf, other not
    if math.isinf(expected) or math.isinf(actual):
        return False, f"expected {_fmt(expected)}, got {_fmt(actual)} (Inf mismatch)"

    if not cross_platform:
        # Same platform: bit-exact match
        if expected == actual:
            return True, None
        abs_diff = abs(expected - actual)
        rel_diff = _relative_diff(expected, actual)
        return False, (
            f"expected {_fmt(expected)}, got {_fmt(actual)} "
            f"(abs_diff={abs_diff:.6e}, rel_diff={rel_diff:.6e})"
        )

    # Cross-platform: relative tolerance 1e-10
    rel_tol = 1e-10

    if expected == actual:
        return True, None

    if expected == 0.0 and actual == 0.0:
        return True, None

    abs_diff = abs(expected - actual)
    rel_diff = _relative_diff(expected, actual)

    if rel_diff <= rel_tol:
        return True, None

    # Also check absolute difference for values near zero
    if abs_diff <= 1e-300:
        return True, None

    return False, (
        f"expected {_fmt(expected)}, got {_fmt(actual)} "
        f"(abs_diff={abs_diff:.6e}, rel_diff={rel_diff:.6e}, tol={rel_tol:.0e})"
    )


def _relative_diff(a, b):
    """Compute relative difference between two non-NaN, non-Inf floats."""
    if a == b:
        return 0.0
    denom = max(abs(a), abs(b))
    if denom == 0.0:
        return 0.0
    return abs(a - b) / denom


def _fmt(v):
    """Format a float for display."""
    if math.isnan(v):
        return "NaN"
    if math.isinf(v):
        return "Inf" if v > 0 else "-Inf"
    return f"{v:.15g}"


# --------------------------------------------------------------------------- #
# Full struct comparison
# --------------------------------------------------------------------------- #

def compare_structs(ref_parsed, test_parsed, fields, field_types,
                    cross_platform=False):
    """Compare two parsed struct dicts field by field.

    Args:
        ref_parsed: OrderedDict from reference binary
        test_parsed: OrderedDict from test binary
        fields: field descriptor list (for ordering)
        field_types: dict mapping field_name -> fmt_char
        cross_platform: if True, use relaxed float tolerance

    Returns:
        (matches: list of str, mismatches: list of (name, detail))
    """
    matches = []
    mismatches = []

    for name, _fmt_char, _count in fields:
        if name not in ref_parsed:
            mismatches.append((name, "missing from reference"))
            continue
        if name not in test_parsed:
            mismatches.append((name, "missing from test"))
            continue

        ok, detail = compare_field(
            name,
            ref_parsed[name],
            test_parsed[name],
            field_types=field_types,
            cross_platform=cross_platform
        )
        if ok:
            matches.append(name)
        else:
            mismatches.append((name, detail))

    return matches, mismatches


def print_report(matches, mismatches, struct_name, verbose=False):
    """Print a comparison report.

    Args:
        matches: list of matching field names
        mismatches: list of (field_name, detail) tuples
        struct_name: name for display
        verbose: if True, also list matching fields
    """
    total = len(matches) + len(mismatches)
    n_match = len(matches)
    n_diff = len(mismatches)

    print(f"=== {struct_name} comparison: {n_match}/{total} fields match ===")
    print()

    if verbose and matches:
        print(f"MATCHING ({n_match} fields):")
        for name in matches:
            print(f"  OK  {name}")
        print()

    if mismatches:
        print(f"DIFFERENCES ({n_diff} fields):")
        for name, detail in mismatches:
            print(f"  DIFF  {name}: {detail}")
        print()

    if n_diff == 0:
        print("RESULT: ALL FIELDS MATCH")
    else:
        print(f"RESULT: {n_diff} FIELD(S) DIFFER")


# --------------------------------------------------------------------------- #
# CLI
# --------------------------------------------------------------------------- #

def main():
    parser = argparse.ArgumentParser(
        description=(
            "Compare two binary dumps of air1_opcal4_debug_t or output_t "
            "structs field by field."
        )
    )
    parser.add_argument(
        "reference",
        help="Path to reference binary dump (expected / oracle output)"
    )
    parser.add_argument(
        "test",
        help="Path to test binary dump (our reimplementation output)"
    )
    parser.add_argument(
        "--type", "-t",
        choices=["debug", "output"],
        default=None,
        help="Struct type. Auto-detected from file size if omitted."
    )
    parser.add_argument(
        "--cross-platform", "-x",
        action="store_true",
        help=(
            "Use cross-platform float tolerance (1e-10 relative). "
            "Default is bit-exact comparison for same-platform use."
        )
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Also list matching fields"
    )

    args = parser.parse_args()

    ref_path = Path(args.reference)
    test_path = Path(args.test)

    for p, label in [(ref_path, "reference"), (test_path, "test")]:
        if not p.exists():
            print(f"Error: {label} file not found: {p}", file=sys.stderr)
            sys.exit(2)

    ref_data = ref_path.read_bytes()
    test_data = test_path.read_bytes()

    # Determine struct type
    struct_type = args.type
    if struct_type is None:
        if len(ref_data) == DEBUG_EXPECTED_SIZE:
            struct_type = "debug"
        elif len(ref_data) == OUTPUT_EXPECTED_SIZE:
            struct_type = "output"
        else:
            print(
                f"Error: reference file size {len(ref_data)} does not match "
                f"debug_t ({DEBUG_EXPECTED_SIZE}) or output_t ({OUTPUT_EXPECTED_SIZE}). "
                f"Use --type to specify.",
                file=sys.stderr
            )
            sys.exit(2)

    # Verify test file size matches
    expected_size = (
        DEBUG_EXPECTED_SIZE if struct_type == "debug" else OUTPUT_EXPECTED_SIZE
    )
    if len(test_data) != expected_size:
        print(
            f"Error: test file size {len(test_data)} does not match "
            f"expected {expected_size} bytes for {struct_type}_t.",
            file=sys.stderr
        )
        sys.exit(2)

    if struct_type == "debug":
        ref_parsed = parse_debug(ref_data)
        test_parsed = parse_debug(test_data)
        fields = DEBUG_FIELDS
        field_types = _DEBUG_FIELD_TYPES
        struct_name = "air1_opcal4_debug_t"
    else:
        ref_parsed = parse_output(ref_data)
        test_parsed = parse_output(test_data)
        fields = OUTPUT_FIELDS
        field_types = _OUTPUT_FIELD_TYPES
        struct_name = "air1_opcal4_output_t"

    matches, mismatches = compare_structs(
        ref_parsed, test_parsed, fields, field_types,
        cross_platform=args.cross_platform
    )

    print_report(matches, mismatches, struct_name, verbose=args.verbose)

    sys.exit(0 if not mismatches else 1)


if __name__ == "__main__":
    main()
