OffsetOfKernel equ  08100h

OffsetOfUserPrg1 equ  0A100h
OffsetOfUserPrg2 equ  0A300h
OffsetOfUserPrg3 equ  0A700h
OffsetOfUserPrg4 equ  0AB00h
Dn_Rt equ 1                 
Up_Rt equ 2                 
Up_Lt equ 3                 
Dn_Lt equ 4      
delay equ 10000
ddelay equ 580  
bigdelay equ 30000
; 用于在指定位置显示字符串，参数：(字符串首地址, 字符串字节数, 行数, 列数)
%macro PRINT 4
    pusha            ; 保护现场
    mov	ax, cs       ; 置其他段寄存器值与CS相同
    mov	ds, ax       ; 数据段
    mov	bp, %1       ; BP=当前串的偏移地址(%1)
    mov	ax, ds       ; ES:BP = 串地址
    mov	es, ax       ; 置ES=DS
    mov	cx, %2       ; CX = 串长（=%2）
    mov	ax, 1301h    ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
    mov	bx, 0007h    ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov dh, %3       ; 行号=%3
    mov	dl, %4       ; 列号=%4
    int	10h          ; BIOS的10h功能：显示一行字符
    popa             ; 恢复现场
%endmacro
