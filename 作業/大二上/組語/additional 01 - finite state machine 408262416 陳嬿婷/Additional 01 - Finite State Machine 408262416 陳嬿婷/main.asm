INCLUDE Irvine32.inc
.data
	wrong BYTE "The input contains odd number of 0s.",0
	ENTER_KEY BYTE ?
	correct BYTE "The input contains even number of 0s.",0
.code
main PROC
StateA:            
	call ReadInt   ;輸入
	cmp	al,0         	
	je	StateB     ;如果是0跳到 State B 	
	cmp	al,1         	
	je	StateA     ;如果是1跳到 State A 	     	
	jmp	Evenn	   ;如果輸入值不是0或1的話則跳到Evenn
StateB:
	call ReadInt       		
	cmp	al,0         	
	je	StateA     ;如果是0跳到 State A 	     	
	cmp	al,1         	
	je	StateB     ;如果是1跳到 State B 	     	
	jmp Oddd  	   ;如果輸入值不是0或1的話則跳到Oddd
;輸出有偶數個0---------------
Evenn:
    mov edx, OFFSET correct
    call writestring  
	call Crlf
	exit
;輸出有奇數個0---------------
oddd:
	 push  edx
	 mov   edx,OFFSET wrong
	 call  WriteString
	 call Crlf
	 pop   edx
	 exit
;----------------------------
main ENDP
END main