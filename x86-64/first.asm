section .data
    numbers dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    target dw 7
    output db 0
    iterations dw 0
    index dw 0
    msg db 'Output: ', 0
    msg_len equ $ - msg
    
    

section .bss
    result resb 1


section .text
    global _start

_start:
    mov rsi, numbers      ; Address of numbers
    mov cx, 10            ; Number of elements
    mov ax, [target]      ; Load target number
    xor bx, bx            ; Index accumulator
    xor di, di            ; Iterations count


    search_loop:
        cmp [rsi], ax
        je found
        inc bx
        inc di
        add rsi, 2
        loop search_loop

    not_found:
        mov byte [result], 2
        jmp end_program

    found:
        mov byte [result], 1
        mov [iterations], di
        mov [index], bx

    end_program:
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