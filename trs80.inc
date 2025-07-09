; https://www.trs-80.com/wordpress/roms/addresses/
; https://www.trs-80.com/wordpress/roms/trs-80-level-1-rom-disassembled/
; https://www.trs-80.com/wordpress/roms/model-4-rom-explained/

;CALL 0049H  ; INKEY with wait??
KBDSCN: equ 002BH ; A=INKEY$
DISPA: equ 033AH ; PRINT A$;
RSRCV: equ 0050H
RSRCV_BUFF: equ 41E8H ; RCV INPUT BUFFER


RSTX: equ 0055H
RSTX_BUFF: equ 41F0H ; TX OUTPUT BUFFER

RSINIT: equ 005AH
RSINIT_BAUD: equ 41F8H ; Bits 7-4 for SEND BAUD and Bits 3-0 to RECEIVE BAUD.
; TX/RX BAUDRATE 0=50, 2=110, 5=300, 12=4800, 14=9600, 15=19200
RSINIT_CFG: equ 41F9H ; Parity, Word Length, and Stop Bits.
;    Bit 7: 0=Odd Parity, 1=Even Parity
;    Bits 6-5: 00=5 Bit Word, 01=6 Bit Word, 10=7 Bit Word, 11=8 Bit Word.
;    Bit 4: 0=1 Stop Bit, 1= 2 Stop Bits.
;    Bit 3: 0=Enable Parity, 1=Disable Parity.
;    Bit 2: 0=Transmitter OFF, 1=Transmitter ON
;    Bit 1: 0=Set DTR Low (Ready), 1=Set DTR High.
;    Bit 0: 0=Set RTS Signal Low (Data is Ready), 1=Set RTS Signal High (No Active Request).
RSINIT_WAIT: equ 41FAH ;Wait for Serial I/O: 0=Do Not Wait, Non-Zero=Wait.
