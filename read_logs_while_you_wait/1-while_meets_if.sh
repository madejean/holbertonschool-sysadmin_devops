#!/bin/bash
if test $1
   then
while read -r line;
do
    echo $line
done < "$1"
fi
