#!/bin/bash

echo "--------------------------------------conda initiate--------------------------------------"
eval "$(conda shell.bash hook)"

echo "---------------activate object detection env (dl_dp_obj_det_env), copy input files & conduct object detection inference---------------"
conda activate dl_dp_obj_det_env
echo "--------------------------------------input UIs copied to input folder--------------------------------------"

  echo "--------------------------------------create object detection and UIED directories--------------------------------------"


  cp ./input/*.* ./object_detection/object_detection_frcnn_mscoco_boilerplate/inference_data/test
  cd ./object_detection/object_detection_frcnn_mscoco_boilerplate
  python object_detection_frcnn_mscoco_inference.py
  echo "waiting 10s"
  cd ../..

  echo "---------------activate UIED env (dp_uied3), iteratively copy input files & conduct text extraction---------------"
  conda activate dp_uied3
  destdir="./tmp_input/"
  cp ./input/*.* $destdir
  cd $destdir
  find . -maxdepth 1 -type f |head -1|xargs cp -t "../UIED/data/input"
  find . -maxdepth 1 -type f |head -1|xargs rm
  sleep 2s
  cd ../UIED/
  python run_uied.py
  echo "---------------activate object detection env------------------------------"
  conda activate dl_dp_obj_det_env
