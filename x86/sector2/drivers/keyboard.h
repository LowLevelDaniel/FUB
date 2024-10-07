#include "idt.h"

/*
* Setup the keyboard callbcak function to handle keyboard input
* 
*/
void keyboard_init(void (*keyboard_callback)(registers_t));

#define SC_MAX 58
extern const char sc_ascii[SC_MAX];

#define SPACE 0x39
#define BACKSPACE 14
#define ENTER 0x1C

#define LSHIFT 0x2A
#define RSHIFT 0x36

#define CAPS_LOCK 0x3A

#define RELASE_MUL 128

const char *hexifyUC(unsigned char ch);