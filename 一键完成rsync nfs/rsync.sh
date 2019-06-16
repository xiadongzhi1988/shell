#!/bin/sh

[ `rpm -qa rsync |wc -l` -eq 0 ] && yum install rsync -y

[ ! -d /backup ] && mkdir /backup
[ ! -d /data ] && mkdir /data
useradd -u 888 rsync -s /sbin/nologin
chown -R rsync.rsync /backup /data
echo "rsync_backup:123" >/etc/rsync.password
chmod 600 /etc/rsync.password

cat > /etc/rsyncd.conf <<EOF
#rsync_config_____________________start
#created  by xdz 17:00 2016-5-21
#QQ 1226032602
##rsyncd.conf  start##
uid = rsync
gid = rsync
use chroot = no
max connections = 200
timeout = 300
pid file = /var/run/rsyncd.pid
lock file = /var/run/rsync.lock
log file = /var/log/rsyncd.log
ignore errors
read only = false
list = false
hosts allow = 172.16.1.0/24
hosts deny = 0.0.0.0/32
auth users = rsync_backup
secrets file = /etc/rsync.password
[backup]
path = /backup/
[data]
path = /data/
#rsync_config_____________________end
EOF

[ `lsof -i:873 |wc -l` -eq 0 ] && /usr/bin/rsync --daemon
[ `grep rsync /etc/rc.local |wc -l` -eq 0 ] && echo "/usr/bin/rsync --daemon" >> /etc/rc.local
