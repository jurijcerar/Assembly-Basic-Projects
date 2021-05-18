	.file	"main.cpp" ;ime datoteke
	.def	___main;	.scl	2;	.type	32;	.endef ;.def definira debugging simbol || .scl 2 pomeni zunanji pomnilniški razred || .type 32 nam poveda je ta simbol funkcija || __main skrbi za potrebe gcc-ja
	.section .rdata,"dr" ;pove asm-ju naj da podatke v sekcijo .rdata
LC0: ;label
	.ascii "Jurij Cerar E1115077\0" ;moj string
	.text ;prièetek texta oziroma kode
	.globl	_main ;definira _main globalno in ga naredi vidnega za linker in druge module
	.def	_main;	.scl	2;	.type	32;	.endef ;kreira simbole, ki pravijo da je main funkcija
_main: ;kreira nov "label" ki bo postal naslov, ki je zaradi zgornje definicje vidna drugim modulom
LFB12:;label
	.cfi_startproc ;inicializira nekatere notranje podatkovne strukture in oddamo zaèetna CFI navodila, ki so odvisna od arhitekture, uporablja a zaèetku funkcij, ki imajo vhod v .eh_frame
	pushl	%ebp ;shranimo ebp register v sklad, zato da ga na koncu funkcije vrnemo na mesto
	.cfi_def_cfa_offset 8 ;modificira pravilo za CFA raèunanje, register ostane isti, offset (stevilo naslovov lokacij dodanih v bazo naslovov zato da dobimo absolutni naslov) pa je nov
	.cfi_offset 5, -8 ;prejšnjo vrednost iz registra 5 shranimo v absolutni naslov offset -8
	movl	%esp, %ebp ;premakne kazalec na sklad v ebp register, ebp kaže na vrh sklada znotraj trenutnega okvirja
	.cfi_def_cfa_register 5 ;modificira pravilo za CFA raèunanje, uporablajl bo register 5 od sedaj naprej
	andl	$-16, %esp ;esp poravna na 16 byte-no mejo
	subl	$16, %esp ;esp alocira 16 bytov spomina
	call	___main ;klic __main, ki bo inicializirala potrebne stvari za delovanje gcc
	movl	$LC0, (%esp) ;premakne vrednost v LC0 v register esp
	call	_printf ;klic _printf
	movl	$0, %eax ;premakne 0 v eax register, v tem registru je shranjeno kaj bo vrnila funkcija
	leave ;ebp in esp v prvotno stanje pred klicom funkcij
	.cfi_restore 5 ;vrne register 5 v prvotno stanje
	.cfi_def_cfa 4, 4 ;definira pravilo za CFA raèunanje vzame naslov registra in mu doda offset
	ret ;return stavek
	.cfi_endproc ;ko konèamo funkcijo moramo zakljuèiti tudi .cfi_startproc
LFE12:;label, kjer so navodila za return stavek
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_printf;	.scl	2;	.type	32;	.endef ;definicja printf