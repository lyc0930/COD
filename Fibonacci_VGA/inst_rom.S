j _loop

.data
    .word 1,1,6   #编译成机器码时编译器会在前面多加个0，所以后面lw指令地址会多加4

_loop:    
        addi $t0,$0,6
        lw   $t1,16($0) #通过更改$3的值控制运行
        lw   $s0,8($0)
        lw   $s1,12($0)
        add  $s2,$s1,$s0 
        sw   $s1,8($0)
        sw   $s2,12($0) #最新结果存在$1里
_hold:
        beq  $t0,$t1,_next
        j    _hold
_next:
        j    _loop