; Counting in a string

.MODEL SMALL
.STACK 100H

.DATA
    inmsg DB "Enter the string: $"
    nv DB "The no of vowel is: $"
    nc DB "The no of consonant is: $"
    nd DB "The no of digit is: $"
    nw DB "The no of word is: $" ; space
    
    vowels DB 'AEIOUaeiou$'
    
    vc DB '0'
    cc DB '0'
    dc DB '0'
    wc DB '0'
    
.CODE
 
 MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, inmsg ; printing input message
    MOV AH, 09H
    INT 21H      
    
    INPUT: ; for taking input 
        MOV AH, 01H
        INT 21H
        CMP AL, 0DH ;checking for carriage return
        JZ ENDINPUT
     
        CMP AL, 'A'
        JL NOTALPHABET ; can be digit/space/or something else
        
        CMP AL, 'z' ; checking higher ascii value than 'z'
        JG OTHERS
        
        CMP AL, 'Z' ; checking ascii value higher than 'Z' 
        JG CHECK
        
        JMP ALPHABET ; for capital letter alphabet
        
    CHECK:
        CMP AL, 'a'  ; checking ascii value less than 'a' -> go to others
        JL OTHERS
    
    ALPHABET:
        MOV SI, 0H
        MOV CX, 0AH
        
    TOP: ; if it is in alphabet
        CMP AL, vowels[SI] ; checking for vowels
        JZ VOWEL
        INC SI
    LOOP TOP:
    
    INC cc  ; if not vowel then consonant
    JMP INPUT
    
    VOWEL:
        INC vc  ; vowel count 
        JMP INPUT
             
        
    NOTALPHABET:
        CMP AL, ' ' ; checking for space
        JZ SPACE  
        
        CMP AL, '0'
        JL OTHERS
        
        CMP AL, '9'
        JG OTHERS 
        
        INC dc ; incrementing value of digit count
        
        JMP INPUT
                
    SPACE:
        INC wc
        JMP INPUT
                                    
    OTHERS:                
        JMP INPUT ; if input is not finished then jump to "INPUT" label
                
    ENDINPUT: ; if input is finished  
                
        ; vowel count
        CALL NEWLINE 
        LEA DX, nv ; printing input message
        MOV AH, 09H ; stream output
        INT 21H
        MOV DL, vc
        MOV AH, 02H
        INT 21H

        ; consonant count
        CALL NEWLINE 
        LEA DX, nc ; printing input message
        MOV AH, 09H ; stream output
        INT 21H
        MOV DL, cc
        MOV AH, 02H
        INT 21H
             
        ; digit count
        CALL NEWLINE 
        LEA DX, nd ; printing input message
        MOV AH, 09H ; stream output
        INT 21H
        MOV DL, dc
        MOV AH, 02H
        INT 21H

        ; word count
        CALL NEWLINE 
        LEA DX, nw ; printing input message
        MOV AH, 09H ; stream output
        INT 21H
        INC wc
        MOV DL, wc
        MOV AH, 02H
        INT 21H
                
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