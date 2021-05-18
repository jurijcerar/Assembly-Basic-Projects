%include "io.inc"

section .data
    string db 'ABCDE', 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, string ; niz v register
    call setup_rotate ; funkcija za obra�anje
    PRINT_STRING string ; izpis niza
    xor eax, eax ; return 0
    ret ; izhod

setup_rotate:                
    mov esi, eax ; esi nastavim na za�etek arraya
    mov edi, eax ; edi nastavim na za�etek arraya
    cld          ; z cld izbri�em zastavico zato, da se ob vskaem klicu loadsb premaknem za en znak naprej
    
lenght: ; podfukija s katero �tejem dol�ino arraya
    lodsb                 ; shranimo v al esi in esi++
    cmp al, 0             ; preverimo �e je al enak 0 oz. �e je konec arraya
    jnz lenght ; �e ne potem �e enkrat loopamo podfunkcijo 

    sub esi, 2 ; esi se nahaja 2 znaka po 0 zato ga moremo dati na pravo vrednost

rotate:
    cmp esi, edi ; esi se nahaja na koncu edi na za�etku sedaj bomo esi zmanj�evali edi pove�evali dokler se ne sre�ata/kri�ata
    jle end ; �e bo edi postal ve�ji vemo da lahko zaklju�imo

    mov byte bl, [edi] ; za�etni znak shranimo v bl ker je velikosti 1 byte [] pomeni vrednost ne pa naslov
    std ; z std nastavimo zastavico to deluje oratno kot cld, saj bomo sedaj z klicem loadsb zmanj�ali vrednost esi
    lodsb ; shranimo v al esi in esi-- 
    mov byte [esi+1], bl  ; znak ki smo ga prej shranili v bl ga sedaj prilepimo na konec
    cld                   ; z cld izbri�em zastavico zato, da se ob vskaem klicu stosb edi pove�amo za 1
    stosb                 ; shrani vrednost ali v edi in edi++

    jmp rotate          ; ponovimo za naslenja znaka

end:
    ret ;vrnemo se v main          
  
  
    