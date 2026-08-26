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

public _start

section '.data' writable
  teststr db 'A', 0

section '.bss' writable
  buffer db 24 dup (0)
  endbuffer:

section '.text' executable

_start:
  mov rdi, teststr
  call hash
  call unsigned_to_str
  print ?
  exit 0

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

unsigned_to_str:
  ; TODO: convert unsigned decimal from hash to string buffer

.end:
  pop rcx
  ret
