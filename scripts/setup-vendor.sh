#!/usr/bin/env bash
# Extract and prepare reference materials for CareSens Air reverse engineering.
# All proprietary assets go in vendor/ (gitignored).
#
# Prerequisites:
#   - jadx (brew install jadx / apt install jadx)
#   - llvm tools: llvm-objdump, llvm-nm
#     macOS: included with Xcode command line tools
#     Linux: apt install llvm  (or llvm-14, etc.)
#
# Optional:
#   - Ghidra (for C decompilation — see Step 5)
#
# Usage:
#   ./scripts/setup-vendor.sh <path-to-file>
#
# The input file can be:
#   - An .xapk file (split APK bundle, e.g. from APKPure)
#   - A regular .apk file
#
# How to obtain the CareSens Air app:
#   1. Go to https://apkpure.com/caresens-air/com.isens.csair/download
#   2. Download the XAPK file (~30 MB)
#   3. The app package is com.isens.csair (CareSens Air by i-SENS)
#   4. You need the armeabi-v7a (32-bit ARM) variant for the oracle harness.
#      APKPure offers multiple variants per version — choose the one that
#      includes "armeabi-v7a" (not "arm64-v8a" / "x86").
#      If only XAPK format is available, the script will automatically
#      extract the correct split APK from it.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VENDOR_DIR="$PROJECT_DIR/vendor"

INPUT_PATH="${1:-}"

if [ -z "$INPUT_PATH" ]; then
    echo "Usage: $0 <path-to-xapk-or-apk>"
    echo ""
    echo "Download the CareSens Air app (com.isens.csair) and provide the path."
    echo ""
    echo "Supported formats:"
    echo "  .xapk  — Split APK bundle (from APKPure, recommended)"
    echo "  .apk   — Regular APK"
    echo ""
    echo "How to download:"
    echo "  1. Visit https://apkpure.com/caresens-air/com.isens.csair/download"
    echo "  2. Download the XAPK (~30 MB)"
    echo "  3. Make sure to pick the armeabi-v7a (32-bit ARM) variant"
    echo ""
    echo "This script will:"
    echo "  1. Extract libCALCULATION.so (ARM native library)"
    echo "  2. Decompile Java sources with jadx"
    echo "  3. Extract the complete symbol table"
    echo "  4. Disassemble all opcal4 functions"
    echo "  5. (Optional) Guide you through Ghidra decompilation"
    echo ""
    echo "All output goes to vendor/ (gitignored)."
    exit 1
fi

if [ ! -f "$INPUT_PATH" ]; then
    echo "Error: File not found at $INPUT_PATH"
    exit 1
fi

# Find llvm tools (macOS via xcrun, Linux via PATH)
find_tool() {
    local tool="$1"
    if command -v xcrun &>/dev/null; then
        xcrun --find "$tool" 2>/dev/null && return 0
    fi
    command -v "$tool" 2>/dev/null && return 0
    # Try versioned names (common on Linux)
    for ver in 18 17 16 15 14; do
        command -v "${tool}-${ver}" 2>/dev/null && return 0
    done
    echo ""
}

echo "=== Setting up vendor directory ==="
# Remove any leftover symlinks (from earlier development)
for dir in native decompiled_java decompiled_c disasm; do
    if [ -L "$VENDOR_DIR/$dir" ]; then
        echo "  Removing stale symlink: vendor/$dir"
        rm "$VENDOR_DIR/$dir"
    fi
done
mkdir -p "$VENDOR_DIR"/{apk,native,decompiled_java,decompiled_c,disasm}

# ── Step 1: Extract native library ──
echo ""
echo "=== Step 1: Extracting native library ==="
WORK_DIR="$VENDOR_DIR/apk"
mkdir -p "$WORK_DIR"
cp "$INPUT_PATH" "$WORK_DIR/"
cd "$WORK_DIR"

INPUT_FILE="$(basename "$INPUT_PATH")"
SO_FOUND=false
APK_FOR_JADX=""

