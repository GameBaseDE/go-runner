# Base image: https://hub.docker.com/_/golang/
FROM golang:alpine
LABEL maintainer="Stefan Lukas <etaloof@gmail.com>"

# Install golint
ENV GOPATH /go
ENV PATH ${GOPATH}/bin:$PATH
RUN apk --no-cache add git
RUN go get -u golang.org/x/lint/golint

COPY llvm.sh llvm.sh

# Install build dependencies
RUN apk add --no-cache clang clang-dev musl-dev bash build-base gcc abuild binutils binutils-doc gcc-doc lld
ENV CC clang
ENV CXX clang++
RUN go env