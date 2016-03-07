#!/bin/bash
awk '{print $1, $9}' $1
echo $1 | awk '{print $4}'
