%ifndef GRAPHICS_INIT
%define GRAPHICS_INIT

; void graphics_init(void)
graphics_init:
	push ax
	mov ah, 0x00	; http://www.ctyme.com/intr/rb-0069.htm
	mov al, 0x13
	int 0x10
	pop ax
	ret

; void graphics_draw(int al, int cx, int dx)
;
; Parameters:
; - al: Pixel color
; - cx: Row
; - dx: Column
graphics_draw:
	pusha
	mov ah, 0x0c	; http://www.ctyme.com/intr/rb-0104.htm
	mov bh, 0x0
	int 0x10
	popa

%endif
