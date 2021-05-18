section .data  ; konstantni podatki
   instruction db 'Vnesi besedilo: ' ; sporocilo za uporabnika ob zagonu 
   len_i equ $-instruction      ; dolžina userMsg
   result db 'To lower function: ' ; sporocilo po vnosu 
   len_r equ $-result      ; dolžina dispMsg           

section .bss           ; neininicializirani podatki
   text resb 1024
	
section .text          ; programska koda
   global _start
	
_start:                ; zaèetek programa

   mov eax, 4 ; sys_write sistemski klic
   mov ebx, 1 ; stdout  opis
   mov ecx, instruction ; kaj izpišemo
   mov edx, len_i ; dolžina besedila
   int 80h ; klic jedra 
   
   mov eax, 3 ; sys_read sistemski klic
   mov ebx, 2 ; stdin opis
   mov ecx, text  ; v kaj beremo
   mov edx, 1024  ; 1024 velikost texta
   int 80h 
	
   mov esi, text ;kazalec na zaèetek besedila
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
   
   cmp al, 0              ; preverimo èe smo na koncu besedila
   je end                 ; èe smo gremo v funkcijo end

   cmp al, ' '            ; preverimo èe je znak enak ' '
   je underscore         ; èe je potem klièemo funkcijo
   
   cmp al, 'A'            ; preverimo èe je znak manjši od A
   jl toLowerUnderscore   ; èe je vemo da ni velika èrka in konèamo
    
   cmp al, 'Z'            ; preverimo še èe je znak veèji od A
   jge toLowerUnderscore  ; èe je vemo da ni velika èrka in konèamo
   
   xor al, 0x20           ; èe sta oba pogoja bila pravilna pa spremenimo v majhno èrko, to deluje ker je razlika med a in A toèno 0x20
    
   mov byte [esi-1], al   ; spremenjen znak oz. bajt popravimo v nizu
    
   jmp toLowerUnderscore  ; nadaljujemo z naslednjim znakom  
   
underscore:
   mov al, '_'            ; v al spremenimo ' ' v '_'
   mov byte [esi-1], al   ; spremenjen znak oz. bajt popravimo v nizu
    
   jmp toLowerUnderscore  ; nadaljujemo z naslednjim znakom             
                
end:
   ret  ; vrnemo se v start
     