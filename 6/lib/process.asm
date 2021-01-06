BITS 16
extern save
global int20
extern goBackKernel
extern afterRun
int20:
    push ds
    push ax
    mov ax,0
    mov ds,ax
    call dword goBackKernel
    pop ax
    pop ds
    add sp, 4 ;ip(before int), cs,flags(pushf)
    push word cs
    push afterRun
    iret
