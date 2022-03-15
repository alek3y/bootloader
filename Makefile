ASMC = nasm
ASMFLAGS = -f bin

CC = gcc
CFLAGS = -m16 -nostdlib

LOADER = main.asm
SRC = print.c
BIN = boot.bin

SECTOR = 512

all:
	$(CC) $(CFLAGS) $(SRC) -o a.out
	truncate -s %512 a.out
	$(ASMC) $(ASMFLAGS) -D SECTORS_TO_LOAD=$$(($$(du -b a.out | cut -f 1) / $(SECTOR))) $(LOADER) -o $(BIN)
	cat a.out >> $(BIN)
	rm a.out

run: all
	qemu-system-x86_64 $(BIN)

clean:
	-rm $(BIN)
