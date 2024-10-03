as = nasm
as_flags = -f elf -O0 # remove optimizations for sanity sakes

cc = gcc
cc_flags = -m32 -ffreestanding -I./sector2/ -nostdlib -nodefaultlibs -nostdinc -fno-exceptions -O0 -fno-pic -fno-pie

ld = ld
ld_flags = --oformat binary -m elf_i386 -T ldscripts/stage2.ld

asm_sources = $(shell find sector2/ -name '*.asm')
asm_includes = $(shell find sector2/ -name '*.inc')
asm_objects = $(asm_sources:.asm=.o)

c_sources = $(shell find sector2/ -name '*.c')
c_objects = $(c_sources:.c=.o)

sector_2 = ${asm_objects} ${c_objects}

all: boot.img

# link
sector1/boot.bin: sector1/boot.asm
	${as} -f bin $< -o $@

sector2/kernel.bin: ${sector_2}
	${ld} ${ld_flags} -o $@  $^

# compile
%.o: %.asm ${asm_includes}
	${as} ${as_flags} $< -o $@

%.o: %.c
	${cc} ${cc_flags} -c $< -o $@


# create image
boot.img: sector1/boot.bin sector2/kernel.bin
	cat $^ > $@

boot.iso: boot.img
	dd if=$< of=$@ bs=2048 conv=sync

cleanobj: ${sector_2}
	rm ${sector_2}