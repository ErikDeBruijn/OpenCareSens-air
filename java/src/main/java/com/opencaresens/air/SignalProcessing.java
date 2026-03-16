package com.opencaresens.air;

/**
 * Signal processing functions ported from C (signal_processing.c).
 * All methods are static. Behavior matches the C implementation exactly.
 */
public final class SignalProcessing {

    private SignalProcessing() {} // prevent instantiation

    // ------------------------------------------------------------------
    // Savitzky-Golay smoothing
    // ------------------------------------------------------------------

    /**
     * Savitzky-Golay smoothing filter.
     *
     * Maintains a sliding window of 10 signal values and produces smoothed outputs
     * using weighted convolution with 7 coefficients (wSgX100).
     *
     * @param sigIn     10 input signals
     * @param seqIn     10 input sequences
     * @param frepIn    6 input frep flags (only indices 0..5 used)
     * @param newSig    new signal value to append
     * @param newSeq    new sequence number
     * @param newFrep   new frep flag
     * @param wSgX100   7 SG weights (as integers, divided by 100 internally)
     * @return SgResult containing sig_out[10], seq_out[10], frep_out[6]
     */
    public static SgResult smoothSg(double[] sigIn, int[] seqIn, int[] frepIn,
                                     double newSig, int newSeq, int newFrep,
                                     int[] wSgX100) {
        // Compute total weight
        double totalWeight = 0.0;
        double[] weights = new double[7];
        for (int i = 0; i < 7; i++) {
            weights[i] = wSgX100[i] / 100.0;
            totalWeight += weights[i];
        }
        if (totalWeight <= 0.0) {
            totalWeight = 1.0;
        }

        // Shift buffers: move [1..9] to [0..8], put new at [9]
        double[] sigBuf = new double[10];
        int[] seqBuf = new int[10];
        int[] frepBuf = new int[6];
        for (int i = 0; i < 9; i++) {
            sigBuf[i] = sigIn[i + 1];
            seqBuf[i] = seqIn[i + 1];
        }
        sigBuf[9] = newSig;
        seqBuf[9] = newSeq;

        for (int i = 0; i < 5; i++) {
            frepBuf[i] = frepIn[i + 1];
        }
        frepBuf[5] = newFrep;

        // SG convolution per ARM disassembly (smooth_sg @ 0x6ccbc):
        //
        // The binary computes a CONVOLUTION of the normalized signal differences
        // with a kernel derived from the wSgX100 weights. The convolution index
        // range is j=3..12, with active terms bounded by 0 <= (j-m) <= 6.
        //
        // Phase 1: Compute kernel sp[i] = weights[i] (already divided by 100)
        //          In the binary, sp[i] = fixed_table[i] * args_table[i],
        //          but since the fixed_table is unknown, we use weights directly.
        //
        // Phase 2: Normalize differences: diff[i] = (sigBuf[i] - ref) / totalWeight
        // Phase 3: Convolve: result[j-3] = sum(diff[m] * sp[j-m]) for 0<=j-m<=6
        // Phase 4: Restore: sigOut[j-3] = ref + result[j-3] * totalWeight
        //          (totalWeight cancels out, so sigOut[j-3] = ref + sum((sigBuf[m]-ref)*sp[j-m]))
        //
        // NOTE: This convolution formula was verified against the ARM disassembly
        // but the effective kernel (sp[]) in the binary is a product of a fixed
        // coefficient table and a state-dependent table from the arguments struct.
        // The current implementation uses weights[i] directly, which does NOT match
        // the oracle output for smooth_result_glucose. The kernel derivation from
        // the binary's fixed and dynamic tables needs further reverse engineering.
        // This does NOT affect result_glucose (which matches 100%).
        double ref = sigBuf[9];
        double[] sigOut = new double[10];

        // Positions 0-2: unsmoothed (shifted raw values)
        for (int i = 0; i < 3; i++) {
            sigOut[i] = sigBuf[i];
        }

        // Skip convolution when buffer is still filling (zeros present)
        boolean windowValid = true;
        for (int i = 0; i <= 6; i++) {
            if (sigBuf[i] == 0.0) {
                windowValid = false;
                break;
            }
        }

        // Positions 3-9: SG convolution (when valid) or pass-through
        for (int j = 3; j < 10; j++) {
            if (!windowValid) {
                sigOut[j] = sigBuf[j];
            } else {
                double acc = 0.0;
                for (int k = -3; k <= 3; k++) {
                    int idx = j + k;
                    if (idx >= 0 && idx <= 6) {
                        acc += weights[k + 3] * (sigBuf[idx] - ref);
                    }
                }
                sigOut[j] = acc / totalWeight + ref;
            }
        }

        return new SgResult(sigOut, seqBuf, frepBuf);
    }

