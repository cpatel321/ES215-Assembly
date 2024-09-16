.data
    result: .asciiz "num 1- num2  is " # string for printing 

.text

    li $t0, 10  #num1 =10
    li $t1, 20  #num2 = 20

   
    not $t2, $t1
    add $t2, $t2,1 # 2's complement for subtraction 
    la $a0, result
    li $v0, 4 #syscall code 4 for printing string
    syscall
    
    add $t3, $t0, $t2
    move $a0, $t3 #storing answer in argument register.
    li $v0, 1 #syscall code 4 for printing string
    syscall


    li $v0, 10  #syscall code 10 for printing
    syscall
