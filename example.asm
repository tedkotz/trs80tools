; Simple example Assembly Program
;
; z80asm example.asm -o example.bin
; z80dasm -latg 0x6000 example.bin


ORG 6000H
LD HL,3C00H ; 15360 in hex, Set Start of Video Memory
LD A, 191   ; Set Fill char
LD (HL),A   ; Write to first byte
LD DE,3C01H ; Setup for 2nd byte in Video Memory
LD BC,1023  ; Setup for size of Video Memory
LDIR        ; {(DE) <- (HL), DE <- DE+1, HL <- HL+1, BC <- BC-1} while (BC != 0)
CALL 0049H  ; Wait for key press
RET
