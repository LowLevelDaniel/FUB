# simply wait for user input
# registers could be changed by bios interrupt
# this should probably be checked
.func WaitKeyPress
WaitKeyPress:
  push ax
  xor    ax, ax        # subfuction 0
  int    0x16          # call bios to wait for key
  pop ax
.endfunc
