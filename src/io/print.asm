%ifndef IO_PRINT
%define IO_PRINT

%include "io/putchar.asm"

; void print(char al, any bx)
;
; Parameters:
; - al: Format of the output
;   - 'c': Character (lower byte)
;   - 's': String (from an address)
;   - 'd': Integer
; - bx: Data to print
print:
	cmp al, 'c'
	je _io_print_print_format_char
	cmp al, 's'
	je _io_print_print_format_string
	cmp al, 'd'
	je _io_print_print_format_int

	jmp _io_print_print_ret

	_io_print_print_format_char:
		call putchar
		jmp _io_print_print_ret

	_io_print_print_format_string:
		call _io_print_string
		jmp _io_print_print_ret

	_io_print_print_format_int:
		call _io_print_int

	_io_print_print_ret:
		ret

; void _io_print_string(char *bx)
;
; Parameters:
; - bx: Address of the characters
_io_print_string:
	push bx

	_io_print_string_loop:
		push bx
		mov bl, byte [bx]
		call putchar
		pop bx

		inc bx	; Next character
		cmp byte [bx], 0x0	; Check for null byte
		jne _io_print_string_loop

	pop bx
	ret

; void _io_print_int(int bx)
;
; Parameters:
; - bx: Number to print
_io_print_int:
	pusha

	mov ax, bx	; Dividend
	mov dx, 0

	mov cx, 10	; Divisor
	div cx

	; Don't print the quotient if it's zero
	cmp ax, 0
	je _io_print_int_ret

	; Print the quotient (number without the rightmost digit)
	mov bx, ax
	call _io_print_int

	_io_print_int_ret:

		; Print the remainder
		mov bl, dl
		add bl, '0'
		call putchar

		popa
		ret

%endif
