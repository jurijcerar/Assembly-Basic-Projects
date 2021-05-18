%include "io.inc"

section .text
    global CMAIN
      
CMAIN:
    mov ebp, esp ;pomoè pri razhrošèevanju, generira stacktrace 
    
    mov eax, 12; f(n-3)
    mov ebx, 22; f(n-2)
    mov ecx, 45; f(n-1)
    mov edx, 3; n
    mov edi, 0; ekstra vrednost
    
    call recursion
        
    xor eax, eax ;register sprostimo oz. damo na 0
    ret ;vrnemo se iz operacije
    
recursion:

    add edi, 1
    add edi, eax ; v edi zraèunam f(n)
    add edi, ebx
    mov eax, ebx ; v eax premaknem f(n-2), ki sedaj postane f(n-3)
    mov ebx, ecx ; v ebx premaknem f(n-1), ki sedaj postane f(n-2)
    mov ecx, edi ; v ecx premaknem f(n), ki sedaj postane f(n-1)
    mov edi, 0 ;resetiram edi
    add edx, 1 ;incrementiram edx saj je naš pogoj za izvajanje
    PRINT_UDEC 1, ecx ;izpišem f(n)
    NEWLINE ; nova linija za preglednost
    cmp edx, 11 ;pogoj èe naj klièemo rekurzijo ali ne nastavil na 11 ker za 10 še vedno klièemo
    jl recursion ;èe je prvo manjse
    ret