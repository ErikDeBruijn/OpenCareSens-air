package com.opencaresens.air.model;

/**
 * User calibration list — BG reference values for factory-cal override (751 bytes packed in C).
 * Passed empty for factory-calibration-only mode.
 * Maps to air1_opcal4_cal_list_t.
 */
public class CalibrationList {
    public int[] idx;
    public double[] value;
    public long[] time;
    public int calListLength;
    public int[] calFlag;

    public CalibrationList() {
        idx = new int[50];
        value = new double[50];
        time = new long[50];
        calFlag = new int[50];
    }
}
