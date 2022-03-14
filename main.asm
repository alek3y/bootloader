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

; Read the rest of the code from disk
load:
	call reset

	; This idea of using a near jump instead of a long jump comes from the disk
	; load example inside of https://github.com/cirosantilli/x86-bare-metal-examples
	mov bx, code	; Address in RAM where to put the loaded sectors

	mov ah, 0x2	; http://www.ctyme.com/intr/rb-0607.htm
	mov al, 0x1	; Sectors to read

	; Place on the disk to read from
	mov ch, 0x0	; Cylinder
	mov cl, 0x2	; Sector (1st is the bootloader)
	mov dh, 0x0	; Head
	mov dl, 0b10000000	; Disk number (bit 7 for HDD)
	int 0x13

	jc load

jmp code

; DEBUG: Print and halt when code couldn't be loaded
mov ah, 0xe	; http://www.ctyme.com/intr/rb-0106.htm
mov al, '!'
int 0x10
jmp $	; Loop indefinitely

reset:
	mov ah, 0x0	; http://www.ctyme.com/intr/rb-0605.htm
	mov dl, 0x0	; Disk number
	int 0x13
	jc reset	; Retry on error (carry is set)
	ret

; Fill up the remaining space of the boot sector (except for the signature) with
; zeroes. '$$' is the origin of the code (0x7c00) and '$' is the address of the
; current instruction.
times 510-($-$$) db 0x0

; Required signature for the BIOS to boot the image
db 0x55
db 0xaa

code:
	mov al, ':'
	mov ah, 0xe
	int 0x10
	mov al, ')'
	int 0x10
	jmp $
	times 512-($-code) db 0
