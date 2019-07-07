# shell

标签: shell编程

---

# 为什么学习shell编程

 > shell脚本语言是实现linux/unix 系统管理机自动化运维所必备的重要工具，linux/unix系统的底层及基础应用软件的核心大部分涉及shell脚本的内容。每一个合格的linux系统管理员或运维工程师，都需要熟练的编写shell脚本语言，并能够阅读系统及各类软件附带的shell脚本内容

---

# 什么是shell
> shell是一个命令解释器，它在操作系统的最外层，负责直接与用户对话，把用户的输入解释给操作系统，并处理各种各样的操作系统的输出结果，输出到屏幕返回给用户，这种对话方式可以是交互式（从键盘输入命令，可以立即得到shell的回应），或非交互（执行脚本程序）的方式

## shell种类
交互式shell
非交互式shell
登录式shell
> /etc/profile -> /etc/profile.d/*.sh -> ~/.bash_profile -> ~/.bashrc -> /etc/bashrc

非登录式shell
> ~/.bashrc -> /etc/bashrc


## shell执行方式
> 解释器执行 （生成一个子shell执行）
添加执行权限（默认根据脚本第一行指定的解释器处理，如果没写以当前默认Shell解释器执行）
source 命令执行（以当前默认Shell解释器执行）

## 子shell
> 在父shell中执行一个shell脚本
在父shell中执行一条命令，在命令的末尾加上&
在父shell中执行一条命令，使用 ( ) 中执行
在父shell中执行带管道的命令


---

# shell应用场景
> * 系统基础配置
> * 部署应用服务
> * 配置应用服务
> * 部署业务代码
> * 应用服务备份
> * 日志分析
> * 监控应用服务



---
# shell基础
> * 命令补全和文件路径补全, 如果写错无法补全   table
> * 命令历史记忆功能 history
> * 别名功能 alias、unalias
> * 常用快捷键 ctrl+u,k,a,e,l,c,z,d,r
> * 前后台作业控制 bg,fg,jobs,screen
> * 输入输出重定向 > >> 2> 2>> < << &> cat
> * |  将前者命令的标准输出交给后者命令的输入
> * |&  将前者命令的错误输出交给后者命令的输入
> * 命令之间的关系
; 没有逻辑关系,无论分号前面的命令执行是否成功都执行后者命令
&&  前面执行成功, 则执行后者
||  前面执行不成功, 则执行后者

---
# shell通配符
 \* 匹配任意多个字符
? 匹配任意一个字符
[] 匹配括号中任意一个字符a-z,0-9,A-Z,a-Z
() 在子 shell 中执行(cd /boot;ls) (umask 077; touch file1000)
{}  集合 touch file{1..9}
\  转义符

# shell模式匹配
使用shopt 内置命令启用shell选项 (extglob) 则会识别几个扩展模式匹配运算符。
模式列表是由 | 分割

查看shell选项 extglob
```
shopt |grep extglob
```

启动shell选项 extglob
```
shopt -s extglob
```

关闭shell选项 extglob
```
shopt -u extglob
```
| 模式              |   说明           |
| ---------------- | -------------------- |
|  ?(pattern-list) | 匹配给定模式零或一次 |
| *(pattern-list)  | 匹配给定模式零次或多次 |
| +(pattern-list)  | 匹配给定模式一次或多次 |
| @(pattern-list)  | 匹配给定模式之一   |
| !(pattern-list)  |  匹配除了给定的模式  |

```
[root@mycentos6-clone ~]# ll
total 0
-rw-r--r-- 1 root root 0 Nov  1 07:02 123
-rw-r--r-- 1 root root 0 Nov  1 07:02 aaaac
-rw-r--r-- 1 root root 0 Nov  1 06:51 aaab
-rw-r--r-- 1 root root 0 Nov  1 07:02 aad
-rw-r--r-- 1 root root 0 Nov  1 07:02 aadg
-rw-r--r-- 1 root root 0 Nov  1 07:02 bb
-rw-r--r-- 1 root root 0 Nov  1 07:02 c
 [root@mycentos6-clone ~]# ls !(c|bb|123)
aaaac  aaab  aad  aadg
[root@mycentos6-clone ~]# rm !(c|bb|123) -f
[root@mycentos6-clone ~]# ll
total 0
-rw-r--r-- 1 root root 0 Nov  1 07:02 123
-rw-r--r-- 1 root root 0 Nov  1 07:02 bb
-rw-r--r-- 1 root root 0 Nov  1 07:02 c
```

# 单引号-双引号-没有引号

## 引号和不加引号的区别1
```shell
[root@oldboytx ~]# touch a b
[root@oldboytx ~]# ll
total 0
-rw-r--r--. 1 root root 0 Jun 25 16:25 a
-rw-r--r--. 1 root root 0 Jun 25 16:25 b
[root@oldboytx ~]# touch "a b"
[root@oldboytx ~]# ll
total 0
-rw-r--r--. 1 root root 0 Jun 25 16:25 a
-rw-r--r--. 1 root root 0 Jun 25 16:25 a b
-rw-r--r--. 1 root root 0 Jun 25 16:25 b
```

## 引号和不加引号的区别2：
```
[root@oldboy36 tmp]# ll
总用量 0
-rw-r--r-- 1 root root 0 6月  25 19:36 ?
-rw-r--r-- 1 root root 0 6月  25 19:32 *
-rw-r--r-- 1 root root 0 6月  25 19:33 aa
-rw-r--r-- 1 root root 0 6月  25 19:33 abc
-rw-r--r-- 1 root root 0 6月  25 19:33 b
[root@oldboy36 tmp]# ll ?
-rw-r--r-- 1 root root 0 6月  25 19:36 ?
-rw-r--r-- 1 root root 0 6月  25 19:32 *
-rw-r--r-- 1 root root 0 6月  25 19:33 b
[root@oldboy36 tmp]# ll "?"
-rw-r--r-- 1 root root 0 6月  25 19:36 ?
[root@oldboy36 tmp]# ll *
-rw-r--r-- 1 root root 0 6月  25 19:36 ?
-rw-r--r-- 1 root root 0 6月  25 19:32 *
-rw-r--r-- 1 root root 0 6月  25 19:33 aa
-rw-r--r-- 1 root root 0 6月  25 19:33 abc
-rw-r--r-- 1 root root 0 6月  25 19:33 b
[root@oldboy36 tmp]# ll "*"
-rw-r--r-- 1 root root 0 6月  25 19:32 *
```


## 双引号和单引号区别1：
关于\$
```
[root@oldboytx ~]# echo "$LANG"
en_US.UTF-8
[root@oldboytx ~]# echo '$LANG'
$LANG
```

## 双引号和单引号区别2：
关于\`\`
```
[root@oldboytx ~]# echo "`which awk`"
/bin/awk
[root@oldboytx ~]# echo '`which awk`'
`which awk`
```

## 双引号和单引号区别3：
关于!
```
[root@oldboytx ~]# echo '!ll'
!ll
[root@oldboytx ~]# echo "!ll"
echo "ll /bin/awk "
ll /bin/awk 
```


---
# shell常用命令与工具
## cat
```shell
cat<<-EOF
    1.[install lamp]
    2.[install lnmp]
    3.[exit]
EOF
```

```
cat >> /etc/profile <<'EOF'
$PATH
EOF
```


## eval
   > * 执行参数做为shell命令
## tee
> * 从标准输入读取写到出和文件
> * -a 追加到文件

## printf
```shell
a=1
b=2
printf "a=%d,b=%d\n" $a $b
```

## :
空命令

## echo
### 字体颜色
```shell
echo -e "\033[30m 黑色字oldboy trainning \033[0m"
echo -e "\033[31m 红色字oldboy trainning \033[0m"
echo -e "\033[32m 绿色字oldboy trainning \033[0m"
echo -e "\033[33m 黄色字oldboy trainning \033[0m"
echo -e "\033[34m 蓝色字oldboy trainning \033[0m"
echo -e "\033[35m 紫色字oldboy trainning \033[0m"
echo -e "\033[36m 天蓝字oldboy trainning \033[0m"
echo -e "\033[37m 白色字oldboy trainning \033[0m"
```

### 背景颜色
```shell
echo -e "\033[40;37m 黑底白字 welcome to old1boy\033[0m"
echo -e "\033[41;37m 红底白字 welcome to old2boy\033[0m"
echo -e "\033[42;37m 绿底白字 welcome to old3boy\033[0m"
echo -e "\033[43;37m 黄底白字 welcome to old4boy\033[0m"
echo -e "\033[44;37m 蓝底白字 welcome to old5boy\033[0m"
echo -e "\033[45;37m 紫底白字 welcome to old6boy\033[0m"
echo -e "\033[46;37m 天蓝白字 welcome to old7boy\033[0m"
echo -e "\033[47;30m 白底黑字 welcome to old8boy\033[0m"
```

## trap
> trap [-lp] [[arg] signal_spec ...]
-l   # 打印编号1-64编号信号名称
arg   # 捕获信号后执行的命令或者函数
signal_spec   # 信号名或编号

trap "" 2    # 不指定arg就不做任何操作，后面也可以写多个信号，以空格分隔
```
trap ':' INT EXIT TSTP TERM HUP
```

## mkpasswd  openssl
```
mkpasswd -l 10 -c 3 -C 3 -d 3
openssl rand -base64 80
```

## basename  dirname
```
basename /etc/init.d/network 
network

dirname /etc/init.d/network 
/etc/init.d

```

---
# shell脚本
## 脚本第一行
指定脚本解释器
```shell
#!/bin/sh
#!/bin/bash
#! /usr/bin/awk
#! /bin/sed
#! /usr/bin/tclsh
#! /usr/bin/expect
#! /usr/bin/perl
#! /usr/bin/env python
```

## 脚本注释
单行注释 #
多行注释
```shell
<<'EOF'
语句1
语句2
...
语句n
EOF
```

## 脚本构成
主脚本    
模块（子脚本）
> * 主脚本 调用模块
> * 模块中 有   函数
> * 先调用模块，再调用函数

## 脚本执行参数
> * -x  将执行的脚本内容及输出显示到屏幕上
> * -n 不会执行该脚本，仅查询脚本语法是否有问题，并给出错误提示。
> * -v  在执行脚本时，先将脚本的内容输出到屏幕上然后执行脚本，如果有错误，也会给出错误提示

---
# 变量
## 变量类型
### 自定义变量
1.定义变量变量名=变量值 ,不允许数字命名, 不能使用横岗命名
2.引用变量$变量名 或 ${变量名}
3.查看变量echo $变量名 set显示所有变量,包括自定义变量和环境变量
4.取消变量unset 变量名 作用范围:仅在当前 shell 中有效

### 系统环境变量
1.定义环境变量 export export 变量 ,将自定义变量转换成环境变量
2.引用环境变量 $变量名 或 ${变量名}
3.查看环境变量 echo $变量名 env |grep Name
4.取消环境变量 unset 变量名
5.作用范围在当前shell和子shell有效

### 位置参数变量
\$1 
\$2 
\$3
\${10}

### 预先定义变量
\$0 脚本文件名
\$* 所有的参数 
$@  所有的参数
```shell
set  "I am" handsome oldboy
for i in "$*" ; do echo $i; done
for i in "$@" ; do echo $i; done
```
\$#  参数的个数
$$  当前进程的 PID
$! 上一个后台进程的 PID
$? 上一个命令的返回值 0 表示成功
$_   在此之前执行的命令或脚本的最后一个参数

## 变量赋值方式

1.显式赋值(变量名=变量值)
2.read从键盘读入变量值
```shell
read -p "请输入数字:"
echo $REPLY
```

3.定义或引用变量时注意事项： " "弱引用 ' '强引用
4.``命令替换等价于$()反引号中的shell命令会被先执行

## 变量子串

变量长度   
```shell
${#string}
```

从前往后删除变量内容
```shell
${string#substring} 从变量$string开头开始删除最短匹配$substring子串
${string##substring} 从变量$string开头开始删除最长匹配$substring子串
```

从后往前删除变量内容
```shell
${string%substring} 从变量$string结尾开始删除最短匹配$substring子串
${string%%substring} 从变量$string结尾开始删除最长匹配$substring子串
```

索引及切片
```shell
${string:position} 在$string中，从$position个开始提取子串（从0开始计数）
${string:position:length} 在$string中，从位置$position之后开始提取长度为$length的子串
```

变量内容替换
```
${parameter/pattern/string} 使用string代替第一个匹配的pattern
${parameter//pattern/string} 使用string代替所有的pattern
${parameter/#pattern/string} 从开头匹配string变量中的pattern, 用string替换匹配的pattern
${parameter/%pattern/string} 从结尾匹配string变量中的pattern, 用string替换匹配的pattern
```

变量替代
```
${value:-word} 如果变量名存在且非null，则返回变量的值。否则，返回word字符串 用途：如果变量未定义，则返回备用的值
${value:=word} 如果变量名存在且非null，则返回变量值。否则，设置这个变量值为word 并返回其值 用途：如果变量未定义，则设置变量为默认值，并返回默认值
${value:?"not defined"} 如果变量名存在且非null，则返回变量的值。否则显示变量名：message, 并退出当前的命令或者脚本 用途：用于捕捉由于变量未定义而导致的错误，并退出程序
${value:+word} 如果变量名存在且非null，则返回word。 否则返回null 用途：测试变量是否存在
```

## 变量作用域
### 环境变量 
> 使用 export 定义,在当前shell及其子shell中生效

### 本地变量
> 仅在当前shell中生效

### 局部变量 
> 使用 local 定义 ，仅在函数中生效

---
# 表达式
## 运算符
> ++  -- 自增  自减
+  -  !  ~ 正号  负号  逻辑取反  按位取反
*  /  % 乘  除   取余
+  - 加  减
<  <=  >  >= 比较符号
==   != 等于   不等于
<<   >> 左移   右移
&   |   ^ 按位与   按位或   按位异或
&&   ||   逻辑与    逻辑或
?: 条件表达式
=  +=   -=  *=  /=  %=  &=    |=   ^=   <<=   >>=  各种赋值运算符
**  幂运算

## 算术运算（整数）
| [] test  | (())  [[]]    |
| -------- | ------------- |
| -eq      | ==  或 =      |
| -ne      | !=            |
| -gt      | >             |
| -ge      | \>=           |
| -lt      | <             |
| -le      | <=            |

## 表达式符号
[ ]
[[ ]]
(( )) 仅用于整数
```
((1<2&&1>3))
((1<2||1>3))
```

## 算术运算（小数）
```
# a=1.2
# b=3
# echo "$a<$b" |bc
1
# echo "$a>$b" |bc
0
# echo "$a+$b" |bc
4.2
# x=$(echo "$a+$b" |bc)
# echo $x
4.2
```

## 逻辑运算
|  []  test   |  [[]]     |   说明        |
| ----------- | --------- | ------------- |
| -a          | &&        | and 与        |
| -o          | \|\|      | or  或        |
| !           | !         | not 非        |

## 字符串运算
```
-z "str" 若串长度为0则真，-z 可以理解为zero
-n "str"  若串长度不为0则真，-n可以理解为no zero
"str1"  =  "str2" 若串1等于串2则真，可以使用  "==" 代替  "="
"str1"  !=  "str2" 若串1不等于串2则真
"str1" =~ "pattern" 字符串匹配成功则为真 [[ ]]
```

## 文件测试
```
[ -f 文件 ] 文件存在且为普通文件则真，条件表达式成立
[ -d 目录 ] 目录存在且为目录文件则真，条件表达式成立
[ -s 文件 ] 文件存在且文件大小不为0则真，条件表达式成立
[ -e 文件 ] 文件存在则真，只要有文件就行
[ -r 文件 ] 文件存在且可读则真，条件表达式成立
[ -w 文件 ] 文件存在且可写则真，条件表达式成立
[ -L 文件 ] 文件存在且为链接文件则真，条件表达式成立
[ f1 -nt f2 ] 文件f1比文件f2新则真，条件表达式成立
[ f1 -ot f2 ] 文件f1比文件f2旧则真，条件表达式成立
```


---
# 流程控制
顺序  选择  循环
## 条件表达式 
> * 条件表达式的值只有真（非0 | 非空 | 条件成立 | \$?为0（此条shell特有））、假（0 | 空 | 条件不成立 | \$?不为0（此条shell特有））
此规则适用于所有的计算机高级语言

算术运算
逻辑运算
Linux命令

## 选择（分支）
### if
```
if 条件表达式;then
  命令
fi
```

```
#/bin/bash
http="ss -lntup|grep nginx &> /dev/null"
if eval $http
then
  echo 1
else
  echo 0
fi
```


流程图
```flow
st=>start: Start
op=>operation: 命令1
cond=>condition: 条件表达式为真？
e=>end

st->cond
cond(yes)->op->e
cond(no)->e
```

### if else
```
if 条件表达式;then
  命令1
else
  命令2
fi
```

```flow
st=>start: Start
op=>operation: 命令1
op2=>operation: 命令2
cond=>condition: 条件表达式为真？
e=>end

st->cond
cond(yes)->op->e
cond(no)->op2->e
```



### if elif else
```
if 条件表达式;then
  命令1
elif 条件表达式2;then
  命令2
else
  命令3
fi
```

```flow
st=>start: Start
op=>operation: 命令1
op2=>operation: 命令2
op3=>operation: 命令3
cond=>condition: 条件表达式为真？
cond2=>condition: 条件表达式2为真？
e=>end

st->cond
cond(yes)->op->e
cond(no)->cond2
cond2(yes)->op2->e
cond2(no)->op3->e
```


### case
```
case 模式名 in
  模式1)
    命令1
    ;;
  模式2)
    命令2
    ;;
  模式3)
    命令3
    ;;
  *)
    其它命令
esac
```

```flow
st=>start: Start
io=>inputoutput: 模式名
op=>operation: 命令1
op2=>operation: 命令2
op3=>operation: 命令3
op4=>operation: 其它命令
cond=>condition: 模式名==模式1 ？
cond2=>condition: 模式名==模式2 ？
cond3=>condition: 模式名==模式3 ？
e=>end

st->io->cond
cond(yes)->op->e
cond(no)->cond2
cond2(yes)->op2->e
cond2(no)->cond3
cond3(yes)->op3->e
cond3(no)->op4->e
```


## 循环
### for
```
for 变量名 in 取值列表
do
  命令
done


for ((expr1;expr2;expr3))
do
  命令
done
```
> expr1  初值
expr2  终值
expr3  步长值

```flow
st=>start: Start
op=>operation: 命令
op1=>operation: expr1
op3=>operation: expr3
cond=>condition: expr2为真 ？
e=>end

st->op1->cond
cond(yes)->op->op3->cond
cond(no)->e
```

IFS
```
#!/bin/bash
data='a,b,c,d'
IFS=,
for i in $data;do
  echo $i
done
```

### while
```
while 条件表达式
do
  命令
done
```

```flow
st=>start: Start
op=>operation: 命令
cond=>condition: 条件表达式为真 ？
e=>end

st->cond
cond(yes)->op->cond
cond(no)->e
```

把a.txt文件中的内容倒腾到b.txt文件中

cat a.txt 
1
2
3
4
5
6
7
8
9
10

cat b.txt 
10
9
8
7
6
5
4
3
2
1

```
#!/bin/bash
touch b.txt

while [ -n "$(cat a.txt)" ]
do
	if [ -z "$(cat b.txt)" ];then
		head -1 a.txt > b.txt
        else
		sed -i "1i `head -1 a.txt`" b.txt
        fi
	sed -i 1d a.txt

done
```

while read
```
while read -p "请输入："
do
  if [[ $REPLY =~ ^[0-9]+$ ]];then
    echo "输出：$((REPLY*=${REPLY}00))"
  elif [[ "$REPLY" = "q" ]];then
    break
  fi
done
```


while读取文件三种方式
```
1、
cat ./a.txt | while read LINE
do
  echo $LINE
done

2、
while read LINE
do
  echo $LINE
done < ./a.txt

3、
exec < ./a.txt
while read LINE
do
  echo $LINE
done
```


### break
break n 表示跳出循环的层数
省略n 表示跳出整个循环

### continue
continue n  退到第n层继续循环
省略n  表示跳出本次循环，继续下一次循环

### select
```
#PS3=[$USER@$0]#
select VAR in var1 var2 quit
do
  case $VAR in
  var1)
    cmd1
    ;;
  var2)
    cmd2
    ;;
  quit)
    break
  esac
done
```


---
# 函数
## 函数定义
```
function 函数名(){
  命令
}
```

## 函数参数
\$1 
\$2
\$3
\$#
\$*
\$@

## 函数调用
> 函数名  参数1  参数2  参数3

## 函数返回
> * 返回数字作为函数执行状态  返回给$?  取值范围 0-255 （使用 return）
> * 返回数字作为函数执行结果 （使用 echo）
> * 返回字符串，作为函数执行结果 （使用 echo）

## 系统函数库
系统函数库
> /etc/init.d/functions

action函数
> action "xxxxx" /bin/true
action "xxxxx" /bin/false

## 功能函数库
```
# 脚本初始化
function scripts_init(){
  prog=`basename $0 .sh`
  LockFile=/var/lock/subsys/${prog}.lock  # 使用锁文件
  LogFile=/var/log/${prog}.log  # 脚本记录日志
  PidFile=/var/run/${prog}.pid  # 记录进程号，可以管理脚本

  [ -f $LockFile ] && echo "There $LockFile is exist!!" && exit 1 ||touch $LockFile
  [ ! -f $LogFile ] && touch $LogFile
  [ -f $PidFile ] && echo "There $PidFile is exist!!" && exit 2|| echo $$ > $PidFile
}

# 记录日志
function writelog(){
  Date=$(date "+%F_%T")
  ShellName=`basename $0`
  Info=$1
  echo "$Date : ${ShellName} : ${Info}" >> ${LogFile}
}

# 脚本退出扫尾
function closeout(){
  [ -f $LockFile ] && rm -f $LockFile 
  [ -f $PidFile ]&& rm -f $PidFile
}

# 判断输入是整数
function int_judge(){
  fun_a=$1
  expr $fun_a + 1 &>/dev/null
  RETVAL=$?
  return $RETVAL
}

# 判断输入非空
function input_judge(){
  RETVAL=0
  fun_a=$1
  [ ${#fun_a} -eq 0 ]&& RETVAL=1
  return $RETVAL
}
```


---
# 数组
> * 数组名代表首地址

下标是从0开始的整数

## 普通数组（索引数组）
### 定义数组
```
array=(a b c)
```

### 获取所有元素
```
${array[*]}
```

### 获取元素下标
```
${!a[@]}
```

### 获取数组长度
```
${#array[*]}
```

### 获取一个元素的长度
```
${#name[0]}
```


### 获取第一个元素
```
${array[0]}
```

### 获取第二个元素
```
${array[1]}
```

### 获取多个元素
```
array=(1 2 3 4 5)
echo ${array[@]:1}
2 3 4 5

#array[@]:下标:截取元素个数
echo ${array[@]:1:3}
2 3 4
```


### 添加元素
```
array[3]=d
```

### 添加多个元素
```
array+=(e f g)
```

### 删除第一个元素
```
unset array[0]    # 删除会保留元素下标
```

### 删除数组
```
unset array
```

### 数组切片
```
${name[4]:0:7}
```


## 关联数组
关联数组的下标是字符串

### 定义关联数组
```
declare -A M
```

### 关联数组赋值
```
M=([a]=11 [b]=22)
```

### 获取关联数组元素
```
echo ${M[a]}
11
```

### 获取关联数组元素个数
```
echo ${#M[@]}
2
```

### 获取关联数组下标
```
echo ${!M[*]}
a b
```

### 获取关联数组所有元素
```
echo ${M[@]}
11 22
```

### 添加元素
```
M[c]=33
```

### 添加多个元素
```
M+=([d]=33 [e]=44)
```



