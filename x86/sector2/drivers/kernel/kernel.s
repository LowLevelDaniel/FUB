	.file	"kernel.c"
	.text
	.globl	kernel_main
	.type	kernel_main, @function
kernel_main:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	kernel_main, .-kernel_main
	.section	.rodata
.LC0:
	.string	"END"
.LC1:
	.string	"Stopping the CPU. Bye!\n"
.LC2:
	.string	"You said: "
.LC3:
	.string	"\n> "
	.text
	.globl	user_input
	.type	user_input, @function
user_input:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$8, %esp
	pushl	$.LC0
	pushl	8(%ebp)
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L3
	subl	$12, %esp
	pushl	$.LC1
	call	print
	addl	$16, %esp
#APP
# 20 "sector2/drivers/kernel/kernel.c" 1
	hlt
# 0 "" 2
#NO_APP
.L3:
	subl	$12, %esp
	pushl	$.LC2
	call	print
	addl	$16, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	print
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC3
	call	print
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	user_input, .-user_input
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
