#!/bin/bash
DATE=`date -d -10min '+%Y%m%d%H%M'`
#DATE=201601081415
DIR=`ls -l /data/lte_xdr/chengdu |sed '1d' |awk '{print $NF}'`
for m in ${DIR}
do
ftp -i -n -v <<!
open 10.101.235.153
user evercdata Ev\$IpM9D
binary 
cd /chengdu/$m
lcd /data/lte_xdr/chengdu/$m
mget *$DATE*.txt
colse
bye
!
done