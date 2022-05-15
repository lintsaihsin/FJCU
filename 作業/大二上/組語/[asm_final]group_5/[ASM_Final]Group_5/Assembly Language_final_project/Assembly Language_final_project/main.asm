INCLUDE Irvine32.inc

;macros
; �w��X,Y�y��--------------
mGotoxy MACRO X:REQ, Y:REQ                              
    PUSH    EDX
    MOV DH, Y
    MOV DL, X
    CALL    Gotoxy
    POP EDX
ENDM
;--------------------------
; �L�X��----------------------------------------
mWrite MACRO text:REQ                                   
    LOCAL string
    .data
        string BYTE text, 0
    .code
        mov al , 15 + ( 0 * 16 );�����C��
        call SetTextColor

        PUSH    EDX
        MOV EDX, OFFSET string
        CALL    WriteString
        POP EDX
ENDM
;-----------------------------------------------
;Ū���r��----------------
mReadString MACRO var:REQ                               
    PUSH    ECX
    PUSH    EDX
    MOV EDX, OFFSET var
    MOV ECX, SIZEOF var
    CALL    ReadString
    POP EDX
    POP ECX
ENDM
;------------------------
;�L�X�r��--------------------------
mWriteString MACRO buffer:REQ                           
     mov al , 15 + ( 0 * 16 );�����C��
    call SetTextColor

    PUSH    EDX
    MOV EDX, OFFSET buffer
    CALL    WriteString
    POP EDX
ENDM
;----------------------------------
; Game "Window" Setup:
    maxX    EQU 115; �]�w�C���d��
    maxY    EQU 28
    wallHor EQU "--------------------------------------------------------------------------------------------------------------------"
    wallVert    EQU '|'
    maxSize EQU 255
;-----------------------------------

; Structs:
;x, y �y�Ъ����c
AXIS STRUCT                                             
    x BYTE 0                                            
    y BYTE 0
AXIS ENDS
;-------------

;�]�w�W�U���k����---------------
    VK_LEFT     EQU 000000025h                          
    VK_UP       EQU 000000026h
    VK_RIGHT    EQU 000000027h
    VK_DOWN     EQU 000000028h
;-----------------------------

; Prototypes:
GetKeyState PROTO, nVirtKey:DWORD

.data
    score dword 0
    ranbon dword 0
    foodPoint   AXIS    <0,0>; �����y��
    SnakeBody   AXIS    maxSize DUP(<0,0>) ; �D�y��

    speed   DWORD   60 ;�t��

    snake       BYTE    '#'
    choice  BYTE    0
    playerName  BYTE    13 + 1 DUP (?)

;�D�X�ͮy��----------------
    currentX    BYTE    40                          
    currentY    BYTE    10
;-------------------------
;�����Ϊ�---------------------
    foodChar0  BYTE   'A'                        
    foodChar1  BYTE   'B'
    foodChar2  BYTE   'C'
    foodChar3  BYTE   'D'
    foodChar4  BYTE   'E'
    foodnum    BYTE   5
    foodrandomnum    DWORD  5
;----------------------------
;�Y���y�Ъ�index--------------
    headIndex       BYTE    3   
    tailIndex       BYTE    0
;-----------------------------
;��l�Ʋ��ʱ���----------------
    LEFT            BYTE    0                       
    RIGHT           BYTE    1                       
    UP              BYTE    0
    DOWN            BYTE    0
;-----------------------------

    wrong byte "you enter the wrong message, try again !",0
    again byte "Maybe you can try again later !",0
    good  byte "Maybe you can get higher score, haha !",0
    excellent  byte "Congraduation! You got high scores !",0

.code
main PROC
   call startgame
   exit
main ENDP  

;�e�X��---------------------
PrintWalls PROC        
    mGotoxy 0, 1     
    mWrite  wallHor
    mGotoxy 0, maxY                                     
    mWrite  wallHor    
    mov cl, maxY - 1                                    
    
X00:
    cmp cl, 1                                           
    je  X01                                             
        mGotoxy 0, CL                                   
        mWrite  wallVert                                
        mGotoxy maxX, CL
        mWrite  wallVert                                
        dec CL                                          
    jmp X00                                             

X01:
    ret
PrintWalls ENDP
;---------------------------

