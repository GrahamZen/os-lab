BITS 16
extern c
extern upper
extern Message
extern printInfo
global _start
_start:
    call dword printInfo    
    mov ax,cs
    mov ds,ax
    mov es,ax
    mov ss,ax
    push cs    
    call upper
    mov bp,Message
    mov ax,ds
    mov es,ax
    mov cx,10
    mov ax,1301h
    mov bx,0007h
    mov dh,10
    mov dl,10
    int 10h
_end:
    jmp $
