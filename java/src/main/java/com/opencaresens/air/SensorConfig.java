package com.opencaresens.air;

import com.opencaresens.air.model.DeviceInfo;

/**
 * Factory calibration parameters for a CareSens Air CGM sensor.
 *
 * <p>These values originate from the sensor's BLE advertisement data and
 * encode the factory calibration performed during manufacturing. They are
 * immutable once constructed.
 *
 * <p>Use the {@link Builder} for construction:
 * <pre>{@code
 * SensorConfig config = new SensorConfig.Builder()
 *     .eapp(0.10067f)
 *     .vref(1.2f)
 *     .slope100(2.5f)
 *     .sensorStartTime(System.currentTimeMillis() / 1000)
 *     .basicWarmup(5)
 *     .err345Seq2(5)
 *     .build();
 * }</pre>
 */
public final class SensorConfig {

    private final DeviceInfo deviceInfo;

    private SensorConfig(DeviceInfo deviceInfo) {
        this.deviceInfo = deviceInfo;
    }

    // ======================================================================
    // Primary getters — the values most integrators need
    // ======================================================================

    /** Electrochemical apparent potential (V). Determines lot type. */
    public float getEapp() { return deviceInfo.eapp; }

    /** Reference voltage (V). */
    public float getVref() { return deviceInfo.vref; }

    /** Slope calibration factor (x100). */
    public float getSlope100() { return deviceInfo.slope100; }

    /** Slope calibration factor. */
    public float getSlope() { return deviceInfo.slope; }

    /** Y-intercept from factory calibration. */
    public float getYcept() { return deviceInfo.ycept; }

    /** Sensor lot identifier. */
    public String getLot() { return deviceInfo.lot; }

    /** Unique sensor identifier. */
    public String getSensorId() { return deviceInfo.sensorId; }

    /** Sensor start time (Unix seconds). */
    public long getSensorStartTime() { return deviceInfo.sensorStartTime; }

    /** Number of warmup readings before glucose is reliable. */
    public int getBasicWarmup() { return deviceInfo.basicWarmup; }

    /** Sequence number threshold for warmup/steady-state transition. */
    public int getErr345Seq2() { return deviceInfo.err345Seq2; }

    // ======================================================================
    // Package-private access to the internal DeviceInfo
    // ======================================================================

    DeviceInfo toDeviceInfo() {
        return deviceInfo;
    }

    // ======================================================================
    // Builder
    // ======================================================================

    /**
     * Builder for constructing a {@link SensorConfig} from individual fields.
     *
     * <p>At minimum, {@code eapp}, {@code vref}, and {@code slope100} must be
     * set. All other fields have safe defaults.
     */
    public static final class Builder {
        private final DeviceInfo di = new DeviceInfo();

        public Builder() {}

        /** Electrochemical apparent potential (V). Required. */
        public Builder eapp(float eapp) { di.eapp = eapp; return this; }

        /** Reference voltage (V). Required. */
        public Builder vref(float vref) { di.vref = vref; return this; }

        /** Slope calibration factor (x100). Required. */
        public Builder slope100(float slope100) { di.slope100 = slope100; return this; }

        /** Slope calibration factor. */
        public Builder slope(float slope) { di.slope = slope; return this; }

        /** Y-intercept from factory calibration. */
        public Builder ycept(float ycept) { di.ycept = ycept; return this; }

        /** R-squared from factory calibration. */
        public Builder r2(float r2) { di.r2 = r2; return this; }

        /** T90 response time (minutes). */
        public Builder t90(float t90) { di.t90 = t90; return this; }

        /** Slope ratio. */
        public Builder slopeRatio(float slopeRatio) { di.slopeRatio = slopeRatio; return this; }

        /** Sensor lot identifier. */
        public Builder lot(String lot) { di.lot = lot; return this; }

        /** Unique sensor identifier. */
        public Builder sensorId(String sensorId) { di.sensorId = sensorId; return this; }

        /** Sensor expiry date string. */
        public Builder expiryDate(String expiryDate) { di.expiryDate = expiryDate; return this; }

