BITS 16

global printPos
global putchar
global cls

printPos:                
    pusha                
    mov si, sp
    add si, 20
    mov	ax, cs             ; 置其他段寄存器值与CS相同
    mov	ds, ax             ; 数据段
    mov	bp, [si]           ; BP=当前串的偏移地址
    mov	ax, ds             ; ES:BP = 串地址
    mov	es, ax             ; 置ES=DS
    mov	cx, [si+4]         ; CX = 串长（=9）
    mov	ax, 1301h          ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
    mov	bx, 0007h          ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov dh, [si+8]         ; 行号=0
    mov	dl, [si+12]        ; 列号=0
    int	10h                ; BIOS的10h功能：显示一行字符
    popa                  
    retf

putchar:              
    pusha
    mov bp, sp
    add bp, 16+4           
    mov al, [bp]           ; AL=要打印的字符
    mov bh, 0              ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov ah, 0Eh            ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
    int 10h                ; BIOS的10h功能：显示一行字符
    popa
    retf
cls:
    pusha
    mov ax, 0003h
    int 10h       
    popa
    retf
