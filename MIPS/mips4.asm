.data
    num1:    .word 7       
    num2:    .word 8       
    msg:     .asciiz "Product: " 

.text
.globl main
main:
    
    lw $t0, num1         
    lw $t1, num2         
    li $t2, 0            # result register 

    #multiplication done by adding the n1, n2 times 
multiply_loop:
    beq $t1, $zero, done_multiply   # If num2 is zero, exit loop
    add $t2, $t2, $t0              # adding n1 to result register 
    subi $t1, $t1, 1               #  $t1
    j multiply_loop		  # jump register

done_multiply:
   
    # Print "Product: "
    li $v0, 4                     
    la $a0, msg                   
    syscall

    # Print the product 
    move $a0, $t2                  
    li $v0, 1                      
    syscall

    # Exit
    li $v0, 10                    
    syscall
