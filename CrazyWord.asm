AboutProc	PROTO :HWND,:UINT,:WPARAM,:LPARAM;sub_401A25 		PROTO :HWND,:UINT,:WPARAM,:LPARAM
sub_401775 		PROTO
sub_4017AD 		PROTO :DWORD
sub_4017CC 		PROTO :DWORD,:DWORD
sub_401802 		PROTO
sub_4017E2 		PROTO
StartAddress 	PROTO
sub_4019C7 		PROTO


.data
dword_40C004    dd 0              
dword_40C008    dd 0              
dword_40C010    dd 0             
dword_40C014    dd 0              
dword_40C018    dd 0               
dword_40C020    dd 0               
dword_40C024    dd 0             
dword_40C02C    dd 0  
dword_40C030    dd 0    

AboutText    	db "  .:: PERYERiAH tEAM PrEsEnTs ::.",0Dh,0Dh
				db "[ Accdb Password Get v5.12 KeyGen ]",0Dh,0Dh
				db "[ Author     : sabYn............. ]",0Dh
                db "[ Date       : o5.o1.2o22........ ]",0Dh
				db "[ Protection : MD5............... ]",0Dh,0Dh
				db "[ GreetZ 2 :                      ",0Dh,0Dh
				db "[ Al0hA ......................[PRF]",0Dh
				db "[ B@TRyNU ....................[PRF]",0Dh
				db "[ WeeGee .....................[PRF]",0Dh
				db "[ MaryNello ..................[PRF]",0Dh
				db "[ r0ger ......................[PRF]",0Dh
				db "[ GRUiA ......................[PRF]",0Dh
				db "[ zzLaTaNN ...................[PRF]",0Dh
				db "[ oViSpider ..................[PRF]",0Dh
				db "[ bDM10 ......................[PRF]",0Dh
				db "[ yMRAN ......................[PRF]",0Dh
				db "[ ShTEFY .....................[PRF]",0Dh
				db "[ DAViD ......................[PRF]",0Dh
				db "[ PuMMy ......................[PRF]",0Dh
				db "[ QueenAntonia ...............[PRF]",0Dh
				db "[ and other [ P R F ] members.....]",0Dh,0Dh
				db "[ also:.......................... ]",0Dh
				db "[ Cachito ...................[TSRh]",0Dh
				db "[ Talers ....................[TSRh]",0Dh
				db "[ Xylitol ....................[RED]",0Dh
				db "[ kao ............................]",0Dh
				db "[ Razorblade1979 ............[URET]",0Dh
				db "[ Arttomov ..................[URET]",0Dh
				db "[ Jasi2169 ..................[URET]",0Dh,0Dh
				db "[  ...  and mainly other ppl . ^) ]",0Dh,0Dh
				db "[ ShoutoutZ 2 :",0Dh,0Dh
				db "[ r0ger...............[keygen temp]",0Dh
				db "[ oskar.....................[music]",0Dh
				db "[ eNeRGy................[libv2 1.5]",0Dh
				db "[ x0man................[about temp]",0Dh,0Dh
				db "[ instagram : @r0gerica.......... ]",0Dh
				db "[ ........... @sabiintheo........ ]",0Dh
				db "[ discord   : r0gerica#2649...... ]",0Dh
				db "[ telegram  : t.me/r0ger888...... ]",0Dh
				db "[ github    : r0gerica........... ]",0Dh,0Dh
				db "[        fuck da cheaterz .       ]",0Dh
				db "[   fuck Carlos & Rajan Kumar .   ]",0
				
				
aWnd    dd 0                    
Globalstop	BOOL	FALSE							
dword_40C421    dd 0                   
dword_40C425    dd 0                 
hMem            dd 0                 
JumpHeight    	dd 14h                
TextLeft    	dd 1Fh             
StartPosition    dd 104h               
aWidth			dd 340
aHeight			dd 260
dword_40C439    dd 0                   
                                        
dword_40C43D    dd 0                   
hdc             dd 0                
hdcDest         dd 0              
ahFont    dd 0                                                    
hBitmap			dd 0      
ThreadId        dd 0      
dword_40C455    dd 0          
AboutBoxTitle   db "PRF TeaM",0     
AboutFont     LOGFONT <8,6,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'terminal'>   
TextLength     db 35h      
	
; aboutbox temp inspired from Open_Video_Converter_3.0.3.Patch.bagie.tPORt

.code

sub_401775      proc ;near               ; CODE XREF: sub_401A25+27p
;SystemTime      = SYSTEMTIME ptr -10h
local SystemTime:SYSTEMTIME
                lea     eax, SystemTime
                push    eax            
                call    GetSystemTime
                movzx   eax, SystemTime.wHour
                imul    eax, 3Ch
                add     ax, SystemTime.wMinute
                imul    eax, 3Ch
                xor     edx, edx
                mov     dx, SystemTime.wSecond
                add     eax, edx
                imul    eax, 3E8h
                mov     dx, SystemTime.wMilliseconds
                add     eax, edx
                mov     dword_40C421, eax
				ret
