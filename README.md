# Train Faster R-CNN on WIDER FACE dataset

This repository narrates my attempt to train Faster R-CNN on WIDER FACE dataset for face detection as described in this [arXiv paper](https://arxiv.org/abs/1606.03473).

Refer to [official README](./README_official.md) for the official Faster R-CNN README and the installation guidelines.

## Contents
1. [Prepare Data](#prepare-data)

---

### Prepare Data

1. Download [WIDER FACE dataset](http://mmlab.ie.cuhk.edu.hk/projects/WIDERFace/)
2. [Flatten](./scripts/flatten.py) all images in `WIDER_train/images/*` into a single directory
3. [Resize](./scripts/resize.sh) all images so that the maximum dimension is 1024 (As mentioned in Section 3.1)
4. [Generate](./scripts/generate_annotations.m) annotation files



