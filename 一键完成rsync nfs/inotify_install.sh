#!/bin/sh

[ ! -f /etc/yum.repos.d/epel.repo ] && wget -O /etc/yum.repos.d/epel.repo  http://mirrors.aliyun.com/repo/epel-6.repo
[ `rpm -qa inotify-tools |wc -l` -eq 0 ] && yum -y install inotify-tools
