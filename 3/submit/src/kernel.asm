BITS 16
extern Greet
extern shell

global _start
_start:
    call dword Greet
WaitForKey:
    mov ah, 0
    int 16h
    cmp al, 0dh   
    jne WaitForKey
    call dword shell
    jmp WaitForKey