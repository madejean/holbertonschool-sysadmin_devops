#!/bin/bash
while read -r line;
do
    if [ $(echo $line | grep -o HEAD) ]    
    then
	HEAD=$(($HEAD+1))
    elif [ $(echo $line | grep -o GET) ]
    then
	GET=$(($GET+1))
    fi
done < $1
echo $HEAD
echo $GET
