FROM jupyter/base-notebook:ubuntu-20.04

USER root

# Install Python 3.8 in the existing Conda environment
RUN mamba install -n base -y \
    python=3.8 \
    pip \
    notebook \
    && mamba clean --all -f -y

USER ${NB_UID}

# Install the legacy PaddlePaddle version required by Paddle Quantum 2.4.0
RUN python -m pip install --no-cache-dir \
    --find-links https://www.paddlepaddle.org.cn/whl/linux/mkl/avx/stable.html \
    paddlepaddle==2.3.0 \
    protobuf==3.20.1

# Install Paddle Quantum and its declared dependencies
RUN python -m pip install --no-cache-dir paddle-quantum==2.4.0
