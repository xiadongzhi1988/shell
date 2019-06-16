#!/bin/bash
source /etc/profile
mysqlUser=root
mysqlPass=`cat /etc/myp`
exDataBase='_schema|Database'
dataBase=`mysql -u$mysqlUser -p$mysqlPass -e "show databases;" 2> /dev/null |egrep -v "$exDataBase"`
Time=`date +%F`
backDir=/application/backup/$Time
[ -d $backDir ] || mkdir -p $backDir
mysqladmin -u$mysqlUser -p$mysqlPass flush-logs 2> /dev/null
for DB in $dataBase
do
  mkdir -p $backDir/$DB
  tablelist=`mysql -u$mysqlUser -p$mysqlPass -e "show tables from $DB" 2> /dev/null |grep -v Tables_in`
  for TABLE in $tablelist
  do
    mysqldump -u$mysqlUser -p$mysqlPass --master-data=2 --single-transaction --triggers -R $DB $TABLE 2> /dev/null |gzip > $backDir/$DB/${DB}-${TABLE}-${Time}.sql.gz
  done
done
