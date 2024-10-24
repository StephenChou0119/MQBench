# Contains CUDA 12.3.2, PyTorch 2.2.0a0+81ea7a48, APEX, Tensorboard, Torch-TensorRT etc.
# For 4090 it requires NVIDIA Driver release 545 or later.
# For A100 it requires NVIDIA Driver release 450.51 (or later R450), 470.57 (or later R470), or 510.47 (or later R510).
# For detail info please refer to https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html
FROM nvcr.io/nvidia/pytorch:23.12-py3

# Common tools
#RUN DEBIAN_FRONTEND=noninteractive apt update && apt upgrade -y && \
#    apt install -y nethogs htop iputils-ping zip unzip rsync rclone ffmpeg
COPY sources.list /etc/apt/sources.list
RUN apt update && apt upgrade -y && \
    apt install -y nethogs htop iputils-ping zip unzip rsync rclone ffmpeg
RUN apt clean && rm -rf /var/cache/apt/*

# Setup workspace
RUN mkdir -p /workspace
RUN mkdir -p /root/.cache/torch/hub/checkpoints
WORKDIR /workspace

# Project requirements
COPY ./requirements.txt ./requirements.txt
RUN pip install -r ./requirements.txt
RUN rm /workspace/requirements.txt

# For dynamic pillar/voxel encoder
RUN FORCE_CUDA=1 pip install --no-cache-dir --verbose torch-scatter==2.1.2

# jemalloc
COPY ./install_jemalloc.sh ./install_jemalloc.sh
RUN bash install_jemalloc.sh
RUN rm /workspace/install_jemalloc.sh
COPY MQBench /MQBench
RUN cd /MQBench && python setup.py install