.686
.model	flat, stdcall
option	casemap :none

include	resID.inc
include staticline.asm
include algo.asm
include textscr_mod.asm
include CrazyWord.asm

AllowSingleInstance MACRO lpTitle
        invoke FindWindow,NULL,lpTitle
        cmp eax, 0
        je @F
          push eax
          invoke ShowWindow,eax,SW_RESTORE
          pop eax
          invoke SetForegroundWindow,eax
          mov eax, 0
          ret
        @@:
ENDM

.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	InitCommonControls
	invoke LoadBitmap,hInstance,400
	mov hIMG,eax
	invoke CreatePatternBrush,eax
	mov hBrush,eax
	AllowSingleInstance addr WindowTitle
	invoke	DialogBoxParam, hInstance, IDD_MAIN, 0, offset DlgProc, 0
	invoke	ExitProcess, eax

DlgProc proc hDlg:HWND,uMessg:UINT,wParams:WPARAM,lParam:LPARAM
LOCAL X:DWORD
LOCAL Y:DWORD
LOCAL ps:PAINTSTRUCT

	.if [uMessg] == WM_INITDIALOG
 
		mov eax, 340
		mov nHeight, eax
		mov eax, 260
		mov nWidth, eax                
		invoke GetSystemMetrics,0                
		sub eax, nHeight
		shr eax, 1
		mov [X], eax
		invoke GetSystemMetrics,1               
		sub eax, nWidth
		shr eax, 1
		mov [Y], eax
		invoke SetWindowPos,hDlg,0,X,Y,nHeight,nWidth,40h
            	
		invoke	LoadIcon,hInstance,200
		invoke	SendMessage, hDlg, WM_SETICON, 1, eax
		invoke  SetWindowText,hDlg,addr WindowTitle
		invoke  SetDlgItemText,hDlg,IDC_MAIL,addr DefaultMail
		invoke 	SendDlgItemMessage, hDlg, IDC_MAIL, EM_SETLIMITTEXT, 31, 0
		invoke  StaticLineInit,hDlg
		invoke  ScrollerInit,hDlg
		invoke CreateFontIndirect,addr TxtFont
		mov hFont,eax
		invoke GetDlgItem,hDlg,IDC_MAIL
		mov hMail,eax
		invoke SendMessage,eax,WM_SETFONT,hFont,1
		invoke GetDlgItem,hDlg,IDC_SERIAL
		mov hSerial,eax
		invoke SendMessage,eax,WM_SETFONT,hFont,1
		
		invoke ImageButton,hDlg,19,212,500,502,501,IDB_COPY
		mov hCopy,eax
		invoke ImageButton,hDlg,132,210,600,602,601,IDB_ABOUT
		mov hAbout,eax
		invoke ImageButton,hDlg,250,210,700,702,701,IDB_EXIT
		mov hExit,eax
		
		invoke GenKey,hDlg
		
		invoke V2M_V15_Init,FUNC(GetForegroundWindow),offset theTune,1000,44100,1 
		invoke V2M_V15_Play,0
		
	.elseif [uMessg] == WM_LBUTTONDOWN

		invoke SendMessage, hDlg, WM_NCLBUTTONDOWN, HTCAPTION, 0

	.elseif [uMessg] == WM_CTLCOLORDLG

		return hBrush

	.elseif [uMessg] == WM_PAINT
                
		invoke BeginPaint,hDlg,addr ps
		mov edi,eax
		lea ebx,r3kt
		assume ebx:ptr RECT
                
		invoke GetClientRect,hDlg,ebx
		invoke CreateSolidBrush,0
		invoke FrameRect,edi,ebx,eax
		invoke EndPaint,hDlg,addr ps                   
     
    .elseif [uMessg] == WM_CTLCOLOREDIT
    
		invoke SetBkMode,wParams,TRANSPARENT
		invoke SetTextColor,wParams,White
		invoke GetWindowRect,hDlg,addr WndRect
		invoke GetDlgItem,hDlg,IDC_MAIL
		invoke GetWindowRect,eax,addr MailRect
		mov edi,WndRect.left
		mov esi,MailRect.left
		sub edi,esi
		mov ebx,WndRect.top
		mov edx,MailRect.top
		sub ebx,edx
		invoke SetBrushOrgEx,wParams,edi,ebx,0
		mov eax,hBrush
		ret        
	
	.elseif [uMessg] == WM_CTLCOLORSTATIC
	
		invoke SetBkMode,wParams,TRANSPARENT
		invoke SetTextColor,wParams,White
		invoke GetWindowRect,hDlg,addr XndRect
		invoke GetDlgItem,hDlg,IDC_SERIAL
		invoke GetWindowRect,eax,addr SerialRect
		mov edi,XndRect.left
		mov esi,SerialRect.left
		sub edi,esi
		mov ebx,XndRect.top
		mov edx,SerialRect.top
		sub ebx,edx
		invoke SetBrushOrgEx,wParams,edi,ebx,0
		mov eax,hBrush
		ret

	.elseif [uMessg] == WM_COMMAND
        
		mov eax,wParams
		mov edx,eax
		shr edx,16
		and eax,0ffffh      
		.if edx == EN_CHANGE
			.if eax == IDC_MAIL
				invoke GenKey,hDlg
			.endif
		.endif  
		.if	eax==IDB_COPY
			invoke SendDlgItemMessage,hDlg,IDC_SERIAL,EM_SETSEL,0,-1
			invoke SendDlgItemMessage,hDlg,IDC_SERIAL,WM_COPY,0,0
		.elseif eax == IDB_ABOUT
			invoke DialogBoxParam,0,IDD_ABOUT,hDlg,offset AboutProc,0
		.elseif eax == IDB_EXIT
			invoke SendMessage,hDlg,WM_CLOSE,0,0
		.endif 
             
	.elseif [uMessg] == WM_CLOSE	
		invoke V2M_V15_Stop,0
		invoke V2M_V15_Close       
		invoke FreeStatic,hDlg
		invoke EndDialog,hDlg,0     
	.endif
         xor eax,eax
         ret
DlgProc endp

end start