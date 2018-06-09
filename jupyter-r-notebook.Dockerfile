FROM jupyter/r-notebook
LABEL maintainer="Mohammed Alsahli <mohmmad1024@gmail.com>"

USER root

RUN apt-get update && apt-get install -y \
    build-essential git libatlas-base-dev libopencv-dev python-opencv \
    libcurl4-openssl-dev libgtest-dev cmake wget unzip

RUN cd /usr/src/gtest && cmake CMakeLists.txt && make && cp *.a /usr/lib

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | apt-key add -
RUN apt-get update
RUN apt-get install -y r-base r-base-dev libxml2-dev libxt-dev libssl-dev

Rscript -e "install.packages('devtools', repo = 'https://cran.rstudio.com')"
Rscript -e "library(devtools); library(methods); options(repos=c(CRAN='https://cran.rstudio.com')); install_deps(dependencies = TRUE)"

RUN cd mxnet && make rpkg && R CMD INSTALL mxnet_current_r.tar.gz

#going normal agin
USER jovyan
WORKDIR /home/jovyan/