        /** Sensor start time (Unix seconds). */
        public Builder sensorStartTime(long sensorStartTime) { di.sensorStartTime = sensorStartTime; return this; }

        /** Sensor version. */
        public Builder sensorVersion(int sensorVersion) { di.sensorVersion = sensorVersion; return this; }

        /** Number of warmup readings. */
        public Builder basicWarmup(int basicWarmup) { di.basicWarmup = basicWarmup; return this; }

        /** Warmup/steady-state transition sequence number. */
        public Builder err345Seq2(int err345Seq2) { di.err345Seq2 = err345Seq2; return this; }

        /** IIR filter flag (0=disabled, 1=enabled). */
        public Builder iirFlag(int iirFlag) { di.iirFlag = iirFlag; return this; }

        /** Maximum glucose value (mg/dL). */
        public Builder maximumValue(float maximumValue) { di.maximumValue = maximumValue; return this; }

        /** Minimum glucose value (mg/dL). */
        public Builder minimumValue(float minimumValue) { di.minimumValue = minimumValue; return this; }

        /** Savitzky-Golay filter weights (7 elements, x100). */
        public Builder wSgX100(int[] wSgX100) {
            System.arraycopy(wSgX100, 0, di.wSgX100, 0, Math.min(wSgX100.length, 7));
            return this;
        }

        /** Error detection sequence thresholds. */
        public Builder err1Seq(int[] err1Seq) {
            System.arraycopy(err1Seq, 0, di.err1Seq, 0, Math.min(err1Seq.length, 3));
            return this;
        }

        /** Error detection multiplier. */
        public Builder err1Multi(int[] err1Multi) {
            System.arraycopy(err1Multi, 0, di.err1Multi, 0, Math.min(err1Multi.length, 2));
            return this;
        }

        /** Error 2 start sequence. */
        public Builder err2StartSeq(int err2StartSeq) { di.err2StartSeq = err2StartSeq; return this; }

        /** Error 2 sequence thresholds. */
        public Builder err2Seq(int[] err2Seq) {
            System.arraycopy(err2Seq, 0, di.err2Seq, 0, Math.min(err2Seq.length, 3));
            return this;
        }

        /** Error 2 cummax. */
        public Builder err2Cummax(int err2Cummax) { di.err2Cummax = err2Cummax; return this; }

        /** Error 2 glucose threshold. */
        public Builder err2Glu(float err2Glu) { di.err2Glu = err2Glu; return this; }

        /** Error 3/4/5 sequence thresholds (array of 5). */
        public Builder err345Seq4(int[] err345Seq4) {
            System.arraycopy(err345Seq4, 0, di.err345Seq4, 0, Math.min(err345Seq4.length, 5));
            return this;
        }

        /** Error 32 delta-time thresholds. */
        public Builder err32Dt(int[] err32Dt) {
            System.arraycopy(err32Dt, 0, di.err32Dt, 0, Math.min(err32Dt.length, 2));
            return this;
        }

        /** Error 32 count thresholds. */
        public Builder err32N(int[] err32N) {
            System.arraycopy(err32N, 0, di.err32N, 0, Math.min(err32N.length, 2));
            return this;
        }

        /** Error 1 last-N window. */
        public Builder err1NLast(int err1NLast) { di.err1NLast = err1NLast; return this; }

        /** Kalman delta-T. */
        public Builder kalmanDeltaT(int kalmanDeltaT) { di.kalmanDeltaT = kalmanDeltaT; return this; }

        /** Basic Y-intercept. */
        public Builder basicYcept(float basicYcept) { di.basicYcept = basicYcept; return this; }

        /**
         * Set the full internal {@link DeviceInfo} directly.
         * Use this when you have a pre-populated DeviceInfo (e.g., parsed from
         * binary advertisement data).
         */
        public Builder fromDeviceInfo(DeviceInfo source) {
            copyDeviceInfo(source, di);
            return this;
        }

        /**
         * Build an immutable {@link SensorConfig}.
         *
         * @throws IllegalStateException if required fields are missing
         */
        public SensorConfig build() {
            if (di.vref == 0.0f && di.slope100 == 0.0f) {
                throw new IllegalStateException(
                    "SensorConfig requires at least vref and slope100 to be set");
            }
            return new SensorConfig(di);
        }

