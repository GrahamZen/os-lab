%include "header.inc"
BITS 16
extern Greet
extern shell
extern TimerWithDate

global _start
_start:
    MOVE_VECTOR 08h,39H
    VECTOR_IN 08h,TimerWithDate
    call dword Greet
WaitForKey:
    mov ah, 0
    int 16h
    cmp al, 0dh   
    jne WaitForKey
    call dword shell
    jmp WaitForKey