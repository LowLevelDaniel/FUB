

all: boot.img

boot.bin: sector1/boot.s
	as sector1/boot.s -o sector1/boot.o
	ld -o sector1/boot.bin -Ttext 0x7C00 --oformat binary sector1/boot.o

main.bin: sector2/main.s
	as sector2/main.s -o sector2/main.o
	ld -o sector2/main.bin -Ttext 0x0 --oformat binary sector2/main.o

boot.img: boot.bin main.bin
	dd if=sector1/boot.bin of=boot.img bs=512 count=1
	dd if=sector2/main.bin of=boot.img bs=512 seek=1

test:
	qemu-system-x86_64 -drive format=raw,file=boot.img -nographic

