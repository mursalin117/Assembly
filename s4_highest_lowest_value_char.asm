; String sorting using bubble sort

.MODEL SMALL
.STACK 100H

.DATA
    str DB 100 DUP ?
    inmsg DB "Enter the stirng: $"
    outmsg1 DB "The smallest ascii value is: $"
    outmsg2 DB "The highest ascii value is: $"
    max DB 'a'
    min DB 'z'
    
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
    
    CMP AL, 'a'
    JL NEXT
    
    CMP AL, 'z'
    JG NEXT
    
    CMP AL, min
    JL SMALL
    
    JMP CHECK
    
SMALL:
    MOV min, AL

CHECK:
    CMP AL, max
    JG HIGH  
    
    JMP NEXT
    
HIGH:
    MOV max, AL    
    
NEXT:    
    MOV str[SI], AL
    INC SI
    
    JMP INPUT
    
ENDINPUT:
    CALL NEWLINE ; new line feed

    LEA DX, outmsg1
    MOV AH, 09H
    INT 21H
    MOV DL, min
    MOV AH, 02H
    INT 21H
             
    CALL NEWLINE
             
    LEA DX, outmsg2
    MOV AH, 09H
    INT 21H
    MOV DL, max
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