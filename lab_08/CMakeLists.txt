cmake_minimum_required(VERSION 3.0)

project(c_and_asm C ASM)

set(CMAKE_C_STANDARD 99)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(BUILD_SHARED_LIBS OFF)

set(ASM_STRING_LIB_NAME asm_string)

set(ASM_STRING_TESTS_LIB_NAME asm_string_tests)

set_source_files_properties(src/asm_strncpy.s PROPERTIES COMPILE_FLAGS "-x assembler-with-cpp")

add_library(${ASM_STRING_LIB_NAME} STATIC
    src/asm_strlen.c
    src/asm_strncpy.s
    )

target_include_directories(${ASM_STRING_LIB_NAME} PRIVATE
    include/asm_string/
    src/
    )

add_executable(${ASM_STRING_TESTS_LIB_NAME}
    test/unit_main.c
    test/unit_asm_strlen.h
    test/unit_asm_strlen.c
    test/unit_asm_strncpy.h
    test/unit_asm_strncpy.c
    )

target_link_libraries(${ASM_STRING_TESTS_LIB_NAME} PRIVATE
    ${ASM_STRING_LIB_NAME}
    check
    pthread
    rt
    )

target_include_directories(${ASM_STRING_TESTS_LIB_NAME} PRIVATE
    include/asm_string/
    test/
    )
