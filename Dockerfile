FROM ubuntu:focal

LABEL Description="MiKTeX build environment, Ubuntu 20.04" Vendor="Christian Schenk" Version="21.3"

RUN    DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN    apt-get install -y --no-install-recommends \
           bison \
           ca-certificates \
           cmake \
           curl \
           dpkg-dev \
           file \
           flex \
           g++ \
           gcc \
           gettext \
           git \
           gosu \
           libboost-locale-dev \
           libbz2-dev \
           libcairo2-dev \
           libcurl4-openssl-dev \
           libfribidi-dev \
           libgd-dev \
           libgmp-dev \
           libgraphite2-dev \
           libhunspell-dev \
           libicu-dev \
           liblog4cxx-dev \
           libmpfr-dev \
           libmspack-dev \
           libpopt-dev \
           libpotrace-dev \
           libssl-dev \
           liburiparser-dev \
           libzzip-dev \
           make \
           qtbase5-dev \
           qtdeclarative5-dev \
           qtscript5-dev \
           qttools5-dev \
           xsltproc \
           xz-utils

#RUN    curl --fail --location --show-error --silent https://cmake.org/files/v3.14/cmake-3.14.3-Linux-x86_64.tar.gz \
#     | tar -xz --strip=1 -C /usr/local

RUN mkdir /miktex
WORKDIR /miktex

COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/make-package.sh"]
