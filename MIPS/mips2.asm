.data
    numbers:    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11   
    count:      .word 11                                  
    result:     .asciiz "Average: "

.text
.globl main
main:
    la $t0, numbers      #load address of  numbers to reg. t0
    lw $t1, count         #load word count to  reg. t1
    
    li $t2, 0            
    li $t3, 0            #loop counter 

find_sum:
    lw $t4, 0($t0)        # indexing the array
    add $t2, $t2, $t4     # t2 is final sum 
    addi $t0, $t0, 4      # index++
    addi $t3, $t3, 1      #loop counter++
    bne $t3, $t1, find_sum  # branch if not equal 

    
    div $t2, $t1          # sum/count
    mflo $t5              # move quotient to $t5

    
    li $v0, 4            
    la $a0, result        
    syscall

    li $v0, 1           
    move $a0, $t5        
    syscall

    li $v0, 10           
    syscall
