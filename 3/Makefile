IMG = os17338233.img
INFO = myos1.bin 
KERNEL = kernel.bin
PRO = LU.com LD.com RU.com RD.com

all:str.s testimg	pro img clean

testimg: boot.bin 
	dd if=boot.bin of=./test/test.img bs=512 count=1 seek=0 conv=notrunc 

boot.bin:strlib
	ld -m elf_i386 -N ./test/main.o ./test/str.o ./test/lib.o -Ttext 0x7c00 --oformat binary  -o ./test/boot.bin

strlib:
	nasm -f elf32 ./test/str.asm -o ./test/str.o
	nasm -f elf32 ./test/lib.asm -o ./test/lib.o

str.s:str.c
	gcc -fno-pie -c -m16 -march=i386 -nostdlib -ffreestanding -mpreferred-stack-boundary=2 -lgcc -shared ${cfile}.c -o ${cfile}.o
	objdump  -s -ld -C -S ${cfile}.o > ${cfile}.s

img:$(INFO) $(KERNEL) $(PRO) 
ifeq ($(IMG), $(wildcard $(IMG)))
	rm $(IMG)
endif
	dd if=myos1.bin of=$(IMG) conv=notrunc
	dd if=kernel.bin of=$(IMG) seek=2 conv=notrunc
	dd if=LU.com of=$(IMG) seek=18 conv=notrunc
	dd if=LD.com of=$(IMG) seek=20 conv=notrunc
	dd if=RU.com of=$(IMG) seek=22 conv=notrunc
	dd if=RD.com of=$(IMG) seek=24 conv=notrunc	

pro:$(INFO) $(KERNEL) $(PRO) 
myos1.bin: myos1.asm
	nasm  $< -o $@

kernel.bin: kernel.o lib.o libc.o
	ld -m elf_i386 -N -Ttext 0x8000 --oformat binary  $^ -o $@

%.o : %.asm
	nasm -f elf32 $< -o $@

%.o : %.c
	gcc -march=i386 -m16 -mpreferred-stack-boundary=2 -ffreestanding -fno-PIE -masm=intel -c $< -o $@
%.com : %.asm
	nasm $< -o $@

.PHONY:clean
clean:
	rm -rf *o *bin *com