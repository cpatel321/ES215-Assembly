.data
    numbers:  .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19    # List of sorted numbers
    target:   .word 7      # Target number to search
    output:   .word 0      # Output location (1 if found, 2 if not found)
    iterations: .word 0    # To store the number of iterations (if found)
    index:    .word 0      # To store the index of the found element

.text
.globl main
main:
    # Initialize registers
    la $t0, numbers        # Load the base address of the numbers array into $t0
    lw $t1, target         # Load the target number into $t1
    li $t2, 10             # Number of elements in the list
    li $t3, 0              # Initialize iteration counter
    li $t4, 2              # Assume output to be "2" (not found) initially

search_loop:
    beqz $t2, not_found    # If no more elements, go to not_found
    lw $t5, 0($t0)         # Load the current number from the list
    addi $t3, $t3, 1       # Increment iteration counter
    beq $t1, $t5, found    # If target equals current element, go to found
    addi $t0, $t0, 4       # Move to the next element in the array
    subi $t2, $t2, 1       # Decrement the number of remaining elements
    j search_loop          # Repeat the loop

found:
    li $t4, 1              # Store 1 in output if found
    subi $t6, $t3, 1       # Index = iterations - 1
    la $t7, output         # Load address of output
    sw $t4, 0($t7)         # Store 1 (found) in output location
    sw $t3, 4($t7)         # Store the number of iterations
    sw $t6, 8($t7)         # Store the index of the found element
    j exit

not_found:
    la $t7, output         # Load address of output
    sw $t4, 0($t7)         # Store 2 (not found) in output location

exit:
    li $v0, 10             # Exit syscall
    syscall
