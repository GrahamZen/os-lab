#!/bin/bash

outfile="os17338233.img"
usrprog=("LU" "LD" "RU" "RD")

cd ./bin
rm -f *o
rm -f *bin
#用于生成用户程序(.com)
# cd ../usrprogram
# for asm_file in ${usrprog[@]}
# do
# 	nasm ${asm_file}.asm -o ../bin/${asm_file}.com
# done

cd ..
#生成引导程序
nasm myos1.asm -o ./bin/myos1.bin
#生成c代码
gcc -march=i386 -m16 -mpreferred-stack-boundary=2 -ffreestanding -fno-PIE -masm=intel -c main.c -o ./bin/main.o
#生成内核程序
nasm -f elf32 kernel.asm -o ./bin/kernel.o
#生成c的辅助汇编程序
nasm -f elf32 lib.asm -o ./bin/lib.o

ld -m elf_i386 -N  -entry _start -Ttext 0x8100 --oformat binary ./bin/kernel.o ./bin/main.o ./bin/lib.o -o ./bin/kernel.bin

dd if=./bin/myos1.bin of=${outfile} conv=notrunc bs=512 count=1
dd if=./bin/kernel.bin of=${outfile} conv=notrunc bs=512 seek=1 count=16
dd if=./bin/LU.com of=${outfile} conv=notrunc bs=512 seek=18 count=2
dd if=./bin/LD.com of=${outfile} conv=notrunc bs=512 seek=20 count=2
dd if=./bin/RU.com of=${outfile} conv=notrunc bs=512 seek=22 count=2
dd if=./bin/RD.com of=${outfile} conv=notrunc bs=512 seek=24 count=2

# for asm_file in ${assembly[@]}
# do
# 	rm -f ${asm_file}.com
#     echo "[+] ${asm_file} done"
# done

echo "[+] ${outfile} generated successfully."
