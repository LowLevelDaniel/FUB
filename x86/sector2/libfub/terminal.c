extern void _reset(void);
extern void reboot(void);

#include "terminal.h"

#include "drivers/graphic.h"
#include "drivers/keyboard.h"
#include "libc/string.h" // strlen strlenl
#include "libfub/port.h"
#include "libc/stdbool.h"

#define MAX_COMMAND_LENGTH 256
#define COMMAND_LINE_PREFIX "fub> "

static char key_buffer[MAX_COMMAND_LENGTH];
static int key_bufferI = 0;
static bool SHIFTED = false;
static bool CAPITAL = false;

void terminal_input(const char *cstr_command);

static void terminal_keyboard_callback(registers_t regs) {
  // The PIC leaves us the scancode in port 0x60
  uint8_t scancode = port_byte_in(0x60);

  if (key_bufferI+1 > MAX_COMMAND_LENGTH) {
    terminal_input("$$%%INVL"); // Internal Terminal Command
    key_bufferI = 0;
    (void)(regs);
    return;
  }

  switch (scancode) {
    case (BACKSPACE):
      if (key_bufferI == 0) goto exit; // removes weird errors
      --key_bufferI;
      int offset = get_cursor_offset();
      int row = get_row_from_offset(offset);
      int col = get_col_from_offset(offset);
      sputc(' ',get_offset(col-1,row),WHITE_ON_BLACK);
      set_cursor_offset(get_offset(col-1,row));
      break;
    case (ENTER):
      key_buffer[key_bufferI] = '\0';
      terminal_input(key_buffer);
      key_bufferI = 0;
      break;
    case (SPACE):
      key_buffer[key_bufferI] = '\0';
      sputc(' ',get_cursor_offset(),WHITE_ON_BLACK);
      ++key_bufferI;
      break;
    case (LSHIFT): SHIFTED = true; break;
    default:
      scancode = sc_ascii[(int)scancode];
      if (scancode >= 'a' && scancode <= 'x') { key_buffer[key_bufferI] = scancode-32; }
      else { key_buffer[key_bufferI] = scancode; }
      
      sputc(key_buffer[key_bufferI],get_cursor_offset(),WHITE_ON_BLACK);
      ++key_bufferI;
  }
exit:
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
  if (strcmp(cstr_command,"exit") == 0) {
    key_bufferI = 0; // reset data before exit
    exit_terminal();
  } else if (strcmp(cstr_command,"$$%%INVL") == 0) {
    swrite("\nCommand Length can't exceed 256 bytes\n" COMMAND_LINE_PREFIX,WHITE_ON_BLACK);
  } else if (strcmp(cstr_command,"clear") == 0) {
    sclear();
    swrite(COMMAND_LINE_PREFIX,WHITE_ON_BLACK);
  } else if (strcmp(cstr_command,"echo") == 0) {
    sputc('\n',get_cursor_offset(),WHITE_ON_BLACK);
    swrite(&cstr_command[5],WHITE_ON_BLACK); // write the first argument
    swrite("\n"COMMAND_LINE_PREFIX,WHITE_ON_BLACK);
  } else if (strcmp(cstr_command,"help") == 0) {
    swrite(
      "\n"
      "exit \"exits the terminal and soft resets the system\"\n"
      "clear \"clear the screen\"\n"
      "echo \"prints out the first argument given (seperate arguments with spaces i.e ECHO hello)\"\n"
      "help \"Displays this menu\"\n"
      "CHELP \"displays internal commands used by the system (should only be used for debugging purpose)\"\n"
      COMMAND_LINE_PREFIX
      , WHITE_ON_BLACK
    );
  } else if (strcmp(cstr_command,"CHELP") == 0) {
    swrite(
      "\n"
      "$$%%INVL \"Displays the Command Length\"\n"
      COMMAND_LINE_PREFIX
      , WHITE_ON_BLACK
    );
  } else {
    swrite("\nInvalid Command '",WHITE_ON_BLACK);
    swrite(cstr_command,WHITE_ON_BLACK);
    swrite("' type help for a list of valid commands\n" COMMAND_LINE_PREFIX,WHITE_ON_BLACK);
  }
}