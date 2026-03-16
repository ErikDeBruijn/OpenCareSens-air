package com.opencaresens.air;

import com.opencaresens.air.model.AlgorithmOutput;
import com.opencaresens.air.model.AlgorithmState;
import com.opencaresens.air.model.CalibrationList;
import com.opencaresens.air.model.CgmInput;
import com.opencaresens.air.model.DebugOutput;
import com.opencaresens.air.model.DeviceInfo;

import java.util.Arrays;

/**
 * Main 14-step calibration pipeline for the CareSens Air CGM.
 * Ported from air1_opcal4_algorithm() in calibration.c.
 *
 * MEDICAL SAFETY: This is life-critical code. Every calculation must match
 * the C implementation at machine-epsilon precision. Incorrect glucose values
 * lead to wrong insulin dosing, causing dangerous hypo/hyperglycemia.
 */
final class CalibrationAlgorithm {

    private CalibrationAlgorithm() {} // prevent instantiation

    // ======================================================================
    // Constants — must match C implementation exactly
    // ======================================================================

    // Temperature correction (lot type 1)
    static final double TEMP_REF = 37.0;
    static final double TEMP_COEFF = 0.1584;

    // Temperature correction (lot type 2)
    static final double LOT2_TEMP_COEFF = 0.0328;
    static final double LOT2_TEMP_REF = 34.0854;
    static final int TEMP_BUF_SIZE = 4;

    // Drift polynomial coefficients (from get_params)
    static final double DRIFT_COEF_A = -5.151560190469187e-12;
    static final double DRIFT_COEF_B = 5.994148299744164e-09;
    static final double DRIFT_COEF_C = 5.293796500000622e-05;
    static final double DRIFT_COEF_D = 0.9146662999999999;
    static final double DRIFT_APPLY_RATE = 0.9;

    // Holt-Kalman constants
    static final double PHI = 0.60653065971263342; // exp(-0.5)
    static final double HOLT_K1 = 0.6729;
    static final double HOLT_K2 = 1.761;
    static final double HOLT_K3 = 0.1279;

    // Baseline correction
    static final double YCEPT_CONTROL = 0.7;  // lot_type == 1
    static final double YCEPT_TEST = 0.243;   // lot_type == 2

    // ADC conversion
    static final double ADC_DIVISOR = 40950.0;

    // ======================================================================
    // Lot type determination
    // ======================================================================

    /**
     * Determine lot_type from eapp value.
     * eapp < 0.075: lot_type = 2
     * eapp == 0.075: lot_type = 0
     * eapp > 0.075: lot_type = 1
     */
    static int determineLotType(float eapp) {
        double dEapp = (double) eapp;
        if (Double.isNaN(dEapp)) {
            dEapp = 0.0;
        }
        double threshold = 0.075;
        if (dEapp < threshold) return 2;
        if (dEapp > threshold) return 1;
        return 0;
    }

    // ======================================================================
    // ADC to current conversion
    // ======================================================================

    /**
     * Convert 30 ADC values to current.
     * Formula: current[i] = (adc[i] * vref / 40950.0 - eapp) * 100.0
     */
    static double[] adcToCurrent(int[] adc, float vref, float eapp) {
        double[] current = new double[30];
        for (int i = 0; i < 30; i++) {
            current[i] = ((double) adc[i] * (double) vref / ADC_DIVISOR
                         - (double) eapp) * 100.0;
        }
        return current;
    }

    // ======================================================================
    // IIR filter
    // ======================================================================

    /**
     * IIR low-pass filter. Oracle shows pass-through behavior.
     */
    static double iirFilter(double input, AlgorithmState args, DeviceInfo devInfo) {
        if (devInfo.iirFlag == 0) {
            return input;
        }
        args.iirX[1] = args.iirX[0];
        args.iirX[0] = input;
        args.iirY = input;
        if (args.iirStartFlag == 0) {
            args.iirStartFlag = 1;
        }
        return input;
    }

    // ======================================================================
    // Drift correction (lot_type 1 only)
    // ======================================================================

