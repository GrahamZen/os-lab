
str.o:     file format elf32-i386

Contents of section .text:
 0000 66556689 e56683ec 046766c7 45fc0000  fUf..f...gf.E...
 0010 00009067 668b45fc 67668d50 01676689  ...gf.E.gf.P.gf.
 0020 55fc6689 c267668b 45086601 d0678a00  U.f..gf.E.f..g..
 0030 84c075df 67668b45 fc664866 c966c366  ..u.gf.E.fHf.f.f
 0040 556689e5 6683ec04 66e8fcff ffff6766  Uf..f...f.....gf
 0050 c745fc09 00000067 66ff75fc 66e8fcff  .E.....gf.u.f...
 0060 ffff6683 c4046683 c030660f bec06650  ..f...f..0f...fP
 0070 66e8fcff ffff6683 c4046766 ff75fc66  f.....f...gf.u.f
 0080 e8fcffff ff6683c4 04666a17 666a0666  .....f...fj.fj.f
 0090 506766ff 75fc66e8 fcffffff 6683c410  Pgf.u.f.....f...
 00a0 66a10000 665066e8 fcffffff 6683c404  f...fPf.....f...
 00b0 6689c266 a1000066 6a17666a 09665266  f..f...fj.fj.fRf
 00c0 5066e8fc ffffff66 83c41090 66c966c3  Pf.....f....f.f.
 00d0 66556689 e56683ec 086766c7 45fc0900  fUf..f...gf.E...
 00e0 00006766 c745f817 00000066 a1000066  ..gf.E.....f...f
 00f0 5066e8fc ffffff66 83c40466 89c266a1  Pf.....f...f..f.
 0100 00006766 ff75f867 66ff75fc 66526650  ..gf.u.gf.u.fRfP
 0110 66e8fcff ffff6683 c4109066 c966c3    f.....f....f.f. 
Contents of section .data:
 0000 00000000                             ....            
Contents of section .rodata:
 0000 776f6465 6d736731 00776f64 65696e66  wodemsg1.wodeinf
 0010 6f00                                 o.              
Contents of section .comment:
 0000 00474343 3a202855 62756e74 7520372e  .GCC: (Ubuntu 7.
 0010 352e302d 33756275 6e747531 7e31382e  5.0-3ubuntu1~18.
 0020 30342920 372e352e 3000               04) 7.5.0.      
Contents of section .eh_frame:
 0000 14000000 00000000 017a5200 017c0801  .........zR..|..
 0010 1b0c0404 88010000 1c000000 1c000000  ................
 0020 00000000 3f000000 00420e08 8502430d  ....?....B....C.
 0030 0578c50c 04040000 1c000000 3c000000  .x..........<...
 0040 3f000000 91000000 00420e08 8502430d  ?........B....C.
 0050 05028ac5 0c040400 1c000000 5c000000  ............\...
 0060 d0000000 4f000000 00420e08 8502430d  ....O....B....C.
 0070 050248c5 0c040400                    ..H.....        

Disassembly of section .text:

00000000 <strlen>:
strlen():
   0:	66 55                	push   %bp
   2:	66 89 e5             	mov    %sp,%bp
   5:	66 83 ec 04          	sub    $0x4,%sp
   9:	67 66 c7 45 fc 00 00 	movw   $0x0,-0x4(%di)
  10:	00 00                	add    %al,(%eax)
  12:	90                   	nop
  13:	67 66 8b 45 fc       	mov    -0x4(%di),%ax
  18:	67 66 8d 50 01       	lea    0x1(%bx,%si),%dx
  1d:	67 66 89 55 fc       	mov    %dx,-0x4(%di)
  22:	66 89 c2             	mov    %ax,%dx
  25:	67 66 8b 45 08       	mov    0x8(%di),%ax
  2a:	66 01 d0             	add    %dx,%ax
  2d:	67 8a 00             	mov    (%bx,%si),%al
  30:	84 c0                	test   %al,%al
  32:	75 df                	jne    13 <strlen+0x13>
  34:	67 66 8b 45 fc       	mov    -0x4(%di),%ax
  39:	66 48                	dec    %ax
  3b:	66 c9                	leavew 
  3d:	66 c3                	retw   