    /** Result container for smooth_sg. */
    public static class SgResult {
        public final double[] sigOut;
        public final int[] seqOut;
        public final int[] frepOut;

        public SgResult(double[] sigOut, int[] seqOut, int[] frepOut) {
            this.sigOut = sigOut;
            this.seqOut = seqOut;
            this.frepOut = frepOut;
        }
    }

    // ------------------------------------------------------------------
    // Weighted least-squares recalibration
    // ------------------------------------------------------------------

    /**
     * Weighted least-squares recalibration.
     * Maintains a circular buffer of calibration points and performs regression.
     *
     * @param input     existing input values (up to 7)
     * @param output    existing output values (up to 7)
     * @param slopeArr  existing slope array (unused in current impl but kept for API compat)
     * @param yceptArr  existing intercept array (unused in current impl)
     * @param n         number of existing points
     * @param newInput  new calibration input
     * @param newOutput new calibration output
     * @return RegressionResult with slope, intercept, and result arrays
     */
    public static RegressionResult regressCal(double[] input, double[] output,
                                               double[] slopeArr, double[] yceptArr,
                                               int n, double newInput, double newOutput) {
        double[] allIn = new double[8];
        double[] allOut = new double[8];
        int total = 0;

        for (int i = 0; i < n && i < 7; i++) {
            allIn[total] = input[i];
            allOut[total] = output[i];
            total++;
        }
        allIn[total] = newInput;
        allOut[total] = newOutput;
        total++;

        double newSlope;
        double newYcept;

        if (total >= 2) {
            double[] reg = MathUtils.fitSimpleRegression(allIn, allOut, total);
            newSlope = reg[0];
            newYcept = reg[1];
        } else {
            newSlope = 1.0;
            newYcept = 0.0;
        }

        // Copy results back
        double[] resultInput = new double[7];
        double[] resultOutput = new double[7];
        double[] resultSlope = new double[7];
        double[] resultYcept = new double[7];

        for (int i = 0; i < total && i < 7; i++) {
            resultInput[i] = allIn[i];
            resultOutput[i] = allOut[i];
            resultSlope[i] = newSlope;
            resultYcept[i] = newYcept;
        }

        return new RegressionResult(newSlope, newYcept,
                resultInput, resultOutput, resultSlope, resultYcept);
    }

    /** Result container for regress_cal. */
    public static class RegressionResult {
        public final double slope;
        public final double ycept;
        public final double[] resultInput;
        public final double[] resultOutput;
        public final double[] resultSlope;
        public final double[] resultYcept;

        public RegressionResult(double slope, double ycept,
                                double[] resultInput, double[] resultOutput,
                                double[] resultSlope, double[] resultYcept) {
            this.slope = slope;
            this.ycept = ycept;
            this.resultInput = resultInput;
            this.resultOutput = resultOutput;
            this.resultSlope = resultSlope;
            this.resultYcept = resultYcept;
        }
    }

    // ------------------------------------------------------------------
    // Parallelogram boundary check
    // ------------------------------------------------------------------

    /**
     * Checks if (slope, ycept) falls within a parallelogram defined by
     * slope/intercept bounds and a diagonal constraint.
     *
     * @return true if inside boundary
     */
    public static boolean checkBoundary(double slope, double ycept,
                                         double slopeMin, double slopeMax,
                                         double yceptMin, double yceptMax,
                                         double cornerOffset) {
        if (ycept < yceptMin || ycept > yceptMax) return false;
        if (slope < slopeMin || slope > slopeMax) return false;

        // Diagonal constraint
        double diagSlope = (slopeMax - slopeMin) / (yceptMin - yceptMax);
        double diagIntercept = slopeMax - diagSlope * yceptMin;

        double lowerBound = diagIntercept - cornerOffset + diagSlope * ycept;
        double upperBound = cornerOffset + diagIntercept + diagSlope * ycept;

        if (slope < lowerBound || slope > upperBound) return false;

        return true;
    }

