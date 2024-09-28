# Research for my Bootloader
First things first i am pretty sure i need two bootloaders,
realistically i need one for the install phase and one for after install,
the bootloader to help with install should be pretty easy only requring a one time boot,
the bootloader after wil be harder but still within reason for the most part,
i only fear when the second bootloader is going to have to find the bootable devices and weather it can do this in the same way as the bios.

## Really Important, How can i write a bootloader for either arm or x86 when i have to write the code before knowing the system
windows can write a single installer that will automatically get the cpu type at startup to know which code to run but how,
if you think you can check the uefi or bios then try to understand how to write the assembly that checks this,
i see no real way to do this unless arm and x86 ensure a copmatibility between each other to understand their type.

#### How does the bios know the MBR

#### How to create a MBR

#### How does the uefi know the GPT

#### How to create a GPT
