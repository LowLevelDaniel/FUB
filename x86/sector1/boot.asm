; Boot sector
; Loads kernel from the disk into memory
; Switches processor to 32-bit Protected Mode
; Executes loaded kernel

[org 0x7C00]
[bits 16]

_start:
  ; disable interruptions
  cli
  
  ; save the boot drive
  mov [BOOT_DRIVE], dl

  ; set segments
  mov ax, cs ; CS = 0x0, since that's where boot sector is (0x07c00)
  mov ds, ax ; DS = CS = 0x0
  mov es, ax ; ES = CS = 0x0
  mov ss, ax ; SS = CS = 0x0
  
  ; set stack (moves downwards from our program)
  mov sp, 0x7C00 ; Stack grows down from offset 0x7C00 toward 0x0000.
  mov bp, sp

  ; enable interuptions
  sti

  ; reset disk system (a turtorial does)
  mov dl, [BOOT_DRIVE] ; this may not be needed but i am worried about sti
  xor ax, ax
  int 0x13
  jc  DiskResetError

  ; load kernel
  call load_kernel

  ; activate protected mode
  call activate_pm
  ; Fall through on purpose
; Error Handling
ProtectedModeError:
  ; I am still working on this being needed
  jmp $
DiskResetError:
  ; Print Something Here
  jmp $
DiskReadError:
  ; Print Something Here
  jmp $

; Next _start helpers
load_kernel:
  ; no registers need to be saved as all labels will reset the needed registers
  xor ax, ax
  mov es, ax

  mov ah, 2              ; subfuction 2 - read floppy/hard disk in CHS mode
  mov al, 0x0D           ; Number of sectors to read
  mov ch, 0x00           ; Cylinder number
  mov cl, 0x02           ; Sector number (starts at 1)
  mov dh, 0x00           ; Head number
  mov dl, [BOOT_DRIVE]   ; Drive number
  mov bx, KERNEL_OFFSET  ; ES:BX points to the KERNEL Offset
  int 0x13               ; bios interrupt
  jc DiskReadError ; check for success 

  ret
activate_pm:
  ;; clear all interrupts
	cli

	;; load the Global Descriptor Table
	lgdt [gdt_descriptor]

	;; switch to protected mode
	;; set PE (Protection Enable) bit in CR0
	;; CR0 is a Control Register 0
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax

	;; far jump to 32 bit instructions
	;; so we can be sure processor has done
	;; all other operations before switch
	jmp CODE_SEG:init_pm
[bits 32]
init_pm:
	;; update all segment registers
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

  ;; update base and stack pointers
	mov ebp, 0x90000 ; Literally just copy and pasted, i don't understand this
	mov esp, ebp

  ; fall through on purpose
execute_kernel:
  cli ; ensure interrupts are turned off
	call KERNEL_OFFSET

; includes
%include "sector1/cpu/gdt.inc"

; Program Data
KERNEL_OFFSET equ 0x1000
BOOT_DRIVE: db 0

times 510 - ($-$$) db 0
dw 0xAA55
