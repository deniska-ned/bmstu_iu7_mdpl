#ifndef ASM_STRING_H
#define ASM_STRING_H

#include <stddef.h>
#include <inttypes.h>

size_t asm_strlen(char *str);

char *asm_strncpy(char *dest, char *src, uint64_t len);

#endif // ASM_STRING_H
