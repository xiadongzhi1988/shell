#!/bin/bash

MYUSER=root
MYPASS=rootroot
MYCMD="/usr/bin/mysql -u$MYUSER -p$MYPASS"
MYDUMP="/usr/bin/mysqldump -u$MYUSER -p$MYPASS -t"

for database in `$MYCMD -e "show databases;"|sed '1,2d'|grep -v mysql |grep -v test`
do
    mkdir /mysql_bak/`date -I`_data/${database}-`date -I` -p
    for table in `$MYCMD -e "show tables from $database;"|sed '1d'`
    do
       $MYDUMP $database $table > /mysql_bak/`date -I`_data/${database}-`date -I`/${database}-${table}-data-`date -I`.sql
    done
done
