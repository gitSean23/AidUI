#!/bin/bash

echo "--------------------------------------conda initiate--------------------------------------"
eval "$(conda shell.bash hook)"

echo "---------------activate object detection env (dl_dp_obj_det_env), copy input files & conduct object detection inference---------------"
conda activate dl_dp_obj_det_env

# create ./input directory
# mkdir ./input/

# input to turn on evaluation mode

EVAL_MODE="on"


if [[ $EVAL_MODE = "on" ]]
then
  echo "EVAL MODE is ON"
  # python -c "import evaluation.evaluation as evaluation; evaluation.set_evaluation_data()"
  echo "--------------------------------------input UIs copied to input folder--------------------------------------"

  echo "--------------------------------------create object detection and UIED directories--------------------------------------"
#  mkdir ./object_detection/object_detection_frcnn_mscoco_boilerplate/inference_data/
#  mkdir ./object_detection/object_detection_frcnn_mscoco_boilerplate/inference_data/test
#  mkdir ./object_detection/object_detection_frcnn_mscoco_boilerplate/inference_output/
#  mkdir ./UIED/data/input/

  cp ./input/*.* ./object_detection/object_detection_frcnn_mscoco_boilerplate/inference_data/test
  cd ./object_detection/object_detection_frcnn_mscoco_boilerplate
  python object_detection_frcnn_mscoco_inference.py
  echo "waiting 10s"
  cd ../..

  echo "---------------activate UIED env (dp_uied3), iteratively copy input files & conduct text extraction---------------"
  conda activate dp_uied3
#  mkdir ./tmp_input/
  destdir="./tmp_input/"
  cp ./input/*.* $destdir
  cd $destdir
  find . -maxdepth 1 -type f |head -15|xargs cp -t "../UIED/data/input"
  find . -maxdepth 1 -type f |head -15|xargs rm
  sleep 2s
  cd ../UIED/
  python run_uied.py
  echo "---------------activate object detection env------------------------------"
  conda activate dl_dp_obj_det_env

#   echo "--------------------------------------execute DP detection & evaluation--------------------------------------"
#   eval "$(conda shell.bash hook)"
#   conda activate dl_dp_obj_det_env
#   python main.py
# else
#   echo "EVAL MODE is OFF"
#   echo "--------------------------------------execute DP detection & evaluation--------------------------------------"
#   eval "$(conda shell.bash hook)"
#   conda activate dl_dp_obj_det_env
#   python main.py
fi
