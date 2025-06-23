
; z80asm example.asm -o example.bin
; z80dasm -latg 0x6000 example.bin


ORG 6000H
LD HL,3C00H ; 15360 in hex
LD A, 191
LD (HL),A
LD DE,3C01H
LD BC,1023
LDIR
CALL 0049H
RET
L1: JP L1

; ORG 0000
; 0000:21003C LD HL, 3C00
; 0003:3EBF   LD A, BF
; 0005:77     LD (HL), A
; 0006:11013C LD DE, 3C01
; 0009:01FF03 LD BC, 03FF
; 000C:EDB0   LDIR
; 000E:C9     RET
;
;
; 6000 24576
;
; 21  33
; 00  0
; 3C  60
; 3E  62
; BF  191
; 77  119
; 11  17
; 01  1
; 3C  60
; 01  1
; FF  255
; 03  3
; ED  237
; B0  176
; C9  201
;     201