    /**
     * Drift correction: cubic polynomial with rate blending.
     * Also computes baseline extraction (running average).
     */
    static double driftCorrection(double outIir, AlgorithmState args, DebugOutput debug) {
        int n = args.idxOriginSeq;
        double seq = (double) n;

        // Cubic polynomial drift factor
        double poly = DRIFT_COEF_A * seq * seq * seq
                    + DRIFT_COEF_B * seq * seq
                    + DRIFT_COEF_C * seq
                    + DRIFT_COEF_D;

        // Rate blending (clamped)
        double divisor;
        if (poly > 1.0) {
            divisor = 1.0;
        } else {
            divisor = (1.0 - DRIFT_APPLY_RATE) + poly * DRIFT_APPLY_RATE;
        }

        double outDrift = outIir / divisor;
        debug.outDrift = outDrift;

        // Baseline extraction: running average
        if (n == 1) {
            args.baselinePrev = outDrift;
            debug.currBaseline = outDrift;
            debug.initstableDiffDc = outDrift;
        } else {
            double prevBaseline = args.baselinePrev;
            double newBaseline = (prevBaseline * (double) (n - 1) + outDrift) / (double) n;
            debug.currBaseline = newBaseline;
            debug.initstableDiffDc = newBaseline - prevBaseline;
            args.baselinePrev = newBaseline;
        }

        return outDrift;
    }

    // ======================================================================
    // Temperature correction with circular buffer
    // ======================================================================

    /**
     * Compute slope_ratio_temp using a 4-element circular buffer of temperatures.
     */
    static double computeSlopeRatioTempBuffered(double temperature,
                                                 AlgorithmState args,
                                                 int lotType) {
        double[] buf = args.slopeRatioTempBuffer;
        int idx = args.idxOriginSeq;
        int bufLen = (idx < TEMP_BUF_SIZE) ? idx : TEMP_BUF_SIZE;
        int bufPos = (idx - 1) % TEMP_BUF_SIZE;
        buf[bufPos] = temperature;

        // Mean of buffered temperatures
        double tMean = 0.0;
        for (int i = 0; i < bufLen; i++) {
            tMean += buf[i];
        }
        tMean /= (double) bufLen;

        // Oracle-verified: the proprietary binary uses the same temperature correction
        // formula for ALL lot types (lot_type 1 formula), not a lot_type-specific one.
        // Verified: lot0 (eapp=0.10067) and lot2 (eapp=0.05) both produce
        // srt = 1 + (-0.1584) * (T_mean - 37.0) = 1.0792 at T=36.5.
        if (lotType == 1 || lotType == 2) {
            return 1.0 + (-TEMP_COEFF) * (tMean - TEMP_REF);
        } else {
            return 1.0; // lot_type 0: no correction
        }
    }

    // ======================================================================
    // Main pipeline: process()
    // ======================================================================

