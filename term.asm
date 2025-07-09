; A minimalist terminal program for manual machine code entry
; seems reliable up to 1200 baud on my TRS-80

include "trs80.inc"

ORG 6000H

; 5 DEFINT A-Z
; 10 POKE 16890, 0
XOR A
LD (RSINIT_WAIT), A

; 15 POKE 16888, 2*17    ' TX/RX BAUDRATE 0=50, 2=110, 5=300, 12=4800, 14=9600, 15=19200
LD A, 7*17  ; TX/RX BAUDRATE 0=50, 2=110, 5=300, 6=600, 7=1200, 10=2400, 12=4800, 14=9600, 15=19200
LD (RSINIT_BAUD), A

; 17 U1 = 16526          ' LSB of USR Call Address
; 18 U2 = 16527          ' MSB of USR Call Address
; 20 POKE U1,90
; 30 POKE U2,0
; 40 X = USR(0)          ' CALL $RSINIT [90]
CALL RSINIT  ; CALL $RSINIT [90]

; 50 RX = 80
; 60 TX = 85
; 70 CI = 16872           ' INPUT BUFFER
; 80 CO = 16880           ' OUTPUT BUFFER

CHECK_RS232:
; 100 POKE U1, RX
; 110 X = USR(0)          ' CALL $RSRCV [80]
CALL RSRCV

; 120 C$ = CHR$(PEEK(CI)) ' READ INPUT BUFFER
LD A, (RSRCV_BUFF)

; NNN IF C$="" GOTO 150
OR A
JR Z, CHECK_KEY  ; only check the keyboard if the rs232 is empty.

; NNN IF C$="\r" GOTO 100
CP '\r'
JR Z, CHECK_RS232

; 130 PRINT C$;           ' WRITE CHAR TO SCREEN will ignore 0
CALL DISPA
JR CHECK_RS232

; 150 C$ = INKEY$         ' READ KEYPRESS
CHECK_KEY:
CALL KBDSCN

; 160 IF C$="" THEN 100
OR A      ;CP 0 vs A
JR Z,CHECK_RS232

; NNN IF C$="^S" END
CP 19 ; ctrl-S
RET Z

; 170 POKE CO, ASC(C$)    ' WRITE CHAR TO OUTPUT BUFFER
LD (RSTX_BUFF), A

; 180 POKE U1, TX
; 190 X = USR(0)          ' CALL $RSTX [85]
CALL RSTX

; 200 GOTO 100
JR CHECK_RS232