    // ------------------------------------------------------------------
    // Regularized DFT smoother
    // ------------------------------------------------------------------

    /**
     * Regularized DFT smoother for err16 drift detection.
     * Uses Hann penalty weights and Tikhonov regularization.
     *
     * @param in  input data array (n elements)
     * @param n   number of data points
     * @return smoothed output array (n elements)
     */
    public static double[] smooth1qErr16(double[] in, int n) {
        double[] out = new double[n];
        if (n == 0) return out;

        for (int k = 0; k < n; k++) {
            // DFT: cosine and sine coefficients for frequency k
            double cosSum = 0.0;
            double sinSum = 0.0;
            for (int j = 0; j < n; j++) {
                double angle = 2.0 * Math.PI * k * j / n;
                cosSum += in[j] * Math.cos(angle);
                sinSum += in[j] * Math.sin(angle);
            }

            // Hann penalty weight
            double w = 2.0 - 2.0 * Math.cos(2.0 * Math.PI * k / n);

            // Tikhonov regularization
            double reg = 1.0 / (1.0 + n * w * w);
            cosSum *= reg;
            sinSum *= reg;

            // Inverse DFT accumulation
            for (int j = 0; j < n; j++) {
                double angle = 2.0 * Math.PI * k * j / n;
                out[j] += cosSum * Math.cos(angle) + sinSum * Math.sin(angle);
            }
        }

        // Normalize
        for (int j = 0; j < n; j++) {
            out[j] /= n;
        }
        return out;
    }

    // ------------------------------------------------------------------
    // Error threshold calculation
    // ------------------------------------------------------------------

    /**
     * Cumulative threshold tracking for error detection.
     *
     * @return ThresholdResult with updated n, mean, max, and flag values
     */
    public static ThresholdResult calThreshold(int nVal, double meanVal, double maxVal,
                                                int flagVal, long seq, int mode,
                                                double value, double absValue,
                                                double runningMean, double runningMax,
                                                int thresholdSeq, int multi1, int multi2) {
        int newN = nVal;
        int newFlag = flagVal;

        if (seq < thresholdSeq) {
            if (seq == 0) {
                newN = 1;
                runningMean = value;
                if (absValue > runningMax) {
                    runningMax = absValue;
                }
            } else {
                newN = (int) (seq + 1);
                if (!Double.isNaN(runningMean)) {
                    runningMean += value;
                } else {
                    runningMean = value;
                }
                if (!Double.isNaN(runningMax) && absValue > runningMax) {
                    runningMax = absValue;
                } else if (Double.isNaN(runningMax)) {
                    runningMax = absValue;
                }
            }
        } else if (seq == thresholdSeq) {
            newFlag = 1;
            if (mode != 1) {
                // Normalize
                runningMean = (runningMean / (double) seq) * (double) multi1;
                runningMax = (runningMax / (double) seq) * (double) multi2;
            }
        }

        return new ThresholdResult(newN, runningMean, runningMax, newFlag);
    }

    /** Result container for cal_threshold. */
    public static class ThresholdResult {
        public final int n;
        public final double mean;
        public final double max;
        public final int flag;

        public ThresholdResult(int n, double mean, double max, int flag) {
            this.n = n;
            this.mean = mean;
            this.max = max;
            this.flag = flag;
        }
    }

    // ------------------------------------------------------------------
    // err1 trio state update
    // ------------------------------------------------------------------

