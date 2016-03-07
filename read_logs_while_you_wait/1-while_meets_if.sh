#!/bin/bash
while read -r line;
do
    if [[ $line == *HEAD* ]] 
    then echo $line
    fi
done < $1
