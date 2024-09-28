.global _start

.section .text
_start:
    /* Set up the stack pointer */
    ldr sp, =0x8000       /* Set the stack pointer to 0x8000 */

    /* Initialize UART */
    bl init_uart

    /* Print "Hello, World!" */
    ldr r0, =message
    bl print_string

    /* Infinite loop */
    b .

init_uart:
    /* UART base address for VersatilePB */
    ldr r1, =0x101f1000   /* UART1 base address */
    /* Set baud rate and other configurations if needed here */
    /* Placeholder for further UART setup */
    bx lr

print_string:
    ldr r1, =0x101f1000   /* UART1 base address */
.loop:
    ldrb r2, [r0], #1     /* Load byte from string and post-increment pointer */
    cmp r2, #0            /* Check if end of string (null terminator) */
    beq .done             /* If yes, finish */
    strb r2, [r1]         /* Send byte to UART */
    b .loop               /* Repeat for next character */
.done:
    bx lr

.section .data
message:
    .asciz "Hello, World!\n"  /* Null-terminated string */
