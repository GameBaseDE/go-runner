# Base image: https://hub.docker.com/_/golang/
FROM golang:latest
MAINTAINER Stefan Lukas <etaloof@gmail.com>

# Install golint
ENV GOPATH /go
ENV PATH ${GOPATH}/bin:$PATH
RUN go get -u golang.org/x/lint/golint

COPY llvm.sh llvm.sh

# Install Clang
RUN apt-get update && apt-get install -y lsb-release curl software-properties-common && apt-get update
RUN bash llvm.sh
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set Clang as default CC
ENV set_clang /etc/profile.d/set-clang-cc.sh
RUN echo "export CC=clang-9" | tee -a ${set_clang} && chmod a+x ${set_clang}