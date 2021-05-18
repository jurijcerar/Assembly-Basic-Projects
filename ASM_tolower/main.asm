section .data  ; konstantni podatki
   instruction db 'Vnesi besedilo: ' ; sporocilo za uporabnika ob zagonu 
   len_i equ $-instruction      ; dol�ina userMsg
   result db 'To lower function: ' ; sporocilo po vnosu 
   len_r equ $-result      ; dol�ina dispMsg           

section .bss           ; neininicializirani podatki
   text resb 1024
	
section .text          ; programska koda
   global _start
	
_start:                ; za�etek programa

   mov eax, 4 ; sys_write sistemski klic
   mov ebx, 1 ; stdout  opis
   mov ecx, instruction ; kaj izpi�emo
   mov edx, len_i ; dol�ina besedila
   int 80h ; klic jedra 
   
   mov eax, 3 ; sys_read sistemski klic
   mov ebx, 2 ; stdin opis
   mov ecx, text  ; v kaj beremo
   mov edx, 1024  ; 1024 velikost texta
   int 80h 
	
   mov esi, text ;kazalec na za�etek besedila
   call toLowerUnderscore ;klic funkcije

   mov eax, 4 ; izpis pred rezultatom
   mov ebx, 1
   mov ecx, result
   mov edx, len_r
   int 80h  

   mov eax, 4 ; izpis rezultata
   mov ebx, 1
   mov ecx, text
   mov edx, 1024
   int 80h  
    
   mov eax, 1 ;izhod
   mov ebx, 0
   int 80h

toLowerUnderscore:
   lodsb                  ; v al nastavimo znak besedila in esi ++
   
   cmp al, 0              ; preverimo �e smo na koncu besedila
   je end                 ; �e smo gremo v funkcijo end

   cmp al, ' '            ; preverimo �e je znak enak ' '
   je underscore         ; �e je potem kli�emo funkcijo
   
   cmp al, 'A'            ; preverimo �e je znak manj�i od A
   jl toLowerUnderscore   ; �e je vemo da ni velika �rka in kon�amo
    
   cmp al, 'Z'            ; preverimo �e �e je znak ve�ji od A
   jge toLowerUnderscore  ; �e je vemo da ni velika �rka in kon�amo
   
   xor al, 0x20           ; �e sta oba pogoja bila pravilna pa spremenimo v majhno �rko, to deluje ker je razlika med a in A to�no 0x20
    
   mov byte [esi-1], al   ; spremenjen znak oz. bajt popravimo v nizu
    
   jmp toLowerUnderscore  ; nadaljujemo z naslednjim znakom  
   
underscore:
   mov al, '_'            ; v al spremenimo ' ' v '_'
   mov byte [esi-1], al   ; spremenjen znak oz. bajt popravimo v nizu
    
   jmp toLowerUnderscore  ; nadaljujemo z naslednjim znakom             
                
end:
   ret  ; vrnemo se v start
     