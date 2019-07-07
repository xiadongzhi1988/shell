

# 基础

## 计算器
calc.sh 
```
#!/bin/bash
echo "$*=$(($*))"
```

## 打印行号
```
sed -n '$=' /etc/passwd
```



## 按照时间生成文件`2018-05-22.log`将每天的磁盘使用状态写入到对应日期的文件
## 统计Nginx日志中每个IP的访问量有多少,日志如下
```
  
`192.168.56.1 - - [21/May/2018:20:44:06 -0400] "GET /index.html HTTP/1.0" 404 169 "-" "ApacheBench/2.3" "-"/code/index.html`
  
```


## 写一个脚本计算一下Linux系统所有进程占用内存大小的和。

## 在/backup下创建10个.txt的文件，找到/backup目录下所有后缀名为.txt的文件
       1.批量修改txt为txt.bak
       2.把所有的.bak文件打包压缩为123.tar.gz
       3.批量还原文件的名字，及把增加的.bak再删除


## 输入两个整数计算这两个整数的相加，相减，相乘，相除，求余的结果


## 把一个文本文档的前五行中包含字母的行删除掉，同时把6到10行中的全部字母删除掉


## 写一个shell脚本来看看你使用最多的命令是哪些，列出你最常用的命令top10

# if
## 将下面的条件表达式改写为if条件语句
```
[ -f /etc/hosts ] && echo !
```



## 打印下面这句话中字母数小于5的单词	I am teacher I am 18

## **比较整数大小**
综合实战案例：开发shell脚本分别实现以脚本传参以及read读入的方式比较2个整数大小。注意：一共是开发2个脚本。



## 写个shell，看看你的linux系统中是否有自定义用户（普通用户），若是有，一共有几个？

## 猜数字


## 打印出 系统版本 内核版本平台 虚拟平台 静态主机名 eth0网卡IP地址 lo网卡IP地址 当前外网IP地址


## 根据不同的操作系统安装不同的源

## 监控CPU使用率
```
#!/bin/bash
DATE=$(date +%F" "%T)
IP=$(hostname -I |awk '{print $1}')
MAIL="1226032602@qq.com"
US=$(vmstat |awk 'NR==3{print $13}')
SY=$(vmstat |awk 'NR==3{print $14}')
ID=$(vmstat |awk 'NR==3{print $15}')
WAIT=$(vmstat |awk 'NR==3{print $16}')
USE=$((US+SY))
#echo "USE=$USE"
if ((USE>60));then
  echo "
  Date: $DATE
  Host: $IP
  Problem: CPU utilization $USE
  " |mail -s "CPU WARN" $MAIL &> /dev/null
fi
```


## 监控内存使用率
```
#!/bin/bash
DATE=$(date +%F" "%T)
IP=$(hostname -I |awk '{print $1}')
MAIL="1226032602@qq.com"
FREE=$(free -m |awk '/Mem/{print $NF}')
#echo "FREE=$FREE"
if ((FREE<1024));then
  echo "
  Date: $DATE
  Host: $IP
  Problem: Memory Free=$FREE
  " |mail -s "Memory WARN" $MAIL &> /dev/null
fi
```


## 磁盘使用率
```
#!/bin/bash
DATE=$(date +%F" "%T)
IP=$(hostname -I |awk '{print $1}')
MAIL="1226032602@qq.com"
TOTAL=$(fdisk -l |awk -F'[: ]+' '/^Disk \/dev/{printf "%s=%sG",$2,$3}')
PART_USE="$(df -h |awk 'BEGIN{OFS="="}/^\/dev/{print $1,int($5),$6}')"
for i in $PART_USE;do
  PART=$(echo $i |awk -F "=" '{print $1}')
  USE=$(echo $i |awk -F "=" '{print $2}')
  MOUNT=$(echo $i |awk -F "=" '{print $3}')
  if ((USE>2));then
    echo "
    Date: $DATE
    Host: $IP
    Total: $TOTAL
    Problem: $PART USE $USE $MOUNT
    " |mail -s "Disk WARN" $MAIL &> /dev/null
  fi
done
```





## 检测软件包是否安装
```
#!/bin/bash
function check_package(){
  (($#!=1)) && { 
    echo $"Usage: sh $0 package" 
    return 2
  }
  package="$1"
  if rpm -q $package &>/dev/null;then
    echo "$package is already installed"
    return 0
  else
    echo "$package is not install"
    return 1
  fi

}
check_package $1
```


## 检测服务状态
```
if ps -ef |grep -v grep |grep nginx &> /dev/null && ss -lntup |grep nginx &> /dev/null;then
  echo "nginx is running"
else
  echo "nginx is not running"
fi
```


```
SERVER_PROCESS="ps -ef |grep -v grep |grep nginx &> /dev/null"
SERVER_PORT="ss -lntup |grep nginx &> /dev/null"
if eval $SERVER_PROCESS && eval $SERVER_PORT;then
  echo "nginx is running"
else
  echo "nginx is not running"
fi
```



```
SERVER="nginx"
SERVER_PROCESS="ps -ef |grep -v grep |grep $SERVER &> /dev/null"
SERVER_PORT="ss -lntup |grep $SERVER &> /dev/null"
if eval $SERVER_PROCESS && eval $SERVER_PORT;then
  echo "$SERVER is running"
else
  echo "$SERVER is not running"
fi
```


```
. /etc/init.d/functions
function service_status(){
if (($#!=1));then
  echo $"Usage: sh $0 servicename" && exit 1
else
  SERVER="$1"
fi
SERVER_PROCESS="ps -ef |grep -v grep |grep $SERVER &> /dev/null"
SERVER_PORT="ss -lntup |grep $SERVER &> /dev/null"
if eval $SERVER_PROCESS && eval $SERVER_PORT;then
  action "$SERVER is running" /bin/true
else
  action "$SERVER is not running" /bin/false

fi
}
service_status $1
```


```
status nginx
```



## 检测url可用性
```
#!/bin/bash
function check_url(){
  if (($#!=1));then
    echo $"Usage: sh $0 www.baidu.com" && exit 1
  fi
  URL="$1"
  HTTP_CODE=$(curl -o /dev/null --connect-timeout 3  -s -w "%{http_code}" $URL)
  if ((HTTP_CODE==200));then
    echo "$URL access successful"
  else
    echo "$URL access failed"
  fi
}
check_url $1
```



## 按单词出现频率降序排序！
## 按字母出现频率降序排序！
```
the squid project provides a number of resources toassist users design,implement and support squid installations. Please browsethe documentation and support sections for more infomation
```


## 使用ps aux查看系统进程发现有100多个test.sh脚本正在运行，如何杀死所有的test.sh

## 写一个猜数字脚本，当用户输入的数字和预设数字（随机生成一个0-100的数字）一样时，直接退出，否则让用户一直输入，并且提示用户的数字比语塞数字大或者小

## 用Shell实现，把一个文本文档中只有一个数字的行给打印出来
```
egrep '^[^0-9]*[0-9][^0-9]*$' test.txt
```


## 写一个Shell脚本通过curl命令返回的状态码来判定所访问的网站是否正常，比如当前状态码200，才算正常




# case
## 打印一个菜单如下，然后用循环加case语句输出用户输入菜单选项的结果
h 显示命令帮助
f 显示登陆信息
d 显示磁盘挂载
m 查看内存使用
u 查看系统负载
q 退出程序



# for
## 计算1到100的和
```
for i in {1..100};do
  ((sum+=i))
done
echo $sum
```


## 编写一个脚本，计算100以内所有能被3整除数字的和

## **扫描网络内存活主机案例**
写一个Shell脚本，判断10.0.0.0/24网络里，当前在线的IP有哪些？
解答：

ip地址在线计算器
**http://help.bitscn.com/ip/**

