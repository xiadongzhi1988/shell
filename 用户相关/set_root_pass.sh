#!/bin/bash

mkdir -p /root/.user
echo root |sed -r 's#(.*)#pass=$(openssl rand -base64 40 |cut -c2-10);echo "$pass"|passwd --stdin \1;echo -e \1 "    " "$pass" > /root/.user/.\1.txt#g'|bash
