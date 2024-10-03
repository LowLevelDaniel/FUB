[bits 32]
global _start
global reboot   ; should probably be moved to a seperate file
global shutdown ; should probably be moved to a seperate file
global halt     ; should probably be moved to a seperate file

[extern kernel_main]

section .KernelEntryPoint ; to tell the linker this section goes first
_start:
  ; just ensure interrupt flag ins't set before we create the interrupt descriptor table
  ; cli

  ; Set stack pointer
  mov esp, stack_top
  mov ebp, esp

  call kernel_main ; jmp to c code
halt:
  jmp halt
; probably move these
shutdown: 
  ; Is this even possible?
reboot:
  db  0xEA ; machine code for reboot (don't ask me how this works)
  dw  0x0000
  dw  0xFFFF

%include "sector2/drivers/idt.inc"

section .bss
raw_idt_table resb 256 * 8 ; 256 entries, each 8 bytes
stack_bottom:
  resb 4096 * 4
stack_top: