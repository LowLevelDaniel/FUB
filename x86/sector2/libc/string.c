#include "libc/string.h"

/*
  Copy data from two buffers for a given integral byte size
*/
void memcpy(void *dest, const void *src, int size) {
  char *cdest = (char*)dest;
  const char *csrc = (const char*)src;
  for (int i = 0; i < size; ++i) { cdest[i] = csrc[i]; }
}

/*
* :param 1 c style string
* :param 2 c_style string
*
* This function will check to strings to be exact copies
* this means the null character has to be at the same point otherwise this function fails
*
* :return int, set to 0 on sucess, 1 for early null character, -1 for completly different character
*/
int strcmp(const char *_1, const char *_2) {
  for (int i = 0; ;++i) {
    if (_1[i] == '\0') {
      if (_2[i] == '\0') {
        return 0;
      }
      return 1;
    }
    if (_1[i] != _2[i]) {
      return -1;
    }
  }
}