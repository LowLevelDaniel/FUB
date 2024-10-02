	.file	"timer.c"
	.text
	.globl	tick
	.bss
	.align 4
	.type	tick, @object
	.size	tick, 4
tick:
	.zero	4
	.text
	.type	timer_callback, @function
timer_callback:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	tick, %eax
	addl	$1, %eax
	movl	%eax, tick
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	timer_callback, .-timer_callback
	.globl	init_timer
	.type	init_timer, @function
init_timer:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$8, %esp
	pushl	$timer_callback
	pushl	$32
	call	register_interrupt_handler
	addl	$16, %esp
	movl	$1193180, %eax
	movl	$0, %edx
	divl	8(%ebp)
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movb	%al, -13(%ebp)
	movl	-12(%ebp), %eax
	shrl	$8, %eax
	movb	%al, -14(%ebp)
	subl	$8, %esp
	pushl	$54
	pushl	$67
	call	port_byte_out
	addl	$16, %esp
	movzbl	-13(%ebp), %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$64
	call	port_byte_out
	addl	$16, %esp
	movzbl	-14(%ebp), %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$64
	call	port_byte_out
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	init_timer, .-init_timer
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