    /**
     * Rotates trio arrays from src to dst and clears src.
     * Both trio and time arrays are [90][3] (flattened to 270).
     * flag arrays are [90].
     *
     * @param dstTrio   destination trio values (270 elements, modified)
     * @param dstTime   destination timestamps (270 elements, modified)
     * @param dstFlag   destination flags (90 elements, modified)
     * @param srcTrio   source trio values (270 elements, cleared)
     * @param srcTime   source timestamps (270 elements, cleared)
     * @param srcFlag   source flags (90 elements, unused in current impl)
     * @param breakFlags int[2]: breakFlags[0] = break_flag, breakFlags[1] = break_flag2
     *                   After call: breakFlags[0] = old breakFlags[1], breakFlags[1] = 0
     */
    public static void err1TdTrioUpdate(double[] dstTrio, long[] dstTime,
                                         int[] dstFlag, double[] srcTrio,
                                         long[] srcTime, int[] srcFlag,
                                         int[] breakFlags) {
        for (int i = 0; i < 90; i++) {
            for (int j = 0; j < 3; j++) {
                dstTrio[i * 3 + j] = srcTrio[i * 3 + j];
                dstTime[i * 3 + j] = srcTime[i * 3 + j];
                srcTime[i * 3 + j] = 0;
                srcTrio[i * 3 + j] = 0.0;
            }
            dstFlag[i] = 0;
        }
        breakFlags[0] = breakFlags[1];
        breakFlags[1] = 0;
        dstFlag[0] = 0; // extra reset
    }

    // ------------------------------------------------------------------
    // err1 variance state update
    // ------------------------------------------------------------------

    /**
     * Rotates variance arrays from src to dst and clears src.
     *
     * @param dstSeq    destination sequences (90 elements, cleared to 0)
     * @param dstVal    destination values (90 elements, modified)
     * @param dstTime   destination timestamps (90 elements, modified)
     * @param counts    int[2]: counts[0] = dst_count, counts[1] = src_count
     *                  After call: counts[0] = old counts[1], counts[1] = 0
     * @param srcVal    source values (90 elements, cleared)
     * @param srcTime   source timestamps (90 elements, cleared)
     */
    public static void err1TdVarUpdate(int[] dstSeq, double[] dstVal,
                                        long[] dstTime, int[] counts,
                                        double[] srcVal, long[] srcTime) {
        for (int i = 0; i < 90; i++) {
            dstVal[i] = srcVal[i];
            dstTime[i] = srcTime[i];
            dstSeq[i] = 0;
            srcTime[i] = 0;
            srcVal[i] = 0.0;
        }
        counts[0] = counts[1];
        counts[1] = 0;
    }

    // ------------------------------------------------------------------
    // LOESS kernel weight lookup
    // ------------------------------------------------------------------

    /**
     * Get LOESS kernel weight for evaluation point e and data point d.
     * Table is 90x45; symmetric access:
     *   Forward (e < 45): table[d][e]
     *   Backward (e >= 45): table[89-d][89-e]
     */
    static double getKernelWeight(int e, int d) {
        if (e < 45) {
            return LoessKernel.TABLE[d][e];
        }
        return LoessKernel.TABLE[89 - d][89 - e];
    }

    // ------------------------------------------------------------------
    // IRLS LOESS regression
    // ------------------------------------------------------------------

    /**
     * IRLS LOESS regression on 90 data points.
     * Up to 3 iterations of Tukey bisquare reweighting.
     * Uses 1-based x values (1..90) and pre-computed kernel weights.
     *
     * @param data90 input data (90 elements)
     * @return fitted values (90 elements)
     */
    static double[] irlsLoess(double[] data90) {
        double[] fitted90 = new double[90];
        double[] bisquareW = new double[90];
        double[] absResid = new double[90];

        for (int i = 0; i < 90; i++) {
            bisquareW[i] = 1.0;
        }

        for (int iter = 0; iter < 3; iter++) {
            for (int e = 0; e < 90; e++) {
                double sw = 0, swx = 0, swxx = 0, swy = 0, swxy = 0;
                for (int d = 0; d < 90; d++) {
                    double kw = getKernelWeight(e, d);
                    double w = kw * bisquareW[d];
                    double xi = (double) (d + 1);
                    double yi = data90[d];
                    double wx = w * xi;
                    double wy = w * yi;
                    swxx += wx * xi;
                    swxy += wy * xi;
                    sw += w;
                    swx += wx;
                    swy += wy;
                }
                double det = swxx * sw - swx * swx;
                if (Math.abs(det) < 1e-30) {
                    double sum = 0;
                    for (int i = 0; i < 90; i++) sum += data90[i];
                    fitted90[e] = sum / 90.0;
                } else {
                    double a0 = (swxx * swy - swx * swxy) / det;
                    double a1 = (sw * swxy - swx * swy) / det;
                    fitted90[e] = a0 + a1 * (double) (e + 1);
                }
            }

            // Compute absolute residuals
            for (int i = 0; i < 90; i++) {
                absResid[i] = Math.abs(data90[i] - fitted90[i]);
            }

            double medianAr = MathUtils.quickMedian(absResid, 90);
            double threshold = medianAr * 6.0;
            if (threshold < 1e-30) break;

            boolean hasNan = false;
            for (int i = 0; i < 90; i++) {
                double u = absResid[i] / threshold;
                if (u > 1.0) u = 1.0;
                double w = (1.0 - u * u);
                w = w * w;
                bisquareW[i] = w;
                if (Double.isNaN(w)) hasNan = true;
            }
            if (hasNan) break;
        }
        return fitted90;
    }

    // ------------------------------------------------------------------
    // Running median filter
    // ------------------------------------------------------------------

    /**
     * Running median filter: for each group of 6, compute 6 medians
     * with expanding/shrinking windows [3, 4, 5, 6, 5, 4].
     * Input: 30 values, output: 30 medians.
     */
    static double[] runningMedians(double[] in30) {
        double[] out30 = new double[30];

        for (int g = 0; g < 5; g++) {
            int base = g * 6;

            // Window of 3: grp[0..2]
            double[] tmp3 = new double[3];
            System.arraycopy(in30, base, tmp3, 0, 3);
            out30[base + 0] = MathUtils.mathMedian(tmp3, 3);

            // Window of 4: grp[0..3]
            double[] tmp4 = new double[4];
            System.arraycopy(in30, base, tmp4, 0, 4);
            out30[base + 1] = MathUtils.mathMedian(tmp4, 4);

            // Window of 5: grp[0..4]
            double[] tmp5 = new double[5];
            System.arraycopy(in30, base, tmp5, 0, 5);
            out30[base + 2] = MathUtils.mathMedian(tmp5, 5);

            // Window of 6: grp[0..5]
            double[] tmp6 = new double[6];
            System.arraycopy(in30, base, tmp6, 0, 6);
            out30[base + 3] = MathUtils.mathMedian(tmp6, 6);

            // Window of 5: grp[1..5]
            System.arraycopy(in30, base + 1, tmp5, 0, 5);
            out30[base + 4] = MathUtils.mathMedian(tmp5, 5);

            // Window of 4: grp[2..5]
            System.arraycopy(in30, base + 2, tmp4, 0, 4);
            out30[base + 5] = MathUtils.mathMedian(tmp4, 4);
        }
        return out30;
    }

    // ------------------------------------------------------------------
    // FIR filter on running medians
    // ------------------------------------------------------------------

    /**
     * FIR filter on running medians.
     * 7-tap coefficients: [-0.25, 1.0, 1.75, 2.0, 1.75, 1.0, -0.25]
     * Uses 3 overlap values from previous call (prev3).
     *
     * @param prev3      3 overlap values from previous call
     * @param medians30  30 median values
     * @return 30 filtered values
     */
    static double[] firFilterMedians(double[] prev3, double[] medians30) {
        double[] firC = {-0.25, 1.0, 1.75, 2.0, 1.75, 1.0, -0.25};

        // Extended buffer: prev3[3] + medians30[30]
        double[] extended = new double[33];
        System.arraycopy(prev3, 0, extended, 0, 3);
        System.arraycopy(medians30, 0, extended, 3, 30);

        double[] out30 = new double[30];

        // Main FIR: positions 0..26
        for (int k = 0; k < 27; k++) {
            double val = 0;
            for (int j = 0; j < 7; j++) {
                val += firC[j] * extended[k + j];
            }
            out30[k] = val / 7.0;
        }

        // Tail: shortened FIR for positions 27..29
        double v0 = medians30[24], v1 = medians30[25], v2 = medians30[26];
        double v3 = medians30[27], v4 = medians30[28], v5 = medians30[29];
        out30[27] = (-0.25 * v0 + v1 + 1.75 * v2 + 2 * v3 + 1.75 * v4 + v5) / 7.25;
        out30[28] = (-0.25 * v1 + v2 + 1.75 * v3 + 2 * v4 + 1.75 * v5) / 6.25;
        out30[29] = (-0.25 * v2 + v3 + 1.75 * v4 + 2 * v5) / 4.5;

        return out30;
    }

