#!/bin/bash
Fromate(){
	if [ $# -ne 2 ];then
		echo "Usage: Fromate <text> {ok|faled}"
		return 1
	fi
	case $2 in
		ok)
			printf "%-80s[\033[32m   %s  \033[0m]\n" "$1" OK
		;;
		faled)
			printf "%-80s[\033[31m %s \033[0m]\n" "$1" FALED
		;;
	esac
}
[ ! -f /etc/rsyncd.conf ] && Fromate "rsync config file:/etc/rsyncd.conf does not exist!" faled && exit 1
pass_file=`grep "secrets file" /etc/rsyncd.conf|awk '{print $4}'`
pid_file=`grep "pid file" /etc/rsyncd.conf|awk '{print $3}'`
if [ ! -f $pass_file ];then
	Fromate "rsync password file:$pass_file does not exist!" faled
	exit 1
else
	[ `stat -c%a $pass_file` -eq 600 ]||chmod 600 $pass_file
fi

rsync_start(){
	if lsof -i:rsync &>/dev/null;then
		Fromate "rsync server is on running..." faled
	else
		rsync --daemon
		Fromate "rysnc server start ok!" ok
	fi
}

rsync_stop(){
        if lsof -i:rsync &>/dev/null;then
		killall rsync
                Fromate "rsync stop ok!" ok
        else
                Fromate "rysnc no running!" faled
        fi
}

rsync_status(){
	if [ -f $pid_file ];then
		echo "rsync is on running,PID:`cat $pid_file`"
	else
		echo "rsync no running!"
	fi
}

case "$1" in 
	start)
		rsync_start
	;;
	stop)
		rsync_stop
	;;
	restart)
		rsync_stop &&sleep 1&& rsync_start
	;;
	status)
		rsync_status
	;;
	*)
		echo "Usage: {start|stop|status|restart}"
		exit 2
	;;
esac
