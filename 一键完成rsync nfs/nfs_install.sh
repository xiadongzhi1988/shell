#!/bin/sh

[ `rpm -qa rpcbind |wc -l` -eq 0 ] && yum install rpcbind -y
[ `rpm -qa nfs-utils |wc -l` -eq 0 ] && yum install nfs-utils -y
/etc/init.d/rpcbind start
/etc/init.d/nfs start
chkconfig rpcbind on && chkconfig --list rpcbind
chkconfig nfs on && chkconfig --list nfs
[ ! -d /backup ] && mkdir /backup
[ ! -d /data ] && mkdir /data
useradd -u 888 rsync -s /sbin/nologin -M
chown -R rsync.rsync /backup /data

cat >  /etc/exports <<EOF
/data   172.16.1.0/24(rw,sync,anonuid=888,anongid=888,all_squash)
EOF
/etc/init.d/nfs reload
