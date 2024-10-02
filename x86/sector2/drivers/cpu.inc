[bits 32]

%macro set_idt_entry_helper 2
  mov ax, %1
  mov ebx, %2
  ; call set_idt_entry
%endmacro

section .text
load_cpu:
  push eax ; register modified
  push ebx

  ; load isr
    set_idt_entry_helper isr0 , 0
    set_idt_entry_helper isr1 , 1
    set_idt_entry_helper isr2 , 2
    set_idt_entry_helper isr3 , 3
    set_idt_entry_helper isr4 , 4
    set_idt_entry_helper isr5 , 5
    set_idt_entry_helper isr6 , 6
    set_idt_entry_helper isr7 , 7
    set_idt_entry_helper isr8 , 8
    set_idt_entry_helper isr9 , 9
    set_idt_entry_helper isr10, 10
    set_idt_entry_helper isr11, 11
    set_idt_entry_helper isr12, 12
    set_idt_entry_helper isr13, 13
    set_idt_entry_helper isr14, 14
    set_idt_entry_helper isr15, 15
    set_idt_entry_helper isr16, 16
    set_idt_entry_helper isr17, 17
    set_idt_entry_helper isr18, 18
    set_idt_entry_helper isr19, 19
    set_idt_entry_helper isr20, 20
    set_idt_entry_helper isr21, 21
    set_idt_entry_helper isr22, 22
    set_idt_entry_helper isr23, 23
    set_idt_entry_helper isr24, 24
    set_idt_entry_helper isr25, 25
    set_idt_entry_helper isr26, 26
    set_idt_entry_helper isr27, 27
    set_idt_entry_helper isr28, 28
    set_idt_entry_helper isr29, 29
    set_idt_entry_helper isr30, 30
    set_idt_entry_helper isr31, 31
  ; load irq
    set_idt_entry_helper irq0, 32 ; inserted after the isr table
    set_idt_entry_helper irq1, 33
    set_idt_entry_helper irq2, 34
    set_idt_entry_helper irq3, 35
    set_idt_entry_helper irq4, 36
    set_idt_entry_helper irq5, 37
    set_idt_entry_helper irq6, 38
    set_idt_entry_helper irq7, 39
    set_idt_entry_helper irq8, 40
    set_idt_entry_helper irq9, 41
    set_idt_entry_helper irq10, 42
    set_idt_entry_helper irq11, 43
    set_idt_entry_helper irq12, 44
    set_idt_entry_helper irq13, 45
    set_idt_entry_helper irq14, 46
    set_idt_entry_helper irq15, 47
  ; end

  ; lidt [raw_idt_table]

  pop ebx
  pop eax
  ; sti ; enable interrupts
  ret
set_idt_entry:
  mov word [raw_idt_table + ebx * 8], ax                         ; .offset_low
  mov word [raw_idt_table + ebx * 8 + 2], CODE_SEGMENT_SELECTOR  ; .selector
  ;                                                              ; .zero
  mov byte [raw_idt_table + ebx * 8 + 5], IDT_ENTRY_TYPE_ATTR    ; .type_attr 
  mov word [raw_idt_table + ebx * 8 + 6], ax                     ; .offset_high 
  ret

CODE_SEGMENT_SELECTOR equ 0x08 ; i don't know why this is the way it is
IDT_ENTRY_TYPE_ATTR   equ 0x8E ; apparently this is set to (present, ring 0, 32-bit interrupt gate) whatever that means


;; IDT Structure
;; I don't know how nasm structures work
;; just here for reference
; struc idt_entry
;   .offset_low  resw 1 ; 2
;   .selector    resw 1 ; 2
;   .zero        resb 1 ; 1
;   .type_attr   resb 1 ; 1
;   .offset_high resw 1 ; 2
; endstruc
