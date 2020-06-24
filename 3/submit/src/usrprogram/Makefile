PROG = LU.com LD.com RU.com RD.com
IMG=../os17338233.img
all: output
output: $(PROG)
	dd if=LU.com of=$(IMG) conv=notrunc bs=512 seek=18 count=2 >/dev/null
	dd if=LD.com of=$(IMG) conv=notrunc bs=512 seek=20 count=2 >/dev/null
	dd if=RU.com of=$(IMG) conv=notrunc bs=512 seek=22 count=2 >/dev/null
	dd if=RD.com of=$(IMG) conv=notrunc bs=512 seek=24 count=2 >/dev/null

%.com : %.asm
	nasm $< -o $@
