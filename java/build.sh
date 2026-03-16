#!/bin/bash
# Simple build script for OpenCareSens-Air Java port
# No Gradle/Maven required - just JDK 11+

set -e

JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home"
JAVAC="$JAVA_HOME/bin/javac"
JAVA="$JAVA_HOME/bin/java"

SRCDIR="src/main/java"
TESTDIR="src/test/java"
OUTDIR="build/classes"
TESTOUTDIR="build/test-classes"
LIBDIR="lib"

# Download JUnit 5 if needed
mkdir -p "$LIBDIR"
JUNIT_JAR="$LIBDIR/junit-platform-console-standalone-1.10.2.jar"
if [ ! -f "$JUNIT_JAR" ]; then
    echo "Downloading JUnit 5..."
    curl -sL "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.2/junit-platform-console-standalone-1.10.2.jar" -o "$JUNIT_JAR"
fi

# Compile main sources
echo "Compiling main sources..."
mkdir -p "$OUTDIR"
find "$SRCDIR" -name "*.java" > /tmp/java_sources.txt
if [ -s /tmp/java_sources.txt ]; then
    $JAVAC -d "$OUTDIR" @/tmp/java_sources.txt
fi

# Compile tests
echo "Compiling tests..."
mkdir -p "$TESTOUTDIR"
find "$TESTDIR" -name "*.java" > /tmp/java_test_sources.txt
if [ -s /tmp/java_test_sources.txt ]; then
    $JAVAC -d "$TESTOUTDIR" -cp "$OUTDIR:$JUNIT_JAR" @/tmp/java_test_sources.txt
fi

# Run tests
echo "Running tests..."
$JAVA -jar "$JUNIT_JAR" \
    --class-path "$OUTDIR:$TESTOUTDIR" \
    --scan-class-path "$TESTOUTDIR" \
    --details verbose

echo "Done."
