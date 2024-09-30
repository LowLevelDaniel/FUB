



1: sector1/boot.s
	as sector1/boot.s -o sector1/boot.o
	ld -o sector1/boot.bin -Ttext 0x7C00 --oformat binary sector1/boot.o

2: sector2/main.s
	as sector2/main.s -o sector2/main.o
	ld -o sector2/main.bin -Ttext 0x7E00 --oformat binary sector2/main.o

img:
	cat sector1/boot.bin sector2/main.bin > combined.bin
	dd if=combined.bin of=boot.img bs=512 count=2

iso:
	mkdir -p iso/boot
	cp combined.bin iso/boot/boot.bin
	genisoimage -o boot.iso -b boot/boot.bin -no-emul-boot -boot-load-size 4 -boot-info-table iso

test1: sector1/boot.img
	qemu-system-x86_64 -drive format=raw,file=sector1/boot.img -nographic


# 2:
