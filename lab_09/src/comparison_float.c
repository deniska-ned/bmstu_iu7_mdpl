#include "comparison_float.h"

#include <stddef.h>
#include <stdio.h>
#include <time.h>

#include "utils.h"


void run_float_sum_c(float l, float r, size_t loop_count)
{
    float c;
    for (size_t i = 0; i < loop_count; ++i)
        c = l + r;
}

void run_float_sum_asm(float l, float r, size_t loop_count)
{
    float c;

    for (size_t i = 0; i < loop_count; ++i)
        asm("fld %1\n"
            "fld %2\n"
            "faddp\n"
            "fstp %0\n"
            : "=m"(c)
            : "m"(l), "m"(r));
}

void run_float_mul_c(float l, float r, size_t loop_count)
{
    float c;
    for (size_t i = 0; i < loop_count; ++i)
        c = l * r;
}

void run_float_mul_asm(float l, float r, size_t loop_count)
{
    float c;

    for (size_t i = 0; i < loop_count; ++i)
        asm("fld %1\n"
            "fld %2\n"
            "fmulp\n"
            "fstp %0\n"
            : "=m"(c)
            : "m"(l), "m"(r));
}

void comparison_float()
{
    clock_t begin, end;

    float l = 2e43, r = 11e53;

    begin = clock();
    run_float_sum_c(l, r, REPEAT_COUNT);
    end = clock();
    double time_sum_c = ((double)(end - begin)
                         / CLOCKS_PER_SEC
                         / REPEAT_COUNT);

    begin = clock();
    run_float_sum_asm(l, r, REPEAT_COUNT);
    end = clock();
    double time_sum_asm = ((double)(end - begin)
                           / CLOCKS_PER_SEC
                           / REPEAT_COUNT);

    begin = clock();
    run_float_mul_c(l, r, REPEAT_COUNT);
    end = clock();
    double time_mul_c = ((double)(end - begin)
                         / CLOCKS_PER_SEC
                         / REPEAT_COUNT);

    begin = clock();
    run_float_mul_asm(l, r, REPEAT_COUNT);
    end = clock();
    double time_mul_asm = ((double)(end - begin)
                           / CLOCKS_PER_SEC
                           / REPEAT_COUNT);

    printf(FRM_TABLE_ROW,
           "float", sizeof(float),
           time_sum_c, time_sum_asm, time_mul_c, time_mul_asm);
}
