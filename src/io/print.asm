%ifndef IO_PRINT
%define IO_PRINT

%include "io/putchar.asm"

; void print(char al, any bx)
;
; Parameters:
; - al: Format of the output
;   - 'c': Character (lower byte)
;   - 's': String (from an address)
;   - 'd': Integer (TODO)
; - bx: Data to print
;
; Returns:
; - cx: Length of the output (TODO)
print:
	push ax
	push bx

	cmp al, 'c'
	je _io_print_print_format_char
	cmp al, 's'
	je _io_print_print_format_string

	jmp _io_print_print_ret

	_io_print_print_format_char:
		mov al, bl
		call putchar
		jmp _io_print_print_ret

	_io_print_print_format_string:
		push bx
		mov bl, byte [bx]
		call putchar
		pop bx

		inc bx	; Next character
		cmp byte [bx], 0x0	; Check for null byte
		jne _io_print_print_format_string

		jmp _io_print_print_ret

	_io_print_print_ret:
		pop bx
		pop ax
		ret

_io_print_string:
	ret

%endif
