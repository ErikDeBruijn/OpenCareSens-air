package com.opencaresens.air.model;

/**
 * Per-reading CGM input — raw sensor data for one measurement (74 bytes packed in C).
 * Maps to air1_opcal4_cgm_input_t.
 */
public class CgmInput {
    public int seqNumber;
    public long measurementTimeStandard;
    public int[] workout;
    public double temperature;

    public CgmInput() {
        workout = new int[30];
    }
}
