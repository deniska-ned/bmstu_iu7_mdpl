#include "unit_asm_strlen.h"

#include <string.h>

#include "asm_string.h"

START_TEST(pos_asl_zero_len)
{
    char *str = "";
    ck_assert_uint_eq(strlen(str), asm_strlen(str));
}

START_TEST(pos_asl_len_1)
{
    char *str = "1";
    ck_assert_uint_eq(strlen(str), asm_strlen(str));
}

START_TEST(pos_asl_len_10)
{
    char *str = "1234567890";
    ck_assert_uint_eq(strlen(str), asm_strlen(str));
}

Suite *suite_create_asm_strlen(void)
{
    Suite *s;
    TCase *tcase_pos;

    s = suite_create("asm_strlen");

    tcase_pos = tcase_create("positive");

    tcase_add_test(tcase_pos, pos_asl_zero_len);
    tcase_add_test(tcase_pos, pos_asl_len_1);
    tcase_add_test(tcase_pos, pos_asl_len_10);

    suite_add_tcase(s, tcase_pos);

    return s;
}
