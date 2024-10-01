# Global Descriptor Table
# It contains entries telling the CPU about memory segments
# http://wiki.osdev.org/Global_Descriptor_Table

.code16

gdt_start:
gdt_null:
	.long 0x0
	.long 0x0

# Kernel Code Segment
gdt_kernel_code:
	.word 0xFFFF
	.word 0x0
	.byte 0x0
	.byte 0b10011010
	.byte 0b11001111
	.byte 0x0

# Kernel Data Segment
gdt_kernel_data:
	.word 0xFFFF
	.word 0x0
	.byte 0x0
	.byte 0b10010010
	.byte 0b11001111
	.byte 0x0

# Userland Code Segment
gdt_userland_code:
	.word 0xFFFF
	.word 0x0
	.byte 0x0
	.byte 0b11111010
	.byte 0b11001111
	.byte 0x0

# Userland Data Segment
gdt_userland_data:
	.word 0xFFFF
	.word 0x0
	.byte 0x0
	.byte 0b11110010
	.byte 0b11001111
	.byte 0x0

gdt_end:
gdt_descriptor:
	.word gdt_end - gdt_start - 1
	.long gdt_start

.equ CODE_SEG, gdt_kernel_code - gdt_start
.equ DATA_SEG, gdt_kernel_data - gdt_start
