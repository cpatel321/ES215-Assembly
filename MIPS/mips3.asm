.data
    num1:    .word 12   
    num2:    .word 18   
    msg:     .asciiz "LCM: "    # Message 

.text
.globl main
main:
    
    lw $t0, num1        
    lw $t1, num2        
    move $t2, $t0        #copy of n1
    move $t3, $t1        # copy of n2

    # euclidian algo.
find_gcd:
    beq $t1, $zero, done_gcd  # branch if equal 
    rem $t4, $t0, $t1        # remainder of $t0 / $t1
    move $t0, $t1           # divisor -> dividend
    move $t1, $t4            # remainder -> divisor
    j find_gcd

done_gcd:
    # Calculate LCM = (num1 * num2) / GCD
    mul $t5, $t2, $t3         # Multiply original num1 and num2
    move $t6, $t0             # $t6 now holds GCD
    div $t5, $t6              # Divide (num1 * num2) by GCD
    mflo $t7                  # Move quotient (LCM) to $t7
  
    li $v0, 4              
    la $a0, msg            
    syscall

    li $v0, 1                
    move $a0, $t7            
    syscall
#exit
    li $v0, 10                
    syscall
