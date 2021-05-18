%include "io.inc"

section .text
    global CMAIN
CMAIN: 
    mov eax,1 ;vstavimo 1 v register eax
    GET_UDEC 1, ebx ;preberemo �tevilo velikosti 1 byte in ga damo v register ebx 
    jmp for_loop ;sko�imo v del programa for_loop
for_loop:
    cmp eax, ebx ;preverimo �e sta vrednosti eax in ebx enaki 
    je end ;�e sta enaki se prestavimo v del programa end
    push eax ;vrednost eax damo na vrh sklada, da jo shranimo za kasneje
    PRINT_UDEC 1, eax ;izpis stevila v eax
    NEWLINE ;izpis nove vrstice
    pop eax ;vrnemo prej�njo vrednost eax iz sklada nazaj v register
    add eax,1 ;inkrementiramo eax
    jmp for_loop ;vrnemo se na za�etek for loopa
end:
    xor eax, eax ;register vrnemo na 0
    xor ebx, ebx ;register vrnemo na 0
    ret; vrnemo se iz operacije;