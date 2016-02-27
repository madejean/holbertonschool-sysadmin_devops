#!/bin/bash
while read -r line; do
    if $line=="HEAD"
    then
	echo count"HEAD"
    elif $line== "GET"
    then
	echo count"GET"
fi
done < "$1"

