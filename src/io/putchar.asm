%ifndef IO_PUTCHAR
%define IO_PUTCHAR

; void putchar(char bl)
;
; Parameters:
; - bl: Character to print to the screen
putchar:
	push ax

	mov ah, 0xe
	mov al, bl
	int 0x10

	pop ax
	ret

%endif
