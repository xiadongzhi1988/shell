## 选择
### 改变bash的提示符实际上就是改变变量（）
\$HOME
\$PWD
```
$PS1
```
\$PS2
### 在shell脚本中，用来读取文件内各个域的内容并将其赋值给shell变量的命令是______
fold

join

tr
```
read
```
### 从后台启动进程，应在命令的结尾加上符号（）
```
A：&
```
B：@

C：#

D：$
### 不是shell具有的功能和特点是（）
A：管道

B：输入输出重定向

C：执行后台进程
```
D：处理程序命令
```
### 退出交互模式的shell，应键入（）
A：\<Esc>

B：^q
```
C：exit
```
D：quit
### shell不仅仅是用户命令解释器，同时一种强大的编程语言，linux缺省的shell是
```
bash
```
ruby

PHP

perl
### 以下函数中，和其他函数不属于一类的是
read

pread

write

pwrite

fseek
```
lseek
```
### 下列变量名中有效的shell变量名是:______
-2-time

_2$3
```
trust_no_1
```
2004file
### 下列对shell变量FRUTT操作，正确的是______
为变量赋值：$FRUTT=apple

显示变量的值：fruit=apple
```
显示变量的值：echo $FRUTT
```
判断变量是否有值: [-f - - FRUTT || ]
### 在shell编程中关于$2的描述正确的是
程序后携带了两个位数参数

宏替换
```
程序后面携带的第二个位置参数
```
携带位置参数的个数
### 在shell环境下想把‘gyyx’值赋给变量company，下面哪个是正确的
company = gyyx

$company=gyyx
```
company='gyyx'
company=gyyx
```
### 下面sed删除行，下面哪个脚本是错误的是
sed -e '/man/d' filename

sed -e '1,3d' filename

sed -e '1,/man/d' filename
```
sed -e '/man/3d' filename
```
### 下面表述错误的是
$n 表示程序的第n个参数值
```
$* 表示程序的所有参数个数
```
$$表示程序的PID
### 下列代码样例中，哪个存在错误
```
for filename in (ls)do cat filename done
```
for((i=0;i<10;i++)) do echo \$i done

x=1 sum=0 while [ x -le 10 ] do let sum=sum+x let x=x+1 done echo \$sum

for i in 1 2 3 4 5 do echo i done
### 在shell脚本中，用来读取文件内各个域的内容并将其赋值给shell变量的命令是
fold

join

tr
```
read
```
### shell中如何跳出当前循环继续之后的循环
break
```
continue
```
exit

kill
### shell脚本中的注释符
//

/**/

" "
```
#
```
### 采用bash执行shell脚本时加上哪个参数可以跟踪执行脚本过程
```
-x
```
-u

-f

-p
### 以下命令执行后，结果为（）
```
var1=abcdedf
var2=abcded
echo "var1"|grep -q "var2" && echo "yes" || echo "no"
```
无结果

语法错误

yes
```
no
```
### 在shell比较运算符中，数值测试“等于则为真”的是（）
-ne

