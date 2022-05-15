
INCLUDE Irvine32.inc
.data
    myID DWORD 100 dup(?) ;  studentID
    sizeID = ($-myID)/sizeof DWORD ;  lengthofmyID
    str1 BYTE "the input contains even number of 0s. ",0 ; 偶數個0
    str2 BYTE "the input contains odd number of 0s. ", 0 ; 奇數個0
.code
main PROC
    mov eax, 0
    mov ecx, sizeID ; 檢查字元總數
    mov esi, 0
    mov ebx, 1
L1:
    call readint
    mov myID[esi], eax
    mov eax, myID[esi]
    cmp eax, -1
    je answer
    or eax, 0                           
    cmp eax, 0 
    jz zzero ; 找0
    add esi, 4
    loop L1
    jmp answer ; for loop 結束 跳到答案

zzero:
    dec ecx 
    add esi, 4
    cmp ebx, 1 ; 目前0的個數為奇偶
    jnz evenn
    mov ebx, 0 ; 奇數個0 換成0
    cmp ecx, 0 ; 檢查 for loop 是否結束
    jz answer ; 迴圈結束 跳到答案
    jmp L1 ; 尚未結束 回去 for loop

evenn:
    mov ebx, 1  ; 偶數個0 換成1
    cmp ecx, 0 ; 檢查 for loop 是否結束
    jz answer ; 迴圈結束 跳到答案
    jmp L1 ; 尚未結束 回去 for loop

answer:
    cmp ebx, 1 
    jne endd  ; 奇數個0 跳去endd
    mov edx, OFFSET str1 ; 偶數個0
    call writestring
    jmp enddd

endd:                              
    mov edx, OFFSET str2 ; 奇數個0
    call writestring

enddd:
    exit
main ENDP
END main
