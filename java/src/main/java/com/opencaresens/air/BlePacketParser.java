package com.opencaresens.air;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

/**
 * Parses raw CareSens Air BLE C5 characteristic notifications into structured
 * readings suitable for {@link CareSensCalibrator#processReading}.
 *
 * <p>The CareSens Air transmits sensor data as 84-byte BLE notifications on the
 * C5 characteristic. This parser decodes the packed little-endian binary format
 * into a {@link ParsedReading} with all fields needed by the calibration pipeline.
 *
 * <p>Usage:
 * <pre>{@code
 * // In BLE notification callback:
 * BlePacketParser.ParsedReading reading = BlePacketParser.parse(bleNotificationBytes);
 * CalibrationResult result = calibrator.processReading(
 *     reading.getSequenceNumber(),
 *     reading.getTimestamp(),
 *     reading.getAdcSamples(),
 *     reading.getTemperature()
 * );
 * }</pre>
 *
 * <p>Packet layout (84 bytes, packed, little-endian):
 * <pre>
 * Offset  Size  Type      Field
 * ------  ----  --------  ----------------
 *  0       1    uint8     reg0 (0xC5)
 *  1       1    uint8     reg1
 *  2       1    int8      deviceErrorCode
 *  3       1    uint8     r_count
 *  4       4    uint32    a_count
 *  8       4    uint32    misc
 * 12       4    uint32    sequenceNumber
 * 16       4    uint32    time (Unix seconds)
 * 20       2    uint16    battery
 * 22       2    uint16    temperature (raw, /100 for Celsius)
 * 24      60    uint16[30] glucose_array (ADC samples)
 * </pre>
 */
public final class BlePacketParser {

    /** Expected size of a complete BLE C5 notification packet. */
    public static final int PACKET_SIZE = 84;

    private BlePacketParser() {
        // Utility class — no instantiation
    }

    /**
     * Parse a CareSens Air BLE C5 notification into components for
     * {@link CareSensCalibrator#processReading}.
     *
     * @param bleData raw bytes from BLE C5 characteristic notification
     * @return parsed reading with all fields extracted
     * @throws IllegalArgumentException if bleData is null or shorter than {@link #PACKET_SIZE} bytes
     */
    public static ParsedReading parse(byte[] bleData) {
        if (bleData == null) {
            throw new IllegalArgumentException("bleData must not be null");
        }
        if (bleData.length < PACKET_SIZE) {
            throw new IllegalArgumentException(
                "bleData must be at least " + PACKET_SIZE + " bytes, got " + bleData.length);
        }

        ByteBuffer buf = ByteBuffer.wrap(bleData).order(ByteOrder.LITTLE_ENDIAN);

        // Offsets 0-3: reg0, reg1, deviceErrorCode, r_count
        // reg0 and reg1 are unsigned bytes
        buf.get();  // reg0 (skip, not needed in ParsedReading)
        buf.get();  // reg1 (skip)
        int deviceErrorCode = buf.get();  // int8 — sign-extended by ByteBuffer.get()
        buf.get();  // r_count (skip)

        // Offsets 4-11: a_count, misc (skip)
        buf.getInt();  // a_count
        buf.getInt();  // misc

        // Offset 12: sequenceNumber (uint32, read as signed int — Java has no unsigned)
        int sequenceNumber = buf.getInt();

        // Offset 16: time (uint32 Unix seconds)
        // Store as long to handle values > Integer.MAX_VALUE correctly
        long timestamp = buf.getInt() & 0xFFFFFFFFL;

        // Offset 20: battery (uint16)
        int battery = buf.getShort() & 0xFFFF;

        // Offset 22: temperature (uint16, raw units of 0.01 degrees Celsius)
        int rawTemperature = buf.getShort() & 0xFFFF;
        double temperature = rawTemperature / 100.0;

        // Offset 24: glucose_array[30] (uint16 each, ADC samples)
        int[] adcSamples = new int[30];
        for (int i = 0; i < 30; i++) {
            adcSamples[i] = buf.getShort() & 0xFFFF;
        }

        return new ParsedReading(sequenceNumber, timestamp, adcSamples,
                                 temperature, battery, deviceErrorCode);
    }

    /**
     * A parsed BLE reading with all fields extracted and ready for
     * {@link CareSensCalibrator#processReading}.
     *
     * <p>This class is immutable. Array accessors return defensive copies.
     */
    public static final class ParsedReading {
        private final int sequenceNumber;
        private final long timestamp;
        private final int[] adcSamples;
        private final double temperature;
        private final int battery;
        private final int deviceErrorCode;

        ParsedReading(int sequenceNumber, long timestamp, int[] adcSamples,
                      double temperature, int battery, int deviceErrorCode) {
            this.sequenceNumber = sequenceNumber;
            this.timestamp = timestamp;
            this.adcSamples = adcSamples.clone();
            this.temperature = temperature;
            this.battery = battery;
            this.deviceErrorCode = deviceErrorCode;
        }

        /**
         * Sensor sequence number. Starts at 1 and increments with each reading.
         */
        public int getSequenceNumber() {
            return sequenceNumber;
        }

        /**
         * Measurement timestamp in Unix seconds (seconds since 1970-01-01 UTC).
         *
         * <p>Returned as {@code long} to correctly represent uint32 values
         * above {@link Integer#MAX_VALUE}.
         */
        public long getTimestamp() {
            return timestamp;
        }

        /**
         * 30 raw ADC sample values from the sensor's glucose array.
         *
         * <p>Returns a defensive copy. Each value is an unsigned 16-bit integer
         * (0-65535) stored as {@code int}.
         */
        public int[] getAdcSamples() {
            return adcSamples.clone();
        }

        /**
         * Skin temperature in degrees Celsius.
         *
         * <p>Converted from the raw uint16 field (units of 0.01 degrees).
         * For example, a raw value of 3412 becomes 34.12 degrees Celsius.
         */
        public double getTemperature() {
            return temperature;
        }

        /**
         * Battery level (raw uint16 value from the sensor).
         */
        public int getBattery() {
            return battery;
        }

        /**
         * Device-reported error code. Zero means no device error.
         *
         * <p>This is the hardware error code from the sensor itself (int8),
         * distinct from the calibration algorithm's error codes in
         * {@link CalibrationResult#getErrorCode()}.
         */
        public int getDeviceErrorCode() {
            return deviceErrorCode;
        }

        @Override
        public String toString() {
            return String.format(java.util.Locale.US,
                "ParsedReading{seq=%d, time=%d, temp=%.2f°C, battery=%d, "
                + "deviceError=%d, adcSamples[0]=%d}",
                sequenceNumber, timestamp, temperature, battery,
                deviceErrorCode, adcSamples[0]);
        }
    }
}
