; Case Reversal

.MODEL SMALL
.STACK 100H

.DATA                      
str DB 100 DUP ?
inmsg DB "Enter the string: $"
outmsg DB "The case reversed string is: $"

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, inmsg ; printing input string
    MOV AH, 09H
    INT 21H
        
    MOV SI, 0H
    MOV DI, 0H    
        
    INPUT: ; taking input
        MOV AH, 01H
        INT 21H
        CMP AL, 0DH  ; checking for end of input
        JZ ENDINPUT
        
        MOV str[SI], AL ; storing character
        INC SI
        
        JMP INPUT ; checking for further input
        
    ENDINPUT:
        
        CALL NEWLINE ; newline printing
        
        LEA DX, outmsg  ; output message print
        MOV AH, 09H
        INT 21H
    
    OUTPUT:
        CMP DI, SI  ; checking for end of string
        JZ ENDOUTPUT
               
        MOV AL, str[DI]
        CMP AL, 'z' ; checking for ascii value bigger than 'z' for no change
        JG NOCHANGE
        CMP AL, 'A' ; checking for ascii value less than 'A' for no change
        JL NOCHANGE
        CMP AL, 'Z' ; checking for ascii value bigger than 'Z' for no change
        JG CHECK
        
        JMP CONVERSION ; if no condition matches, go to conversion
    
    CHECK:
        CMP AL, 'a' ; checking for ascii value less than 'a' for no change
        JL NOCHANGE 
        
        JMP CONVERSION ; otherwise go to conversion   
         
    NOCHANGE: ; no conversion
        MOV DL, AL
        MOV AH, 02H
        INT 21H
        
        INC DI
        JMP OUTPUT    
        
    CONVERSION:   ; converting cases
        XOR AL, 32 ; converting the case
        MOV DL, AL
        MOV AH, 02
        INT 21H
        
        INC DI
        JMP OUTPUT 
        
    ENDOUTPUT:
        MOV AH, 4CH
        INT 21H   
    
MAIN ENDP
        
NEWLINE PROC
    MOV AH, 02H ; carriage return
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH ; newline feed
    INT 21H
    RET
NEWLINE ENDP        
        
END MAIN