format ELF64

define INITHASH 5381
define STDOUT   1
define NEWLINE  10

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
extrn InitWindow
extrn CloseWindow


section '.data' writable
  msg db "Argument did not providen", NEWLINE, 0
  msg_size = $ - msg
  title db "Raylib Hasher", 0

section '.bss' writable
  buffer db 24 dup (0)
  endbuffer:
  newline db 0

section '.text' executable

_start:
  pop rax
  cmp rax, 2
  jl error
  pop rdi
  xor rdi, rdi
  pop rdi

  push rdi
  mov rdi, 400
  mov rsi, 400
  mov rdx, title
  call InitWindow

  call hash
  call unsigned_to_str
  call CloseWindow
  print rsi ,rdx
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
.end:
  pop rcx
  ret

unsigned_to_str:
  push rbx
  push rcx
  mov [newline], NEWLINE
  mov rbx, 10 ; divider
  mov rsi, endbuffer
.loop:
  dec rsi
  xor rdx, rdx
  div rbx
  add dl, '0'
  mov [rsi], dl
  test rax, rax
  jnz .loop
  mov rdx, newline+1
  sub rdx, rsi
  pop rcx
  pop rbx
  ret

error:
  print msg, msg_size
  exit 1
