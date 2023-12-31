# pull from devel image instead of base
#old = FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

FROM nvidia/cuda:12.2.2-devel-ubuntu22.04



# Set bash as the default shell
ENV SHELL=/bin/bash

# Create a working directory
WORKDIR /app/



# Build with some basic utilities
RUN apt-get update && apt-get install -y \
    python3-pip \
    apt-utils \
    vim \
    git

# alias python='python3'
RUN ln -s /usr/bin/python3 /usr/bin/python


# Copy the requirements.txt file to the container
COPY requirements.txt  requirements.txt

# Install the packages from requirements.txt
RUN pip install -r  requirements.txt

# install jupyter lab extensions
RUN pip install \
    # https://github.com/mohirio/jupyterlab-horizon-theme
    jupyterlab-horizon-theme \
    # https://github.com/jupyterlab/jupyterlab-git
    jupyterlab-git \
    # https://github.com/jtpio/jupyterlab-system-monitor
    jupyterlab-system-monitor \
    jupyterlab_nvdashboard   \
    # Install ipykernel
    ipykernel

# build with some basic python packages
RUN pip install \
    torch \
    torchvision\ 
    torchaudio 
  

# start jupyter lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
EXPOSE 8888