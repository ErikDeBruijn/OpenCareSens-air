package com.opencaresens.air;

import com.opencaresens.air.model.AlgorithmOutput;
import com.opencaresens.air.model.AlgorithmState;
import com.opencaresens.air.model.CalibrationList;
import com.opencaresens.air.model.CgmInput;
import com.opencaresens.air.model.DebugOutput;
import com.opencaresens.air.model.DeviceInfo;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Full oracle verification test: runs the entire Java calibration pipeline against
 * 2000 oracle readings (400 per lot x 5 lots) and compares every field.
 *
 * MEDICAL SAFETY: This is the primary safety guarantee for the Java port.
 * The oracle data represents ground truth from the original proprietary library.
 * Every glucose value must match at machine epsilon precision.
 *
 * Oracle data is produced by oracle_harness.c running the real libCALCULATION.so
 * on ARM, dumping binary input/output/debug for each reading.
 */
class OracleVerificationTest {

    // Tolerance: doubles match if abs_err < 1e-12 OR rel_err < 1e-10
    private static final double ABS_TOL = 1e-12;
    private static final double REL_TOL = 1e-10;

    private static final int READINGS_PER_LOT = 400;

    // Oracle data root (relative to project root)
    private static final String ORACLE_ROOT = "../oracle/output";

    // Lot configurations: eapp value per lot (matches run_oracle.sh LOT_DEFS)
    private static final float[] LOT_EAPP = {
        0.10067f,  // lot0: standard eapp, normal glucose
        0.15f,     // lot1: high eapp, normal glucose
        0.05f,     // lot2: low eapp, normal glucose
        0.10067f,  // lot3: standard eapp, hypo profile
        0.10067f,  // lot4: standard eapp, hyper profile
    };

    private static String oracleBase;

    @BeforeAll
    static void findOracleData() {
        // Try relative path from java/ directory, then absolute
        Path rel = Paths.get(ORACLE_ROOT);
        Path abs = Paths.get("/Users/erik/github.com/erikdebruijn/OpenCareSens-air/oracle/output");
        if (Files.isDirectory(rel)) {
            oracleBase = rel.toString();
        } else if (Files.isDirectory(abs)) {
            oracleBase = abs.toString();
        } else {
            oracleBase = null;
        }
    }

    // ======================================================================
    // DeviceInfo setup — must match oracle_harness.c init_default_device_info()
    // ======================================================================

    private static DeviceInfo createDefaultDeviceInfo(float eapp) {
        DeviceInfo di = new DeviceInfo();
        di.sensorVersion = 1;
        di.ycept = 1.0f;
        di.slope100 = 3.5226f;
        di.slope = 1.0f;
        di.r2 = 0.0f;
        di.t90 = 0.0f;
        di.slopeRatio = 1.0f;
        di.stabilizationInterval = 7200;
        di.cgmDataInterval = 300;
        di.bleAdvInterval = 300;
        di.bleAdvDuration = 10;
        di.age = 18;
        di.allowedList = 1;
        di.maximumValue = 500.0f;
        di.minimumValue = 40.0f;
        di.cLibraryVersion = 3;
        di.parameterVersion = 3;
        di.basicWarmup = 24;
        di.basicYcept = 0.0f;
        di.contactWinLen = 30;
        di.contactCond1X10 = 5;
        di.contactCond2X10 = 1;
        di.contactCond3X10 = 2;
        di.fillFlag = 1;
        di.driftCorrectionOn = 0;
        di.driftCoefficient[0][2] = 1.0f;
        di.driftCoefficient[1][2] = 1.0f;
        di.driftCoefficient[2][2] = 1.0f;
        di.iRefX100 = 100;
        di.coefLength = 1;
        di.divPoint = 1;
        di.iirFlag = 1;
        di.iirStDX10 = 90;
        di.correct1Flag = 1;
        di.correct1Coeff[2] = 1.0f;
        di.kalmanT90 = 10;
        di.kalmanDeltaT = 5;
        di.kalmanQX100[0][0] = -115;
        di.kalmanQX100[1][1] = 1440;
        di.kalmanQX100[2][2] = 10;
        di.kalmanRX100 = 200;
        di.bgCalRatio = 1.0f;
        di.bgCalTimeFactor = 0;
        di.slopeFactorX10 = 20;
        di.slopeInterUpX10 = 10;
        di.slopeInterDownX10 = -20;
        di.slopeMultiVX10 = 20;
        di.slopeIirThr = 20;
        di.slopeNegInterThr1X10 = 5;
        di.slopeNegInterThr2X10 = 8;
        di.slopeBgCalThrDown = 70;
        di.slopeBgCalThrUp = 100;
        di.slopeMaxSlopeX100 = 76;
        di.slopeMinSlopeX100 = 40;
        di.slopeDcalRate = 0.6f;
        di.slopeDcalTargetLength = 108;
        di.slopeDcalWindow = 888;
        di.slopeDcalFactoryCalUse = 0;
        di.shiftMSel = 1;
        di.shiftCoeff[2] = 1.0f;
        di.shiftM2X100[0] = 17;
        di.shiftM2X100[1] = 2000;
        di.shiftM2X100[2] = 111;
        di.wSgX100[0] = 80;
        di.wSgX100[1] = 130;
        di.wSgX100[2] = 90;
        di.wSgX100[3] = 80;
        di.wSgX100[4] = 110;
        di.wSgX100[5] = 90;
        di.wSgX100[6] = 80;
        di.calTrendRate = 3;
        di.calNoise = 3.0f;
        di.errcodeVersion = 2;
        di.err1Seq[0] = 23; di.err1Seq[1] = 47; di.err1Seq[2] = 11;
        di.err1ContactBad = 0.5f;
        di.err1ThDiff = 2.0f;
        di.err1ThSseDmean[0] = 0.05f;
        di.err1ThSseDmean[1] = 0.1f;
        di.err1ThSseDmean[2] = 0.5f;
        di.err1ThN1[0] = 43; di.err1ThN1[1] = 40;
        di.err1ThN1[2] = 37; di.err1ThN1[3] = 34;
        di.err1ThN2[0][0] = 2; di.err1ThN2[0][1] = 6;
        di.err1ThN2[1][0] = 4; di.err1ThN2[1][1] = 8;
        di.err1NConsecutive = 6;
        di.err1ISseDmeanNow[0] = 3.0f;
        di.err1ISseDmeanNow[1] = 0.001f;
        di.err1CountSseDmean = 12;
        di.err1NLast = 288;
        di.err1Multi[0] = 10; di.err1Multi[1] = 10;
        di.err1CurrentAvgDiff = 1.0E-15f;
        di.err2StartSeq = 289;
        di.err2Seq[0] = 20; di.err2Seq[1] = 11; di.err2Seq[2] = 6;
        di.err2Glu = 800.0f;
        di.err2Cv[0] = 10.0f; di.err2Cv[1] = 0.05f; di.err2Cv[2] = 10.0f;
        di.err2Cummax = 2;
        di.err2Multi = 10;
        di.err2Ycept = 2.0f;
        di.err2Alpha = 2.0f;
        di.err345Seq1[0] = 3; di.err345Seq1[1] = 576;
        di.err345Seq2 = 5;
        di.err345Seq3[0] = 5; di.err345Seq3[1] = 864; di.err345Seq3[2] = 24;
        di.err345Seq4[0] = 11; di.err345Seq4[1] = 23; di.err345Seq4[2] = 12;
        di.err345Seq4[3] = 288; di.err345Seq4[4] = 24;
        di.err345Seq5[0] = 11; di.err345Seq5[1] = 36; di.err345Seq5[2] = 288;
        di.err345Raw[0] = 0.1f; di.err345Raw[1] = 0.5f;
        di.err345Raw[2] = 0.2f; di.err345Raw[3] = 0.7f;
        di.err345Filtered[0] = 0.2f; di.err345Filtered[1] = 1.0f;
        di.err345Min[0] = 0.5f; di.err345Min[1] = 0.3f;
        di.err345Range = -1.0f;
        di.err345NRange = 2;
        di.err345Md = 0.0f;
        di.err345NMd = 6;
        di.err6CalNPts = 3;
        di.err6CalBasicPrct = 0.3f;
        di.err6CalBasicSeq = 1440;
        di.err6CalOriginSlope = 30.0f;
        di.err6CalInVitro[0] = 0.0f; di.err6CalInVitro[1] = 2.0f;
        di.err6CgmRpd = 0.55f;
        di.err6CgmSlp = -0.2f;
        di.err6CgmLow3dSeq = 24;
        di.err6CgmLow3dP = 0.32f;
        di.err6CgmLow1dSeq = 24;
        di.err6CgmLow1dP = 0.3f;
        di.err6CgmPrct[0] = 30; di.err6CgmPrct[1] = 50; di.err6CgmPrct[2] = 70;
        di.err6CgmDay[0] = 1; di.err6CgmDay[1] = 3;
        di.err6CgmBleBad[0] = 12; di.err6CgmBleBad[1] = 96;
        di.err6CgmPoly2 = 0.7f;
        di.err32Dt[0] = 23; di.err32Dt[1] = 60;
        di.err32N[0] = 3; di.err32N[1] = 2;
        di.vref = 1.49594f;
        di.eapp = eapp;
        di.sensorStartTime = 1709726400L; // 2024-03-06 12:00:00 UTC
        return di;
    }