0000003f <printInfo>:
printInfo():
  3f:	66 55                	push   %bp
  41:	66 89 e5             	mov    %sp,%bp
  44:	66 83 ec 04          	sub    $0x4,%sp
  48:	66 e8 fc ff          	callw  48 <printInfo+0x9>
  4c:	ff                   	(bad)  
  4d:	ff 67 66             	jmp    *0x66(%edi)
  50:	c7 45 fc 09 00 00 00 	movl   $0x9,-0x4(%ebp)
  57:	67 66 ff 75 fc       	pushw  -0x4(%di)
  5c:	66 e8 fc ff          	callw  5c <printInfo+0x1d>
  60:	ff                   	(bad)  
  61:	ff 66 83             	jmp    *-0x7d(%esi)
  64:	c4 04 66             	les    (%esi,%eiz,2),%eax
  67:	83 c0 30             	add    $0x30,%eax
  6a:	66 0f be c0          	movsbw %al,%ax
  6e:	66 50                	push   %ax
  70:	66 e8 fc ff          	callw  70 <printInfo+0x31>
  74:	ff                   	(bad)  
  75:	ff 66 83             	jmp    *-0x7d(%esi)
  78:	c4 04 67             	les    (%edi,%eiz,2),%eax
  7b:	66 ff 75 fc          	pushw  -0x4(%ebp)
  7f:	66 e8 fc ff          	callw  7f <printInfo+0x40>
  83:	ff                   	(bad)  
  84:	ff 66 83             	jmp    *-0x7d(%esi)
  87:	c4 04 66             	les    (%esi,%eiz,2),%eax
  8a:	6a 17                	push   $0x17
  8c:	66 6a 06             	pushw  $0x6
  8f:	66 50                	push   %ax
  91:	67 66 ff 75 fc       	pushw  -0x4(%di)
  96:	66 e8 fc ff          	callw  96 <printInfo+0x57>
  9a:	ff                   	(bad)  
  9b:	ff 66 83             	jmp    *-0x7d(%esi)
  9e:	c4 10                	les    (%eax),%edx
  a0:	66 a1 00 00 66 50    	mov    0x50660000,%ax
  a6:	66 e8 fc ff          	callw  a6 <printInfo+0x67>
  aa:	ff                   	(bad)  
  ab:	ff 66 83             	jmp    *-0x7d(%esi)
  ae:	c4 04 66             	les    (%esi,%eiz,2),%eax
  b1:	89 c2                	mov    %eax,%edx
  b3:	66 a1 00 00 66 6a    	mov    0x6a660000,%ax
  b9:	17                   	pop    %ss
  ba:	66 6a 09             	pushw  $0x9
  bd:	66 52                	push   %dx
  bf:	66 50                	push   %ax
  c1:	66 e8 fc ff          	callw  c1 <printInfo+0x82>
  c5:	ff                   	(bad)  
  c6:	ff 66 83             	jmp    *-0x7d(%esi)
  c9:	c4 10                	les    (%eax),%edx
  cb:	90                   	nop
  cc:	66 c9                	leavew 
  ce:	66 c3                	retw   

000000d0 <printmsg>:
printmsg():
  d0:	66 55                	push   %bp
  d2:	66 89 e5             	mov    %sp,%bp
  d5:	66 83 ec 08          	sub    $0x8,%sp
  d9:	67 66 c7 45 fc 09 00 	movw   $0x9,-0x4(%di)
  e0:	00 00                	add    %al,(%eax)
  e2:	67 66 c7 45 f8 17 00 	movw   $0x17,-0x8(%di)
  e9:	00 00                	add    %al,(%eax)
  eb:	66 a1 00 00 66 50    	mov    0x50660000,%ax
  f1:	66 e8 fc ff          	callw  f1 <printmsg+0x21>
  f5:	ff                   	(bad)  
  f6:	ff 66 83             	jmp    *-0x7d(%esi)
  f9:	c4 04 66             	les    (%esi,%eiz,2),%eax
  fc:	89 c2                	mov    %eax,%edx
  fe:	66 a1 00 00 67 66    	mov    0x66670000,%ax
 104:	ff 75 f8             	pushl  -0x8(%ebp)
 107:	67 66 ff 75 fc       	pushw  -0x4(%di)
 10c:	66 52                	push   %dx
 10e:	66 50                	push   %ax
 110:	66 e8 fc ff          	callw  110 <printmsg+0x40>
 114:	ff                   	(bad)  
 115:	ff 66 83             	jmp    *-0x7d(%esi)
 118:	c4 10                	les    (%eax),%edx
 11a:	90                   	nop
 11b:	66 c9                	leavew 
 11d:	66 c3                	retw   
