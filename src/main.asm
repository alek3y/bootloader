[bits 16]
[org 0x7c00+512]
jmp main	; Avoid include files execution

%include "io/print.asm"

section .data
message: db "fugg an e", 0
h4x0r: db " h4x0r xDDDD", 0

section .text
main:
	mov al, 's'
	mov bx, message
	call print

	mov al, 'd'
	mov bx, 1337
	call print

	mov al, 's'
	mov bx, h4x0r
	call print

	jmp $
