ASMC = nasm
ASMFLAGS = -f bin

SRC = main.asm
DEST = build/boot.bin

all: dirs
	$(ASMC) $(ASMFLAGS) $(SRC) -o $(DEST)

run: all
	qemu-system-x86_64 $(DEST)

dirs:
	mkdir -p $$(dirname $(DEST))

clean:
	-rm -r $$(dirname $(DEST))
