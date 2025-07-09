
all: term.bin example.bin test.bin term_m4.bin


%.bin: %.asm trs80.inc
	@echo "ASM $<"
	z80asm $< -o $@

dump%: %.bin
	z80dasm -latg 0x6000 $<
	./bindump.py -g 0x6000 $<

$(V).SILENT:
