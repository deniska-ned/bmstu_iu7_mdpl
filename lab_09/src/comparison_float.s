	.file	"comparison_float.c"
	.text
	.globl	run_float_sum_c
	.type	run_float_sum_c, @function
run_float_sum_c:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movss	%xmm0, -20(%rbp)
	movss	%xmm1, -24(%rbp)
	movq	%rdi, -32(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L2
.L3:
	movss	-20(%rbp), %xmm0
	addss	-24(%rbp), %xmm0
	movss	%xmm0, -12(%rbp)
	addq	$1, -8(%rbp)
.L2:
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jb	.L3
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	run_float_sum_c, .-run_float_sum_c
	.globl	run_float_sum_asm
	.type	run_float_sum_asm, @function
run_float_sum_asm:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movss	%xmm0, -20(%rbp)
	movss	%xmm1, -24(%rbp)
	movq	%rdi, -32(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L5
.L6:
	movl	-20(%rbp), %eax
#APP
# 23 "comparison_float.c" 1
	fld %eax;fld -24(%rbp);faddp;fstp %eax;
# 0 "" 2
#NO_APP
	movl	%eax, -12(%rbp)
	addq	$1, -8(%rbp)
.L5:
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jb	.L6
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	run_float_sum_asm, .-run_float_sum_asm
	.globl	run_float_mul_c
	.type	run_float_mul_c, @function
run_float_mul_c:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movss	%xmm0, -20(%rbp)
	movss	%xmm1, -24(%rbp)
	movq	%rdi, -32(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L8
.L9:
	movss	-20(%rbp), %xmm0
	mulss	-24(%rbp), %xmm0
	movss	%xmm0, -12(%rbp)
	addq	$1, -8(%rbp)
.L8:
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jb	.L9
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	run_float_mul_c, .-run_float_mul_c
	.globl	run_float_mul_asm
	.type	run_float_mul_asm, @function
run_float_mul_asm:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movss	%xmm0, -36(%rbp)
	movss	%xmm1, -40(%rbp)
	movq	%rdi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -16(%rbp)
	jmp	.L11
.L12:
#APP
# 46 "comparison_float.c" 1
	fld -36(%rbp);fld -40(%rbp);fmulp;fstp -20(%rbp);
# 0 "" 2
#NO_APP
	addq	$1, -16(%rbp)
.L11:
	movq	-16(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jb	.L12
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	run_float_mul_asm, .-run_float_mul_asm
	.section	.rodata
.LC2:
	.string	"float"
	.align 8
.LC3:
	.string	"| %12s | %10zu | %10.3g | %10.3g | %10.3g | %10.3g |\n"
	.text
	.globl	comparison_float
	.type	comparison_float, @function
comparison_float:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, -56(%rbp)
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, -52(%rbp)
	call	clock@PLT
	movq	%rax, -48(%rbp)
	movss	-52(%rbp), %xmm0
	movl	-56(%rbp), %eax
	movl	$1000000, %edi
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	run_float_sum_c
	call	clock@PLT
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	subq	-48(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)
	call	clock@PLT
	movq	%rax, -48(%rbp)
	movss	-52(%rbp), %xmm0
	movl	-56(%rbp), %eax
	movl	$1000000, %edi
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	run_float_sum_asm
	call	clock@PLT
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	subq	-48(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -24(%rbp)
	call	clock@PLT
	movq	%rax, -48(%rbp)
	movss	-52(%rbp), %xmm0
	movl	-56(%rbp), %eax
	movl	$1000000, %edi
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	run_float_mul_c
	call	clock@PLT
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	subq	-48(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	call	clock@PLT
	movq	%rax, -48(%rbp)
	movss	-52(%rbp), %xmm0
	movl	-56(%rbp), %eax
	movl	$1000000, %edi
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	run_float_mul_asm
	call	clock@PLT
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	subq	-48(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	movsd	-8(%rbp), %xmm2
	movsd	-16(%rbp), %xmm1
	movsd	-24(%rbp), %xmm0
	movq	-32(%rbp), %rax
	movapd	%xmm2, %xmm3
	movapd	%xmm1, %xmm2
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	movl	$4, %edx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$4, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	comparison_float, .-comparison_float
	.section	.rodata
	.align 4
.LC0:
	.long	2139095040
	.align 8
.LC1:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 10.2.0-13ubuntu1) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
