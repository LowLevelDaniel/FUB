#!/bin/sh

# Check if an argument is provided
if [ $# -eq 0 ]; then
  qemu-system-x86_64 -drive format=raw,file=boot.img -nographic -m 4096 
  exit 0
fi

# Check if the argument is equal to 32
if [ "$1" -eq 32 ]; then
  qemu-system-i386 -fda boot.img -nographic
  # qemu-system-i386 -drive format=raw,file=boot.img -nographic
else
  qemu-system-x86_64 -drive format=raw,file=boot.img -nographic -m 4096 
fi
exit 0