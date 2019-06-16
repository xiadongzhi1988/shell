#!/bin/sh
. /etc/init.d/functions
[ ! -f /server/scripts/iplist ] && echo "hostlists.txt is not exist." && exit 1

for IP in `cat /server/scripts/iplist`
do
#  scp -r /server root@$IP:/ &>/dev/null
   ssh root@$IP "/bin/sh /server/scripts/dis-sshkey.sh"
  if [ $? -eq 0 ];then
   action "$IP" /bin/true
  else
   action "$IP" /bin/false
  fi
done
