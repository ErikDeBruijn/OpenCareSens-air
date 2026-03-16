package com.opencaresens.air;

/**
 * Immutable result of calibrating one CGM reading.
 *
 * <p>Contains the calibrated glucose value, trend rate, error information,
 * and smoothed historical glucose values. All fields are set at construction
 * time and cannot be modified.
 *
 * <p>Typical usage:
 * <pre>{@code
 * CalibrationResult result = calibrator.processReading(seq, timestamp, adc, temp);
 * if (result.isValid()) {
 *     double glucose = result.getGlucoseMgdl();
 *     double trend = result.getTrendRateMgdlPerMin();
 * }
 * }</pre>
 */
public final class CalibrationResult {

    private final double glucoseMgdl;
    private final double trendRate;
    private final int errorCode;
    private final int stage;
    private final int calAvailableFlag;
    private final double[] smoothedGlucose;
    private final int[] smoothedSeq;
    private final int[] smoothedFixedFlag;

    CalibrationResult(double glucoseMgdl, double trendRate, int errorCode,
                      int stage, int calAvailableFlag,
                      double[] smoothedGlucose, int[] smoothedSeq,
                      int[] smoothedFixedFlag) {
        this.glucoseMgdl = glucoseMgdl;
        this.trendRate = trendRate;
        this.errorCode = errorCode;
        this.stage = stage;
        this.calAvailableFlag = calAvailableFlag;
        // Defensive copies for immutability
        this.smoothedGlucose = smoothedGlucose.clone();
        this.smoothedSeq = smoothedSeq.clone();
        this.smoothedFixedFlag = smoothedFixedFlag.clone();
    }

    /**
     * Calibrated glucose value in mg/dL.
     *
     * <p>Check {@link #isValid()} before using this value. When the reading
     * has errors, this may be zero or unreliable.
     */
    public double getGlucoseMgdl() {
        return glucoseMgdl;
    }

    /**
     * Calibrated glucose value in mmol/L.
     *
     * <p>Convenience conversion: {@code mg/dL / 18.0182}.
     */
    public double getGlucoseMmol() {
        return glucoseMgdl / 18.0182;
    }

    /**
     * Rate of glucose change in mg/dL per minute.
     *
     * <p>A value of {@code 100.0} means the trend rate is not yet available
     * (insufficient readings). Positive values indicate rising glucose,
     * negative values indicate falling glucose.
     */
    public double getTrendRateMgdlPerMin() {
        return trendRate;
    }

    /**
     * Error code bitmask. Zero means no error.
     *
     * <p>Individual error bits:
     * <ul>
     *   <li>Bit 0 (1): Contact/noise error</li>
     *   <li>Bit 1 (2): Delay/slope error</li>
     *   <li>Bit 2 (4): Range error</li>
     *   <li>Bit 3 (8): High-frequency noise</li>
     *   <li>Bit 4 (16): Calibration drift</li>
     *   <li>Bit 5 (32): Communication error</li>
     *   <li>Bit 6 (64): Parameter validation error</li>
     * </ul>
     */
    public int getErrorCode() {
        return errorCode;
    }

    /**
     * Whether this reading has any error flags set.
     */
    public boolean hasError() {
        return errorCode != 0;
    }

    /**
     * Whether this reading produced a valid, usable glucose value.
     *
     * <p>A reading is valid when there are no errors and the glucose value
     * falls within the sensor's operating range (40-500 mg/dL).
     */
    public boolean isValid() {
        return errorCode == 0
            && glucoseMgdl >= 40.0
            && glucoseMgdl <= 500.0;
    }

    /**
     * Whether the trend rate has been computed and is available.
     *
     * <p>The trend rate requires at least 12 readings with proper spacing.
     * Before that, {@link #getTrendRateMgdlPerMin()} returns {@code 100.0}
     * as a sentinel value.
     */
    public boolean isTrendAvailable() {
        return trendRate != 100.0;
    }

    /**
     * Whether calibration data is available for this reading.
     */
    public boolean isCalibrationAvailable() {
        return calAvailableFlag != 0;
    }

    /**
     * Sensor stage: 0 = warmup, 1 = steady state.
     *
     * <p>During warmup (stage 0), glucose values may be less accurate.
     * The transition to stage 1 happens after the warmup period defined
     * in the sensor's factory calibration parameters.
     */
    public int getStage() {
        return stage;
    }

    /**
     * Six smoothed historical glucose values (mg/dL) from the
     * Savitzky-Golay filter. Returns a defensive copy.
     */
    public double[] getSmoothedGlucose() {
        return smoothedGlucose.clone();
    }

    /**
     * Sequence numbers corresponding to each smoothed glucose value.
     * Returns a defensive copy.
     */
    public int[] getSmoothedSeq() {
        return smoothedSeq.clone();
    }

    /**
     * Fixed-point flags for each smoothed glucose value.
     * Returns a defensive copy.
     */
    public int[] getSmoothedFixedFlag() {
        return smoothedFixedFlag.clone();
    }

    @Override
    public String toString() {
        return String.format(java.util.Locale.US,
            "CalibrationResult{glucose=%.1f mg/dL, trend=%.2f mg/dL/min, "
            + "error=0x%02X, stage=%d, valid=%s}",
            glucoseMgdl, trendRate, errorCode, stage, isValid());
    }
}
