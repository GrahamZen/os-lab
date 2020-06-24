Dn_Rt equ 1                 
Up_Rt equ 2                 
Up_Lt equ 3                 
Dn_Lt equ 4                 
delay equ 50000				
ddelay equ 580				

jmp near start
 
start:
	mov ax,0x7c0                 
	mov ds,ax
	mov ax,0B800h			
	mov es,ax				
    mov byte[char],'H'
	mov byte [es:0x00],'Z'
	mov byte [es:0x01],0x07
	mov byte [es:0x02],'g'
	mov byte [es:0x03],0x07
	mov byte [es:0x04],'h'
	mov byte [es:0x05],0x07
	mov byte [es:0x06],'1'
	mov byte [es:0x07],0x07
	mov byte [es:0x08],'7'
	mov byte [es:0x09],0x07
	mov byte [es:0x0a],'3'
	mov byte [es:0x0b],0x07
	mov byte [es:0x0c],'3'
	mov byte [es:0x0d],0x07
	mov byte [es:0x0e],'8'
	mov byte [es:0x0f],0x07
	mov byte [es:0x10],'2'
	mov byte [es:0x11],0x07
	mov byte [es:0x12],'3'
	mov byte [es:0x13],0x07
	mov byte [es:0x14],'3'
	mov byte [es:0x15],0x07
loop1:
	dec word[count]			
	jnz loop1				
	mov word[count],delay
	dec word[dcount]			
    jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay

    mov al,1
    cmp al,byte[rdul]
	jz  DnRt
      mov al,2
      cmp al,byte[rdul]
	jz  UpRt
      mov al,3
      cmp al,byte[rdul]
	jz  UpLt
      mov al,4
      cmp al,byte[rdul]
	jz  DnLt



DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dr2ur
	mov bx,word[y]
	mov ax,80
	sub ax,bx	
      jz  dr2dl
	jmp show
dr2ur:
      mov word[x],23
      mov byte[rdul],Up_Rt	
      jmp show
dr2dl:
      mov word[y],78
      mov byte[rdul],Dn_Lt	
      jmp show

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  ur2ul
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ur2dr
	jmp show
ur2ul:
      mov word[y],78
      mov byte[rdul],Up_Lt	
      jmp show
ur2dr:
      mov word[x],1
      mov byte[rdul],Dn_Rt	
      jmp show

	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ul2dl
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  ul2ur
	jmp show

ul2dl:
      mov word[x],1
      mov byte[rdul],Dn_Lt	
      jmp show
ul2ur:
      mov word[y],1
      mov byte[rdul],Up_Rt	
      jmp show

	
	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  dl2dr
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dl2ul
	jmp show

dl2dr:
      mov word[y],1
      mov byte[rdul],Dn_Rt	
      jmp show
	
dl2ul:
      mov word[x],23
      mov byte[rdul],Up_Lt	
      jmp show
	
show:	
      xor ax,ax                
      mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2			
	mul bx
	mov bx,ax
	mov ah,[color]
	inc byte[color]
	mov al,byte[char]		
	mov [es:bx],ax  	
	jmp loop1
	
; _end:
;     jmp $                  
	

times 510-($-$$) db 0
			   db 0x55,0xaa

datadef:	
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt        
    x    dw 7
    y    dw 0
    char db 'A'
	color db 0Fh