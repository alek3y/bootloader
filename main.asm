; List of common BIOS interrupts: https://w.wiki/3GRJ

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

; Proves that $$ is 0x7c00
mov ax, $$
mov al, ah
mov ah, 0x0e
int 0x10

jmp $

; Fill up the remaining space of the boot sector (except for the signature) with
; zeroes. '$$' is the origin of the code (0x7c00) and '$' is the address of the
; current instruction.
times 510-($-$$) db 0

; Required signature for the BIOS to boot the image
db 0x55
db 0xaa
