#include "idt.h"

/*
* Setup the keyboard callbcak function to handle keyboard input
* 
*/
void keyboard_init(void (*keyboard_callback)(registers_t));

#define SC_MAX 57
extern const char sc_ascii[SC_MAX];

#define SPACE 0x39
#define BACKSPACE 0x0E
#define ENTER 0x1C