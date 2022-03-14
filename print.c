// Sources:
// - https://www.youtube.com/watch?v=MobAjLVDZEc
// - http://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html

void _start(void) {
	asm(
		"mov $0xe, %ah\n"
		"mov $0x41, %al\n"
		"int $0x10\n"
		"hlt"
	);
}
