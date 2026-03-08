#ifndef CARESENS_SIGNAL_PROCESSING_H
#define CARESENS_SIGNAL_PROCESSING_H

#include "calibration.h"

/* Savitzky-Golay smoothing with 7 weights from dev_info->w_sg_x100. */
void smooth_sg(const double *sig_in, const uint16_t *seq_in, const uint8_t *frep_in,
               double *sig_out, uint16_t *seq_out, uint8_t *frep_out,
               double new_sig, uint16_t new_seq, uint8_t new_frep,
               const uint8_t *w_sg_x100);

/* Weighted least-squares recalibration. */
void regress_cal(const double *input, const double *output,
                 const double *slope_arr, const double *ycept_arr,
                 uint8_t n, double new_input, double new_output,
                 double *new_slope, double *new_ycept,
                 double *result_input, double *result_output,
                 double *result_slope, double *result_ycept);

/* Parallelogram boundary check for slope/intercept validity. Returns 1 if valid. */
uint8_t check_boundary(double slope, double ycept,
                       double slope_min, double slope_max,
                       double ycept_min, double ycept_max,
                       double corner_offset);

/* Simple exponential smoothing. */
void apply_simple_smooth(double *buffer, uint16_t n, double alpha);

/* Hann-window + Fourier smoothing for err16 drift detection. */
void smooth1q_err16(const double *in, double *out, uint16_t n, uint16_t window);

/* Error threshold calculation. */
void cal_threshold(int16_t *n_ptr, double *mean_ptr, double *max_ptr,
                   uint8_t *flag_ptr, uint32_t seq, int mode,
                   double value, double abs_value,
                   double running_mean, double running_max,
                   uint16_t threshold_seq, uint8_t multi1, uint8_t multi2);

/* err1 trio state update. */
void err1_TD_trio_update(double *dst_trio, uint32_t *dst_time,
                         uint8_t *dst_flag, double *src_trio,
                         uint32_t *src_time, uint8_t *src_flag,
                         uint8_t *break_flag, uint8_t *break_flag2);

/* err1 variance state update. */
void err1_TD_var_update(uint16_t *dst_seq, double *dst_val,
                        uint32_t *dst_time, uint16_t *dst_count,
                        double *src_val, uint32_t *src_time,
                        uint16_t *src_count);

/*
 * LOESS pipeline: converts tran_inA[30] to tran_inA_1min[5].
 *
 * Maintains state in history60 (LOESS), prev3 (FIR overlap),
 * prev5_raw/prev5_corrected/outlier_fifo (Hampel filter).
 *
 * Algorithm: Hampel outlier filter → IRLS LOESS → running median →
 *            FIR filter → cal_average_without_min_max.
 */
void compute_tran_inA_1min(const double *tran_inA,
                           double *tran_inA_1min,
                           double *history60,
                           double *prev3,
                           double *prev5_raw,
                           double *prev5_corrected,
                           int8_t *outlier_fifo,
                           uint32_t call_count,
                           double time_gap);

#endif
