%include "io.inc"

section .data
    msg db 'Hello World', 0 ;0 je za konec stringa db defined bytes

section .text
    global CMAIN
CMAIN:
    mov ebp, esp ;pomoè pri razhrošèevanju, generira stacktrace 
    PRINT_STRING msg ;izpis podatkov shranjenih v msg
    NEWLINE ;nova vrstica
    xor eax, eax ;register sprostimo oz. damo na 0
    ret ;vrnemo se iz operacije
    ;