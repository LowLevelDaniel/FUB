/*
  Copy data from two buffers for a given integral byte size
*/
void memcpy(void *dest, const void *src, int byte_size);

/*
* :param 1 c style string
* :param 2 c_style string
*
* This function will check to strings to be exact copies
* this means the null character has to be at the same point otherwise this function fails
*
* :return int, set to 0 on sucess, 1 for early null character, -1 for completly different character
*/
int strcmp(const char *_1, const char *_2);