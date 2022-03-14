ASMC = nasm
ASMFLAGS = -f bin

SRC = main.asm
BIN = boot.bin

all:
	$(ASMC) $(ASMFLAGS) $(SRC) -o $(BIN)

run: all
	qemu-system-x86_64 $(BIN)

clean:
	-rm $(BIN)
