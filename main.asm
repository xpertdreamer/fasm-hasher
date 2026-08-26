format ELF64

define INITHASH 5381
define STDOUT   1

macro print buf, len {
  mov rax, 1
  mov rdi, STDOUT
  mov rsi, buf
  mov rdx, len
  syscall
}

macro exit {
  mov rax, 60
  mov rdi, 0
  syscall
}
  
