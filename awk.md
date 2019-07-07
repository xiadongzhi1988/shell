# awk

标签（空格分隔）： shell编程

---
# Awk文本处理

1.进行逐行扫描文件(或流), 从第一行到最后一行
2.寻找匹配的特定模式的行,在行上进行操作
3.如果没有指定处理动作,则把匹配的行显示到标准输出
4.如果没有指定模式，则所有被操作的行都被处理

## awk的语法格式
```
awk [options] 'commands' filenames 
awk [options] -f awk-script-file filenames
```

### 选项 options
-F 定义输入字段分隔符，默认的分隔符, 空格或tab键

### 命令 command
行处理前        行处理     行处理后
```
BEGIN{}  {}  END{}
```

---
# Awk 工作原理
1.awk将文件中的每一行作为输入, 并将每一行赋给内部变量\$0, 以换行符结束

2.awk开始进行字段分解，每个字段存储在已编号的变量中，从$1开始[默认空格分割]

 3.awk默认字段分隔符是由内部FS变量来确定, 可以使用-F修订

4.awk行处理时使用了print函数打印分割后的字段

5.awk在打印后的字段加上空格，因为$1,$3 之间有一个逗号。逗号被映射至OFS内部变量中，称为输出字段分隔符， OFS默认为空格.

6.awk输出之后，将从文件中获取另一行，并将其存储在$0中，覆盖原来的内容，然后将新的字符串分隔成字段并进行处理。该过程将持续到所有行处理完毕.


---

# Awk内部变量

## $0保存当前记录的内容
```
awk '{print $0}' /etc/passwd
```

## NR记录输入总的编号(行号)
```
awk '{print NR,$0}' /etc/passwd
awk 'NR<=3' /etc/passwd
```

## FNR当前输入文件的编号(行号)
```awk
awk '{print NR,$0}' /etc/passwd /etc/hosts
awk '{print FNR,$0}' /etc/passwd /etc/hosts
```

## NF保存行的最后一列
```
awk -F ":" '{print NF,$NF}' /etc/passwd /etc/hosts
```

## FS指定字段分割符, 默认是空格

### //以冒号作为字段分隔符
```
awk -F: '/root/{print $1,$3}' /etc/passwd

awk 'BEGIN{FS=":"} {print $1,$3}' /etc/passwd
```

### //以空格冒号tab作为字段分割
```
awk -F'[ :\t]' '{print $1,$2,$3}' /etc/passwd
```

## OFS指定输出字段分隔符

### //,逗号映射为OFS, 初始情况下OFS变量是空格
```
awk -F: '/root/{print $1,$2,$3,$4}' /etc/passwd

awk 'BEGIN{FS=":"; OFS="+++"} /^root/{print $1,$2}' /etc/passwd
```

## RS输入记录分隔符，默认为换行符[了解]
```
awk -F: 'BEGIN{RS=" "} {print $0}' /etc/hosts
```

## ORS将文件以空格为分割每一行合并为一行
```
awk -F: 'BEGIN{ORS=" "} {print $0}' /etc/hosts
```

## print 输出函数
```
date|awk '{print $2,"5月份""\n",$NF,"今年"}'

awk -F: '{print "用户是:" $1 "\t 用户uid: " $3  "\t 用户gid:" $4}' /etc/passwd
```

## printf 格式化输出函数
```
awk -F: '{printf "%-15s %-10s %-15s\n", $1, $2, $3}' /etc/passwd
```

%s 字符类型
%d 数值类型
占 15 字符
- 表示左对齐，默认是右对齐
printf 默认不会在行尾自动换行，加\n

---

# Awk模式动作

awk语句都由模式和动作组成。
模式部分决定动作语句何时触发及触发事件。
如果省略模式部分，动作将时刻保持执行状态。模式可以是条件语句或复合语句或正则表达式。

## 1.正则表达式

### //匹配记录（整行）
```
awk '/^root/' /etc/passwd
awk '$0 ~ /^root/' /etc/passwd
```

### //匹配字段：匹配操作符（~ !~）
```
awk '$1~/^root/' /etc/passwd
awk '$NF !~ /bash$/' /etc/passwd
```

## 2.比较表达式

比较表达式采用对文本进行比较，只有当条件为真，才执行指定的动作。
比较表达式使用关系运算符，用于比较数字与字符串

### 关系运算符

|运算符    | 含义    |     示例 |
| -------- | ------- | ------  |
| <        |小于     |     x < y   |
| <=       | 小于或等于  |   x<=y |
| ==      | 等于     |     x==y   |
| !=      | 不等于   |     x!=y  |
| \>=      | 大于等于 |       x>=y |
| >       | 大于       |   x>y   |


//uid为0的列出来
```
awk -F ":" '$3==0' /etc/passwd
```

//uid小于10的全部列出来
```
awk -F: '$3 < 10' /etc/passwd
```


//用户登陆的shell等于/bin/bash
```
awk -F: '$7 == "/bin/bash" ' /etc/passwd
```

//第一列为alice的列出来
```
awk -F: '$1 == "alice" ' /etc/passwd
```

//为alice的用户列出来
```
awk -F: '$1 ~ /alice/' /etc/passwd
awk -F: '$1 !~ /alice/' /etc/passwd
```

//磁盘使用率大于多少则，则打印可用的值
```
df |awk '/\/$/'|awk '$3>1000000 {print $4}'
```

## 3.条件表达式
```
awk -F: '$3>300 {print $0}' /etc/passwd
awk -F: '{if($3>300) print $0}' /etc/passwd
awk -F: '{if($3>5555){print $3} else {print $1}}' /etc/passwd
```


## 4.运算表达式
```
awk -F: '$3 * 10 > 500000' /etc/passwd

awk -F: 'BEGIN{OFS="--"} { if($3*10>50000) {print $1,$3} } END {print "打印ok"}' /etc/passwd

awk '/southem/{print $5 + 10}' file 
awk '/southem/{print $5 + 1.5}' file
awk '/southem/{print $8 - 8}' file 
awk '/southem/{print $8 / 3 }' file  
awk '/southem/{print $8 * 4 }' file 
awk '/southem/{print $8 % 2 }' file
```

## 5.逻辑操作符和复合模式

&&逻辑与 || 逻辑或  !逻辑非 

//匹配用户名为root并且打印uid小于15的行
```
awk -F: '$1~/root/ && $3<=15' /etc/passwd 
```

//匹配用户名为root或uid大于5000
```
awk -F: '$1~/root/ || $3>=5000' /etc/passwd
```

awk示例1
```
 awk '/west/' file 
 awk '/^north/' file 
 awk '$3 ~ /^north/' file 
 awk '/^(no|so)/' file 
 awk '{print $3,$2}' file
 awk '{print $3 $2}' file 
 awk '{print $0}' file 
 awk '{print "Number of fields: "NF}' file 
 awk '/northeast/{print $3,$2}' file
 awk '/^[ns]/{print $1}' file 
 awk '$5 ~ /\. [7-9]+/' file 
 awk '$2 !~ /E/{print $1,$2}' file 
 awk '$3 ~ /^Joel/{print $3 "is a nice boy."}' file 
 awk '$8 ~ /[0-9][0-9]$/{print $8}' file
 awk '$4 ~ /Chin$/{print "The price is $" $8 "."}' file 
awk '/Tj/{print $0}' file 
awk -F: '{print "Number of fields: "NF}' /etc/passwd 
awk -F"[ :]" '{print NF}' /etc/passwd 
```

## 三目运算符
迭代是重复反馈过程的活动，其目的通常是为了逼近所需目标或结果。每一次对过程的重复称为一次“迭代”，而每一次迭代得到的结果会作为下一次迭代的初始值
```
[root@web03 ~]# cat lessons.txt 
634751 预排
568688 预排
386760 删除
619373 预排
428491 预排
487563 完成
603342 完成
436339 完成
结果：
删除  386760
完成  487563,603342,436339
预排  634751,568688,619373,428491

[root@web03 ~]# awk '{a[$2]=a[$2]" "$1}END{for(i in a) print i,a[i]}' lessons.txt
删除  386760
完成  487563 603342 436339
预排  634751 568688 619373 428491
[root@web03 ~]# awk '{a[$2]=a[$2]","$1}END{for(i in a) print i,a[i]}' lessons.txt
删除 ,386760
完成 ,487563,603342,436339
预排 ,634751,568688,619373,428491
[root@web03 ~]# awk '{a[$2]=a[$2]?a[$2]","$1:a[$2]$1}END{for(i in a) print i,a[i]}' lessons.txt
删除 386760
完成 487563,603342,436339
预排 634751,568688,619373,428491
[root@web03 ~]# awk '{if(a[$2]){a[$2]=a[$2]","$1}else{a[$2]=a[$2]$1}}END{for(i in a) print i,a[i]}' lessons.txt
删除 386760
完成 487563,603342,436339
预排 634751,568688,619373,428491
```

---

# awk条件
## if
语句格式:
{ if(表达式)｛语句;语句;... ｝}

//打印当前管理员用户名称
```
awk -F: '{ if($3==0){print $1 "is adminisitrator"} }' /etc/passwd
```

//统计系统用户数量
```
awk -F: '{ if($3>0 && $3<1000){i++}} END {print i}' /etc/passwd
```

//统计普通用户数量
```
awk -F: '{ if($3>1000){i++}} END {print i}' /etc/passwd
```

写出一个shell脚本，把当前目录下的文本文件number.txt里面数字大于100的求和并输出，并打印所在行行号及内容，最后还要输出每一行的总和。
[root@m01 ~]# cat number.txt
100
98
205
303
1
99
66
33

```
awk '{if($1>100){sum+=$1;print NR,$0}}{i+=$1}END{print sum,i}' number.txt 
3 205
4 303
508 905
```



## if...else 
语句格式: 
{if(表达式)｛语句;语句;... ｝else{语句;语句;...}}
```
awk -F: '{if($3==0){print $1} else {print $7}}' /etc/passwd
awk -F: '{if($3==0) {count++} else{i++} }' /etc/passwd
awk -F: '{if($3==0){count++} else{i++}} END{print " 管理员个数: "count ; print " 系统用户数: "i}' /etc/passwd
```

## if...else if...else
语句格式:
{if(表达式 1)｛语句;语句；... ｝else if(表达式 2)｛语句;语句；. .. ｝else｛语句;语句；... ｝}

```
awk -F: '{ if($3==0){i++} else if($3>0 && $3<1000){j++} else if($3>1000) {k++}} END {print i;print j;print k}' /etc/passwd

awk -F: '{ if($3==0){i++} else if($3>0 && $3<1000){j++} else if($3>1000) {k++}} END {print "管理员个数"i; print "系统用户个数" j; print "系统用户个 数" }' /etc/passwd
管理员个数1
系统用户个数29
系统用户个数69
```

## switch-case
```
BEGIN{
  a=2;
  b=2;
  c=3
  switch(a){
  case 1: print a;break;
  case 2: print b;break;
  case 3: print c;break;
  }
}
```

---

# awk循环语句

## for循环

### C格式 
for(初值;终值;步长值){语句}

```
awk 'BEGIN{for(i=1;i<=5;i++){print i} }' 
//将每行打印 10 次
awk -F: '{ for(i=1;i<=10;i++) {print $0} }' passwd
```
### 列表
for(变量 in 数组){语句}


## while循环
```
awk 'BEGIN{ i=1; while(i<=10){print i; i++} }'
awk -F: '{i=1; while(i<=NF){print $i; i++}}' /etc/passwd
awk -F: '{i=1; while(i<=10) {print $0; i++}}' /etc/passwd

cat a.txt
111 222
333 444 555
666 777 888 999

awk '{i=1;while(i<=NF){print $i;i++}}' a.txt
```

用awk获取文件中第三列打到倒数第二列字段
```
awk.awk
#!/usr/bin/awk
BEGIN{
FS=":"
OFS=":"
}
{
t=$2;
i=2;
while (i<NF-1)
{
  $i=$(i+1);
  i++;
}
$(NF-1)=t;
print $0;
}
```
运行
```
awk -f awk.awk /etc/passwd
```



## do-while
```
do
{语句}
while(条件)
```

## break	  
当 break 语句用于 while 或 for 语句时，导致退出程序循环

## continue	  
当 continue 语句用于 while 或 for 语句时，使程序循环移动到下一个迭代

## next	    
能能够导致读入下一个输入行，并返回到脚本的顶部。这可以避免对当前输入行执行其他的操作过程

## exit	     
语句使主输入循环退出并将控制转移到END,如果END存在的话。如果没有定义END规则，或在END中应用exit语句，则终止脚本的执行

---

# awk数组
```
awk -F: '{username[++i]=$1} END{print username[1]}' /etc/passwd
awk -F: '{username[i++]=$1} END{print username[1]}' /etc/passwd
awk -F: '{username[i++]=$1} END{print username[0]}' /etc/passwd
```

注意:将需要统计的某个字段作为数组的索引，最后对索引进行遍历

## 按索引遍历
```
awk -F: '{username[x++]=$1} END{for(i in username) {print i,username[i]} }' /etc/passwd

awk -F: '{username[++x]=$1} END{for(i in username) {print i,username[i]} }' /etc/passwd
```


### 1.统计/etc/passwd 中各种类型 shell 的数量
```
awk -F: '{shells[$NF]++} END{ for(i in shells){print i,shells[i]} }' /etc/passwd
```

### ２.网站访问状态统计
```
ss -an|awk '/:80/{tcp[$2]++} END {for(i in tcp){print i,tcp[i]}}'
```

### 3.统计当前访问的每个IP的数量
```
ss -an|awk -F ':' '/:80/{ips[$(NF-1)]++} END {for(i in ips){print i,ips[i]}}'
```

## Awk数组案例
Nginx日志分析，日志格式如下：
```
log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

52.55.21.59 - - [25/Jan/2018:14:55:36 +0800] "GET /feed/ HTTP/1.1" 404 162 "https://www.google.com/" "Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; de) Presto/2.9.168 Version/11.52" "-"
```

1.统计2018年01月25日,当天的PV量
```
grep "22/Nov/2015" access.log |wc -l
awk '/22\/Nov\/2015/{i++}END{print i}' access.log
```

//统计15-19点的pv量
```
awk '$4>="[25/Jan/2018:15:00:00" && $4<="[25/Jan/2018:19:00:00 {print $0}"' access.log |wc -l
```

2.统计2018年01月25日,一天内访问最多的10个IP
```
awk '/25\/Jan\/2018/ {ips[$1]++} END {for(i in ips){ print ips[i],i}}' access.log |sort -rn|head
```

//统计15-19点访问次数最多的10个IP
```
awk '$4>="[25/Jan/2018:15:00:00" && $4<="[25/Jan/2018:19:00:00"' access.log |awk '{ips[$1]++} END {for(i in ips){print ips[i],i}}'|sort -rn|head
```

3.统计2018年01月25日,访问大于100次的IP
```
awk '/25\/Jan\/2018/ {ips[$1]++} END {for(i in ips){if(ips[i]>10){print i,ips[i]}}}' access.log
```

4.统计2018年01月25日,访问最多的10个页面($request top 10)
```
awk '/25\/Jan\/2018/ {request[$7]++} END {for(i in request){print request[i],i}}' access.log |sort -rn|head
```

5.统计2018年01月25日,每个URL访问内容总大小($body_bytes_sent)
```
awk '/25\/Jan\/2018/ {request[$7]++;size[$7]+=$10} END {for(i in request){print request[i],i,size[i]}}' access.log |sort -rn|head
```

6.统计2018年01月25日,每个IP访问状态码数量($status)
```
awk '{ip_code[$1 " " $9]++} END {for(i in ip_code){print ip_code[i],i}}' access.log|sort -rn|head
```

7.统计2018年01月25日,访问状态码为404及出现的次数($status)
```
grep "404" log.bjstack.log |wc -l
awk '{if($9=="404") code[$9]++} END {for(i in code){print i,code[i]}}' access.log
```

8.统计2018年01月25日,8:30-9:00访问状态码是404
```
awk '$4>="[25/Jan/2018:15:00:00" && $4<="[25/Jan/2018:19:00:00" && $9=="404" {code[$9]++} END {for(i in code){print i,code[i]}}' access.log

awk '$9=="404" {code[$9]++} END {for(i in code){print i,code[i]}}' access.log
```

9.统计2018年01月25日,各种状态码数量
```
awk '{code[$9]++} END {for(i in code){print i,code[i]}}' access.log

awk 'BEGIN{i=j=k=n=p=0}{if($9>=100 && $9<200) {i++}
else if ($9>=200 && $9<300) {j++}
else if ($9>=300 && $9<400) {k++}
else if ($9>=400 && $9<500) {n++}
else if($9>=500) {p++}}
END{print i,j,k,n,p,i+j+k+n+p}' access.log
```

 awk数组练习
```
cat a.txt
a  1
b  3
c  2
d  7
b  5
a  3 
g  2
f  6
d  9


awk '{str[$1]+=$2}END{for (i in str){print i,str[i]}}' a.txt 
a 4
b 8
c 2
d 16
f 6
g 2


awk '{if(str[$1]){str[$1]=str[$1]" "$2}else{str[$1]=str[$1]$2}}END{for (i in str){print i,str[i]}}' a.txt 
a 1 3
b 3 5
c 2
d 7 9
f 6
g 2

```

```
awk -F '[ ]+' '$7~/(jpg|bmp|png|jpeg|gif)$/{count[$7]++;sum[$7]+=$10}END{for (i in count)print count[i]"次", i,sum[i]}' access.log
```


---

# awk函数

## awk内置函数
###  gsub
gsub(/正则匹配/,"替换后的内容",字段)
```
[root@oldboy files]# awk '$2~/^Xiaoyu$/{gsub(/:/,"$",$NF);print $NF}' reg.txt 
$155$90$201
```

```
[root@m01 ~]# cat test 
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin

[root@m01 ~]# awk '{gsub("root","wuxing");print > "test"}' test
[root@m01 ~]# cat test 
wuxing:x:0:0:wuxing:/wuxing:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/wuxing:/sbin/nologin
```

### substr
substr(某一列,从第几个字符开始,截取几个字符结束)
```
echo abcdefghi |awk '{print substr($1,6,2)}'
fg
```

每分钟每个资源的访问次数最多的10个
```
awk '{a[substr($4,2,17)" "$7]++}END{for (i in a) print a[i],i}' access.log |sort -rn |head
151 22/Nov/2015:11:37 /online/api/mc/cart/new/getCart.json
117 22/Nov/2015:11:29 /online/api/mc/cart/new/getCart.json
116 22/Nov/2015:11:38 /online/api/mc/cart/new/getCart.json
110 22/Nov/2015:11:38 /online/api/mc/sys/nowTime.json
109 22/Nov/2015:11:34 /online/api/mc/cart/new/getCart.json
108 22/Nov/2015:11:30 /online/api/mc/cart/new/getCart.json
104 22/Nov/2015:12:00 /online/api/mc/sys/nowTime.json
104 22/Nov/2015:11:36 /online/api/mc/cart/new/getCart.json
104 22/Nov/2015:11:27 /online/api/mc/sys/nowTime.json
103 22/Nov/2015:11:30 /online/api/mc/sys/nowTime.json
```

###  split
精确切割
split(s, a [, r])
split(某一列,数组名字,/正则表达式/)
把某一列通过正则表达式切割，切完后放到数组中
> * 注意:数组元素是从1开始

```
echo GET /mobile/theme/oldboy/common/images/arrow-down2.png
GET /mobile/theme/oldboy/common/images/arrow-down2.png

echo GET /mobile/theme/oldboy/common/images/arrow-down2.png |awk '{split($2,arr,/\./);print arr[1]}'
/mobile/theme/oldboy/common/images/arrow-down2

echo GET /mobile/theme/oldboy/common/images/arrow-down2.png |awk '{split($2,arr,/\./);print arr[2]}'
png

echo GET /mobile/theme/oldboy/common/images/arrow-down2.png |awk '{split($2,arr,/\./);print arr[1],arr[2]}'
/mobile/theme/oldboy/common/images/arrow-down2 png

echo GET /mobile/theme/oldboy/common/images/arrow-down2.png |awk '{split($2,arr,/\./);for(i in arr) print i}'
1
2

echo GET /mobile/theme/oldboy/common/images/arrow-down2.png |awk '{split($2,arr,/\./);for(i in arr) print i,arr[i]}'
1 /mobile/theme/oldboy/common/images/arrow-down2
2 png
```

### system
awk调用shell命令
```
awk 'BEGIN{system("ls")}'
```


## awk自定义函数
awkfun.awk 
```
#!/usr/bin/awk
function sum(num1,num2)
{
  s=num1+num2;
  print s;
}

BEGIN{
  sum(1,2)
}
```

``` 
#!/usr/bin/awk
function sum(num1,num2)
{
  s=num1+num2;
  return s;
}

BEGIN{
  res=sum(1,2);
  print res;
}
```

运行awk脚本
```
awk -f awkfun.awk
```

---

#  awk命令行参数
ARGC是命令行参数数量 
ARGV是将命令行参数存到数组，元素由ARGC指定，数组下标从0开始 

```
awk 'BEGIN{print ARGC}' 1 2 3 
4 

awk 'BEGIN{print ARGV[0]}' 
awk 

awk 'BEGIN{print ARGV[1]}' 1 2 
1
```
