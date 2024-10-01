# Print to screen a c style string
# all registers should be perserved
# check what can be modified by the bios interrupt
.func CstrPrint
CstrPrint:
  push ax
  push bx
CstrPrint_loop:
  lodsb                   # load byte at ds:si into al (advancing si)
  or     al, al           # test if character is 0 (end)
  jz     CstrPrint_done   # jump to end if 0.

  mov    ah, 0x0e         # Subfunction 0xe of int 10h (video teletype output)
  mov    bx, 9            # Set bh (page nr) to 0, and bl (attribute) to white (9)
  int    0x10             # call BIOS interrupt.

  jmp    CstrPrint_loop      # Repeat for next character.
CstrPrint_done:
  pop bx
  pop ax 
  ret
.endfunc
