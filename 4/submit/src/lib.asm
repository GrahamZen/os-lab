%include "header.inc"
BITS 16

global printPos
global putchar
global cls
global getch
global shutdown
global loadUsrProgram
global getDateInfo
extern Timer
extern TimerWithDate

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
    VECTOR_IN 08h,Timer
    mov bp, sp
    mov bx, [bp+20]        ; 偏移地址; 存放数据的内存偏移地址
    mov ah,2               ; 功能号
    mov al,[bp+24]         ; 扇区数
    mov dl,0               ; 驱动器号; 软盘为0，硬盘和U盘为80H
    mov dh,[bp+28]         ; 磁头号; 起始编号为0
    mov ch,[bp+32]         ; 柱面号; 起始编号为0
    mov cl,[bp+36]         ; 起始扇区号 ; 起始编号为1
    int 13H                ; 调用读磁盘BIOS的13h功能
    shr bx,4
    add bx,-10h
    mov word[program],0x100
    mov  word[program+2],bx
    call far [program]
    mov ax,cs
    mov ds,ax
    mov es,ax
    VECTOR_IN 08h,TimerWithDate
    popa
    retf

getDateInfo:
    push bp
    mov bp, sp
    mov al, [bp+6]        ; 偏移地址; 存放数据的内存偏移地址
    out 70h, al
    in al, 71h
    mov ah, 0
    pop bp
    retf

program:
dw 0x7c00
