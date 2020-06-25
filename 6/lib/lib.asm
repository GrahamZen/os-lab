BITS 16
%include "./lib/header.inc"

global kernelInit
global printPos
global putchar
global cls
global getch
global shutdown
global loadUsrProgram
global runUsrProgram
global getDateInfo
global save
global restart
global Timesave
global Timerestart
global syscaller
global sys_int22
global sys_putchar
global setTimeIV,setDateIV
global current_process_id,timeFlag

extern getTimeRegisterImage,getRegisterImage
extern sysc_int22

extern Timer
extern TimerWithDate

kernelInit:
    push ax
    mov ax,cs
    mov ss,ax
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    pop ax
    retf

cls:
    pusha
    mov ax, 0003h
    int 10h       ;清屏
    popa
    retf

printPos:
    pusha
    mov si, sp
    add si, 16+4
    mov	ax, cs             ; 置其他段寄存器值与CS相同
    mov	ds, ax             ; 数据段
    mov	bp, [si]           ; BP=当前串的偏移地址
    mov	ax, ds             ; ES:BP = 串地址
    mov	es, ax             ; 置ES=DS
    mov	cx, [si+4]         ; CX = 串长（=9）
    mov	ax, 1300h          ; AH = 13h（功能号）、AL = 00h（光标置于串尾）
    mov	bx, 0007h          ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov dh, [si+8]         ; 行号=0
    mov	dl, [si+12]        ; 列号=0
    int	10h; BIOS的10h功能：显示一行字符
    popa   
    retf

putchar:
    pusha
    mov bp, sp
    add bp, 16+4 
    mov al, [bp] 
    mov bh, 0
    mov ah, 0Eh ;功能码
    int 10h 
    popa
    retf

getch:
    mov ah,0
    int 16h
    mov ah,0
    retf

shutdown:
    mov ax, 2001H
    mov dx, 1004H
    out dx, ax

loadUsrProgram:    
    pusha
    push ds
    push es       
    mov bp, sp
    mov bx, [bp+24]        ; 程序信息结构体指针
    mov ax, [bx+20]        ; 存放数据的段地址
    mov es, ax             ; 用es才能跨段读取,es:bx是读入的数据所在内存地址
    mov ah,2               ; 功能号
    mov al,[bx+12]         ; 扇区数
    mov dl,0               ; 驱动器号; 软盘为0，硬盘和U盘为80H
    mov dh, [bx+4]         ; 磁头号; 起始编号为0
    mov ch, [bx]           ; 柱面号; 起始编号为0
    mov cl, [bx+8]         ; 起始扇区号 ; 起始编号为1
    mov bx, [bx+16]        ; 存放数据的内存偏移地址
    int 13H                ; 调用读磁盘BIOS的13h功能
    push gs
    mov ax, cs
    mov gs, ax
    mov word[gs:savesp],sp   ; 保存当前的栈顶，用于返回后恢复
    mov sp,0xff00               ; 设置用户程序的栈顶
    mov bx, es
    mov ss, bx             ; 设置现在的栈段和es一致(以后push和pop就会操作用户程序的栈)
    mov ax,[gs:codeOfInt20]; 用ax保存int 20这个语句
    mov [es:0],ax          ; 在es:0(用户程序所在段首)放置int 20
    push cs                ; 
    push afterRun          ; 将cs ip先后压栈，返回时可以远返回retf
    push dword 0           ; 压栈0，用户程序如果使用ret就会触发ip=0的操作，开始执行从es:0开始的语句
    mov bx, cs
    mov ss, bx
    mov sp,[savesp]
    pop gs
    pop ds
    pop es
    popa
    retf

runUsrProgram:
    pusha
    mov bp, sp
    mov bx, [bp+20]        ; 程序信息结构体指针
    mov ax, cs
    mov gs, ax
    mov word[gs:savesp],sp   ; 保存当前的栈顶，用于返回后恢复
    mov ax,0xff00          ; 用户程序的栈顶为0xff00
    mov sp, ax              ; 设置用户程序的栈顶
    sub sp, 8
    mov bx, [bx+20]
    mov es, bx             ; 用es才能跨段读取,es:bx是读入的数据所在内存地址
    mov ds, bx             ; 设置用户程序的数据段和es一致
    mov ss, bx             ; 设置现在的栈段和es一致(以后push和pop就会操作用户程序的栈)
    mov word[gs:program+2], bx
    
    jmp far [gs:program]   ;远转移至gs:program所指的位置

afterRun:
    mov ax,cs
    mov ss,ax
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    mov ax,[savesp]
    mov sp, ax
    popa
    retf

codeOfInt20:
    int 20h

getDateInfo:
    push es
    push bp
    mov bp, sp
    mov al, [bp+8]        ; 偏移地址; 存放数据的内存偏移地址
    out 70h, al
    in al, 71h
    mov ah, 0
    pop bp
    pop es
    retf

save:
    pusha
    mov bp, sp
    call dword getRegisterImage
    mov di, ax
    mov ax, [bp]         ;di
    mov [cs:di+14], ax   ;
    mov ax, [bp+2]       ;si
    mov [cs:di+12], ax   ;
    mov ax, [bp+4]       ;bp
    mov [cs:di+10], ax   ;
    mov ax, [bp+6]       ;sp
    mov [cs:di+8], ax    ;
    mov ax, [bp+8]       ;dx
    mov [cs:di+6], ax    ;
    mov ax, [bp+10]      ;cx
    mov [cs:di+4], ax    ;
    mov ax, [bp+12]      ;bx
    mov [cs:di+2], ax    ;
    mov ax, [bp+14]      ;ax
    mov [cs:di], ax      ;
    mov ax, ds           ;ds
    mov [cs:di+16], ax   ;
    mov ax, es           ;es
    mov [cs:di+18], ax   ;
    mov ax, fs           ;fs
    mov [cs:di+20], ax   ;
    mov ax, gs           ;gs
    mov [cs:di+22], ax   ;
    mov ax, ss           ;ss
    mov [cs:di+24], ax   ;
    mov ax, [bp+18]      ;ip
    mov [cs:di+26], ax   ;
    mov ax, [bp+20]      ;cs
    mov [cs:di+28], ax   ;
    mov ax, [bp+22]      ;flags
    mov [cs:di+30], ax   ;
    popa
    ret

