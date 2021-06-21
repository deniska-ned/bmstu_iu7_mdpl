#include "unit_asm_strncpy.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "asm_string.h"

void pos_asnc_test(char *_src, size_t _copy_size, uint64_t _max_str_len,
                   char *_res)
{
    char *src = _src;
    char *dst = malloc(_copy_size);
    ck_assert_ptr_nonnull(dst);

    char *rc = asm_strncpy(dst, src, _max_str_len);

    ck_assert_ptr_eq(rc, dst);
    ck_assert_int_eq(0, strcmp(dst, _res));
}

START_TEST(pos_asnc_len_zero)
{
    pos_asnc_test("", 0, 1, "");
}
END_TEST

START_TEST(pos_asnc_len_one)
{
    pos_asnc_test("hello", 5, 1, "h");
}
END_TEST

START_TEST(pos_asnc_default)
{
    pos_asnc_test("hello", 6, 5, "hello");
}
END_TEST

START_TEST(pos_asnc_more_copy)
{
    pos_asnc_test("hello", 7, 6, "hello");
}
END_TEST

Suite *suite_create_asm_strncpy(void)
{
    Suite *s;
    TCase *tcase_pos;

    s = suite_create("asm_strncpy");

    tcase_pos = tcase_create("positive");

    tcase_add_test(tcase_pos, pos_asnc_len_zero);
    // tcase_add_test(tcase_pos, pos_asnc_len_one);
    tcase_add_test(tcase_pos, pos_asnc_default);
    tcase_add_test(tcase_pos, pos_asnc_more_copy);

    suite_add_tcase(s, tcase_pos);

    return s;
}
