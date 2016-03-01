#!/bin/bash
while read line
do
    if [[ $line == *HEAD* ]]
    then
<<<<<<< HEAD
	HEAD=$(($HEAD+1))
    elif [[ $line == *GET* ]]
    then
	GET=$(($GET+1))
=======
	 HEAD=$(($HEAD+1))
    elif [[ $line == *GET* ]]
    then
	 GET=$(($GET+1))
>>>>>>> 0bc77bc5d6db5fdb697d399ab35dd3a7fec90c1b
    fi
done < $1
echo $HEAD
echo $GET