    /**
     * Main calibration algorithm entry point.
     * Matches air1_opcal4_algorithm() from calibration.c.
     *
     * @return 1 on success, 0 on failure (matches C uint8_t return)
     */
    public static int process(DeviceInfo devInfo,
                               CgmInput cgmInput,
                               CalibrationList calInput,
                               AlgorithmState algoArgs,
                               AlgorithmOutput algoOutput,
                               DebugOutput algoDebug) {
        // Clear output and debug
        clearOutput(algoOutput);
        clearDebug(algoDebug);

        int seq = cgmInput.seqNumber;
        long timeNow = cgmInput.measurementTimeStandard;

        // --- Step 0: First-call initialization ---
        algoArgs.idxOriginSeq++;

        if (algoArgs.idxOriginSeq == 1) {
            algoArgs.lotType = determineLotType(devInfo.eapp);
            algoArgs.sensorStartTime = devInfo.sensorStartTime;
            algoArgs.stateReturnOpcal = -1;
        }

        // Cumulative sequence number
        int seqFinal = seq + algoArgs.cumulSum;

        // --- Populate output header ---
        algoOutput.seqNumberOriginal = seq;
        algoOutput.seqNumberFinal = seqFinal;
        algoOutput.measurementTimeStandard = timeNow;
        System.arraycopy(cgmInput.workout, 0, algoOutput.workout, 0, 30);

        // --- Populate debug header ---
        algoDebug.seqNumberOriginal = seq;
        algoDebug.seqNumberFinal = seqFinal;
        algoDebug.measurementTimeStandard = timeNow;
        algoDebug.dataType = 0;
        // Note: temperature is set AFTER the eapp check below (oracle-verified:
        // the binary returns before setting temperature when eapp is invalid)
        System.arraycopy(cgmInput.workout, 0, algoDebug.workout, 0, 30);

        // --- Parameter validation: eapp range check ---
        // Oracle-verified: the proprietary binary rejects eapp values outside the
        // sensor's valid operating range. eapp >= 0.12 produces errcode=64 (bit 6)
        // with zeroed output. The debug struct retains header fields (seq, time,
        // workout) but temperature stays zeroed.
        double dEappCheck = (double) devInfo.eapp;
        if (dEappCheck >= 0.12) {
            algoOutput.errcode = 64;
            algoOutput.resultGlucose = 0.0;
            return 1;
        }

        algoDebug.temperature = cgmInput.temperature;

        // --- Debug initialization (oracle-verified) ---
        algoDebug.stateReturnOpcal = algoArgs.stateReturnOpcal;
        algoDebug.nOpcalState = -1;
        algoDebug.diabetesTAR = Double.NaN;
        algoDebug.diabetesTBR = Double.NaN;
        algoDebug.diabetesCV = Double.NaN;
        algoDebug.levelDiabetes = 6;
        algoDebug.err1ThSseDMean1 = Double.NaN;
        algoDebug.err1ThSseDMean2 = Double.NaN;
        algoDebug.err1ThSseDMean = Double.NaN;
        algoDebug.err1ThDiff1 = Double.NaN;
        algoDebug.err1ThDiff2 = Double.NaN;
        algoDebug.err1ThDiff = Double.NaN;
        algoDebug.callogCslopePrev = 1.0;
        algoDebug.callogCslopeNew = 1.0;
        algoDebug.initstableWeightUsercal = 1.0;
        algoDebug.initstableFixusercal = 0.8;
        algoDebug.trendrate = 100.0;
        algoDebug.tempLocalMean = cgmInput.temperature;

        // --- Validate device_info parameters ---
        double dEapp = (double) devInfo.eapp;
        double dVref = (double) devInfo.vref;
        double dSlope100 = (double) devInfo.slope100;

        if (dEapp < 0.0 || dEapp > 0.5 ||
            dVref < 0.0 || dVref > 3.0 ||
            dSlope100 < 0.0 || dSlope100 > 10.0) {
            algoDebug.nOpcalState = 1;
            algoOutput.errcode = 0;
            algoOutput.resultGlucose = 0.0;
            return 1;
        }

        // --- Step 1: ADC to current conversion ---
        double[] tranInA = adcToCurrent(cgmInput.workout, devInfo.vref, devInfo.eapp);
        System.arraycopy(tranInA, 0, algoDebug.tranInA, 0, 30);

        // --- Step 2: Compute 1-minute averages via LOESS pipeline ---
        double timeGap = 300.0; // default 5-min interval
        if (algoArgs.idxOriginSeq > 1 && algoArgs.timePrev > 0) {
            timeGap = (double) (timeNow - algoArgs.timePrev);
        }

        // Bridge int[] outlierMaxIndex to byte[] for SignalProcessing
        byte[] outlierFifo = new byte[6];
        for (int i = 0; i < 6; i++) {
            outlierFifo[i] = (byte) algoArgs.outlierMaxIndex[i];
        }

        double[] tranInA1min = SignalProcessing.computeTranInA1min(
                tranInA,
                algoArgs.prevOutlierRemovedCurr,
                algoArgs.prevMovMedianCurr,
                algoArgs.prevCurrent,
                algoArgs.prevNewISig,
                outlierFifo,
                algoArgs.idxOriginSeq,
                timeGap);

        // Copy back outlier FIFO state
        for (int i = 0; i < 6; i++) {
            algoArgs.outlierMaxIndex[i] = outlierFifo[i];
        }

        System.arraycopy(tranInA1min, 0, algoDebug.tranInA1min, 0, 5);

        // tran_inA_5min = average of 1-min values excluding min and max
        double tranInA5min = MathUtils.calAverageWithoutMinMax(tranInA1min, 5);
        algoDebug.tranInA5min = tranInA5min;

        // --- Step 3: Correct baseline (ycept subtraction) ---
        double correctedCurrent;
        int lotType = algoArgs.lotType;
        if (lotType == 1) {
            correctedCurrent = tranInA5min - YCEPT_CONTROL;
        } else if (lotType == 2) {
            correctedCurrent = tranInA5min - YCEPT_TEST;
        } else {
            correctedCurrent = tranInA5min;
        }
        algoDebug.correctedReCurrent = correctedCurrent;

        // --- Step 4: ycept = corrected current ---
        algoDebug.ycept = correctedCurrent;

        // --- Step 5: IIR filter ---
        double outIir = iirFilter(correctedCurrent, algoArgs, devInfo);
        algoDebug.outIir = outIir;

        // --- Step 6: Temperature correction ---
        double slopeRatioTemp = computeSlopeRatioTempBuffered(
                cgmInput.temperature, algoArgs, algoArgs.lotType);
        algoDebug.slopeRatioTemp = slopeRatioTemp;

        // --- Step 7: Drift correction and baseline extraction ---
        // Oracle-verified: drift correction is applied for ALL lot types (lot_type 1 and 2).
        // The proprietary binary uses the same cubic polynomial drift + baseline extraction
        // regardless of eapp/lot_type. Verified: lot2 (eapp=0.05) oracle shows
        // out_drift = out_iir / divisor, not out_drift = out_iir.
        double outDrift = driftCorrection(outIir, algoArgs, algoDebug);

        // --- Step 7b: Initstable counter ---
        {
            double threshold = 0.01;
            if (algoArgs.idxOriginSeq > 1) {
                double diffDc = algoDebug.initstableDiffDc;
                if (diffDc < threshold && diffDc > -threshold) {
                    algoArgs.initstableInitcnt++;
                } else {
                    algoArgs.initstableInitcnt = 0;
                }
            }
            algoDebug.initstableInitcnt = algoArgs.initstableInitcnt;
        }

        // --- Step 8: Initial calibrated glucose estimate ---
        double initCg = outDrift * 100.0 / (dSlope100 * slopeRatioTemp);
        algoDebug.initCg = initCg;

        // --- Step 9: Compute stage ---
        int currentStage;
        if (seq <= devInfo.err345Seq2) {
            currentStage = 0;
        } else {
            currentStage = 1;
        }
        algoDebug.stage = currentStage;
        algoOutput.currentStage = currentStage;

        // --- Step 10: Kalman pass-through + bias correction state ---
        double outRescale = initCg;
        algoDebug.outRescale = outRescale;

        // Bias correction state machine
        {
            int prevFlag = algoArgs.biasFlag;
            int idx = algoArgs.idxOriginSeq;
            int bw = devInfo.basicWarmup;
            int sf = seqFinal;

            // Track init_cg stability
            if (idx > 1) {
                double deltaCg = Math.abs(initCg - algoArgs.initCgPrev);
                if (deltaCg < 0.1) {
                    algoArgs.nSumtrend += 1.0;
                } else {
                    algoArgs.nSumtrend = 0.0;
                }
            }

            // Flag management
            if (sf <= bw) {
                algoArgs.biasFlag = 0;
            } else if (sf <= bw + 6) {
                if (prevFlag == 3 && algoArgs.nSumtrend >= 3.0) {
                    algoArgs.biasFlag = 0;
                } else if (prevFlag == 3 || sf == bw + 1) {
                    algoArgs.biasFlag = 3;
                } else {
                    algoArgs.biasFlag = 0;
                }
            } else {
                algoArgs.biasFlag = 0;
            }

            // Counter management
            if (algoArgs.biasFlag == 3) {
                algoArgs.biasCnt = 1;
            } else if (prevFlag == 3) {
                algoArgs.biasCnt = 1;
            } else if (algoArgs.biasCnt == 0) {
                algoArgs.biasCnt = 1;
            } else if (sf >= 2 * devInfo.err345Seq2) {
                algoArgs.biasCnt++;
            }
        }
        algoDebug.stateInitKalman = algoArgs.biasFlag;

        // Store rate of change history (shift right by 1)
        System.arraycopy(algoArgs.kalmanRoc, 0, algoArgs.kalmanRoc, 1, 3);
        algoArgs.kalmanRoc[0] = 0.0;

        // --- Step 11: Savitzky-Golay smoothing ---
        // Save timestamps before smooth_sg corrupts via int aliasing
        long[] savedSmoothTime = new long[9];
        System.arraycopy(algoArgs.smoothTimeIn, 1, savedSmoothTime, 0, 9);

        // Convert long[] to int[] for SG
        int[] seqInSg = new int[10];
        for (int i = 0; i < 10; i++) {
            seqInSg[i] = (int) algoArgs.smoothTimeIn[i];
        }
        int[] frepInSg = new int[6];
        System.arraycopy(algoArgs.smoothFRepIn, 0, frepInSg, 0, 6);

        SignalProcessing.SgResult sgResult = SignalProcessing.smoothSg(
                algoArgs.smoothSigIn, seqInSg, frepInSg,
                outRescale, seq, 0,
                devInfo.wSgX100);

        // Copy results back to state
        System.arraycopy(sgResult.sigOut, 0, algoArgs.smoothSigIn, 0, 10);
        for (int i = 0; i < 10; i++) {
            algoArgs.smoothTimeIn[i] = sgResult.seqOut[i];
        }
        System.arraycopy(sgResult.frepOut, 0, algoArgs.smoothFRepIn, 0, 6);

        // Oracle-verified: smooth_result_glucose corresponds to SG buffer positions [3..8].
        // The SG buffer has 10 elements: positions [0..2] are unsmoothed
        // (shifted raw values), [3..9] are SG-convolved. The 6 output smooth values
        // come from positions [3..8]. Similarly for smooth_seq.
        for (int i = 0; i < 6; i++) {
            algoDebug.smoothSig[i] = algoArgs.smoothSigIn[i + 3];
            algoDebug.smoothSeq[i] = (int) algoArgs.smoothTimeIn[i + 3];
            algoDebug.smoothFrep[i] = algoArgs.smoothFRepIn[i];
        }

        // Restore proper timestamps for trendrate
        System.arraycopy(savedSmoothTime, 0, algoArgs.smoothTimeIn, 0, 9);
        algoArgs.smoothTimeIn[9] = timeNow;

        // --- Step 11b: Holt bias correction ---
        double opcalAd;
        {
            int cnt = algoArgs.biasCnt;
            if (cnt <= 1) {
                if (cnt == 1) {
                    algoArgs.holtLevel = initCg;
                    algoArgs.holtForecast = initCg;
                    algoArgs.holtTrend = 0.0;
                }
                opcalAd = initCg;
            } else {
                // State prediction
                double levelPred = PHI * algoArgs.holtLevel
                                 + (1.0 - PHI) * algoArgs.holtForecast;
                double forecastPred = algoArgs.holtForecast + algoArgs.holtTrend;
                double trendPred = algoArgs.holtTrend;

                // Innovation and Kalman update
                double innovation = initCg - levelPred;
                algoArgs.holtLevel = levelPred + HOLT_K1 * innovation;
                algoArgs.holtForecast = forecastPred + HOLT_K2 * innovation;
                algoArgs.holtTrend = trendPred + HOLT_K3 * innovation;

                if (cnt > 25) {
                    opcalAd = algoArgs.holtForecast;
                } else {
                    opcalAd = initCg + (algoArgs.holtForecast - initCg)
                            * (double) (cnt - 1) / 24.0;
                }
            }
        }
        algoDebug.opcalAd = opcalAd;
        double resultGlucose = opcalAd;

        algoDebug.outWeightAd = opcalAd;
        algoDebug.shiftoutAd = opcalAd;

        // --- Step 12: Calibration state ---
        algoDebug.calState = algoArgs.calState;

        // --- Step 13: Error detection ---
        int errcode = CheckError.checkError(devInfo, algoArgs, algoDebug,
                resultGlucose, correctedCurrent, seq, timeNow, currentStage);

        // Update prev_last_1min_curr
        algoArgs.err1PrevLast1minCurr = tranInA1min[4];

        // --- Step 13b: Trendrate computation ---
        computeTrendrate(algoArgs, algoDebug, errcode, timeNow);

        // --- Step 14: Set final output ---
        algoOutput.resultGlucose = resultGlucose;
        algoOutput.errcode = errcode;
        algoOutput.trendrate = algoDebug.trendrate;
        algoOutput.calAvailableFlag = algoDebug.calAvailableFlag;
        algoOutput.dataType = algoDebug.dataType;

        for (int i = 0; i < 6; i++) {
            algoOutput.smoothSeq[i] = algoDebug.smoothSeq[i];
            algoOutput.smoothResultGlucose[i] = algoDebug.smoothSig[i];
            algoOutput.smoothFixedFlag[i] = algoDebug.smoothFrep[i];
        }

        // --- Store state for next call ---
        algoArgs.timePrev = timeNow;
        algoArgs.seqPrev = seq;
        System.arraycopy(cgmInput.workout, 0, algoArgs.adcPrev, 0, 30);
        algoArgs.tempPrev = cgmInput.temperature;
        algoArgs.initCgPrev = initCg;

        return 1;
    }