[root@web01 scripts]# cat oldboy_19_5_1.sh
```
#!/bin/sh
CMD="ping -W 2 -c 2"
Ip="10.0.0."
for n in $(seq 254)
do 
{
        $CMD $Ip$n &> /dev/null
        if [ $? -eq 0 ];then
           echo "$Ip$n is ok"
        fi
}&
done
```





[root@web01 shell]# cat 4.sh 
```
#!/bin/bash
. /etc/init.d/functions
CMD="ping -c 2"
IP="10.0.0."
for n in {1..254}
do
  {
    $CMD ${IP}$n &> /dev/null
        if [ $? -eq 0 ]
          then
      action "${IP}$n is ok" /bin/true
        fi
  }&
done
```



```
#!/bin/bash

SUBNET="192.168.8.0"
[ -f ping_ok.txt ] && rm ping_ok.txt -f
[ -f ping_fail.txt ] && rm ping_fail.txt -f
for IP in ${SUBNET%?}{1..254};do
{
  NUM=0
  while ((NUM<3));do
    if ping -c 1 $IP &> /dev/null;then
      echo $IP  >> ping_ok.txt
      break
    else
      ((NUM++))
      if ((NUM==3));then
        echo $IP  >> ping_fail.txt
      fi
    fi
  done
}&
done
wait
echo ping finish...
```




[root@web01 scripts]# cat oldboy_19_5_3.sh
#!/bin/sh
CMD="nmap -sP"
Ip="10.0.0.0/24"
$CMD $Ip|awk '/Nmap scan report for/ {print $NF}'
[root@web01 scripts]# sh oldboy_19_5_3.sh
(10.0.0.1)
(10.0.0.2)
(10.0.0.8)

