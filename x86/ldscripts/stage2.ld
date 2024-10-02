/* if any more potenitial linker erros just allign stuff here */
ENTRY(_start)
SECTIONS
{
  . = 0x1000;
  .KernelEntryPoint : { *(.KernelEntryPoint*) }
  .text : { *(.text*) }
  .rodata : { *(.rodata*) } /* .rodata is the section used by gcc */
  .data : { *(.data*) }
  .bss : { *(.bss*) }
}

