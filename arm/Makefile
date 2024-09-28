

1:
	aarch64-linux-gnu-as -o boot.o boot.s
	aarch64-linux-gnu-ld -o boot.efi -Ttext 0x400000 boot.o
	aarch64-linux-gnu-ld -o boot.efi -Ttext 0x400000 boot.o

test1:
	qemu-system-aarch64 -machine virt -cpu cortex-a53 -nographic -bios boot.bin