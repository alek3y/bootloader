[bits 16]
[org 0x7c00+512]

jmp main	; Avoid include files execution

%include "io/putchar.asm"

main:
	mov al, 'H'
	call putchar
	mov al, 'i'
	call putchar

	jmp $
