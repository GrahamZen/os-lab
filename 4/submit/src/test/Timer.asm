org 7c00h
%include "header.inc"
call cls
mov ax, 0B800h
mov gs,ax
mov ax,cs
mov ds,ax

VECTOR_IN 08h,Timer
sti
jmp $			; 死循环
; 时钟中断处理程序

Timer:
    pusha
    push gs
    push ds
    mov ax,cs
    mov ds,ax
	mov	ax,0B800h		; 文本窗口显存起始地址
	mov	gs,ax		; GS = B800h

	dec byte [count]		; 递减计数变量
	jnz Exit			; >0：跳转
	mov byte[count],delay		; 重置计数变量=初值delay
    
    mov ah,[color]
	dec byte[color]
	jz restoreColor
draw:
    mov si, wheel
    add si, [wheelOffset]
    mov al,[si]
	mov [gs:((80*24+79)*2)],ax	; =0：递增显示字符的ASCII码值
    inc byte[wheelOffset]
    cmp byte[wheelOffset],4
    jne Exit
    mov byte[wheelOffset],0
Exit:
	mov al,20h			; AL = EOI
	out 20h,al			; 发送EOI到主8529A
	out 0A0h,al			; 发送EOI到从8529A
    pop ds
    pop gs
    popa
	iret			; 从中断返回

restoreColor:
	mov byte[color], 07h
	jmp draw

cls:
    pusha
    mov ax, 0003h
    int 10h
    popa
    ret
delay equ 4		; 计时器延迟计数
count db delay		; 计时器计数变量，初值=delay
wheel db '-\|/'
wheelOffset dw 0
color db 07h

times 510-($-$$) db 0
db 0x55,0xaa