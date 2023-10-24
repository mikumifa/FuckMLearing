FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    wget \
    bzip2

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && \
    bash Anaconda3-2021.05-Linux-x86_64.sh -b -p /opt/conda

ENV PATH /opt/conda/bin:$PATH
WORKDIR /app/MeTAL

RUN conda create -n metal python=3.7.10
RUN echo "conda activate metal" >> ~/.bashrc


RUN /bin/bash -c "source activate metal && \
    conda install -y pytorch=1.4 numpy=1.19.2 &&\
    conda install pytorch=1.4.0 torchvision=0.2.1 cudatoolkit=10.1 -c pytorch &&\
    conda install -c conda-forge tensorboard &&\
    conda install numpy=1.19.2 scipy=1.1.0 matplotlib=3.2.1 &&\
    conda install -c conda-forge pbzip2 pydrive &&\
    conda install pillow=7.1.2 tqdm"

WORKDIR /app
RUN apt-get install -y git
RUN git clone https://github.com/baiksung/MeTAL

RUN mkdir /app/MeTAL/datasets

RUN pip install gdown

# 下载文件使用gdown
RUN gdown --id 1qQCoGoEJKUCQkk8roncWH7rhPN7aMfBr -O /app/MeTAL/datasets/miniImagenet.tar.gz
RUN tar -xvjf  /app/MeTAL/datasets/miniImagenet.tar.gz -C /app/MeTAL/datasets/

RUN /bin/bash -c "source activate metal && \
    bash /app/MeTAL/install.sh"

CMD ["/bin/bash", "-c", "source activate metal && cd /app/MeTAL/experiment_scripts && bash MeTAL.sh 0"]

