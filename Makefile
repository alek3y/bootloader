ASMC = nasm
ASMFLAGS = -f bin

CC = gcc
CFLAGS = -m16 -nostdlib

LOADER = main.asm
SRC = print.c
BIN = boot.bin

SECTOR = 512

all:
	$(ASMC) $(ASMFLAGS) $(LOADER) -o $(BIN)
	$(CC) $(CFLAGS) $(SRC) -o a.out

	@# (512 - (size % 512)) are the zeroes necessary to pad to a sector
	dd if=/dev/zero bs=1 count=$$(($(SECTOR) - ($$(du -b a.out | cut -f 1) % $(SECTOR)))) >> a.out

	cat a.out >> $(BIN)
	rm a.out

run: all
	qemu-system-x86_64 $(BIN)

clean:
	-rm $(BIN)