    // ======================================================================
    // Field comparison infrastructure
    // ======================================================================

    /** Tracks match/mismatch stats for a single named field across all readings. */
    static class FieldStats {
        final String name;
        int total;
        int match;
        int mismatch;
        double maxAbsErr;
        double maxRelErr;
        int firstMismatchSeq;
        String firstMismatchDetail;

        FieldStats(String name) {
            this.name = name;
        }

        void recordMatch() {
            total++;
            match++;
        }

        void recordMismatch(int seq, String detail) {
            total++;
            mismatch++;
            if (firstMismatchSeq == 0) {
                firstMismatchSeq = seq;
                firstMismatchDetail = detail;
            }
        }

        void recordDoubleMismatch(int seq, double ours, double oracle,
                                   double absErr, double relErr) {
            total++;
            mismatch++;
            if (absErr > maxAbsErr) maxAbsErr = absErr;
            if (relErr > maxRelErr) maxRelErr = relErr;
            if (firstMismatchSeq == 0) {
                firstMismatchSeq = seq;
                firstMismatchDetail = String.format(
                    "ours=%.10g oracle=%.10g (abs=%.2e rel=%.2e)",
                    ours, oracle, absErr, relErr);
            }
        }

        void recordDoubleMatch(double absErr, double relErr) {
            total++;
            match++;
            if (absErr > maxAbsErr) maxAbsErr = absErr;
            if (relErr > maxRelErr) maxRelErr = relErr;
        }
    }

    /** Compare a double value with oracle tolerance. */
    static boolean compareDouble(FieldStats fs, int seq, double ours, double oracle) {
        if (Double.isNaN(ours) && Double.isNaN(oracle)) {
            fs.recordMatch();
            return true;
        }
        if (Double.isNaN(ours) || Double.isNaN(oracle)) {
            fs.recordMismatch(seq, String.format("ours=%g oracle=%g", ours, oracle));
            return false;
        }
        if (ours == oracle) {
            fs.recordMatch();
            return true;
        }
        double absErr = Math.abs(ours - oracle);
        double relErr = (Math.abs(oracle) > 1e-10)
            ? absErr / Math.abs(oracle) : absErr;
        if (absErr < ABS_TOL || relErr < REL_TOL) {
            fs.recordDoubleMatch(absErr, relErr);
            return true;
        }
        fs.recordDoubleMismatch(seq, ours, oracle, absErr, relErr);
        return false;
    }

    /** Compare an integer value with oracle (bit-exact). */
    static boolean compareInt(FieldStats fs, int seq, long ours, long oracle) {
        if (ours == oracle) {
            fs.recordMatch();
            return true;
        }
        fs.recordMismatch(seq, String.format("ours=%d oracle=%d", ours, oracle));
        return false;
    }

    // ======================================================================
    // Per-lot verification
    // ======================================================================

