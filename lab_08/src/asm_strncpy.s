    .file   "asm_string.c"
    .text
    .globl  asm_strncpy
    .type   asm_strncpy,   @function
asm_strncpy:
.LFB0:
    .cfi_startproc
    pushq   %rbp
    movq    %rsp,   %rbp

    /* rdi = dst */
    /* rsi = src */
    /* rdx = len */

    movq %rdx, %rcx
    movq %rdi, %rbx

    cmpq %rsi, %rdi
    je exit
    jl copy
    movq %rdi, %rax
    subq %rsi, %rax

    cmpq %rdx, %rax
    jge copy
    addq %rdx, %rdi
    decq %rdi
    addq %rdx, %rsi
    decq %rsi

    std
copy:
    rep movsb
    cld
exit:
    movq %rbx, %rax

    popq    %rbp
    ret
    .cfi_endproc
.LFE0:
