#!/bin/bash

datafile='data.log'

while read line;do

#sed -n "${line}p" $datafile
n=`echo ${line}|awk '{print $1}'`

u=`sed -n "${n}p" $datafile | awk -v head="u" -v tail="_p" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
p=`sed -n "${n}p" $datafile | awk -v head="_p" -v tail="c" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
c=`sed -n "${n}p" $datafile | awk -v head="c" -v tail="_a" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`

ln -s stars/u${u}_p${p}_c${c}.star .

done < $1
