ASMC = nasm
ASMFLAGS = -f bin
ASMFLAGS += -Isrc

LOADER = boot.asm
SRC = src/main.asm
BIN = boot.bin

SECTOR = 512

payload := $(shell mktemp)

all: bootloader
	printf 'holy shid dis fuggin dign :DDDDDD' >> $(BIN)
	truncate -s %$(SECTOR) $(BIN)

bootloader: code
	$(ASMC) $(ASMFLAGS) \
		-D SECTORS_TO_LOAD=$$(($(shell du -b $(payload) | cut -f 1) / $(SECTOR))) \
		$(LOADER) -o $(BIN)
	cat $(payload) >> $(BIN)
	rm $(payload)

code:
	$(ASMC) $(ASMFLAGS) $(SRC) -o $(payload)
	truncate -s %$(SECTOR) $(payload)	# Rounds to the nearest sector

run: all
	qemu-system-x86_64 $(BIN)

clean:
	-rm $(BIN)
