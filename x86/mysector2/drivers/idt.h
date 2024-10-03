#include "clib/stdint.h"

// Address of kernel code segment
#define KERNEL_CS 0x08

// Entries count in Interrupt Descriptor Table
#define IDT_ENTRIES 256

// Structure for storing Gate entry
// http://wiki.osdev.org/Interrupt_Descriptor_Table#Location_and_Size
// 0..15 bits are Lo offset bits
// 16..31 bits is a code segment selector in GDT or LDT
// 32..39 bits are unused, set to 0
// 40..47 bits are type and attributes bits
// 48..63 bits are Hi offset bits
typedef struct {
  uint16_t low_offset;
  uint16_t sel;
  uint8_t always0;
  uint8_t flags;
  uint16_t high_offset;
} __attribute__((packed)) idt_gate_t;

// Structure for storing IDT location
// http://wiki.osdev.org/Interrupt_Descriptor_Table#Location_and_Size
// 0..15 bits defines the length of IDT
// 16..47 bits defines address where IDT starts
typedef struct {
  uint16_t limit;
  uint32_t base;
} __attribute__((packed)) idt_register_t;

typedef struct {
  uint32_t ds;
  uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
  uint32_t int_no, err_code;
  uint32_t eip, cs, eflags, useresp, ss;
} registers_t;

typedef void (*isr_t)(registers_t);

// Public API
void isr_install();
void irq_install_setup();
void register_interrupt_handler(uint8_t n, isr_t handler);
