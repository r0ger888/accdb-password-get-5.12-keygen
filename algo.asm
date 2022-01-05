include md5.asm

Hex2ch		PROTO	:DWORD,:DWORD,:DWORD
GenKey		PROTO	:DWORD
Ismail		PROTO	:DWORD,:DWORD

.data
MD5Mailhash	db	100h dup(0)
Magicstr	db	"http://accdbpassword.bistonesoft.com",0
Nomail		db	"Insert ur mail!",0
NoAront		db	"U forgot ur @ char..",0
Toolong		db	"Mail too long!",0

.data?
Mailbuff	db	60h	dup(?)
MD5hash		db	60h	dup(?)
Srlbuff		db	60h	dup(?)
Finalbuff	db	60h	dup(?)
hLen		dd	?


.code
Hex2ch proc HexValue:DWORD,CharValue:DWORD,HexLength:DWORD
    mov esi,[ebp+8]
    mov edi,[ebp+0Ch]
    mov ecx,[ebp+10h]
    @HexToChar:
      lodsb
      mov ah, al
      and ah, 0Fh
      shr al, 4
      add al, '0'
      add ah, '0'
       .if al > '9'
          add al, 'A'-'9'-1
       .endif
       .if ah > '9'
          add ah, 'A'-'9'-1
       .endif
      stosw
    loopd @HexToChar
    ret
Hex2ch endp

GenKey proc hWin:DWORD

	invoke GetDlgItemText,hWin,IDC_MAIL,addr Mailbuff,256
	cmp eax,0
	je no_mail
	cmp eax,31
	je toolong
	
	invoke Ismail,addr Mailbuff,256
	.if eax == 0
		invoke SetDlgItemText,hWin,IDC_SERIAL,addr NoAront
		invoke GetDlgItem,hWin,IDB_COPY
		invoke EnableWindow,eax,FALSE
		ret
	.endif
	
	invoke lstrcat,addr MD5hash,addr Mailbuff
	invoke lstrcat,addr MD5hash,addr Magicstr
	invoke lstrlen,addr MD5hash
	mov hLen,eax
	invoke MD5Init
	invoke MD5Update,addr MD5hash,hLen
	invoke MD5Final
	invoke Hex2ch,addr MD5Digest,addr MD5Mailhash,16
	invoke lstrcpyn,addr Finalbuff,addr MD5Mailhash,33
	invoke lstrcat,addr Srlbuff,addr Finalbuff
	invoke SetDlgItemText,hWin,IDC_SERIAL,addr Srlbuff
	invoke GetDlgItem,hWin,IDB_COPY
	invoke EnableWindow,eax,TRUE
	call Clean
	ret
	
	no_mail:
	invoke SetDlgItemText,hWin,IDC_SERIAL,addr Nomail
	invoke GetDlgItem,hWin,IDB_COPY
	invoke EnableWindow,eax,FALSE
	ret

	toolong:
	invoke SetDlgItemText,hWin,IDC_SERIAL,addr Toolong
	invoke GetDlgItem,hWin,IDB_COPY
	invoke EnableWindow,eax,FALSE
	ret
GenKey endp

Clean proc
	
	invoke RtlZeroMemory,addr Mailbuff,sizeof Mailbuff
	invoke RtlZeroMemory,addr MD5Mailhash,sizeof MD5Mailhash
	invoke RtlZeroMemory,addr Srlbuff,sizeof Srlbuff
    invoke RtlZeroMemory,addr MD5hash,sizeof MD5hash
    invoke RtlZeroMemory,addr Finalbuff,sizeof Finalbuff
    
	Ret
Clean endp

Ismail proc uses esi ecx Value:DWORD,szValue:DWORD
	mov esi, [ebp+8]
	mov ecx, [ebp+0ch]
	xor eax,eax
	mov edx, '@'
	a1:
	lodsb
	cmp eax, edx
	je a0
	loopne a1
	xor eax, eax
	Ret
	a0:
	mov eax, 1
	Ret
Ismail endp