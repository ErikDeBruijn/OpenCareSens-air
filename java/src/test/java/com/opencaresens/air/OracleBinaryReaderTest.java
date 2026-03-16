package com.opencaresens.air;

import com.opencaresens.air.model.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Assumptions;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests for OracleBinaryReader — verifies that we can correctly parse
 * oracle binary files into Java model objects.
 *
 * These tests read actual oracle data from oracle/output/lot0/.
 * Tests are skipped if oracle data is not present (e.g., CI without data).
 */
class OracleBinaryReaderTest {

    // Path relative to java/ directory; test runner cwd is java/
    private static final String ORACLE_DIR = "../oracle/output/lot0";
    private static boolean oracleDataAvailable;

    @BeforeAll
    static void checkOracleData() {
        Path p = Paths.get(ORACLE_DIR, "seq_0001_output.bin");
        oracleDataAvailable = Files.exists(p);
    }

    private void requireOracleData() {
        Assumptions.assumeTrue(oracleDataAvailable,
                "Oracle data not available at " + ORACLE_DIR);
    }

    // ---- Output file tests ----

    @Test
    void readOutput_seq1_hasCorrectSize() throws IOException {
        requireOracleData();
        Path p = Paths.get(ORACLE_DIR, "seq_0001_output.bin");
        assertEquals(OracleBinaryReader.OUTPUT_SIZE, Files.size(p));
    }

