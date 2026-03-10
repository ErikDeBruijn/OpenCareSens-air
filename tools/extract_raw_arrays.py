#!/usr/bin/env python3
"""
Extract C byte arrays from Jaap's run6_0.h, run6_1.h, run6_3.h into binary files.

Input:  .h files containing lines like:
  const unsigned char run6_0[446] = {0x1,0xe,...};

Output: raw binary files (device_info.bin, cgm_input_init.bin, arguments_init.bin)
"""

import re
import struct
import sys
import os


def extract_c_array(input_path):
    """Parse a C byte array from a .h file and return raw bytes."""
    with open(input_path, 'r') as f:
        content = f.read()

    # Find all hex and char literals inside the braces
    # Match the array initializer: { ... }
    m = re.search(r'\{(.+)\}', content, re.DOTALL)
    if not m:
        raise ValueError(f"No array initializer found in {input_path}")

    inner = m.group(1)

    byte_vals = []
    # Tokenize: each element is either 0xHH, a decimal, or 'c' (char literal)
    tokens = re.findall(r"0x[0-9A-Fa-f]+|'[^'\\]'|'\\x[0-9A-Fa-f]+'|\d+", inner)
    for tok in tokens:
        if tok.startswith('0x') or tok.startswith('0X'):
            byte_vals.append(int(tok, 16))
        elif tok.startswith("'"):
            # Character literal
            ch = tok.strip("'")
            if ch.startswith('\\x'):
                byte_vals.append(int(ch[2:], 16))
            else:
                byte_vals.append(ord(ch))
        else:
            byte_vals.append(int(tok))

    return bytes(byte_vals)


def main():
    tests_dir = os.path.join(
        os.path.expanduser('~'),
        'github.com/j-kaltes/Juggluco/Common/src/main/cpp/air/tests'
    )
    output_dir = os.path.join(
        os.path.dirname(os.path.abspath(__file__)),
        '..', 'build'
    )
    os.makedirs(output_dir, exist_ok=True)

    files = [
        ('run6_0.h', 'device_info.bin', 446),
        ('run6_1.h', 'cgm_input_init.bin', 74),
        ('run6_3.h', 'arguments_init.bin', 117312),
    ]

    for src_name, dst_name, expected_size in files:
        src_path = os.path.join(tests_dir, src_name)
        dst_path = os.path.join(output_dir, dst_name)

        print(f"Extracting {src_name}...")
        data = extract_c_array(src_path)
        print(f"  Got {len(data)} bytes (expected {expected_size})")
        if len(data) != expected_size:
            print(f"  WARNING: size mismatch!")

        with open(dst_path, 'wb') as f:
            f.write(data)
        print(f"  Written to {dst_path}")


if __name__ == '__main__':
    main()
