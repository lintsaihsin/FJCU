INCLUDE Irvine32.inc
.data
    myID DWORD 100 dup(?)                ;  studentID
    sizeID = ($-myID)/sizeof DWORD       ;  lengthofmyID
    myID_oddCount  DWORD   ?             ;  Count of odd
    myID_evenSum   DWORD   ?             ;  Sum of even
    myID_result   DWORD    ?             ;  result
    counter DWORD 0                      ; �_�ƭӼưO��
    counter1 DWORD 0                     ; �Ȧs���ƼƦr
    sum DWORD 0                          ; ���ƼƦr�`�M
    ans DWORD 0                          ; �_�ƭӼ� * �����`�M
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
    mov ecx, sizeID                      ; �r���`��
    mov esi, 0                           ; index
L1:
    call readint                         ; ��J
    mov myID[esi], eax
    cmp eax, -1                          
    je answer                            ; �p�G��-1����answer
    mov ebx, eax                         ; ��eax���ȼȦs��EBX
    and eax, 1                           ; �P�_�O�_���_��
    cmp eax, 0
    jz evenn                             ; �p�G�O����, �N���hevenn
    inc counter                          ; �_�ƭӼ�++
    add esi, 4                           ; ����U�@��
    loop L1                              

    jmp answer                           ; for loop ����, ����answer

evenn:
    mov eax, ebx                         ; �N�Ȧs�bebx����,��Jeax
    add sum, eax                         ; ���Ƭۥ[
    add esi, 4                           ; ����U�@��r��
    dec ecx                              ; ecx - 1
    cmp ecx, 0                           ; �ˬd for loop �O�_����
    jz answer                            ; TRUE, �i�Janswer
    jmp L1                               ; FALSE, �^�h for loop

answer:
    cmp esi, 36                          ; �ˬd-1�O�_���̫�@��
    jne endd                             ; ���O�̫�@��, ���hendd

    ; ��X Count of odd------------------------------------------
    mov edx, OFFSET str2
    call writestring
    mov eax , counter
    call writedec
    call crlf
    ;------------------------------------------------------------

    ; ��X Sum of even-------------------------------------------
    mov edx, OFFSET str3
    call writestring
    mov eax , SUM
    call writedec
    call crlf
    ;------------------------------------------------------------

    ; ��X (Count of odd) * (Sum of even) = --------------------
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
   
    ;��X��ӼƦr�ۭ�
    mov eax, sum
    mov ebx, counter
    mul ebx
    call writedec
    call crlf
    jmp enddd
    ;------------------------------------------------------------


endd:                              ; ��X ERROR
    mov edx, OFFSET str1
    call writestring

enddd:
    exit

main ENDP
END main