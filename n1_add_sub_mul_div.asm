; Addition, Subtraction, Multiplication and Division in one program

.MODEL SMALL
.STACK 100H

.DATA
    inmsg DB "Enter two numbers: (0-9)$"
    outmsg1 DB "Addition: $"
    outmsg2 DB "Subtraction: $"
    outmsg3 DB "Multiplication: $"
    outmsg4 DB "Division: $"
    A DB ?
    B DB ?
    
.CODE
    
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
INPUT:
    ; Addition
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    MOV A, AL
    
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    ADD AL, A
    MOV BL, AL
    ADD BL, '0'
    
    CALL NEWLINE
           
    LEA DX, outmsg1
    MOV AH, 09H
    INT 21H
    
    MOV DL, BL
    MOV AH, 02H
    INT 21H
    
    ; Subtraction
    CALL NEWLINE
      
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    MOV A, AL
    
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    MOV B, AL
    
    MOV AL, A
    SUB AL, B
    ADD AL, '0'
    MOV BL, AL    
    
    CALL NEWLINE
                
    LEA DX, outmsg2
    MOV AH, 09H
    INT 21H
    
    MOV DL, BL
    MOV AH, 02H
    INT 21H
    
    ; Multiplication
    CALL NEWLINE
    
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    MOV A, AL
    
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    MOV B, AL
    
    MOV AL, A
    MUL B
    ADD AL, '0'
    MOV BL, AL 
    
    CALL NEWLINE
    
    LEA DX, outmsg3
    MOV AH, 09H
    INT 21H
    
    MOV DL, BL
    MOV AH, 02H
    INT 21H 
    
    ; Division
    CALL NEWLINE
    
    LEA DX, inmsg
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    MOV A, AL
    
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'
    MOV B, AL
    
    MOV AL, A
    MOV AH, 0H
    DIV B
    ADD AL, '0'
    ADD AH, '0'
    MOV BL, AL
    MOV BH, AH 
    
    CALL NEWLINE
    
    LEA DX, outmsg4
    MOV AH, 09H
    INT 21H
    
    MOV DL, BL
    MOV AH, 02H
    INT 21H
    
    MOV DL, ','
    MOV AH, 02H
    INT 21H
    
    MOV DL, BH
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
        
    