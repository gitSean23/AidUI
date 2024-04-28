#!/bin/bash

conda init && conda activate dl_dp_obj_det_env && python -m spacy download en_core_web_trf 
conda init && conda activate dp_uied3  && python -m spacy download en_core_web_trf


cd ../root/.cache
mkdir -p torch/hub/checkpoints
cd ~

echo "Downloading the CNN Rico Model"
# Download the CNN Rico Model
wget -O .cache/torch/hub/checkpoints/cnn-rico-1.h5 "https://drive.google.com/uc?export=download&id=1Gzpi-V_Sj7SSFQMNzy6bcgkEwaZBhGWS"


cd ../AidUI