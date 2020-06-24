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
	jz program1
	cmp al,'2'
	jz program2
	cmp al,'3'
	jz program3
	cmp al,'4'
	jz program4
	jmp WaitForKey
  
_end:
    jmp $
	
  program1:
  	call far [proc1]
	jmp start
  program2:
  	call far [proc2]
	jmp start
  program3:
  	call far [proc3]
	jmp start
  program4:
  	call far [proc4]
	jmp start

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
	proc1 dw 100h,0xa00
	proc2 dw 100h,0xa20
	proc3 dw 100h,0xa60
	proc4 dw 100h,0xaa0
times 510-($-$$) db 0
db 0x55,0xaa