#!/bin/sh

IP="`sed -nr 's#^IPADDR=(.*)#\1#gp' /root/ifcfg-eth0`"

sed -i "s#IPADDR=${IP}#IPADDR=$1#g" /root/ifcfg-eth0
