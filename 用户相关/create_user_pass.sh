#!/bin/bash

USER=$1
mkdir -p /root/.user
echo ${USER}{01..03} |xargs -n1 |sed -r 's#(.*)#useradd \1;pass=$(openssl rand -base64 40 |cut -c2-10);echo "$pass"|passwd --stdin \1;echo -e \1 "    " "$pass" >> /root/.user/${USER}.txt#g'|bash
