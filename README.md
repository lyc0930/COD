# COD
### 计算机组成原理与设计实验
### Computer Organization and Design
[![](https://img.shields.io/badge/Lab-@lyc0930-brightgreen.svg?style=flat)](https://github.com/lyc0930) ![](https://img.shields.io/badge/USTC-2019Spring-inactive.svg?style=flat)
***
##### 这是用于存放大二年级下学期组成原理上机实验课程代码的仓库，库内还包括截图、下载照片、[实验报告](https://github.com/lyc0930/COD/tree/master/实验报告)等相关内容
##### This is a repository of verilog code of computer organization and design courses in spring semester of sophomore including the screen-catches, photos and [reports](https://github.com/lyc0930/COD/tree/master/实验报告) of courses

***
#### 各次实验对应目录：
#### Directories of each lab:
1. 运算器、寄存器、比较器、累加器、斐波那契数列生成
    [**ALU**](https://github.com/lyc0930/COD/tree/master/ALU), [**Register**](https://github.com/lyc0930/COD/tree/master/Register), [**CMP**](https://github.com/lyc0930/COD/tree/master/CMP), [**ACM**](https://github.com/lyc0930/COD/tree/master/ACM), [**Fibonacci**](https://github.com/lyc0930/COD/tree/master/Fibonacci)
2. 除法器、（冒泡）排序
    [**DIV**](https://github.com/lyc0930/COD/tree/master/DIV), [**Sort**](https://github.com/lyc0930/COD/tree/master/Sort)
3. 寄存器组、计数器、循环队列
    [**RegisterFile**](https://github.com/lyc0930/COD/tree/master/RegisterFile), [**Counter**](https://github.com/lyc0930/COD/tree/master/Counter), [**Queue**](https://github.com/lyc0930/COD/tree/master/Queue)
4. VGA画板
    [**VGA_Brush**](https://github.com/lyc0930/COD/tree/master/VGA_Brush)
5. 多周期CPU
    [**MulticycleCPU**](https://github.com/lyc0930/COD/tree/master/MulticycleCPU)
6. 综合实验
    [**Fibonacci_VGA**](https://github.com/lyc0930/COD/tree/master/Fibonacci_VGA), [**MulticycleCPU**](https://github.com/lyc0930/COD/tree/master/MulticycleCPU)

> 注：在第六次实验中，对于多周期CPU的代码结构有了非功能性的优化，已覆盖更新，注意[**MulticycleCPU**](https://github.com/lyc0930/COD/tree/master/MulticycleCPU)目录下的代码版本
> P.s. In Lab6, the code structure of the multicycle CPU has been non-functionally optimized, and the update has been overwritten. Note the code version in the [**MulticycleCPU**](https://github.com/lyc0930/COD/tree/master/MulticycleCPU) directory.

***
#### 其他代码片段的说明：
#### Code snippets:
- [**Counter.v**](https://github.com/lyc0930/COD/tree/master/Counter.v)
    计数器
    Clock controled counter
- [**Debounce.v**](https://github.com/lyc0930/COD/tree/master/Debounce.v)
    按钮信号去抖动
    Debounce the button signal
- [**DisplayPulse.v**](https://github.com/lyc0930/COD/tree/master/DisplayPulse.v)
    七段数码管时装分频
    Dividing the rate of the clock signal for the 7-Segment display
- [**FrequencyDivision.v**](https://github.com/lyc0930/COD/tree/master/FrequencyDivision.v)
    用于时钟分频（适用于IP核输出信号）
    Dividing the rate of the clock signal(after the IP core)
- [**GenerateClock.v**](https://github.com/lyc0930/COD/tree/master/GenerateClock.v)
    用于在仿真文件中生成持续的时钟信号
    Generating the clock signal in test-bench
- [**Hex7SegmentDisplay.v**](https://github.com/lyc0930/COD/tree/master/Hex7SegmentDisplay.v)
    将16进制数编码为七段数码管显示输出
    Encode hexadecimal number for 7-Segment display
- [**MUX.v**](https://github.com/lyc0930/COD/tree/master/MUX.v)
    多选器（2、3、4选1）
    Multiplexer(2, 3 or 4 to 1)
- [**Nexys4DDR_Master.xdc**](https://github.com/lyc0930/COD/tree/master/Nexys4DDR_Master.xdc)
    开发版约束文件
    Constraint file of the Nexys4DDR
- [**SinglePulse.v**](https://github.com/lyc0930/COD/tree/master/SinglePulse.v)
    产生单独时钟周期信号
    Translate a signal change to a single clock cycle
- [**bcdto7segment_dataflow.v**](https://github.com/lyc0930/COD/tree/master/bcdto7segment_dataflow.v)
    将BCD码编码为七段数码管显示输出
    Encode BCD for 7-Segment display

***
### 目前大二春季学期更新已结束
### Course has ended, so the update is suspended
