#!/bin/bash
while read -r line;
      do
echo $1 | awk -F '{print $1}'   
done < "$1"
