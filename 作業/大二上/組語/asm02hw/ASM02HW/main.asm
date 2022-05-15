INCLUDE Irvine32.inc
.data
    myID DWORD 100 dup(?)                ;  studentID
    sizeID = ($-myID)/sizeof DWORD       ;  lengthofmyID
    myID_oddCount  DWORD   ?             ;  Count of odd
    myID_evenSum   DWORD   ?             ;  Sum of even
    myID_result   DWORD    ?             ;  result
    counter DWORD 0                      ; 计计癘计
    counter1 DWORD 0                     ; 既案计计
    sum DWORD 0                          ; 案计计羆㎝
    ans DWORD 0                          ; 计计 * 案计羆㎝
    str1 BYTE "Error",0                  
    str2 BYTE "Odd count: ",0
    str3 BYTE "Even sum: ",0
    str4 BYTE "Result: ",0
    str5 BYTE " * ",0
    str6 BYTE " = ",0
    str7 BYTE "Result: ",0

.code
main PROC
    mov eax, 0
    mov ecx, sizeID                      ; じ羆计
    mov esi, 0                           ; index
L1:
    call readint                         ; 块
    mov myID[esi], eax
    cmp eax, -1                          
    je answer                            ; 狦-1铬answer
    mov ebx, eax                         ; рeax既EBX
    and eax, 1                           ; 耞琌计
    cmp eax, 0
    jz evenn                             ; 狦琌案计, 碞铬evenn
    inc counter                          ; 计计++
    add esi, 4                           ; 簿
    loop L1                              

    jmp answer                           ; for loop 挡, 铬answer

evenn:
    mov eax, ebx                         ; 盢既ebx,eax
    add sum, eax                         ; 案计
    add esi, 4                           ; 铬じ
    dec ecx                              ; ecx - 1
    cmp ecx, 0                           ; 浪琩 for loop 琌挡
    jz answer                            ; TRUE, 秈answer
    jmp L1                               ; FALSE,  for loop

answer:
    cmp esi, 36                          ; 浪琩-1琌程
    jne endd                             ; ぃ琌程, 铬endd

    ; 块 Count of odd------------------------------------------
    mov edx, OFFSET str2
    call writestring
    mov eax , counter
    call writedec
    call crlf
    ;------------------------------------------------------------

    ; 块 Sum of even-------------------------------------------
    mov edx, OFFSET str3
    call writestring
    mov eax , SUM
    call writedec
    call crlf
    ;------------------------------------------------------------

    ; 块 (Count of odd) * (Sum of even) = --------------------
    mov edx, OFFSET str7
    call writestring
    mov eax , counter
    call writedec
    mov edx, OFFSET str5
    call writestring
    mov eax , SUM
    call writedec
    mov edx, OFFSET str6
    call writestring
    ;------------------------------------------------------------
   
    ;块ㄢ计
    mov eax, sum
    mov ebx, counter
    mul ebx
    call writedec
    call crlf
    jmp enddd
    ;------------------------------------------------------------


endd:                              ; 块 ERROR
    mov edx, OFFSET str1
    call writestring

enddd:
    exit

main ENDP
END main