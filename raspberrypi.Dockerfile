FROM ubuntu:22.04

ARG USER
ARG USER_ID
ARG GROUP_ID

RUN apt-get update
RUN apt-get install -y \
    bc \
    bison \
    flex \
    libssl-dev \
    make \
    libc6-dev \
    libncurses5-dev \
    crossbuild-essential-arm64 \
    crossbuild-essential-armhf

RUN groupadd -g ${GROUP_ID} ${USER}
RUN useradd -m -u ${USER_ID} -g ${USER} ${USER}

ENV HOME=/home/${USER}
ENV USER=${USER}