;��l�e��----------------
DrawFirstScreen PROC
    CALL    ClrScr
    CALL    PrintWalls
        
    mGotoxy 28, 3                                       
    mWrite  "            _____          _____   ____   __    __ ______"
    mGotoxy 28, 4                                       
    mWrite  "|        | |       |      /       /    \  | \  / | |     "   
    mGotoxy 28, 5 
    mWrite  "|        | |       |      |       |    |  |  \/  | |"
    mGotoxy 28, 6
    mWrite  "|   /\   | |_____  |      |       |    |  |      | |_____ "
    mGotoxy 28, 7
    mWrite  "|  /  \  | |       |      |       |    |  |      | |     "
    mGotoxy 28, 8
    mWrite  "\_/    \_/ |_____  |_____ \_____  \____/  |      | |_____ "

    
    mGotoxy 10, 10                                     
    mWrite  "       \|/                                                                           \|/"   
    mGotoxy 10, 11  
    mWrite  "    ____|______                                                                 ______|_____"
    mGotoxy 10, 12
    mWrite  "  /            \                                                               /            \"
    mGotoxy 10, 13
    mWrite  " /              \                                                             /              \"
    mGotoxy 10, 14
    mWrite  "|                |                                                           |                |"
    mGotoxy 10, 15
    mWrite  "|  *****  *****  |                                                           |  *****  *****  |"
    mGotoxy 10, 16
    mWrite  "|    *      *    |                                                           |   *      *     |"
    mGotoxy 10, 17
    mWrite  "|       *        |                                                           |      *         |"
    mGotoxy 10, 18
    mWrite  "|         *      |                                                           |     *          |"
    mGotoxy 10, 19     
    mWrite  "|       *        |                                                           |      *         |"
    mGotoxy 10, 20                        
    mWrite  "|   **********   |                                                           |   **********   |"
    mGotoxy 10, 21
    mWrite  "|    *      *    |                                                           |    *      *    |"
    mGotoxy 10, 22
    mWrite  "|     ******     |                                                           |     ******     |"
    mGotoxy 10, 23
    mWrite  "|________________|                                                           |________________|"
;�򥻸��-------------------------------
    mGotoxy 40, 12                                      
    mWrite  "Assembly Language Final Group Project"
    mGotoxy 55, 14                                      
    mWrite  "Group 5"
    mGotoxy 40, 16
    mWrite  "��u�G�A     408262143    Tsai-Hsin Lin"
    mGotoxy 40, 18
    mWrite  "��u�G�A     408262349    Zi-Qing Chang"
    mGotoxy 40, 20
    mWrite  "��u�G�A     408262416    Yan-Ting Chen"
    mGotoxy 44, 22
;--------------------------------------
    call    WaitMsg
    mGotoxy 0, 0  
       
    RET
DrawFirstScreen ENDP

;�W�h------------------------
rule proc
    call    ClrScr
    call    PrintWalls
    
    mGotoxy 15, 2                                       
    mWrite  " _______      ____     ____    ____ _______        ______   __     __  __      _______"  
    mGotoxy 15, 3 
    mWrite  "/  _____\    /    \    |   \  /   | |  ____|      | ____ \  | |    | | | |     |  ____|"
    mGotoxy 15, 4 
    mWrite  "| |         /  /\  \   | |\ \/ /| | | |           | |   \ | | |    | | | |     | | "
    mGotoxy 15, 5
    mWrite  "| |  ___   /  /__\  \  | | \  / | | | |____       | |___/ | | |    | | | |     | |____"
    mGotoxy 15, 6
    mWrite  "| | |_  | /  ______  \ | |  \/  | | |  ____|      | __  _/  | |    | | | |     |  ____|"
    mGotoxy 15, 7
    mWrite  "| |___| | |  |    |  | | |      | | | |____       | | \ \   | |____| | | |____ | |____"
    mGotoxy 15, 8
    mWrite  "\_______/ |__|    |__| |_|      |_| |______|      |_|  \_\  \________/ |______||______|"


    mGotoxy 30, 10
    mWrite  " * First : Enter your name",                                 
    mGotoxy 30, 12                                      
    mWrite  " * Second : choose the level that you want to challenge"
    mGotoxy 30, 14                                      
    mWrite  " * Start the game"
    mGotoxy 33, 16                                      
    mWrite  "Press up, right, down, and left to move your snake !!!"
    mGotoxy 33, 18
    mWrite  "There are 5 different kinds of foods that snake can eat."
    mGotoxy 33, 20
    mWrite  "What the snake eat, what the snake become"
    mGotoxy 33, 22
    mWrite  "You will die if you bump to the wall !!!"
    mGotoxy 33, 24
    mWrite  "Good Luck & Take care"
    mGotoxy 44, 26

    CALL    WaitMsg
    mGotoxy 0, 0  
    call Clrscr
       
    ret
