#!/bin/sh

HOST="`sed -nr 's#^HOSTNAME=(.*)#\1#gp' network`"

sed -i "s#HOSTNAME=${HOST}#HOSTNAME=$1#g"  network
