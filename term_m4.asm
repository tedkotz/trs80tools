; A terminal program which may make use of Model 4 feature
; - 80x24 operation
; - Arrow and other key support
; - ANSI Escape code support
;

include "trs80.inc"

; https://en.wikipedia.org/wiki/ANSI_escape_code
;
; Control Chars
; ^G	0x07	BEL	Bell
; ^H	0x08	BS	Backspace
; ^I	0x09	HT	Tab
; ^J	0x0A	LF	Line Feed
; ^K	0x0B	VT  Vert Tab as LF
; ^L	0x0C	FF	Form Feed as LF
; ^M	0x0D	CR	Carriage Return
; ^[	0x1B	ESC	Escape
;
; Control Sequence
; \e[\x40-\x5F] ~ ignore
; \eP maybe
; \e\[[\x30-\x3F]*[\x20-\x2F]*[\x40-\x7E]
;
; \e[rr;ccH Move Cursor to Row rr and Column cc
; \e[rr;ccf Move Cursor to Row rr and Column cc
; \e[A UP
; \e[B DOWN
; \e[C RIGHT
; \e[D LEFT
; \e[J Erase Display
; \e[K Erase Line
;
; xterm sequences:
; <esc>[A     - Up          <esc>[K     -             <esc>[U     -
; <esc>[B     - Down        <esc>[L     -             <esc>[V     -
; <esc>[C     - Right       <esc>[M     -             <esc>[W     -
; <esc>[D     - Left        <esc>[N     -             <esc>[X     -
; <esc>[E     -             <esc>[O     -             <esc>[Y     -
; <esc>[F     - End         <esc>[1P    - F1          <esc>[Z     -
; <esc>[G     - Keypad 5    <esc>[1Q    - F2
; <esc>[H     - Home        <esc>[1R    - F3
; <esc>[I     -             <esc>[1S    - F4
; <esc>[J     -             <esc>[T     -


ORG 6000H

; 5 DEFINT A-Z
; 10 POKE 16890, 0
;LD HL,RSINIT_WAIT ; POKE 16890, 0
;LD A, 0  ; TX/RX BAUDRATE 0=50, 2=110, 5=300, 12=4800, 14=9600, 15=19200
;LD (HL),A
XOR A
LD (RSINIT_WAIT), A

; 15 POKE 16888, 2*17    ' TX/RX BAUDRATE 0=50, 2=110, 5=300, 12=4800, 14=9600, 15=19200
;LD HL,RSINIT_BAUD ; POKE 16888, 2*17
LD A, 7*17  ; TX/RX BAUDRATE 0=50, 2=110, 5=300, 6=600, 7=1200, 10=2400, 12=4800, 14=9600, 15=19200
;LD (HL),A
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
;
CHECK_RS232:
; 100 POKE U1, RX
; 110 X = USR(0)          ' CALL $RSRCV [80]
CALL RSRCV
; 120 C$ = CHR$(PEEK(CI)) ' READ INPUT BUFFER
;LD HL,RSRCV_BUFF ; PEEK(CI)
;LD A, (HL)
LD A, (RSRCV_BUFF)
OR A
JR Z, CHECK_KEY  ; only check the keyboard if the rs232 is empty.
CP '\r'
JR Z, CHECK_RS232

; 130 PRINT C$;           ' WRITE CHAR TO SCREEN will ignore 0
CALL DISPA
JR CHECK_RS232
;
; 150 C$ = INKEY$         ' READ KEYPRESS
CHECK_KEY:
CALL KBDSCN

; 160 IF C$="" THEN 100
OR A      ;CP 0 vs A
JR Z,CHECK_RS232

CP 19 ; ctrl-S
RET Z
; 170 POKE CO, ASC(C$)    ' WRITE CHAR TO OUTPUT BUFFER
;LD HL,RSTX_BUFF
;LD (HL),A
LD (RSTX_BUFF), A

; 180 POKE U1, TX
; 190 X = USR(0)          ' CALL $RSTX [85]
CALL RSTX

; 200 GOTO 100
JR CHECK_RS232
