#!/usr/bin/env bash
# Download and extract reference materials for CareSens Air reverse engineering.
# All proprietary assets go in vendor/ (gitignored).
#
# Prerequisites:
#   - apktool (brew install apktool)
#   - jadx (brew install jadx)
#   - Ghidra (optional, for decompilation)
#   - Xcode command line tools (for llvm-objdump and llvm-nm)
#
# Usage: ./scripts/setup-vendor.sh <path-to-airsdk-apk>
#
# The APK can be obtained from the Google Play Store (search "CareSens Air")
# or from APK mirror sites. Look for: com.isens.airsdk

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VENDOR_DIR="$PROJECT_DIR/vendor"

APK_PATH="${1:-}"

if [ -z "$APK_PATH" ]; then
    echo "Usage: $0 <path-to-airsdk-apk>"
    echo ""
    echo "Download the CareSens Air APK (com.isens.airsdk) and provide the path."
    exit 1
fi

if [ ! -f "$APK_PATH" ]; then
    echo "Error: APK not found at $APK_PATH"
    exit 1
fi

echo "=== Setting up vendor directory ==="
mkdir -p "$VENDOR_DIR"/{apk,native,decompiled_java,decompiled_c,disasm}

# Step 1: Extract native library
echo ""
echo "=== Step 1: Extracting native library ==="
mkdir -p "$VENDOR_DIR/apk"
cp "$APK_PATH" "$VENDOR_DIR/apk/"
cd "$VENDOR_DIR/apk"
unzip -o "$(basename "$APK_PATH")" "lib/armeabi-v7a/libCALCULATION.so" -d extracted/ 2>/dev/null || true
if [ -f extracted/lib/armeabi-v7a/libCALCULATION.so ]; then
    mkdir -p "$VENDOR_DIR/native/lib/armeabi-v7a/"
    cp extracted/lib/armeabi-v7a/libCALCULATION.so "$VENDOR_DIR/native/lib/armeabi-v7a/"
    echo "  OK: libCALCULATION.so extracted"
else
    echo "  ERROR: libCALCULATION.so not found in APK"
    exit 1
fi

# Step 2: Decompile Java with jadx
echo ""
echo "=== Step 2: Decompiling Java (jadx) ==="
if command -v jadx &>/dev/null; then
    jadx -d "$VENDOR_DIR/decompiled_java" "$APK_PATH" --no-res 2>/dev/null || true
    echo "  OK: Java decompiled"
else
    echo "  SKIP: jadx not installed (brew install jadx)"
fi

# Step 3: Get symbol table
echo ""
echo "=== Step 3: Extracting symbol table ==="
LLVM_NM=$(xcrun --find llvm-nm 2>/dev/null || echo "")
SO="$VENDOR_DIR/native/lib/armeabi-v7a/libCALCULATION.so"
if [ -n "$LLVM_NM" ] && [ -f "$SO" ]; then
    $LLVM_NM "$SO" | sort > "$VENDOR_DIR/symbol_table.txt"
    echo "  OK: Symbol table saved to vendor/symbol_table.txt"
else
    echo "  SKIP: llvm-nm not available"
fi

# Step 4: Disassemble key functions
echo ""
echo "=== Step 4: Disassembling opcal4 functions ==="
OBJDUMP=$(xcrun --find llvm-objdump 2>/dev/null || echo "")
if [ -n "$OBJDUMP" ] && [ -f "$SO" ]; then
    TRIPLE="--triple=thumbv7-linux-gnueabi"

    # Complete opcal4 region
    $OBJDUMP -d $TRIPLE --start-address=0x616e8 --stop-address=0x6ef80 "$SO" \
        > "$VENDOR_DIR/disasm/all_opcal4_functions.asm"

    # Individual key functions
    declare -A FUNCTIONS=(
        ["check_error"]="0x66688:0x6c5fe"
        ["smooth_sg"]="0x6ccbc:0x6cde8"
        ["regress_cal"]="0x6ce38:0x6d3d8"
        ["solve_linear"]="0x6d458:0x6d608"
        ["apply_simple_smooth"]="0x6d608:0x6d740"
        ["smooth1q_err16"]="0x6d740:0x6d950"
        ["f_cgm_trend"]="0x6d950:0x6e0e0"
        ["fit_simple_regression"]="0x6e210:0x6e310"
        ["f_rsq"]="0x6e310:0x6e400"
        ["cal_average_without_min_max"]="0x6cc68:0x6ccbc"
        ["fun_linear_kalman_opcal1"]="0x40528:0x40d38"
    )

    for func in "${!FUNCTIONS[@]}"; do
        IFS=':' read -r start stop <<< "${FUNCTIONS[$func]}"
        $OBJDUMP -d $TRIPLE --start-address="$start" --stop-address="$stop" "$SO" \
            > "$VENDOR_DIR/disasm/${func}.asm"
    done

    echo "  OK: Key functions disassembled to vendor/disasm/"
else
    echo "  SKIP: llvm-objdump not available"
fi

echo ""
echo "=== Setup complete ==="
echo "Vendor directory: $VENDOR_DIR"
echo ""
echo "To verify: file $SO"
file "$SO" 2>/dev/null || true
