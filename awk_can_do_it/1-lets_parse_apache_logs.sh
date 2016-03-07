#!/bin/bash
<<<<<<< HEAD
awk '{print $1, $9}' $1
=======
while read -r line
      do
awk= awk '{print $1, $9}' $1
echo $awk
done < "$1"
>>>>>>> 674c2e5985cbac03c8ffc0ca9ad3656d50371cb8
