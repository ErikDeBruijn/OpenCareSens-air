#!/bin/bash
#
# run_oracle.sh — Build, deploy, run the oracle harness, and pull results.
#
# This script supports three execution modes:
#   1. adb    - Push to Android device via adb (default, most reliable)
#   2. qemu   - Run via QEMU user-mode emulation (requires qemu-arm)
#   3. native - Build and run natively (struct verification only, no .so)
#
# Usage:
#   ./run_oracle.sh [adb|qemu|native] [options]
#
# Options:
#   --device <serial>  Use specific adb device
#   --lib <path>       Override path to libCALCULATION.so
#   --output <dir>     Override output directory (default: ./output)
#   --readings <n>     Override number of readings (requires recompile)
#
# Prerequisites:
#   adb mode:  Android NDK installed, Android device connected via USB
#   qemu mode: qemu-arm installed (brew install qemu), NDK installed
#   native:    Host C compiler (for struct verification only)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ORACLE_DIR="$SCRIPT_DIR"

# Defaults
MODE="${1:-adb}"
shift 2>/dev/null || true

LIB_PATH="$PROJECT_DIR/vendor/native/lib/armeabi-v7a/libCALCULATION.so"
OUTPUT_DIR="$ORACLE_DIR/output"
ADB_DEVICE=""
ADB_WORKDIR="/data/local/tmp/oracle"

# Parse options
while [[ $# -gt 0 ]]; do
    case "$1" in
        --device)  ADB_DEVICE="-s $2"; shift 2 ;;
        --lib)     LIB_PATH="$2"; shift 2 ;;
        --output)  OUTPUT_DIR="$2"; shift 2 ;;
        *)         echo "Unknown option: $1"; exit 1 ;;
    esac
done

echo "==========================================="
echo "  Oracle Harness Runner"
echo "==========================================="
echo "Mode:    $MODE"
echo "Library: $LIB_PATH"
echo "Output:  $OUTPUT_DIR"
echo ""

# Verify the .so exists
if [[ "$MODE" != "native" ]] && [[ ! -f "$LIB_PATH" ]]; then
    echo "ERROR: libCALCULATION.so not found at $LIB_PATH"
    echo "Run scripts/setup-vendor.sh first to extract from APK."
    exit 1
fi

case "$MODE" in

# ─────────────────────────────────────────────────
# Mode 1: Android device via adb
# ─────────────────────────────────────────────────
adb)
    echo "=== Building for ARM (Android NDK) ==="
    cd "$ORACLE_DIR"
    make arm

    BINARY="$ORACLE_DIR/build/oracle_harness_arm"
    if [[ ! -f "$BINARY" ]]; then
        echo "ERROR: Build failed, binary not found."
        exit 1
    fi

    echo ""
    echo "=== Checking adb device ==="
    # shellcheck disable=SC2086
    adb $ADB_DEVICE devices -l
    # shellcheck disable=SC2086
    adb $ADB_DEVICE shell "echo 'Device OK: $(getprop ro.product.model 2>/dev/null || echo unknown)'"

    echo ""
    echo "=== Deploying to device ==="
    # shellcheck disable=SC2086
    adb $ADB_DEVICE shell "mkdir -p $ADB_WORKDIR/output"
    # shellcheck disable=SC2086
    adb $ADB_DEVICE push "$BINARY" "$ADB_WORKDIR/oracle_harness"
    # shellcheck disable=SC2086
    adb $ADB_DEVICE shell "chmod 755 $ADB_WORKDIR/oracle_harness"
    # shellcheck disable=SC2086
    adb $ADB_DEVICE push "$LIB_PATH" "$ADB_WORKDIR/libCALCULATION.so"

    echo ""
    echo "=== Running oracle on device ==="
    START_TIME=$(date +%s)
    # Run with LD_LIBRARY_PATH set so dlopen finds the .so
    # shellcheck disable=SC2086
    adb $ADB_DEVICE shell "cd $ADB_WORKDIR && \
        LD_LIBRARY_PATH=$ADB_WORKDIR \
        ./oracle_harness ./libCALCULATION.so ./output" \
        2>&1 | tee "$ORACLE_DIR/build/oracle_run.log"
    END_TIME=$(date +%s)
    echo ""
    echo "Execution time: $((END_TIME - START_TIME)) seconds"

    echo ""
    echo "=== Pulling results ==="
    mkdir -p "$OUTPUT_DIR"
    # shellcheck disable=SC2086
    adb $ADB_DEVICE pull "$ADB_WORKDIR/output/" "$OUTPUT_DIR/"

    echo ""
    echo "=== Cleanup on device ==="
    # shellcheck disable=SC2086
    adb $ADB_DEVICE shell "rm -rf $ADB_WORKDIR"

    echo ""
    echo "=== Results ==="
    echo "Output directory: $OUTPUT_DIR"
    find "$OUTPUT_DIR" -type f | head -20
    echo "..."
    echo "Total files: $(find "$OUTPUT_DIR" -type f | wc -l | tr -d ' ')"
    ;;

