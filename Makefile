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
	$(ASMC) $(ASMFLAGS) $(LOADER) -o $(BIN)
	truncate -s %512 a.out
	cat a.out >> $(BIN)
	rm a.out

run: all
	qemu-system-x86_64 $(BIN)

clean:
	-rm $(BIN)
