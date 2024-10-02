	.file	"idt.c"
	.text
	.globl	idt
	.bss
	.align 32
	.type	idt, @object
	.size	idt, 2048
idt:
	.zero	2048
	.globl	idt_reg
	.align 4
	.type	idt_reg, @object
	.size	idt_reg, 6
idt_reg:
	.zero	6
	.text
	.globl	set_idt_gate
	.type	set_idt_gate, @function
set_idt_gate:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	12(%ebp), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movw	%dx, idt(,%eax,8)
	movl	8(%ebp), %eax
	movw	$8, idt+2(,%eax,8)
	movl	8(%ebp), %eax
	movb	$0, idt+4(,%eax,8)
	movl	8(%ebp), %eax
	movb	$-114, idt+5(,%eax,8)
	movl	12(%ebp), %eax
	shrl	$16, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movw	%dx, idt+6(,%eax,8)
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	set_idt_gate, .-set_idt_gate
	.globl	set_idt
	.type	set_idt, @function
set_idt:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	$idt, %eax
	movl	%eax, idt_reg+2
	movw	$2047, idt_reg
	movl	$idt_reg, %eax
#APP
# 30 "sector2/drivers/cpu/idt.c" 1
	lidtl (%eax)
# 0 "" 2
#NO_APP
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	set_idt, .-set_idt
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
