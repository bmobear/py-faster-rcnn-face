#!/usr/bin/env bash
# requires ImageMagick

src_dir=$1
des_dir=$2
log=$3
maxdim=$4

mkdir -p $des_dir
:> $log

for f in $src_dir/*.jpg;
do
  # image dimensions before resizing
  wi=`identify $f | cut -f3 -d' ' | sed 's:x.*::'`
  hi=`identify $f | cut -f3 -d' ' | sed 's:.*x::'`
  
  # resize if w or h exceeds maxdim
  des=${des_dir}/`basename $f`
  convert $f -resize "${maxdim}x${maxdim}>" $des
  
  # image dimensions after resizing
  wf=`identify $des | cut -f3 -d' ' | sed 's:x.*::'`
  hf=`identify $des | cut -f3 -d' ' | sed 's:.*x::'`
  echo "`basename $f` $wi $hi $wf $hf" >> $log
done


