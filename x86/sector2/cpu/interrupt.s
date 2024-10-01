# TODO: how to port push byte 0 from nasm?
.code32
.intel_syntax noprefix

# Make our isr_handler() from isr.c available here
.extern isr_handler

# Make our irq_handler() from isr.c available here
.extern irq_handler

.macro pushb value
  mov ax, 0x1234  ; Load the 2-byte value into AX
  push eax        ; Push the 4-byte value (EAX)
  sub esp, 2      ; Adjust the stack pointer to account for only 2 bytes
.endm

# Common stub which calls when any of interrupts are triggered
isr_common_stub:
  pusha
  mov ax, ds
  push eax
  mov ax, 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  call isr_handler

  pop eax
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  popa
  add esp, 8
  sti
  iret

# Common stub which calls when any of hardware interrupts are triggered
irq_common_stub:
  pusha
  mov ax, ds
  push eax
  mov ax, 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  call irq_handler

  pop ebx
  mov ds, bx
  mov es, bx
  mov fs, bx
  mov gs, bx
  popa
  add esp, 8
  sti
  iret

# We need to make our procedures global
# So it became available in isr.c file for setting the gates
  .globl isr0
  .globl isr1
  .globl isr2
  .globl isr3
  .globl isr4
  .globl isr5
  .globl isr6
  .globl isr7
  .globl isr8
  .globl isr9
  .globl isr10
  .globl isr11
  .globl isr12
  .globl isr13
  .globl isr14
  .globl isr15
  .globl isr16
  .globl isr17
  .globl isr18
  .globl isr19
  .globl isr20
  .globl isr21
  .globl isr22
  .globl isr23
  .globl isr24
  .globl isr25
  .globl isr26
  .globl isr27
  .globl isr28
  .globl isr29
  .globl isr30
  .globl isr31

# IRQ handlers
  .globl irq0
  .globl irq1
  .globl irq2
  .globl irq3
  .globl irq4
  .globl irq5
  .globl irq6
  .globl irq7
  .globl irq8
  .globl irq9
  .globl irq10
  .globl irq11
  .globl irq12
  .globl irq13
  .globl irq14
  .globl irq15

# Implementations for gates
# Each of these implementations push data on the stack
# And jumps to our stub above
isr0:
  cli
  push dbyte 0
  push dbyte 0
  jmp isr_common_stub

isr1:
  cli
  pushb 0
  pushb 1
  jmp isr_common_stub

isr2:
  cli
  pushb 0
  pushb 2
  jmp isr_common_stub

isr3:
  cli
  pushb 0
  pushb 3
  jmp isr_common_stub

isr4:
  cli
  pushb 0
  pushb 4
  jmp isr_common_stub

isr5:
  cli
  pushb 0
  pushb 5
  jmp isr_common_stub

isr6:
  cli
  pushb 0
  pushb 6
  jmp isr_common_stub

isr7:
  cli
  pushb 0
  pushb 7
  jmp isr_common_stub

isr8:
  cli
  pushb 8
  jmp isr_common_stub

isr9:
  cli
  pushb 0
  pushb 9
  jmp isr_common_stub

isr10:
  cli
  pushb 10
  jmp isr_common_stub

isr11:
  cli
  pushb 11
  jmp isr_common_stub

isr12:
  cli
  pushb 12
  jmp isr_common_stub

isr13:
  cli
  pushb 13
  jmp isr_common_stub

isr14:
  cli
  pushb 14
  jmp isr_common_stub

isr15:
  cli
  pushb 0
  pushb 15
  jmp isr_common_stub

isr16:
  cli
  pushb 0
  pushb 16
  jmp isr_common_stub

isr17:
  cli
  pushb 0
  pushb 17
  jmp isr_common_stub

isr18:
  cli
  pushb 0
  pushb 18
  jmp isr_common_stub

isr19:
  cli
  pushb 0
  pushb 19
  jmp isr_common_stub

isr20:
  cli
  pushb 0
  pushb 20
  jmp isr_common_stub

isr21:
  cli
  pushb 0
  pushb 21
  jmp isr_common_stub

isr22:
  cli
  pushb 0
  pushb 22
  jmp isr_common_stub

isr23:
  cli
  pushb 0
  pushb 23
  jmp isr_common_stub

isr24:
  cli
  pushb 0
  pushb 24
  jmp isr_common_stub

isr25:
  cli
  pushb 0
  pushb 25
  jmp isr_common_stub

isr26:
  cli
  pushb 0
  pushb 26
  jmp isr_common_stub

isr27:
  cli
  pushb 0
  pushb 27
  jmp isr_common_stub

isr28:
  cli
  pushb 0
  pushb 28
  jmp isr_common_stub

isr29:
  cli
  pushb 0
  pushb 29
  jmp isr_common_stub

isr30:
  cli
  pushb 0
  pushb 30
  jmp isr_common_stub

isr31:
  cli
  pushb 0
  pushb 31
  jmp isr_common_stub

# IRQ handlers
irq0:
  cli
  pushb 0
  pushb 32
  jmp irq_common_stub

irq1:
  cli
  pushb 1
  pushb 33
  jmp irq_common_stub

irq2:
  cli
  pushb 2
  pushb 34
  jmp irq_common_stub

irq3:
  cli
  pushb 3
  pushb 35
  jmp irq_common_stub

irq4:
  cli
  pushb 4
  pushb 36
  jmp irq_common_stub

irq5:
  cli
  pushb 5
  pushb 37
  jmp irq_common_stub

irq6:
  cli
  pushb 6
  pushb 38
  jmp irq_common_stub

irq7:
  cli
  pushb 7
  pushb 39
  jmp irq_common_stub

irq8:
  cli
  pushb 8
  pushb 40
  jmp irq_common_stub

irq9:
  cli
  pushb 9
  pushb 41
  jmp irq_common_stub

irq10:
  cli
  pushb 10
  pushb 42
  jmp irq_common_stub

irq11:
  cli
  pushb 11
  pushb 43
  jmp irq_common_stub

irq12:
  cli
  pushb 12
  pushb 44
  jmp irq_common_stub

irq13:
  cli
  pushb 13
  pushb 45
  jmp irq_common_stub

irq14:
  cli
  pushb 14
  pushb 46
  jmp irq_common_stub

irq15:
  cli
  pushb 15
  pushb 47
  jmp irq_common_stub
