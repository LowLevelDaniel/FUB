# 0 "sector2/drivers/libc/mem.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "sector2/drivers/libc/mem.c"
# 1 "sector2/drivers/libc/mem.h" 1
# 1 "sector2/drivers/libc/../include/stdint.h" 1
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
# 2 "sector2/drivers/libc/mem.h" 2

void memory_copy(uint8_t *source, uint8_t *destination, int bytes);
void memory_set(uint8_t *destination, uint8_t value, uint32_t len);
# 2 "sector2/drivers/libc/mem.c" 2

void memory_copy(uint8_t *source, uint8_t *destination, int bytes) {
  for (int i = 0; i < bytes; i++) {
    *(destination + i) = *(source + i);
  }
}

void memory_set(uint8_t *destination, uint8_t value, uint32_t len) {
  uint8_t *temp = (uint8_t*)destination;
  for (; len != 0; len--) *temp++ = value;
}
