#!/bin/bash
# Run the oracle harness against the real libCALCULATION.so
#
# Prerequisites (already set up):
#   - Docker Desktop running
#   - Android NDK at ~/Library/Android/sdk/ndk/27.2.12479018
#   - Patched linker at oracle/android_sysroot/system/bin/linker
#   - Cross-compiled harness at oracle/oracle_harness_arm
#
# Usage:
#   ./run_oracle.sh                          # All 3 lot types, 400 readings each
#   ./run_oracle.sh --lot 0 --readings 50    # Quick test, lot 0 only

set -euo pipefail
cd "$(dirname "$0")"

LOT_TYPES=(0 1 2)
READINGS=400
EAPP_MAP=(0.10067 0.15 0.05)

# Parse args
while [[ $# -gt 0 ]]; do
    case $1 in
        --lot) LOT_TYPES=("$2"); shift 2 ;;
        --readings) READINGS="$2"; shift 2 ;;
        *) echo "Usage: $0 [--lot N] [--readings N]"; exit 1 ;;
    esac
done

# Recompile if source is newer than binary
if [[ oracle_harness.c -nt oracle_harness_arm ]]; then
    echo "Recompiling oracle harness..."
    NDK=$HOME/Library/Android/sdk/ndk/27.2.12479018
    CC=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/bin/armv7a-linux-androideabi24-clang
    $CC -O2 -mfloat-abi=softfp -mfpu=vfpv3-d16 \
        -o oracle_harness_arm oracle_harness.c -lm -ldl
    chmod +x oracle_harness_arm
fi

SO_PATH="$(cd ../native/lib/armeabi-v7a && pwd)/libCALCULATION.so"

for lot_num in "${LOT_TYPES[@]}"; do
    eapp=${EAPP_MAP[$lot_num]}
    outdir="output/lot${lot_num}"
    rm -rf "$outdir"
    mkdir -p "$outdir"

    echo "=== Lot $lot_num (eapp=$eapp, $READINGS readings) ==="
    docker run --rm --platform linux/arm/v7 \
        -v "$(pwd)/android_sysroot/system:/system:ro" \
        -v "$(pwd)/oracle_harness_arm:/oracle/oracle_harness:ro" \
        -v "$SO_PATH:/oracle/libCALCULATION.so:ro" \
        -v "$(pwd)/$outdir:/oracle/output" \
        debian:bookworm-slim \
        /oracle/oracle_harness \
            --so /oracle/libCALCULATION.so \
            --output /oracle/output \
            --readings "$READINGS" \
            --eapp "$eapp" 2>&1 | tail -5
    echo ""
done

echo "Oracle data saved to output/lot{0,1,2}/"
echo "Parse with: python3 ../tools/parse_oracle.py output/lot0 [seq]"
