#!/bin/bash

[ $# -ne 3 ] && exit 1

num=$(rpm -qa dos2unix|wc -l)

[ $num -eq 0 ] && yum -y install dos2unix &>/dev/null

email_File=/tmp/email.log
function main(){
	echo "$3" >$email_File
	/usr/bin/dos2unix $email_File &>/dev/null
	/bin/mail -s "$2" "$1" <$email_File
}
main "$1" "$2" "$3"
