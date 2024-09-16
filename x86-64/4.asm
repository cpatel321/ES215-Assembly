;16 bit only
section .data
    num1 dw 7
    num2 dw 8
    msg db 'Product: ', 0
    msg_len equ $ - msg

section .bss
    result resw 1
    prod_str resb 6   ; Enough space for 5 digits + null terminator

section .text
    global _start

_start:
    mov ax, [num1]
    mov cx, [num2]
    xor bx, bx            ; Clear BX (result accumulator)

    multiply_loop:
        cmp cx, 0
        je done_multiply
        add bx, ax        ; Add AX to BX
        ; dec cx            ; Decrement CX: no need because look decreases the value of CX by 1 each time
        loop multiply_loop
    done_multiply:
        mov [result], bx      ; Store the result



    ; Convert result to string
    mov rdi, 0          ; Clear RDI
    mov ax, bx         ; Clear RAX
    mov rsi, prod_str
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
    mov rsi, prod_str  ; pointer to the result string
    mov rdx, 6           ; length of the result string
    syscall
    ; Exit the program
    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall



; Convert integer to string
int_to_str:
    mov cx, 10          ; Base 10
    xor dx, dx         ; Clear EDX (remainder)
    div cx              ; Divide RAX by 10
    add dl, '0'          ; Convert remainder to ASCII
    mov [rsi+5], dl        ; Store ASCII digit
    dec rsi              ; Move to the next position
    test ax, ax        ; Check if quotient is 0
    jz int_to_str_done
    call int_to_str      ; Recursive call
int_to_str_done:
    mov byte [rsi], 0    ; Null-terminate the string
    ret

;console output
;Product: 56