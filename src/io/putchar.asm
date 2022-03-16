%ifndef IO_PUTCHAR
%define IO_PUTCHAR

; void putchar(char al)
;
; Parameters:
; - al: Character to print to the screen
putchar:
	push ax

	mov ah, 0xe
	int 0x10

	pop ax
	ret

%endif
