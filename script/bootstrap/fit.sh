#!/bin/bash
for f in ../unalign/*mrc;do

f2=`basename $f .mrc`
#echo $f2

if [ ! -f "${f2}_aligned.mrc" ];then
e2proc3d.py $f ${f2}_aligned.mrc --alignref ./tmp/ed1_half1_bin2_correct.mrc --align rotate_translate_3d_tree -v 2
echo $f2
fi

done
