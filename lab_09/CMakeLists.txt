cmake_minimum_required(VERSION 3.0)

project(c_and_asm C)

set(CMAKE_C_STANDARD 99)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(APP_NAME_WITHOUT_FLAGS c_and_asm)
set(APP_NAME_WITH_m80387  c_and_asm-m80387)
set(APP_NAME_WITH_mno_80387 c_and_asm-mno-80387)

add_executable(${APP_NAME_WITHOUT_FLAGS}
        src/main.c
        src/comparison_float.h
        src/comparison_float.c
        src/comparison_double.h
        src/comparison_double.c
        src/comparison_long_double.h
        src/comparison_long_double.c
        src/utils.h
        src/comparison_table.h
        src/comparison_table.c
        src/comparison_sin_pi.h
        src/comparison_sin_pi.c
        )

target_compile_options(${APP_NAME_WITHOUT_FLAGS} PRIVATE -masm=intel)

target_include_directories(${APP_NAME_WITHOUT_FLAGS} PRIVATE
        src/
        )


add_executable(${APP_NAME_WITH_m80387}
        src/main.c
        src/comparison_float.h
        src/comparison_float.c
        src/comparison_double.h
        src/comparison_double.c
        src/comparison_long_double.h
        src/comparison_long_double.c
        src/utils.h
        src/comparison_table.h
        src/comparison_table.c
        src/comparison_sin_pi.h
        src/comparison_sin_pi.c
        )

target_compile_options(${APP_NAME_WITH_m80387} PRIVATE
        -masm=intel
        -m80387
        )

target_include_directories(${APP_NAME_WITH_m80387} PRIVATE
        src/
        )


add_executable(${APP_NAME_WITH_mno_80387}
        src/main.c
        src/comparison_float.h
        src/comparison_float.c
        src/comparison_double.h
        src/comparison_double.c
        src/comparison_long_double.h
        src/comparison_long_double.c
        src/utils.h
        src/comparison_table.h
        src/comparison_table.c
        src/comparison_sin_pi.h
        src/comparison_sin_pi.c
        )

target_compile_options(${APP_NAME_WITH_mno_80387} PRIVATE
        -masm=intel
        -mno-80387
        -DMNO
)

target_include_directories(${APP_NAME_WITH_mno_80387} PRIVATE
        src/
        )
