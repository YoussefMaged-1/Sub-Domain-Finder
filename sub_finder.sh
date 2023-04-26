#!/bin/bash

#if the input is NULL
if [ $# -eq 0 ]
then 
echo "How to use: ./sub_finder.sh"
echo "Ex: ./sub_finder.sh www.example.com"
else

wget $1 2> /dev/null
if [ -e index.html ]
then
domain=$(less index.html|grep "href="|cut -d ":" -f 2|cut -d "/" -f 3|grep "mega"|grep "w"|cut -d '"' -f 1|cut -d "." -f 2|uniq) 
echo $domain 
less index.html|grep "href="|cut -d ":" -f 2|cut -d "/" -f 3 |grep "$domain"|cut -d '"' -f 1|grep -v "$1"|uniq > sub.txt 


for sub in $(cat sub.txt)
do
if [[ $(ping -c 1 $sub 2>/dev/null) ]]
then
echo "$sub++++++++PONG"
echo $sub >> valid_sub.txt
else
echo "$sub- - - - - ERROR"
fi
done

for ip in $(cat valid_sub.txt)
do
host $ip | cut -d " " -f 4 >> ips.txt
done
fi
fi
