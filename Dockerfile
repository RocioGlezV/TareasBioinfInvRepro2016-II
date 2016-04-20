###########################################################
# Dockerfile
# Este dockerfile instala FastXTools a partir de una imagen de biodckr/biodocker
#
# Version:          1
# Software:         FastX-Toolkit
# Software Version: 0.0.14
# Description:      Herramientas para el pre-procesamiento de datos de secuenciación de siguiente generación
# Website:          http://hannonlab.cshl.edu/fastx_toolkit/index.html
# Tags:             Genomica
# Provides:         FastXTools 0.0.14
# Base Image:       biodckr/biodocker
# Build Cmd:        docker build -t biodckrdev/fastxtoolkit .
# Pull Cmd:         docker pull biodckrdev/fastxtoolkit
# Run Cmd:          docker run -it biodckrdev/fastxtoolkit /bin/bash
###########################################################

# Set the base image to Ubuntu
FROM biodckr/biodocker

################# BEGIN INSTALLATION #################

# Cambiar usuario a root
USER root


RUN wget https://github.com/agordon/libgtextutils/releases/download/0.7/libgtextutils-0.7.tar.gz && \
    tar xvf  libgtextutils-0.7.tar.gz && \
    cd libgtextutils-0.7 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    wget https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/fastx_toolkit-0.0.14.tar.bz2 && \
    tar -xvf fastx_toolkit-0.0.14.tar.bz2 && \
    cd fastx_toolkit-0.0.14 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf lib* fast*

# Cambiar usuario de nuevo a biodocker
USER biodocker

# Cambiar working directory a /data
WORKDIR /data/

################## INSTALLATION END ##################

# File Author / Maintainer
MAINTAINER Rocio Gonzalez-Vazquez
