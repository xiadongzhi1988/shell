#!/bin/bash

USER=root
PASSWD=rootroot
DATE=`date -I`
MYCMD="/usr/local/mysql/bin/mysql -u${USER} -p${PASSWD}"
MYDUMP="/usr/local/mysql/bin/mysqldump -u${USER} -p${PASSWD} --default-character-set=utf8"
DIR="/usr/local/mysql_bak/${DATE}"

mkdir -p  ${DIR}/NC_CR
for table in `$MYCMD -e "show tables from NC_CR" |egrep -v 'SOURCE|Tables'`
do
    $MYDUMP  NC_CR $table > ${DIR}/NC_CR/${table}.sql && sleep 1

done
