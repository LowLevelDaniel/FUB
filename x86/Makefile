all: boot.img

AS = as
OTHER_AS = nasm
LD = ld

sector1/boot.bin: sector1/boot.s
	${AS} sector1/boot.s -o sector1/boot.o
	${LD} -o $@ -Ttext 0x7C00 --oformat binary sector1/boot.o

SOURCES = $(shell find sector2/cpu sector2/drivers sector2/include sector2/kernel sector2/libc -name '*.c')
HEADERS = $(shell find sector2/cpu sector2/drivers sector2/include sector2/kernel sector2/libc -name '*.h')
CFLAGS = -ffreestanding -Wall -Wextra -fno-exceptions -m32 -std=c11 -fno-stack-protector -fno-pic -fno-pie -O0
OBJ = ${SOURCES:.c=.o}
CC = gcc

sector2/main.bin: sector2/cpu/interrupt.asm sector1/kernel_entry.s ${OBJ}
	${AS} --32 sector1/kernel_entry.s -o sector1/kernel_entry.o
	${OTHER_AS} -f elf sector2/cpu/interrupt.asm -o sector2/cpu/interrupt.o
	${LD} -no-pie -m elf_i386 -o $@ -Ttext 0x1000 ${OBJ} sector2/cpu/interrupt.o sector1/kernel_entry.o --oformat binary

test_sector2/main.bin: test_sector2/main.s
	${AS} test_sector2/main.s -o sector1/kernel_entry.o
	${LD} --oformat binary -o $@ -Ttext 0x1000 sector1/kernel_entry.o

boot.img: sector1/boot.bin sector2/main.bin
	dd if=sector1/boot.bin of=boot.img bs=512 count=1
	dd if=sector2/main.bin of=boot.img bs=512 seek=1

testboot.img: sector1/boot.bin test_sector2/main.bin
	dd if=sector1/boot.bin      of=testboot.img bs=512 count=1
	dd if=test_sector2/main.bin of=testboot.img bs=512 seek=1

itest: boot.img
	qemu-system-i386 -drive format=raw,file=boot.img -nographic -s
test: boot.img
	qemu-system-x86_64 -drive format=raw,file=boot.img -nographic -s

itestboot: testboot.img
	qemu-system-i386 -drive format=raw,file=testboot.img -nographic -s
testboot: testboot.img
	qemu-system-x86_64 -drive format=raw,file=testboot.img -nographic -s

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -c $< -o $@

boot.iso: boot.img
	ccd2iso $< $@
testboot.iso: testboot.img
	ccd2iso $< $@