rule endp

;��J���a�W------------------
entername proc
    call    ClrScr
    call    PrintWalls
    mGotoxy 2, 6                                       
    mWrite  "            ---------             ---------             ---------             ---------             --------- "
    mGotoxy 2, 7                                       
    mWrite  " --------- -         - --------- -         - --------- -         - --------- -         - --------- -         - "
    mGotoxy 2, 8
    mWrite  "-         --         --         --         --         --         --         --         --         --     **  -"
    mGotoxy 2, 9                                      
    mWrite  "-         --         --         --         --         --         --         --         --         --     **  -"
    mGotoxy 2, 10
    mWrite  "-         --         --         --         --         --         --         --         --         --         -"
    mGotoxy 2, 11                                       
    mWrite  "-         --         --         --         --         --         --         --         --         --         -"
    mGotoxy 2, 12
    mWrite  "-         --         --         --         --         --         --         --         --         --         -"
    mGotoxy 2, 13                                       
    mWrite  "-         --         --         --         --         --         --         --         --         --         -"
    mGotoxy 2, 14
    mWrite  "-         --         --         --         --         --         --         --         --         --         -"
    mGotoxy 2, 15                                       
    mWrite  "-         - --------- -         - --------- -         - --------- -         - --------- -         - --------- "
    mGotoxy 2, 16
    mWrite  " ---------             ---------             ---------             ---------             ---------            "

    mGotoxy 45, 20                                       
    mWrite  "----enter your name----"
    mGotoxy 45, 22
    mWrite  "Your Name: "
    mReadString playerName
    mGotoxy 0, 0 
    call    ClrScr
    ret
entername endp

;����------------------------
ChooseLev proc
    call    PrintWalls
    mGotoxy 52, 7
    mWrite "Hello, "
    mWriteString OFFSET playerName 
    mGotoxy 40, 9
    mWrite "Choose a level which you want challenge !!!"
;����(�t��)���----------------------
 L1:
    mGotoxy 48, 11
    mWrite  "----LEVEL Table----" 
    mGotoxy 48, 13 
    mWrite  "(0) Level_0 : Easy"    
    mGotoxy 48, 15 
    mWrite  "(1) Level_1 : Normal"
    mGotoxy 48, 17 
    mWrite  "(2) Level_2 : Medium"
    mGotoxy 48, 19
    mWrite  "(3) Level_3 : Hard"
    mGotoxy 48, 21
    mWrite  "Your selection is  "

    call    ReadChar    ;Ū�����
    mov choice, AL                                      
    call    WriteChar

    ;�P�_���
    .if choice == '0'
        mov speed, 150
    .elseif choice == '1'
        mov speed, 100
    .elseif choice == '2'
        mov speed, 75
    .elseif choice == '3'
        mov speed, 50
    .else
        INVOKE  Sleep, 100
        mGotoxy 0, 0                                    
        call    ClrScr
        mGotoxy 40, 9
        mWriteString offset wrong
        call    PrintWalls
        jmp L1
    .endif
    INVOKE  Sleep, 100
    mGotoxy 0, 0                                    
    call    ClrScr      ;���X�D���

    ret
ChooseLev endp

;��ܪ��a��T----------------
drawHUD PROC                                            
;���a�W----------------------------                                                                                                    
    mGotoxy 2, 0
    mWrite  "Name: "
    mWriteString offset playerName 
;----------------------------------
;������----------------------------
    mGotoxy 20, 0
    mWrite "Level: "
    .if choice == '0'
        mWrite "Easy"
    .elseif choice == '1'
        mWrite "Normal"
    .elseif choice == '2'
        mWrite "Medium"
    .else
        mWrite "Hard"
    .endif
    mGotoxy 40, 0
    mWrite "Score: "
    mov eax, score
    call writedec
;-----------------------------------
    ret
drawHUD ENDP

;����------------------------
createfood proc
    call Randomize
;������x�y��---------------------------
    call random32       
    xor edx, edx
    mov ecx, maxX - 2
    div ecx
    add dl, 2
    mov foodPoint.x, dl
;-------------------------------------
;������y�y��---------------------------
    call random32       
    mov edx, 0
    mov ecx, maxY - 2
    div ecx
    add dl, 2
    mov foodPoint.y, dl
;-------------------------------------
;�N���в��ܷs���H���y��-----------------
    mGotoxy foodPoint.x, foodPoint.y
