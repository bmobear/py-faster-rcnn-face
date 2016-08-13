# Train Faster R-CNN on WIDER FACE dataset

This repository narrates my attempt to train Faster R-CNN on WIDER FACE dataset for face detection as described in this [arXiv paper](https://arxiv.org/abs/1606.03473).

Refer to [official README](./README_official.md) for the official Faster R-CNN README and the installation guidelines.

## Contents
1. [Prepare Data](#prepare-data)
2. [Prepare Caffe Model](#prepare-caffe-model)
3. [Modify Existing Code](#modify-existing-code)

---

### Prepare Data

1. Download [WIDER FACE dataset](http://mmlab.ie.cuhk.edu.hk/projects/WIDERFace/), specifically
   
   + Wider Face Training Images
   + Wider Face Validation Images
   + Face annotations
   
   and unzip them into

    ```
    WIDER_ROOT/
      +-- wider_face_split/
      +-- WIDER_train/
      +-- WIDER_val/
   ```
   
2. Create the following directories

    ```
    WIDER_ROOT/
      +-- wider_processed_data/
      |    +-- img/
      |    +-- annt/
   ```
   
3. [Flatten](./face_scripts/flatten.py) images under `WIDER_train/images/*/*.jpg` into a single directory `WIDER_train/flatten_img`
4. [Generate](./face_scripts/gen_ls.sh) a text file `wider_processed_data/train.txt` listing image files under `WIDER_train/flatten_img`
5. [Resize](./face_scripts/resize.sh) images in `WIDER_train/flatten_img` and save the results under `wider_processed_data/img`
   
   Resize all images so that the maximum dimension (either width or height) is 1024 (As mentioned in Section 3.1 in the paper). The script also writes out a summary of size changes into a text file `WIDER_train/resized_img.txt`.
   
6. [Generate](./face_scripts/gen_annt.m) annotation files
  
    Generate annotation files in JSON format. An annotation file describes an image file name and a list of one or more face bounding boxes. The script loads WIDER annotation file `wider_face_split/wider_face_train.mat`; and for each image, it parses face bounding boxes, resizes bounding boxes match the new size from step 3, and writes updated bounding boxes to a JSON file. The output files are saved under `wider_processed_data/img`

    ```matlab
    scale = 1024/max(img_width, img_height)
    [xmin' ymin' xmax' ymax'] = scale*[xmin ymin xmin+bb_width ymin+bb_height]
    ```

6. Repeat 3-6 on the validation set `WIDER_val/`


At the end we have the following structure


    WIDER_ROOT/
      +-- wider_processed_data
      |    +-- img/
      |    |    +-- img_1.jpg
      |    |    +-- img_2.jpg
      |    |        ...
      |    +-- annt/
      |    |    +-- img_1.json
      |    |    +-- img_2.json
      |    |        ...
      |    +-- train.txt
      |    +-- val.txt


### Prepare Caffe Model


### Modify Existing Code



