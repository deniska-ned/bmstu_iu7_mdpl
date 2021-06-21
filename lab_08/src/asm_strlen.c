#include "asm_string.h"

#include <inttypes.h>

size_t asm_strlen(char *str)
{
    uint64_t len = 0;

    __asm__ (
           "movq $-1,   %%rcx;"
           "movb $0,    %%al;"
           "movq %1,    %%rdi;"
           "repne scasb;"
           "negq %%rcx;"
           "subq $2,    %%rcx;"
           "movq %%rcx, %0;"
           : "=r"   (len /* %0 */)      /* output */
           : "r"    (str /* %1 */)      /* input */
           : "%rax", "%rbx", "%cl"      /* clobbered register */
           );

    return (size_t) len;
}
