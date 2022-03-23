%ifndef IO_READ
%define IO_READ

%define DISK 0b10000000

; void read(int dh, int ch, int cl, void *bx, int al)
;
; Parameters:
; - dh: Head source number
; - ch: Cylinder source number
; - cl: Sector source number
; - bx: Destination address to write to
; - al: Amount of sectors to read
read:
	pusha

	mov ah, 0x2	; http://www.ctyme.com/intr/rb-0607.htm
	mov dl, DISK	; NOTE: This assumes the disk number
	int 0x13

	; TODO: This function does not account for errors (CF set)

	popa
	ret

%endif
