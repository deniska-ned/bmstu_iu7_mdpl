#include "comparison_table.h"

#include <stdio.h>

#include "comparison_float.h"
#include "comparison_double.h"
#include "comparison_long_double.h"
#include "utils.h"

void print_real_comparison_table()
{
    printf(FRM_TABLE_HEADER,
           "type", "type size",
           "sum c s", "sum asm s", "mul c s", "mul c asm");
    printf(TABLE_UNDER_HEADER);

    comparison_float();
    compatison_double();
    comparison_long_double();
}