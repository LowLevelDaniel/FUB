/*
* TUI = Keyboard UI
* GUI = Keyboard and Mouse UI
*/

extern void _start(void);
extern void halt(void);
extern void reboot(void);
extern void shutdown(void);

#include "drivers/idt.h"
#include "drivers/graphic.h"
#include "drivers/keyboard.h"

#include "libfub/terminal.h"

/*
* Called to reset the entire program
* This is not meant to return
* the function should reset the stack to stop any overflow
* nothing should be saved through _reset calls but is instead like a short reboot
*/
void _reset() {
  _start();
  // __asm__ ("jmp _start"); // this would also work and would be more explicit for assembly code as the code will not return here
}

/*
* Entry Point of Program
* Called in main.asm
* Return goes to a hlt statement
* Reboot is an already defined label
* Shutdown is an already defined label
*/
void kernel_main() {
  // Load Interrupt Descriptor Table
  isr_install();
  irq_install_setup(); // just enables interrupts
  // Setup Hardware Drivers
    // Timer (NotImplementYet)
    // Keyboard
  // Load Boot TUI
  // Not Implemented Yet
    run_terminal(); // calls _reset on exit
  return;
}

