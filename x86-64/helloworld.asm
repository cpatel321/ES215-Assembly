section .data
    msg db 'Hello, World!', 0  ; Adding a newline character for proper output

section .text
    global _start

_start:
    ; Write the message to stdout
    mov rax, 1          ; syscall number for sys_write
    mov rdi, 1          ; file descriptor 1 is stdout
    mov rsi, msg        ; pointer to the message
    mov rdx, 13         ; length of the message including newline character
    syscall             ; invoke the system call

    ; Exit the program
    mov rax, 60         ; syscall number for sys_exit
    xor rdi, rdi        ; exit code 0
    syscall             ; invoke the system call