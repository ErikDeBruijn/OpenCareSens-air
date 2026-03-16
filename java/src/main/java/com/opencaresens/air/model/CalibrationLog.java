package com.opencaresens.air.model;

/**
 * Calibration log entry — one per BG calibration event (104 bytes in C).
 * Maps to air1_opcal4_cal_log_t.
 */
public class CalibrationLog {
    public int group;
    public long bgTime;
    public double bgSeq;
    public double cgSeq1m;
    public int cgIdx;
    public double bgUser;
    public double cslopePrev;
    public double cyceptPrev;
    public int bgValid;
    public double bgCal;
    public double cgCal;
    public double cslopeNew;
    public double cyceptNew;
    public int inlierFlg;
}
