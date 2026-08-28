fasm-hasher: main.o
	ld build/main.o -o build/fasm-hasher

main.o: main.asm
	@mkdir -p build/
	fasm main.asm build/main.o
