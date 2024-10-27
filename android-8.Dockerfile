FROM ubuntu:14.04

ARG USER
ARG USER_ID
ARG GROUP_ID

RUN apt-get update
RUN apt-get install -y \
    git-core \
    gnupg \
    flex \
    bison \
    gperf \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    lib32ncurses5-dev \
    x11proto-core-dev \
    libx11-dev \
    lib32z-dev \
    ccache \
    libgl1-mesa-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    python \
    openjdk-7-jdk

RUN curl -o jdk8.tgz https://android.googlesource.com/platform/prebuilts/jdk/jdk8/+archive/master.tar.gz \
    && tar -zxf jdk8.tgz linux-x86 \
    && mv linux-x86 /usr/lib/jvm/java-8-openjdk-amd64 \
    && rm -rf jdk8.tgz

RUN groupadd -g ${GROUP_ID} ${USER}
RUN useradd -m -u ${USER_ID} -g ${USER} ${USER}

ENV HOME=/home/${USER}
ENV USER=${USER}