restart:
    call dword getRegisterImage
    mov si, ax
    mov ax, [cs:si+0]
    mov cx, [cs:si+2]
    mov bx, [cs:si+6]
    mov sp, [cs:si+8]
    mov di, [cs:si+14]
    mov ds, [cs:si+16]
    mov es, [cs:si+18]
    mov fs, [cs:si+20]
    mov gs, [cs:si+22]
    mov ss, [cs:si+24]
    ; add sp, 4*2                   ; 恢复正确的sp(原返回地址，ip,cs,flags)
    mov bp,sp

    mov dx, word[cs:si+30]            ; 新进程flags
    mov [bp+6],dx
    mov dx, word[cs:si+28]            ; 新进程cs
    mov [bp+4],dx
    mov dx, word[cs:si+26]            ; 新进程ip
    mov [bp+2],dx
    
    mov bp, [cs:si+10]
    mov dx, [cs:si+4]
    mov si, [cs:si+12]
    
    ret
Timesave:
    pusha
    mov bp, sp
    add bp,16+2
    call dword getTimeRegisterImage
    mov di, ax

    mov ax, [bp]
    mov [cs:di], ax
    mov ax, [bp+2]
    mov [cs:di+2], ax
    mov ax, [bp+4]
    mov [cs:di+4], ax
    mov ax, [bp+6]
    mov [cs:di+6], ax
    mov ax, [bp+8]
    mov [cs:di+8], ax
    mov ax, [bp+10]
    mov [cs:di+10], ax
    mov ax, [bp+12]
    mov [cs:di+12], ax
    mov ax, [bp+14]
    mov [cs:di+14], ax
    mov ax, [bp+16]
    mov [cs:di+16], ax
    mov ax, [bp+18]
    mov [cs:di+18], ax
    mov ax, [bp+20]
    mov [cs:di+20], ax
    mov ax, [bp+22]
    mov [cs:di+22], ax
    mov ax, [bp+24]
    mov [cs:di+24], ax
    mov ax, [bp+26]
    mov [cs:di+26], ax
    mov ax, [bp+28]
    mov [cs:di+28], ax
    mov ax, [bp+30]
    mov [cs:di+30], ax
    popa
    ret

Timerestart:
    call dword getTimeRegisterImage
    mov si, ax
    mov ax, [cs:si+0]
    mov cx, [cs:si+2]
    mov bx, [cs:si+6]
    mov sp, [cs:si+8]
    mov di, [cs:si+14]
    mov ds, [cs:si+16]
    mov es, [cs:si+18]
    mov fs, [cs:si+20]
    mov gs, [cs:si+22]
    mov ss, [cs:si+24]
    ; add sp, 4*2                   ; 恢复正确的sp(原返回地址，ip,cs,flags)
    mov bp,sp

    mov dx, word[cs:si+30]            ; 新进程flags
    mov [bp+6],dx
    mov dx, word[cs:si+28]            ; 新进程cs
    mov [bp+4],dx
    mov dx, word[cs:si+26]            ; 新进程ip
    mov [bp+2],dx
    
    mov bp, [cs:si+10]
    mov dx, [cs:si+4]
    mov si, [cs:si+12]
    
    ret

setTimeIV:
    VECTOR_IN 08h,Timer
    retf
setDateIV:
    VECTOR_IN 08h,TimerWithDate
    retf

syscaller:;不切换段
    nop
    cli
    call save ;保存现场
    mov si,cs ;si=0
    mov ds,si ;ds=cs=0
    mov si,ax ;功能号
    shr si,8
    add si,si
    add si,si
    call [sys_table+si]
    mov [retval],ax
    call restart
    push ds                           ; 压栈ds用于恢复
    mov ax, 0                         ; ax临时用于修改ds
    mov ds, ax                        ; 临时修改ds为0，用于恢复ax
    mov ax,[retval]                   ; 修改ax为返回值
    pop ds                            ; 恢复ds
    sti
    iret

sys_putchar: ;系统调用：打印一个字符(不需要返回参数)
    pusha
    mov bp,sp
    push word[bp+28];16(pusha)+2(call)+6(int 21)+4(call dword)
    call dword putchar
    add sp, 2
    popa
    ret

sys_getch: ;系统调用：从键盘获得输入的一个字符(需要返回参数)
    call dword getch
    ret


sys_putchar_c:                  ; 函数：在光标处打印一个彩色字符
    pusha
    mov bx, 0                   ; 页号=0
    mov ah, 03h                 ; 功能号：获取光标位置
    int 10h                     ; dh=行，dl=列
    mov bp, sp
    add bp, 28                  ; 参数地址，es:bp指向要显示的字符,4(call dword)+6(int 21)+2(call)+16(pusha)
    mov cx, 1                   ; 显示1个字符
    mov ax, 1301h               ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
    mov bh, 0                   ; 页号
    mov bl, [bp+4]              ; 颜色属性
    int 10h                     ; 显示字符串（1个字符）
    popa
    ret


sys_int22:
    call dword sysc_int22
    ret

sys_table:
    dd sys_putchar,sys_getch,sys_putchar_c

datadef:
program dw 0x100,0
retval dw 0xff00
savesp dw 0xff00