sub_401775      endp


sub_4017AD      proc arg_0000:DWORD;near               ; CODE XREF: StartAddress+A3p
;arg_0000           = dword ptr  8
                mov     eax, arg_0000
                imul    edx, dword_40C421, 8088405h
                inc     edx
                mov     dword_40C421, edx
                mul     edx
                mov     eax, edx
				ret
sub_4017AD      endp


sub_4017CC      proc arg_000:DWORD,arg_444:DWORD
;arg_000           = dword ptr  8
;arg_444           = dword ptr  0Ch
                shr     [arg_444], 1
                shr     [arg_000], 1
                mov     eax, arg_000
                sub     arg_444, eax
                mov     eax,arg_444
				ret
sub_4017CC      endp


sub_4017E2      proc near 
                push    offset AboutText
                call    lstrlen
                mov     dword_40C425, eax
                imul    eax, 15h
                push    eax      
                push    40h  
                call    GlobalAlloc
                mov     hMem, eax
				ret
sub_4017E2      endp


sub_401802      proc
LOCAL var_88:DWORD
LOCAL var_44:DWORD
                push    TextLeft
                pop var_44
                push    StartPosition
                pop var_88
                mov     edx, hMem
                mov     ecx, offset AboutText
                xor     eax, eax
loc_401827: 
                push    eax
                mov     al, [ecx]
                mov     [edx], al
                push var_44
                pop     dword ptr [edx+1]
                push var_88
                pop     dword ptr [edx+5]
                push    dword ptr [edx+1]
                pop     dword ptr [edx+9]
                push    dword ptr [edx+5]
                pop     dword ptr [edx+0Dh]
                add var_44,8
                add     edx, 15h
                cmp     al, 0Dh
                jnz     short loc_40185C
                push    TextLeft
                pop var_44
                add var_88,0Fh
loc_40185C: 
                pop     eax
                inc     eax
                inc     ecx
                cmp     dword_40C425, eax
                ja      short loc_401827
				ret
sub_401802      endp

StartAddress    proc
LOCAL hdcSrc:HDC 
LOCAL hBackground:DWORD
LOCAL var_4:DWORD
                
                invoke CreateCompatibleDC,0
                mov hdcSrc,eax 
                invoke FindResource,hInstance,250,eax                 
			    invoke BitmapFromResource,eax,250
                mov hBackground,eax
	            invoke SelectObject,hdcSrc,hBackground
	             
loc_401897:    
                mov var_4,0
           		invoke StretchBlt,hdcDest,0,0,aWidth,aHeight,hdcSrc,0,0,aWidth,aHeight,0CC0020h
                mov     edx, hMem

loc_4018CD:  
                mov     eax, [edx+5]
                cmp     [edx+0Dh], eax
                jnz     short loc_401939
                mov     eax, [edx+1]
                mov     ecx, eax
                add     ecx, 7
                cmp     dword_40C439, eax
                jb      short loc_40193F
                cmp     dword_40C439, ecx
                ja      short loc_40193F
                mov     eax, [edx+5]
                mov     ecx, eax
                add     ecx, 0Fh
                cmp     dword_40C43D, eax
                jb      short loc_401937
                cmp     dword_40C43D, ecx
                ja      short loc_401937
                push    edx
                push    JumpHeight
                call    sub_4017AD
                pop     edx
                mov     ecx, eax
                push    edx
                push    2
                call    sub_4017AD
                pop     edx
                cmp     al, 1
                jnz     short loc_40192D
                mov     dword ptr [edx+11h], 1
                imul    ecx, -1
                jmp     short loc_401934
; ---------------------------------------------------------------------------
loc_40192D:                   
                mov     dword ptr [edx+11h], 0FFFFFFFFh
loc_401934:           
                add     [edx+5], ecx
loc_401937:  
                jmp     short loc_40193F
; ---------------------------------------------------------------------------
loc_401939: 
                mov     eax, [edx+11h]
                add     [edx+5], eax
loc_40193F:    
                push    edx
                cmp     byte ptr [edx], 0Dh
                jz      short loc_40195B
                push    1    
                lea     eax, [edx]
                push    eax  
                push    dword ptr [edx+5]
                push    dword ptr [edx+1] 
                push    hdcDest        
                call    TextOut

loc_40195B:  
                pop     edx
                movzx   ecx, TextLength
                imul    ecx, 0Fh
                imul    ecx, -1
                cmp     ecx, [edx+5]
                jnz     short loc_401975
                pusha
                call    sub_401802
                popa

