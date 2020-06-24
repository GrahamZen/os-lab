#!/bin/bash

outfile="os17338233.img"
assembly=("myos1" "kernel" "LU" "LD" "RU" "RD")


rm -f ${outfile}

for asm_file in ${assembly[@]}
do
	nasm ${asm_file}.asm -o ${asm_file}.bin
    cat ${asm_file}.bin >> "${outfile}"
    rm -f ${asm_file}.bin
    echo "[+] ${asm_file} done"
done

echo "[+] ${outfile} generated successfully."