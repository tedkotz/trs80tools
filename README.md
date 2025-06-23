# trs80tools
TRS-80 tools to get my old TRS-80 working as a terminal.


### Data

https://jimlawless.net/blog/posts/z-80/

R  $0000 - $2FFF  ROM
   $3000 - $37DF  -unmapped-
 W $37E0 - $37E3  DRVSEL
   $37E4 - $37E7  -unmapped-
RW $37E8 - $37E9  printer
   $37EA - $37EB  -unmapped-
RW $37EC          FDC command
RW $37ED          FDC track
RW $37EE          FDC sector
RW $37EF          FDC data
   $37F0 - $37FF  -unmapped-
R  $3800 - $38FF  keyboard
   $3900 - $39FF    keyboard mirror
   $3A00 - $3AFF    keyboard mirror
   $3B00 - $3BFF    keyboard mirror
RW $3C00 - $3FFF  display RAM
RW $4000 - $FFFF  RAM

loader,txt on phone

https://en.wikipedia.org/wiki/Intel_HEX

https://en.wikipedia.org/wiki/SREC_(file_format)

https://www.trs-80.com/wordpress/tips/formats/

https://en.wikipedia.org/wiki/Kansas_City_standard


### ToDo
- [x] BASIC 110 baud terminal
- [ ] Can we speed it up to 300+ baud?
    - DEFINT
    - give serial input priority over keyboard
- [ ] write a BASIC serial loader for machine code software
- [ ] Assembly Hello WOrld
- [ ] Assembly Terminal Emulator
- [ ] Fix CR/NL handling
- [ ] Arrow keys
- [ ] Clear Screen
- [ ] ANSI escape sequence minimums (vt100?)
- [ ] get Nano to work.
- [ ] get LPRINT working with the EPSON
- [ ] Fix Floppy drives
- [ ] get floppy disk software
- [ ] figure out how to launch from boot ROM
- [ ] get floppy Tape drive working with
