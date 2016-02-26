#!/bin/bash
if test $1
   then
while IFS='' read -r line;
do
    echo $line
done < "$1"
fi
