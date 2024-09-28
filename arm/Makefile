

1: sector1/boot.s
	qemu-img create -f qcow2 main_disk.img 20G
	qemu-img create -f qcow2 varstore.img 64M
	aarch64-linux-gnu-gcc -nostdlib -nostartfiles -o bootloader.efi sector1/boot.s
	dd if=/dev/zero of=boot.img bs=1M count=64
	mkfs.vfat boot.img
	mmd -i boot.img ::/EFI
	mmd -i boot.img ::/EFI/BOOT
	mcopy -i boot.img bootloader.efi ::/EFI/BOOT/BOOTAA64.EFI

#	aarch64-linux-gnu-as -o sector1/boot.o sector1/boot.as
#	aarch64-linux-gnu-ld -o sector1/boot.efi -Ttext 0x400000 sector1/boot.o
#	aarch64-linux-gnu-objcopy -O binary sector1/boot.efi sector1/boot.bin
#	dd if=sector1/boot.bin of=sector1/boot.img bs=512 count=2880

test1:
	sudo qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a57 \
  -m 2048 \
  -drive if=pflash,format=raw,file=/usr/share/AAVMF/AAVMF_CODE.fd,readonly=on \
  -drive if=pflash,format=raw,file=/usr/share/AAVMF/AAVMF_VARS.fd \
  -drive if=none,file=main_disk.img,id=hd0 \
  -device virtio-blk-device,drive=hd0 \
  -drive if=none,file=varstore.img,id=efivars \
  -device virtio-blk-device,drive=efivars \
  -drive file=boot.img,format=raw,if=virtio \
  -nographic

