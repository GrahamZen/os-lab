

## 环境依赖

### 系统环境

* windows(带wsl)或linux
* nasm
* gcc
* make
* bochs（可选）

## 镜像生成步骤

下面的操作均在src目录下完成

1. 全部生成且清除所有中间文件（不包括用户程序）

```shell
make all
```

2. 生成混合编程测试镜像

```shell
make testimg
```

3. 生成操作系统镜像

```shell
make img
```

4. 若只修改了\usrprog下的用户程序源代码，生成用户程序并放入操作系统镜像

```shell
make usrprog
```

5. 清除临时文件

```shell
make clean
```

### 注意事项

#### 测试镜像相关

* 测试镜像请不要使用Vmware的虚拟机打开，可以用Bochs等工具，镜像盘由bochs生成，不可删除，否则大小将发生变化(原来的镜像为1.44M)。每次生成镜像将对镜像文件重新写入。

#### bochs相关

* 若要使用bochs配置文件，在安装了bochs的Windows下直接双击配置文件（17338233.bxrc或test.bxrc）即可运行操作系统镜像，若提示未找到的错误，请将配置文件中的第十行设置为镜像的绝对路径。
* 要调试时请使用bochsdbg，并在弹出的'Bochs start menu'页面中点击load，选择配置文件（17338233.bxrc或test.bxrc），即可开始调试。调试过程可以参考实验报告的感想部分。

### 目录结构描述
./src
├── 17338233.bxrc   //bochs配置文件
├── Makefile   
├── interface.h     //交互utility库
├── mystring.h      //IO/字符串操作库
├── main.c          //shell主逻辑函数
├── kernel.asm      //内核程序
├── lib.asm         //汇编库
├── myos1.asm       //引导程序
├── os17338233.img  //操作系统目标镜像
├── test            //测试项目
│   ├── test.bxrc   //bochs配置文件
│   ├── Makefile    //混合编程测试
│   ├── str.c
│   ├── str.s       //str.o通过objdump命令生成的可读汇编文件
│   ├── test.asm    //主程序
│   ├── test.img    //测试目标镜像
│   └── testlib.asm //汇编库
└── usrprogram      //用户程序源文件
    ├── LU.asm      
    ├── LD.asm      
    ├── RU.asm      
    ├── RD.asm      
    ├── Makefile    
    ├── LU.com      //用户程序1
    ├── LD.com      //用户程序2
    ├── RU.com      //用户程序3
    ├── RD.com      //用户程序4
    └── header.inc  //头文件