    private LotResult runLotVerification(int lotNum) throws IOException {
        String lotDir = oracleBase + "/lot" + lotNum;
        Assumptions.assumeTrue(Files.isDirectory(Paths.get(lotDir)),
            "Oracle data not found for lot" + lotNum + " at " + lotDir);

        DeviceInfo devInfo = createDefaultDeviceInfo(LOT_EAPP[lotNum]);
        AlgorithmState algoArgs = new AlgorithmState();
        CalibrationList calInput = new CalibrationList();

        // --- Output field stats ---
        FieldStats oSeqOriginal = new FieldStats("output.seq_number_original");
        FieldStats oSeqFinal = new FieldStats("output.seq_number_final");
        FieldStats oMeasTime = new FieldStats("output.measurement_time_standard");
        FieldStats oResultGlucose = new FieldStats("output.result_glucose");
        FieldStats oTrendrate = new FieldStats("output.trendrate");
        FieldStats oCurrentStage = new FieldStats("output.current_stage");
        FieldStats oErrcode = new FieldStats("output.errcode");
        FieldStats oCalAvailable = new FieldStats("output.cal_available_flag");
        FieldStats oDataType = new FieldStats("output.data_type");
        FieldStats[] oSmoothGlu = new FieldStats[6];
        for (int i = 0; i < 6; i++) {
            oSmoothGlu[i] = new FieldStats("output.smooth_result_glucose[" + i + "]");
        }

        // --- Debug field stats ---
        FieldStats dSeqOriginal = new FieldStats("debug.seq_number_original");
        FieldStats dSeqFinal = new FieldStats("debug.seq_number_final");
        FieldStats dMeasTime = new FieldStats("debug.measurement_time_standard");
        FieldStats dDataType = new FieldStats("debug.data_type");
        FieldStats dStage = new FieldStats("debug.stage");
        FieldStats dTemperature = new FieldStats("debug.temperature");
        FieldStats[] dTranInA1min = new FieldStats[5];
        for (int i = 0; i < 5; i++) {
            dTranInA1min[i] = new FieldStats("debug.tran_inA_1min[" + i + "]");
        }
        FieldStats dTranInA5min = new FieldStats("debug.tran_inA_5min");
        FieldStats dYcept = new FieldStats("debug.ycept");
        FieldStats dCorrectedReCurrent = new FieldStats("debug.corrected_re_current");
        FieldStats dDiabetesMeanX = new FieldStats("debug.diabetes_mean_x");
        FieldStats dDiabetesM2 = new FieldStats("debug.diabetes_M2");
        FieldStats dDiabetesTAR = new FieldStats("debug.diabetes_TAR");
        FieldStats dDiabetesTBR = new FieldStats("debug.diabetes_TBR");
        FieldStats dDiabetesCV = new FieldStats("debug.diabetes_CV");
        FieldStats dLevelDiabetes = new FieldStats("debug.level_diabetes");
        FieldStats dOutIir = new FieldStats("debug.out_iir");
        FieldStats dOutDrift = new FieldStats("debug.out_drift");
        FieldStats dCurrBaseline = new FieldStats("debug.curr_baseline");
        FieldStats dInitstableDiffDc = new FieldStats("debug.initstable_diff_dc");
        FieldStats dInitstableInitcnt = new FieldStats("debug.initstable_initcnt");
        FieldStats dTempLocalMean = new FieldStats("debug.temp_local_mean");
        FieldStats dSlopeRatioTemp = new FieldStats("debug.slope_ratio_temp");
        FieldStats dInitCg = new FieldStats("debug.init_cg");
        FieldStats dOutRescale = new FieldStats("debug.out_rescale");
        FieldStats dOpcalAd = new FieldStats("debug.opcal_ad");
        FieldStats dStateInitKalman = new FieldStats("debug.state_init_kalman");
        FieldStats dCalState = new FieldStats("debug.cal_state");
        FieldStats dStateReturnOpcal = new FieldStats("debug.state_return_opcal");
        FieldStats dValidBgTime = new FieldStats("debug.valid_bg_time");
        FieldStats dValidBgValue = new FieldStats("debug.valid_bg_value");
        FieldStats dCallogGroup = new FieldStats("debug.callog_group");
        FieldStats dCallogBgTime = new FieldStats("debug.callog_bgTime");
        FieldStats dCallogBgSeq = new FieldStats("debug.callog_bgSeq");
        FieldStats dCallogBgUser = new FieldStats("debug.callog_bgUser");
        FieldStats dCallogBgValid = new FieldStats("debug.callog_bgValid");
        FieldStats dCallogBgCal = new FieldStats("debug.callog_bgCal");
        FieldStats dCallogCgSeq1m = new FieldStats("debug.callog_cgSeq1m");
        FieldStats dCallogCgIdx = new FieldStats("debug.callog_cgIdx");
        FieldStats dCallogCgCal = new FieldStats("debug.callog_cgCal");
        FieldStats dCallogCslopePrev = new FieldStats("debug.callog_CslopePrev");
        FieldStats dCallogCyceptPrev = new FieldStats("debug.callog_CyceptPrev");
        FieldStats dCallogCslopeNew = new FieldStats("debug.callog_CslopeNew");
        FieldStats dCallogCyceptNew = new FieldStats("debug.callog_CyceptNew");
        FieldStats dCallogInlierFlg = new FieldStats("debug.callog_inlierFlg");
        FieldStats dInitstableWeightUsercal = new FieldStats("debug.initstable_weight_usercal");
        FieldStats dInitstableWeightNocal = new FieldStats("debug.initstable_weight_nocal");
        FieldStats dInitstableFixusercal = new FieldStats("debug.initstable_fixusercal");
        FieldStats dNOpcalState = new FieldStats("debug.nOpcalState");
        FieldStats dInitstableInitEndPoint = new FieldStats("debug.initstable_init_end_point");
        FieldStats dOutWeightAd = new FieldStats("debug.out_weight_ad");
        FieldStats dShiftoutAd = new FieldStats("debug.shiftout_ad");
        FieldStats dErrorCode1 = new FieldStats("debug.error_code1");
        FieldStats dErrorCode2 = new FieldStats("debug.error_code2");
        FieldStats dErrorCode4 = new FieldStats("debug.error_code4");
        FieldStats dErrorCode8 = new FieldStats("debug.error_code8");
        FieldStats dErrorCode16 = new FieldStats("debug.error_code16");
        FieldStats dErrorCode32 = new FieldStats("debug.error_code32");
        FieldStats dTrendrate = new FieldStats("debug.trendrate");
        FieldStats dCalAvailableFlag = new FieldStats("debug.cal_available_flag");
        // err1 fields
        FieldStats dErr1ISseDMean = new FieldStats("debug.err1_i_sse_d_mean");
        FieldStats dErr1ThSseDMean1 = new FieldStats("debug.err1_th_sse_d_mean1");
        FieldStats dErr1ThSseDMean2 = new FieldStats("debug.err1_th_sse_d_mean2");
        FieldStats dErr1ThSseDMean = new FieldStats("debug.err1_th_sse_d_mean");
        FieldStats dErr1IsContactBad = new FieldStats("debug.err1_is_contact_bad");
        FieldStats dErr1CurrentAvgDiff = new FieldStats("debug.err1_current_avg_diff");
        FieldStats dErr1ThDiff1 = new FieldStats("debug.err1_th_diff1");
        FieldStats dErr1ThDiff2 = new FieldStats("debug.err1_th_diff2");
        FieldStats dErr1ThDiff = new FieldStats("debug.err1_th_diff");
        FieldStats dErr1Isfirst0 = new FieldStats("debug.err1_isfirst0");
        FieldStats dErr1Isfirst1 = new FieldStats("debug.err1_isfirst1");
        FieldStats dErr1Isfirst2 = new FieldStats("debug.err1_isfirst2");
        FieldStats dErr1N = new FieldStats("debug.err1_n");
        FieldStats dErr1RandomNoiseTempBreak = new FieldStats("debug.err1_random_noise_temp_break");
        FieldStats dErr1Result = new FieldStats("debug.err1_result");
        FieldStats dErr1ResultTD = new FieldStats("debug.err1_result_TD");
        // err2 fields
        FieldStats dErr2DelayRevisedValue = new FieldStats("debug.err2_delay_revised_value");
        FieldStats dErr2DelayRoc = new FieldStats("debug.err2_delay_roc");
        FieldStats dErr2DelaySlopeSharp = new FieldStats("debug.err2_delay_slope_sharp");
        FieldStats dErr2DelayRocCummax = new FieldStats("debug.err2_delay_roc_cummax");
        FieldStats dErr2DelaySlopeCummax = new FieldStats("debug.err2_delay_slope_cummax");
        FieldStats dErr2DelayGluCummax = new FieldStats("debug.err2_delay_glu_cummax");
        FieldStats dErr2DelayFlag = new FieldStats("debug.err2_delay_flag");
        FieldStats dErr2Cummax = new FieldStats("debug.err2_cummax");
        FieldStats[] dErr2CrtCurrent = new FieldStats[2];
        for (int i = 0; i < 2; i++) dErr2CrtCurrent[i] = new FieldStats("debug.err2_crt_current[" + i + "]");
        FieldStats[] dErr2CrtGlu = new FieldStats[2];
        for (int i = 0; i < 2; i++) dErr2CrtGlu[i] = new FieldStats("debug.err2_crt_glu[" + i + "]");
        FieldStats[] dErr2Condi = new FieldStats[2];
        for (int i = 0; i < 2; i++) dErr2Condi[i] = new FieldStats("debug.err2_condi[" + i + "]");
        // err4 fields
        FieldStats dErr4Min = new FieldStats("debug.err4_min");
        FieldStats dErr4Range = new FieldStats("debug.err4_range");
        FieldStats dErr4MinDiff = new FieldStats("debug.err4_min_diff");
        // err16 fields
        FieldStats dErr16CgmPlasma = new FieldStats("debug.err16_CGM_plasma");
        FieldStats dErr16CgmIsfSmooth = new FieldStats("debug.err16_CGM_ISF_smooth");
        // err128 fields
        FieldStats dErr128Flag = new FieldStats("debug.err128_flag");
        FieldStats dErr128RevisedValue = new FieldStats("debug.err128_revised_value");
        FieldStats dErr128Normal = new FieldStats("debug.err128_normal");
        // tran_inA array
        FieldStats dTranInA = new FieldStats("debug.tran_inA[30]");

        // Collect all stats for reporting
        List<FieldStats> allOutputStats = new ArrayList<>();
        allOutputStats.add(oSeqOriginal);
        allOutputStats.add(oSeqFinal);
        allOutputStats.add(oMeasTime);
        allOutputStats.add(oResultGlucose);
        allOutputStats.add(oTrendrate);
        allOutputStats.add(oCurrentStage);
        allOutputStats.add(oErrcode);
        allOutputStats.add(oCalAvailable);
        allOutputStats.add(oDataType);
        for (FieldStats s : oSmoothGlu) allOutputStats.add(s);

        List<FieldStats> allDebugStats = new ArrayList<>();
        allDebugStats.add(dSeqOriginal);
        allDebugStats.add(dSeqFinal);
        allDebugStats.add(dMeasTime);
        allDebugStats.add(dDataType);
        allDebugStats.add(dStage);
        allDebugStats.add(dTemperature);
        for (FieldStats s : dTranInA1min) allDebugStats.add(s);
        allDebugStats.add(dTranInA5min);
        allDebugStats.add(dYcept);
        allDebugStats.add(dCorrectedReCurrent);
        allDebugStats.add(dDiabetesMeanX);
        allDebugStats.add(dDiabetesM2);
        allDebugStats.add(dDiabetesTAR);
        allDebugStats.add(dDiabetesTBR);
        allDebugStats.add(dDiabetesCV);
        allDebugStats.add(dLevelDiabetes);
        allDebugStats.add(dOutIir);
        allDebugStats.add(dOutDrift);
        allDebugStats.add(dCurrBaseline);
        allDebugStats.add(dInitstableDiffDc);
        allDebugStats.add(dInitstableInitcnt);
        allDebugStats.add(dTempLocalMean);
        allDebugStats.add(dSlopeRatioTemp);
        allDebugStats.add(dInitCg);
        allDebugStats.add(dOutRescale);
        allDebugStats.add(dOpcalAd);
        allDebugStats.add(dStateInitKalman);
        allDebugStats.add(dCalState);
        allDebugStats.add(dStateReturnOpcal);
        allDebugStats.add(dValidBgTime);
        allDebugStats.add(dValidBgValue);
        allDebugStats.add(dCallogGroup);
        allDebugStats.add(dCallogBgTime);
        allDebugStats.add(dCallogBgSeq);
        allDebugStats.add(dCallogBgUser);
        allDebugStats.add(dCallogBgValid);
        allDebugStats.add(dCallogBgCal);
        allDebugStats.add(dCallogCgSeq1m);
        allDebugStats.add(dCallogCgIdx);
        allDebugStats.add(dCallogCgCal);
        allDebugStats.add(dCallogCslopePrev);
        allDebugStats.add(dCallogCyceptPrev);
        allDebugStats.add(dCallogCslopeNew);
        allDebugStats.add(dCallogCyceptNew);
        allDebugStats.add(dCallogInlierFlg);
        allDebugStats.add(dInitstableWeightUsercal);
        allDebugStats.add(dInitstableWeightNocal);
        allDebugStats.add(dInitstableFixusercal);
        allDebugStats.add(dNOpcalState);
        allDebugStats.add(dInitstableInitEndPoint);
        allDebugStats.add(dOutWeightAd);
        allDebugStats.add(dShiftoutAd);
        allDebugStats.add(dErrorCode1);
        allDebugStats.add(dErrorCode2);
        allDebugStats.add(dErrorCode4);
        allDebugStats.add(dErrorCode8);
        allDebugStats.add(dErrorCode16);
        allDebugStats.add(dErrorCode32);
        allDebugStats.add(dTrendrate);
        allDebugStats.add(dCalAvailableFlag);
        allDebugStats.add(dErr1ISseDMean);
        allDebugStats.add(dErr1ThSseDMean1);
        allDebugStats.add(dErr1ThSseDMean2);
        allDebugStats.add(dErr1ThSseDMean);
        allDebugStats.add(dErr1IsContactBad);
        allDebugStats.add(dErr1CurrentAvgDiff);
        allDebugStats.add(dErr1ThDiff1);
        allDebugStats.add(dErr1ThDiff2);
        allDebugStats.add(dErr1ThDiff);
        allDebugStats.add(dErr1Isfirst0);
        allDebugStats.add(dErr1Isfirst1);
        allDebugStats.add(dErr1Isfirst2);
        allDebugStats.add(dErr1N);
        allDebugStats.add(dErr1RandomNoiseTempBreak);
        allDebugStats.add(dErr1Result);
        allDebugStats.add(dErr1ResultTD);
        allDebugStats.add(dErr2DelayRevisedValue);
        allDebugStats.add(dErr2DelayRoc);
        allDebugStats.add(dErr2DelaySlopeSharp);
        allDebugStats.add(dErr2DelayRocCummax);
        allDebugStats.add(dErr2DelaySlopeCummax);
        allDebugStats.add(dErr2DelayGluCummax);
        allDebugStats.add(dErr2DelayFlag);
        allDebugStats.add(dErr2Cummax);
        for (FieldStats s : dErr2CrtCurrent) allDebugStats.add(s);
        for (FieldStats s : dErr2CrtGlu) allDebugStats.add(s);
        for (FieldStats s : dErr2Condi) allDebugStats.add(s);
        allDebugStats.add(dErr4Min);
        allDebugStats.add(dErr4Range);
        allDebugStats.add(dErr4MinDiff);
        allDebugStats.add(dErr16CgmPlasma);
        allDebugStats.add(dErr16CgmIsfSmooth);
        allDebugStats.add(dErr128Flag);
        allDebugStats.add(dErr128RevisedValue);
        allDebugStats.add(dErr128Normal);
        allDebugStats.add(dTranInA);

        int readingsCompared = 0;
        int glucoseMismatches = 0;

        for (int seq = 1; seq <= READINGS_PER_LOT; seq++) {
            // --- Load oracle input ---
            CgmInput cgmInput;
            try {
                cgmInput = OracleBinaryReader.readInput(lotDir, seq);
            } catch (IOException e) {
                if (seq == 1) throw e;
                break; // no more readings
            }

            // --- Load oracle output and debug for comparison ---
            AlgorithmOutput oracleOutput;
            DebugOutput oracleDebug;
            try {
                oracleOutput = OracleBinaryReader.readOutput(lotDir, seq);
                oracleDebug = OracleBinaryReader.readDebug(lotDir, seq);
            } catch (IOException e) {
                break;
            }

            // --- Run OUR algorithm ---
            AlgorithmOutput ourOutput = new AlgorithmOutput();
            DebugOutput ourDebug = new DebugOutput();

            CalibrationAlgorithm.process(devInfo, cgmInput, calInput,
                                          algoArgs, ourOutput, ourDebug);

            // === Compare OUTPUT fields ===
            compareInt(oSeqOriginal, seq, ourOutput.seqNumberOriginal, oracleOutput.seqNumberOriginal);
            compareInt(oSeqFinal, seq, ourOutput.seqNumberFinal, oracleOutput.seqNumberFinal);
            compareInt(oMeasTime, seq, ourOutput.measurementTimeStandard, oracleOutput.measurementTimeStandard);
            if (!compareDouble(oResultGlucose, seq, ourOutput.resultGlucose, oracleOutput.resultGlucose)) {
                glucoseMismatches++;
            }
            compareDouble(oTrendrate, seq, ourOutput.trendrate, oracleOutput.trendrate);
            compareInt(oCurrentStage, seq, ourOutput.currentStage, oracleOutput.currentStage);
            compareInt(oErrcode, seq, ourOutput.errcode, oracleOutput.errcode);
            compareInt(oCalAvailable, seq, ourOutput.calAvailableFlag, oracleOutput.calAvailableFlag);
            compareInt(oDataType, seq, ourOutput.dataType, oracleOutput.dataType);
            for (int i = 0; i < 6; i++) {
                compareDouble(oSmoothGlu[i], seq,
                    ourOutput.smoothResultGlucose[i], oracleOutput.smoothResultGlucose[i]);
            }

            // === Compare DEBUG fields ===
            compareInt(dSeqOriginal, seq, ourDebug.seqNumberOriginal, oracleDebug.seqNumberOriginal);
            compareInt(dSeqFinal, seq, ourDebug.seqNumberFinal, oracleDebug.seqNumberFinal);
            compareInt(dMeasTime, seq, ourDebug.measurementTimeStandard, oracleDebug.measurementTimeStandard);
            compareInt(dDataType, seq, ourDebug.dataType, oracleDebug.dataType);
            compareInt(dStage, seq, ourDebug.stage, oracleDebug.stage);
            compareDouble(dTemperature, seq, ourDebug.temperature, oracleDebug.temperature);
            for (int i = 0; i < 5; i++) {
                compareDouble(dTranInA1min[i], seq, ourDebug.tranInA1min[i], oracleDebug.tranInA1min[i]);
            }
            compareDouble(dTranInA5min, seq, ourDebug.tranInA5min, oracleDebug.tranInA5min);
            compareDouble(dYcept, seq, ourDebug.ycept, oracleDebug.ycept);
            compareDouble(dCorrectedReCurrent, seq, ourDebug.correctedReCurrent, oracleDebug.correctedReCurrent);
            compareDouble(dDiabetesMeanX, seq, ourDebug.diabetesMeanX, oracleDebug.diabetesMeanX);
            compareDouble(dDiabetesM2, seq, ourDebug.diabetesM2, oracleDebug.diabetesM2);
            compareDouble(dDiabetesTAR, seq, ourDebug.diabetesTAR, oracleDebug.diabetesTAR);
            compareDouble(dDiabetesTBR, seq, ourDebug.diabetesTBR, oracleDebug.diabetesTBR);
            compareDouble(dDiabetesCV, seq, ourDebug.diabetesCV, oracleDebug.diabetesCV);
            compareInt(dLevelDiabetes, seq, ourDebug.levelDiabetes, oracleDebug.levelDiabetes);
            compareDouble(dOutIir, seq, ourDebug.outIir, oracleDebug.outIir);
            compareDouble(dOutDrift, seq, ourDebug.outDrift, oracleDebug.outDrift);
            compareDouble(dCurrBaseline, seq, ourDebug.currBaseline, oracleDebug.currBaseline);
            compareDouble(dInitstableDiffDc, seq, ourDebug.initstableDiffDc, oracleDebug.initstableDiffDc);
            compareInt(dInitstableInitcnt, seq, ourDebug.initstableInitcnt, oracleDebug.initstableInitcnt);
            compareDouble(dTempLocalMean, seq, ourDebug.tempLocalMean, oracleDebug.tempLocalMean);
            compareDouble(dSlopeRatioTemp, seq, ourDebug.slopeRatioTemp, oracleDebug.slopeRatioTemp);
            compareDouble(dInitCg, seq, ourDebug.initCg, oracleDebug.initCg);
            compareDouble(dOutRescale, seq, ourDebug.outRescale, oracleDebug.outRescale);
            compareDouble(dOpcalAd, seq, ourDebug.opcalAd, oracleDebug.opcalAd);
            compareInt(dStateInitKalman, seq, ourDebug.stateInitKalman, oracleDebug.stateInitKalman);
            compareInt(dCalState, seq, ourDebug.calState, oracleDebug.calState);
            compareInt(dStateReturnOpcal, seq, ourDebug.stateReturnOpcal, oracleDebug.stateReturnOpcal);
            compareInt(dValidBgTime, seq, ourDebug.validBgTime, oracleDebug.validBgTime);
            compareDouble(dValidBgValue, seq, ourDebug.validBgValue, oracleDebug.validBgValue);
            compareInt(dCallogGroup, seq, ourDebug.callogGroup, oracleDebug.callogGroup);
            compareInt(dCallogBgTime, seq, ourDebug.callogBgTime, oracleDebug.callogBgTime);
            compareDouble(dCallogBgSeq, seq, ourDebug.callogBgSeq, oracleDebug.callogBgSeq);
            compareDouble(dCallogBgUser, seq, ourDebug.callogBgUser, oracleDebug.callogBgUser);
            compareInt(dCallogBgValid, seq, ourDebug.callogBgValid, oracleDebug.callogBgValid);
            compareDouble(dCallogBgCal, seq, ourDebug.callogBgCal, oracleDebug.callogBgCal);
            compareDouble(dCallogCgSeq1m, seq, ourDebug.callogCgSeq1m, oracleDebug.callogCgSeq1m);
            compareInt(dCallogCgIdx, seq, ourDebug.callogCgIdx, oracleDebug.callogCgIdx);
            compareDouble(dCallogCgCal, seq, ourDebug.callogCgCal, oracleDebug.callogCgCal);
            compareDouble(dCallogCslopePrev, seq, ourDebug.callogCslopePrev, oracleDebug.callogCslopePrev);
            compareDouble(dCallogCyceptPrev, seq, ourDebug.callogCyceptPrev, oracleDebug.callogCyceptPrev);
            compareDouble(dCallogCslopeNew, seq, ourDebug.callogCslopeNew, oracleDebug.callogCslopeNew);
            compareDouble(dCallogCyceptNew, seq, ourDebug.callogCyceptNew, oracleDebug.callogCyceptNew);
            compareInt(dCallogInlierFlg, seq, ourDebug.callogInlierFlg, oracleDebug.callogInlierFlg);
            compareDouble(dInitstableWeightUsercal, seq, ourDebug.initstableWeightUsercal, oracleDebug.initstableWeightUsercal);
            compareDouble(dInitstableWeightNocal, seq, ourDebug.initstableWeightNocal, oracleDebug.initstableWeightNocal);
            compareDouble(dInitstableFixusercal, seq, ourDebug.initstableFixusercal, oracleDebug.initstableFixusercal);
            compareInt(dNOpcalState, seq, ourDebug.nOpcalState, oracleDebug.nOpcalState);
            compareInt(dInitstableInitEndPoint, seq, ourDebug.initstableInitEndPoint, oracleDebug.initstableInitEndPoint);
            compareDouble(dOutWeightAd, seq, ourDebug.outWeightAd, oracleDebug.outWeightAd);
            compareDouble(dShiftoutAd, seq, ourDebug.shiftoutAd, oracleDebug.shiftoutAd);
            compareInt(dErrorCode1, seq, ourDebug.errorCode1, oracleDebug.errorCode1);
            compareInt(dErrorCode2, seq, ourDebug.errorCode2, oracleDebug.errorCode2);
            compareInt(dErrorCode4, seq, ourDebug.errorCode4, oracleDebug.errorCode4);
            compareInt(dErrorCode8, seq, ourDebug.errorCode8, oracleDebug.errorCode8);
            compareInt(dErrorCode16, seq, ourDebug.errorCode16, oracleDebug.errorCode16);
            compareInt(dErrorCode32, seq, ourDebug.errorCode32, oracleDebug.errorCode32);
            compareDouble(dTrendrate, seq, ourDebug.trendrate, oracleDebug.trendrate);
            compareInt(dCalAvailableFlag, seq, ourDebug.calAvailableFlag, oracleDebug.calAvailableFlag);
            // err1
            compareDouble(dErr1ISseDMean, seq, ourDebug.err1ISseDMean, oracleDebug.err1ISseDMean);
            compareDouble(dErr1ThSseDMean1, seq, ourDebug.err1ThSseDMean1, oracleDebug.err1ThSseDMean1);
            compareDouble(dErr1ThSseDMean2, seq, ourDebug.err1ThSseDMean2, oracleDebug.err1ThSseDMean2);
            compareDouble(dErr1ThSseDMean, seq, ourDebug.err1ThSseDMean, oracleDebug.err1ThSseDMean);
            compareInt(dErr1IsContactBad, seq, ourDebug.err1IsContactBad, oracleDebug.err1IsContactBad);
            compareDouble(dErr1CurrentAvgDiff, seq, ourDebug.err1CurrentAvgDiff, oracleDebug.err1CurrentAvgDiff);
            compareDouble(dErr1ThDiff1, seq, ourDebug.err1ThDiff1, oracleDebug.err1ThDiff1);
            compareDouble(dErr1ThDiff2, seq, ourDebug.err1ThDiff2, oracleDebug.err1ThDiff2);
            compareDouble(dErr1ThDiff, seq, ourDebug.err1ThDiff, oracleDebug.err1ThDiff);
            compareInt(dErr1Isfirst0, seq, ourDebug.err1Isfirst0, oracleDebug.err1Isfirst0);
            compareInt(dErr1Isfirst1, seq, ourDebug.err1Isfirst1, oracleDebug.err1Isfirst1);
            compareInt(dErr1Isfirst2, seq, ourDebug.err1Isfirst2, oracleDebug.err1Isfirst2);
            compareInt(dErr1N, seq, ourDebug.err1N, oracleDebug.err1N);
            compareInt(dErr1RandomNoiseTempBreak, seq, ourDebug.err1RandomNoiseTempBreak, oracleDebug.err1RandomNoiseTempBreak);
            compareInt(dErr1Result, seq, ourDebug.err1Result, oracleDebug.err1Result);
            compareInt(dErr1ResultTD, seq, ourDebug.err1ResultTD, oracleDebug.err1ResultTD);
            // err2
            compareDouble(dErr2DelayRevisedValue, seq, ourDebug.err2DelayRevisedValue, oracleDebug.err2DelayRevisedValue);
            compareDouble(dErr2DelayRoc, seq, ourDebug.err2DelayRoc, oracleDebug.err2DelayRoc);
            compareDouble(dErr2DelaySlopeSharp, seq, ourDebug.err2DelaySlopeSharp, oracleDebug.err2DelaySlopeSharp);
            compareDouble(dErr2DelayRocCummax, seq, ourDebug.err2DelayRocCummax, oracleDebug.err2DelayRocCummax);
            compareDouble(dErr2DelaySlopeCummax, seq, ourDebug.err2DelaySlopeCummax, oracleDebug.err2DelaySlopeCummax);
            compareDouble(dErr2DelayGluCummax, seq, ourDebug.err2DelayGluCummax, oracleDebug.err2DelayGluCummax);
            compareInt(dErr2DelayFlag, seq, ourDebug.err2DelayFlag, oracleDebug.err2DelayFlag);
            compareDouble(dErr2Cummax, seq, ourDebug.err2Cummax, oracleDebug.err2Cummax);
            for (int i = 0; i < 2; i++) {
                compareInt(dErr2CrtCurrent[i], seq, ourDebug.err2CrtCurrent[i], oracleDebug.err2CrtCurrent[i]);
                compareInt(dErr2CrtGlu[i], seq, ourDebug.err2CrtGlu[i], oracleDebug.err2CrtGlu[i]);
                compareInt(dErr2Condi[i], seq, ourDebug.err2Condi[i], oracleDebug.err2Condi[i]);
            }
            // err4
            compareDouble(dErr4Min, seq, ourDebug.err4Min, oracleDebug.err4Min);
            compareDouble(dErr4Range, seq, ourDebug.err4Range, oracleDebug.err4Range);
            compareDouble(dErr4MinDiff, seq, ourDebug.err4MinDiff, oracleDebug.err4MinDiff);
            // err16
            compareDouble(dErr16CgmPlasma, seq, ourDebug.err16CgmPlasma, oracleDebug.err16CgmPlasma);
            compareDouble(dErr16CgmIsfSmooth, seq, ourDebug.err16CgmIsfSmooth, oracleDebug.err16CgmIsfSmooth);
            // err128
            compareInt(dErr128Flag, seq, ourDebug.err128Flag, oracleDebug.err128Flag);
            compareDouble(dErr128RevisedValue, seq, ourDebug.err128RevisedValue, oracleDebug.err128RevisedValue);
            compareDouble(dErr128Normal, seq, ourDebug.err128Normal, oracleDebug.err128Normal);

            // tran_inA array (30 doubles)
            for (int i = 0; i < 30; i++) {
                compareDouble(dTranInA, seq, ourDebug.tranInA[i], oracleDebug.tranInA[i]);
            }

            // Progress: print first 5, then every 50th
            if (seq <= 5 || seq % 50 == 0 || seq == READINGS_PER_LOT) {
                System.out.printf("  lot%d seq %3d: glu ours=%.2f oracle=%.2f | err ours=%d oracle=%d%n",
                    lotNum, seq, ourOutput.resultGlucose, oracleOutput.resultGlucose,
                    ourOutput.errcode, oracleOutput.errcode);
            }

            readingsCompared++;
        }

        // Print reports
        System.out.println();
        System.out.printf("=== Lot %d: %d readings compared ===%n", lotNum, readingsCompared);
        printReport("OUTPUT", allOutputStats);
        printReport("DEBUG", allDebugStats);

        return new LotResult(lotNum, readingsCompared, glucoseMismatches,
            allOutputStats, allDebugStats);
    }

