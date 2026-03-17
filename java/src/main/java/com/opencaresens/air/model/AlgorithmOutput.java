package com.opencaresens.air.model;

/**
 * Per-reading algorithm output (155 bytes packed in C).
 * Maps to air1_opcal4_output_t.
 */
public class AlgorithmOutput {
    public int seqNumberOriginal;
    public int seqNumberFinal;
    public long measurementTimeStandard;
    public int[] workout;
    public double resultGlucose;
    public double trendrate;
    public int currentStage;
    public int[] smoothFixedFlag;
    public int[] smoothSeq;
    public double[] smoothResultGlucose;
    public int errcode;
    public int calAvailableFlag;
    public int dataType;

    public AlgorithmOutput() {
        workout = new int[30];
        smoothFixedFlag = new int[6];
        smoothSeq = new int[6];
        smoothResultGlucose = new double[6];
    }
}
