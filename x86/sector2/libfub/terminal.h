/*
* The FUB Terminal
* when run_terminal is called it will block execution of the main program until the terminal registers an exit command
* on exit it will jump back to the _start function which will rerun the kernel_main function
*/
void run_terminal();
