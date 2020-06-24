%include "header.inc"

org  OffsetOfKernel                     

start:
	call cls
	PRINT welcomeString,wSlen,10,32
	PRINT hint,hintlen,20,19
	
WaitForKey:
	mov ah,0
	int 16h
	cmp al,'1'
	jz OffsetOfUserPrg1
	cmp al,'2'
	jz OffsetOfUserPrg2
	cmp al,'3'
	jz OffsetOfUserPrg3
	cmp al,'4'
	jz OffsetOfUserPrg4
	jmp WaitForKey

_end:
    jmp $
	
cls:
    pusha
    mov ax, 0003h
    int 10h       ;清屏
    popa
    ret

DataDef:	
    welcomeString db 'OS 17338233'
	wSlen equ ($-welcomeString)
    hint db 'press 1/2/3/4 to run one of the 4 programs'
	hintlen equ ($-hint)
times 510-($-$$) db 0
db 0x55,0xaa