    private static void printReport(String section, List<FieldStats> fields) {
        System.out.printf("%n--- %s Field Match Report ---%n", section);
        System.out.printf("%-45s %6s %6s %6s %10s %10s %s%n",
            "Field", "Total", "Match", "Miss", "MaxAbsE", "MaxRelE", "FirstMiss");
        System.out.printf("%-45s %6s %6s %6s %10s %10s %s%n",
            "-----", "-----", "-----", "----", "-------", "-------", "---------");

        int totalMatch = 0, totalMismatch = 0, totalTotal = 0;
        for (FieldStats f : fields) {
            totalMatch += f.match;
            totalMismatch += f.mismatch;
            totalTotal += f.total;

            String absStr = (f.maxAbsErr > 0) ? String.format("%.1e", f.maxAbsErr) : "-";
            String relStr = (f.maxRelErr > 0) ? String.format("%.1e", f.maxRelErr) : "-";
            String firstStr = (f.firstMismatchSeq > 0)
                ? "seq " + f.firstMismatchSeq : "-";
            String status = (f.mismatch == 0) ? " OK" : " FAIL";

            System.out.printf("%-45s %6d %6d %6d %10s %10s %-12s%s%n",
                f.name, f.total, f.match, f.mismatch,
                absStr, relStr, firstStr, status);
        }

        double pct = (totalTotal > 0) ? 100.0 * totalMatch / totalTotal : 0.0;
        System.out.printf("%n  TOTAL: %d/%d fields match (%.1f%%)%n", totalMatch, totalTotal, pct);
    }

