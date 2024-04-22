FROM continuumio/miniconda3

WORKDIR /AidUI

# RUN apt-get update && apt-get install libgl1 -y
RUN apt-get update && apt-get install -y \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

COPY env_specification_files/dl_environment.yml /AidUI/env_specification_files/dl_environment.yml
COPY env_specification_files/dp_environment.yml /AidUI/env_specification_files/dp_environment.yml

RUN conda env create -f /AidUI/env_specification_files/dl_environment.yml
RUN conda env create -f /AidUI/env_specification_files/dp_environment.yml

# FROM continuumio/miniconda3

# COPY --from=builder /opt/conda/envs/dl_dp_obj_det_env /opt/conda/envs/dl_dp_obj_det_env
# COPY --from=builder /opt/conda/envs/dp_uied3 /opt/conda/envs/dp_uied3

# RUN conda init && conda activate dl_dp_obj_det_env && python -m spacy download en_core_web_trf && conda activate dp_uied3 && python -m spacy download en_core_web_trf

ADD . /AidUI

# ## This can be found at https://pytorch.org/hub/nvidia_deeplearningexamples_resnet50/
# COPY resnet50-0676ba61.pth /root/.cache/torch/hub/checkpoints/

# ## Can be found at https://drive.google.com/file/d/1Gzpi-V_Sj7SSFQMNzy6bcgkEwaZBhGWS/view
# COPY cnn-rico-1.h5 /root/.cache/torch/hub/checkpoints/

RUN chmod +x /AidUI/setup.sh

# RUN /bin/bash -c "source activate dl_dp_obj_det_env && python -m spacy download en_core_web_trf"
# RUN /bin/bash -c "source activate dp_uied3 && python -m spacy download en_core_web_trf"

# CMD ["/bin/bash", "/AidUI/model_setup.sh"]