loc_401975:   
                add     edx, 15h
                mov     eax, dword_40C425
                inc var_4
                cmp var_4,eax
                jb      loc_4018CD
                push    0CC0020h  
                push    0             
                push    0             
                push    hdcDest  
                push    aHeight ; height
                push    aWidth ; width  
                push    0          
                push    0           
                push    hdc         
                call    BitBlt
                push    0Ah                    
                call    Sleep
                cmp     Globalstop, 1
                jnz     loc_401897
				ret
StartAddress    endp


sub_4019C7      proc 
                mov     ecx, dword_40C425
                mov     edx, hMem
loc_4019D3: 
                mov     eax, [edx+5]
                cmp     [edx+0Dh], eax
                jnz     short loc_401A09
                push    ecx
                push    edx
                push    3
                call    sub_4017AD
                mov     ecx, eax
                push    2
                call    sub_4017AD
                pop     edx
                cmp     al, 1
                jnz     short loc_4019FE
                mov     dword ptr [edx+11h], 1
                imul    ecx, -1
                jmp     short loc_401A05
; ---------------------------------------------------------------------------
loc_4019FE: 
                mov     dword ptr [edx+11h], 0FFFFFFFFh
loc_401A05: 
                add     [edx+5], ecx
                pop     ecx
loc_401A09:    
                dec     dword ptr [edx+0Dh]
                dec     dword ptr [edx+5]
                add     edx, 15h
                loop    loc_4019D3
                invoke Sleep,32h
                cmp     Globalstop, 1
                jnz     short sub_4019C7
				ret
sub_4019C7      endp


AboutProc proc hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
LOCAL Y:DWORD
LOCAL X:DWORD
LOCAL Aboutrect:RECT
	
                mov eax,uMsg
                cmp     eax, 110h ; <-- WM_INITDIALOG
                jnz     loc_401BAF
                mov     Globalstop, 0
                push hWnd
                pop     aWnd
                call    sub_401775
               	invoke GetParent, hWnd
				mov ecx, eax
				invoke GetWindowRect, ecx, addr Aboutrect
				mov edi, Aboutrect.left
				mov esi, Aboutrect.top
				add edi, 0
				add esi, 0
				invoke SetWindowPos,hWnd,HWND_TOP,edi,esi,aWidth,aHeight,SWP_SHOWWINDOW
               invoke SetWindowText,hWnd,offset AboutBoxTitle
               invoke GetDC,aWnd
                mov     hdc, eax
               invoke CreateCompatibleDC,0
                mov     hdcDest, eax
               invoke CreateBitmap,aWidth,aHeight,1,20h,0
                mov     hBitmap, eax
                invoke CreateFontIndirect,addr AboutFont
                mov     ahFont, eax
                invoke SelectObject,hdcDest,hBitmap
                invoke SelectObject,hdcDest,ahFont
                invoke SetBkMode,hdcDest,1
                xor     eax, eax
                mov     ah, 0
                mov     al, 0
                rol     eax, 8
                mov     al, 0
                invoke SetTextColor,hdcDest,White
             ;   invoke CreateRoundRectRgn,0,0,aWidth,aHeight,28h,28h
              ;  invoke SetWindowRgn,hWnd,eax,1
                call    sub_4017E2
                call    sub_401802
                invoke CreateThread,0,0,offset StartAddress,0,0,offset ThreadId
                invoke CreateThread,0,0,offset sub_4019C7,0,0,offset dword_40C455
                jmp     loc_401C83
; ---------------------------------------------------------------------------
loc_401BAF:                  
                cmp uMsg,200h ; <-- WM_MOUSEMOVE
                jnz     short loc_401BD5
                mov eax,lParam;arg_C
                and     eax, 0FFFFh
                mov     dword_40C439, eax
                mov eax,lParam;arg_C
                shr     eax, 10h
                mov     dword_40C43D, eax
                jmp     loc_401C83
; ---------------------------------------------------------------------------
loc_401BD5:                            
                cmp     eax, 201h ; <-- WM_LBUTTONDOWN
                jnz     short loc_401C09
                push    0             
                push    0               
                push    10h           
                push hWnd
                call    SendMessage
                jmp     short loc_401C83
; ---------------------------------------------------------------------------
loc_401C09:                           
                cmp     eax, 10h ; <-- WM_CLOSE
                jnz     short loc_401C83
                mov     Globalstop, 1
                invoke Sleep,64h
                invoke ReleaseDC,aWnd,hdc
                invoke DeleteObject,hdcDest
                invoke DeleteObject,ahFont
                invoke DeleteObject,hBitmap
                invoke TerminateThread,ThreadId,0
                invoke TerminateThread,ThreadId,0
                invoke GlobalFree,hMem
                invoke EndDialog,aWnd,0
loc_401C83:                                                             
                xor     eax, eax
				ret
AboutProc      endp