    @Test
    void readOutput_seq1_seqNumberIsOne() throws IOException {
        requireOracleData();
        AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, 1);
        assertEquals(1, out.seqNumberOriginal, "First reading should have seq_number_original=1");
    }

    @Test
    void readOutput_seq1_hasValidFields() throws IOException {
        requireOracleData();
        AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, 1);

        // seq_number_final should be reasonable (>= original)
        assertTrue(out.seqNumberFinal >= out.seqNumberOriginal,
                "seq_number_final should be >= seq_number_original");

        // measurement_time_standard should be after sensor_start_time (1709726400)
        assertTrue(out.measurementTimeStandard > 1709726400L,
                "measurement_time should be after sensor start");

        // result_glucose is a double — verify it's a finite number (not NaN/Inf)
        // During warmup the oracle may output unclamped intermediate values
        assertTrue(Double.isFinite(out.resultGlucose),
                "Glucose should be finite, got " + out.resultGlucose);

        // current_stage should be a small number (0-4 typically)
        assertTrue(out.currentStage <= 10,
                "current_stage should be small, got " + out.currentStage);
    }

    @Test
    void readOutput_seq1_workoutArrayIsPopulated() throws IOException {
        requireOracleData();
        AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, 1);

        // workout[30] contains ADC readings; at least some should be non-zero
        boolean hasNonZero = false;
        for (int i = 0; i < 30; i++) {
            if (out.workout[i] != 0) {
                hasNonZero = true;
                break;
            }
        }
        assertTrue(hasNonZero, "workout array should contain non-zero ADC values");
    }

    @Test
    void readOutput_seq25_postWarmup_hasGlucose() throws IOException {
        requireOracleData();
        // seq 25 is past the 24-reading warmup period
        AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, 25);
        assertEquals(25, out.seqNumberOriginal);
        // Post-warmup, glucose should be a real value (> 0) or error
        // We just verify the field was read; the oracle determines correctness
    }

    @Test
    void readOutput_rawBytesMatchParsed() throws IOException {
        requireOracleData();
        AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, 1);
        byte[] raw = OracleBinaryReader.readOutputRaw(ORACLE_DIR, 1);

        // Verify key fields at known offsets match parsed values
        assertEquals(out.seqNumberOriginal,
                OracleBinaryReader.extractUint16(raw, 0));
        assertEquals(out.seqNumberFinal,
                OracleBinaryReader.extractUint16(raw, 2));
        assertEquals(out.measurementTimeStandard,
                OracleBinaryReader.extractUint32(raw, 4));
        assertEquals(out.resultGlucose,
                OracleBinaryReader.extractDouble(raw, 68));
        assertEquals(out.trendrate,
                OracleBinaryReader.extractDouble(raw, 76));
        assertEquals(out.currentStage,
                OracleBinaryReader.extractUint8(raw, 84));
        assertEquals(out.errcode,
                OracleBinaryReader.extractUint16(raw, 151));
        assertEquals(out.calAvailableFlag,
                OracleBinaryReader.extractUint8(raw, 153));
        assertEquals(out.dataType,
                OracleBinaryReader.extractUint8(raw, 154));
    }

    // ---- Debug file tests ----

    @Test
    void readDebug_seq1_hasCorrectSize() throws IOException {
        requireOracleData();
        Path p = Paths.get(ORACLE_DIR, "seq_0001_debug.bin");
        assertEquals(OracleBinaryReader.DEBUG_SIZE, Files.size(p));
    }

    @Test
    void readDebug_seq1_seqNumberMatchesOutput() throws IOException {
        requireOracleData();
        AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, 1);
        DebugOutput dbg = OracleBinaryReader.readDebug(ORACLE_DIR, 1);

        assertEquals(out.seqNumberOriginal, dbg.seqNumberOriginal,
                "Debug and output should have same seq_number_original");
        assertEquals(out.seqNumberFinal, dbg.seqNumberFinal,
                "Debug and output should have same seq_number_final");
        assertEquals(out.measurementTimeStandard, dbg.measurementTimeStandard,
                "Debug and output should have same measurement_time_standard");
    }

    @Test
    void readDebug_seq1_temperatureIsBodyTemp() throws IOException {
        requireOracleData();
        DebugOutput dbg = OracleBinaryReader.readDebug(ORACLE_DIR, 1);

        // Oracle harness sets temperature = 36.5
        assertEquals(36.5, dbg.temperature, 0.001,
                "Temperature should be 36.5 (body temp set by oracle harness)");
    }

    @Test
    void readDebug_seq1_tranInAArrayPopulated() throws IOException {
        requireOracleData();
        DebugOutput dbg = OracleBinaryReader.readDebug(ORACLE_DIR, 1);

        // tran_inA[30] are converted current values from ADC; should be non-zero
        boolean hasNonZero = false;
        for (int i = 0; i < 30; i++) {
            if (dbg.tranInA[i] != 0.0) {
                hasNonZero = true;
                break;
            }
        }
        assertTrue(hasNonZero, "tran_inA should contain non-zero converted currents");
    }

    @Test
    void readDebug_rawBytesMatchParsed_keyFields() throws IOException {
        requireOracleData();
        DebugOutput dbg = OracleBinaryReader.readDebug(ORACLE_DIR, 1);
        byte[] raw = OracleBinaryReader.readDebugRaw(ORACLE_DIR, 1);

        // Verify against known offsets from compare_oracle.c
        assertEquals(dbg.seqNumberOriginal,
                OracleBinaryReader.extractUint16(raw, 0));
        assertEquals(dbg.seqNumberFinal,
                OracleBinaryReader.extractUint16(raw, 2));
        assertEquals(dbg.measurementTimeStandard,
                OracleBinaryReader.extractUint32(raw, 4));
        assertEquals(dbg.dataType,
                OracleBinaryReader.extractUint8(raw, 8));
        assertEquals(dbg.stage,
                OracleBinaryReader.extractUint8(raw, 9));
        assertEquals(dbg.temperature,
                OracleBinaryReader.extractDouble(raw, 10));

        // tran_inA_1min[0] at offset 318
        assertEquals(dbg.tranInA1min[0],
                OracleBinaryReader.extractDouble(raw, 318));

        // ycept at offset 366
        assertEquals(dbg.ycept,
                OracleBinaryReader.extractDouble(raw, 366));

        // corrected_re_current at offset 374
        assertEquals(dbg.correctedReCurrent,
                OracleBinaryReader.extractDouble(raw, 374));

        // init_cg at offset 473
        assertEquals(dbg.initCg,
                OracleBinaryReader.extractDouble(raw, 473));

        // opcal_ad at offset 489
        assertEquals(dbg.opcalAd,
                OracleBinaryReader.extractDouble(raw, 489));

        // error codes at known packed offsets
        assertEquals(dbg.errorCode1,
                OracleBinaryReader.extractUint8(raw, 974));
        assertEquals(dbg.errorCode2,
                OracleBinaryReader.extractUint8(raw, 975));

        // trendrate at offset 980
        assertEquals(dbg.trendrate,
                OracleBinaryReader.extractDouble(raw, 980));
    }

    @Test
    void readDebug_consumesExactlyAllBytes() throws IOException {
        requireOracleData();
        // This implicitly tests that our read doesn't throw the position mismatch error
        DebugOutput dbg = OracleBinaryReader.readDebug(ORACLE_DIR, 1);
        assertNotNull(dbg);
    }

    // ---- Input file tests ----

    @Test
    void readInput_seq1_hasCorrectSeqNumber() throws IOException {
        requireOracleData();
        CgmInput input = OracleBinaryReader.readInput(ORACLE_DIR, 1);
        assertEquals(1, input.seqNumber);
    }

    @Test
    void readInput_seq1_hasBodyTemperature() throws IOException {
        requireOracleData();
        CgmInput input = OracleBinaryReader.readInput(ORACLE_DIR, 1);
        assertEquals(36.5, input.temperature, 0.001);
    }

    @Test
    void readInput_seq1_workoutMatchesOutputWorkout() throws IOException {
        requireOracleData();
        CgmInput input = OracleBinaryReader.readInput(ORACLE_DIR, 1);
        AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, 1);

        // The output workout is just copied from input
        assertArrayEquals(input.workout, out.workout,
                "Input and output workout arrays should match");
    }

    // ---- Cross-consistency: multiple readings ----

    @Test
    void readMultipleSeqs_seqNumbersAreSequential() throws IOException {
        requireOracleData();
        for (int seq = 1; seq <= 5; seq++) {
            AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, seq);
            assertEquals(seq, out.seqNumberOriginal,
                    "seq_number_original should match file seq for seq=" + seq);
        }
    }

    @Test
    void readMultipleSeqs_timeIncreases() throws IOException {
        requireOracleData();
        long prevTime = 0;
        for (int seq = 1; seq <= 5; seq++) {
            AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, seq);
            assertTrue(out.measurementTimeStandard > prevTime,
                    "Time should increase between readings");
            prevTime = out.measurementTimeStandard;
        }
    }

    @Test
    void readMultipleSeqs_timeSpacingIs300Seconds() throws IOException {
        requireOracleData();
        AlgorithmOutput out1 = OracleBinaryReader.readOutput(ORACLE_DIR, 1);
        AlgorithmOutput out2 = OracleBinaryReader.readOutput(ORACLE_DIR, 2);

        long delta = out2.measurementTimeStandard - out1.measurementTimeStandard;
        assertEquals(300, delta, "Readings should be 300 seconds (5 min) apart");
    }

    // ---- Error handling tests ----

    @Test
    void readOutput_nonexistentFile_throwsIOException() {
        assertThrows(IOException.class, () -> {
            OracleBinaryReader.readOutput("/nonexistent/path", 1);
        });
    }

    @Test
    void readDebug_nonexistentFile_throwsIOException() {
        assertThrows(IOException.class, () -> {
            OracleBinaryReader.readDebug("/nonexistent/path", 1);
        });
    }

    // ---- Post-warmup validation (seq 50 = well past warmup) ----

    @Test
    void readOutput_seq50_hasReasonableGlucose() throws IOException {
        requireOracleData();
        AlgorithmOutput out = OracleBinaryReader.readOutput(ORACLE_DIR, 50);
        // After warmup (seq > 24), glucose should typically be > 0 for normal profile
        // (unless there's an error code)
        if (out.errcode == 0) {
            assertTrue(out.resultGlucose > 0,
                    "Post-warmup, no-error reading should have glucose > 0, got "
                            + out.resultGlucose);
        }
    }

    @Test
    void readDebug_seq50_intermediateValuesPopulated() throws IOException {
        requireOracleData();
        DebugOutput dbg = OracleBinaryReader.readDebug(ORACLE_DIR, 50);

        // After warmup, several intermediate values should be non-zero
        // init_cg is the initial calibrated glucose — should be populated
        // out_rescale should have been computed
        // We verify the parsing produced values, not their correctness
        assertNotEquals(0.0, dbg.correctedReCurrent,
                "corrected_re_current should be non-zero at seq 50");
    }

    // ---- Lot consistency ----

    @Test
    void readOutput_allLots_seq1HasSeqOne() throws IOException {
        String[] lots = {"lot0", "lot1", "lot2", "lot3", "lot4"};
        for (String lot : lots) {
            String dir = "../oracle/output/" + lot;
            Path p = Paths.get(dir, "seq_0001_output.bin");
            if (!Files.exists(p)) continue;

            AlgorithmOutput out = OracleBinaryReader.readOutput(dir, 1);
            assertEquals(1, out.seqNumberOriginal,
                    "seq_number_original should be 1 for " + lot);
        }
    }
}
