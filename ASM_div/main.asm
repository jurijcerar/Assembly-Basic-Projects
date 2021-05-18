%include "io.inc"

section .bss          ; sekcija za neinicializirane podatke
i resq 1
N resq 1

section .text
    global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov dword [i], 1 ;init i na 1
    GET_UDEC 4, [N] ;branje N
    mov edx, 0      ; poèistimo register deljenja
    mov eax, [N]   ; deljenec
    mov ecx, 2    ; delitelj
    div ecx  ;delimo eax/acx
    mov ebx, eax ;v register ebx damo koliènik
    mov ecx, 47; vstavimo 47 kot delitelj
    jmp for_loop ;skoèimo v del programa for_loop
for_loop:
    mov eax, [i] ; v register eax damo i
    cmp eax, ebx ;preverimo èe sta vrednosti eax in ebx enaki 
    je end ;èe sta enaki se prestavimo v del programa end
    mov edx, 0 ; poèistimo register deljenja
    div ecx ;delimo eax/acx
    cmp edx, 0 ;preverimo èe je brez ostanka
    je divisable ; sem skoèimo èe je brez ostanka
    inc dword [i]  ;i++
    jmp for_loop ;vrnemo se na zaèetek for loopa
divisable:
    push eax ;vrednost eax damo na vrh sklada, da jo shranimo za kasneje
    PRINT_UDEC 4, [i]  ;izpis stevila v eax
    NEWLINE ;izpis nove vrstice
    pop eax ;vrnemo prejšnjo vrednost eax iz sklada nazaj v register
    inc dword [i] ;i++
    jmp for_loop ;nazaj v for_loop
end:
    xor eax, eax ;register vrnemo na 0
    ret; vrnemo se iz operacije;