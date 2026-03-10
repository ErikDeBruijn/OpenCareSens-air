#!/usr/bin/env python3
"""
Extract BLE C5 sensor packets from Jaap's data.hpp into a binary file.

Input:  data.hpp with lines like:
  {timestamp,{0xC5,0x01,...}}

Output: binary file with records:
  [uint32_t nowsec][uint16_t pkt_len][pkt_len bytes of BLE data]

Only C5 packets (sensor readings) are extracted; C4 (polling) packets are skipped.
"""

import re
import struct
import sys
import os


def extract_packets(input_path, output_path):
    c5_count = 0
    c4_count = 0

    with open(input_path, 'r') as f:
        content = f.read()

    # Match each {timestamp,{byte,byte,...}} entry
    pattern = re.compile(
        r'\{(\d+),\{((?:0x[0-9A-Fa-f]+,?[\s]*)+)\}\}'
    )

    records = []
    for m in pattern.finditer(content):
        timestamp = int(m.group(1))
        hex_str = m.group(2)
        # Parse hex bytes
        byte_vals = [int(x.strip().rstrip(','), 16) for x in
                     re.findall(r'0x[0-9A-Fa-f]+', hex_str)]
        pkt = bytes(byte_vals)

        if len(pkt) < 2:
            continue

        if pkt[0] == 0xC4:
            c4_count += 1
            continue
        elif pkt[0] == 0xC5:
            c5_count += 1
            records.append((timestamp, pkt))
        # skip anything else

    # Write binary output
    with open(output_path, 'wb') as out:
        # Header: magic + record count
        out.write(b'BLEP')  # magic
        out.write(struct.pack('<I', len(records)))

        for timestamp, pkt in records:
            out.write(struct.pack('<I', timestamp))
            out.write(struct.pack('<H', len(pkt)))
            out.write(pkt)

    print(f"Extracted {c5_count} C5 packets, skipped {c4_count} C4 packets")
    print(f"Written to {output_path} ({os.path.getsize(output_path)} bytes)")
    return c5_count


def main():
    if len(sys.argv) < 2:
        data_hpp = os.path.join(
            os.path.expanduser('~'),
            'github.com/j-kaltes/Juggluco/Common/src/main/cpp/air/tests/data.hpp'
        )
    else:
        data_hpp = sys.argv[1]

    if len(sys.argv) < 3:
        output = os.path.join(
            os.path.dirname(os.path.abspath(__file__)),
            '..', 'build', 'real_data_packets.bin'
        )
    else:
        output = sys.argv[2]

    os.makedirs(os.path.dirname(os.path.abspath(output)), exist_ok=True)
    extract_packets(data_hpp, output)


if __name__ == '__main__':
    main()
