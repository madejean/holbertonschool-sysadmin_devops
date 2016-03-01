#!/bin/bash
while read line
do
    if [[ $line == *HEAD* ]]
    then
	HEAD=$(($HEAD+1))
    elif [[ $line == *GET* ]]
    then
	GET=$(($GET+1))
    fi
done < $1
echo $HEAD
echo $GET
