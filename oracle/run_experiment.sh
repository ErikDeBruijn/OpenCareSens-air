#!/bin/bash
# Run a single oracle experiment with custom parameters
# Usage: ./run_experiment.sh <name> [extra flags for oracle_harness]
# Example: ./run_experiment.sh eapp_0.2 --eapp 0.2
#          ./run_experiment.sh shift_m2_0_34 --shift_m2_0 34

set -euo pipefail
cd "$(dirname "$0")"

NAME="${1:?Usage: $0 <name> [extra flags]}"
shift

OUTDIR="output/exp_${NAME}"
rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"

# Recompile if needed
if [[ oracle_harness.c -nt oracle_harness_arm ]]; then
    echo "Recompiling oracle harness..."
    NDK=$HOME/Library/Android/sdk/ndk/27.2.12479018
    CC=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/bin/armv7a-linux-androideabi24-clang
    $CC -O2 -mfloat-abi=softfp -mfpu=vfpv3-d16 \
        -o oracle_harness_arm oracle_harness.c -lm -ldl
    chmod +x oracle_harness_arm
fi

SO_PATH="$(cd ../native/lib/armeabi-v7a && pwd)/libCALCULATION.so"

echo "=== Experiment: $NAME ($@) ==="
docker run --rm --platform linux/arm/v7 \
    -v "$(pwd)/android_sysroot/system:/system:ro" \
    -v "$(pwd)/oracle_harness_arm:/oracle/oracle_harness:ro" \
    -v "$SO_PATH:/oracle/libCALCULATION.so:ro" \
    -v "$(pwd)/$OUTDIR:/oracle/output" \
    debian:bookworm-slim \
    /oracle/oracle_harness \
        --so /oracle/libCALCULATION.so \
        --output /oracle/output \
        --readings 10 \
        "$@" 2>&1 | tail -15

echo "Output: $OUTDIR/"
