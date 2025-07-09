; Simple test example program
;

include "trs80.inc"

ORG 6000H

L1:
LD A,(MYBYTE)
INC A
LD (MYBYTE),A
CALL DISPA

CALL KBDSCN
;CALL DISPA

OR A     ;CP 0 vs A
JR Z,L1
RET

MYBYTE: db 1
