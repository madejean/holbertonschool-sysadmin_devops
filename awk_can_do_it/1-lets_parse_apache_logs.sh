#!/bin/bash
while read -r line
      do
awk= awk '{print $1, $9}' $1
echo $awk
done < "$1"
