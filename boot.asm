; Lists of BIOS interrupts:
; - http://www.ctyme.com/intr/int.htm
; - https://w.wiki/3GRJ

[bits 16]	; NASM directive for switching the bits (see nasm(1))

; Because of old IBM BIOS specification, the BIOS loads the bootloader at address 0x7c00,
; so this is telling the compiler where it is going to be stored. This is to prevent NASM
; from guessing wrong when using long jumps.
;
; Sources:
; - https://stackoverflow.com/a/46813144
; - http://www.ctyme.com/intr/rb-2270.htm
[org 0x7c00]

; Because the bootloader is loaded at 0x7c00 we can use the range 0x0000-0x7c00 as
; the stack, and because it's descending the values will be pushed towards 0x0000.
mov bp, 0x7c00
mov sp, bp	; Stack pointer = base pointer, which means the stack is empty

jmp load	; Avoid include files execution

%include "io/putchar.asm"
%include "io/read.asm"

; Read the rest of the code from disk
load:

	; Place on the disk to read the code from
	mov dh, 0x0	; Head
	mov ch, 0x0	; Cylinder
	mov cl, 0x2	; Sector (1st is the bootloader)

	; This idea of using a near jump instead of a long jump comes from the disk
	; load example inside of https://github.com/cirosantilli/x86-bare-metal-examples
	mov bx, code	; Address in RAM where to put the loaded sectors

	mov al, SECTORS_TO_LOAD	; NOTE: These are the sectors that will be read (aka binary size)
	call read

	push SECTORS_TO_LOAD	; Save the read sector count for the code to retrieve it
	jnc code	; Run when read successfully

; DEBUG: Print and halt when code couldn't be loaded
mov bl, '!'
call putchar
jmp $	; Loop indefinitely

; Fill up the remaining space of the boot sector (except for the signature) with
; zeroes. '$$' is the origin of the code (0x7c00) and '$' is the address of the
; current instruction.
times 510-($-$$) db 0x0

; Required signature for the BIOS to boot the image
db 0x55
db 0xaa

code:
