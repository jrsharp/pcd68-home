#!/bin/bash -xe

m68k-unknown-elf-gcc -O0 -s -g -o pcd68home pcd68home.S -nostdlib -fomit-frame-pointer -mno-rtd -m68000 -msoft-float -mpcrel -T pcd68.lds

m68k-unknown-elf-objcopy -O binary pcd68home program.bin
m68k-unknown-elf-objcopy -O ihex pcd68home program.hex