[root@db03 oldboy]#** ****nmap -sn 10.0.0.0/24**
Starting Nmap 5.51 ( http://nmap.org ) at 2017-04-01 15:45 CST
Nmap scan report for 10.0.0.1
Host is up (0.00024s latency).
MAC Address: 00:50:56:C0:00:08 (VMware)
Nmap scan report for 10.0.0.2
Host is up (0.00020s latency).
MAC Address: 00:50:56:E7:8A:4B (VMware)
Nmap scan report for db03 (10.0.0.53)
Host is up.
Nmap done: 256 IP addresses (3 hosts up) scanned in 11.56 seconds





[root@db03 scripts]# cat ping.sh 
#!/bin/bash

for i in 10.0.0.{1..254}
do
  **ping -c 1 -w 1 $i &> /dev/null && echo "$i is ok!" &**
done



[root@db03 scripts]# cat ping.sh      
#!/bin/bash
ip=$1
for i in ${ip}.{1..254}
do
  ping -c 1 -w 1 $i &> /dev/null && echo "$i is ok!" &
done

[root@db03 scripts]# sh ping.sh 10.0.0
10.0.0.2 is ok!
10.0.0.1 is ok!
10.0.0.53 is ok!


```
[root@db03 scripts]# ipcalc -mpnb 10.0.0.0/24
NETMASK=255.255.255.0
PREFIX=24
BROADCAST=10.0.0.255
NETWORK=10.0.0.0
```



## **MySQL****数据库分库备份**
请实现对MySQL数据库进行分库备份，用脚本实现。
解答：

```
mysql -uroot -poldboy123 -e "show databases;" 2> /dev/null |egrep -v '_schema|Database'
```


[root@db03 scripts]# cat mysqlbak.sh 
```
#!/bin/bash
mysqlUser=root
mysqlPass=oldboy123
exDataBase='_schema|Database'
dataBase=`mysql -uroot -poldboy123 -e "show databases;" 2> /dev/null |egrep -v '_schema|Database'`
Time=`date +%F`
for i in $dataBase
do
  mysqldump -u$mysqlUser -p$mysqlPass -F --single-transaction  -R -B $i 2> /dev/null |gzip > /tmp/$i-${Time}.sql.gz
done
```


## **MySQL****数据库分库分表备份**
如何实现对MySQL数据库进行分库加分表备份，请用脚本实现。
解答：

```
#!/bin/bash
source /etc/profile
mysqlUser=root
mysqlPass=`cat /etc/myp`
exDataBase='_schema|Database'
dataBase=`mysql -u$mysqlUser -p$mysqlPass -e "show databases;" 2> /dev/null |egrep -v "$exDataBase"`
Time=`date +%F`
backDir=/application/backup/$Time
[ -d $backDir ] || mkdir -p $backDir
mysqladmin -u$mysqlUser -p$mysqlPass flush-logs 2> /dev/null
for DB in $dataBase
do
  mkdir -p $backDir/$i
  tablelist=`mysql -u$mysqlUser -p$mysqlPass -e "show tables from $i" 2> /dev/null |grep -v Tables_in`
  for TABLE in $tablelist
  do
    mysqldump -u$mysqlUser -p$mysqlPass --master-data=2 --single-transaction --triggers -R $DB $TABLE 2> /dev/null |gzip > $backDir/$i/$i-$t-${Time}.sql.gz
  done
done
```



## 打印99乘法表




# for-if综合
## **批量创建特殊要求用户**
批量创建10个系统帐号oldboy01-oldboy10并设置密码（密码为随机数，要求字符和数字等混合）。

解答：
方法1：
```
echo oldboy{01..10}|xargs -n1|sed -r 's#(.*)#pass=`echo \1 |md5sum |cut -c1-8` \&\& useradd \1 \&\& echo $pass |passwd --stdin \1 \&\& echo \1 $pass >>/tmp/user_passwd#g'|bash
```

方法2：
```
#!/bin/bash
for n in {01..10}
do
        useradd oldboy$n
        pass=`echo $RANDOM|md5sum|cut -c 2-10`
        echo "$pass"|passwd --stdin oldboy$n
        echo -e "oldboy$n $pass" >> /tmp/user.txt
done
```


方法3：
```
#!/bin/bash
. /etc/init.d/functions
RETVAL=0
for n in {11..15}
do
        useradd oldboy$n &>/dev/null
        RETVAL1=$?
        pass=`echo $RANDOM|md5sum|cut -c 2-10`
        echo "$pass"|passwd --stdin oldboy$n &>/dev/null && \
        echo -e "oldboy$n $pass" >> /tmp/user.txt
        RETVAL2=$?
        if [ $RETVAL1 -eq 0 -a $RETVAL2 -eq 0 ]
                then
                   action "add user is ok" /bin/true
                else
                   action "add user is fail" /bin/false
    fi
done
```


```
#!/bin/bash
userfile=/tmp/user_password.txt
for i in {1..10}
do
  useradd oldboy$i
  pass=$(uuidgen |sed 's#-##g'|tr "0-9" "a-j"|cut -c 1-10)
  echo oldboy${i}:${pass} >> $userfile
  chpasswd < $userfile
done
```



```
#!/bin/bash
. /etc/init.d/functions
RETVAL=0
for n in {16..20}
do
        useradd oldboy$n &>/dev/null
        RETVAL1=$?
        pass=`echo $RANDOM|md5sum|cut -c 2-10`
        echo -e "oldboy${n}:$pass" >> /tmp/user1.txt
        chpasswd < /tmp/user1.txt &>/dev/null
        RETVAL2=$?
        if [ $RETVAL1 -eq 0 -a $RETVAL2 -eq 0 ]
                then
                   action "add user is ok" /bin/true
                else
                   action "add user is fail" /bin/false
    fi
done
```



create_user.sh
```
#!/bin/bash

. /etc/init.d/functions
. ./colorString

USER_FILE=user.txt
PREUSER="wuxing"
PASS="123456"
if (($#!=1));then
  echo $"Usage: sh $0 userpre" && exit 1
else
  PREUSER="$1"
fi
for USER in ${PREUSER}{1..3};do
  if ! id $USER &> /dev/null;then
    PASS="$(openssl rand -base64 20 |cut -c1-10)"
    useradd $USER && echo $PASS |passwd --stdin $USER &> /dev/null
    echo -e "${USER}\t${PASS}" >> user.txt
    RETVAL=$?
    if [ $RETVAL -eq 0 ] ;then
      action "create $USER success..." /bin/true
    else
      action "create $USER faild!" /bin/false
    fi
  else
    echo_color yellow "$USER is exist!"
  fi

done
```


## 查找包含关键字的文件
```
#!/bin/bash
FIND_DIR="$1"
KEY="$2"
for FILE in $(find $FIND_DIR -type f);do
  if grep "$KEY" $FILE &> /dev/null;then
     echo $FILE
  fi
done
```



# while
## 使用while循环使1加到100

## 文件a内容aaa\nbbb\nccc  文件b内容aaaa\nddd\nbbb  使用任意程序语言写一个小程序实现打印出仅在文件a中出现的行

```
cat a 
aaa
bbb
ccc

cat b 
aaaa
ddd
bbb

cat 1.sh 
#!/bin/bash
while read line;do
  if grep -w $line a &> /dev/null && ! grep -w $line b &> /dev/null ;then
    echo $line
  fi
done < a
```



## 输入5个100以下的数字,统计和,最小值和最大值
```
#!/bin/bash
COUNT=0
while ((COUNT<5));do
  read -p "please input a num (1-100): " NUM
  if [[ ! $NUM =~ ^[0-9]+$ ]];then
    echo "input must num"
    exit 1
  elif [ $NUM -gt 100 ];then
    echo "input must 1-100"
    exit 1
  fi
  if ((COUNT==0));then
    MIN=$NUM
    MAX=$NUM
  fi
  SUM=$(($SUM+$NUM))
  ((NUM<MIN)) && MIN=$NUM
  ((NUM>MAX)) && MAX=$NUM
  let COUNT++
done
echo "SUM: $SUM"
echo "MIN: $MIN"
```
echo "MAX: $MAX"








# 函数
## 求几个数中的最大值
```
#!/bin/bash
function compare(){
  if (($1>=$2));then
    echo $1
  else
    echo $2
  fi
}

read -p "please input 4 num: " NUM1 NUM2 NUM3 NUM4
MAX=$(compare $NUM1 $NUM2)
MAX=$(compare $MAX $NUM3)
MAX=$(compare $MAX $NUM4)
echo $MAX
```


```
#!/bin/bash
function compare(){
  if (($1>=$2));then
    echo $1
  else
    echo $2
  fi
}

read -p "please input n num: " -a NUM
MAX=$(compare ${NUM[0]} ${NUM[1]})
for ((i=2;i<${#NUM[*]};i++));do
  MAX=$(compare $MAX ${NUM[i]})
done
echo $MAX
```






## 颜色输出字符串函数

```
PS1="\033[31m[\u\033[32m@\033[33m\h \033[34m\W]\033[0m\$"
```



```
#!/bin/bash
function echo_color_string() {
  if [ $# -ne 2 ];then
    echo $"Usage: sh $0 {red|green|yellow|blue|sblue|white} string"
  else
    color="$1"
    string="$2"
    red="\033[31m"
    green="\033[32m"
    yellow="\033[33m"
    blue="\033[34m"
    purple="\033[35m"
    sblue="\033[36m"
    white="\033[37m"
    c_reset="\033[0m"
    case  $color  in
      red)
        echo -e "${red}${string}$c_reset"
        ;;
      green)
        echo -e "${green}${string}$c_reset"
        ;;
      yellow)
        echo -e "${yellow}${string}$c_reset"
        ;;
      blue)
        echo -e "${blue}${string}$c_reset"
        ;;
      purple)
        echo -e "${purple}${string}$c_reset"
        ;;
      sblue)
        echo -e "${sblue}${string}$c_reset"
        ;;
      white)
        echo -e "${white}${string}$c_reset"
        ;;
      *)
        echo $"Usage: sh $0 {red|green|yellow|blue|sblue|white} string"
    esac
  fi
}

echo_color_string "$@"
```


```
function echo_color_string() {
  color_set="red|green|yellow|blue|sblue|purple|white"
  if [ $# -ne 2 ];then
    echo $"Usage: sh $0 {$color_set} string"
  else
    if [[ "$1" =~ ^(red|green|yellow|blue|sblue|purple|white)$ ]];then
      color="$1"
      string="$2"
      red="\033[31m"
      green="\033[32m"
      yellow="\033[33m"
      blue="\033[34m"
      purple="\033[35m"
      sblue="\033[36m"
      white="\033[37m"
      c_reset="\033[0m"
      eval echo -e "\${${color}}${string}\${c_reset}"
    else
      echo "\$1 = {$color_set}"
    fi
  fi
}

echo_color_string "$@"
```


colorString
```
function echo_color_string() {
  local color_set="red|green|yellow|blue|sblue|purple|white"
  if [ $# -ne 2 ];then
    echo $"Usage: sh $0 {$color_set} string"
    exit 1
  fi
  if [ -z "$1" -o -z "$2" ];then
    echo '$1 or $2 is null'
    exit 2
  fi
  if [[ "$1" =~ ^(red|green|yellow|blue|sblue|purple|white)$ ]];then
    local color="$1"
    local string="$2"
    local red="\033[31m"
    local green="\033[32m"
    local yellow="\033[33m"
    local blue="\033[34m"
    local purple="\033[35m"
    local sblue="\033[36m"
    local white="\033[37m"
    local c_reset="\033[0m"
    eval echo -e "\${${color}}${string}\${c_reset}"
  else
    echo "\$1 = {$color_set}"
  fi
}
```
## 

## 脚本初始化
```
function scripts_init(){
  prog=`basename $0`
  LockFile=/var/lock/subsys/${prog}.lock  # 使用锁文件
  LogFile=/var/log/${prog}.log  # 脚本记录日志
  PidFile=/var/run/${prog}.pid  # 记录进程号，可以管理脚本

  [ -f $LockFile ] && echo "There $LockFile is exist!!" && exit 1 ||touch $LockFile
  [ ! -f $LogFile ] && touch $LogFile
  [ -f $PidFile ] && echo "There $PidFile is exist!!" && exit 2|| echo $$ > $PidFile
}
```


## 记录日志
```
function writelog(){
  Date=$(date "+%F_%T")
  ShellName=`basename $0`
  Info=$1
  echo "$Date : ${ShellName} : ${Info}" >> ${LogFile}
}
```

## 脚本退出扫尾
```
function closeout(){
  [ -f $LockFile ] && rm -f $LockFile 
  [ -f $PidFile ]&& rm -f $PidFile
}
```


## 判断输入是整数
```
function int_judge(){
  fun_a=$1
  expr $fun_a + 1 &>/dev/null
  RETVAL=$?
  return $RETVAL
}
```


```
function isnum(){
  NUM=$1
  if [[ $NUM =~ ^[0-9]+$ ]];then
    echo $NUM is num
  else
    echo $NUM is not num
  fi
}
```


## 判断是否为数字
```
function isnum(){
  NUM=$1
  if [[ $NUM =~ ^[0-9]+\.[0-9]+$ || $NUM =~ ^[0-9]+$ ]];then
    echo $NUM is num
  else
    echo $NUM is not num
  fi
}
```


## 判断输入非空
```
function input_judge(){
  RETVAL=0
  fun_a=$1
  [ ${#fun_a} -eq 0 ]&& RETVAL=1
  return $RETVAL
}
```


## 判断是否为IP地址
```
function check_ip(){
  IP=$1
  if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]];then
    echo $IP |awk -F "." '{if($1<=255&&$2<=255&&$3<=255&&$4<=255){print $0 " is available"} else {print $0 " is not available"}}'
  else
    echo "$IP not available !"
  fi
}

check_ip $1
```


## message
```
  . /etc/init.d/functions
function Msg(){
  if [ $? -eq 0 ];then
    action "$1" /bin/true
  else
    action "$1" /bin/false
  fi
}
```




# 数组
统计每个字母的个数
cat sex.txt 
```
m
m
f
f
f
m
m
m
m
f
m
f
m
```


cat count.sh 
```
#!/bin/bash
declare -A count
while read line
do
   let count[$line]++
done < sex.txt
for i in ${!count[*]}
do
   echo $i ${count[$i]}
done
```



# 综合

生成0-100之间的随机数，并相加，直到大于1000，输出相加的结果

生成0-100之间的随机数，并相加，直到大于1000，并判断最后一个随机数字能否被3整除

```
sum=0
while ((sum<=1000))
do
  random=$((RANDOM%101))
  ((sum+=random))
done
echo $sum
if ((random%3==0));then
   echo $random 能被3整除
else
   echo $random 不能被3整除
fi
```


```
sum=0
for ((;sum<=1000;))
do
  random=$((RANDOM%101))
  ((sum+=random))
done
echo $sum
if ((random%3==0));then
   echo $random 能被3整除
else
   echo $random 不能被3整除
fi
```



判断/tmp目录下是否有大于4k的文件，如果有则输出该文件的大小与创建时间

数组array=(1 2 3 4 5 6)使用脚本打印出每个元素（每行显示一个元素）

使用数组判断I am oldboy teacher welcome to training class中字母数大于6的单词




# 其它

## 产生随机数和随机字符串
```
[root@web01 ~]# echo $RANDOM 
16321

[root@web01 ~]# echo "oldboy$RANDOM" |md5sum 
f3badba255529d96a35320c81e18b712  -

[root@web01 ~]# date +%S%N
09513717319

[root@nfs01 ~]# head /dev/urandom |cksum         
524929739 1892
[root@nfs01 ~]# head /dev/urandom |cksum 
3414497532 1700
[root@nfs01 ~]# cat /proc/sys/kernel/random/uuid 
6124b5c3-429f-4f5e-b828-9d0177c63eb1
```


 
```
[root@db03 ~]# uuidgen 
d5b387bd-ba13-459c-9a6b-c7b1de071336
```


```
tr -cd 'a-zA-Z0-9' < /dev/urandom |head -c 8
```



yum install expect -y


mkpasswd 参数
-l   (length of password,default = 9)       指定密码长度
-d   (min #  of digits,default = 2)         指定密码中数字的数量
-c   (min #  of lowercase chars, default = 2)   指定密码中小写字母的数量
-C   (min #  of uppercase chars, default = 2)   指定密码中大写字母的数量
-s   (min #  of special chars,default = 1)     指定密码中特殊字符的数量


openssl命令

[root@web01 ~]# **openssl** rand -base64 80
Fc1Nb5tSZg19EjOgXw2NgCV3w5JglvwxyGCa50tBHx+oIQM0HoortyDxoBre+bQH
x0/MXD8t7ZoYxzjMhzPuO0VesHgbYF7v+LjmkDYR9rI=

echo '123' |openssl passwd -1 -stdin


 产生10个随机小写字母
[root@web01 ~]# openssl rand -base64 40|sed 's#[^a-z]##g'|cut -c 1-10
uyweucnlqu


[root@db03 ~]# uuidgen |sed 's#-##g'|tr "0-9" "a-j"|cut -c 1-10
ejccebeccd





**批量生成随机字符文件名案例**
使用for循环在/oldboy目录下批量创建10个html文件，其中每个文件需要包含10个随机小写字母加固定字符串oldboy，名称示例如下：
[root@oldgirl C19]# ls /oldboy
apquvdpqbk_oldboy.html  mpyogpsmwj_oldboy.html  txynzwofgg_oldboy.html
bmqiwhfpgv_oldboy.html  mtrzobsprf_oldboy.html  vjxmlflawa_oldboy.html
jhjdcjnjxc_oldboy.html  qeztkkmewn_oldboy.html
jpvirsnjld_oldboy.html  ruscyxwxai_oldboy.html
解答：





解答：
[root@web01 shell]# cat 1.sh 
#!/bin/bash
Path=/oldboy
[ -d "$Path" ] || mkdir -p $Path
for n in {1..10}
do
  pass=`openssl rand -base64 40|sed 's#[^a-z]##g'|cut -c 1-10`
  touch $Path/${pass}_oldboy.html
done




 建立随机文件
mktemp 名XXX
mktemp fkfdXXX
fkfd705

# mktemp XXX
653

 建立随机目录
mktemp -d 名XXX

mktemp -d XXXX
5492

mktemp -d jdfjfXXX
jdfjf762

mktemp -d djjs.XXX
djjs.513

 创建socket文件
mksock a.sock

 创建字符设备文件
mknod character c 4 68

 创建块设备文件
mknod sdb b 8 5




## **批量改名特殊**
将上题中结果文件名中的oldboy字符串全部改成oldgirl(最好用for循环实现),并且将扩展名html全部改成大写。
解答：
[root@web01 shell]# cat 2.sh 
#!/bin/bash
Path=/oldboy
[ ! -d $Path ] && mkdir -p $Path
for f in `ls $Path/*.html`
do
  mv $f `echo $f|sed 's#oldboy.html#oldgirl.HTML#g'`
done


[root@web01 oldboy]# ls |awk -F "[_.]" '{print "mv " $0 " "$1"_oldboy.html"}'
mv bvcbbfrkkg_oldgirl.HTML bvcbbfrkkg_oldboy.html
mv ecpytcuycr_oldgirl.HTML ecpytcuycr_oldboy.html
mv jcvagsnesd_oldgirl.HTML jcvagsnesd_oldboy.html
mv klgnlleocy_oldgirl.HTML klgnlleocy_oldboy.html
mv rnbydwwwye_oldgirl.HTML rnbydwwwye_oldboy.html
mv ryhioakkgl_oldgirl.HTML ryhioakkgl_oldboy.html
mv wzthmzmluv_oldgirl.HTML wzthmzmluv_oldboy.html
mv xopvkcglss_oldgirl.HTML xopvkcglss_oldboy.html
mv ycdvngnyvv_oldgirl.HTML ycdvngnyvv_oldboy.html
mv yqceggzzdj_oldgirl.HTML yqceggzzdj_oldboy.html
[root@web01 oldboy]# **ls |awk -F "[_.]" '{print "mv " $0 " "$1"_oldboy.html"}'|bash**
[root@web01 oldboy]# ll
total 0
-rw-r--r-- 1 root root 0 Nov  6 16:36 bvcbbfrkkg_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 ecpytcuycr_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 jcvagsnesd_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 klgnlleocy_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 rnbydwwwye_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 ryhioakkgl_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 wzthmzmluv_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 xopvkcglss_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 ycdvngnyvv_oldboy.html
-rw-r--r-- 1 root root 0 Nov  6 16:36 yqceggzzdj_oldboy.html
[root@web01 oldboy]# **rename  oldboy.html  oldgirl.HTML  ***
[root@web01 oldboy]# ll
total 0
-rw-r--r-- 1 root root 0 Nov  6 16:36 bvcbbfrkkg_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 ecpytcuycr_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 jcvagsnesd_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 klgnlleocy_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 rnbydwwwye_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 ryhioakkgl_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 wzthmzmluv_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 xopvkcglss_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 ycdvngnyvv_oldgirl.HTML
-rw-r--r-- 1 root root 0 Nov  6 16:36 yqceggzzdj_oldgirl.HTML











[root@db03 oldboy]# ls|sed -r 's#(.*)_oldgirl.HTML#mv & \1_oldboy.html#g'
mv aijbigjfcb_oldgirl.HTML aijbigjfcb_oldboy.html
mv cfacjbbbdc_oldgirl.HTML cfacjbbbdc_oldboy.html
mv chbabffecc_oldgirl.HTML chbabffecc_oldboy.html
mv eaefebiedc_oldgirl.HTML eaefebiedc_oldboy.html
mv ebjbicagfi_oldgirl.HTML ebjbicagfi_oldboy.html
mv eghbdhgefa_oldgirl.HTML eghbdhgefa_oldboy.html
mv ejdjbbjhfd_oldgirl.HTML ejdjbbjhfd_oldboy.html
mv fabcjfdfab_oldgirl.HTML fabcjfdfab_oldboy.html
mv fdabbcfgba_oldgirl.HTML fdabbcfgba_oldboy.html
mv ibdiihcibg_oldgirl.HTML ibdiihcibg_oldboy.html
[root@db03 oldboy]#** ****ls|sed -r 's#(.*)_oldgirl.HTML#mv & \1_oldboy.html#g'|bash**
[root@db03 oldboy]# ll
total 0
-rw-r--r-- 1 root root 0 Apr  1 14:58 aijbigjfcb_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 cfacjbbbdc_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 chbabffecc_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 eaefebiedc_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 ebjbicagfi_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 eghbdhgefa_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 ejdjbbjhfd_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 fabcjfdfab_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 fdabbcfgba_oldboy.html
-rw-r--r-- 1 root root 0 Apr  1 14:58 ibdiihcibg_oldboy.html







[root@db03 scripts]# cat rename.sh 
#!/bin/bash
DIR=/oldboy
[ -d $DIR ] || exit 1
cd $DIR
for name in $(ls *html)
do
  char=`echo ${name%%_o*l}`
  mv $name ${char}_oldgirl.HTML
done





[root@web01 ~]# **seq -w 10**
01
02
03
04
05
06
07
08
09
10
[root@web01 ~]# **echo {01..10}**
01 02 03 04 05 06 07 08 09 10












## **解决DOS攻击生产案例**
写一个Shell脚本解决DOS攻击生产案例。
请根据web日志或者或者网络连接数，监控当某个IP并发连接数或者短时内PV达到100（读者根据实际情况设定），即调用防火墙命令封掉对应的IP。防火墙命令为：iptables-I INPUT -s IP地址 -j DROP。
解答：

[root@web01 scripts]# grep "ESTABLISHED" netstat.log|awk -F "[ :]+" '{print $(NF-3)}'|sort|uniq -c|sort -rn -k1|head -5
      1 120.237.97.10
      1 120.198.202.48
      1 101.226.89.193
[root@web01 scripts]# awk -F "[ :]+" '/EST/{print $(NF-3)}' netstat.log|sort|uniq -c|sort -rn -k1|head -5
      1 120.237.97.10
      1 120.198.202.48
      1 101.226.89.193




[root@web01 scripts]# cat oldboy_19_6_1.sh 
#!/bin/sh
file=$1
if** expr "$file" : ".*\.log"** &>/dev/null
  then
   :
  else
   echo $"usage:$0 xxx.log"
   exit 1
fi

while true
do
awk -F "[ :]+" '/ESTABLISHED/{++S[$(NF-3)]}END {for(key in S) print S[key], key}' $1|sort -rn -k1|head -5 >/tmp/tmp.log
        while read line
        do
          ip=`echo $line|awk '{print $2}'`
          count=`echo $line|awk '{print $1}'`
            if [ $count -gt 3 ] && [ `iptables -nL|grep "$ip"|wc -l` -lt 1 ]
             then
                iptables -I INPUT -s $ip -j DROP
                echo "$line is dropped" >>/tmp/droplist_$(date +%F).log
            fi
        done</tmp/tmp.log
        sleep 5
done










[root@web01 scripts]# cat oldboy_19_6_2.sh
#!/bin/sh
JudgeExt(){
if expr "$1" : ".*\.log" &>/dev/null
  then
   :
  else
   echo $"usage:$0 xxx.log"
   exit 1
fi
}

IpCount(){
awk -F "[ :]+" '/ESTABLISHED/{ ++S[$(NF-3)]}END {for(key in S) print S[key], key}' $1|sort -rn -k1|head -5 >/tmp/tmp.log
}

ipt(){
local ip=$1
if [ `iptables -nL|grep "$ip"|wc -l` -lt 1 ]
then
  iptables -I INPUT -s $ip -j DROP
  echo "$line is dropped" >>/tmp/droplist_$(date +%F).log
fi
}
main(){
JudgeExt $1
while true
do
IpCount $1
while read line
        do
          ip=`echo $line|awk '{print $2}'`
          count=`echo $line|awk '{print $1}'`
            if [ $count -gt 3 ]
             then
                ipt $ip
            fi
        done</tmp/tmp.log
        sleep 5
done
}
main $*











fail2ban
yum install fail2ban



































## **筛选符合长度的单词案例**
利用bash for循环打印下面这句话中字母数不大于6的单词(某企业面试真题)。
I am oldboy teacher welcome to oldboy trainingclass
解答：
 
cat 8.sh 
```
#!/bin/bash
word="I am oldboy teacher welcome to oldboy trainingclass"
for i in $word
do
#  [ ${#i} -le 6 ] && echo $i
#   [ `echo $i |wc -L` -le 6 ] && echo $i
    [ `expr length "$i"` -le 6 ] && echo $i
done
```




## **MySQL主从复制异常监控案例**
开发一个守护进程脚本每30秒监控MySQL主从复制是否异常（包括不同步以及延迟），如果异常，则发送短信并发送邮件给管理员存档。提示：如果没主从复制的环境,可以把下面文本放到文件里读取来模拟主从复制状态：
解答：
mysql -uroot -poldboy123 -e "show slave status\G" 2> /dev/null|awk -F '[ :]+' '/Slave_IO_Running|Slave_SQL_Running|Seconds_Behind_Master/{print $3}'

mysql -uroot -poldboy123 -e "show slave status\G" 2> /dev/null|awk -F '[ :]+' '/Slave_IO_Running/{print $3}'      
Yes

mysql -uroot -poldboy123 -e "show slave status\G" 2> /dev/null|awk -F '[ :]+' '/Slave_SQL_Running/{print $3}'|grep -v Slave
Yes


mysql -uroot -poldboy123 -e "show slave status\G" 2> /dev/null|awk -F '[ :]+' '/Seconds_Behind_Master/{print $3}'           
0


[root@db02 ~]# cat checkmysql.sh 
#!/bin/bash
tmpFile=/tmp/tmp.log
Flag=0

function IO(){
  [ "$io_status" == "Yes" ] || Flag=1
  io_status=`mysql -uroot -poldboy123 -e "show slave status\G" 2> /dev/null|awk -F '[ :]+' '/Slave_IO_Running/{print $3}'`
}
function SQL(){
  [ "$sql_status" == "Yes" ] || Flag=1
  sql_status=`mysql -uroot -poldboy123 -e "show slave status\G" 2> /dev/null|awk -F '[ :]+' '/Slave_SQL_Running/{print $3}'|grep -v Slave`
}
function Seconds(){
  [ "$sec_status" == "0" ] || Flag=1
  sec_status=`mysql -uroot -poldboy123 -e "show slave status\G" 2> /dev/null|awk -F '[ :]+' '/Seconds_Behind_Master/{print $3}'`
}
function Send(){
  echo "Slave_IO_Running:$1 Slave_SQL_Running:$2 Seconds_Behind_Master:$3" >> $tmpFile
}
function main(){
while true
do
  Flag=0
  IO
  SQL
  Seconds
  [ $Flag -eq 1 ] && Send $io_status $sql_status $sec_status
  sleep 10
done
}
main

## 








## **菜单自动化软件部署经典案例**
综合实例：打印选择菜单，按照选择一键安装不同的Web服务。
示例菜单：
[root@oldboy scripts]# shmenu.sh
    1.[install lamp]
    2.[install lnmp]
    3.[exit]
    pls input the num you want:
要求：
1、当用户输入1时，输出“startinstalling lamp.提示”然后执行/server/scripts/lamp.sh，脚本内容输出"lampis installed"后退出脚本，工作中就是正式lamp一键安装脚本；
2、当用户输入2时，输出“startinstalling lnmp.提示” 然后执行/server/scripts/lnmp.sh输出"lnmpis installed"后退出脚本，工作中就是正式lnmp一键安装脚本；
3、当输入3时，退出当前菜单及脚本；
4、当输入任何其它字符，给出提示“Input error”后退出脚本；
5、要对执行的脚本进行相关的条件判断，例如：脚本文件是否存在，是否可执行等判断，尽量用上前面讲解的知识点。
解答：






[root@db03 scripts]# cat 11.sh 
#!/bin/bash
function menu(){
        cat <<-EOF
          1.[install lamp]
          2.[install lnmp]
          3.[exit]
        EOF
}
function main(){
      menu
      read  -p "pls input the num you want:" choose
      case "$choose" in
            1)
              lamp=/server/scripts/lamp.sh
              [ -f $lamp ] && $lamp
              ;;
            2)
              lnmp=/server/scripts/lnmp.sh
              [ -f $lnmp ] && $lnmp
              ;;
            3)
              exit
              ;;
            *)
              echo "Input error" && exit
       esac
}
main





## **Web****及****MySQL****服务异常监测案例**
用if条件语句实现对Nginx Web服务以及MySQL数据库服务是否正常进行检测，如果服务未启动，则启动相应服务。
解答：

 nc 命令 简易聊天工具
第一个会话
[root@db03 scripts]# nc -l 12345
hello
nihao


第二个会话
[root@db03 ~]# nc 10.0.0.53 12345
hello 
nihao



 本地端口判断
[root@db03 scripts]# cat 12-1.sh 
#!/bin/bash
PORT_NUM=`lsof -i:3306 |wc -l`
if [ $PORT_NUM -eq 0 ]
then
  echo "mysql is bad"
  exit 1
else
  echo "mysql is good"
  exit 0
fi


 本地进程判断
[root@db03 scripts]# cat 12-2.sh 
#!/bin/bash
PORT_NUM=`ps -ef |grep mysql|grep -v grep|wc -l`
if [ $PORT_NUM -eq 0 ]
then
  echo "mysql is bad"
  exit 1
else
  echo "mysql is good"
  exit 0
fi










 远程端口判断
[root@db03 scripts]# cat 12-3.sh 
#!/bin/bash
IP=`hostname -I |awk '{print $1}'`
PORT=3306
PORT_NUM=`nmap $IP -p $PORT |grep open|wc -l`
if [ $PORT_NUM -eq 0 ]
then
  echo "mysql is bad"
  exit 1
else
  echo "mysql is good"
  exit 0
fi



 获取返回内容判断
[root@db03 scripts]# cat 12-4.sh 
#!/bin/bash
NUM=`mysql -uroot -poldboy123 -e "select user,host from mysql.user;" 2> /dev/null |wc -l`
if [ $NUM -eq 0 ]
then
  echo "mysql is bad"
  exit 1
else
  echo "mysql is good"
  exit 0
fi





## **监控****Memcached****缓存服务是否正常**
监控Memcached缓存服务是否正常，模拟用户（web客户端）检测。
使用nc命令加上set/get来模拟检测。
解答：
memcache写
printf "set key01 0 0 10\r\n$(echo $RANDOM |md5sum |cut -c 2-11)\r\n" |nc 127.0.0.1 11211
memcache读
printf "get key01\r\n" |nc 127.0.0.1 11211
printf "get key01\r\n" |nc 127.0.0.1 11211 |sed -n 2p |tr -d "\r"

memcache_check.sh
```
#!/bin/bash
IP=127.0.0.1
PORT=11211
NC_CMD="nc $IP $PORT"
InsertNum=$(echo $RANDOM |md5sum |cut -c 2-11)
MC_W="set key01 0 0 10\r\n${InsertNum}\r\n"
MC_R="get key01\r\n"

function MC_ok(){
  echo "memcache server is good"
  exit 0
}

function MC_err(){
  echo "memcache server is bad"
  exit 1
}

#write check
if printf "$MC_W"|${NC_CMD} &> /dev/null
then
  :
else
  MC_err
fi

#read check
SelectNum=$(printf "$MC_R" |${NC_CMD} |sed -n 2p |tr -d "\r")

if [ "${SelectNum}" = "${InsertNum}" ]
then
  MC_ok
else
  MC_err
fi
```



## **开发脚本入侵检测与报警案例**
面试及实战考试题：监控web站点目录（/var/html/www）下所有文件是否被恶意篡改（文件内容被改了），如果有就打印改动的文件名（发邮件），定时任务每3分钟执行一次。
解答：
生成指纹库
[root@db03 scripts]# cat 14-1.sh
```
#!/bin/bash
WebSite=/var/www/html/
path=/server/scripts
Md5sumDb=$path/md5sum.db
DiffDb=$path/diff.db
find $WebSite -type f |xargs md5sum > $Md5sumDb
find $WebSite -type f > $DiffDb
```


检查对比脚本
[root@db03 scripts]# cat 14-2.sh
```
#!/bin/bash
WebSite=/var/www/html/
path=/server/scripts
Md5sumDb=$path/md5sum.db
DiffDb=$path/diff.db
DiffNdb=$path/new_diff.db
CheckLog=/tmp/check.log

#Judge some dir or files is exist?
[ ! -d "$WebSite" ] && {
  echo "This is a joke!"
  exit 1
}

[ ! -d "$path" ] && mkdir -p $path

# Defined Check function
function check(){
  find $WebSite -type f > $DiffNdb
  md5sum -c $Md5sumDb 2> /dev/null |grep FAILED >> $CheckLog
  diff $DiffDb $DiffNdb >> $CheckLog 2>&1
}

# Defined main function
function main(){
  while true
    do
      check
      [ -s "$CheckLog" ] && \
      mail -s "site is cuangai $(date +%F)" 123456@qq.com < $CheckLog
      sleep 10
    cat /dev/null > $CheckLog
  done
}
main
```



## **开发****Rsync****服务启动脚本案例**
写网络服务独立进程模式下Rsync的系统启动脚本，例如：/etc/init.d/rsyncd {start|stop|restart}。
要求：
1.要使用系统函数库技巧。
2.要用函数，不能一坨SHI的方式。
3.可被chkconfig管理。
解答：
 
#!/bin/bash
```
# chkconfig: 2345 64 36
# description: manager rsyncd server.
 
# Warning: This script uses the /etc/init.d/functions system function. 
#          System  kernel version is CentOS6.6,2.6.32-504.el6.x86_64.
#          I'm not sure whether other systems can be used normally.
# Source function library.
. /etc/init.d/functions
 
rsync=/usr/bin/rsync
prog=rsyncd
pidfile=${PIDFILE-/var/run/rsyncd.pid}
lockfile=${LOCKFILE-/var/lock/subsys/rsyncd}
RsyncConf="/etc/rsyncd.conf"
RETVAL=0
 
Usage(){
$SETCOLOR_WARNING 
echo -n "Rsync Daemon Program Need Configuration File,like /etc/rsyncd.conf"
$SETCOLOR_NORMAL
echo
exit 6
}

start(){
[ -x $rsync ] || exit 5
[ -f $RsyncConf ] || Usage
        echo -n $"Starting $prog: "
        daemon --pidfile=${pidfile} $rsync --daemon
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && touch ${lockfile}
        return $RETVAL
}
 
stop(){
echo -n $"Stopping $prog: "
killproc $prog
retval=$?
echo
[ $retval -eq 0 ] && rm -f ${lockfile}
return $retval
}
 
restart() {
stop
sleep 1
start
}
 
rh_status() {
status $prog
}
 
rh_status_q() {
rh_status >/dev/null 2>&1
}
 
case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart)
        $1
        ;;
    status)
        rh_status
        ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart}"
        exit 2
esac
```







## **开发MySQL多实例启动脚本**
开发MySQL多实例启动脚本：
已知MySQL多实例启动命令为：mysqld_safe --defaults-file=/data/3306/my.cnf&
停止命令为：mysqladmin -u root -poldboy123 -S/data/3306/mysql.sock shutdown
请完成mysql多实例启动启动脚本的编写
要求：用函数，case语句、if语句等实现。


## **天津项目学生实践抓阄案例**
好消息，老男孩培训学生外出企业项目实践机会（第6次）来了（本月中旬），但是，名额有限，队员限3人（班长带队）。
因此需要挑选学生，因此需要一个抓阄的程序：
要求：
1、执行脚本后，想去的同学输入英文名字全拼，产生随机数01-99之间的数字，数字越大就去参加项目实践，前面已经抓到的数字，下次不能在出现相同数字。
2、第一个输入名字后，屏幕输出信息，并将名字和数字记录到文件里，程序不能退出继续等待别的学生输入。
 解答：


```
#!/bin/bash

function rand(){
  echo $((RANDOM%100+1))

}

> /tmp/user.txt
while true
do
  clear
  echo "抓阄获奖名单如下: "
  sort -rnk2 /tmp/user.txt |head -3
  read -p 'please input name: ' NAME
  [ -z "$NAME" ] && continue
  if [ "$NAME" = "q" ];then
    break
  fi
  if grep -w "$NAME" /tmp/user.txt &> /dev/null;then
    continue
  fi
  RAND=$(rand)
  while grep -w "$RAND" /tmp/user.txt &> /dev/null
  do
    RAND=$(rand)
  done

  echo -e "$NAME\t$RAND" >>/tmp/user.txt

done
echo "抓阄获奖名单如下: "
sort -rnk2 /tmp/user.txt |head -3
```




```
#!/bin/bash

DbFile=./while_ernie.db
[ ! -f $DbFile ] && touch $DbFile

RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
PINK='\E[1;35m'
RES='\E[0m'

function trapper(){
  trap ':' INT EXIT TSTP TERM HUP
}

function random(){
  local x y
  x=$(($RANDOM%9))
  y=$(($RANDOM%9))
  echo $x$y
}

function warn(){
  echo -e "${RED_COLOR}Please enter the correct format name! like zhangsan!${RES}"
  countdown
  continue
}

function warn2(){
  echo -e "${RED_COLOR} You have entered the name! Give the change to other!${RES}"
  countdown
  continue
}

function countdown(){
  for i in `seq -w 10 -1 1`
  do
    echo -ne "\b\b$i";
    sleep 1;
  done
}

function check_name(){
  echo -e "${YELOW_COLOR}Please enter [exit] to exit the program${RES}"
  read -p "Please enter the name of the Pinyin:" name name1
  [ "$name" == "exit" ] && exit 0
  [ -n "$name1" ] && warn
  [ -n "$name" -a -z "`echo "${name//[a-zA-Z]/}"`" ] || warn
}

function check_file(){
  local Name Id
  Name=`awk '{if($1=="'$name'") print $1}' $DbFile`
  [ -z "$Name" ] || warn2
  
  num=`random`
  Id=$num
  while [ -n "$Id" ]
  do
    num=`random`
    Id=`awk '{if($2=="'$num'") print $2}' $DbFile`
  done

  printf "%-20s %-2s\n" $name $num >> $DbFile
}

function welcome(){
  clear
  echo -e "${GREEN_COLOR}
       This program will select 3 students to participate in
  the training of enterprise project practice out of the oldboy.
  
  The students are eligible to participate in the list as follows${RES}"

  echo -e "${BLUE_COLOR}`sort -rn -k2 $DbFile|head -3`${RES}"
}

function main(){
  while true
  do
    trapper
    welcome
    check_name
    check_file
  done
}

main
```





## **破解****RANDOM****随机数案例**
已知下面的字符串是通过RANDOM随机数变量md5sum后，再截取一部分连续字符串的结果，请破解这些字符串对应的使用md5sum处理前的RANDOM对应的数字？
21029299
00205d1c
a3da1677
1f6d12dd
解答：

```
#!/bin/bash
for i in {0..32767}
do
  echo "$i:$(echo $i |md5sum)" >> /tmp/dict.txt
done
egrep "21029299|00205d1c|a3da1677|1f6d12dd|890684b" /tmp/dict.txt
```


## **批量检查多个网站地址是否正常**
企业面试题：批量检查多个网站地址是否正常
要求：
1、使用shell数组方法实现，检测策略尽量模拟用户访问。
2、每10秒钟做一次所有的检测，无法访问的输出报警。
3、待检测的地址如下
http://blog.oldboyedu.com
http://blog.etiantian.org
http://oldboy.blog.51cto.com
http://10.0.0.7
解答：

## **单词及字母去重排序案例**
用shell处理以下内容
1、按单词出现频率降序排序！
2、按字母出现频率降序排序！
the squid project provides a number ofresources to assist users design,implement and support squid installations.Please browse the documentation and support sections for more infomation,byoldboy training.
课堂实战考察某企业shell面试考试题
http://oldboy.blog.51cto.com/2561410/1686891
解答：

1
```
awk -F "[,. ]" '{for(i=1;i<=NF;i++)array[$i]++}END{for(key in array)print array[key],key|"sort -nr"}' oldboy.txt|column -t
```

```
tr "[ ,.]" "\n"<oldboy.txt|grep -v "^$"|sort|uniq -c|sort -rn
```

```
tr "{ |,|.}" "\n"<oldboy.txt|awk -F ""  '{for(i=1;i<=NF;i++)array[$i]++}END{for(key in array)print array[key],key|"sort -nr"}'
```

```
tr "[ ,.]" "\n"<oldboy.txt|awk '{for(i=1; i<=length($0); i++) ++S[substr($0,i,1)]} END {for(a in S) print S[a], a|"sort -rn"}'
```



2
```
echo "the squid project provides a number of resources toassist users design,implement and support squid installations. Please browsethe documentation and support sections for more infomation"|sed 's# ##g'|sed -r 's#(.)#\1\n#g'|sort|uniq -c|sort -rn -k1
```

```
echo "the squid project provides a number of resources toassist users design,implement and support squid installations. Please browsethe documentation and support sections for more infomation"|sed 's# ##g'|awk -F "" '{for(n=1;n<=NF;n++) print $n}'|sort|uniq -c|sort -k1 -nr
```




## **编写正（或长）方形图形案例**
请用shell或Python编写一个正（或长）方形，接收用户输入的数字。
解答：

25.sh
```
#!/bin/bash
read -p "please enter a number:" Line
for x in `seq $Line`
  do
    for y in `seq $Line`
      do
        echo -n "* "
    done
    echo
done
```

25-2.sh 
```
#!/bin/bash
read -p "please enter a number:" chang kuan
for x in `seq $kuan`
  do
    for y in `seq $chang`
      do
        echo -n "* "
    done
    echo
done
```




## **编写等腰三角形图形字符案例**
请用shell或Python编写一个等腰三角形，接收用户输入的数字。
解答：

![图片](https://images-cdn.shimo.im/EWAyyuhFgNgkpxDB/image.image/png!thumbnail)

一行一行打印

26.sh
```
#!/bin/bash
read -p "Please Enter a number:" Line
for ((i=1; i<=Line; i++))
do
    for ((j=$Line-$i; j>0; j--));
    do
        echo -n ' '
    done
    for ((h=1; h<=$((2*$i-1)); h++))
    do
        echo -n '*'
    done
    echo
done
```



## **编写直角梯形图形字符案例**
请用shell或Python编写一个画直角梯形程序，接收用户输入的参数n（n>2），m。
解答
![图片](https://images-cdn.shimo.im/0PTCayBzAro0Gydz/image.image/png!thumbnail)

vim 27.sh
```
#!/bin/sh
if [ $# -ne 2 ];then
    echo $"USAGE:$0 num1(>2) num2"
    exit 1
fi
for n in `seq $1 $2`
do
    for((m=1;m<=$n;m++))
    do
        echo -n "*"
    done
    echo
done
```





## **爬虫**
获取51CTO博客列表倒序排序考试题
 
请把http://oldboy.blog.51cto.com地址中的所有博文，按照时间倒序列表如下：
2013-09-13运维就是一场没有硝烟的战争
http://oldboy.blog.51cto.com/2561410/1296694
2016-04-17运维人员写项目方案及推进项目的基本流程思路
http://oldboy.blog.51cto.com/2561410/1764820
附加：高级要求：
生成html页面，并设置超链接。
结果如下：
http://oldboy.blog.51cto.com/2561410/1862041
解答：

#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
HTMLFILE=/home/oldboy/html
HTTP=http://oldboy.blog.51cto.com/all/2561410
NUM=$(curl $HTTP |awk -F "[ /]" '/页数/ {print $(NF-3)}')
[ -d $HTMLFILE ]||mkdir $HTMLFILE -p
echo -e "<b><h1>老男孩51CTO博客文章html整理版</h1></b>\n<b><h3>老男孩教育运维脱产班31期  王梅西</h3></b>" >$HTMLFILE/blog_oldboy_$(date +%F).html
for((i=$NUM;i>0;i--))
do
    curl $HTTP/page/$i|egrep "<li><span>|<em"|awk '{if(NR%2==0){printf $0 "\n"}else{printf $0}}'|awk -F '["<>]+' '{print "<a href=\"http://oldboy.blog.51cto.com"$9"\">",$14,$10,"</a> <br>"}'|sort -n >>$HTMLFILE/blog_oldboy_$(date +%F).html
done







抓取网页的脚本
http://life2death.blog.51cto.com/7550586/1657133

[root@mysql scripts]# cat html_to_table.sh        
#!/bin/bash
# oldboy linux training
# 2015-06-01
# Happy Children's Day
# 说明：本脚本来自老男孩linux21期学员张耀开发！
EduFile=/tmp/edu.html
EduFile2=/tmp/edu2.html
Url="$*"
 
# Check for given parameters 
[ $# -eq 0 ] && {
   echo "USAGE: /bin/sh $0 http://...."
   exit 1
}
 
# Judge url is ok?
curl -I $Url &>/dev/null 
[ $? -ne 0 ] &&{
   echo "Bad url,Please check it"
   exit 1
}
 
# Defined get pagenum and CourseId Functions
function getnum(){
        curl -s $Url>$EduFile
        grep '"pagesGoEnd"' $EduFile &>/dev/null
        if [ $? -eq 0 ]
          then
            num=`sed -rn 's#.*page=([0-9].*)" class="pagesGoEnd".*$#\1#gp' $EduFile`
        else
            num=`sed -rn 's|.*page=([0-9].*)#" class="pagesNum".*$|\1|gp' $EduFile`
        fi
        pagenum=${num:-1}
        CourseId=`echo $Url|awk -F "[-.]" '{print $4}'`
}
 
 
# Defined curl html Functions
function Curl(){
        getnum
        for i in `seq $pagenum`
          do 
            curl "http://edu.51cto.com/index.php?do=course&m=lessions&course_id=$CourseId&page=$i" 1>>$EduFile 2>/dev/null
        done
}
 
# Defined Create table Functions
function table(){
        sum=""
        index=1
        sed -rn '/do=lesson/ s#<.*(<a href=")(.*)</h4>#\1http://edu.51cto.com\2#gp' $EduFile > $EduFile2
        while read line
          do
            sum=$sum"<tr><th width="40" scope="row">$index</th><td width="520">$line</td>"
            ((index++))
        done <$EduFile2
}
 
# Defined Create html Functions
function html(){
        cat >/tmp/oldboy.html<<-END
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>test</title>
        </head>
 
        <body>
        <table width="560" border="1">
        $sum
        </table>
        </body>
        </html>
        END
}
 
function main(){
        Curl
        table
        html
}
 
main



[root@mysql scripts]# sh html_to_table.sh http://edu.51cto.com/course/course_id-839.html 
[root@mysql scripts]# sz /tmp/oldboy.html

spider.sh 
```
#!/bin/bash
for i in {1..58}
do
 wget http://www.521609.com/daxuexiaohua/list3${i}.html
 for j in $(awk -F '[" ]+' '/<img src=.*\jpg./{print $11}' list3${i}.html |egrep 'jpg$')
 do
  wget http://www.521609.com$j
 done
done
```


## **企业代码上线发布系统案例**
写一套简单的企业代码上线发布系统案例，利用SVN对代码及配置文件进行管理，在办公室服务器上从svn取出指定版本的代码和配置，发布到IDC机房分发机服务器上，在分发服务器或者负载均衡器上或者应用服务器本地实现代码平滑发布、上线、回滚脚本（具体设计请参考课堂讲解的企业代码发布方案）

![图片](https://images-cdn.shimo.im/Y9bYTic0BKguCKSJ/image.image/png!thumbnail)



/server/scripts/deploy.sh
```
#!/bin/sh
DATE=$(date +%Y-%m-%d-%H-%M-%S)
CODE_DIR="/var/lib/jenkins/workspace/freestyle-job/"
WEB_DIR="/var/www/"

get_code_tar(){
        cd $CODE_DIR && tar zcf /opt/web-$DATE.tar.gz ./*
}

scp_code_web(){
        scp /opt/web-$DATE.tar.gz 10.0.0.8:$WEB_DIR
}

code_tarxf(){
        ssh 10.0.0.8 "cd $WEB_DIR &&mkdir web-$DATE && tar xf web-$DATE.tar.gz -C web-$DATE"

}
ln_html(){
         ssh 10.0.0.8 "cd $WEB_DIR && rm -rf html && ln -s web-$DATE html"
}

main(){

        get_code_tar;
        scp_code_web;
        code_tarxf;
        ln_html;
}
main
```



## **30道shell编程题目中给每个伙伴随机抽取10道题目**
cat xuanti.sh
```
#!/bin/bash
function input(){
  read -p "请输入题目总数:" S_count
  read -p "请输入选题数量:" count
  read -p "请输入组的数量:" team
}

function RAN_one(){
  tmp_num=`echo $((RANDOM%$S_count+1))`
  i=0
  while ((i<${#num[*]}))
  do
    if ((tmp_num!=num[i]))
    then
      ((i++))
    else
      i=0
      tmp_num=`echo $((RANDOM%$S_count+1))`
    fi
  done
  num[${#num[*]}]=$tmp_num
}

function RAN(){
count=$1
num[0]=`echo $((RANDOM%$S_count+1))`
for((j=1;j<count;j++))
do 
  RAN_one
done
echo ${num[*]}
}


function main(){
  clear
  input
  for ((i=1;i<=team;i++))
  do
    echo $i ------ $(RAN $count)
  done
}
main
```










