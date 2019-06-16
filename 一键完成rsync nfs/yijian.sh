#!/bin/sh
. /etc/init.d/functions

[ ! -f /root/.ssh/id_dsa.pub ] && \
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
#ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa >/dev/null 2>&1

[ `rpm -qa expect |wc -l` -eq 0 ] && yum install expect -y
. /server/scripts/dis-sshkey.sh >/dev/null 2>&1

for IP in `cat /server/scripts/iplist`
do
    ssh root@$IP "
cat > /etc/hosts <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
172.16.1.41 backup
172.16.1.31 nfs01
172.16.1.5 lb01
172.16.1.6 lb02
172.16.1.7 web02
172.16.1.8 web01
172.16.1.51 db01
172.16.1.61 m01
EOF
"
  if [ $? -eq 0 ];then
   action "$IP /etc/hosts" /bin/true
  else
   action "$IP /etc/hosts" /bin/false
  fi

  ssh root@$IP "mkdir -p /server/scripts"
  if [ $? -eq 0 ];then
   action "$IP create /server/scripts" /bin/true
  else
   action "$IP create /server/scripts" /bin/false
  fi


  if [[ "$IP" = "10.0.0.41" ]];then
     #scp /server/scripts/rsync.sh root@$IP:/server/scripts/
     rsync /server/scripts/rsync.sh -e 'ssh' root@$IP:/server/scripts/
     if [ $? -eq 0 ];then
       action "$IP transfer /server/scripts/rsync.sh" /bin/true
     else
       action "$IP transfer /server/scripts/rsync.sh" /bin/false
     fi

     ssh root@$IP "/bin/sh /server/scripts/rsync.sh"
     if [ $? -eq 0 ];then
       action "$IP exec /server/scripts/rsync.sh" /bin/true
     else
       action "$IP exec /server/scripts/rsync.sh" /bin/false
     fi
  fi

  if [[ "$IP" = "10.0.0.31" ]];then
     #scp /server/scripts/{rsync_c.sh,nfs_install.sh,inotify_install.sh} root@$IP:/server/scripts/
     rsync /server/scripts/{rsync_c.sh,nfs_install.sh,inotify_install.sh,inotify.sh} -e 'ssh' root@$IP:/server/scripts/
     if [ $? -eq 0 ];then
       action "$IP transfer rsync_c.sh,nfs_install.sh,inotify_install.sh,inotify.sh" /bin/true
     else
       action "$IP transfer rsync_c.sh,nfs_install.sh,inotify_install.sh,inotify.sh" /bin/false
     fi

     ssh root@$IP "/bin/sh /server/scripts/rsync_c.sh"
     if [ $? -eq 0 ];then
       action "$IP exec /server/scripts/rsync_c.sh" /bin/true
     else
       action "$IP exec /server/scripts/rsync_c.sh" /bin/false
     fi

     ssh root@$IP "/bin/sh /server/scripts/nfs_install.sh"
     if [ $? -eq 0 ];then
       action "$IP exec /server/scripts/nfs_install.sh" /bin/true
     else
       action "$IP exec /server/scripts/nfs_install.sh" /bin/false
     fi

     ssh root@$IP "/bin/sh /server/scripts/inotify_install.sh"
     if [ $? -eq 0 ];then
       action "$IP exec /server/scripts/inotify_install.sh" /bin/true
     else
       action "$IP exec /server/scripts/inotify_install.sh" /bin/false
     fi
  fi
done
