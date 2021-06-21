#include <stdio.h>

#include <check.h>

#include "unit_asm_strlen.h"
#include "unit_asm_strncpy.h"

#define SUITE_FUNC_COUNT 2

typedef Suite *(*suite_func_t)(void);

#include <stdlib.h>

int main(void)
{
    int num_failed = 0;

    Suite *s;
    SRunner *runner;

    suite_func_t suite_create_arr[SUITE_FUNC_COUNT] = {
        suite_create_asm_strlen,
        suite_create_asm_strncpy
    };

    for (int i = 0; i < SUITE_FUNC_COUNT; ++i)
    {
        s = suite_create_arr[i]();

        runner = srunner_create(s);
        srunner_run_all(runner, CK_VERBOSE);
        num_failed += srunner_ntests_failed(runner);
        srunner_free(runner);
        printf("\n");
    }

    printf("Num failed == %d\n", num_failed);
    return (0 == num_failed) ? 0 : -1;
}
