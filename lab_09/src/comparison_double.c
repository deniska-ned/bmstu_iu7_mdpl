#include "comparison_double.h"

#include <stddef.h>
#include <stdio.h>
#include <time.h>

#include "utils.h"

void run_double_sum_c(double l, double r, size_t loop_count)
{
    double c;
    for (size_t i = 0; i < loop_count; ++i)
        c = l + r;
}

void run_double_sum_asm(double l, double r, size_t loop_count)
{
    double c;
    for (size_t i = 0; i < loop_count; ++i)
        asm("fld %1\n"
            "fld %2\n"
            "faddp\n"
            "fstp %0\n"
            : "=m"(c)
            : "m"(l), "m"(r));
}

void run_double_mul_c(double l, double r, size_t loop_count)
{
    double c;
    for (size_t i = 0; i < loop_count; ++i)
        c = l * r;
}

void run_double_mul_asm(double a, double b, size_t loop_count)
{
    double c;
    for (size_t i = 0; i < loop_count; ++i)
        asm("fld %1\n"
            "fld %2\n"
            "fmulp\n"
            "fstp %0\n"
            : "=m"(c)
            : "m"(a), "m"(b)
            :);
}

void compatison_double()
{
    clock_t begin, end;

    double a = 2e43, b = 11e53;

    begin = clock();
    run_double_sum_c(a, b, REPEAT_COUNT);
    end = clock();
    double time_sum_c = ((double)(end - begin)
                         / CLOCKS_PER_SEC
                         / REPEAT_COUNT);

    begin = clock();
    run_double_sum_asm(a, b, REPEAT_COUNT);
    end = clock();
    double time_sum_asm = ((double)(end - begin)
                           / CLOCKS_PER_SEC
                           / REPEAT_COUNT);

    begin = clock();
    run_double_mul_c(a, b, REPEAT_COUNT);
    end = clock();
    double time_mul_c = ((double)(end - begin)
                         / CLOCKS_PER_SEC
                         / REPEAT_COUNT);

    begin = clock();
    run_double_mul_asm(a, b, REPEAT_COUNT);
    end = clock();
    double time_mul_asm = ((double)(end - begin)
                           / CLOCKS_PER_SEC
                           / REPEAT_COUNT);

    printf(FRM_TABLE_ROW,
           "double", sizeof(double),
           time_sum_c, time_sum_asm, time_mul_c, time_mul_asm);
}