# Determine input type and extract accordingly
case "$INPUT_FILE" in
    *.xapk)
        echo "  Detected XAPK (split APK bundle)"
        mkdir -p xapk_contents
        unzip -o "$INPUT_FILE" -d xapk_contents/ 2>/dev/null

        # Try to find the armeabi-v7a split APK first (needed for oracle harness)
        if [ -f xapk_contents/config.armeabi_v7a.apk ]; then
            echo "  Found config.armeabi_v7a.apk split"
            mkdir -p extracted
            unzip -o xapk_contents/config.armeabi_v7a.apk "lib/armeabi-v7a/libCALCULATION.so" -d extracted/ 2>/dev/null || true
            if [ -f extracted/lib/armeabi-v7a/libCALCULATION.so ]; then
                SO_FOUND=true
            fi
        fi

        # If no armeabi-v7a, try arm64-v8a (will need different oracle setup)
        if [ "$SO_FOUND" = false ] && [ -f xapk_contents/config.arm64_v8a.apk ]; then
            echo "  WARNING: No armeabi-v7a split found. Found arm64-v8a instead."
            echo "  The oracle harness is built for 32-bit ARM (armeabi-v7a)."
            echo "  Try downloading a different variant from APKPure that includes armeabi-v7a."
            echo ""
            echo "  Extracting arm64-v8a anyway for reference..."
            mkdir -p extracted
            unzip -o xapk_contents/config.arm64_v8a.apk "lib/arm64-v8a/libCALCULATION.so" -d extracted/ 2>/dev/null || true
            if [ -f extracted/lib/arm64-v8a/libCALCULATION.so ]; then
                echo "  Saved arm64-v8a library (NOT compatible with current oracle harness)"
                mkdir -p "$VENDOR_DIR/native/lib/arm64-v8a/"
                cp extracted/lib/arm64-v8a/libCALCULATION.so "$VENDOR_DIR/native/lib/arm64-v8a/"
            fi
        fi

        # Also check if the base APK contains the .so directly
        if [ "$SO_FOUND" = false ]; then
            for apk in xapk_contents/*.apk; do
                [ -f "$apk" ] || continue
                if unzip -l "$apk" 2>/dev/null | grep -q "lib/armeabi-v7a/libCALCULATION.so"; then
                    echo "  Found libCALCULATION.so in $(basename "$apk")"
                    unzip -o "$apk" "lib/armeabi-v7a/libCALCULATION.so" -d extracted/ 2>/dev/null || true
                    SO_FOUND=true
                    break
                fi
            done
        fi

        # Use the base APK for jadx decompilation
        if [ -f xapk_contents/com.isens.csair.apk ]; then
            APK_FOR_JADX="$WORK_DIR/xapk_contents/com.isens.csair.apk"
        fi
        ;;
    *.apk)
        echo "  Detected regular APK"
        mkdir -p extracted
        unzip -o "$INPUT_FILE" "lib/armeabi-v7a/libCALCULATION.so" -d extracted/ 2>/dev/null || true
        if [ -f extracted/lib/armeabi-v7a/libCALCULATION.so ]; then
            SO_FOUND=true
        fi
        APK_FOR_JADX="$WORK_DIR/$INPUT_FILE"
        ;;
    *)
        echo "  ERROR: Unsupported file format. Expected .xapk or .apk"
        exit 1
        ;;
esac

if [ "$SO_FOUND" = true ]; then
    mkdir -p "$VENDOR_DIR/native/lib/armeabi-v7a/"
    cp extracted/lib/armeabi-v7a/libCALCULATION.so "$VENDOR_DIR/native/lib/armeabi-v7a/"
    echo "  OK: libCALCULATION.so (armeabi-v7a) extracted"
else
    echo "  ERROR: libCALCULATION.so (armeabi-v7a) not found"
    echo ""
    echo "  The oracle harness requires the 32-bit ARM (armeabi-v7a) library."
    echo "  When downloading from APKPure, make sure to select the armeabi-v7a variant."
    echo "  The arm64-v8a (64-bit) variant will NOT work with the current oracle setup."
    exit 1
fi

SO="$VENDOR_DIR/native/lib/armeabi-v7a/libCALCULATION.so"
cd "$PROJECT_DIR"

# ── Step 2: Verify library ──
echo ""
echo "=== Step 2: Verifying library ==="
file "$SO" 2>/dev/null || true
SO_SIZE=$(wc -c < "$SO" | tr -d ' ')
echo "  Size: $SO_SIZE bytes"

# Check it's an ARM ELF with expected symbols
LLVM_NM=$(find_tool llvm-nm)
if [ -n "$LLVM_NM" ] && [ -f "$SO" ]; then
    # Verify key opcal4 symbols exist
    if $LLVM_NM "$SO" 2>/dev/null | grep -q "air1_opcal4_algorithm"; then
        echo "  OK: air1_opcal4_algorithm symbol found"
    else
        echo "  WARNING: air1_opcal4_algorithm symbol NOT found — wrong library version?"
    fi
    if $LLVM_NM "$SO" 2>/dev/null | grep -q "check_error"; then
        echo "  OK: check_error symbol found"
    else
        echo "  WARNING: check_error symbol NOT found"
    fi
else
    echo "  SKIP: llvm-nm not available for verification"
fi

# ── Step 3: Decompile Java with jadx ──
echo ""
echo "=== Step 3: Decompiling Java (jadx) ==="
if command -v jadx &>/dev/null; then
    if [ -n "$APK_FOR_JADX" ] && [ -f "$APK_FOR_JADX" ]; then
        jadx -d "$VENDOR_DIR/decompiled_java" "$APK_FOR_JADX" --no-res 2>/dev/null || true
        # Verify key files were decompiled
        KEY_JAVA="$VENDOR_DIR/decompiled_java/sources/com/isens/airsdk/module/type/DebugData4Obj.java"
        if [ -f "$KEY_JAVA" ]; then
            echo "  OK: Java decompiled (DebugData4Obj.java found)"
        else
            echo "  WARNING: Java decompiled but DebugData4Obj.java not found at expected path"
            echo "  Look in vendor/decompiled_java/ for the actual layout"
        fi
    else
        echo "  SKIP: No base APK found for jadx decompilation"
    fi
else
    echo "  SKIP: jadx not installed"
    echo "  Install: brew install jadx (macOS) or apt install jadx (Linux)"
    echo ""
    echo "  This step is IMPORTANT — it produces DebugData4Obj.java which defines"
    echo "  the byte layout of the 1579-byte debug oracle struct."
fi

# ── Step 4: Extract symbol table ──
echo ""
echo "=== Step 4: Extracting symbol table ==="
if [ -n "$LLVM_NM" ] && [ -f "$SO" ]; then
    $LLVM_NM "$SO" | sort > "$VENDOR_DIR/symbol_table.txt"
    SYMBOL_COUNT=$($LLVM_NM "$SO" 2>/dev/null | wc -l | tr -d ' ')
    echo "  OK: Symbol table saved to vendor/symbol_table.txt ($SYMBOL_COUNT symbols)"
    echo ""
    echo "  Key insight: This library is NOT stripped. All function names are visible,"
    echo "  including static (local) functions (marked with lowercase 't')."
else
    echo "  SKIP: llvm-nm not available"
fi

# ── Step 5: Disassemble opcal4 functions ──
echo ""
echo "=== Step 5: Disassembling opcal4 functions ==="
OBJDUMP=$(find_tool llvm-objdump)
if [ -n "$OBJDUMP" ] && [ -f "$SO" ]; then
    TRIPLE="--triple=thumbv7-linux-gnueabi"

    # Complete opcal4 region (all helper functions + main algorithm)
    # Range: cal_threshold (0x61518) through err1_TD_trio_update end (~0x6ef80)
    $OBJDUMP -d $TRIPLE --start-address=0x61518 --stop-address=0x6ef80 "$SO" \
        > "$VENDOR_DIR/disasm/all_opcal4_functions.asm"
    echo "  OK: Complete opcal4 region disassembled"

    # Individual key functions (names match docs/reference/caresens-air-knowledge-base.md)
    #
    # Functions that Ghidra CANNOT decompile (truncated after __aeabi_memclr8):
    # These are the critical ones — ARM disassembly is our only source.
    declare -A FUNCTIONS=(
        # Signal processing (Ghidra-truncated → full disasm required)
        ["smooth_sg_opcal4"]="0x6ccbc:0x6cde8"
        ["regress_cal_opcal4"]="0x6ce38:0x6d3d8"
        ["fun_linear_kalman"]="0x40528:0x40d38"

        # Error detection (Ghidra couldn't find check_error at all)
        ["check_error"]="0x66688:0x6c5fe"
        ["f_cgm_trend_opcal4"]="0x6d950:0x6e0e0"

        # Newly discovered helpers (not in Ghidra function list)
        ["solve_linear"]="0x6d458:0x6d608"
        ["apply_simple_smooth"]="0x6d608:0x6d740"
        ["smooth1q_err16"]="0x6d740:0x6d950"
        ["fit_simple_regression"]="0x6e210:0x6e310"
        ["f_rsq"]="0x6e310:0x6e400"
        ["cal_average_without_min_max"]="0x6cc68:0x6ccbc"

        # Error helpers (Ghidra CAN decompile these, but disasm is useful for verification)
        ["cal_threshold"]="0x6e908:0x6e9fc"
        ["err1_TD_var_update"]="0x6e9fc:0x6ea48"
        ["err1_TD_trio_update"]="0x6ea48:0x6ef80"
        ["f_check_cgm_trend"]="0x6e498:0x6e700"

        # Math utilities (Ghidra CAN decompile these, included for completeness)
        ["math_mean"]="0x6c6a0:0x6c6f8"
        ["math_std"]="0x6c610:0x6c668"
        ["eliminate_peak"]="0x6c6f8:0x6c758"
        ["delete_element"]="0x6c668:0x6c6a0"
        ["math_round"]="0x6c758:0x6c7a0"
        ["quick_median"]="0x6c7a0:0x6c828"
        ["fun_comp_decimals"]="0x6c828:0x6c950"
        ["math_median"]="0x6c950:0x6ca20"
        ["quick_select"]="0x6ca20:0x6cbd0"
        ["math_round_digits"]="0x6cbd0:0x6cc68"
        ["check_boundary"]="0x6d3d8:0x6d458"
        ["calcPercentile"]="0x6e0e0:0x6e170"
        ["f_trimmed_mean"]="0x6e170:0x6e210"
        ["math_max"]="0x6e400:0x6e448"
        ["math_min"]="0x6e448:0x6e498"
    )

    for func in "${!FUNCTIONS[@]}"; do
        IFS=':' read -r start stop <<< "${FUNCTIONS[$func]}"
        $OBJDUMP -d $TRIPLE --start-address="$start" --stop-address="$stop" "$SO" \
            > "$VENDOR_DIR/disasm/${func}.asm"
    done

    DISASM_COUNT=$(ls "$VENDOR_DIR/disasm/"*.asm 2>/dev/null | wc -l | tr -d ' ')
    echo "  OK: $DISASM_COUNT files written to vendor/disasm/"
    echo ""
    echo "  Key files for LLM-assisted transpilation:"
    echo "    check_error.asm          — 8008 instructions (ALL error detection)"
    echo "    fun_linear_kalman.asm    — 583 instructions (Kalman filter, opcal1 reference)"
    echo "    regress_cal_opcal4.asm   — 462 instructions (IRLS regression)"
    echo "    f_cgm_trend_opcal4.asm   — 636 instructions (CGM trend analysis)"
    echo "    smooth_sg_opcal4.asm     — 111 instructions (Savitzky-Golay smoothing)"
else
    echo "  SKIP: llvm-objdump not available"
    echo "  Install: Xcode command line tools (macOS) or apt install llvm (Linux)"
fi

# ── Step 6: Ghidra decompilation guidance ──
echo ""
echo "=== Step 6: Ghidra C decompilation (manual) ==="
echo "  Ghidra decompilation is optional but helpful for math utility functions."
echo "  To produce vendor/decompiled_c/all_functions.c:"
echo ""
echo "  1. Open Ghidra, import libCALCULATION.so as ARM:LE:32:v7 (Thumb)"
echo "  2. Run auto-analysis"
echo "  3. Select all functions → Export as C/C++ to vendor/decompiled_c/all_functions.c"
echo ""
echo "  WARNING: Ghidra applies a 0x10000 base address offset."
echo "  Ghidra address = ELF VMA + 0x10000"
echo "  The ARM disassembly (Step 5) uses correct ELF VMA addresses."
echo ""
echo "  WARNING: Ghidra truncates complex functions after __aeabi_memclr8() calls."
echo "  For truncated functions, use the ARM disassembly instead."

# ── Step 7: Clone Juggluco (struct definitions) ──
echo ""
echo "=== Step 7: Juggluco reference source ==="
JUGGLUCO_DIR="$PROJECT_DIR/../j-kaltes/Juggluco"
if [ -d "$JUGGLUCO_DIR" ]; then
    echo "  OK: Juggluco found at $JUGGLUCO_DIR"
else
    echo "  Juggluco provides the struct definitions and BLE protocol reference."
    echo "  Clone it as a sibling of this project:"
    echo ""
    echo "    git clone https://github.com/j-kaltes/Juggluco $(dirname "$PROJECT_DIR")/j-kaltes/Juggluco"
    echo ""
    echo "  Key files:"
    echo "    Common/src/main/cpp/air/air.hpp       — struct definitions (the source of truth)"
    echo "    Common/src/main/cpp/air/java.cpp       — how the algorithm is called via dlopen/dlsym"
    echo "    Common/src/dex/java/tk/glucodata/AirGattCallback.java — BLE protocol"
fi

# ── Summary ──
echo ""
echo "========================================"
echo "=== Setup complete ==="
echo "========================================"
echo ""
echo "Vendor directory: $VENDOR_DIR"
echo ""
echo "Next steps:"
echo "  1. Read docs/reference/caresens-air-knowledge-base.md (comprehensive reference)"
echo "  2. Read docs/plans/2026-03-06-caresens-air-calibration-cleanroom.md (implementation plan)"
echo "  3. Build the oracle test harness: see oracle/run_oracle.sh"
echo ""
echo "Directory structure:"
echo "  vendor/native/lib/armeabi-v7a/libCALCULATION.so  — proprietary ARM library"
echo "  vendor/decompiled_java/                          — jadx Java decompilation"
echo "  vendor/decompiled_c/                             — Ghidra C decompilation (manual)"
echo "  vendor/disasm/                                   — ARM Thumb-2 disassembly"
echo "  vendor/symbol_table.txt                          — complete function listing"
