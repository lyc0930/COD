# MPIS-CPU的多周期实现  
## Multicycle MIPS-CPU  

##  目前支持的指令  
### Instructions  
    - `add`, `sub`, `and`, `or`, `xor`, `nor`, `slt`  
    - `addi`, `andi`, `ori`, `xori`, `slti`  
    - `lw`, `sw`  
    - `beq`, `bne`, `j`  
    
## 2019.5.9 建立，属于实验五的核心内容  
### Upload at 2019.5.9, as a part of lab5  

***  

## 2019.6.6 更新，在实验六中进行了语法的优化  
### Update at 2019.6.6, fix some problem in lab6  
    1. 采用"MIPS-opcode.vh"头文件
        Use the verilog header file
    2. 重命名并改写了寄存器堆文件，使之支持同时同步读写同一地址  
        Rename and rewrite the register file, support the synchronous reading and writing request of same address  
    3. 添加了零扩展，并将其与符号扩展合写在一个文件中  
        Add the zero extention, rewrite in one file with sign extention  