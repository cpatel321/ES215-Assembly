section .data
    numbers dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11
    count dw 11
    msg db 'Average: ', 0
    msg_len equ $ - msg

section .bss
    sum resw 1            ; Space to store the sum
    average resw 1        ; Space to store the average
    average_str resb 6    ; Enough space for 5 digits + null terminator

section .text
    global _start

_start:
    mov rsi, numbers      ; Address of the numbers array
    mov cx, [count]       ; Number of elements
    xor ax, ax            ; Clear AX (sum accumulator)
    
    find_sum:
        add ax, [rsi]     ; Add number to AX
        add rsi, 2        ; Move to the next number (2 bytes per number)
        loop find_sum
    
    mov [sum], ax         ; Store sum
    mov bx, [count]       ; Load count
    div bx                ; Divide sum by count to get the average
    mov [average], al     ; Store average (AL contains the result of division)

     ; Convert result to string
    mov rdi, 0          ; Clear RDI
    mov rsi, average_str
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
    mov rsi, average_str  ; pointer to the result string
    mov rdx, 6           ; length of the result string
    syscall
    ; Exit the program
    mov rax, 60           ; sys_exit
    xor rdi, rdi          ; Status 0
    syscall



; Convert integer to string
int_to_str:
    mov ecx, 10          ; Base 10
    xor edx, edx         ; Clear EDX (remainder)
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

