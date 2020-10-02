#!/bin/bash
starfile=$1
sed -n '24,25023p' $starfile >sub1.star
sed -n '25024,50023p' $starfile >sub2.star
sed -n '50024,75023p' $starfile >sub3.star
sed -n '75024,100023p' $starfile >sub4.star

cat sub1.star sub2.star sub3.star > u123.star
cat sub1.star sub2.star sub4.star > u124.star
cat sub1.star sub3.star sub4.star > u134.star
cat sub2.star sub3.star sub4.star > u234.star

cat ./head.star u123.star > union123.star
cat ./head.star u124.star > union124.star
cat ./head.star u134.star > union134.star
cat ./head.star u234.star > union234.star

rm u???.star
