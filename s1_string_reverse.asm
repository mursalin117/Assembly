; String Reverse

.MODEL SMALL
.STACK 100H

.DATA
    str DB 100 DUP ?
    inmsg DB "Enter the string: $"
    outmsg DB "The reversed string is: $"
    
.CODE
 
 MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, inmsg ; printing input message
    MOV AH, 09H
    INT 21H      
    
    MOV SI, 0H
    
    INPUT: ; for taking input 
        MOV AH, 01H
        INT 21H
        CMP AL, 0DH ;checking for carriage return
        JZ ENDINPUT
        
        MOV str[SI], AL ; inserting character by character
        INC SI
        
        JMP INPUT ; if input is not finished then jump to "INPUT" label
        
    ENDINPUT: ; if input is finished  
    
        CALL NEWLINE 
        
        LEA DX, outmsg ; printing input message
        MOV AH, 09H
        INT 21H
              
        DEC SI ; decreasing the last number for indexing
              
        OUTPUT:
            MOV DL, str[SI] ; printing from reversed index
            MOV AH, 02H
            INT 21H
            
            DEC SI ; decreasing the last number for indexing
            
            CMP SI, 0H  ; checking for if the first index is passed
            JL ENDOUTPUT
            
            JMP OUTPUT
            
    ENDOUTPUT:
    
        MOV AH, 4CH
        INT 21H
  
 MAIN ENDP
    
 NEWLINE PROC
    MOV DL, 0AH ; carriage return
    MOV AH, 02H
    INT 21H
    MOV DL, 0DH ; newline feed   
    INT 21H
    RET
 NEWLINE ENDP  
      
 END MAIN