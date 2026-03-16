#!/bin/bash
# Build and test script for OpenCareSens-Air Java port
# No Gradle/Maven required - just JDK 11+
#
# Usage:
#   ./build.sh          # compile + run all tests
#   ./build.sh compile  # compile only
#   ./build.sh test     # run tests only (must compile first)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# --- Locate JDK ---
# Try JAVA_HOME, then well-known macOS/Linux locations, then PATH
find_java_home() {
    if [ -n "$JAVA_HOME" ] && [ -x "$JAVA_HOME/bin/javac" ]; then
        echo "$JAVA_HOME"
        return
    fi

    # macOS: use java_home utility if available
    if [ -x "/usr/libexec/java_home" ]; then
        local jh
        jh=$(/usr/libexec/java_home 2>/dev/null || true)
        if [ -n "$jh" ] && [ -x "$jh/bin/javac" ]; then
            echo "$jh"
            return
        fi
    fi

    # Check well-known macOS JDK locations
    for d in /Library/Java/JavaVirtualMachines/*/Contents/Home; do
        if [ -x "$d/bin/javac" ]; then
            echo "$d"
            return
        fi
    done

    # Linux: common locations
    for d in /usr/lib/jvm/java-*-openjdk-* /usr/lib/jvm/java-*; do
        if [ -x "$d/bin/javac" ]; then
            echo "$d"
            return
        fi
    done

    # Fall back to PATH
    if command -v javac >/dev/null 2>&1; then
        local javac_path
        javac_path="$(command -v javac)"
        # Resolve symlinks to find JAVA_HOME
        javac_path="$(readlink -f "$javac_path" 2>/dev/null || realpath "$javac_path" 2>/dev/null || echo "$javac_path")"
        echo "$(dirname "$(dirname "$javac_path")")"
        return
    fi

    return 1
}

JDK_HOME="$(find_java_home)" || {
    echo "ERROR: No JDK found. Install JDK 11+ and set JAVA_HOME or add javac to PATH."
    exit 1
}

JAVAC="$JDK_HOME/bin/javac"
JAVA="$JDK_HOME/bin/java"

echo "Using JDK: $JDK_HOME"
echo "  javac: $($JAVAC -version 2>&1)"

# --- Directories ---
SRCDIR="src/main/java"
TESTDIR="src/test/java"
OUTDIR="build/classes"
TESTOUTDIR="build/test-classes"
LIBDIR="lib"

# --- Download JUnit 5 standalone console if needed ---
JUNIT_VERSION="1.10.2"
JUNIT_JAR="$LIBDIR/junit-platform-console-standalone-${JUNIT_VERSION}.jar"
JUNIT_URL="https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/${JUNIT_VERSION}/junit-platform-console-standalone-${JUNIT_VERSION}.jar"

download_junit() {
    if [ -f "$JUNIT_JAR" ]; then
        return
    fi
    echo "Downloading JUnit 5 console standalone ${JUNIT_VERSION}..."
    mkdir -p "$LIBDIR"
    if command -v curl >/dev/null 2>&1; then
        curl -sL "$JUNIT_URL" -o "$JUNIT_JAR"
    elif command -v wget >/dev/null 2>&1; then
        wget -q "$JUNIT_URL" -O "$JUNIT_JAR"
    else
        echo "ERROR: Neither curl nor wget found. Cannot download JUnit."
        exit 1
    fi
    echo "  Downloaded: $JUNIT_JAR"
}

# --- Compile ---
do_compile() {
    download_junit

    echo ""
    echo "=== Compiling main sources ==="
    mkdir -p "$OUTDIR"
    local src_files
    src_files=$(find "$SRCDIR" -name "*.java")
    if [ -z "$src_files" ]; then
        echo "  No main sources found."
    else
        local count
        count=$(echo "$src_files" | wc -l | tr -d ' ')
        $JAVAC -source 8 -target 8 -d "$OUTDIR" $src_files
        echo "  Compiled $count source files."
    fi

    echo ""
    echo "=== Compiling test sources ==="
    mkdir -p "$TESTOUTDIR"
    local test_files
    test_files=$(find "$TESTDIR" -name "*.java")
    if [ -z "$test_files" ]; then
        echo "  No test sources found."
    else
        local count
        count=$(echo "$test_files" | wc -l | tr -d ' ')
        $JAVAC -source 8 -target 8 -d "$TESTOUTDIR" -cp "$OUTDIR:$JUNIT_JAR" $test_files
        echo "  Compiled $count test files."
    fi
}

# --- Run tests ---
do_test() {
    echo ""
    echo "=== Running tests ==="
    echo ""
    $JAVA -jar "$JUNIT_JAR" \
        --class-path "$OUTDIR:$TESTOUTDIR" \
        --scan-class-path "$TESTOUTDIR" \
        --details verbose
    echo ""
    echo "=== All tests passed ==="
}

# --- Main ---
case "${1:-all}" in
    compile)
        do_compile
        ;;
    test)
        do_test
        ;;
    all|"")
        do_compile
        do_test
        ;;
    *)
        echo "Usage: $0 [compile|test|all]"
        exit 1
        ;;
esac
