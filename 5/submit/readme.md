# 环境依赖

## 系统环境

* windows(带wsl)或linux
* nasm
* gcc
* make
* vmware/bochs

# 镜像生成步骤

下面的操作均在src目录下完成

1. 全部生成且清除所有中间文件（不包括用户程序）

```shell
make/make  all
```

2. 若只修改了\usrprog下的用户程序源代码，生成用户程序并放入操作系统镜像（可以在启动了操作系统的情况下生成）

```shell
make usrprog
```

3. 清除临时文件

```shell
make clean
```

# 注意事项

## bochs相关

* 若要使用bochs配置文件，在安装了bochs的Windows下直接双击配置文件（17338233.bxrc或test.bxrc）即可运行操作系统镜像

# 目录结构描述
./src
├── Makefile
├── kernel.asm             //内核程序
├── lib
│   ├── Timer.asm          //时钟中断处理程序
│   ├── header.inc         //宏定义
│   ├── interface.h        //交互函数库
│   ├── lib.asm            //内核核心汇编库
│   ├── mystring.h         //IO/字符串操作库
│   ├── process.asm        //进程控制汇编库
│   └── process.h          //进程控制相关声明
├── main.c                 //shell主逻辑函数
├── myos1.asm              //引导程序
├── os17338233.img         //操作系统目标镜像
└── usrprogram             
    ├── LD.asm             
    ├── LD.com             
    ├── LU.asm             
    ├── LU.com             
    ├── Makefile           
    ├── RD.asm             
    ├── RD.com             
    ├── RU.asm             
    ├── RU.com             
    ├── header.inc         //宏定义
    ├── mystring.c         //用户程序库
    ├── mystring.h         //IO/字符串函数声明
    ├── syscall.asm        //系统调用库
    ├── test.c             //测试主程序
    └── test.com           //测试程序

2 directories, 28 files