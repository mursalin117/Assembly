; longest sequence in stirng

.MODEL SMALL
.STACK 100H

.DATA
    str DB 100 DUP ?
    inmsg DB "Enter the string: $"
    outmsg DB "The longest sequence is: $" 
    errmsg DB "You have entered wrong alphabet. Try again.$"
    start DW 0H
    len DW 0H

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0H
    MOV DI, 0H
    MOV CX, 0H
    
    
    INPUT:
        MOV AH, 01H
        INT 21H
        
        CMP AL, 0DH
        JZ ENDINPUT
                 
        CMP AL, ' '
        JZ CHECK         
                 
        CMP AL, 'a'
        JL ERROR
        
        CMP AL, 'z'
        JG ERROR 
        
        INC CX
        
        JMP STORE
                 
    CHECK:
        CMP len, CX
        JL CHANGE
        
        MOV CX, 0H
        MOV DI, SI
        INC DI
        
        JMP STORE             
    
    CHANGE:
        MOV len, CX
        MOV start, DI
        MOV CX, 0H 
                  
        MOV CX, 0H
        MOV DI, SI
        INC DI
                          
        JMP STORE
                       
    ERROR:
        LEA DX, errmsg
        MOV AH, 09H
        INT 21H
        
        CALL NEWLINE
        
        LEA DX, inmsg
        INT 21H
        
        JMP INPUT
                 
    STORE:
        MOV str[SI], AL
        INC SI
        
        JMP INPUT             
                 
    ENDINPUT:
        CMP len, CX
        JL CHANGE_LAST
        
        JMP NEXT:             
    
    CHANGE_LAST:
        MOV len, CX
        MOV start, DI 
    
    NEXT: 
        CALL NEWLINE
        
        LEA DX, outmsg
        MOV AH, 09H
        INT 21H
        
        MOV CX, len
        
        MOV SI, start
        
    OUTPUT:
        MOV DL, str[SI]
        MOV AH, 02H
        INT 21H
        
        INC SI
    LOOP OUTPUT
    
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