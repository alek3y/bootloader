ASMC = nasm
ASMFLAGS = -f bin
ASMFLAGS += -Isrc

LOADER = boot.asm
SRC = src/main.asm
BIN = boot.bin

SECTOR = 512

all:
	$(ASMC) $(ASMFLAGS) $(SRC) -o code.bin
	truncate -s %512 code.bin	# Rounds to the nearest sector
	$(ASMC) $(ASMFLAGS) -D SECTORS_TO_LOAD=$$(($$(du -b code.bin | cut -f 1) / $(SECTOR))) $(LOADER) -o $(BIN)
	cat code.bin >> $(BIN)
	rm code.bin

run: all
	qemu-system-x86_64 $(BIN)

clean:
	-rm $(BIN)
