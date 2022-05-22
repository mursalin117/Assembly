; integer summation

.MODEL SMALL
.STACK 100H
 
.DATA
    inmsg DB "Enter integer: (1-3) $"
    outmsg DB "The summation is: $"
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
    
    SUB AL, '0'
    
    MOV BL, AL
    INC BL
    MUL BL
    MOV AH, 0H
    MOV BL, 02H
    DIV BL
    
    ADD AL, '0'
    MOV n, AL
    
    ; output
    CALL NEWLINE
    
    LEA DX, outmsg
    MOV AH, 09H
    INT 21H
    
    MOV DL, n
    MOV AH, 02H
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