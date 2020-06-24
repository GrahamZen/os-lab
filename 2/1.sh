rm -f boot.img
# nasm LU.asm -o main.bin
nasm LD.asm -o main.bin
# nasm RU.asm -o main.bin
# nasm RD.asm -o main.bin
dd conv=sync if=main.bin of=boot.img bs=1440k count=1  