;-------------------------------------
;5 kinds of foods & random & show-----
    mov eax, 5 
    call randomrange 
    mov foodrandomnum, eax
    .if eax == 0
        mov eax, black (9 * 16);blue
        call settextcolor
        mov al, foodChar0
        call writechar
        ret
    .elseif eax == 1
        mov eax, black (12 * 16);red
        call settextcolor
        mov al, foodChar1
        call writechar
        ret
    .elseif eax == 2
        mov eax, black (6 * 16);yellow
        call settextcolor
        mov al, foodChar2
        call writechar
        ret
    .elseif eax == 3
        mov eax, black (10 * 16);green
        call settextcolor
        mov al, foodChar3
        call writechar
        ret
    .elseif eax == 4
        mov eax, black (7 * 16);gray
        call settextcolor
        mov al, foodChar4
        call writechar
        ret
    .endif
;-------------------------------------
createfood endp

;�W��------------------------
grow proc
    ;�P�_�O�_���Y�쭹��
    mov ah, currentX
    mov al, currentY
    .if ah == FoodPoint.x && al ==  FoodPoint.y
        .if foodrandomnum == 0
            mov foodnum, 0
            call createfood ;���ͷs������
            inc headIndex   ;�W�[�D������
            inc score
        .elseif foodrandomnum == 1
            mov foodnum, 1
            call createfood ;���ͷs������
            inc headIndex   ;�W�[�D������
            inc score
        .elseif foodrandomnum == 2
            mov foodnum, 2
            call createfood ;���ͷs������
            inc headIndex   ;�W�[�D������
            inc score
        .elseif foodrandomnum == 3
            mov foodnum, 3
            call createfood ;���ͷs������
            inc headIndex   ;�W�[�D������
            inc score
        .elseif foodrandomnum == 4
            mov foodnum, 4
            call createfood ;���ͷs������
            inc headIndex   ;�W�[�D������
            inc score
        .endif
    .endif
    ret
grow endp

SetDirection PROC, R:BYTE, L:BYTE, U:BYTE, D:BYTE
    mov dl, R
    mov RIGHT, dl

    mov dl, L
    mov LEFT, dl

    mov dl, U
    mov UP, dl

    mov dl, D
    mov DOWN, dl
    
    ret
SetDirection ENDP
;---------------------------
;��J��V--------------------
presskey proc
;press down ?--------------------
ddown:
     MOV AH, 0
        INVOKE GetKeyState, VK_DOWN                  
        .if ah == 0 || currentY >= maxY
            jmp uup
    .else
        inc currentY
        invoke SetDirection,  0, 0, 0, 1
    .endif                       
     RET
;--------------------------------
;press up ?--------------------
uup:
    mov ah, 0
    invoke  GetKeyState, VK_UP
    .if ah == 0 || currentY <= 0
        jmp lleft
    .else
        dec currentY
        invoke SetDirection, 0, 0, 1, 0
    .endif
    ret
;--------------------------------
;press left ?--------------------
lleft:
    mov ah, 0
    invoke  GetKeyState, VK_LEFT
    .if ah == 0 || currentX <= 0
        jmp rright
    .else
        dec currentX
        invoke SetDirection, 0, 1, 0, 0
    .endif
    ret
;---------------------------------
;press right ?--------------------
rright:
    mov ah, 0
    invoke  GetKeyState, VK_RIGHT
    .if ah == 0 || currentY >= maxY
        jmp rightpress
    .else
        inc currentX
        invoke SetDirection, 1, 0, 0, 0
    .endif
    ret
;--------------------------------
;right is press------------------
rightpress:
    .if RIGHT == 0 || currentX >=  maxX
        jmp leftpress
    .else
        inc currentX
    .endif
;--------------------------------
;left is press------------------
leftpress:
    .if LEFT == 0 || currentX <=  0
        jmp uppress
    .else
        dec currentX
    .endif
;--------------------------------
;up is press------------------
uppress:
    .if UP == 0 || currentY <=  0
        jmp downpress
    .else
        dec currentY
    .endif
;--------------------------------
;down is press------------------
downpress:
    .if DOWN == 0 || currentY >=  maxY
        jmp breakk
    .else
        inc currentY
    .endif
;--------------------------------
breakk:
    ret 
presskey endp

;����?----------------------
IsCollision proc
;�O�_�I�����----------------------
    .if currentX == 0        ;left
        jmp L1
    .elseif currentY == 1    ;up
        jmp L1
    .elseif currentX == maxX ;right
        jmp L1
    .elseif currentY == maxY ;down
        jmp L1
    .else 
        jmp L2
    .endif
;---------------------------------
;gameover?------------------------
L1: 
    mov eax, 1
    ret
L2: 
    mov eax, 0
    ret
;---------------------------------
IsCollision endp

;move�D---------------------
movesnake proc
    mov ecx, 0
    mov cl, headIndex ;snake's head
;load x and y----------------
    mov al, currentX
    mov ah, currentY
;----------------------------
;load new x, y for snake new body
    mov Snakebody[2 * ecx].x, al
    mov Snakebody[2 * ecx].y, ah
;--------------------------------
    mGotoxy Snakebody[2 * ecx].x, Snakebody[2 * ecx].y
;snake body---------------------
    .if foodnum == 0
        mov eax, black (9 * 16)
        call settextcolor
        mov al, foodChar0
    .elseif foodnum == 1
        mov eax, black (12 * 16)
        call settextcolor
        mov al, foodChar1
    .elseif foodnum == 2
        mov eax, black (6 * 16)
        call settextcolor
        mov al, foodChar2
    .elseif foodnum == 3
        mov eax, black (10 * 16)
        call settextcolor
        mov al, foodChar3
    .elseif foodnum == 4
        mov eax, black (7 * 16)
        call settextcolor
        mov al, foodChar4
    .else 
        mov al, snake
    .endif

    call writeChar
    INVOKE  Sleep, speed
;-------------------------------
    mov ecx, 0  
    mov cl, tailIndex
    cmp SnakeBody[2 * ecx].x, 0;�g���D�����ڦ�m�L�X
    JE  L1 
    mGotoxy SnakeBody[2 * ecx].x, SnakeBody[2 * ecx].y
    mWrite  " "
    
L1:
    inc tailIndex
    inc headIndex
    cmp tailIndex, maxSize
    jne L2
    mov tailIndex, 0

L2:
    cmp headIndex, maxSize ; Ū����e�g���D�̤j����
    jne L3
    mov headIndex, 0

L3:
    ret
movesnake endp

bonus proc
    call    ClrScr
    call    PrintWalls
    mGotoxy 27, 2                                        
    mWrite  "________    _________  ____        __  __      __    _________"
    mGotoxy 27, 3                                        
    mWrite  "| _____ \  / _______ \ |   \      | |  | |     | |  /  _______\"  
    mGotoxy 27, 4 
    mWrite  "| |    \ \ | |     | | | |\ \     | |  | |     | |  | |"
    mGotoxy 27, 5
    mWrite  "| |    / / | |     | | | | \ \    | |  | |     | |  | |"
    mGotoxy 27, 6
    mWrite  "| |   / /  | |     | | | |  \ \   | |  | |     | |  | |_______"
    mGotoxy 27, 7
    mWrite  "| |   \ \  | |     | | | |   \ \  | |  | |     | |  |________ \"
    mGotoxy 27, 8
    mWrite  "| |    \ \ | |     | | | |    \ \ | |  | |     | |          | |"
    mGotoxy 27, 9
    mWrite  "| |____/ / | |_____| | | |     \ \| |  | |_____| |  ________| |"
    mGotoxy 27, 10
    mWrite  "|_______/  \_________/ |_|      \___|  \_________/  \_________/"

;bonus random---------------------------------
    mov     eax,3      ; RandomRange[0, eax-1]
    call    RandomRange ; result in eax
    inc     eax
    mov     ranbon,0
    mov     ranbon,eax
    .if eax == 1       
        mGotoxy 50, 12                                        
        mWrite  "     _____"
        mGotoxy 50, 14                                       
        mWrite  "    /    |"  
        mGotoxy 50, 16 
        mWrite  "   /  |  |"
        mGotoxy 50, 18
        mWrite  "  /__/|  |"
        mGotoxy 50, 20
        mWrite  "      |  |"
        mGotoxy 50, 22
        mWrite  "   ___|  |___"
        mGotoxy 50, 24
        mWrite  "  |__________|"
    .elseif eax == 2
        mGotoxy 50, 12                                        
        mWrite  "  ___________  "
        mGotoxy 50, 14                                       
        mWrite  " |________   |"  
        mGotoxy 50, 16 
        mWrite  "          |  |"
        mGotoxy 50, 18
        mWrite  "  ________|  |"
        mGotoxy 50, 20
        mWrite  " |   ________|"
        mGotoxy 50, 22
        mWrite  " |  |________"
        mGotoxy 50, 24
        mWrite  " |___________|"
    .elseif eax > 2    
        mGotoxy 50, 12                                        
        mWrite  "  ___________ "
        mGotoxy 50, 14                                       
        mWrite  " |________   |"  
        mGotoxy 50, 16 
        mWrite  "          |  |"
        mGotoxy 50, 18
        mWrite  "  ________|  |"
        mGotoxy 50, 20
        mWrite  " |________   |"
        mGotoxy 50, 22
        mWrite  "          |  |"
        mGotoxy 50, 24
        mWrite  "  ________|  | "
        mGotoxy 50, 26
        mWrite  " |___________|"
    .endif
    INVOKE  Sleep, 3000
    ;mGotoxy 0, 0
    ret
bonus endp

;�C������--------------------
gameover proc
    call    Clrscr
    CALL    PrintWalls
    mGotoxy 15, 4                                       
    mWrite  " _______      ____     ____    ___  _______       _______  __      __ _______  _______"  
    mGotoxy 15, 5 
    mWrite  "/  _____\    /    \    |   \  /   | |  ____|     / _____ \ | |    | | |  ____| | ____ \"
    mGotoxy 15, 6
    mWrite  "| |         /  /\  \   | |\ \/ /| | | |          | |   | | | |    | | | |      | |   \ \"
    mGotoxy 15, 7
    mWrite  "| |  ___   /  /__\  \  | | \  / | | | |____      | |   | | | |    | | | |____  | |___/ /"
    mGotoxy 15, 8
    mWrite  "| | |_  | /  ______  \ | |  \/  | | |  ____|     | |   | | \ \    / / |  ____| | __  _/"
    mGotoxy 15, 9
    mWrite  "| |___| | |  |    |  | | |      | | | |____      | |___| |  \ \__/ /  | |____  | | \ \"
    mGotoxy 15, 10
    mWrite  "\_______/ |__|    |__| |_|      |_| |______|     \_______/   \____/   |______| |_|  \_\"


    mGotoxy 55, 14
    mWrite  "Hey~ "
    mGotoxy 60, 14
    mWriteString offset playerName
    mGotoxy 44, 16                                   
    mWrite  "Your exact score and bonus is "
    mov eax, score
    call writedec   
    mov    al , ' '                      
    call     WriteChar
    mov    al , '&'                      
    call     WriteChar 
    mov    al , ' '                      
    call     WriteChar
    mov eax, ranbon
    call writedec
    mGotoxy 46, 18                                   
    mWrite  "Your total score is "
     mov eax, score
    call writedec   
    mov    al , ' '                      
    call     WriteChar
    mov    al , '*'                      
    call     WriteChar 
    mov    al , ' '   
    call     WriteChar
    mov    eax, ranbon
    call   writedec
    mov    al , ' '   
    call     WriteChar
    mov    al , '='                      
    call     WriteChar
    mov    al , ' '                      
    call     WriteChar
    mov eax, 0
    mov ebx, 0
    mov eax, score
    mov ebx, ranbon
    mul ebx
    call writedec
    mGotoxy 44, 20
    .if eax <= 10 && eax >= 0        
        mWriteString offset again
    .elseif eax <= 20 && eax > 10 
         mWriteString offset good
    .elseif eax > 20    
        mWriteString offset excellent
    .endif
    mGotoxy 50, 22                                  
    mWrite  "Thanks for playing!!!"
    mGotoxy 52, 24                                  
    mWrite  "FJCU CSIE Group 5"

    INVOKE  Sleep, 5000
                                                            
    mGotoxy 25,28
        
    ret  
gameover endp

;�D��---------------------------------------
startgame proc
    call    DrawFirstScreen  ;�D��
L0: 
    call    rule             ;�W�h
    call    entername        ;��J�ϥΪ̦W��
    call    ChooseLev        ;���������
L1: 
    call    ClrScr
    call    createfood       ;����
    call    PrintWalls       ;���
L2:
    call    grow             ;�O�_���Y�쭹�� �p�G���N�[�� �p�G�S���N�~��
    call    presskey         ;�O�_���U���s
L3: 
    call    IsCollision      ;�C���O�_����
    .if eax != 1
        call movesnake
        call drawHUD
        jmp L2
    .else
        ;INVOKE  Sleep, 10
        call    bonus
        call    gameover
    .endif
    ;INVOKE  ExitProcess, 0
    ret
startgame endp
;------------------------------------------
END main