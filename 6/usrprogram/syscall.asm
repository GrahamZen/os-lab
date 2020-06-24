BITS 16
global syscall_putchar
global syscall_putchar_c
global syscall_getch

syscall_putchar:
    mov ah,0
    int 21h
    ret
syscall_getch:
    mov ah,1
    int 21h
    ret
syscall_putchar_c:
    mov ah,2
    int 21h
    ret