    static class LotResult {
        final int lotNum;
        final int readingsCompared;
        final int glucoseMismatches;
        final List<FieldStats> outputStats;
        final List<FieldStats> debugStats;
        final int totalOutputMatch;
        final int totalOutputMismatch;
        final int totalDebugMatch;
        final int totalDebugMismatch;

        LotResult(int lotNum, int readingsCompared, int glucoseMismatches,
                  List<FieldStats> outputStats, List<FieldStats> debugStats) {
            this.lotNum = lotNum;
            this.readingsCompared = readingsCompared;
            this.glucoseMismatches = glucoseMismatches;
            this.outputStats = outputStats;
            this.debugStats = debugStats;
            int om = 0, omm = 0, dm = 0, dmm = 0;
            for (FieldStats f : outputStats) { om += f.match; omm += f.mismatch; }
            for (FieldStats f : debugStats) { dm += f.match; dmm += f.mismatch; }
            this.totalOutputMatch = om;
            this.totalOutputMismatch = omm;
            this.totalDebugMatch = dm;
            this.totalDebugMismatch = dmm;
        }
    }

    // ======================================================================
    // Test methods — one per lot (parameterized)
    // ======================================================================

    @ParameterizedTest(name = "lot{0}: eapp={0}")
    @ValueSource(ints = {0, 1, 2, 3, 4})
    @DisplayName("Oracle verification")
    void verifyLot(int lotNum) throws IOException {
        Assumptions.assumeTrue(oracleBase != null,
            "Oracle data directory not found");

        LotResult result = runLotVerification(lotNum);

        // Print first N mismatches for diagnosis
        List<FieldStats> allStats = new ArrayList<>();
        allStats.addAll(result.outputStats);
        allStats.addAll(result.debugStats);

        int mismatchFieldCount = 0;
        System.out.println("\n--- First mismatches for lot" + lotNum + " ---");
        for (FieldStats f : allStats) {
            if (f.mismatch > 0) {
                mismatchFieldCount++;
                if (mismatchFieldCount <= 20) {
                    System.out.printf("  %-45s: %d/%d mismatches, first at seq %d: %s%n",
                        f.name, f.mismatch, f.total, f.firstMismatchSeq,
                        f.firstMismatchDetail != null ? f.firstMismatchDetail : "");
                }
            }
        }
        if (mismatchFieldCount > 20) {
            System.out.printf("  ... and %d more mismatching fields%n", mismatchFieldCount - 20);
        }

        System.out.printf("%nLot %d summary: output %d/%d match, debug %d/%d match, glucose mismatches: %d%n",
            lotNum,
            result.totalOutputMatch, result.totalOutputMatch + result.totalOutputMismatch,
            result.totalDebugMatch, result.totalDebugMatch + result.totalDebugMismatch,
            result.glucoseMismatches);

        // CRITICAL ASSERTION: glucose values must match
        assertEquals(0, result.glucoseMismatches,
            "MEDICAL SAFETY FAILURE: " + result.glucoseMismatches
            + " glucose value mismatches in lot" + lotNum
            + ". Every glucose reading must match the oracle at 1e-10 precision.");
    }

