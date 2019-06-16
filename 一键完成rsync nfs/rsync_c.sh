#!/bin/sh

[ `rpm -qa rsync |wc -l` -eq 0 ] && yum install rsync -y

echo "123" >/etc/rsync.password
chmod 600 /etc/rsync.password
