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
#   ./run_oracle.sh                          # All lots, 400 readings each
#   ./run_oracle.sh --lot 0 --readings 50    # Quick test, lot 0 only

set -euo pipefail
cd "$(dirname "$0")"

# Lot definitions: each lot has an eapp value and a glucose profile
# Format: "eapp:profile"
#   eapp: sensor parameter affecting ADC→current conversion
#   profile: 0=normal, 1=hypo, 2=hyper
LOT_DEFS=(
    "0.10067:0"   # lot0: standard eapp, normal glucose range
    "0.15:0"      # lot1: high eapp, normal glucose range
    "0.05:0"      # lot2: low eapp, normal glucose range (triggers err2)
    "0.10067:1"   # lot3: standard eapp, hypoglycemia scenario
    "0.10067:2"   # lot4: standard eapp, hyperglycemia scenario
)

LOT_TYPES=(0 1 2 3 4)
READINGS=400

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

SO_PATH="$(cd ../vendor/native/lib/armeabi-v7a && pwd)/libCALCULATION.so"

for lot_num in "${LOT_TYPES[@]}"; do
    lot_def=${LOT_DEFS[$lot_num]}
    eapp=${lot_def%%:*}
    profile=${lot_def##*:}
    outdir="output/lot${lot_num}"
    rm -rf "$outdir"
    mkdir -p "$outdir"

    echo "=== Lot $lot_num (eapp=$eapp, profile=$profile, $READINGS readings) ==="
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
            --eapp "$eapp" \
            --profile "$profile" 2>&1 | tail -5
    echo ""
done

echo "Oracle data saved to output/lot{0..4}/"
echo "Parse with: python3 ../tools/parse_oracle.py output/lot0 [seq]"
