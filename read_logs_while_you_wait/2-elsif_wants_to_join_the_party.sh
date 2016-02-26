#!/bin/bash
if test $1
   then
while read -r line;
do
    curl -o /dev/null --silent --head --write-out '%{http_code}' "$LINE"
    echo $line
done < "$1"
fi
