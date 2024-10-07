#include "keyboard.h"
#include "drivers/idt.h"

void keyboard_init(void (*keyboard_callback)(registers_t)) {
  register_interrupt_handler(IRQ1, keyboard_callback);
}

const char sc_ascii[SC_MAX] = {
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
  'q',
  'w',
  'e',
  'r',
  't',
  'y',
  'u',
  'i',
  'o',
  'p',
  '[',
  ']',
  '?',
  '?',
  'a',
  's',
  'd',
  'f',
  'g',
  'h',
  'j',
  'k',
  'l',
  ';',
  '\'',
  '`',
  '?',
  '\\',
  'z',
  'x',
  'c',
  'v',
  'b',
  'n',
  'm',
  ',',
  '.',
  '/',
  '?',
  '?',
  '?',
  ' '
};


const char *hexifyUC(unsigned char ch) {
  static char hexString[3] = { '\0', '\0', '\0' };
  static const char hexDigits[] = "0123456789ABCDEF";

  // Get the high nibble (4 bits) and low nibble (4 bits)
  hexString[0] = hexDigits[(ch >> 4) & 0x0F];  // High nibble (4 most significant bits)
  hexString[1] = hexDigits[ch & 0x0F];         // Low nibble (4 least significant bits)

  return hexString;
}