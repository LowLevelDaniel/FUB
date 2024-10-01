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

.global _start
_start:
  jmp main

.include "sector1/keyboard.s"
.include "sector1/display.s"

.include "sector2/b16.s"
.include "sector2/b32.s"
.include "sector2/b64.s"

.code16
main:
  cli
  mov  ax, 0x07E0      # AX = 0x0
  mov  ds, ax          # DS = AX = 0x0
  mov  es, ax          # ES = AX = 0x0
  mov  ss, ax          # SS = AX = 0x0
  mov  sp, 0x7C00      # stack grows down from offset 0x7C00 toward 0x0000
  sti

  mPrint SecondStageConfirmation

  # switch mode
  

  mPrint ErrorStart
  call WaitKeyPress
  mReboot


SecondStageConfirmation: .asciz "Starting Second Stage...\n"
bit32:                   .asciz "64 bit cpu check failed...\n"
bit16:                   .asciz "32 bit cpu check failed...\n"
ErrorStart:              .asciz "Couldn't Start Second Stage. "
