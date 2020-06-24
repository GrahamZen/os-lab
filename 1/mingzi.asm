         ;代码清单5-1 
         ;文件名：c05_mbr.asm
         ;文件说明：硬盘主引导扇区代码
         ;创建日期：2011-3-31 21:15 
         
         mov ax,0xb800                 ;指向文本模式的显示缓冲区
         mov es,ax

         ;以下显示字符串"Label offset:"
         mov byte [es:0x00],'Z'
         mov byte [es:0x01],0x07
         mov byte [es:0x02],'h'
         mov byte [es:0x03],0x07
         mov byte [es:0x04],'e'
         mov byte [es:0x05],0x07
         mov byte [es:0x06],'n'
         mov byte [es:0x07],0x07
         mov byte [es:0x08],'g'
         mov byte [es:0x09],0x07
         mov byte [es:0x0a],'g'
         mov byte [es:0x0b],0x07
         mov byte [es:0x0c],'e'
         mov byte [es:0x0d],0x07
         mov byte [es:0x0e],'h'
         mov byte [es:0x0f],0x07
         mov byte [es:0x10],'a'
         mov byte [es:0x11],0x07
         mov byte [es:0x12],'n'
         mov byte [es:0x13],0x07
         mov byte [es:0x14],'1'
         mov byte [es:0x15],0x07
         mov byte [es:0x16],'7'
         mov byte [es:0x17],0x07
         mov byte [es:0x18],'3'
         mov byte [es:0x19],0x07
         mov byte [es:0x1A],'3'
         mov byte [es:0x1B],0x07
         mov byte [es:0x1C],'8'
         mov byte [es:0x1D],0x07
         mov byte [es:0x1E],'2'
         mov byte [es:0x1F],0x07
         mov byte [es:0x20],'3'
         mov byte [es:0x21],0x07
         mov byte [es:0x22],'3'
         mov byte [es:0x23],0x07


   infi: jmp near infi                 ;无限循环
      
  number db 0,0,0,0,0 ;和number: db 0,0,0,0,0相同 
  
times 510-($-$$) db 0
			   db 0x55,0xaa