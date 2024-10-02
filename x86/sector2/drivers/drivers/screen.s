	.file	"screen.c"
	.text
	.globl	print
	.type	print, @function
print:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$4, %esp
	pushl	$-1
	pushl	$-1
	pushl	8(%ebp)
	call	print_at
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	print, .-print
	.globl	print_at
	.type	print_at, @function
print_at:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	cmpl	$0, 12(%ebp)
	js	.L3
	cmpl	$0, 16(%ebp)
	js	.L3
	subl	$8, %esp
	pushl	16(%ebp)
	pushl	12(%ebp)
	call	get_offset
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	jmp	.L4
.L3:
	call	get_cursor_offset
	movl	%eax, -12(%ebp)
.L4:
	jmp	.L5
.L6:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	get_row_from_offset
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$12, %esp
	pushl	-12(%ebp)
	call	get_col_from_offset
	addl	$16, %esp
	movl	8(%ebp), %edx
	movzbl	(%edx), %edx
	movsbl	%dl, %edx
	pushl	$15
	pushl	%ebx
	pushl	%eax
	pushl	%edx
	call	print_char
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	addl	$1, 8(%ebp)
.L5:
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L6
	nop
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	print_at, .-print_at
	.globl	print_backspace
	.type	print_backspace, @function
print_backspace:
.LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	get_cursor_offset
	subl	$2, %eax
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	pushl	-12(%ebp)
	call	get_row_from_offset
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	-12(%ebp)
	call	get_col_from_offset
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	pushl	$15
	pushl	-16(%ebp)
	pushl	-20(%ebp)
	pushl	$8
	call	print_char
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	print_backspace, .-print_backspace
	.globl	clear_screen
	.type	clear_screen, @function
clear_screen:
.LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$0, -12(%ebp)
	jmp	.L9
.L12:
	movl	$0, -16(%ebp)
	jmp	.L10
.L11:
	pushl	$15
	pushl	-12(%ebp)
	pushl	-16(%ebp)
	pushl	$32
	call	print_char
	addl	$16, %esp
	addl	$1, -16(%ebp)
.L10:
	cmpl	$79, -16(%ebp)
	jle	.L11
	addl	$1, -12(%ebp)
.L9:
	cmpl	$24, -12(%ebp)
	jle	.L12
	subl	$8, %esp
	pushl	$0
	pushl	$0
	call	get_offset
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	set_cursor_offset
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	clear_screen, .-clear_screen
	.globl	print_char
	.type	print_char, @function
print_char:
.LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$52, %esp
	.cfi_offset 3, -12
	movl	8(%ebp), %eax
	movb	%al, -44(%ebp)
	cmpl	$0, 20(%ebp)
	jne	.L14
	movl	$15, 20(%ebp)
.L14:
	movl	$753664, -24(%ebp)
	cmpl	$0, 12(%ebp)
	js	.L15
	cmpl	$0, 16(%ebp)
	js	.L15
	subl	$8, %esp
	pushl	16(%ebp)
	pushl	12(%ebp)
	call	get_offset
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	jmp	.L16
.L15:
	call	get_cursor_offset
	movl	%eax, -12(%ebp)
.L16:
	cmpb	$10, -44(%ebp)
	jne	.L17
	subl	$12, %esp
	pushl	-12(%ebp)
	call	get_row_from_offset
	addl	$16, %esp
	movl	%eax, 16(%ebp)
	movl	16(%ebp), %eax
	addl	$1, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$0
	call	get_offset
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	jmp	.L18
.L17:
	movl	-12(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -12(%ebp)
	movl	%eax, %edx
	movl	-24(%ebp), %eax
	addl	%eax, %edx
	movzbl	-44(%ebp), %eax
	movb	%al, (%edx)
	movl	-12(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -12(%ebp)
	movl	%eax, %edx
	movl	-24(%ebp), %eax
	addl	%edx, %eax
	movl	20(%ebp), %edx
	movb	%dl, (%eax)
.L18:
	cmpl	$3999, -12(%ebp)
	jle	.L19
	movl	$1, -16(%ebp)
	jmp	.L20
.L21:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$0
	call	get_offset
	addl	$16, %esp
	addl	$753664, %eax
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	-16(%ebp)
	pushl	$0
	call	get_offset
	addl	$16, %esp
	addl	$753664, %eax
	subl	$4, %esp
	pushl	$160
	pushl	%ebx
	pushl	%eax
	call	memory_copy
	addl	$16, %esp
	addl	$1, -16(%ebp)
.L20:
	cmpl	$24, -16(%ebp)
	jle	.L21
	subl	$8, %esp
	pushl	$24
	pushl	$0
	call	get_offset
	addl	$16, %esp
	addl	$753664, %eax
	movl	%eax, -28(%ebp)
	movl	$0, -20(%ebp)
	jmp	.L22
.L23:
	movl	-20(%ebp), %edx
	movl	-28(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	addl	$1, -20(%ebp)
.L22:
	cmpl	$159, -20(%ebp)
	jle	.L23
	subl	$160, -12(%ebp)
.L19:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	set_cursor_offset
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	print_char, .-print_char
	.globl	get_cursor_offset
	.type	get_cursor_offset, @function
get_cursor_offset:
.LFB5:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$8, %esp
	pushl	$14
	pushl	$980
	call	port_byte_out
	addl	$16, %esp
	subl	$12, %esp
	pushl	$981
	call	port_byte_in
	addl	$16, %esp
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, -12(%ebp)
	subl	$8, %esp
	pushl	$15
	pushl	$980
	call	port_byte_out
	addl	$16, %esp
	subl	$12, %esp
	pushl	$981
	call	port_byte_in
	addl	$16, %esp
	movzbl	%al, %eax
	addl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	%eax, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	get_cursor_offset, .-get_cursor_offset
	.globl	set_cursor_offset
	.type	set_cursor_offset, @function
set_cursor_offset:
.LFB6:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, 8(%ebp)
	subl	$8, %esp
	pushl	$14
	pushl	$980
	call	port_byte_out
	addl	$16, %esp
	movl	8(%ebp), %eax
	sarl	$8, %eax
	movzbl	%al, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$981
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$15
	pushl	$980
	call	port_byte_out
	addl	$16, %esp
	movl	8(%ebp), %eax
	movzbl	%al, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$981
	call	port_byte_out
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	%eax, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	set_cursor_offset, .-set_cursor_offset
	.globl	get_offset
	.type	get_offset, @function
get_offset:
.LFB7:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	addl	%eax, %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	get_offset, .-get_offset
	.globl	get_row_from_offset
	.type	get_row_from_offset, @function
get_row_from_offset:
.LFB8:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %ecx
	movl	$1717986919, %edx
	movl	%ecx, %eax
	imull	%edx
	movl	%edx, %eax
	sarl	$6, %eax
	sarl	$31, %ecx
	movl	%ecx, %edx
	subl	%edx, %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	get_row_from_offset, .-get_row_from_offset
	.globl	get_col_from_offset
	.type	get_col_from_offset, @function
get_col_from_offset:
.LFB9:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	8(%ebp)
	call	get_row_from_offset
	addl	$4, %esp
	imull	$-160, %eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	get_col_from_offset, .-get_col_from_offset
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
