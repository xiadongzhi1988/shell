#!/bin/bash

name=oldboy
passWord=123456

echo "Hello World！"
echo "你现在使用$USER用户登录，字符集为$LANG，因此我可以使用中文和你交流。"

while true
  do
    read -p "请输入你的用户名：" user
	read -s -p "请输入你的密码：" pass

	if [ "$user" == "$name" -a "$pass" == "$passWord" ]
	  then
		echo "身份认证成功！"
		break
	else
	  echo "身份认证失败，请重试！"

	  for i in `seq -w 10 -1 1`
        do
          echo -ne "\b\b$i";
          sleep 1;
      done
	fi
done
