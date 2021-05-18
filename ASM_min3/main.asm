%include "io.inc"

section .bss          ; sekcija za neinicializirane podatke
a resq 1
b resq 1
c resq 1

section .text
    global CMAIN
    
CMAIN:
    mov ebp, esp ;pomoè pri razhrošèevanju, generira stacktrace 
    
    GET_UDEC 1, [a] ;branje a
    GET_UDEC 1, [b] ;branje b
    GET_UDEC 1, [c] ;branje c
    
    mov eax, [a]
    mov ecx, [b]
    mov edx, [c]
    
    call min3
    
    PRINT_UDEC 1, ebx
    
    xor eax, eax ;register sprostimo oz. damo na 0
    ret ;vrnemo se iz operacije
    
min3:
    cmp eax, ecx
    jl prvo_ali_tretje ;èe je prvo manjse
    jmp drugo_ali_tretje ;else
    ret

prvo_ali_tretje:
    cmp eax, edx
    jl prvo_najmanjse
    jmp tretje_najmanjse

drugo_ali_tretje:
    cmp eax, edx
    jl drugo_najmanjse
    jmp tretje_najmanjse
    
prvo_najmanjse:
    mov ebx, [a]
    ret
   
drugo_najmanjse:
    mov ebx, [b]
    ret
   
tretje_najmanjse:
    mov ebx, [c]
    ret
