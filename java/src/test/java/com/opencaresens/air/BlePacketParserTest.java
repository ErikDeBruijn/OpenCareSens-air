package com.opencaresens.air;

import org.junit.jupiter.api.Test;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests for {@link BlePacketParser}.
 */
class BlePacketParserTest {

    /**
     * Build a synthetic 84-byte BLE C5 packet with known values.
     */
    private static byte[] buildTestPacket(int seq, long time, int battery,
                                          int rawTemp, int deviceError,
                                          int[] adcValues) {
        ByteBuffer buf = ByteBuffer.allocate(BlePacketParser.PACKET_SIZE)
                                   .order(ByteOrder.LITTLE_ENDIAN);
        buf.put((byte) 0xC5);        // reg0
        buf.put((byte) 0x01);        // reg1
        buf.put((byte) deviceError); // deviceErrorCode (int8)
        buf.put((byte) 0x00);        // r_count
        buf.putInt(0);               // a_count
        buf.putInt(0);               // misc
        buf.putInt(seq);             // sequenceNumber
        buf.putInt((int) time);      // time
        buf.putShort((short) battery);    // battery
        buf.putShort((short) rawTemp);    // temperature (raw)
        for (int i = 0; i < 30; i++) {
            buf.putShort((short) (adcValues != null && i < adcValues.length
                                  ? adcValues[i] : 0));
        }
        return buf.array();
    }

    @Test
    void parseKnownPacket() {
        int[] adc = new int[30];
        for (int i = 0; i < 30; i++) {
            adc[i] = 1000 + i;
        }

        byte[] packet = buildTestPacket(
            42,       // sequenceNumber
            1700000000L, // timestamp (2023-11-14)
            3700,     // battery
            3412,     // rawTemp => 34.12 C
            0,        // no device error
            adc
        );

        BlePacketParser.ParsedReading reading = BlePacketParser.parse(packet);

        assertEquals(42, reading.getSequenceNumber());
        assertEquals(1700000000L, reading.getTimestamp());
        assertEquals(3700, reading.getBattery());
        assertEquals(34.12, reading.getTemperature(), 0.001);
        assertEquals(0, reading.getDeviceErrorCode());

        int[] parsed = reading.getAdcSamples();
        assertEquals(30, parsed.length);
        for (int i = 0; i < 30; i++) {
            assertEquals(1000 + i, parsed[i], "ADC sample " + i);
        }
    }

    @Test
    void parseDeviceErrorCode() {
        byte[] packet = buildTestPacket(1, 1000, 0, 3000, -5, null);
        BlePacketParser.ParsedReading reading = BlePacketParser.parse(packet);
        assertEquals(-5, reading.getDeviceErrorCode());
    }

    @Test
    void parseHighTemperature() {
        // rawTemp = 4000 => 40.00 C
        byte[] packet = buildTestPacket(1, 1000, 0, 4000, 0, null);
        BlePacketParser.ParsedReading reading = BlePacketParser.parse(packet);
        assertEquals(40.00, reading.getTemperature(), 0.001);
    }

    @Test
    void parseHighAdcValues() {
        // uint16 max = 65535
        int[] adc = new int[30];
        for (int i = 0; i < 30; i++) {
            adc[i] = 65535;
        }
        byte[] packet = buildTestPacket(1, 1000, 0, 3000, 0, adc);
        BlePacketParser.ParsedReading reading = BlePacketParser.parse(packet);
        for (int v : reading.getAdcSamples()) {
            assertEquals(65535, v);
        }
    }

    @Test
    void adcSamplesAreDefensivelyCopied() {
        byte[] packet = buildTestPacket(1, 1000, 0, 3000, 0, new int[30]);
        BlePacketParser.ParsedReading reading = BlePacketParser.parse(packet);

        int[] first = reading.getAdcSamples();
        first[0] = 99999;
        int[] second = reading.getAdcSamples();
        assertEquals(0, second[0], "Modifying returned array must not affect internal state");
    }

    @Test
    void nullInputThrows() {
        IllegalArgumentException ex = assertThrows(
            IllegalArgumentException.class,
            () -> BlePacketParser.parse(null)
        );
        assertTrue(ex.getMessage().contains("null"));
    }

    @Test
    void shortInputThrows() {
        byte[] tooShort = new byte[83];
        IllegalArgumentException ex = assertThrows(
            IllegalArgumentException.class,
            () -> BlePacketParser.parse(tooShort)
        );
        assertTrue(ex.getMessage().contains("84"));
    }

    @Test
    void exactMinimumSize() {
        byte[] exact = new byte[BlePacketParser.PACKET_SIZE];
        // Should not throw — all zeros is a valid parse
        BlePacketParser.ParsedReading reading = BlePacketParser.parse(exact);
        assertEquals(0, reading.getSequenceNumber());
        assertEquals(0L, reading.getTimestamp());
        assertEquals(0.0, reading.getTemperature(), 0.001);
        assertEquals(30, reading.getAdcSamples().length);
    }

    @Test
    void largerBufferAccepted() {
        // Packets larger than 84 bytes should parse fine (extra bytes ignored)
        byte[] larger = new byte[100];
        BlePacketParser.ParsedReading reading = BlePacketParser.parse(larger);
        assertNotNull(reading);
    }

    @Test
    void toStringContainsKey() {
        byte[] packet = buildTestPacket(7, 2000, 100, 3600, 0, null);
        BlePacketParser.ParsedReading reading = BlePacketParser.parse(packet);
        String s = reading.toString();
        assertTrue(s.contains("seq=7"));
        assertTrue(s.contains("36.00"));
    }
}
