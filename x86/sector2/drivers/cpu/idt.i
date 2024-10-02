# 0 "sector2/drivers/cpu/idt.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "sector2/drivers/cpu/idt.c"



# 1 "sector2/drivers/cpu/idt.h" 1
# 1 "sector2/drivers/cpu/../include/stdint.h" 1
typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned uint32_t;
typedef long long int64_t;
typedef unsigned long long uint64_t;

typedef signed char int_least8_t;
typedef unsigned char uint_least8_t;
typedef short int_least16_t;
typedef unsigned short uint_least16_t;
typedef int int_least32_t;
typedef unsigned uint_least32_t;
typedef long long int_least64_t;
typedef unsigned long long uint_least64_t;

typedef char int_fast8_t;
typedef unsigned char uint_fast8_t;
typedef short int_fast16_t;
typedef unsigned short uint_fast16_t;
typedef int int_fast32_t;
typedef unsigned int uint_fast32_t;
typedef long long int_fast64_t;
typedef unsigned long long uint_fast64_t;

typedef int intptr_t;
typedef unsigned uintptr_t;

typedef long long intmax_t;
typedef unsigned long long uintmax_t;
# 2 "sector2/drivers/cpu/idt.h" 2
# 16 "sector2/drivers/cpu/idt.h"
typedef struct {
  uint16_t low_offset;
  uint16_t sel;
  uint8_t always0;
  uint8_t flags;
  uint16_t high_offset;
} __attribute__((packed)) idt_gate_t;





typedef struct {
  uint16_t limit;
  uint32_t base;
} __attribute__((packed)) idt_register_t;


extern idt_gate_t idt[256];


extern idt_register_t idt_reg;


void set_idt_gate(int n, uint32_t handler);
void set_idt();
# 5 "sector2/drivers/cpu/idt.c" 2


idt_gate_t idt[256];


idt_register_t idt_reg;




void set_idt_gate(int n, uint32_t handler) {
  idt[n].low_offset = (uint16_t)((handler) & 0xFFFF);
  idt[n].sel = 0x08;
  idt[n].always0 = 0;
  idt[n].flags = 0x8E;
  idt[n].high_offset = (uint16_t)(((handler) >> 16) & 0xFFFF);
}





void set_idt() {
  idt_reg.base = (uint32_t)&idt;
  idt_reg.limit = 256 * sizeof(idt_gate_t) - 1;
  __asm__ __volatile__("lidtl (%0)" : : "r" (&idt_reg));
}
