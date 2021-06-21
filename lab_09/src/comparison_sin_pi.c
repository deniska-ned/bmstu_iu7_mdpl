#include "comparison_sin_pi.h"

#include <math.h>
#include <stdio.h>


void print_sin_comparison()
{ double res = 0.0;

    printf("\n");
    printf("sin(pi)\n");
    printf("3.14        | %g\n", sin(3.14));
    printf("3.141596    | %g\n", sin(3.141596));

    asm("fldpi\n"
        "fsin\n"
        "fstp %0\n" ::"m"(res));
    printf("fpu         | %g\n", res);

    printf("\n");
    printf("sin(pi/2)\n");
    printf("3.14 / 2    | %g\n", sin(3.14 / 2));
    printf("3.141596 / 2| %g\n", sin(3.141596 / 2));

    res = 2.0;
    asm("fldpi\n"
        "fld1\n"
        "fld1\n"
        "faddp\n"
        "fdiv\n"
        "fsin\n"
        "fstp %0\n"
    : "=m"(res));
    printf("fpu         | %g\n", res);

    printf("\n");
}
