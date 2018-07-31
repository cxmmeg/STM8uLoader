stm8/  TITLE "Reset_128000v0D.asm"
    MOTOROLA
    WORDS
	.NOLIST
	#include "STM8S103F3P.inc"
    .LIST
; размер дампа должен быть 243 байта
; при этом дамп будет находится в адресах $02ED...$03DF
; (затирает адеса $03DE:$03DF с адресом перехода к начальному загрузчику)
; и вызываться по адресу $02EF
; вызвавший дамп начальный загрузчик находится в адресах $03E0...$03FE
; и повторно может быть вызван по адресу $03E0 (переключит скорость на 9600, надо A<=$0D SP<=$03DF X<=$0000)
; или по адресу $03E8 (скорость не переключит, надо A<=$0D SP<=$03E7 X<=$0000)
; команда перехода к прикладной программе здесь $03FB
	segment byte at 0000-00F2 'ram0'
	dc.w   $02EF
start:
; Инициализируем регистры и передаем управление на вектор RESET
    ldw    X, #$03FF
	ldw    SP, X
	clrw   X
	clrw   Y
	ld     A, #$28
	push   A
	clr    A
	pop    CC
	jp     $8000
	
	SKIP   226, $00

	end
; Reset_128000v0D.asm