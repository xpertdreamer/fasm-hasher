main.o: main.asm
	@mkdir -p build/
	fasm main.asm build/main.o

main: main.o
	ld build/main.o -o build/main
	./build/main
