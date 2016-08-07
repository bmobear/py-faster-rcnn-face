# Train Faster R-CNN on WIDER FACE dataset

This repository narrates my attempt to train Faster R-CNN on WIDER FACE dataset for face detection as described in this [arXiv paper](https://arxiv.org/abs/1606.03473).

Refer to [official README](./README_official.md) for the official Faster R-CNN README and the installation guidelines.

## Contents
1. [Prepare Data](#prepare-data)
2. [Modify Existing Code](#modify-existing-code)

---

### Prepare Data

1. Download [WIDER FACE dataset](http://mmlab.ie.cuhk.edu.hk/projects/WIDERFace/)
2. [Flatten](./scripts/flatten.py) all images in `WIDER_train/images/*` into a single directory
3. [Resize](./scripts/resize.sh) images
   
   Resize all images so that the maximum dimension (either width or height) is 1024 (As mentioned in Section 3.1 in the paper). The script also writes out a summary of size changes into a text file.

   `scale = 1024/max(img_width, img_height)`
4. [Generate](./scripts/generate_annotations.m) annotation files
  
    Generate annotation files in JSON. An annotation file describes an image file name and a list of one or more face bounding boxes. The script loads WIDER annotation file `wider_face_train.mat`; and for each image, it parses face bounding boxes, resizes bounding boxes match the new size from step 3, and writes updated bounding boxes to a JSON file.
   
    `[xmin' ymin' xmax' ymax'] = scale*[xmin ymin xmin+bb_width ymin+bb_height]`

5. Repeat 1-4 on `WIDER_val`
6. [Generate](TBA) `train.txt` and `val.txt`
7. Organize data as follows:
   
    ```
    WIDER_data/
      +-- img/
      |    +-- img_1.jpg
      |    +-- img_2.jpg
      |        ...
      +-- annt/
      |    +-- img_1.json
      |    +-- img_2.json
      |        ...
      +-- train.txt
      +-- val.txt
   ```
      

### Modify Existing Code



