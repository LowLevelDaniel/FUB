.code16
.intel_syntax noprefix
.text

.macro mReboot
  # machine language to jump to FFFF:0000 (reboot)
  .byte  0xEA 
  .word  0x0000
  .word  0xFFFF
.endm

.macro mPrint str
  push si
  lea  si, \str
  call CstrPrint
  pop si
.endm

.macro mError str
  mPrint \str     # Print reboot msg
  call WaitKeyPress  # wait for user key press
  mReboot
.endm

.global _start

_start:
  jmp short start                    # jump to beginning of code
  nop

.include "sector1/bootinfo.s"
.include "sector1/keyboard.s"
.include "sector1/display.s"

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
  mov dl, 0x80           # Drive number (0x80 for first hard disk)
  mov bx, 0x7E00         # ES:BX points to buffer (0x7E00:0000)
  int 0x13               # bios interrupt
  jc LoadKernel_read_err # check for success 

  # log sucess
  mPrint disksucess

  # Jump to the second stage bootloader
  jmp 0x07E0:0x0000

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

  # Display "loading" message:
  mPrint loadmsg

  # Reset disk system.
  # Jump to bootFailure on error.
  mov  dl, iBootDrive  # drive to reset
  xor  ax, ax          # subfunction 0
  int  0x13            # call interrupt 13h
  jc   start_DiskResetError     # display error message if carry set (error) 

  # Load Second Stage Boootloader
  call LoadKernel

  # something has went wrong, control shouldn't be handed back here
  mError rebootmsg

start_DiskResetError:
  mError diskreseterr

# PROGRAM DATA
loadmsg:            .asciz "Loading OS...\n"
disksucess:         .asciz "Loaded Disk, Now Executing...\n"
diskreseterr:       .asciz "Disk Reset Error. "
diskreaderr:        .asciz "Disk read Error. "
rebootmsg:          .asciz "Press any key to reboot.\n"

.fill (510-(.-_start)), 1, 0  # Pad with nulls up to 510 bytes (excl. boot magic)
BootMagic: # magic bytes for BIOS
  .byte 0x55
  .byte 0xAA
