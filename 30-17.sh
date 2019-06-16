#!/bin/bash

DbFile=./while_ernie.db
[ ! -f $DbFile ] && touch $DbFile

RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
PINK='\E[1;35m'
RES='\E[0m'

function trapper(){
  trap ':' INT EXIT TSTP TERM HUP
}

function random(){
  local x y
  x=$(($RANDOM%9))
  y=$(($RANDOM%9))
  echo $x$y
}

function warn(){
  echo -e "${RED_COLOR}Please enter the correct format name! like zhangsan!${RES}"
  countdown
  continue
}

function warn2(){
  echo -e "${RED_COLOR} You have entered the name! Give the change to other!${RES}"
  countdown
  continue
}

function countdown(){
  for i in `seq -w 10 -1 1`
  do
    echo -ne "\b\b$i";
    sleep 1;
  done
}

function check_name(){
  echo -e "${YELOW_COLOR}Please enter [exit] to exit the program${RES}"
  read -p "Please enter the name of the Pinyin:" name name1
  [ "$name" == "exit" ] && exit 0
  [ -n "$name1" ] && warn
  [ -n "$name" -a -z "`echo "${name//[a-zA-Z]/}"`" ] || warn
}

function check_file(){
  local Name Id
  Name=`awk '{if($1=="'$name'") print $1}' $DbFile`
  [ -z "$Name" ] || warn2
  
  num=`random`
  Id=$num
  while [ -n "$Id" ]
  do
    num=`random`
    Id=`awk '{if($2=="'$num'") print $2}' $DbFile`
  done

  printf "%-20s %-2s\n" $name $num >> $DbFile
}

function welcome(){
  clear
  echo -e "${GREEN_COLOR}
       This program will select 3 students to participate in
  the training of enterprise project practice out of the oldboy.
  
  The students are eligible to participate in the list as follows${RES}"

  echo -e "${BLUE_COLOR}`sort -rn -k2 $DbFile|head -3`${RES}"
}

function main(){
  while true
  do
    trapper
    welcome
    check_name
    check_file
  done
}

main
