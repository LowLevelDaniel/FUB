# 0 "sector2/drivers/drivers/keyboard.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "sector2/drivers/drivers/keyboard.c"





# 1 "sector2/drivers/drivers/keyboard.h" 1
# 1 "sector2/drivers/drivers/../include/stdint.h" 1
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
# 2 "sector2/drivers/drivers/keyboard.h" 2

void init_keyboard();
# 7 "sector2/drivers/drivers/keyboard.c" 2
# 1 "sector2/drivers/drivers/screen.h" 1
# 1 "sector2/drivers/drivers/../include/stdint.h" 1
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
# 2 "sector2/drivers/drivers/screen.h" 2
# 20 "sector2/drivers/drivers/screen.h"
void print(char *message);
void print_at(char *message, int col, int row);
void print_backspace();
void clear_screen();
# 8 "sector2/drivers/drivers/keyboard.c" 2
# 1 "sector2/drivers/drivers/../cpu/ports.h" 1
unsigned char port_byte_in(unsigned short port);
void port_byte_out(unsigned short port, unsigned char data);
unsigned short port_word_in(unsigned short port);
void port_word_out(unsigned short port, unsigned short data);
# 9 "sector2/drivers/drivers/keyboard.c" 2
# 1 "sector2/drivers/drivers/../cpu/isr.h" 1
# 1 "sector2/drivers/drivers/../cpu/../include/stdint.h" 1
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
# 2 "sector2/drivers/drivers/../cpu/isr.h" 2


extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();


extern void irq0();
extern void irq1();
extern void irq2();
extern void irq3();
extern void irq4();
extern void irq5();
extern void irq6();
extern void irq7();
extern void irq8();
extern void irq9();
extern void irq10();
extern void irq11();
extern void irq12();
extern void irq13();
extern void irq14();
extern void irq15();
# 73 "sector2/drivers/drivers/../cpu/isr.h"
typedef struct {
  uint32_t ds;
  uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
  uint32_t int_no, err_code;
  uint32_t eip, cs, eflags, useresp, ss;
} registers_t;

typedef void (*isr_t)(registers_t);


void isr_install();
void isr_handler(registers_t r);
void irq_install();
void irq_handler(registers_t r);
void register_interrupt_handler(uint8_t n, isr_t handler);
# 10 "sector2/drivers/drivers/keyboard.c" 2
# 1 "sector2/drivers/drivers/../libc/function.h" 1
# 11 "sector2/drivers/drivers/keyboard.c" 2
# 1 "sector2/drivers/drivers/../libc/string.h" 1
void itoa(int n, char str[]);
void reverse(char s[]);
int strlen(char s[]);
void backspace(char s[]);
void append(char s[], char n);
int strcmp(char s1[], char s2[]);
# 12 "sector2/drivers/drivers/keyboard.c" 2
# 1 "sector2/drivers/drivers/../kernel/kernel.h" 1
void user_input(char *input);
# 13 "sector2/drivers/drivers/keyboard.c" 2




static char key_buffer[256];



const char *sc_name[] = {
  "ERROR",
  "Esc",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "0",
  "-",
  "=",
  "Backspace",
  "Tab",
  "Q",
  "W",
  "E",
  "R",
  "T",
  "Y",
  "U",
  "I",
  "O",
  "P",
  "[",
  "]",
  "Enter",
  "Lctrl",
  "A",
  "S",
  "D",
  "F",
  "G",
  "H",
  "J",
  "K",
  "L",
  ";",
  "'",
  "`",
  "LShift",
  "\\",
  "Z",
  "X",
  "C",
  "V",
  "B",
  "N",
  "M",
  ",",
  ".",
  "/",
  "RShift",
  "Keypad *",
  "LAlt",
  "Spacebar"
};

const char sc_ascii[] = {
  '?',
  '?',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0',
  '-',
  '=',
  '?',
  '?',
  'Q',
  'W',
  'E',
  'R',
  'T',
  'Y',
  'U',
  'I',
  'O',
  'P',
  '[',
  ']',
  '?',
  '?',
  'A',
  'S',
  'D',
  'F',
  'G',
  'H',
  'J',
  'K',
  'L',
  ';',
  '\'',
  '`',
  '?',
  '\\',
  'Z',
  'X',
  'C',
  'V',
  'B',
  'N',
  'M',
  ',',
  '.',
  '/',
  '?',
  '?',
  '?',
  ' '
};


static void keyboard_callback(registers_t regs) {

  uint8_t scancode = port_byte_in(0x60);

  if (scancode > 57) return;
  if (scancode == 0x0E) {
    backspace(key_buffer);
    print_backspace();
  } else if (scancode == 0x1C) {
    print("\n");
    user_input(key_buffer);
    key_buffer[0] = '\0';
  } else {
    char letter = sc_ascii[(int)scancode];
    char str[2] = {letter, '\0'};
    append(key_buffer, letter);
    print(str);
  }

  (void)(regs);
}


void init_keyboard() {
  register_interrupt_handler(33, keyboard_callback);
}
