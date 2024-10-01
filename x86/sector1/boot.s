.code16
.intel_syntax noprefix
.text

.equ KERNEL_OFFSET, 0x1000

.macro mError str
  lea si,\str 
  call CstrPrint
  jmp $
.endm

.global _start

_start:
  jmp short start                    # jump to beginning of code
  jmp $

.include "sector1/display.s"
.include "sector1/cpu/switch_to_pm.s"

.code16
.func LoadKernel
LoadKernel:
  pusha

  xor ax, ax
  mov es, ax

  mov ah, 2              # subfuction 2 - read floppy/hard disk in CHS mode
  mov al, 0x01           # Number of sectors to read
  mov ch, 0x00           # Cylinder number
  mov cl, 0x02           # Sector number (starts at 1)
  mov dh, 0x00           # Head number
  mov dl, [iBootDrive]   # Drive number
  mov bx, KERNEL_OFFSET         # ES:BX points to buffer (0x7E00:0000)
  int 0x13               # bios interrupt
  jc LoadKernel_read_err # check for success 

  popa
  ret
LoadKernel_read_err:
  mError diskreaderr
.endfunc

start:
  # Setup segments:
  cli
  mov  iBootDrive, dl  # save what drive we booted from (should be 0x0)
  mov  ax, cs          # CS = 0x0, since that's where boot sector is (0x07c00)
  mov  ds, ax          # DS = CS = 0x0
  mov  es, ax          # ES = CS = 0x0
  mov  ss, ax          # SS = CS = 0x0
  mov  sp, 0x7C00      # Stack grows down from offset 0x7C00 toward 0x0000.
  sti

  # Reset disk system.
  # Jump to bootFailure on error.
  mov  dl, iBootDrive  # drive to reset
  xor  ax, ax          # subfunction 0
  int  0x13            # call interrupt 13h
  jc   start_DiskResetError     # display error message if carry set (error) 

  # Load Second Stage Boootloader Into Memory
  call LoadKernel

  # attempt switch (for both 16 bit and above)
  lea si, pmNotification
  call CstrPrint
  call switch_to_pm

  # something has went wrong, control shouldn't be handed back here
  jmp $
start_DiskResetError:
  mError diskreseterr

.code32
begin_pm: # this can be for both 16 bit and 32 bit
  call KERNEL_OFFSET
  jmp $

.code16

# PROGRAM DATA
diskreseterr:       .asciz "Disk Reset Error. "
diskreaderr:        .asciz "Disk read Error. "
pmNotification:     .asciz "Entering Proteceted Mode. "
iBootDrive:         .byte  0

.fill (510-(.-_start)), 1, 0  # Pad with nulls up to 510 bytes (excl. boot magic)
BootMagic: # magic bytes for BIOS
  .byte 0x55
  .byte 0xAA