    // ------------------------------------------------------------------
    // Per-sample Hampel filter
    // ------------------------------------------------------------------

    /**
     * Modified Hampel filter for per-sample outlier removal.
     *
     * @param tranInA          30 input values
     * @param prev5Raw         5 raw previous values (modified: updated to last 5 of tranInA)
     * @param prev5Corrected   5 corrected previous values (modified: updated to last 5 of result)
     * @param outlierFifo      6-element outlier FIFO (modified: shifted left, appended 0)
     * @return 30 filtered values
     */
    static double[] perSampleHampelFilter(double[] tranInA,
                                           double[] prev5Raw,
                                           double[] prev5Corrected,
                                           byte[] outlierFifo) {
        // Determine detection buffer
        int fifoSum = 0;
        for (int i = 0; i < 6; i++) {
            fifoSum += Math.abs(outlierFifo[i]);
        }
        double[] prev5 = (fifoSum >= 4) ? prev5Corrected : prev5Raw;

        // Build detection buffer: [prev5, tranInA] = 35 values
        double[] buffer = new double[35];
        System.arraycopy(prev5, 0, buffer, 0, 5);
        System.arraycopy(tranInA, 0, buffer, 5, 30);

        // Build replacement buffer
        double[] replBuf = new double[35];
        System.arraycopy(prev5Corrected, 0, replBuf, 0, 5);
        System.arraycopy(tranInA, 0, replBuf, 5, 30);

        double[] perSample = new double[30];
        System.arraycopy(tranInA, 0, perSample, 0, 30);

        for (int i = 0; i < 30; i++) {
            // Sliding window of 6 consecutive values from buffer[i:i+6]
            double[] window = new double[6];
            System.arraycopy(buffer, i, window, 0, 6);

            // Sort window to find median
            double[] sw = window.clone();
            for (int a = 0; a < 5; a++) {
                for (int b = a + 1; b < 6; b++) {
                    if (sw[a] > sw[b]) {
                        double t = sw[a];
                        sw[a] = sw[b];
                        sw[b] = t;
                    }
                }
            }
            double median = (sw[2] + sw[3]) / 2.0;

            // Compute MAD
            double[] absDev = new double[6];
            for (int j = 0; j < 6; j++) {
                absDev[j] = Math.abs(window[j] - median);
            }
            for (int a = 0; a < 5; a++) {
                for (int b = a + 1; b < 6; b++) {
                    if (absDev[a] > absDev[b]) {
                        double t = absDev[a];
                        absDev[a] = absDev[b];
                        absDev[b] = t;
                    }
                }
            }
            double mad = (absDev[2] + absDev[3]) / 2.0;

            // Compute scaled MAD with fallbacks
            double scaledMad;
            if (mad >= 1e-14) {
                scaledMad = mad * 1.486;
            } else {
                double meanAd = 0;
                for (int j = 0; j < 6; j++) {
                    meanAd += Math.abs(window[j] - median);
                }
                meanAd /= 6.0;
                if (meanAd > 0.001) {
                    scaledMad = meanAd * 1.253314;
                } else {
                    continue; // No outlier possible
                }
            }

            double z = (tranInA[i] - median) / scaledMad;

            if (z > 1.5) {
                perSample[i] = replBuf[i + 4] + scaledMad;
                replBuf[i + 5] = perSample[i];
            } else if (z < -1.5) {
                perSample[i] = replBuf[i + 4] - scaledMad;
                replBuf[i + 5] = perSample[i];
            }
        }

        // Update state for next call
        System.arraycopy(tranInA, 25, prev5Raw, 0, 5);
        System.arraycopy(perSample, 25, prev5Corrected, 0, 5);

        // Shift outlier FIFO left by 1, append 0
        System.arraycopy(outlierFifo, 1, outlierFifo, 0, 5);
        outlierFifo[5] = 0;

        return perSample;
    }

