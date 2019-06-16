#!/bin/sh
###### 批量分发秘钥,调用 expect-copy-sshkey.exp #############
. /etc/init.d/functions
[ ! -f /server/scripts/iplist ] && echo "hostlists.txt is not exist." && exit 1

for host in `cat /server/scripts/iplist`
do
 expect expect-copy-sshkey.exp $host &>/dev/null
 if [ $? -eq 0 ];then
    action "$host dis data" /bin/true
 else
    action "$host dis data" /bin/false
 fi
done