-ge
```
-eq
```
-le
## 填空
### 在shell编程中，如果要访问变量值，可以变量前加一个_____符号
$
### 请说出以下符号在bash shell中的意义
```
n   第n个参数
?  上一条命令的返回状态
*   获取所有参数视为一个参数
$   当前shell进程号
${#aa}   变量aa值的长度
```
### 执行shell程序之前必须赋予该脚本_____
执行权限
### Linux系统shell脚本第一行需写______代表什么意义_____
```
#!/bin/bash
```
指定脚本运行时的解释器
### 编写shell脚本时注释符是_________
\#
### shell命令“sed -i s/\r/ /g test.txt”实现的是_______
文件内容无变化
## 简答
### 在shell中n,!,*,@,？分别是什么含义？
```
n   第n个参数
!    最后一个后台进程号
*    获取所有参数视为一个参数
@   获取所有参数,每个参数视为单独的参数
?    上一条命令的返回状态
```
### 统计/var/log下文件的个数
```
方法1:
find /var/log/ -type f |wc -l
方法2:
tree /var/log/ |awk 'END{print $3}'
```
### 如何将F1文件的运行结果输出到F2.txt里
```
./F1 > F2.txt
```
### 写一个脚本实现判断192.168.1.0/24 网络里，当前在线的ip有哪些，能拼通则认为在
```bash
#!/bin/bash
CMD="ping -W 2 -c 2"
Ip="192.168.1."
for n in $(seq 254)
do
{
        $CMD $Ip$n &> /dev/null
        if [ $? -eq 0 ];then
           echo "$Ip$n is ok"
        fi
}&
done
```
### 根据以下信息
```
IP_Address MAC_Address Interface Static
10.66.10.250 80:71:7A:33:CA:A7 br on
10.66.10.249 5C:50:15:7F:3B:F5 br on
```
将以上文件名称test.txt文件中IP_Address,MAC_Address, Interface三项下的内容取出来，值以“：”分割，并呈格式显示出来
```
10.66.10.250:80:71:7A:33:CA:A7:br
10.66.10.249:5C:50:15:7F:3B:F5:br
```
```
awk 'NR!=1{OFS=":";print $1,$2,$3}' test.txt
```
### 在shell中变量的赋值有四种方法，其中采用name=jfedu.net的方法称
```
直接复制
```
使用read命令
使用命令行传参
使用命令输出
### 编写一个脚本，5分钟检查一次日志，发现有暴力SSH破解现象的，提取此类IP地址，并去重，并按降序排序
要求：同一个IP暴力破解超过10次，自动屏蔽IP地址，指定办公室IP地址（192.168.100.100）为可信任IP地址，不受屏蔽规则限制，以下为日志格式：
日志样式：
```
May 4 03:43:07 tz-monitor sshd{14003}: Failed password for root from 124.232.135.84 port 25251 ssh2
Myy 4 03:43:07 tz-monitor sshd{14082}: invalid user postgres from 124.232.135.84
```
vim /server/scripts/fairban.sh
```bash
#!/bin/bash
awk '/Failed password/{count[$(NF-3)]++}END{for (ip in count) if(count[ip]>=10){print count[ip],ip}}' /var/log/secure > /tmp/count_ip.txt
while read line
do
  IP=$(echo $line |awk '{print $2}')
  if [ "$IP" != "192.168.100.100" ];then
    if ! grep -w $IP /tmp/drop_ip.txt &> /dev/null;then
      iptables -I INPUT -s $IP -j DROP
      echo $IP >> /tmp/drop_ip.txt
    fi
  fi
done < /tmp/count_ip.txt
```
crontab -e
```
*/5 * * * * /bin/bash /server/scripts/fairban.sh &> /dev/null
```
### 检查OSPF route-ID配置，配置如下，请用shell编写代码，条件如下：a.检查ospf的route-id值，route-id值必须与interface LoopBack0的IP地址值相同，如果两个值不相等打印出ospf的route-id的值，并且ospf的route-id值必须以139开头，如139.xx.xx.xx，否则也打印出route-id的值
```
ospf 100
route-id 139.11.0.1
area 0.0.0.0
network 139.11.0.1 0.0.0.0
network 140.11.0.0 0.0.0.3
network 140.11.0.8 0.0.0.3
network 140.11.0.16 0.0.0.3
network 140.11.0.24 0.0.0.3
network 140.11.0.32 0.0.0.3
interface LoopBack0
ip address 139.11.0.1 255.255.255.255
```
```bash
#!/bin/bash
route_id=$(grep  ospf -A 1 route-id.txt |awk 'NR==2{print $2}')
interface_LoopBack0=$(grep  "interface LoopBack0" -A 1 route-id.txt |awk 'NR==2{print $3}')
if [ "$route_id" != "$interface_LoopBack0" ] || ! [[  $route_id =~ ^139.*$ ]];then
  echo $route_id
fi
```
### 检查IP地址合规，请用shell编写代码，列出不以199或200开头的IP地址，如199.x.x.x 或200.x.x.x
```
Interface Physical Protocol IP Adderss
Eth1/0/1 up up 199.11.250.1
Eth1/0/2 up up 200.11.250.5
Loop0 up up(s) 199.11.250.1
Vlan1 *down down unassigned
Vlan500 down down 139.100.1.157
Vlan900 up up 140.11.250.41
```
```bash
#!/bin/bash
while read line
do
  isnum=$(echo $line | awk -F "[ .]+" '{print $(NF-3)}')
  if [[ $isnum =~ ^[0-9]+$ ]];then
    if [ $isnum -ne 199 ] && [ $isnum -ne 200 ];then
      echo $line | awk  '{print $NF}'
    fi
  fi
done < /tmp/config.txt
```
### 处理以下文件内容，将域名提取并进行计数排序，如处理
```
http://www.baidu.com/index.html
http://www.baidu.com/1.html
http://post.baidu.com/index.html
http://mp3.baidu.com/index.html
http://www.baidu.com/3.html
http://post.baidu.com/2.html
```
得到如下结果：
域名的出现次数 域名
```
3 www.baidu.com
2 post.baidu.com
1 mp3.baidu.com
```
可以使用bash/per/php任意一种
```
awk -F '/' '{count[$3]++}END{for (url in count) print count[url],url}' url.txt |sort -rn
```
### 在单台服务器Linux操作系统环境下，写一行命令，将所有该机器的所有以“.log.bak“为后缀的文件，打包压缩并上传到ftp上，FTP地址为123.234.25.130的/home/bak文件夹
```
cd /
find -type f -name "*.log.bak" |xargs tar zcf /tmp/all.tar.gz
ftp -i -n <<FTPIT
open 123.234.25.130
user username_xxx password_xxx
bin
passive
hash
cd /home/bak
lcd /tmp
put all.tar.gz
quit
FTPIT
```
### Linux脚本：现在要删除本机中若干文件，/root/file.list中记录了这些文件的绝对路径，请用脚本实现。/root/file.list内容范例：/tmp/1.file
```bash
#!/bin/bash
while read line
do
  rm $line -f
done < /root/file.list
```
### 说出shell的种类，已经常用的shell
csh ksh tcsh bash  sh
交互式 非交互式
登录式 非登录式

