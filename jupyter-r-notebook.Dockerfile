FROM jupyter/r-notebook
LABEL maintainer="Mohammed Alsahli <mohmmad1024@gmail.com>"

RUN apt-get update && apt-get install -y build-essential git libopenblas-dev liblapack-dev libopencv-dev

RUN git clone --recursive https://github.com/apache/incubator-mxnet && cd incubator-mxnet
RUN make -j $(nproc) USE_OPENCV=1 USE_BLAS=openblas

RUN make rpkg && R CMD INSTALL mxnet_current_r.tar.gz
