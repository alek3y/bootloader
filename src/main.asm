[bits 16]
[org 0x7c00+512]
jmp main

%include "io/print.asm"
%include "io/read.asm"

section .data
data: db 0

section .text
main:
	pop bx	; Pull the code sector count
	add bx, 0x2	; Offset by code sector number

	mov dh, 0x0
	mov ch, 0x0
	mov cl, bl
	mov bx, lebear
	mov al, 1
	call read

	mov al, 's'
	mov bl, lebear
	call print

	jmp $

section .bss
lebear: resb 512
