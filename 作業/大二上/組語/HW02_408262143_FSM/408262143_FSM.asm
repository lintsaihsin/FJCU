
INCLUDE Irvine32.inc
.data
    myID DWORD 100 dup(?) ;  studentID
    sizeID = ($-myID)/sizeof DWORD ;  lengthofmyID
    str1 BYTE "the input contains even number of 0s. ",0 ; ���ƭ�0
    str2 BYTE "the input contains odd number of 0s. ", 0 ; �_�ƭ�0
.code
main PROC
    mov eax, 0
    mov ecx, sizeID ; �ˬd�r���`��
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
    jz zzero ; ��0
    add esi, 4
    loop L1
    jmp answer ; for loop ���� ���쵪��

zzero:
    dec ecx 
    add esi, 4
    cmp ebx, 1 ; �ثe0���ӼƬ��_��
    jnz evenn
    mov ebx, 0 ; �_�ƭ�0 ����0
    cmp ecx, 0 ; �ˬd for loop �O�_����
    jz answer ; �j�鵲�� ���쵪��
    jmp L1 ; �|������ �^�h for loop

evenn:
    mov ebx, 1  ; ���ƭ�0 ����1
    cmp ecx, 0 ; �ˬd for loop �O�_����
    jz answer ; �j�鵲�� ���쵪��
    jmp L1 ; �|������ �^�h for loop

answer:
    cmp ebx, 1 
    jne endd  ; �_�ƭ�0 ���hendd
    mov edx, OFFSET str1 ; ���ƭ�0
    call writestring
    jmp enddd

endd:                              
    mov edx, OFFSET str2 ; �_�ƭ�0
    call writestring

enddd:
    exit
main ENDP
END main
