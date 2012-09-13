# Makefile

ASM	     = nasm
ASMFLAGS = -I boot/include/

TARGET   = image/boot.bin image/loader.bin

.PHONY: everything clean all

everything: $(TARGET)

clean:
	rm -f $(TARGET)

all: clean everything

image/boot.bin: boot/boot.asm boot/include/load.inc boot/include/fat12hdr.inc 
	$(ASM) $(ASMFLAGS) -o $@ $<

image/loader.bin: boot/loader.asm boot/include/load.inc boot/include/fat12hdr.inc boot/include/pm.inc
	$(ASM) $(ASMFLAGS) -o $@ $<


