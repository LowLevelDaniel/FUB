.global _start

.section .text
_start:
    ldr sp, =0x8000               /* Set stack pointer */
    ldr r0, =0x101f1000           /* UART base address */
    ldr r1, =message
.loop:
    ldrb r2, [r1], #1              /* Load byte */
    cmp r2, #0                     /* Check for null terminator */
    beq .done                      /* If end, exit */
    strb r2, [r0]                 /* Output character */
    b .loop                        /* Repeat */
.done:
    b .done                        /* Loop infinitely */

.section .data
message:
    .asciz "Hello, World!\n"      /* Null-terminated string */
