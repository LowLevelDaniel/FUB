#include "libc/stdint.h"

// Address in memory which is mapped to video
#define VIDEO_ADDRESS 0xB8000

// Terminal sizes by default
#define MAX_ROWS 25
#define MAX_COLS 80

// Attribute byte for text
// Foreground color is in its lowest 4 bits
// Background color is in its highest 3 bits
#define WHITE_ON_BLACK 0x0F

// Indexed registers for read\write from\in port
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

// Public API
int swrite(const char *message, int attribute);
int swriteo(const char *message, int offset, int attribute); // write offset
int sputc(char in, int offset, int attribute);
void sclear();

// Getters && Setters
int get_offset(int col, int row);
int get_row_from_offset(int offset);
int get_col_from_offset(int offset);

int get_cursor_offset();
int set_cursor_offset(int offset);