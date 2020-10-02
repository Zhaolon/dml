#!/bin/bash

th=2

distfile="c*"
stars="../c*/u*p*c*.star"
ptcl=`grep '_rlnImageName' head.star | awk '{print substr($2,2)}'`

nproc=28
Pfifo="./tmp.fifo"
mkfifo $Pfifo
exec 6<>$Pfifo
rm -f $Pfifo
for((i=1; i<=$nproc; i++));do
echo
done >&6

for f in ./u*p*c*.star;do

while read line;do
read -u6
{
{
p=`echo ${line}|awk '{if(NF>5) print $'${ptcl}'}'`
n=`grep " $p " u*p*c*.star|wc -l`
#echo $n
if [[ -n $p && $n -ge $th ]];then
echo $n,$p
echo ${line} >> post_or.tmp
elif [ -n $p ] && [ $n -eq 1 ];then
u0=`echo $f | awk -v head="u" -v tail="_p" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
p0=`echo $f | awk -v head="_p" -v tail="_c" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
c0=`echo $f | awk -v head="_c" -v tail=".s" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
order0=`grep "u${u0}_p${p0}c${c0}_newbox_aligned" data.log|awk '{print $1}'`
d0=`grep "^${order0} " $distfile|awk '{print $2}'`

l0=${line}
tot=`grep " $p " $stars|wc -l`
i=0
flag=1
grep " $p " $stars|while read line;do

i=$[i+1]
f1=`echo ${line}|awk -F":" '{print $1}'`
u1=`echo $f1 | awk -v head="u" -v tail="_p" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
p1=`echo $f1 | awk -v head="_p" -v tail="_c" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
c1=`echo $f1 | awk -v head="_c" -v tail=".s" '{print substr($0, index($0,head)+length(head),index($0,tail)-index($0,head)-length(head))}'`
folder1=`dirname $f1`
order1=`grep "u${u1}_p${p1}c${c1}_newbox_aligned" data.log|awk '{print $1}'`
#echo ${folder1}
d1=`grep "^${order1} " ${folder1}/${distfile}|awk '{print $2}'`
if [[ `echo "$d0 > $d1"|bc` -eq 1 ]];then
flag=0
break
fi

if [[ $i -eq $tot && $flag -ne 0 ]];then
echo $n,$p
echo ${l0} >> post_or.tmp
fi

done
fi
}
sleep 1
echo >&6
} &
done < $f
wait

done

exec 6>&-
cp head.star post_or.star
sort -k $ptcl,$ptcl -u post_or.tmp >> post_or.star
rm post_or.tmp
