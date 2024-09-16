section .data
    num1 dw 12
    num2 dw 18
    msg db 'LCM: ', 0
    msg_len equ $ - msg

section .bss
    lcm resw 1
    gcd resw 1
    lcm_str resb 6

section .text
    global _start

_start:
    mov ax, [num1]        ; Load first number into AX
    mov bx, [num2]        ; Load second number into BX
    mov cx, ax            ; Save original num1 in CX
    mov dx, bx            ; Save original num2 in DX
    
    ; Compute GCD using Euclidean algorithm
    find_gcd:
        cmp bx, 0
        je done_gcd
        xor dx, dx        ; Clear DX (remainder)
        div bx            ; AX divided by BX
        mov ax, bx        ; Save the previous divisor as the new dividend
        mov bx, dx        ; Save the remainder as the new divisor
        jmp find_gcd      ; Repeat the loop
    
    done_gcd:
        mov [gcd], ax     ; Store the GCD (in AX) in memory
    
    ; Calculate LCM
    mov ax, [num1]        ; Load first number into AX
    mov bx, [num2]        ; Load second number into BX
    imul ax, bx           ; AX = num1 * num2
    mov cx, [gcd]         ; Load GCD into CX
    test cx, cx           ; Check if GCD is zero to avoid division by zero
    jz exit               ; Exit if GCD is zero (undefined LCM)
    idiv cx               ; Divide (num1 * num2) by GCD
    mov [lcm], ax         ; Store the LCM (in AX) in memory
    


    ; Convert result to string
    mov rdi, 0          ; Clear RDI
    mov rsi, lcm_str
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
    mov rsi, lcm_str  ; pointer to the result string
    mov rdx, 6           ; length of the result string
    syscall
    ; Exit the program
exit:
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

;console output
; LCM: 36