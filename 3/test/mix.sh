#!/bin/bash

outfile="test.img"
assembly=("main" "lib")
cFile=("str")
# rm -f ${outfile}

for asm_file in ${assembly[@]}
do
	nasm -f elf32 ${asm_file}.asm -o ${asm_file}.o
done

for cfile in ${cFile[@]}
do
	gcc -fno-pie -c -m16 -march=i386 -nostdlib -ffreestanding -mpreferred-stack-boundary=2 -lgcc -shared ${cfile}.c -o ${cfile}.o
	objdump  -s -ld -C -S ${cfile}.o > ${cfile}.s
done

ld -m elf_i386 -N main.o str.o lib.o -Ttext 0x7c00 --oformat binary  -o boot.bin
ld -m elf_i386 -N main.o str.o lib.o -Ttext 0x7c00 --oformat binary  -o boot.com
dd if=boot.bin of=${outfile} bs=512 count=1 seek=0 conv=notrunc 

rm *.o
# rm *.bin
