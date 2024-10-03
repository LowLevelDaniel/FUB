#include "libc/string.h"

/*
* This can probably be optimized
*/
void memcpy(void *dest, const void *src, int size) {
  char *cdest = (char*)dest;
  const char *csrc = (const char*)src;
  for (int i = 0; i < size; ++i) { cdest[i] = csrc[i]; }
}