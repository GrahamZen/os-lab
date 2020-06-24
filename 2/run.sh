#!/bin/bash

outfile="os17338233.img"
assembly=("myos1" "kernel" "LU" "LD" "RU" "RD")


rm -f ${outfile}

for asm_file in ${assembly[@]}
do
	nasm ${asm_file}.asm -o ${asm_file}.com
done
dd if=myos1.com of=${outfile} bs=512 count=1 2>/dev/null
dd if=kernel.com of=${outfile} bs=512 seek=1 count=1 2>/dev/null
dd if=LU.com of=${outfile} bs=512 seek=2 count=2 2>/dev/null
dd if=LD.com of=${outfile} bs=512 seek=4 count=2 2>/dev/null
dd if=RD.com of=${outfile} bs=512 seek=6 count=2 2>/dev/null
dd if=RU.com of=${outfile} bs=512 seek=8 count=2 2>/dev/null
for asm_file in ${assembly[@]}
do
	rm -f ${asm_file}.com
    echo "[+] ${asm_file} done"
done

echo "[+] ${outfile} generated successfully."
