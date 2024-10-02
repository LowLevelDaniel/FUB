[bits 32]
section .text
;; called on service interrupt
isr_handler:
  ; perform sanity checks
  cmp eax, 31
  jg isr_handler_failure ; jmp if larger than 31 (0-31 isr interrutps)

  cmp eax, 0
  jl isr_handler_failure ; jmp if smaller than zero

  ; get address of user handler in isr table
  mov edx, 4 ; the size of a long in bytes (this will allow memory address indexing)
  mul edx ; implicitly multiplies by eax (why?)
  add eax, [isr_handler]

  ; test if eax is 0 (i.e the custom handler isn't set)
  test eax, eax
  jz isr_handler_failure

  ; call eax
  call [eax] ; i feel like this should be called with interrupts on
isr_handler_failure:
  popfd
  popa
  sti
  iret

;; called on hardware interrupt
irq_handler:
 ; perform sanity checks
  cmp eax, 31
  jg irq_handler_failure ; jmp if larger than 31 (0-31 isr interrutps)

  cmp eax, 0
  jl irq_handler_failure ; jmp if smaller than zero

  ; get address of user handler in isr table
  mov edx, 4 ; the size of a long in bytes (this will allow memory address indexing)
  mul edx ; implicitly multiplies by eax (why?)
  add eax, [isr_handler]

  ; test if eax is 0 (i.e the custom handler isn't set)
  test eax, eax
  jz irq_handler_failure

  ; call eax
  call [eax] ; i feel like this should be called with interrupts on
irq_handler_failure:
  popfd ; pushed in the gate
  popa  ; pushed in the gate
  sti
  iret

;; Implementations for gates
%macro gate_helper 2
  cli
  pusha
  pushfd
  mov eax, %2
  jmp %1
%endmacro
;; ISR gates
  isr0:  gate_helper isr_handler, 0
  isr1:  gate_helper isr_handler, 1
  isr2:  gate_helper isr_handler, 2
  isr3:  gate_helper isr_handler, 3
  isr4:  gate_helper isr_handler, 4
  isr5:  gate_helper isr_handler, 5
  isr6:  gate_helper isr_handler, 6
  isr7:  gate_helper isr_handler, 7  
  isr8:  gate_helper isr_handler, 8
  isr9:  gate_helper isr_handler, 9  
  isr10: gate_helper isr_handler, 10
  isr11: gate_helper isr_handler, 11
  isr12: gate_helper isr_handler, 12
  isr13: gate_helper isr_handler, 13
  isr14: gate_helper isr_handler, 14
  isr15: gate_helper isr_handler, 15
  isr16: gate_helper isr_handler, 16
  isr17: gate_helper isr_handler, 17
  isr18: gate_helper isr_handler, 18
  isr19: gate_helper isr_handler, 19
  isr20: gate_helper isr_handler, 20
  isr21: gate_helper isr_handler, 21
  isr22: gate_helper isr_handler, 22
  isr23: gate_helper isr_handler, 23
  isr24: gate_helper isr_handler, 24
  isr25: gate_helper isr_handler, 25
  isr26: gate_helper isr_handler, 26
  isr27: gate_helper isr_handler, 27
  isr28: gate_helper isr_handler, 28
  isr29: gate_helper isr_handler, 29
  isr30: gate_helper isr_handler, 30
  isr31: gate_helper isr_handler, 31
;; IRQ gates
  irq0:  gate_helper irq_handler, 0
  irq1:  gate_helper irq_handler, 1
  irq2:  gate_helper irq_handler, 2
  irq3:  gate_helper irq_handler, 3
  irq4:  gate_helper irq_handler, 4
  irq5:  gate_helper irq_handler, 5
  irq6:  gate_helper irq_handler, 6
  irq7:  gate_helper irq_handler, 7
  irq8:  gate_helper irq_handler, 8
  irq9:  gate_helper irq_handler, 9
  irq10: gate_helper irq_handler, 10
  irq11: gate_helper irq_handler, 11
  irq12: gate_helper irq_handler, 12
  irq13: gate_helper irq_handler, 13
  irq14: gate_helper irq_handler, 14
  irq15: gate_helper irq_handler, 15
;; END
