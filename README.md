# COD
### 计算机组成原理与设计实验
### Computer Organization and Design
***
##### 这是用于存放大二年级下学期组成原理上机实验课程代码的仓库，库内还包括截图、下载照片、实验报告等相关内容  
##### This is a repository of verilog code of computer organization and design courses in summer semester of sophomore including the screen-catches, photos and reports of courses  

***
#### 各次实验对应目录：  
#### Directories of each lab:   
1. 运算器、寄存器、比较器、累加器、斐波那契数列生成  
    **ALU, Register, CMP, ACM, Fibonacci**
2. 除法器、排序  
    **DIV, Sort**  
3. 寄存器组、计数器、循环队列  
    **RegisterFile, Counter, Queue**

#### 其他代码片段的说明：  
#### Code snippets:   
- **FrequencyDivision.v**  
    用于时钟分频（适用于IP核输出信号）  
    Dividing the rate of the clock signal(after the IP core)  
- **GenerateClock.v**  
    用于在仿真文件中生成持续的时钟信号  
    Generating the clock signal in test-bench  
- **Nexys4DDR_Master.xdc**  
    开发版约束文件  
    Constraint file of the Nexys4DDR  

### 目前更新到第三次实验（部分）