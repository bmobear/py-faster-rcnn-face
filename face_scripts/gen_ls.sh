#!/usr/bin/env bash

in_img_dir=$1
out_txt_file=`readlink -f $2`

cd $in_img_dir
ls -1 *.jpg > $out_txt_file 

