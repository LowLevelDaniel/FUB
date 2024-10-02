	.file	"keyboard.c"
	.text
	.local	key_buffer
	.comm	key_buffer,256,32
	.globl	sc_name
	.section	.rodata
.LC0:
	.string	"ERROR"
.LC1:
	.string	"Esc"
.LC2:
	.string	"1"
.LC3:
	.string	"2"
.LC4:
	.string	"3"
.LC5:
	.string	"4"
.LC6:
	.string	"5"
.LC7:
	.string	"6"
.LC8:
	.string	"7"
.LC9:
	.string	"8"
.LC10:
	.string	"9"
.LC11:
	.string	"0"
.LC12:
	.string	"-"
.LC13:
	.string	"="
.LC14:
	.string	"Backspace"
.LC15:
	.string	"Tab"
.LC16:
	.string	"Q"
.LC17:
	.string	"W"
.LC18:
	.string	"E"
.LC19:
	.string	"R"
.LC20:
	.string	"T"
.LC21:
	.string	"Y"
.LC22:
	.string	"U"
.LC23:
	.string	"I"
.LC24:
	.string	"O"
.LC25:
	.string	"P"
.LC26:
	.string	"["
.LC27:
	.string	"]"
.LC28:
	.string	"Enter"
.LC29:
	.string	"Lctrl"
.LC30:
	.string	"A"
.LC31:
	.string	"S"
.LC32:
	.string	"D"
.LC33:
	.string	"F"
.LC34:
	.string	"G"
.LC35:
	.string	"H"
.LC36:
	.string	"J"
.LC37:
	.string	"K"
.LC38:
	.string	"L"
.LC39:
	.string	";"
.LC40:
	.string	"'"
.LC41:
	.string	"`"
.LC42:
	.string	"LShift"
.LC43:
	.string	"\\"
.LC44:
	.string	"Z"
.LC45:
	.string	"X"
.LC46:
	.string	"C"
.LC47:
	.string	"V"
.LC48:
	.string	"B"
.LC49:
	.string	"N"
.LC50:
	.string	"M"
.LC51:
	.string	","
.LC52:
	.string	"."
.LC53:
	.string	"/"
.LC54:
	.string	"RShift"
.LC55:
	.string	"Keypad *"
.LC56:
	.string	"LAlt"
.LC57:
	.string	"Spacebar"
	.data
	.align 32
	.type	sc_name, @object
	.size	sc_name, 232
sc_name:
	.long	.LC0
	.long	.LC1
	.long	.LC2
	.long	.LC3
	.long	.LC4
	.long	.LC5
	.long	.LC6
	.long	.LC7
	.long	.LC8
	.long	.LC9
	.long	.LC10
	.long	.LC11
	.long	.LC12
	.long	.LC13
	.long	.LC14
	.long	.LC15
	.long	.LC16
	.long	.LC17
	.long	.LC18
	.long	.LC19
	.long	.LC20
	.long	.LC21
	.long	.LC22
	.long	.LC23
	.long	.LC24
	.long	.LC25
	.long	.LC26
	.long	.LC27
	.long	.LC28
	.long	.LC29
	.long	.LC30
	.long	.LC31
	.long	.LC32
	.long	.LC33
	.long	.LC34
	.long	.LC35
	.long	.LC36
	.long	.LC37
	.long	.LC38
	.long	.LC39
	.long	.LC40
	.long	.LC41
	.long	.LC42
	.long	.LC43
	.long	.LC44
	.long	.LC45
	.long	.LC46
	.long	.LC47
	.long	.LC48
	.long	.LC49
	.long	.LC50
	.long	.LC51
	.long	.LC52
	.long	.LC53
	.long	.LC54
	.long	.LC55
	.long	.LC56
	.long	.LC57
	.globl	sc_ascii
	.section	.rodata
	.align 32
	.type	sc_ascii, @object
	.size	sc_ascii, 58
sc_ascii:
	.ascii	"??1234567890-=??QWERTYUIOP[]??ASDFGHJKL;'`?\\ZXCVBNM,./??? "
.LC58:
	.string	"\n"
	.text
	.type	keyboard_callback, @function
keyboard_callback:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$12, %esp
	pushl	$96
	call	port_byte_in
	addl	$16, %esp
	movb	%al, -9(%ebp)
	cmpb	$57, -9(%ebp)
	ja	.L6
	cmpb	$14, -9(%ebp)
	jne	.L4
	subl	$12, %esp
	pushl	$key_buffer
	call	backspace
	addl	$16, %esp
	call	print_backspace
	jmp	.L1
.L4:
	cmpb	$28, -9(%ebp)
	jne	.L5
	subl	$12, %esp
	pushl	$.LC58
	call	print
	addl	$16, %esp
	subl	$12, %esp
	pushl	$key_buffer
	call	user_input
	addl	$16, %esp
	movb	$0, key_buffer
	jmp	.L1
.L5:
	movzbl	-9(%ebp), %eax
	movzbl	sc_ascii(%eax), %eax
	movb	%al, -10(%ebp)
	movzbl	-10(%ebp), %eax
	movb	%al, -12(%ebp)
	movb	$0, -11(%ebp)
	movsbl	-10(%ebp), %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$key_buffer
	call	append
	addl	$16, %esp
	subl	$12, %esp
	leal	-12(%ebp), %eax
	pushl	%eax
	call	print
	addl	$16, %esp
	jmp	.L1
.L6:
	nop
.L1:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	keyboard_callback, .-keyboard_callback
	.globl	init_keyboard
	.type	init_keyboard, @function
init_keyboard:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$8, %esp
	pushl	$keyboard_callback
	pushl	$33
	call	register_interrupt_handler
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	init_keyboard, .-init_keyboard
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
