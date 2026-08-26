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

macro exit code {
  mov rdi, code
  mov rax, 60
  syscall
}
  
hash:
  push rcx
  mov rax, INITHASH
  mov rcx, 0
.loop:
  mov cl, [rdi]
  inc rdi
  test rcx, rcx
  jz .end
  mov rdx, rax
  shl rax, 5
  add rax, rdx
  add rax, rcx
  jmp .loop

.end:
  pop rcx
  ret