# ─────────────────────────────────────────────────
# Mode 2: QEMU user-mode emulation
# ─────────────────────────────────────────────────
qemu)
    if ! command -v qemu-arm &>/dev/null; then
        echo "ERROR: qemu-arm not found. Install with: brew install qemu"
        exit 1
    fi

    echo "=== Building for ARM (Android NDK, static) ==="
    cd "$ORACLE_DIR"

    # For QEMU, we need additional Android sysroot libraries.
    # The binary links dynamically against libdl (for dlopen) which
    # needs the Android linker. We use a wrapper approach.
    make arm

    BINARY="$ORACLE_DIR/build/oracle_harness_arm"

    echo ""
    echo "=== Running via QEMU ==="
    mkdir -p "$OUTPUT_DIR"

    # Copy the .so to the output dir where QEMU can find it
    cp "$LIB_PATH" "$OUTPUT_DIR/libCALCULATION.so"

    START_TIME=$(date +%s)

    # QEMU user-mode requires the Android linker and libraries.
    # We need to find the NDK sysroot.
    NDK_PATH="${NDK_PATH:-${ANDROID_NDK_HOME:-${ANDROID_NDK_ROOT:-}}}"
    if [[ -z "$NDK_PATH" ]]; then
        NDK_PATH=$(ls -d "$HOME/Library/Android/sdk/ndk/"* 2>/dev/null | head -1)
    fi

    if [[ -n "$NDK_PATH" ]]; then
        SYSROOT="$NDK_PATH/toolchains/llvm/prebuilt/$(uname -s | tr 'A-Z' 'a-z')-$(uname -m)/sysroot"
        echo "Using sysroot: $SYSROOT"
        qemu-arm \
            -L "$SYSROOT" \
            -E "LD_LIBRARY_PATH=$OUTPUT_DIR:$SYSROOT/usr/lib/arm-linux-androideabi" \
            "$BINARY" \
            "$OUTPUT_DIR/libCALCULATION.so" \
            "$OUTPUT_DIR" \
            2>&1 | tee "$ORACLE_DIR/build/oracle_run.log"
    else
        echo "WARNING: NDK sysroot not found, trying without -L"
        qemu-arm \
            -E "LD_LIBRARY_PATH=$OUTPUT_DIR" \
            "$BINARY" \
            "$OUTPUT_DIR/libCALCULATION.so" \
            "$OUTPUT_DIR" \
            2>&1 | tee "$ORACLE_DIR/build/oracle_run.log"
    fi

    END_TIME=$(date +%s)
    echo ""
    echo "Execution time: $((END_TIME - START_TIME)) seconds"

    # Clean up copied .so
    rm -f "$OUTPUT_DIR/libCALCULATION.so"

    echo ""
    echo "=== Results ==="
    echo "Output directory: $OUTPUT_DIR"
    find "$OUTPUT_DIR" -type f | head -20
    echo "..."
    echo "Total files: $(find "$OUTPUT_DIR" -type f | wc -l | tr -d ' ')"
    ;;

# ─────────────────────────────────────────────────
# Mode 3: Native build (struct verification only)
# ─────────────────────────────────────────────────
native)
    echo "=== Building natively (struct verification only) ==="
    echo "NOTE: The native build can verify struct sizes but cannot"
    echo "run libCALCULATION.so (which is ARM-only)."
    echo ""

    cd "$ORACLE_DIR"
    make native

    BINARY="$ORACLE_DIR/build/oracle_harness_native"

    # Create a dummy .so path just to see struct sizes
    echo ""
    echo "=== Running struct size verification ==="
    echo "(Will fail at dlopen since .so is ARM-only, but sizes are checked first)"
    "$BINARY" /nonexistent/libCALCULATION.so "$OUTPUT_DIR" || true
    ;;

*)
    echo "ERROR: Unknown mode '$MODE'"
    echo "Usage: $0 [adb|qemu|native]"
    exit 1
    ;;
esac

echo ""
echo "Done."
