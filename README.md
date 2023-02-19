# 基于PYNQ Z2开发板与Vivado 2022.2的FPGA开发板使用教程

## 0. PYNQ Z2配置

见官方文档: https://pynq.readthedocs.io/en/latest/getting_started/pynq_z2_setup.html  
SD卡系统镜像文件在http://www.pynq.io/board.html下载, 使用Win32DiskImager烧录即可.

## 1. Vivado下载与安装

**下载**

前往XILINX下载中心: https://www.xilinx.com/support/download.html  
首先进行账户注册, 注册完成后选择"Xilinx Unified Installer 2022.2: Windows Self Extracting Web Installer (EXE - 209.61 MB)"下载.  
下载时提示"U.S. Government Export Approval", 可以按照以下信息填写:  
Company Name: Massachusetts Institute of Technology  
Address 1: Massachusetts Institute of Technology  
Location: United States  
State/Province: Massachusetts  
City: Cambridge  
Postal Code: 02139  

点击Download下载.

**安装**

安装时按照默认配置即可. 在安装路径处选择安装文件夹. 注意安装时所需的磁盘空间至少120GB, 安装完毕后将占用磁盘100GB以上空间. 下载文件时会出现警告, 多次重试即可.

## 2. 配置开发板文件

**配置文件**
前往PYNQ官网: https://www.tulembedded.com/FPGA/ProductsPYNQ-Z2.html
选择PYNQ-Z2 Board File下载. 解压压缩包, 复制第二层pynq-z2文件夹.  
打开Vivado所在路径, 进入Vivado\2022.2\data\boards文件夹. 新建board_files文件夹, 并将pynq-z2文件夹粘贴进去. 如图.

![1.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/1.jpg)

**约束文件**
前往PYNQ教程网站: https://pynq.readthedocs.io/en/latest/overlay_design_methodology/board_settings.html  
选择Download the Pynq-Z2 Master XDC constraints下载约束文件, 解压备用.

## 3. 新建项目
打开Vivado, 选择"Create Project", 输入项目名称与路径. 选中Create project subdirectory, 点击Next.  

![2.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/2.jpg)

选择RTL Project, 点击Next.

![3.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/3.jpg)

Target language与Simulator language均为Verilog, 点击Next.

![4.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/4.jpg)

Add Constriants中选择左上角蓝色+, 点击Add files. 选择上一步下载的约束文件(后缀名为.xdc). 选中Copy constraints files into project, 点击Next.

![5.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/5.jpg)

选择Boards, 选择pynq-z2(如果上一步配置文件配置正确的话应该会出现), 点击Next.

![6.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/6.jpg)

点击Finish. 项目新建完成.

![7.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/7.jpg)

## 4. 新建IP(Intellectual Property)

点击左边栏IP INTEGRATOR-Create Block Design, 命名完毕后点击OK

![8.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/8.jpg)
![9.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/9.jpg)

进入Sources菜单, 右键Design Sources, 点击Add Sources.

![10.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/10.jpg)

选择Add or create design sources, 点击Next.

![11.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/11.jpg)

点击Create File, File type选择Verilog, 命名后点击OK.

![12.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/12.jpg)

点击Finish.

![13.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/13.jpg)

自动弹出引脚定义页面. 以半加法器为例, 拥有两个input(a, b)与两个output(sum, c_out). 点击OK.

![14.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/14.jpg)

进入half_adder.v, 粘贴以下代码并保存(Ctrl+S):

```Verilog
module Add_half (sum, c_out, a, b);
    input a, b;
    output sum, c_out;
    wire c_out_bar;
    xor (sum, a, b);
    nand (c_out_bar, a, b);
    not (c_out, c_out_bar);
endmodule
```

![15.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/15.jpg)

## 5. 准备运行

进入Diagram菜单(或点击half_adder.bd), 将half_adder.v拖入框中.

![16.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/16.jpg)

右键一个引脚, 选择Create Port, 命名(建议命名为对应的外设名称)后点击OK. Ctrl+S保存.

![17.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/17.jpg)
![18.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/18.jpg)
![19.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/19.jpg)

点击左边栏Run Synthesis, 以默认配置运行.

![20.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/20.jpg)
![21.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/21.jpg)

可在Design Run中监测进度. 等待一段时间.

![22.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/22.jpg)

完成后弹出如下菜单, 选择Open Synthesis Design.

![23.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/23.jpg)

进入I/O Ports菜单, 根据User Manual第20页所示的引脚定义配置. 此处以input为两个开关, output为单色LED为例.  
I/O Std参考约束文件13,14,27,28行

```Verilog
#set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]; #IO_L7N_T1_AD2N_35 Sch=sw[0]
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]; #IO_L7P_T1_AD2P_35 Sch=sw[1]
...
#set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L6N_T0_VREF_34 Sch=led[0]
#set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L6P_T0_34 Sch=led[1]
```

修改为LVCMOS33.

![24.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/24.jpg)
![25.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/25.jpg)

Ctrl+S保存, 弹出警告页面, 选择OK即可. 保存约束文件页面选择保存到之前的约束文件, 点击OK.

![26.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/26.jpg)

再次Run Synthesis, 完成后在弹出的页面选择Run Implementation, 默认配置, 点击OK. 完成后在弹出的页面选择Generate Bitstream, 默认配置. 完成后在弹出的页面选择Cancel.

![27.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/27.jpg)

## 6. 运行
将PYNQ-Z2通过Micro-USB连接到电脑并开启电源. 开机后在Vivado左侧边栏选择Open Hardware Manager. 点击Open Target-Auto Connect, 连接开发板.

![28.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/28.jpg)

点击左侧边栏Program Device, 选择XILINX芯片进行烧录. 默认配置. 点击Program.
  
![29.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/29.jpg)

烧录完成后程序自动运行.

## 7. 保存至SD卡并运行

上一步中通过Vivado进行烧录的方法并不能在开发板中永久保存你的代码. 下面的方法可以永久保存代码并运行代码.

**连接网络**

将网线插入开发板与电脑(可以使用USB转RJ45转接线连接)并开机. 开机后在电脑控制面板-网络和 Internet-网络连接, 右键网口所在的网络适配器, 选择属性.

![30.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/30.jpg)

在IPv4中配置IP地址为192.168.2.x(x表示任选), 子网掩码为255.255.255.0, 点击确定.

![31.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/31.jpg)

打开电脑浏览器, 地址栏输入192.168.2.99:9090, 进入jupyter notebooks. 默认密码为xilinx

![32.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/32.jpg)

打开电脑文件资源管理器, 地址栏输入\\\pynq, 密码与用户名均为xilinx. 进入\xilinx\jupyter_notebooks并新建文件夹, 名称任意.

![33.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/33.jpg)

**导入Bitstream**

进入Tutorial.runs\impl_1, 将.bit文件拷贝至上一步新建的文件夹中.

![34.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/34.jpg)

返回浏览器, 进入上一步新建的文件夹, 点击New-Python3, 复制下面的代码:

```Python
from pynq import Bitstream

bit = Bitstream("Add_half.bit") # No overlay Tcl file required

bit.download()

bit.bitfile_name
```

![35.jpg](https://github.com/WangHaoZhe/PYNQ-Tutorial/blob/main/Resource/35.jpg)

其中Add_half.bit为你的Bitstream文件名. 保存, 点击运行, 等待开发板载入代码. 载入代码后jupyter notebooks进入不可用状态, 无法再进行控制. 若想停止代码运行并恢复jupyter notebooks, 点按开发板上的SRST并等待重启即可.  
之后每次重新上电, 运行该notebook即可, 无需重新烧录代码.
