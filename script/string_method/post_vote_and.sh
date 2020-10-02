#!/bin/bash
for f in ./u*f?s?.star;do

f2=`basename $f ".star"`
cp head.star ${f2}_post_and.star

while read line;do
p=`echo ${line}|awk '{if(NF>5) print $10}'`
echo $p
n=`grep $p u*f?s?.star|wc -l`
#echo $n
if [ $n -gt 1 ];then
echo ${line} >> ${f2}_post_and.star
#echo ${line}
fi
done < $f

done
