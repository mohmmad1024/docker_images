FROM jupyter/r-notebook
LABEL maintainer="Mohammed Alsahli <mohmmad1024@gmail.com>"

USER root

COPY --from=mxnet/r-lang:latest /mxnet /home/jovyan/mxnet

RUN apt-get update && apt-get install -y build-essential git libopenblas-dev liblapack-dev libopencv-dev  r-base r-base-dev libxml2-dev libxt-dev libssl-dev
RUN git clone --recursive https://github.com/apache/incubator-mxnet
WORKDIR /home/jovyan/incubator-mxnet
RUN make -j $(nproc) USE_OPENCV=1 USE_BLAS=openblas
RUN make rpkg && R CMD INSTALL mxnet_current_r.tar.gz

#RUN ln -s /bin/tar /bin/gtar && cd /home/jovyan/mxnet/R-package \
#&& Rscript -e "install.packages('devtools', repo = 'https://cran.rstudio.com')" \
#&& Rscript -e "library(devtools); library(methods); options(repos=c(CRAN='https://cran.rstudio.com')); install_deps(dependencies = TRUE)"
#RUN Rscript -e "cran <- getOption('repos');cran['dmlc'] <- 'https://s3-us-west-2.amazonaws.com/apache-mxnet/R/CRAN/';options(repos = cran);install.packages('mxnet',repos='http://cran.ma.imperial.ac.uk/',dependencies = T)"
#RUN cd /home/jovyan/mxnet \
#&& R CMD INSTALL mxnet_current_r.tar.gz
#going normal agin
USER jovyan
WORKDIR /home/jovyan/