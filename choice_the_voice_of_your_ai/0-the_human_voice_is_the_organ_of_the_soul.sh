#!/bin/bash 
file=$(echo $1 | awk '{print $1}')
message=$1
Voice=$2
IP=$3

case $Voice in
	f)
	    say -v Vicki -o /tmp/$file.m4a $1;; 
	m)
	    say -v  Fred -o /tmp/$file.m4a $1 ;;
	x)
	    say -v  Zarvox -o /tmp/$file.m4a $1;;
esac

scp /tmp/$file.m4a admin@$IP:/var/www/html/$file.m4a
echo "Listen to the message here $IP/$file.m4a"