    // ======================================================================
    // Trendrate computation (Step 13b)
    // ======================================================================

    static void computeTrendrate(AlgorithmState algoArgs, DebugOutput algoDebug,
                                  int errcode, long timeNow) {
        // Update err_delay_arr: shift left, append current error status
        System.arraycopy(algoArgs.errDelayArr, 1, algoArgs.errDelayArr, 0, 6);
        algoArgs.errDelayArr[6] = (errcode != 0) ? 1 : 0;

        // Guard: need at least 12 readings
        if (algoArgs.idxOriginSeq < 12) return;

        // Guard: 6 consecutive timestamp pairs spaced >= 181s
        // T points to smoothTimeIn[3..9]
        for (int i = 0; i < 6; i++) {
            if (algoArgs.smoothTimeIn[3 + i + 1] - algoArgs.smoothTimeIn[3 + i] < 181) {
                return;
            }
        }

        // Guard: total span in [1200, 2100] seconds
        long span = timeNow - algoArgs.smoothTimeIn[3];
        if (span < 1200 || span > 2100) return;

        // Guard: no error flags in delay array
        for (int i = 0; i < 7; i++) {
            if (algoArgs.errDelayArr[i] == 1) return;
        }

        // Compute calibrated glucose from smooth buffer
        double[] glu = new double[7];
        for (int i = 0; i < 7; i++) {
            glu[i] = algoArgs.smoothSigIn[3 + i];
            if (glu[i] <= 0.0 || glu[i] < 40.0 || glu[i] > 500.0) return;
        }

        // Rate computation
        double rateLong = (glu[6] - glu[0]) / ((double) (timeNow - algoArgs.smoothTimeIn[3]) / 60.0);
        double rateShort = (glu[6] - glu[5]) / ((double) (timeNow - algoArgs.smoothTimeIn[8]) / 60.0);

        // Direction guard
        if (rateShort < 0.0 && rateLong >= 1.0) return;
        if (rateShort > 0.0 && rateLong <= -1.0) return;

        double rateMid = (glu[5] - glu[4]) / ((double) (algoArgs.smoothTimeIn[8] - algoArgs.smoothTimeIn[7]) / 60.0);
        algoDebug.trendrate = (rateShort * rateMid >= 0.0) ? rateShort : 0.0;
    }

