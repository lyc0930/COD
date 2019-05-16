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
4. VGA画板  
    **VGA_Brush**  
5. 多周期CPU  
    **MulticycleCPU**  

#### 其他代码片段的说明：  
#### Code snippets:   
- **Counter.v**  
    计数器  
    Clock controled counter  
- **Debounce.v**  
    按钮信号去抖动  
    Debounce the button signal  
- **DisplayPulse.v**  
    七段数码管时装分频  
    Dividing the rate of the clock signal for the 7-Segment display  
- **FrequencyDivision.v**  
    用于时钟分频（适用于IP核输出信号）  
    Dividing the rate of the clock signal(after the IP core)  
- **GenerateClock.v**  
    用于在仿真文件中生成持续的时钟信号  
    Generating the clock signal in test-bench  
- **Hex7SegmentDisplay**  
    将16进制数编码为七段数码管显示输出  
    Encode hexadecimal number for 7-Segment display  
- **MUX.v**  
    多选器（2、3、4选1）  
    Multiplexer(2, 3 or 4 to 1)  
- **Nexys4DDR_Master.xdc**  
    开发版约束文件  
    Constraint file of the Nexys4DDR  
- **SunglePulse.v**  
    产生单独时钟周期信号  
    Translate a signal change to a single clock cycle  
- **bcdto7segment_dataflow.v**  
    将BCD码编码为七段数码管显示输出  
    Encode BCD for 7-Segment display  

### 目前更新到第五次实验