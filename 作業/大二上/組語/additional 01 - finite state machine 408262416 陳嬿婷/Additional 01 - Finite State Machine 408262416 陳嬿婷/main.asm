INCLUDE Irvine32.inc
.data
	wrong BYTE "The input contains odd number of 0s.",0
	ENTER_KEY BYTE ?
	correct BYTE "The input contains even number of 0s.",0
.code
main PROC
StateA:            
	call ReadInt   ;��J
	cmp	al,0         	
	je	StateB     ;�p�G�O0���� State B 	
	cmp	al,1         	
	je	StateA     ;�p�G�O1���� State A 	     	
	jmp	Evenn	   ;�p�G��J�Ȥ��O0��1���ܫh����Evenn
StateB:
	call ReadInt       		
	cmp	al,0         	
	je	StateA     ;�p�G�O0���� State A 	     	
	cmp	al,1         	
	je	StateB     ;�p�G�O1���� State B 	     	
	jmp Oddd  	   ;�p�G��J�Ȥ��O0��1���ܫh����Oddd
;��X�����ƭ�0---------------
Evenn:
    mov edx, OFFSET correct
    call writestring  
	call Crlf
	exit
;��X���_�ƭ�0---------------
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