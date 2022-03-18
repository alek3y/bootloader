[bits 16]
[org 0x7c00+512]
jmp main	; Avoid include files execution

%include "io/putchar.asm"

section .data
face: db ":)"

section .text
main:
	mov al, [face]
	call putchar
	mov al, [face+1]
	call putchar

	jmp $
