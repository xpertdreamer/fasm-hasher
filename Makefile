fasm-hasher: main.o
	ld build/main.o -o build/fasm-hasher -dynamic-linker /lib64/ld-linux-x86-64.so.2 -L./raylib/ -lc -lraylib -lm

main.o: main.asm
	@mkdir -p build/
	fasm main.asm build/main.o
