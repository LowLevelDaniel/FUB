



1: sector1/boot.as
	as sector1/boot.as -o sector1/boot.o
	ld -o sector1/boot.bin -Ttext 0x7C00 --oformat binary sector1/boot.o
	dd if=sector1/boot.bin of=sector1/boot.img bs=512 count=1

test1: sector1/boot.img
	qemu-system-x86_64 -drive format=raw,file=sector1/boot.img


# 2:
