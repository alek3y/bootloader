[bits 16]
[org 0x7c00+512]

mov ah, 0xe
mov al, 'H'
int 0x10
mov al, 'i'
int 0x10

jmp $
