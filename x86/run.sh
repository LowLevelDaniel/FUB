#!/bin/sh

# Check if an argument is provided
if [ $# -eq 0 ]; then
  qemu-system-x86_64 -drive format=raw,file=boot.img -nographic -s
  exit 0
fi

# Check if the argument is equal to 32
if [ "$1" -eq 32 ]; then
  qemu-system-i386 -drive format=raw,file=boot.img -nographic -s
else
  qemu-system-x86_64 -drive format=raw,file=boot.img -nographic -s
fi
exit 0