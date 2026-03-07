# Makefile for Oracle Test Harness
#
# Builds the oracle_harness binary for ARM (Android NDK) or native host.
#
# Targets:
#   make arm          - Cross-compile for ARM using Android NDK
#   make native       - Build for native host (for struct size checks only)
#   make clean        - Remove build artifacts
#
# Environment variables:
#   NDK_PATH          - Path to Android NDK (default: auto-detect)
#   API_LEVEL         - Android API level (default: 21)

# Android NDK configuration
API_LEVEL ?= 21

# Auto-detect NDK path
ifdef NDK_PATH
    NDK := $(NDK_PATH)
else ifdef ANDROID_NDK_HOME
    NDK := $(ANDROID_NDK_HOME)
else ifdef ANDROID_NDK_ROOT
    NDK := $(ANDROID_NDK_ROOT)
else
    # Common installation paths
    NDK := $(firstword $(wildcard \
        $(HOME)/Library/Android/sdk/ndk/*/  \
        $(HOME)/Android/Sdk/ndk/*/          \
        /usr/local/lib/android/sdk/ndk/*/   \
    ))
endif

# ARM toolchain from NDK
ifdef NDK
    TOOLCHAIN := $(NDK)/toolchains/llvm/prebuilt/$(shell uname -s | tr A-Z a-z)-$(shell uname -m)
    ARM_CC := $(TOOLCHAIN)/bin/armv7a-linux-androideabi$(API_LEVEL)-clang
    ARM_STRIP := $(TOOLCHAIN)/bin/llvm-strip
else
    ARM_CC := armv7a-linux-androideabi$(API_LEVEL)-clang
    ARM_STRIP := llvm-strip
endif

# Flags matching the proprietary library's ABI
ARM_CFLAGS := -std=c11 -Wall -Wextra -O2 \
    -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 \
    -mthumb \
    -I../src

# Native compiler
NATIVE_CC := cc
NATIVE_CFLAGS := -std=c11 -Wall -Wextra -O2 -I../src

# Build directory
BUILD_DIR := build

.PHONY: all arm native clean check-ndk

all: arm

# ── ARM build (for running on device) ──

check-ndk:
	@if [ -z "$(NDK)" ]; then \
		echo "ERROR: Android NDK not found."; \
		echo "Set NDK_PATH, ANDROID_NDK_HOME, or ANDROID_NDK_ROOT."; \
		echo "Install via: sdkmanager 'ndk;27.2.12479018'"; \
		exit 1; \
	fi
	@if [ ! -x "$(ARM_CC)" ]; then \
		echo "ERROR: ARM compiler not found at $(ARM_CC)"; \
		echo "NDK path: $(NDK)"; \
		exit 1; \
	fi
	@echo "NDK: $(NDK)"
	@echo "ARM CC: $(ARM_CC)"

arm: check-ndk $(BUILD_DIR)/oracle_harness_arm

$(BUILD_DIR)/oracle_harness_arm: oracle_harness.c ../src/calibration.h | $(BUILD_DIR)
	$(ARM_CC) $(ARM_CFLAGS) -o $@ $< -ldl -lm
	@echo "Built: $@ ($(shell file $@))"
	@echo "Size: $$(stat -f%z $@ 2>/dev/null || stat -c%s $@ 2>/dev/null) bytes"

# ── Native build (for struct verification and development) ──

native: $(BUILD_DIR)/oracle_harness_native

$(BUILD_DIR)/oracle_harness_native: oracle_harness.c ../src/calibration.h | $(BUILD_DIR)
	$(NATIVE_CC) $(NATIVE_CFLAGS) -o $@ $< -ldl -lm
	@echo "Built: $@ (native, for struct size verification only)"

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

# ── Info targets ──

.PHONY: info
info:
	@echo "NDK path:      $(NDK)"
	@echo "ARM CC:        $(ARM_CC)"
	@echo "ARM CFLAGS:    $(ARM_CFLAGS)"
	@echo "API level:     $(API_LEVEL)"
	@echo "Native CC:     $(NATIVE_CC)"
