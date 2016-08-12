#!/usr/bin/env bash
set -x
set -e

WIDER_ROOT=$1

# unzip
for z in $WIDER_ROOT/*.zip;
do
  /usr/bin/time -f 'elapsed time %e seconds' unzip -q $z -d $WIDER_ROOT
done

mkdir -p $WIDER_ROOT/wider_processed_data
mkdir -p $WIDER_ROOT/wider_processed_data/img
mkdir -p $WIDER_ROOT/wider_processed_data/annt

for img_set in train val;
do
  # flatten
  mkdir -p $WIDER_ROOT/WIDER_${img_set}/flatten_img
  python flatten.py $WIDER_ROOT/WIDER_${img_set}/images $WIDER_ROOT/WIDER_${img_set}/flatten_img
  
  # generate image file list
  /usr/bin/time -f 'elapsed time %e seconds' sh gen_ls.sh $WIDER_ROOT/WIDER_${img_set}/flatten_img $WIDER_ROOT/wider_processed_data/${img_set}.txt
  
  # resize
  /usr/bin/time -f 'elapsed time %e seconds' sh resize.sh $WIDER_ROOT/WIDER_${img_set}/flatten_img $WIDER_ROOT/wider_processed_data/img $WIDER_ROOT/WIDER_${img_set}/resized_img.txt 1024
  
  # generate annotation
  jsonlab='/home/toy/jsonlab/jsonlab'
  wider_annt_mat="$WIDER_ROOT/wider_face_split/wider_face_${img_set}.mat"
  resizeinfo_file="$WIDER_ROOT/WIDER_${img_set}/resized_img.txt"
  output_dir="$WIDER_ROOT/wider_processed_data/annt"
  # matlab gen_annt('$jsonlab', '$wider_annt_mat', '$resizeinfo_file', '$output_dir')
  
done


