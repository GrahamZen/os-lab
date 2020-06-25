BITS 16
global Timer
global TimerWithDate
extern printDate
extern Timesave
extern Timerestart
extern schedule
extern timeFlag,current_process_id
extern getTimeRegisterImage
%macro  PCB_RESTART 0              ; 宏：从PCB中恢复寄存器的值
    call dword getTimeRegisterImage
    mov si, ax
    mov ax, [cs:si+0]
    mov cx, [cs:si+2]
    mov dx, [cs:si+4]
    mov bx, [cs:si+6]
    mov sp, [cs:si+8]
    mov bp, [cs:si+10]
    mov di, [cs:si+14]
    mov ds, [cs:si+16]
    mov es, [cs:si+18]
    mov fs, [cs:si+20]
    mov gs, [cs:si+22]
    mov ss, [cs:si+24]
    add sp, 16+6                   ; 恢复正确的sp
    push word[cs:si+30]            ; 新进程flags
    push word[cs:si+28]            ; 新进程cs
    push word[cs:si+26]            ; 新进程ip
    push word[cs:si+12]
    pop si                         ; 恢复si
%endmacro

; 时钟中断处理程序
	delay equ 4		; 计时器延迟计数
	count db delay		; 计时器计数变量，初值=delay
    wheel db '-\|/'
    wheelOffset dw 0
	color db 07h
Timer:
	nop
	cli
    ; pushf
    cmp word[cs:timeFlag], 0
    je QuitTimer
    push ss
    push gs
    push fs
    push es
    push ds
    push di
    push si
    push bp
    push sp
    push bx
    push dx
    push cx
    push ax

    mov ax, cs
    mov ds, ax                     ; ds=cs，因为函数中可能要用到ds
    mov es, ax                     ; es=ax，原因同上。注意此时尚未发生栈切换
	call Timesave

CheckEscKey:
    mov ah, 01h                    ; 功能号：查询键盘缓冲区但不等待
    int 16h
    jz ContinucSchedule            ; 无键盘按下，继续调度
    mov ah, 0                      ; 功能号：查询键盘输入
    int 16h
    cmp al, 27                     ; 是否按下ESC
    jne ContinucSchedule           ; 若按下的不是ESC，继续调度
    mov ax, 0
    mov [timeFlag], ax
    mov [current_process_id], ax
    ; call goBackToKernel            ; 清理PCB
    jmp PcbRestart                 ; 通过恢复返回内核

ContinucSchedule:
	call dword schedule
PcbRestart:
	PCB_RESTART

QuitTimer:
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
    ; popf
	sti
	iret			; 从中断返回

restoreColor:
	mov byte[color], 07h
	jmp draw

TimerWithDate:
	nop
	cli
	; call Timesave
    pusha
    push gs
    push ds
    mov ax,cs
    mov ds,ax
	mov	ax,0B800h		; 文本窗口显存起始地址
	mov	gs,ax		; GS = B800h

	dec byte [count]		; 递减计数变量
	jnz Exit1			; >0：跳转
	mov byte[count],delay		; 重置计数变量=初值delay
    
    mov ah,[color]
	dec byte[color]
	jz restoreColor1
draw1:
    mov si, wheel
    add si, [wheelOffset]
    mov al,[si]
	mov [gs:((80*24+79)*2)],ax	; =0：递增显示字符的ASCII码值
    inc byte[wheelOffset]
    cmp byte[wheelOffset],4
    jne Exit1
    mov byte[wheelOffset],0
Exit1:
	call dword printDate
	mov al,20h			; AL = EOI
	out 20h,al			; 发送EOI到主8529A
	out 0A0h,al			; 发送EOI到从8529A
    pop ds
    pop gs
    popa
	; call Timerestart
	sti
	iret			; 从中断返回

restoreColor1:
	mov byte[color], 07h
	jmp draw1
