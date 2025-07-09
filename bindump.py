#!/usr/bin/env python3
import argparse

def base_int(x):
    return int(x, 0)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('filename')
    parser.add_argument('-g', '--origin', type=base_int, default=0x6000)
    args = parser.parse_args()
    i=args.origin
    with open(args.filename, "rb") as file:
        byte = file.read(1)
        while byte:
            print(f'{i}:\t{int(byte[0])}\t{hex(byte[0])}')
            byte = file.read(1)
            i=i+1

if __name__ == "__main__":
    main()
