#!/usr/bin/env python3
#################
## Usage: scriptsname argv1 argv2
################
import paramiko
import sys
import os
ip=sys.argv[1]
cmd=sys.argv[2]
port=22
username='root'
key_file='/root/.ssh/id_rsa'
privatekey=os.path.expanduser(key_file)
key=paramiko.RSAKey.from_private_key_file(privatekey)

client=paramiko.SSHClient()
client.load_system_host_keys(filename='/root/.ssh/known_hosts')
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(ip,username=username,pkey=key)
stdin,stdout,stderr=client.exec_command(cmd)
for line in stdout:
    print('...'+line.strip('\n'))
client.close()
