BITS 16
extern c
extern printInfo
global _start
_start:
    pusha
    call dword printInfo
    popa

_end:
    jmp $