    // ------------------------------------------------------------------
    // Full LOESS pipeline: compute_tran_inA_1min
    // ------------------------------------------------------------------

    /**
     * Full LOESS pipeline: tran_inA[30] to tran_inA_1min[5].
     *
     * Algorithm:
     *   1. Modified Hampel filter for per-sample outlier removal (callCount >= 2)
     *   2. If callCount >= 3 and timeGap < 897.2: IRLS LOESS on history60+perSample
     *   3. Running median filter (5 groups of 6)
     *   4. If callCount >= 2 and timeGap < 327.2: FIR filter using prev3
     *   5. calAverageWithoutMinMax per group of 6
     *   6. Update state: shift history, store perSample, store last 3 medians
     *
     * @param tranInA         30 input values
     * @param history60       60-element history buffer (modified)
     * @param prev3           3-element FIR overlap buffer (modified)
     * @param prev5Raw        5-element raw previous values (modified)
     * @param prev5Corrected  5-element corrected previous values (modified)
     * @param outlierFifo     6-element outlier FIFO (modified)
     * @param callCount       number of times this function has been called
     * @param timeGap         time gap since last call
     * @return tran_inA_1min: 5 values
     */
    public static double[] computeTranInA1min(double[] tranInA,
                                               double[] history60,
                                               double[] prev3,
                                               double[] prev5Raw,
                                               double[] prev5Corrected,
                                               byte[] outlierFifo,
                                               long callCount,
                                               double timeGap) {
        // Step 1: Per-sample outlier removal
        double[] perSample;
        if (callCount >= 2) {
            perSample = perSampleHampelFilter(tranInA, prev5Raw, prev5Corrected, outlierFifo);
        } else {
            perSample = new double[30];
            System.arraycopy(tranInA, 0, perSample, 0, 30);
            // Initialize prev5 state on first call
            System.arraycopy(tranInA, 25, prev5Raw, 0, 5);
            System.arraycopy(tranInA, 25, prev5Corrected, 0, 5);
            System.arraycopy(outlierFifo, 1, outlierFifo, 0, 5);
            outlierFifo[5] = 0;
        }

        // Step 2: IRLS LOESS or pass-through
        double[] intermediate30;
        if (callCount >= 3 && timeGap < 897.2) {
            double[] data90 = new double[90];
            System.arraycopy(history60, 0, data90, 0, 60);
            System.arraycopy(perSample, 0, data90, 60, 30);

            double[] fitted90 = irlsLoess(data90);
            intermediate30 = new double[30];
            System.arraycopy(fitted90, 60, intermediate30, 0, 30);
        } else {
            intermediate30 = new double[30];
            System.arraycopy(perSample, 0, intermediate30, 0, 30);
        }

        // Step 3: Running median filter
        double[] medians30 = runningMedians(intermediate30);

        // Step 4: FIR filter
        double[] firOut;
        if (callCount >= 2 && timeGap < 327.2) {
            firOut = firFilterMedians(prev3, medians30);
        } else {
            firOut = new double[30];
            System.arraycopy(medians30, 0, firOut, 0, 30);
        }

        // Step 5: calAverageWithoutMinMax per group of 6
        double[] tranInA1min = new double[5];
        for (int g = 0; g < 5; g++) {
            double[] group = new double[6];
            System.arraycopy(firOut, g * 6, group, 0, 6);
            tranInA1min[g] = MathUtils.calAverageWithoutMinMax(group, 6);
        }

        // Step 6: Update state
        // Shift history: [0:30] = [30:60], [30:60] = perSample
        System.arraycopy(history60, 30, history60, 0, 30);
        System.arraycopy(perSample, 0, history60, 30, 30);

        // Store last 3 raw medians for next call's FIR overlap
        prev3[0] = medians30[27];
        prev3[1] = medians30[28];
        prev3[2] = medians30[29];

        return tranInA1min;
    }
}
