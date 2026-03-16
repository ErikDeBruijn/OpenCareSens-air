package com.opencaresens.air;

import com.opencaresens.air.model.*;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Reads oracle binary verification files produced by the C oracle harness.
 *
 * Binary formats match the C structs in calibration.h:
 * - output_t: 155 bytes, packed (__attribute__((packed)) / #pragma pack(1))
 * - debug_t:  1579 bytes, packed
 * - cgm_input_t: 74 bytes, packed
 * - arguments_t: 117312 bytes, natural ARM alignment
 *
 * All files are little-endian (ARM).
 */
public class OracleBinaryReader {

    public static final int OUTPUT_SIZE = 155;
    public static final int DEBUG_SIZE = 1579;
    public static final int INPUT_SIZE = 74;
    public static final int ARGS_SIZE = 117312;

    // ---- File loading helpers ----

    private static ByteBuffer loadFile(Path path, int expectedSize) throws IOException {
        byte[] data = Files.readAllBytes(path);
        if (data.length != expectedSize) {
            throw new IOException("Expected " + expectedSize + " bytes but got "
                    + data.length + " for " + path);
        }
        ByteBuffer buf = ByteBuffer.wrap(data);
        buf.order(ByteOrder.LITTLE_ENDIAN);
        return buf;
    }

    // ---- Convenience: load by directory + seq number ----

    public static AlgorithmOutput readOutput(String oracleDir, int seq) throws IOException {
        Path path = Paths.get(oracleDir, String.format("seq_%04d_output.bin", seq));
        return readOutput(path);
    }

    public static DebugOutput readDebug(String oracleDir, int seq) throws IOException {
        Path path = Paths.get(oracleDir, String.format("seq_%04d_debug.bin", seq));
        return readDebug(path);
    }

    public static CgmInput readInput(String oracleDir, int seq) throws IOException {
        Path path = Paths.get(oracleDir, String.format("seq_%04d_input.bin", seq));
        return readInput(path);
    }

    // ---- output_t: 155 bytes, packed ----
    // Layout from calibration.h (packed):
    //   uint16_t seq_number_original;      // 0
    //   uint16_t seq_number_final;         // 2
    //   uint32_t measurement_time_standard;// 4
    //   uint16_t workout[30];              // 8  (60 bytes)
    //   double result_glucose;             // 68
    //   double trendrate;                  // 76
    //   uint8_t current_stage;             // 84
    //   uint8_t smooth_fixed_flag[6];      // 85
    //   uint16_t smooth_seq[6];            // 91 (12 bytes)
    //   double smooth_result_glucose[6];   // 103 (48 bytes)
    //   uint16_t errcode;                  // 151
    //   uint8_t cal_available_flag;        // 153
    //   uint8_t data_type;                 // 154
    //   TOTAL = 155

    public static AlgorithmOutput readOutput(Path path) throws IOException {
        ByteBuffer buf = loadFile(path, OUTPUT_SIZE);
        AlgorithmOutput out = new AlgorithmOutput();

        out.seqNumberOriginal = Short.toUnsignedInt(buf.getShort());        // 0
        out.seqNumberFinal = Short.toUnsignedInt(buf.getShort());           // 2
        out.measurementTimeStandard = Integer.toUnsignedLong(buf.getInt()); // 4
        for (int i = 0; i < 30; i++) {                                     // 8
            out.workout[i] = Short.toUnsignedInt(buf.getShort());
        }
        out.resultGlucose = buf.getDouble();                                // 68
        out.trendrate = buf.getDouble();                                    // 76
        out.currentStage = Byte.toUnsignedInt(buf.get());                   // 84
        for (int i = 0; i < 6; i++) {                                      // 85
            out.smoothFixedFlag[i] = Byte.toUnsignedInt(buf.get());
        }
        for (int i = 0; i < 6; i++) {                                      // 91
            out.smoothSeq[i] = Short.toUnsignedInt(buf.getShort());
        }
        for (int i = 0; i < 6; i++) {                                      // 103
            out.smoothResultGlucose[i] = buf.getDouble();
        }
        out.errcode = Short.toUnsignedInt(buf.getShort());                  // 151
        out.calAvailableFlag = Byte.toUnsignedInt(buf.get());               // 153
        out.dataType = Byte.toUnsignedInt(buf.get());                       // 154

        return out;
    }

    // ---- debug_t: 1579 bytes, packed ----
    // Field offsets verified against compare_oracle.c

    public static DebugOutput readDebug(Path path) throws IOException {
        ByteBuffer buf = loadFile(path, DEBUG_SIZE);
        DebugOutput d = new DebugOutput();

        d.seqNumberOriginal = Short.toUnsignedInt(buf.getShort());          // 0
        d.seqNumberFinal = Short.toUnsignedInt(buf.getShort());             // 2
        d.measurementTimeStandard = Integer.toUnsignedLong(buf.getInt());   // 4
        d.dataType = Byte.toUnsignedInt(buf.get());                         // 8
        d.stage = Byte.toUnsignedInt(buf.get());                            // 9
        d.temperature = buf.getDouble();                                    // 10
        for (int i = 0; i < 30; i++) {                                     // 18
            d.workout[i] = Short.toUnsignedInt(buf.getShort());
        }
        for (int i = 0; i < 30; i++) {                                     // 78
            d.tranInA[i] = buf.getDouble();
        }
        for (int i = 0; i < 5; i++) {                                      // 318
            d.tranInA1min[i] = buf.getDouble();
        }
        d.tranInA5min = buf.getDouble();                                    // 358
        d.ycept = buf.getDouble();                                          // 366
        d.correctedReCurrent = buf.getDouble();                             // 374
        d.diabetesMeanX = buf.getDouble();                                  // 382
        d.diabetesM2 = buf.getDouble();                                     // 390
        d.diabetesTAR = buf.getDouble();                                    // 398
        d.diabetesTBR = buf.getDouble();                                    // 406
        d.diabetesCV = buf.getDouble();                                     // 414
        d.levelDiabetes = Byte.toUnsignedInt(buf.get());                    // 422
        d.outIir = buf.getDouble();                                         // 423
        d.outDrift = buf.getDouble();                                       // 431
        d.currBaseline = buf.getDouble();                                   // 439
        d.initstableDiffDc = buf.getDouble();                               // 447
        d.initstableInitcnt = Short.toUnsignedInt(buf.getShort());          // 455
        d.tempLocalMean = buf.getDouble();                                  // 457
        d.slopeRatioTemp = buf.getDouble();                                 // 465
        d.initCg = buf.getDouble();                                         // 473
        d.outRescale = buf.getDouble();                                     // 481
        d.opcalAd = buf.getDouble();                                        // 489
        d.stateInitKalman = Byte.toUnsignedInt(buf.get());                  // 497

        // smooth_seq[6]: uint16_t at 498
        for (int i = 0; i < 6; i++) {
            d.smoothSeq[i] = Short.toUnsignedInt(buf.getShort());
        }
        // smooth_sig[6]: double at 510
        for (int i = 0; i < 6; i++) {
            d.smoothSig[i] = buf.getDouble();
        }
        // smooth_frep[6]: uint8_t at 558
        for (int i = 0; i < 6; i++) {
            d.smoothFrep[i] = Byte.toUnsignedInt(buf.get());
        }

        d.calState = Byte.toUnsignedInt(buf.get());                        // 564
        d.stateReturnOpcal = buf.get();                                     // 565 (int8_t = signed)
        d.validBgTime = Integer.toUnsignedLong(buf.getInt());               // 566
        d.validBgValue = buf.getDouble();                                   // 570
        d.callogGroup = Byte.toUnsignedInt(buf.get());                      // 578
        d.callogBgTime = Integer.toUnsignedLong(buf.getInt());              // 579
        d.callogBgSeq = buf.getDouble();                                    // 583
        d.callogBgUser = buf.getDouble();                                   // 591
        d.callogBgValid = buf.get();                                        // 599 (int8_t)
        d.callogBgCal = buf.getDouble();                                    // 600
        d.callogCgSeq1m = buf.getDouble();                                  // 608
        d.callogCgIdx = Short.toUnsignedInt(buf.getShort());                // 616
        d.callogCgCal = buf.getDouble();                                    // 618
        d.callogCslopePrev = buf.getDouble();                               // 626
        d.callogCyceptPrev = buf.getDouble();                               // 634
        d.callogCslopeNew = buf.getDouble();                                // 642
        d.callogCyceptNew = buf.getDouble();                                // 650
        d.callogInlierFlg = Byte.toUnsignedInt(buf.get());                  // 658

        // cal_slope[7]: double at 659
        for (int i = 0; i < 7; i++) {
            d.calSlope[i] = buf.getDouble();
        }
        // cal_ycept[7]: double at 715
        for (int i = 0; i < 7; i++) {
            d.calYcept[i] = buf.getDouble();
        }
        // cal_input[7]: double at 771
        for (int i = 0; i < 7; i++) {
            d.calInput[i] = buf.getDouble();
        }
        // cal_output[7]: double at 827
        for (int i = 0; i < 7; i++) {
            d.calOutput[i] = buf.getDouble();
        }

        d.initstableWeightUsercal = buf.getDouble();                        // 883
        d.initstableWeightNocal = buf.getDouble();                          // 891
        d.initstableFixusercal = buf.getDouble();                           // 899
        d.nOpcalState = buf.get();                                          // 907 (int8_t)
        d.initstableInitEndPoint = Short.toUnsignedInt(buf.getShort());     // 908

        // out_weight_sd[6]: double at 910
        for (int i = 0; i < 6; i++) {
            d.outWeightSd[i] = buf.getDouble();
        }
        d.outWeightAd = buf.getDouble();                                    // 958
        d.shiftoutAd = buf.getDouble();                                     // 966

        d.errorCode1 = Byte.toUnsignedInt(buf.get());                       // 974
        d.errorCode2 = Byte.toUnsignedInt(buf.get());                       // 975
        d.errorCode4 = Byte.toUnsignedInt(buf.get());                       // 976
        d.errorCode8 = Byte.toUnsignedInt(buf.get());                       // 977
        d.errorCode16 = Byte.toUnsignedInt(buf.get());                      // 978
        d.errorCode32 = Byte.toUnsignedInt(buf.get());                      // 979

        d.trendrate = buf.getDouble();                                       // 980
        d.calAvailableFlag = Byte.toUnsignedInt(buf.get());                  // 988

        // err1 fields
        d.err1ISseDMean = buf.getDouble();                                   // 989
        d.err1ThSseDMean1 = buf.getDouble();                                 // 997
        d.err1ThSseDMean2 = buf.getDouble();                                 // 1005
        d.err1ThSseDMean = buf.getDouble();                                  // 1013
        d.err1IsContactBad = Byte.toUnsignedInt(buf.get());                  // 1021
        d.err1CurrentAvgDiff = buf.getDouble();                              // 1022
        d.err1ThDiff1 = buf.getDouble();                                     // 1030
        d.err1ThDiff2 = buf.getDouble();                                     // 1038
        d.err1ThDiff = buf.getDouble();                                      // 1046
        d.err1Isfirst0 = Byte.toUnsignedInt(buf.get());                      // 1054
        d.err1Isfirst1 = Byte.toUnsignedInt(buf.get());                      // 1055
        d.err1Isfirst2 = Byte.toUnsignedInt(buf.get());                      // 1056
        d.err1N = Short.toUnsignedInt(buf.getShort());                       // 1057
        d.err1RandomNoiseTempBreak = Byte.toUnsignedInt(buf.get());          // 1059
        d.err1Result = Byte.toUnsignedInt(buf.get());                        // 1060

        d.err1LengthT2Max = Byte.toUnsignedInt(buf.get());                   // 1061
        d.err1LengthT3Max = Byte.toUnsignedInt(buf.get());                   // 1062
        d.err1LengthT1Trio = Byte.toUnsignedInt(buf.get());                  // 1063
        d.err1LengthT2Trio = Byte.toUnsignedInt(buf.get());                  // 1064
        d.err1LengthT3Trio = Byte.toUnsignedInt(buf.get());                  // 1065
        d.err1LengthT6Trio = Byte.toUnsignedInt(buf.get());                  // 1066
        d.err1LengthT7Trio = Byte.toUnsignedInt(buf.get());                  // 1067
        d.err1LengthT8Trio = Byte.toUnsignedInt(buf.get());                  // 1068
        d.err1LengthT9Trio = Byte.toUnsignedInt(buf.get());                  // 1069
        d.err1LengthT10Trio = Byte.toUnsignedInt(buf.get());                 // 1070

        d.err1ResultTD = Byte.toUnsignedInt(buf.get());                      // 1071
        for (int i = 0; i < 2; i++) {                                        // 1072
            d.err1ResultConditionTD[i] = Byte.toUnsignedInt(buf.get());
        }
        d.err1TDCount = Short.toUnsignedInt(buf.getShort());                 // 1074
        d.err1TDTemporaryBreakFlag = Byte.toUnsignedInt(buf.get());          // 1076
        for (int i = 0; i < 3; i++) {                                        // 1077
            d.err1TDTimeTrio[i] = Integer.toUnsignedLong(buf.getInt());
        }
        for (int i = 0; i < 3; i++) {                                        // 1089
            d.err1TDValueTrio[i] = buf.getDouble();
        }

        // err2 fields                                                        // 1113
        d.err2DelayRevisedValue = buf.getDouble();
        d.err2DelayRoc = buf.getDouble();
        d.err2DelaySlopeSharp = buf.getDouble();
        d.err2DelayRocCummax = buf.getDouble();
        d.err2DelayRocTrimmedMean = buf.getDouble();
        d.err2DelaySlopeCummax = buf.getDouble();
        d.err2DelaySlopeTrimmedMean = buf.getDouble();
        d.err2DelayGluCummax = buf.getDouble();
        d.err2DelayGluTrimmedMean = buf.getDouble();
        for (int i = 0; i < 3; i++) {
            d.err2DelayPreCondi[i] = Byte.toUnsignedInt(buf.get());
        }
        for (int i = 0; i < 3; i++) {
            d.err2DelayCondi[i] = Byte.toUnsignedInt(buf.get());
        }
        d.err2DelayFlag = Byte.toUnsignedInt(buf.get());
        d.err2Cummax = buf.getDouble();
        for (int i = 0; i < 2; i++) {
            d.err2CrtCurrent[i] = Byte.toUnsignedInt(buf.get());
        }
        for (int i = 0; i < 2; i++) {
            d.err2CrtGlu[i] = Byte.toUnsignedInt(buf.get());
        }
        d.err2CrtCv = buf.getDouble();
        for (int i = 0; i < 2; i++) {
            d.err2Condi[i] = Byte.toUnsignedInt(buf.get());
        }

        // err4 fields
        d.err4Min = buf.getDouble();
        d.err4Range = buf.getDouble();
        d.err4MinDiff = buf.getDouble();
        for (int i = 0; i < 5; i++) {
            d.err4Condi[i] = Byte.toUnsignedInt(buf.get());
        }
        for (int i = 0; i < 5; i++) {
            d.err4DelayCondi[i] = Byte.toUnsignedInt(buf.get());
        }
        d.err4DelayFlag = Byte.toUnsignedInt(buf.get());

        // err8 fields
        for (int i = 0; i < 2; i++) {
            d.err8Condi[i] = Byte.toUnsignedInt(buf.get());
        }

        // err16 fields
        d.err16CalConsDUsercalAfter = buf.getDouble();
        d.err16CalDayDTemp = buf.getDouble();
        d.err16CalDayDRef = buf.getDouble();
        d.err16CalDayNRef = buf.getDouble();
        d.err16CgmPlasma = buf.getDouble();
        d.err16CgmIsfSmooth = buf.getDouble();
        d.err16CgmIsfRocValue = buf.getDouble();
        d.err16CgmIsfRocSteady = buf.getDouble();
        d.err16CgmIsfRocMinTemp = buf.getDouble();
        d.err16CgmIsfRocMin = buf.getDouble();
        d.err16CgmIsfRocDiff = buf.getDouble();
        d.err16CgmIsfRocRatio = buf.getDouble();
        d.err16CgmIsfTrendMinValue = buf.getDouble();
        d.err16CgmIsfTrendMinSlope1 = buf.getDouble();
        d.err16CgmIsfTrendMinSlope2 = buf.getDouble();
        d.err16CgmIsfTrendMinRsq1 = buf.getDouble();
        d.err16CgmIsfTrendMinRsq2 = buf.getDouble();
        d.err16CgmIsfTrendMinDiff = buf.getDouble();
        d.err16CgmIsfTrendMinMaxTemp = buf.getDouble();
        d.err16CgmIsfTrendMinMax = buf.getDouble();
        d.err16CgmIsfTrendMinRatio = buf.getDouble();
        d.err16CgmIsfTrendModeValue = buf.getDouble();
        d.err16CgmIsfTrendModeProportion = buf.getDouble();
        d.err16CgmIsfTrendModeDiff = buf.getDouble();
        d.err16CgmIsfTrendModeMaxTemp = buf.getDouble();
        d.err16CgmIsfTrendModeMax = buf.getDouble();
        d.err16CgmIsfTrendModeRatio = buf.getDouble();
        d.err16CgmIsfTrendMeanValue = buf.getDouble();
        d.err16CgmIsfTrendMeanSlope = buf.getDouble();
        d.err16CgmIsfTrendMeanRsq = buf.getDouble();
        d.err16CgmIsfTrendMeanDiff = buf.getDouble();
        d.err16CgmIsfTrendMeanMaxTemp = buf.getDouble();
        d.err16CgmIsfTrendMeanMax = buf.getDouble();
        d.err16CgmIsfTrendMeanRatio = buf.getDouble();
        d.err16CgmIsfTrendMeanDiffEarly = buf.getDouble();
        d.err16CgmIsfTrendMeanMaxTempEarly = buf.getDouble();
        d.err16CgmIsfTrendMeanMaxEarly = buf.getDouble();
        d.err16CgmIsfTrendMeanRatioEarly = buf.getDouble();
        for (int i = 0; i < 7; i++) {
            d.err16Condi[i] = Byte.toUnsignedInt(buf.get());
        }

        // err128 fields
        d.err128Flag = Byte.toUnsignedInt(buf.get());
        d.err128RevisedValue = buf.getDouble();
        d.err128Normal = buf.getDouble();

        // Verify we consumed exactly DEBUG_SIZE bytes
        if (buf.position() != DEBUG_SIZE) {
            throw new IOException("Debug binary read position mismatch: expected "
                    + DEBUG_SIZE + " but at " + buf.position());
        }

        return d;
    }

    // ---- cgm_input_t: 74 bytes, packed ----
    // Layout:
    //   uint16_t seq_number;               // 0
    //   uint32_t measurement_time_standard; // 2
    //   uint16_t workout[30];              // 6 (60 bytes)
    //   double temperature;                // 66
    //   TOTAL = 74

    public static CgmInput readInput(Path path) throws IOException {
        ByteBuffer buf = loadFile(path, INPUT_SIZE);
        CgmInput input = new CgmInput();

        input.seqNumber = Short.toUnsignedInt(buf.getShort());              // 0
        input.measurementTimeStandard = Integer.toUnsignedLong(buf.getInt()); // 2
        for (int i = 0; i < 30; i++) {                                      // 6
            input.workout[i] = Short.toUnsignedInt(buf.getShort());
        }
        input.temperature = buf.getDouble();                                 // 66

        return input;
    }

    // ---- Raw byte access for direct offset-based comparison ----

    /**
     * Returns the raw bytes of an output binary file for direct field comparison.
     * Useful when you need to compare at specific byte offsets (like compare_oracle.c does).
     */
    public static byte[] readOutputRaw(String oracleDir, int seq) throws IOException {
        Path path = Paths.get(oracleDir, String.format("seq_%04d_output.bin", seq));
        byte[] data = Files.readAllBytes(path);
        if (data.length != OUTPUT_SIZE) {
            throw new IOException("Expected " + OUTPUT_SIZE + " bytes but got " + data.length);
        }
        return data;
    }

    /**
     * Returns the raw bytes of a debug binary file for direct field comparison.
     */
    public static byte[] readDebugRaw(String oracleDir, int seq) throws IOException {
        Path path = Paths.get(oracleDir, String.format("seq_%04d_debug.bin", seq));
        byte[] data = Files.readAllBytes(path);
        if (data.length != DEBUG_SIZE) {
            throw new IOException("Expected " + DEBUG_SIZE + " bytes but got " + data.length);
        }
        return data;
    }

    /**
     * Extracts a double from raw oracle bytes at the given offset.
     */
    public static double extractDouble(byte[] raw, int offset) {
        ByteBuffer buf = ByteBuffer.wrap(raw, offset, 8);
        buf.order(ByteOrder.LITTLE_ENDIAN);
        return buf.getDouble();
    }

    /**
     * Extracts a uint16 from raw oracle bytes at the given offset.
     */
    public static int extractUint16(byte[] raw, int offset) {
        ByteBuffer buf = ByteBuffer.wrap(raw, offset, 2);
        buf.order(ByteOrder.LITTLE_ENDIAN);
        return Short.toUnsignedInt(buf.getShort());
    }

    /**
     * Extracts a uint32 from raw oracle bytes at the given offset.
     */
    public static long extractUint32(byte[] raw, int offset) {
        ByteBuffer buf = ByteBuffer.wrap(raw, offset, 4);
        buf.order(ByteOrder.LITTLE_ENDIAN);
        return Integer.toUnsignedLong(buf.getInt());
    }

    /**
     * Extracts a uint8 from raw oracle bytes at the given offset.
     */
    public static int extractUint8(byte[] raw, int offset) {
        return Byte.toUnsignedInt(raw[offset]);
    }

    /**
     * Extracts a int8 from raw oracle bytes at the given offset.
     */
    public static int extractInt8(byte[] raw, int offset) {
        return raw[offset];
    }
}
