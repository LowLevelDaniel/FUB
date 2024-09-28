


1:
	arm-none-eabi-as -o sector1/boot.o sector1/boot.s
	arm-none-eabi-ld -Ttext=0x10000 -o sector1/boot.elf sector1/boot.o
	arm-none-eabi-objcopy -O binary sector1/boot.elf sector1/boot.bin
	qemu-img create -f raw sector1/boot.img 64M
	dd if=sector1/boot.bin of=sector1/boot.img bs=512 count=1 conv=notrunc

test1:
	qemu-system-arm -M versatilepb -m 128M -drive file=sector1/boot.img,format=raw -nographic -serial file:output.txt
