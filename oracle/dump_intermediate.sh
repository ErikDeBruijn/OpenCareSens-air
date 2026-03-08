#!/bin/bash
# Run the oracle under GDB to dump the intermediate 30-value array
# that feeds the median filter for seq >= 3.
#
# Strategy:
#   1. Use gdb-multiarch in the Docker container
#   2. Set breakpoint at the median filter entry point
#   3. Dump 30 doubles from the source array
#
# The function starts at some address in the loaded library.
# We need to find the library's base address at runtime.
#
# Simpler approach: modify the oracle harness to call the function
# multiple times and use ltrace/strace to observe.
#
# SIMPLEST approach: Add a "signal self" instruction in the oracle
# harness between calls, so we can attach gdb at the right moment.
#
# Even simpler: build a special version of the oracle that saves
# the entire stack after the call returns. Since the function is called
# in a loop, we can save the stack frame for specific sequences.
#
# BUT: the simplest of all is to write a custom harness that:
# 1. Calls the algorithm
# 2. Uses /proc/self/mem to read the library's .data section
# 3. Dumps the GOT entry for the kernel table

set -euo pipefail
cd "$(dirname "$0")"

echo "Building GDB-instrumented oracle..."

# We need GDB in the Docker container
# Build a custom Dockerfile with GDB

cat > Dockerfile.gdb <<'DOCKERFILE'
FROM debian:bookworm-slim

# Install GDB for ARM
RUN apt-get update && apt-get install -y \
    gdb \
    python3 \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]
DOCKERFILE

echo "Building Docker image with GDB..."
docker build -t oracle-gdb -f Dockerfile.gdb .

echo "Done. Use docker run to debug."
