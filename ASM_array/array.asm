%include "io.inc"

section .data
    string db 'ABCDE', 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, string ; niz v register
    call setup_rotate ; funkcija za obraèanje
    PRINT_STRING string ; izpis niza
    xor eax, eax ; return 0
    ret ; izhod

setup_rotate:                
    mov esi, eax ; esi nastavim na zaèetek arraya
    mov edi, eax ; edi nastavim na zaèetek arraya
    cld          ; z cld izbrišem zastavico zato, da se ob vskaem klicu loadsb premaknem za en znak naprej
    
lenght: ; podfukija s katero štejem dolžino arraya
    lodsb                 ; shranimo v al esi in esi++
    cmp al, 0             ; preverimo èe je al enak 0 oz. èe je konec arraya
    jnz lenght ; èe ne potem še enkrat loopamo podfunkcijo 

    sub esi, 2 ; esi se nahaja 2 znaka po 0 zato ga moremo dati na pravo vrednost

rotate:
    cmp esi, edi ; esi se nahaja na koncu edi na zaèetku sedaj bomo esi zmanjševali edi poveèevali dokler se ne sreèata/križata
    jle end ; èe bo edi postal veèji vemo da lahko zakljuèimo

    mov byte bl, [edi] ; zaèetni znak shranimo v bl ker je velikosti 1 byte [] pomeni vrednost ne pa naslov
    std ; z std nastavimo zastavico to deluje oratno kot cld, saj bomo sedaj z klicem loadsb zmanjšali vrednost esi
    lodsb ; shranimo v al esi in esi-- 
    mov byte [esi+1], bl  ; znak ki smo ga prej shranili v bl ga sedaj prilepimo na konec
    cld                   ; z cld izbrišem zastavico zato, da se ob vskaem klicu stosb edi poveèamo za 1
    stosb                 ; shrani vrednost ali v edi in edi++

    jmp rotate          ; ponovimo za naslenja znaka

end:
    ret ;vrnemo se v main          
  
  
    