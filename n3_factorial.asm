; Factorial 

.MODEL SMALL
.STACK 100H

.DATA
    inmsg DB "Enter a number: (0-3) $"
    outmsg DB "The factorial is: $"
    n DB ?
    
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; input
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    MOV n, 01H
    CMP AL, '0'
    JE OUTPUT
    
    SUB AL, '0'
    MOV CH, 0H
    MOV CL, AL
    MOV AL, 01H
    
    LOOP:
        MUL CL
    LOOP LOOP
    
    MOV n, AL
    
    OUTPUT:
        CALL NEWLINE
        
        LEA DX, outmsg
        MOV AH, 09H
        INT 21H
        
        ADD n, '0'
        MOV DL, n
        MOV AH, 02
        INT 21H
           
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