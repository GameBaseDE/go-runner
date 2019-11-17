# Base image: https://hub.docker.com/_/golang/
FROM golang:latest
LABEL maintainer="Stefan Lukas <etaloof@gmail.com>"

# Install golint
ENV GOPATH /go
ENV PATH ${GOPATH}/bin:$PATH
RUN apt-get update && apt-get install -y git
RUN go get -u golang.org/x/lint/golint

COPY llvm.sh llvm.sh

# Install build dependencies
RUN apt-get update \
    && apt-get install -y lsb-release curl software-properties-common \
    && apt-get update
RUN bash llvm.sh
RUN apt-get clean \
    && apt-get purge -y lsb-release curl software-properties-common \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV CC clang-9
ENV CXX clang-9++
RUN go env