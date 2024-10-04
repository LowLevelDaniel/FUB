extern void _reset(void);
extern void reboot(void);

#include "terminal.h"

#include "drivers/graphic.h"
#include "drivers/keyboard.h"
#include "libc/string.h" // strlen strlenl
#include "libfub/port.h"

#define MAX_COMMAND_LENGTH 256
#define COMMAND_LINE_PREFIX "fub> "

static char key_buffer[MAX_COMMAND_LENGTH];
static int key_bufferI;

volatile int terminal_exit = 0;

void terminal_input(const char *cstr_command);

static void terminal_keyboard_callback(registers_t regs) {
  // The PIC leaves us the scancode in port 0x60
  uint8_t scancode = port_byte_in(0x60);

  if (scancode > SC_MAX) return;
  if (key_bufferI+1 > MAX_COMMAND_LENGTH) {
    terminal_input("$$%%INVL"); // Internal Terminal Command
    key_bufferI = 0;
    (void)(regs);
    return;
  }
  if (scancode == BACKSPACE) {
    --key_bufferI;
    // TODO: Clean This Up
    int offset = get_cursor_offset();
    int row = get_row_from_offset(offset);
    int col = get_col_from_offset(offset);

    sputc(' ',get_offset(col-1,row),WHITE_ON_BLACK);
    set_cursor_offset(get_offset(col-1,row));
  } else if (scancode == ENTER) {
    key_buffer[key_bufferI] = '\0';
    terminal_input(key_buffer);
    key_bufferI = 0;
  } else if (scancode == SPACE) {
    key_buffer[key_bufferI] = '\0';
    sputc(' ',get_cursor_offset(),WHITE_ON_BLACK);
    ++key_bufferI;
  } else {
    key_buffer[key_bufferI] = sc_ascii[(int)scancode];
    sputc(key_buffer[key_bufferI],get_cursor_offset(),WHITE_ON_BLACK);
    ++key_bufferI;
  }
  (void)(regs);
}

void run_terminal() {
  // terminal setup
  sclear();
  swrite(
    "Welcome to the FUB Terminal!\n"
    "Type 'help' to get a list of commands\n"
    COMMAND_LINE_PREFIX,
    WHITE_ON_BLACK
  );
  keyboard_init(terminal_keyboard_callback);
}
void exit_terminal() {
  _reset(); // jmp to the start to reset the program
}

void terminal_input(const char *cstr_command) {
  if (strcmp(cstr_command,"EXIT") == 0) {
    key_bufferI = 0; // reset data before exit
    exit_terminal();
  } else if (strcmp(cstr_command,"$$%%INVL") == 0) {
    swrite("\nCommand Length can't exceed 256 bytes\n" COMMAND_LINE_PREFIX,WHITE_ON_BLACK);
  } else if (strcmp(cstr_command,"CLEAR") == 0) {
    sclear();
    swrite(COMMAND_LINE_PREFIX,WHITE_ON_BLACK);
  } else if (strcmp(cstr_command,"ECHO") == 0) {
    sputc('\n',get_cursor_offset(),WHITE_ON_BLACK);
    swrite(&cstr_command[5],WHITE_ON_BLACK); // write the first argument
    swrite("\n"COMMAND_LINE_PREFIX,WHITE_ON_BLACK);
  } else {
    swrite("\nInvalid Command '",WHITE_ON_BLACK);
    swrite(cstr_command,WHITE_ON_BLACK);
    swrite("' type help for a list of valid commands\n" COMMAND_LINE_PREFIX,WHITE_ON_BLACK);
  }
}