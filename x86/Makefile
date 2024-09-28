



1: sector1/boot.s
	as sector1/boot.s -o sector1/boot.o
	ld -o sector1/boot.bin -Ttext 0x7C00 --oformat binary sector1/boot.o

img:
	dd if=sector1/boot.bin of=sector1/boot.img bs=512 count=1

iso:
	mkdir -p iso/boot
	cp sector1/boot.bin iso/boot/boot.bin
	genisoimage -o sector1/boot.iso -b boot/boot.bin -no-emul-boot -boot-load-size 4 -boot-info-table iso

test1: sector1/boot.img
	qemu-system-x86_64 -drive format=raw,file=sector1/boot.img


# 2:
