#/bin/bash



case "$1" in
computer)
dmidecode | grep "Product Name"
;;
kernel)
KERNEL=`uname -r`
echo "kernel version : $KERNEL"
;;
sys)
SYS=`cat /etc/redhat-release`
BIT=`getconf -a |grep -i long|awk 'NR==1{print $2}'`
echo "system version : $SYS"
echo "system bit : $BIT"
;;
cpu)
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
TOTAL=`cat /proc/cpuinfo |grep "physical id" |sort |uniq |wc -l`
CORE=`grep 'core id' /proc/cpuinfo | sort -u | wc -l`
PROCESSOR=`cat /proc/cpuinfo |grep processor |wc -l`
echo "cpu physical : $TOTAL"
echo "cpu core : $CORE"
echo "cpu processor : $PROCESSOR"
;;
cpubit)
CPUBIT=`getconf LONG_BIT`
echo $CPUBIT
;;
mem)
echo -e "`free -m`\n\n`free -g`"
;;
memnum)
dmidecode|grep -P -A5 "Memory\s+Device"|grep Size|grep -v Range
;;
memmax)
dmidecode|grep -P 'Maximum\s+Capacity'
;;
memrate)
dmidecode|grep -A16 "Memory Device"|grep 'Speed'
;;
disk)
fdisk -l |egrep "/dev/sd*"
echo ""
df -h
;;
network)
A1=`ifconfig |grep eth0|cut -f 1 -d " "`
A2=`ifconfig |grep eth0 |awk '{print $5}'`
A3=`ifconfig |grep "inet addr"|awk 'NR==1{print $0}'|cut -d ":" -f 2|cut -d " " -f 1`
B1=`ifconfig |grep eth1|cut -f 1 -d " "`
B2=`ifconfig |grep eth1 |awk '{print $5}'`
B3=`ifconfig |grep "inet addr"|awk 'NR==2{print $0}'|cut -d ":" -f 2|cut -d " " -f 1`
C1=`ifconfig |grep eth2|cut -f 1 -d " "`
C2=`ifconfig |grep eth2 |awk '{print $5}'`
C3=`ifconfig |grep "inet addr"|awk 'NR==3{print $0}'|cut -d ":" -f 2|cut -d " " -f 1`
D1=`ifconfig |grep eth3|cut -f 1 -d " "`
D2=`ifconfig |grep eth3 |awk '{print $5}'`
D3=`ifconfig |grep "inet addr"|awk 'NR==4{print $0}'|cut -d ":" -f 2|cut -d " " -f 1`
mii-tool eth0
mii-tool eth1
mii-tool eth2
mii-tool eth3
echo -e "$A1 \t $A2 \t $A3"
echo -e "$B1 \t $B2 \t $B3"
echo -e "$C1 \t $C2 \t $C3"
echo -e "$D1 \t $D2 \t $D3"
route -n
echo ""
ip route
;;
networkmessage)
dmesg | grep -i eth
;;
*)
       echo "Usage: get.sh {computer|kernel|sys|cpu|cpubit|mem|memnum|memmax|memrate|disk|network|networkmessage}"
        exit 1
esac