    // ======================================================================
    // Aggregate summary test
    // ======================================================================

    @Test
    @DisplayName("Full oracle verification summary across all lots")
    void fullOracleVerificationSummary() throws IOException {
        Assumptions.assumeTrue(oracleBase != null,
            "Oracle data directory not found");

        int totalReadings = 0;
        int totalGluMismatches = 0;
        int totalOutputMatch = 0, totalOutputMismatch = 0;
        int totalDebugMatch = 0, totalDebugMismatch = 0;

        for (int lot = 0; lot < 5; lot++) {
            String lotDir = oracleBase + "/lot" + lot;
            if (!Files.isDirectory(Paths.get(lotDir))) {
                System.out.printf("Skipping lot%d (no oracle data)%n", lot);
                continue;
            }

            LotResult result = runLotVerification(lot);
            totalReadings += result.readingsCompared;
            totalGluMismatches += result.glucoseMismatches;
            totalOutputMatch += result.totalOutputMatch;
            totalOutputMismatch += result.totalOutputMismatch;
            totalDebugMatch += result.totalDebugMatch;
            totalDebugMismatch += result.totalDebugMismatch;
        }

        System.out.println("\n========================================");
        System.out.println("FULL ORACLE VERIFICATION SUMMARY");
        System.out.println("========================================");
        System.out.printf("Total readings:          %d%n", totalReadings);
        System.out.printf("Output fields match:     %d/%d (%.1f%%)%n",
            totalOutputMatch, totalOutputMatch + totalOutputMismatch,
            (totalOutputMatch + totalOutputMismatch > 0)
                ? 100.0 * totalOutputMatch / (totalOutputMatch + totalOutputMismatch) : 0.0);
        System.out.printf("Debug fields match:      %d/%d (%.1f%%)%n",
            totalDebugMatch, totalDebugMatch + totalDebugMismatch,
            (totalDebugMatch + totalDebugMismatch > 0)
                ? 100.0 * totalDebugMatch / (totalDebugMatch + totalDebugMismatch) : 0.0);
        System.out.printf("Glucose mismatches:      %d%n", totalGluMismatches);
        System.out.println("========================================");

        assertEquals(0, totalGluMismatches,
            "MEDICAL SAFETY FAILURE: " + totalGluMismatches
            + " total glucose value mismatches across all lots.");
    }
}
