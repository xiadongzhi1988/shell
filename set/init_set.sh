#!/bin/sh

if [ $# -ne 2 ];then
  echo "/bin/sh $0 hostname eth0IP"
  exit 1
fi

HOST="`sed -nr 's#^HOSTNAME=(.*)#\1#gp' /etc/sysconfig/network`"
IP="`sed -nr 's#^IPADDR=(.*)#\1#gp' /etc/sysconfig/network-scripts/ifcfg-eth0`"

sed -i "s#HOSTNAME=${HOST}#HOSTNAME=$1#g" /etc/sysconfig/network
sed -i "s#IPADDR=${IP}#IPADDR=$2#g" /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i "/^HWADDR/d;/^UUID/d" /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i "/^HWADDR/d;/^UUID/d" /etc/sysconfig/network-scripts/ifcfg-eth1
>/etc/udev/rules.d/70-persistent-net.rules
