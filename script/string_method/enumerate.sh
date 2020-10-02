#!/bin/bash

datafile='data.log'
numberfile='num.txt'

while read line;do
u=`echo $line | awk -v head="u" -v tail="_p" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
p=`echo $line | awk -v head="p" -v tail="c" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
c=`echo $line | awk -v head="c" -v tail="_a" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`

l=$[`awk '{if(NF>3) print $0}' stars/u${u}_p${p}_c${c}.star | wc -l`]
echo $l >> $numberfile
done < $datafile
