.data
    string:  .asciiz "Hello, MIPS World!"  # String to search in
    charToFind: .asciiz "M"                # Character to search for
    msg_found: .asciiz "Character found at index: "
    msg_not_found: .asciiz "Character not found"
    result_index: .word 0                  # To store the index of the found character
    newline: .asciiz "\n"

.text
.globl main
main:
    # Load addresses of the string and character
    la $t0, string        # Load address of the string into $t0
    la $t1, charToFind    # Load address of the character to find into $t1
    lb $t2, 0($t1)        # Load the character to find into $t2
    li $t3, 0             # Initialize index counter to 0
    li $t4, -1            # Initialize result index to -1 (not found)

search_loop:
    lb $t5, 0($t0)        # Load current character from the string
    beqz $t5, not_found   # If end of string (null terminator), go to not_found
    beq $t5, $t2, found   # If character matches, go to found
    addi $t0, $t0, 1      # Move to the next character in the string
    addi $t3, $t3, 1      # Increment index counter
    j search_loop         # Repeat the loop

found:
    li $t4, 0             # Store index in result index (found)
    sw $t3, result_index  # Store the found index
    j print_result        # Jump to print the result

not_found:
    li $t4, 1             # Character not found (set result index to -1)

print_result:
    # Print message based on the result
    beq $t4, 0, print_found  # If result index is 0, print found message
    li $v0, 4              # Print string syscall
    la $a0, msg_not_found  # Load address of "Character not found" message
    syscall
    j end_program

print_found:
    li $v0, 4              # Print string syscall
    la $a0, msg_found      # Load address of "Character found at index: " message
    syscall

    # Print the index
    li $v0, 1              # Print integer syscall
    lw $a0, result_index   # Load the result index
    syscall

    # Print newline
    li $v0, 4              # Print string syscall
    la $a0, newline        # Load address of newline
    syscall

end_program:
    li $v0, 10             # Exit syscall
    syscall
