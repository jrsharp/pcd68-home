#!/bin/bash -xe

m68k-unknown-elf-gcc -Os -s -g -o pcd68home pcd68home.S -nostdlib -fomit-frame-pointer -lc -lm -mno-rtd -m68000 -msoft-float -mpcrel -T pcd68.lds

m68k-unknown-elf-objcopy -O binary pcd68home program.bin
m68k-unknown-elf-objcopy -O ihex pcd68home program.hex