        private static void copyDeviceInfo(DeviceInfo src, DeviceInfo dst) {
            dst.sensorVersion = src.sensorVersion;
            dst.ycept = src.ycept;
            dst.slope100 = src.slope100;
            dst.slope = src.slope;
            dst.r2 = src.r2;
            dst.t90 = src.t90;
            dst.slopeRatio = src.slopeRatio;
            dst.lot = src.lot;
            dst.sensorId = src.sensorId;
            dst.expiryDate = src.expiryDate;
            dst.stabilizationInterval = src.stabilizationInterval;
            dst.cgmDataInterval = src.cgmDataInterval;
            dst.bleAdvInterval = src.bleAdvInterval;
            dst.bleAdvDuration = src.bleAdvDuration;
            dst.age = src.age;
            dst.allowedList = src.allowedList;
            dst.maximumValue = src.maximumValue;
            dst.minimumValue = src.minimumValue;
            dst.cLibraryVersion = src.cLibraryVersion;
            dst.parameterVersion = src.parameterVersion;
            dst.basicWarmup = src.basicWarmup;
            dst.basicYcept = src.basicYcept;
            dst.contactWinLen = src.contactWinLen;
            dst.contactCond1X10 = src.contactCond1X10;
            dst.contactCond2X10 = src.contactCond2X10;
            dst.contactCond3X10 = src.contactCond3X10;
            dst.fillFlag = src.fillFlag;
            dst.driftCorrectionOn = src.driftCorrectionOn;
            for (int i = 0; i < 3; i++)
                System.arraycopy(src.driftCoefficient[i], 0, dst.driftCoefficient[i], 0, 3);
            dst.iRefX100 = src.iRefX100;
            dst.coefLength = src.coefLength;
            dst.divPoint = src.divPoint;
            dst.iirFlag = src.iirFlag;
            dst.iirStDX10 = src.iirStDX10;
            dst.correct1Flag = src.correct1Flag;
            System.arraycopy(src.correct1Coeff, 0, dst.correct1Coeff, 0, 4);
            dst.kalmanT90 = src.kalmanT90;
            dst.kalmanDeltaT = src.kalmanDeltaT;
            for (int i = 0; i < 3; i++)
                System.arraycopy(src.kalmanQX100[i], 0, dst.kalmanQX100[i], 0, 3);
            dst.kalmanRX100 = src.kalmanRX100;
            dst.bgCalRatio = src.bgCalRatio;
            dst.bgCalTimeFactor = src.bgCalTimeFactor;
            dst.slopeFactorX10 = src.slopeFactorX10;
            dst.slopeInterUpX10 = src.slopeInterUpX10;
            dst.slopeInterDownX10 = src.slopeInterDownX10;
            dst.slopeMultiVX10 = src.slopeMultiVX10;
            dst.slopeIirThr = src.slopeIirThr;
            dst.slopeNegInterThr1X10 = src.slopeNegInterThr1X10;
            dst.slopeNegInterThr2X10 = src.slopeNegInterThr2X10;
            dst.slopeBgCalThrDown = src.slopeBgCalThrDown;
            dst.slopeBgCalThrUp = src.slopeBgCalThrUp;
            dst.slopeMaxSlopeX100 = src.slopeMaxSlopeX100;
            dst.slopeMinSlopeX100 = src.slopeMinSlopeX100;
            dst.slopeDcalRate = src.slopeDcalRate;
            dst.slopeDcalTargetLength = src.slopeDcalTargetLength;
            dst.slopeDcalWindow = src.slopeDcalWindow;
            dst.slopeDcalFactoryCalUse = src.slopeDcalFactoryCalUse;
            dst.shiftMSel = src.shiftMSel;
            System.arraycopy(src.shiftCoeff, 0, dst.shiftCoeff, 0, 4);
            System.arraycopy(src.shiftM2X100, 0, dst.shiftM2X100, 0, 3);
            System.arraycopy(src.wSgX100, 0, dst.wSgX100, 0, 7);
            dst.calTrendRate = src.calTrendRate;
            dst.calNoise = src.calNoise;
            dst.errcodeVersion = src.errcodeVersion;
            System.arraycopy(src.err1Seq, 0, dst.err1Seq, 0, 3);
            dst.err1ContactBad = src.err1ContactBad;
            dst.err1ThDiff = src.err1ThDiff;
            System.arraycopy(src.err1ThSseDmean, 0, dst.err1ThSseDmean, 0, 3);
            System.arraycopy(src.err1ThN1, 0, dst.err1ThN1, 0, 4);
            for (int i = 0; i < 2; i++)
                System.arraycopy(src.err1ThN2[i], 0, dst.err1ThN2[i], 0, 2);
            dst.err1NConsecutive = src.err1NConsecutive;
            System.arraycopy(src.err1ISseDmeanNow, 0, dst.err1ISseDmeanNow, 0, 2);
            dst.err1CountSseDmean = src.err1CountSseDmean;
            dst.err1NLast = src.err1NLast;
            System.arraycopy(src.err1Multi, 0, dst.err1Multi, 0, 2);
            dst.err1CurrentAvgDiff = src.err1CurrentAvgDiff;
            dst.err2StartSeq = src.err2StartSeq;
            System.arraycopy(src.err2Seq, 0, dst.err2Seq, 0, 3);
            dst.err2Glu = src.err2Glu;
            System.arraycopy(src.err2Cv, 0, dst.err2Cv, 0, 3);
            dst.err2Cummax = src.err2Cummax;
            dst.err2Multi = src.err2Multi;
            dst.err2Ycept = src.err2Ycept;
            dst.err2Alpha = src.err2Alpha;
            System.arraycopy(src.err345Seq1, 0, dst.err345Seq1, 0, 2);
            dst.err345Seq2 = src.err345Seq2;
            System.arraycopy(src.err345Seq3, 0, dst.err345Seq3, 0, 3);
            System.arraycopy(src.err345Seq4, 0, dst.err345Seq4, 0, 5);
            System.arraycopy(src.err345Seq5, 0, dst.err345Seq5, 0, 3);
            System.arraycopy(src.err345Raw, 0, dst.err345Raw, 0, 4);
            System.arraycopy(src.err345Filtered, 0, dst.err345Filtered, 0, 2);
            System.arraycopy(src.err345Min, 0, dst.err345Min, 0, 2);
            dst.err345Range = src.err345Range;
            dst.err345NRange = src.err345NRange;
            dst.err345Md = src.err345Md;
            dst.err345NMd = src.err345NMd;
            dst.err6CalNPts = src.err6CalNPts;
            dst.err6CalBasicPrct = src.err6CalBasicPrct;
            dst.err6CalBasicSeq = src.err6CalBasicSeq;
            dst.err6CalOriginSlope = src.err6CalOriginSlope;
            System.arraycopy(src.err6CalInVitro, 0, dst.err6CalInVitro, 0, 2);
            dst.err6CgmRpd = src.err6CgmRpd;
            dst.err6CgmSlp = src.err6CgmSlp;
            dst.err6CgmLow3dSeq = src.err6CgmLow3dSeq;
            dst.err6CgmLow3dP = src.err6CgmLow3dP;
            dst.err6CgmLow1dSeq = src.err6CgmLow1dSeq;
            dst.err6CgmLow1dP = src.err6CgmLow1dP;
            System.arraycopy(src.err6CgmPrct, 0, dst.err6CgmPrct, 0, 3);
            System.arraycopy(src.err6CgmDay, 0, dst.err6CgmDay, 0, 2);
            System.arraycopy(src.err6CgmBleBad, 0, dst.err6CgmBleBad, 0, 2);
            dst.err6CgmPoly2 = src.err6CgmPoly2;
            System.arraycopy(src.err32Dt, 0, dst.err32Dt, 0, 2);
            System.arraycopy(src.err32N, 0, dst.err32N, 0, 2);
            dst.vref = src.vref;
            dst.eapp = src.eapp;
            dst.sensorStartTime = src.sensorStartTime;
        }
    }
}
