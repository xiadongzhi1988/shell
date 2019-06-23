#!/bin/bash
source /etc/profile
IP="$(ip a s eth1 |awk -F "[ /]+" 'NR==3{print $3}')"
BAK_DIR="/backup"
RSYNC_AUTH_NAME="rsync_backup"
RSYNC_HOST_ADDR="172.16.1.41"
RSYNC_MODULE_NAME="backup"
RSYNC_PASS_FILE="/etc/rsync.pass"
DATE="$(date +%F -d -1day)"
if (($(date +%w -d -1day)==1));then
  DATE="$(date +%F_%w -d -1day)"
fi

mkdir $BAK_DIR/$IP -p
cd /
tar zchf $BAK_DIR/$IP/${DATE}_etc.tar.gz   etc/hosts etc/fstab etc/passwd etc/rc.local var/spool/cron/root
md5sum $BAK_DIR/$IP/${DATE}*.tar.gz > $BAK_DIR/$IP/flag.txt
rsync -az $BAK_DIR/* $RSYNC_AUTH_NAME@$RSYNC_HOST_ADDR::$RSYNC_MODULE_NAME --password-file=$RSYNC_PASS_FILE
find $BAK_DIR/$IP -type f -name "*.tar.gz" -mtime +7 -delete
