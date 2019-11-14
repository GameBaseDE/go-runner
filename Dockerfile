# Base image: https://hub.docker.com/_/golang/
FROM golang:alpine
LABEL maintainer="Stefan Lukas <etaloof@gmail.com>"

# Install golint
ENV GOPATH /go
ENV PATH ${GOPATH}/bin:$PATH
RUN apk --no-cache add git
RUN go get -u golang.org/x/lint/golint

COPY llvm.sh llvm.sh

# Install Clang
RUN apk add --no-cache lsb-release curl software-properties-common
RUN bash llvm.sh
RUN apk del lsb-release curl software-properties-common

# Set Clang as default CC
ENV set_clang /etc/profile.d/set-clang-cc.sh
RUN echo "export CC=clang-9" | tee -a ${set_clang} && chmod a+x ${set_clang}