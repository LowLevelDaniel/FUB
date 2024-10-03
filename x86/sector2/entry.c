extern void halt(void);
extern void reboot(void);
extern void shutdown(void);

#include "drivers/idt.h"
#include "drivers/graphic.h"

/*
* Entry Point of Program
* Called in main.asm
* Return goes to a hlt statement
* Reboot is an already defined label
* Shutdown is an already defined label
*/
void kernel_main() {
  screen_clear();

  // Load CPU Drivers
  isr_install();
  // irq_install_setup();

  return;
}

