; Number sorting using bubble sort

.MODEL SMALL
.STACK 100H

.DATA
    str DB 100 DUP ?
    inmsg DB "Enter the stirng of Number: $"
    outmsg DB "After sorting: $"
    n DW ?
    
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ;input string
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0H
    
INPUT: ; input taking
    MOV AH, 01H
    INT 21H
    
    CMP AL, 0DH
    JZ ENDINPUT
    
    MOV str[SI], AL
    INC SI
    
    JMP INPUT
    
ENDINPUT:
    CALL NEWLINE ; new line feed
    
    MOV n, SI
    
    CMP SI, 01H
    JE OUTPUT
    
    MOV CX, n
    DEC CX
    MOV SI, 0H
    
    OUTLOOP:    ; outer loop
        MOV DI, SI
        INC DI
        
        INLOOP: ; inside loop
            MOV AL, str[SI]
            CMP AL, str[DI]
            JL SKIP
               
            XCHG AL, str[DI]
            MOV str[SI], AL
            
            SKIP:
                CMP DI, n
                JZ ENDINLOOP   
               
            INC DI
            
            JMP INLOOP
            
        ENDINLOOP:
            INC SI
            
    LOOP OUTLOOP:
    
    OUTPUT: ; showing output
    LEA DX, outmsg
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0H
    MOV CX, n
    
    SHOW: ; loop for output showing
        MOV DL, str[SI]
        MOV AH, 02H
        INT 21H
        
        INC SI
    LOOP SHOW
    
    MOV AH, 4CH
    INT 21H
            
MAIN ENDP        

NEWLINE PROC
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    RET
NEWLINE ENDP

END MAIN