bash
### 下面代码会输出什么
```python
def f(x,l=[]):
    for i in range(x):
        l.append(i*i)
        print(l)
f(2)
f(3,[3,2,1])
f(3)
```
```
[0]
[0, 1]
[3, 2, 1, 0]
[3, 2, 1, 0, 1]
[3, 2, 1, 0, 1, 4]
[0, 1, 0]
[0, 1, 0, 1]
[0, 1, 0, 1, 4]
```
### 根据以下nginx日志信息格式，统计全天PV、UV及UV的前十、PV前十页面；分别列出状态码499、500、502按次数统计的前三位
```
36.110.86.173 - - [30/Otc2017:09:38:30 +0800] “POST /index.php?r=tuiguang%2Fdelete HTTP/1.1” 200 385 0.036 “http://backend.lepu.cn/index.php?r=tuiguang%2Findex&id=535634“ “Mozilla/5.0 (windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Fecko) Chrome/55.0.2883.87 Safari/537.36” “0.68”
```
全天PV： 全天UV： PV前十：
UV前十： 499前三： 500前三： 502前三：
全天PV
```
wc -l access.log
```
PV前十
```
awk '{count[$7]++}END{for(pv in count)print count[pv],pv}' access.log |sort -nr |head
```
499前三
```
awk '$9==499{count[$7]++}END{for(pv in count) print count[pv],pv}' access.log |sort -nr |head -3
```
500前三
```
awk '$9==500{count[$7]++}END{for(pv in count) print count[pv],pv}' access.log |sort -nr |head -3
```
502前三
```
awk '$9==502{count[$7]++}END{for(pv in count) print count[pv],pv}' access.log |sort -nr |head -3
```
### 创建一个函数，能接受两个参数
（1） 第一个参数为URL，即可下载的文件；第二个参数为目录，即下载后保存位置；
（2） 如果用户给的目录不存在，则提示用户是否创建；如果创建就继续执行，否则函数返回一个51的错误值给调用脚本
（3） 如果给的目录存在，则下载文件；下载命令执行结束后测试文件下载成功，如果成功，则返回0给调用脚本，否则，返回52给调用脚本；
```bash
f(){
  URL=$1
  dir=$2
  if [ -d $dir ];then
    cd $dir
    wget $URL
    if [ $? -eq 0 ];then
      return 0
    else
      return 52
    fi
  else
    read -p "是否创建目录(y/n):" res
    if [ "$res" = "y" ];then
      mkdir $dir -p
      f $URL $dir
    else
      return 51
    fi
  fi
}
```
### 有一个长度为n序列，需要移除掉里面的重复元素，但是对于每种元素保留最后出现的那个。输入描述:输入包括两行
第一行为序列长度n(1≤ n≤ 50)
第二行为n个数scqucencel,以空格分隔
输出描述
输出消除重复元素之后的序列，以空格分隔，行末无空格
输入例子
100 100 100 99 99 99 100 100 100
输出例子
99 100
```bash
#!/bin/bash
onum=()
read -a inum -p "请输入数字序列: "
for num in ${inum[*]}
do
  if test -z $onum;then
    onum+=($num)
  else
    for num1 in ${onum[*]};do
      if ((num1==num));then
        flag=1
        break
      fi
    done
    if ((flag==1));then
      flag=0
      continue
    fi
    onum+=($num)
  fi
done
echo ${onum[*]}
```
### 使用一个队列模拟一个栈，在空白处实现下面类中的方法即可
```
class Queue(object):
def enqueue(self,item):
"''""入队""""
def dequcue(self):
""""出队"""
```
测试
```
q = Queue()
q.enqueue(1)
输出q [1]
q.enqueue(4)
输出q [1,4]
q.dequeue()
输出14
```
```python
class Queue(object):
    def __init__(self):
        self.items = []
    def enqueue(self,item):
        self.items.append(item)
        print(self.items)
    def dequeue(self):
        l=self.items
        for i in l:
            print(i,end='')

q = Queue()
q.enqueue(1)
q.enqueue(4)
q.dequeue()
```
### 从一个网站上面分别下载100个图片，他们的网址是 http://download.linekong.com/img/1.png 、http://download.linekong.com/img/2.png ... http://download.linekong.com/img/100.png 批量下载100个图片文件，并找出大于500kb的文件
```bash
#!/bin/bash
URL="http://download.linekong.com/img/"
for i in {1..100};do
  wget $URL${i}.png
done
find -type f -size +500k -name '*.png'
```
### 一个文本文件info.txt每行都是以逗号分隔，其中第二列都是数字，请对该文件按照第二列从小到大排列
```
aa,101
bb,302
cc,222
dd,44
```
```
sort -t "," -nk2 info.txt
```
### 通过shell如何删除文档中的注释和空白行
```
sed -ri '/#|^\s*$/d' info.txt
```
### 根据要求写出linux命令
a．显示当前目录的内容
b．以详细格式显示test用户的家目录内容，包含隐藏文件
c．进入根目录
d．显示/etc/passwd文本文件的内容
e．显示/etc/passwd文件的后十行内容
```
ls
ls -ali /home/test/
cd /
cat /etc/passwd
tail /etc/passwd
```
### 用netstat统计系统当前tcp连接的各种状态的连接数
```
netstat -ant |awk '$1~/^tcp$/{count[$6]++}END{for(state in count)print count[state],state}'
```
### 写一个脚本，实现判断10.10.10.0/24网络里，当前在线的ip有哪些。注：能ping通则认为在线
```bash
#!/bin/bash
CMD="ping -W 2 -c 2"
Ip="10.10.10."
for n in $(seq 254)
do
{
        $CMD $Ip$n &> /dev/null
        if [ $? -eq 0 ];then
           echo "$Ip$n is ok"
        fi
}&
done
```
### 怎么把脚本添加到系统服务里，即使用service来调用
vim /etc/init.d/test
```
#! /bin/bash
#
# test
#
# chkconfig: 2345 10 90
...
```
chkconfig管理
```
chkconfig --add test
```
service调用
```
service test [start|stop|restart|status]
```
### 统计指定文件中每个单词出现的次数；如
cat /etc/fstab
```
UUID=94e4e384-Oace-437f-bc96-057dd64f42ee / ext4 defaults.barrier=0 1 1
tmpfs /dev/shm tmpfs defults 0 0
```
```
egrep  -o '[a-z]+' /etc/fstab |awk '{count[$0]++}END{for(word in count)print count[word],word}'
```
### 练习：写一个脚本
列出如下菜单给用户
```
disk) show disks info;
mem) show memory info;
cpu) show cpu info;
*) quit;
```
提示用户给出自己的选择，而后显示对应其选择的相应系统信息
```bash
#!/bin/bash
while true;do
 cat <<-'EOF'
  disk) show disks info;
  mem) show memory info;
  cpu) show cpu info;
  *) quit;
 EOF
 read -p '请输入要查看的信息: ' option
 case $option in
 disk)
  df -h
  ;;
 mem)
  free -h
  ;;
 cpu)
  lscpu
  ;;
 *)
  exit
 esac
done
```
### 说明以下shell 代码，所完成的功能
```bash
n=1
while [ $n -lt 1000 ]
do
  cd /root/perl_test/testdir
  touch $n.txt
  n=`expr $n + 1`
done
```
在/root/perl_test/testdir目录下创建1.txt 2.txt 3.txt ... 999.txt
### 用最熟悉的脚本语言实现如下功能
如果在/home/pushmail目录下不存在leadtone目录，则创建该目录，并将/var/sync/bin目录下的所有文件拷贝到leadtone目录下，但是不能够拷贝文件长度大于1M的文件
```bash
#!/bin/bash
[ -d /home/pushmail/leadtone ] || mkdir /home/pushmail/leadtone -p
find /var/sync/bin -type f  ! -size +1M |xargs cp -t /home/pushmail/leadtone/
```
### 查找含有特定字符的文件
```
grep -l 'test' *
```
### Centos操作系统历史命令记录中，执行次数最多的5条
```
history |awk '{count[$4]++}END{for(cmd in count)print count[cmd],cmd}' |sort -nr |head -5
```
### 写一个脚本，判断一个指定的脚本是否是语法错误，如果有错误，则提醒用户键入Q或者q无视错误并退出其它任何键可以通过vim打开这个指定的脚本
```
#!/bin/bash
read -p "请输入要检测的脚本: " script
if ! sh -n $script &> /dev/null;then
  read -p "${script}有错误,请输入[Q|q]退出: " key
  case $key in
  Q|q)
 exit
 ;;
  *)
 vim $script
  esac
fi
```
### 用Shell编程，判断一文件是不是字符设备文件，如果是将其拷贝到 /dev 目录下
```
[ -c file ] && cp file /dev/
```
### 写一个脚本，实现批量添加20个用户，用户名为user01-20，密码user后面跟5个随机字符
```bash
#!/bin/bash
. /etc/init.d/functions
RETVAL=0
for n in {01..20}
do
        useradd user$n &>/dev/null
        RETVAL1=$?
        pass=`echo $RANDOM|md5sum|cut -c 2-6`
        echo "$pass"|passwd --stdin user$n &>/dev/null && \
        echo -e "user$n $pass" >> /tmp/user.txt
        RETVAL2=$?
        if [ $RETVAL1 -eq 0 -a $RETVAL2 -eq 0 ]
                then
                   action "add user is ok" /bin/true
                else
                   action "add user is fail" /bin/false
    fi
done
```
### 统计nginx访问日志，找出访问次数前10的IP
```
awk '{count[$1]++}END{for(ip in count)print count[ip],ip}' access.log |sort -nr |head
```
### 找出在文件a中但不在文件b中的内容，用命令后编写脚本实现
```bash
#!/bin/bash
while read line;do
  if grep -w $line a &> /dev/null && ! grep -w $line b &> /dev/null ;then
    echo $line
  fi
done < a
```
### 对文件test中，1>第一列为aaa的行求和；2>对偶数行求和；3>求文件test中的最大值
```
awk '$1~/aaa/{sum+=$2}END{print sum}' test.txt

awk 'NR%2==0{sum+=$2}END{print sum}' test.txt

awk 'BEGIN{max=0}{if($2>max) max=$2}END{print max}' test.txt
```
### Case语句的语法？while 语句的语法？continue命令的作用？
```
case $变量名 in
value1)
 cmd1
 ;;
value2)
 cmd2
 ;;
value3)
 cmd3
 ;;
*)
 cmd
esac
```
```
while 条件;do
 command
done
```
continue结束当次循环,进入下次循环
### 请写出下列shell脚本：使用for循环在/opt目录下通过随机小写10个字母加固定字符串test批量创建10个html文件，创建完成后将test全部改为test_done（for循环实现），并且html大写
```bash
#!/bin/bash
cd /opt && {
for((i=0;i<10;i++))
do
  SEQ=$(openssl rand -base64 40 |sed 's#[^a-z]##g' |cut -c1-10)
  touch ${SEQ}test.html
  mv ${SEQ}test.html ${SEQ}test_done.HTML
done
}
```
### 在UNIX操作系统中，若用户键入的命令参数的个数为1时，执行cat 2<$1命令，请将下面所示的shell程序的空缺部分补齐
```
case （_____）in
cat $1
cat >>1
*)echo 'defult...'
case
$#
$@
$$
$*
```
$#
### 如何在每天23:59分时，将apache的accesslog中，访问次数最多的前10个ip以及访问量最多的10个文件保存到/var/Top.log中
```
awk '$4>="[22/Nov/2015:11:40:00" && $4<="[22/Nov/2015:11:40:59"{count[$1]++}END{for(i in count)print count[i],i}' access.log  |sort -nr |head

awk '$4>="[22/Nov/2015:11:40:00" && $4<="[22/Nov/2015:11:40:59"{count[$7]++}END{for(i in count)print count[i],i}' access.log  |sort -nr |head
```
### shell脚本编程：求100以内的质数
```bash
#!/bin/bash
for ((num=2;num<=100;num++));do
  flag=0
  for ((i=2;i<num;i++));do
     if ((num%i==0));then
       flag=1
       break
     fi
  done
  if ((flag!=1));then
    flag=0
    echo $num
  fi
done
```
### 如果有10个文件夹，每个文件夹都有1,000,000个url，每个url对应一个访问量，请问如何最快找出前1,000,000个访问量最高的url
准备环境
```
echo 3452 > a/aaa.baidu.com
echo 398 > a/bbb.baidu.com
echo 29876 > a/ccc.baidu.com
echo 34 > b/ddd.baidu.com
echo 123 > b/eee.baidu.com
echo 43562 > b/fff.baidu.com
echo 4356299999999999999 > c/ggg.baidu.com
echo 4356223 > c/hhh.baidu.com
echo 6223 > c/iii.baidu.com
```
```bash
#!/bin/bash
for dir in $(ls);do
  if [ -d $dir ];then
    for file in $(ls $dir);do
      cat ${dir}/$file >> /tmp/1000000.log
    done
  fi
done
sort -rn /tmp/1000000.log |head -1
```
### 创建一个shell脚本，它从用户那里接收10个数，并显示已输入的最大的数
```bash
#!/bin/bash
max=0
read -a num -p "请输入10个数字: "
for i in ${num[*]};do
  if ((i>max));then
    max=$i
  fi
done
echo $max
```
### 设计一个shell程序，在每月第一天备份并压缩/etc目录的所有内容，存放在/root/bak目录里，且文件名为如下形式yymmdd_etc，yy为年，mm为月，dd为日。shell程序fileback存放在/usr/bin目录下
/usr/bin/fileback
```
#!/bin/bash
cd /
tar zcf /root/bak/$( date +%Y%m%d)_etc.tar.gz etc
```
crontab -e
```
00 00 1 * * /usr/bin/fileback &> /dev/null
```
### 找出系统中父进程号为105的所有进程，并将其结束
```
ps -ef |awk '$3==105{print "kill "$2}'|bash
```
### 如何从history记录中分析最近500次内执行最多的命令？如何查找当前目录90天以前的文件并将其删除？
```
history |tail -500 |awk '{count[$2]++}END{for(cmd in count)print count[cmd],cmd}' |sort -n|tail -1
```
```
find . -type f -mtime +90 -delete
```
### 写出命令统计当前连接到本机6379端口连接数最高的ip地址和连接个数，查看自己的ip地址，看这个ip地址所在网段都有哪些机器，任意查看此网段的另外一个ip地址有哪些端口开放了。简述tcp的几种连接状态，高并发服务器一般会遇到什么问题？
```
netstat -antup |awk '$1~/^tcp$/' |awk -F '[: ]+' '{count[$5" "$6]++}END{for(i in count)print count[i],i}' |sort -nr |head -1
```
```
ip a
```
```bash
#!/bin/bash
CMD="ping -W 2 -c 2"
Ip="10.10.10."
for n in $(seq 254)
do
{
        $CMD $Ip$n &> /dev/null
        if [ $? -eq 0 ];then
           echo "$Ip$n is ok"
        fi
}&
done
```
```
nmap -p1-65535 10.10.10.123
```
### 下面给出了一个shell程序，试对其行后有#（号码）形式的语句进行解释，并说明程序完成的功能
```
!/bin/bash
DICNAME=ls /root |grep bak   #(1)  /root目录下过滤bak文件赋值给变量DICNAME
if [ -z "$DICNAME" ] then    #(2)   变量DICNAME值是否为空
mkdir /root/bak cd /root/bak  #(3)  创建bak并进入bak目录
fi
YY=date +%y MM=date +%m DD=date +%d  #(4) 定义三个时间相关的变量
BACKETC=$YY$MM$DD_etc.tar.gz         #(5) 定义备份文件变量
tar zcvf $BACKETC /etc                #(6) 打包/etc目录
echo "fileback fiaished!"
```
程序完成功能:备份/etc目录到/root/bak下
### 试编写一个Shell程序，该程序能接收用户从键盘输入的100个整数，然后求出其总和、最大值及最小值
```bash
#!/bin/bash
max=0
read -a num -p "请输入100个整数: "
for i in ${num[*]};do
  if ((i>max));then
    max=$i
  fi
done
min=${num[0]}
for ((j=1;j<${#num[*]};j++));do
  if ((${num[j]}<min));then
    min=${num[$j]}
  fi
done
for k in ${num[*]};do
  ((sum+=k))
done
echo $sum
echo $max
echo $min
```
### 请用自己熟悉的脚本语言，快速替换notice服务下config.properties配置文件中所有变量值为jdbc.username,jdbc.password的值为blue和pass1234 说明：配置文件的目录/opt/blue/notice/conf/config.properties
config.properties文件格式如下
```ini
zookeeper.server=127.0.0.1:2181
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://lx-db:3306/gudong
jdbc.username=lanxin
jdbc.password=OnLIDX5
```
```
sed -e '/^jdbc.username=/c jdbc.username=blue' -e '/^jdbc.password=/c jdbc.password=pass1234' config.properties
```
### 判断数字大于500则执行big.sh 小于等于500则退出脚本，并输出报错信息
```bash
#!/bin/bash
read -p '请输入一个数字: ' num
if [ $num -gt 500 ];then
  sh big.sh
else
  echo error  && exit
fi
```
### 处理以下文件内容，将域名取出并进行计数排序
```
http://www.baidu.com/index.html
http://www.baidu.com/1.jpg
http://post.baidu.com/index.php
http://mp3.baidu.com/index.jsp
http://www.baidu.com/3.html
http://post.baidu.com/2.bmp
```
得到如下结果：
域名的出现的次数 域名
```
3 www.baidu.com
2 post.baidu.com
1 mp3.baidu.com
```
```
awk -F '/' '{count[$3]++}END{for (url in count) print count[url],url}' url.txt |sort -rn
```
### 文件ip.txt中包含很多IP地址（以及其它非IP数据），请打印出满足A.B.C.D 其中A=172 C=130 D<=100 条件的所有IP（请用AWK实现）
```
awk -F '.' '$1==172&&$2<=255&&$3==130&&$4<100{OFS=".";print}' ip.txt
```
### 请编写一个可递归创建3级hash目录的shell脚本，hash目录名分别为 a b c d e f 0 1 2 3 4 5 6 7 8 9 (请用bash实现)
```
mkdir -p {a,b,c}/{d,e,f}/{0..9}
```
### 统计web服务器上网络连接的各个状态（ESTABLISHED/SYN_SENT/SYN_RECV等）的个数并按倒序排列
```
netstat -ant |awk '$1~/^tcp$/{count[$NF]++}END{for (state in count)print count[state],state}' |sort -nr
```
### 脚本测试test.txt文件
```
1 2 3
4 5 6
7 8 9
```
打印出每一列的累加值
```
awk '{a+=$1;b+=$2;c+=$3}END{print a,b,c}' test.txt
```
### 请在linux下写个bash shell 程序，目的如下：查找/opt/mp3目录下所有mp3后缀的文件，然后计算下每个md5值，文件名跟md5值写入新的文件mp3-md5.txt文件
```
find /opt/mp3 -type f -name "*.mp3"|xargs md5sum > mp3-md5.txt
```
### 请写出完成下面工作的Linux shell命令或脚本
（1）查看服务器的硬盘占用量
（2）将/usr/test目录下大于100K的文件转移到/tmp目录下
（3）杀死所有启动的servicefx_asr进程
（4）假设某nginx server的日志access.log如下：
```
198.24.230.194 - - [10/Oct/2015:10:23:50 +0800] “POST /asr/recognize HTTP/1.1 200 177 “-” ”-”
```
请查找在2015/10/10,10点这一个小时内，访问“/CheckAuth”接口的IP一共有几个，每个各访问了多少次
```
df -h
```
```
find /usr/test -type f -size +100k |xargs mv -t /tmp/
```
```
pkill servicefx_asr
```
```
awk '$4>="[10/Oct/2015:10:00:00" && $4<="[10/Oct/2015:10:59:59"{if($7=="/CheckAuth"){count[$1]++}}END{for(ip in count)print count[ip],ip}' access.log
```
### 执行$ time sleep 2 输出如下
```
real 0m2.003s
user 0m0.004s
sys 0m0.000s
```
请说明real、user、sys三者具体代表的意思和区别
```
real时间是指命令开始执行到结束的时间。这个短时间包括其他进程所占用的时间片，和进程被阻塞时所花费的时间。
```
```
user时间是指进程花费在用户模式中的CPU时间，这是唯一真正用于执行进程所花费的时间，其他进程和花费阻塞状态中的时间没有计算在内。
```
```
sys时间是指花费在内核模式中的CPU时间，代表在内核中执系统调用所花费的时间，这也是真正由进程使用的CPU时间。
```
### 编写脚本完成以下工作
某目录下有两个文件a.txt和b.txt，文件格式为(ip username)，例如：
a.txt    b.txt
127.0.0.1 zhangsan     127.0.0.4 lixiaoliu
127.0.0.1 wangxiaoer   127.0.0.1 lisi
127.0.0.2 lisi
127.0.0.3 wangwu
每个文件至少有100万行，请使用Linux命令完成下列工作
1）两个文件各自的IP数，以及总IP数
2）出现再b.txt而没有出现再a.txt的IP
3）每个username出现的次数，以及每个username对应的IP数
1)
```
awk '{count[$1]++}END{for(ip in count)print count[ip],ip}' a.txt |wc -l
awk '{count[$1]++}END{for(ip in count)print count[ip],ip}' b.txt |wc -l
```
```
awk '{count[$1]++}END{for(ip in count)print count[ip],ip}' a.txt b.txt |wc -l
```
2)
```bash
#!/bin/bash
while read line;do
  IP=$(echo $line |awk '{print $1}')
  if ! grep $IP a.txt &> /dev/null;then
    echo $IP
  fi
done < b.txt
```
3)
```
awk '{count[$2]++}END{for(user in count)print count[user],user}' a.txt b.txt
```
### 现在一个REST API服务（名称为ab-service），进程启动后占用8038端口进行网络通信。现需要一个Bash Shell脚本（start.sh），在一台Linux机器上启动这个服务，并通过8038端口对所有内外网IP服务。请写出完整的可运行脚本，并尽量考虑可能出现的情况并处理
vim /usr/bin/start.sh
```bash
#!/bin/bash
case "$1" in
start)
 if ss -lntup |grep 8038 &> /dev/null;then
  echo "ab-service is running"
 else
  ab-service start &>> /var/log/ab-server.log
  if ss -lntup |grep 8038 &> /dev/null;then
   echo "ab-service start succese !"
  else
   echo " ab-service start fail !!!"
  fi
 fi
 ;;
stop)
 if ss -lntup |grep 8038 &> /dev/null;then
  ab-service stop &>> /var/log/ab-service.log
  if ! ss -lntup |grep 8038 &> /dev/null;then
   echo "ab-service stop succece!"
  else
   echo "ab-service stop fail !!!"
  fi
 else
  echo "ab-service is stopped"
 fi
 ;;
*)
 echo $"Usage: $0 {start|stop|status|restart|force-reload}"
esac
```
