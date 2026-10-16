FROM jupyter/base-notebook:ubuntu-20.04

USER root

RUN mamba create -n paddle38 -y \
    -c conda-forge \
    python=3.8 \
    pip \
    notebook \
    ipykernel \
    && mamba clean --all -f -y

USER ${NB_UID}

RUN /opt/conda/envs/paddle38/bin/python -m pip install \
    --no-cache-dir \
    --find-links https://www.paddlepaddle.org.cn/whl/linux/mkl/avx/stable.html \
    paddlepaddle==2.3.0 \
    protobuf==3.20.1

RUN /opt/conda/envs/paddle38/bin/python -m pip install \
    --no-cache-dir \
    paddle-quantum==2.4.0

RUN /opt/conda/envs/paddle38/bin/python -m ipykernel install \
    --user \
    --name paddle38 \
    --display-name "Python 3.8 (Paddle Quantum)"
