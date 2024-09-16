section .data
    num1 dw 0xF00D   ;61453
    num2 dw 0xBEEF   ;48879 
    msg db 'Result: ', 0
    msg_len equ $ - msg

section .bss
    result resw 1
    result_str resb 6   ; Enough space for 5 digits + null terminator

section .text
    global _start

_start:
    mov ax, [num1]
    mov bx, [num2]
    not bx
    add bx, 1
    add ax, bx
    mov [result], ax

    ; Convert result to string
    ; mov rdi, 0          ; Clear RDI
    mov rsi, result_str
    call int_to_str

    ; Print message
    mov rax, 1           ; sys_write
    mov rdi, 1           ; file descriptor (stdout)
    mov rsi, msg         ; pointer to the message
    mov rdx, msg_len     ; length of the message
    syscall

    ; Print result
    mov rax, 1           ; sys_write
    mov rdi, 1           ; file descriptor (stdout)
    mov rsi, result_str  ; pointer to the result string
    mov rdx, 6           ; length of the result string
    syscall

    ; Exit the program
    mov rax, 60          ; sys_exit
    xor rdi, rdi         ; Status 0
    syscall

; Convert integer to string
int_to_str:
    mov ecx, 10          ; Base 10
    xor dl, dl         ; Clear EDX (remainder)
    div ecx              ; Divide RAX by 10
    add dl, '0'          ; Convert remainder to ASCII
    mov [rsi+5], dl        ; Store ASCII digit
    dec rsi              ; Move to the next position
    test rax, rax        ; Check if quotient is 0
    jz int_to_str_done
    call int_to_str      ; Recursive call
int_to_str_done:
    mov byte [rsi], 0    ; Null-terminate the string
    ret
;console output 
;Result: 12574