    // ======================================================================
    // Output/Debug clearing helpers
    // ======================================================================

    private static void clearOutput(AlgorithmOutput out) {
        out.seqNumberOriginal = 0;
        out.seqNumberFinal = 0;
        out.measurementTimeStandard = 0;
        Arrays.fill(out.workout, 0);
        out.resultGlucose = 0.0;
        out.trendrate = 0.0;
        out.currentStage = 0;
        Arrays.fill(out.smoothFixedFlag, 0);
        Arrays.fill(out.smoothSeq, 0);
        Arrays.fill(out.smoothResultGlucose, 0.0);
        out.errcode = 0;
        out.calAvailableFlag = 0;
        out.dataType = 0;
    }

    private static void clearDebug(DebugOutput d) {
        d.seqNumberOriginal = 0;
        d.seqNumberFinal = 0;
        d.measurementTimeStandard = 0;
        d.dataType = 0;
        d.stage = 0;
        d.temperature = 0.0;
        Arrays.fill(d.workout, 0);
        Arrays.fill(d.tranInA, 0.0);
        Arrays.fill(d.tranInA1min, 0.0);
        d.tranInA5min = 0.0;
        d.ycept = 0.0;
        d.correctedReCurrent = 0.0;
        d.diabetesMeanX = 0.0;
        d.diabetesM2 = 0.0;
        d.diabetesTAR = 0.0;
        d.diabetesTBR = 0.0;
        d.diabetesCV = 0.0;
        d.levelDiabetes = 0;
        d.outIir = 0.0;
        d.outDrift = 0.0;
        d.currBaseline = 0.0;
        d.initstableDiffDc = 0.0;
        d.initstableInitcnt = 0;
        d.tempLocalMean = 0.0;
        d.slopeRatioTemp = 0.0;
        d.initCg = 0.0;
        d.outRescale = 0.0;
        d.opcalAd = 0.0;
        d.stateInitKalman = 0;
        Arrays.fill(d.smoothSeq, 0);
        Arrays.fill(d.smoothSig, 0.0);
        Arrays.fill(d.smoothFrep, 0);
        d.calState = 0;
        d.stateReturnOpcal = 0;
        d.validBgTime = 0;
        d.validBgValue = 0.0;
        d.callogGroup = 0;
        d.callogBgTime = 0;
        d.callogBgSeq = 0.0;
        d.callogBgUser = 0.0;
        d.callogBgValid = 0;
        d.callogBgCal = 0.0;
        d.callogCgSeq1m = 0.0;
        d.callogCgIdx = 0;
        d.callogCgCal = 0.0;
        d.callogCslopePrev = 0.0;
        d.callogCyceptPrev = 0.0;
        d.callogCslopeNew = 0.0;
        d.callogCyceptNew = 0.0;
        d.callogInlierFlg = 0;
        Arrays.fill(d.calSlope, 0.0);
        Arrays.fill(d.calYcept, 0.0);
        Arrays.fill(d.calInput, 0.0);
        Arrays.fill(d.calOutput, 0.0);
        d.initstableWeightUsercal = 0.0;
        d.initstableWeightNocal = 0.0;
        d.initstableFixusercal = 0.0;
        d.nOpcalState = 0;
        d.initstableInitEndPoint = 0;
        Arrays.fill(d.outWeightSd, 0.0);
        d.outWeightAd = 0.0;
        d.shiftoutAd = 0.0;
        d.errorCode1 = 0;
        d.errorCode2 = 0;
        d.errorCode4 = 0;
        d.errorCode8 = 0;
        d.errorCode16 = 0;
        d.errorCode32 = 0;
        d.trendrate = 0.0;
        d.calAvailableFlag = 0;
        d.err1ISseDMean = 0.0;
        d.err1ThSseDMean1 = 0.0;
        d.err1ThSseDMean2 = 0.0;
        d.err1ThSseDMean = 0.0;
        d.err1IsContactBad = 0;
        d.err1CurrentAvgDiff = 0.0;
        d.err1ThDiff1 = 0.0;
        d.err1ThDiff2 = 0.0;
        d.err1ThDiff = 0.0;
        d.err1Isfirst0 = 0;
        d.err1Isfirst1 = 0;
        d.err1Isfirst2 = 0;
        d.err1N = 0;
        d.err1RandomNoiseTempBreak = 0;
        d.err1Result = 0;
        d.err1LengthT2Max = 0;
        d.err1LengthT3Max = 0;
        d.err1LengthT1Trio = 0;
        d.err1LengthT2Trio = 0;
        d.err1LengthT3Trio = 0;
        d.err1LengthT6Trio = 0;
        d.err1LengthT7Trio = 0;
        d.err1LengthT8Trio = 0;
        d.err1LengthT9Trio = 0;
        d.err1LengthT10Trio = 0;
        d.err1ResultTD = 0;
        Arrays.fill(d.err1ResultConditionTD, 0);
        d.err1TDCount = 0;
        d.err1TDTemporaryBreakFlag = 0;
        Arrays.fill(d.err1TDTimeTrio, 0);
        Arrays.fill(d.err1TDValueTrio, 0.0);
        d.err2DelayRevisedValue = 0.0;
        d.err2DelayRoc = 0.0;
        d.err2DelaySlopeSharp = 0.0;
        d.err2DelayRocCummax = 0.0;
        d.err2DelayRocTrimmedMean = 0.0;
        d.err2DelaySlopeCummax = 0.0;
        d.err2DelaySlopeTrimmedMean = 0.0;
        d.err2DelayGluCummax = 0.0;
        d.err2DelayGluTrimmedMean = 0.0;
        Arrays.fill(d.err2DelayPreCondi, 0);
        Arrays.fill(d.err2DelayCondi, 0);
        d.err2DelayFlag = 0;
        d.err2Cummax = 0.0;
        Arrays.fill(d.err2CrtCurrent, 0);
        Arrays.fill(d.err2CrtGlu, 0);
        d.err2CrtCv = 0.0;
        Arrays.fill(d.err2Condi, 0);
        d.err4Min = 0.0;
        d.err4Range = 0.0;
        d.err4MinDiff = 0.0;
        Arrays.fill(d.err4Condi, 0);
        Arrays.fill(d.err4DelayCondi, 0);
        d.err4DelayFlag = 0;
        Arrays.fill(d.err8Condi, 0);
        d.err16CalConsDUsercalAfter = 0.0;
        d.err16CalDayDTemp = 0.0;
        d.err16CalDayDRef = 0.0;
        d.err16CalDayNRef = 0.0;
        d.err16CgmPlasma = 0.0;
        d.err16CgmIsfSmooth = 0.0;
        d.err16CgmIsfRocValue = 0.0;
        d.err16CgmIsfRocSteady = 0.0;
        d.err16CgmIsfRocMinTemp = 0.0;
        d.err16CgmIsfRocMin = 0.0;
        d.err16CgmIsfRocDiff = 0.0;
        d.err16CgmIsfRocRatio = 0.0;
        d.err16CgmIsfTrendMinValue = 0.0;
        d.err16CgmIsfTrendMinSlope1 = 0.0;
        d.err16CgmIsfTrendMinSlope2 = 0.0;
        d.err16CgmIsfTrendMinRsq1 = 0.0;
        d.err16CgmIsfTrendMinRsq2 = 0.0;
        d.err16CgmIsfTrendMinDiff = 0.0;
        d.err16CgmIsfTrendMinMaxTemp = 0.0;
        d.err16CgmIsfTrendMinMax = 0.0;
        d.err16CgmIsfTrendMinRatio = 0.0;
        d.err16CgmIsfTrendModeValue = 0.0;
        d.err16CgmIsfTrendModeProportion = 0.0;
        d.err16CgmIsfTrendModeDiff = 0.0;
        d.err16CgmIsfTrendModeMaxTemp = 0.0;
        d.err16CgmIsfTrendModeMax = 0.0;
        d.err16CgmIsfTrendModeRatio = 0.0;
        d.err16CgmIsfTrendMeanValue = 0.0;
        d.err16CgmIsfTrendMeanSlope = 0.0;
        d.err16CgmIsfTrendMeanRsq = 0.0;
        d.err16CgmIsfTrendMeanDiff = 0.0;
        d.err16CgmIsfTrendMeanMaxTemp = 0.0;
        d.err16CgmIsfTrendMeanMax = 0.0;
        d.err16CgmIsfTrendMeanRatio = 0.0;
        d.err16CgmIsfTrendMeanDiffEarly = 0.0;
        d.err16CgmIsfTrendMeanMaxTempEarly = 0.0;
        d.err16CgmIsfTrendMeanMaxEarly = 0.0;
        d.err16CgmIsfTrendMeanRatioEarly = 0.0;
        Arrays.fill(d.err16Condi, 0);
        d.err128Flag = 0;
        d.err128RevisedValue = 0.0;
        d.err128Normal = 0.0;
    }
}
