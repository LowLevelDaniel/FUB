# 0 "sector2/drivers/drivers/screen.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "sector2/drivers/drivers/screen.c"




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
# 6 "sector2/drivers/drivers/screen.c" 2
# 1 "sector2/drivers/drivers/../cpu/ports.h" 1
unsigned char port_byte_in(unsigned short port);
void port_byte_out(unsigned short port, unsigned char data);
unsigned short port_word_in(unsigned short port);
void port_word_out(unsigned short port, unsigned short data);
# 7 "sector2/drivers/drivers/screen.c" 2
# 1 "sector2/drivers/drivers/../libc/mem.h" 1
# 1 "sector2/drivers/drivers/../libc/../include/stdint.h" 1
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
# 2 "sector2/drivers/drivers/../libc/mem.h" 2

void memory_copy(uint8_t *source, uint8_t *destination, int bytes);
void memory_set(uint8_t *destination, uint8_t value, uint32_t len);
# 8 "sector2/drivers/drivers/screen.c" 2

int print_char(char character, int col, int row, int attribute);
int get_cursor_offset();
int set_cursor_offset(int offset);
int get_offset(int col, int row);
int get_row_from_offset(int offset);
int get_col_from_offset(int offset);


void print(char *message) {
  print_at(message, -1, -1);
}


void print_at(char *message, int col, int row) {
  int offset;

  if (col >= 0 && row >= 0) {
    offset = get_offset(col, row);
  } else {
    offset = get_cursor_offset();
  }

  while (*message) {
    offset = print_char(
      (char)*message,
      get_col_from_offset(offset),
      get_row_from_offset(offset),
      0x0F
    );

    message++;
  }
}

void print_backspace() {
  int offset = get_cursor_offset() - 2;
  int row = get_row_from_offset(offset);
  int col = get_col_from_offset(offset);
  print_char(0x08, col, row, 0x0F);
}


void clear_screen() {
  for (int row = 0; row < 25; row++) {
    for (int col = 0; col < 80; col++) {
      print_char(' ', col, row, 0x0F);
    }
  }

  set_cursor_offset(get_offset(0, 0));
}




int print_char(char character, int col, int row, int attribute) {
  if (!attribute) attribute = 0x0F;

  char *video_memory_ptr = (char*)0xB8000;

  int offset;
  if (col >= 0 && row >= 0) {
    offset = get_offset(col, row);
  } else {
    offset = get_cursor_offset();
  }

  if (character == '\n') {
    row = get_row_from_offset(offset);
    offset = get_offset(0, row + 1);
  } else {
    video_memory_ptr[offset++] = character;
    video_memory_ptr[offset++] = attribute;
  }

  if (offset >= 25 * 80 * 2) {


    for (int i = 1; i < 25; i++) {
      memory_copy(
        (uint8_t*)(get_offset(0, i) + 0xB8000),
        (uint8_t*)(get_offset(0, i - 1) + 0xB8000),
        80 * 2
      );
    }


    char* last_line = (char*)(get_offset(0, 25 - 1) + 0xB8000);
    for (int i = 0; i < 80 * 2; i++) {
      last_line[i] = 0;
    }


    offset -= 2 * 80;
  }


  set_cursor_offset(offset);
  return offset;
}






int get_cursor_offset() {
  port_byte_out(0x3D4, 14);
  int offset = port_byte_in(0x3D5) << 8;
  port_byte_out(0x3D4, 15);
  offset += port_byte_in(0x3D5);

  return offset * 2;
}





int set_cursor_offset(int offset) {
  offset /= 2;

  port_byte_out(0x3D4, 14);
  port_byte_out(0x3D5, (unsigned char)(offset >> 8));
  port_byte_out(0x3D4, 15);
  port_byte_out(0x3D5, (unsigned char)(offset & 0xFF));

  return offset * 2;
}


int get_offset(int col, int row) {
  return 2 * (row * 80 + col);
}


int get_row_from_offset(int offset) {
  return offset / (2 * 80);
}


int get_col_from_offset(int offset) {
  return (offset - (get_row_from_offset(offset) * 2 * 80)) / 2;
}
