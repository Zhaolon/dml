#!/bin/bash

#mkdir maps
#mkdir stars

ur=`eval echo {234,134,124,123}`
pr=25
cr=10

for u in $ur;do
for p in `seq 1 $pr`;do
for c in `seq 1 $cr`;do
ln -s /gpfs/share/home/1701110171/el_bagging/ptsm_bagging/part${p}/Autorefine_After3D/u${u}/job0$(printf '%02d' $c)/run_class001.mrc maps/u${u}_p${p}_c${c}.maps
#echo $u
#echo $p
#echo $c
ln -s /gpfs/share/home/1701110171/el_bagging/ptsm_bagging/part${p}/Autorefine_After3D/u${u}/job0$(printf '%02d' $c)/run_data.star stars/u${u}_p${p}_c${c}.star
done
done
done

