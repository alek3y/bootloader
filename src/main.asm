[bits 16]
[org 0x7c00+512]
jmp main	; Avoid include files execution

%include "io/print.asm"

section .data
message: db "fugg xDDD", 0

section .text
main:
	mov al, 's'
	mov bx, message
	call print

	jmp $
