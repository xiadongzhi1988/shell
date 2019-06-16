#!/bin/bash

function get_random(){
  echo $((RANDOM%$S_count+1))
}

function input(){
  read -p "请输入题目总数:" S_count
  read -p "请输入选题数量:" count
  read -p "请输入学生数量:" N
  for ((i=1;i<=N;i++))
  do
    read -p "请输入学生${i}姓名:" name[i]
  done
}

function RAN_one(){
  tmp_num=`get_random`
  i=0
  while ((i<${#num[*]}))
  do
    if ((tmp_num!=num[i]))
    then
      ((i++))
    else
      i=0
      tmp_num=`get_random`
    fi
  done
  num[${#num[*]}]=$tmp_num
}

function RAN(){
count=$1
num[0]=`get_random`
for((j=1;j<count;j++))
do 
  RAN_one
done
echo ${num[*]}
}


function main(){
  clear
  input
  for ((i=1;i<=N;i++))
  do
    echo ${name[i]} ---- $(RAN $count)
  done
}
main