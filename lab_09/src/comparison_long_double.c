#include "utils.h"

#include <stddef.h>
#include <stdio.h>
#include <time.h>

#include "comparison_long_double.h"

#ifndef MNO
void run_long_double_sum_c(long double l, long double r, size_t loop_count)
{
    long double c;
    for (size_t i = 0; i < loop_count; ++i)
        c = l + r;
}
#endif // MNO

void run_long_double_sum_asm(long double l, long double r, size_t loop_count)
{
    long double c;

    for (size_t i = 0; i < loop_count; ++i)
        asm("fld %1\n"
            "fld %2\n"
            "faddp\n"
            "fstp %0\n"
            : "=m"(c)
            : "m"(l), "m"(r));
}

#ifndef MNO
void run_long_double_mul_c(long double l, long double r, size_t loop_count)
{
    long double c;
    for (size_t i = 0; i < loop_count; ++i)
        c = l * r;
}
#endif

void run_long_double_mul_asm(long double l, long double r, size_t loop_count)
{
    long double c;

    for (size_t i = 0; i < loop_count; ++i)
        asm("fld %1\n"
            "fld %2\n"
            "fmulp\n"
            "fstp %0\n"
            : "=m"(c)
            : "m"(l), "m"(r));
}

void comparison_long_double()
{
    long double l = 2e43, r = 11e53;

    clock_t begin, end;


    double time_sum_c;
#ifndef MNO
    begin = clock();
    run_long_double_sum_c(l, r, REPEAT_COUNT);
    end = clock();
    time_sum_c = ((double)(end - begin)
                         / CLOCKS_PER_SEC
                         / REPEAT_COUNT);
#endif

    begin = clock();
    run_long_double_sum_asm(l, r, REPEAT_COUNT);
    end = clock();
    double time_sum_asm = ((double)(end - begin)
                           / CLOCKS_PER_SEC
                           / REPEAT_COUNT);

    double time_mul_c;
#ifndef MNO
    begin = clock();
    run_long_double_mul_c(l, r, REPEAT_COUNT);
    end = clock();
    time_mul_c = ((double)(end - begin)
                         / CLOCKS_PER_SEC
                         / REPEAT_COUNT);
#endif

    begin = clock();
    run_long_double_mul_asm(l, r, REPEAT_COUNT);
    end = clock();
    double time_mul_asm = ((double)(end - begin)
                           / CLOCKS_PER_SEC
                           / REPEAT_COUNT);

    printf(FRM_TABLE_ROW,
           "long_double", sizeof(long double),
           time_sum_c, time_sum_asm, time_mul_c, time_mul_asm);
}
