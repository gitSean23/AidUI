#!/bin/bash

# Download the CNN Rico Model
wget -O cnn_rico_model.zip "https://drive.google.com/uc?export=download&id=1Gzpi-V_Sj7SSFQMNzy6bcgkEwaZBhGWS"
unzip cnn_rico_model.zip -d /root/.cache/torch/hub/checkpoints/
rm cnn_rico_model.zip

# Download the trained visual cue detection model
wget -O visual_cue_detection_model.zip "https://github.com/SageSELab/AidUI/releases/download/v-ICSE'23-data/trained-visual-cue-detection-model.pth"
unzip visual_cue_detection_model.zip -d AidUI/object_detection/object_detection_frcnn_mscoco_boilerplate/
rm visual_cue_detection_model.zip

cd AidUI

python main.py