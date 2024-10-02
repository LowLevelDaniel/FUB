	.file	"isr.c"
	.text
	.globl	interrupt_handlers
	.bss
	.align 32
	.type	interrupt_handlers, @object
	.size	interrupt_handlers, 1024
interrupt_handlers:
	.zero	1024
	.globl	exception_messages
	.section	.rodata
.LC0:
	.string	"Division By Zero"
.LC1:
	.string	"Debug"
.LC2:
	.string	"Non Maskable Interrupt"
.LC3:
	.string	"Breakpoint"
.LC4:
	.string	"Into Detected Overflow"
.LC5:
	.string	"Out of Bounds"
.LC6:
	.string	"Invalid Opcode"
.LC7:
	.string	"No Coprocessor"
.LC8:
	.string	"Double Fault"
.LC9:
	.string	"Coprocessor Segment Overrun"
.LC10:
	.string	"Bad TSS"
.LC11:
	.string	"Segment Not Present"
.LC12:
	.string	"Stack Fault"
.LC13:
	.string	"General Protection Fault"
.LC14:
	.string	"Page Fault"
.LC15:
	.string	"Unknown Interrupt"
.LC16:
	.string	"Coprocessor Fault"
.LC17:
	.string	"Alignment Check"
.LC18:
	.string	"Machine Check"
.LC19:
	.string	"Reserved"
	.data
	.align 32
	.type	exception_messages, @object
	.size	exception_messages, 128
exception_messages:
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
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.long	.LC19
	.text
	.globl	isr_install
	.type	isr_install, @function
isr_install:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	$isr0, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$0
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr1, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$1
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr2, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$2
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr3, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$3
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr4, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$4
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr5, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$5
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr6, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$6
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr7, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$7
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr8, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$8
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr9, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$9
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr10, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$10
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr11, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$11
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr12, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$12
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr13, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$13
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr14, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$14
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr15, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$15
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr16, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$16
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr17, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$17
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr18, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$18
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr19, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$19
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr20, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$20
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr21, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$21
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr22, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$22
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr23, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$23
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr24, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$24
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr25, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$25
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr26, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$26
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr27, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$27
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr28, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$28
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr29, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$29
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr30, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$30
	call	set_idt_gate
	addl	$16, %esp
	movl	$isr31, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$31
	call	set_idt_gate
	addl	$16, %esp
	subl	$8, %esp
	pushl	$17
	pushl	$32
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$17
	pushl	$160
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$32
	pushl	$33
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$40
	pushl	$161
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$4
	pushl	$33
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$2
	pushl	$161
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$1
	pushl	$33
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$1
	pushl	$161
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$33
	call	port_byte_out
	addl	$16, %esp
	subl	$8, %esp
	pushl	$0
	pushl	$161
	call	port_byte_out
	addl	$16, %esp
	movl	$irq0, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$32
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq1, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$33
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq2, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$34
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq3, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$35
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq4, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$36
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq5, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$37
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq6, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$38
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq7, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$39
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq8, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$40
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq9, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$41
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq10, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$42
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq11, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$43
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq12, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$44
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq13, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$45
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq14, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$46
	call	set_idt_gate
	addl	$16, %esp
	movl	$irq15, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$47
	call	set_idt_gate
	addl	$16, %esp
	call	set_idt
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	isr_install, .-isr_install
	.section	.rodata
.LC20:
	.string	"Received interrupt: "
.LC21:
	.string	"\n"
	.text
	.globl	isr_handler
	.type	isr_handler, @function
isr_handler:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$12, %esp
	pushl	$.LC20
	call	print
	addl	$16, %esp
	movl	44(%ebp), %eax
	movl	%eax, %edx
	subl	$8, %esp
	leal	-11(%ebp), %eax
	pushl	%eax
	pushl	%edx
	call	itoa
	addl	$16, %esp
	subl	$12, %esp
	leal	-11(%ebp), %eax
	pushl	%eax
	call	print
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC21
	call	print
	addl	$16, %esp
	movl	44(%ebp), %eax
	movl	exception_messages(,%eax,4), %eax
	subl	$12, %esp
	pushl	%eax
	call	print
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC21
	call	print
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	isr_handler, .-isr_handler
	.globl	irq_install
	.type	irq_install, @function
irq_install:
.LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
#APP
# 138 "sector2/drivers/cpu/isr.c" 1
	sti
# 0 "" 2
#NO_APP
	subl	$12, %esp
	pushl	$50
	call	init_timer
	addl	$16, %esp
	call	init_keyboard
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	irq_install, .-irq_install
	.globl	irq_handler
	.type	irq_handler, @function
irq_handler:
.LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	44(%ebp), %eax
	cmpl	$39, %eax
	jbe	.L5
	subl	$8, %esp
	pushl	$32
	pushl	$160
	call	port_byte_out
	addl	$16, %esp
.L5:
	subl	$8, %esp
	pushl	$32
	pushl	$32
	call	port_byte_out
	addl	$16, %esp
	movl	44(%ebp), %eax
	movl	interrupt_handlers(,%eax,4), %eax
	testl	%eax, %eax
	je	.L7
	movl	44(%ebp), %eax
	movl	interrupt_handlers(,%eax,4), %eax
	movl	%eax, -12(%ebp)
	pushl	68(%ebp)
	pushl	64(%ebp)
	pushl	60(%ebp)
	pushl	56(%ebp)
	pushl	52(%ebp)
	pushl	48(%ebp)
	pushl	44(%ebp)
	pushl	40(%ebp)
	pushl	36(%ebp)
	pushl	32(%ebp)
	pushl	28(%ebp)
	pushl	24(%ebp)
	pushl	20(%ebp)
	pushl	16(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	movl	-12(%ebp), %eax
	call	*%eax
	addl	$64, %esp
.L7:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	irq_handler, .-irq_handler
	.globl	register_interrupt_handler
	.type	register_interrupt_handler, @function
register_interrupt_handler:
.LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	8(%ebp), %eax
	movb	%al, -4(%ebp)
	movzbl	-4(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, interrupt_handlers(,%eax,4)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	register_interrupt_handler, .-register_interrupt_handler
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
