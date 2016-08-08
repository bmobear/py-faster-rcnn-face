# Train Faster R-CNN on WIDER FACE dataset

This repository narrates my attempt to train Faster R-CNN on WIDER FACE dataset for face detection as described in this [arXiv paper](https://arxiv.org/abs/1606.03473).

Refer to [official README](./README_official.md) for the official Faster R-CNN README and the installation guidelines.

## Contents
1. [Prepare Data](#prepare-data)
2. [Modify Existing Code](#modify-existing-code)

---

### Prepare Data

1. Download [WIDER FACE dataset](http://mmlab.ie.cuhk.edu.hk/projects/WIDERFace/), specifically
   
   + Wider Face Training Images
   + Wider Face Validation Images
   + Face annotations
   
   and put them into a single directory 

    ```
    WIDER_ROOT/
      +-- wider_face_split.zip
      +-- WIDER_train.zip
      +-- WIDER_val.zip
   ```
   
2. Extract the zip files
2. [Flatten](./scripts/flatten.py) images in `WIDER_train/images/*` into a single directory `WIDER_train/flatten_img`
3. [Resize](./scripts/resize.sh) images in `WIDER_train/flatten_img` and save the results in `WIDER_train/resized_img`
   
   Resize all images so that the maximum dimension (either width or height) is 1024 (As mentioned in Section 3.1 in the paper). The script also writes out a summary of size changes into a text file `WIDER_train/resized_img.txt`.
   
4. [Generate](./scripts/generate_annotations.m) annotation files
  
    Generate annotation files in JSON. An annotation file describes an image file name and a list of one or more face bounding boxes. The script loads WIDER annotation file `wider_face_split/wider_face_train.mat`; and for each image, it parses face bounding boxes, resizes bounding boxes match the new size from step 3, and writes updated bounding boxes to a JSON file. The output files are in `WIDER_train/annt`

    ```matlab
    scale = 1024/max(img_width, img_height)
    [xmin' ymin' xmax' ymax'] = scale*[xmin ymin xmin+bb_width ymin+bb_height]
    ```

5. Repeat 2-4 on the validation set `WIDER_val/`
6. Generate a text file listing image files per image set, saved as `train.txt` and `val.txt`
7. Combine image files from `train` and `val` into a single directory `img`, combine annotation files into `annt`, and have data organized as follows:
   
    ```
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
   ```

### Modify Existing Code



