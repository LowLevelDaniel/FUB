[bits 32]
global _start
global reboot   ; should probably be moved to seperate files
global shutdown ; should probably be moved to seperate files

[extern kernel_main]

section .KernelEntryPoint ; to tell the linker this section goes first
_start:
  ; just ensure interrupt flag ins't set before we create the interrupt descriptor table
  ; cli

  ; Set stack pointer
  ; mov esp, stack_top
  ; mov ebp, esp

  call kernel_main

  ; Load CPU Drivers
  ; call load_cpu ; this is broken

  ; Load Graphic Drivers ( this happens first for debugging (but safety reasons it can't come before cpu drivers )

  ; Load Periphrial Drivers ( allow for keyboard interrupts) 

  ; Load Disk Drivers ( get ready to scan for bootable disks )

  ; Search for fub bootable disks

  ; Search for bootable disks

  ; Search for grub bootable disks

  ; main application loop ( handle the graphic api and keyboard interrupts to select a bootloader )

  hlt ; failure

; probably move these
shutdown: 
  ; Is this even possible?
reboot:
  db  0xEA ; machine code for reboot (don't ask me how this works)
  dw  0x0000
  dw  0xFFFF

; I liked the look of this, it is explicit and always gurantees that much space so this is what i will use,
; technically this may be slightly worse than using free space defined in the bios standard

section .bss
raw_idt_table resb 256 * 8 ; 256 entries, each 8 bytes
stack_bottom:
  resb 4096 * 4
stack_top: