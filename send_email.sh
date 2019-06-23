#!/bin/bash
BAK_DIR="/backup"
EMAIL="123456@qq.com"
md5sum -c $BAK_DIR/*/flag.txt > email.txt
mail -s "test"  $EMAIL < email.txt
find $BAK_DIR/172.16.1.*/ -type f -mtime +180 ! -name "*_1_etc.tar.gz" -name "*_etc.tar.gz" -delete
