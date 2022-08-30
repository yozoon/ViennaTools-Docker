# syntax=docker/dockerfile:1
FROM ubuntu:22.04

ARG VIENNALS_GIT_COMMIT
ARG VIENNARAY_GIT_COMMIT
ARG VIENNAPS_GIT_COMMIT

RUN mkdir -p /ViennaTools
WORKDIR /ViennaTools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Europe/Vienna apt-get install -y --no-install-recommends \
    build-essential \
    git \
    cmake \
    libvtk9.1 \
    libvtk9-dev \
    libembree3-3 \
    libembree-dev \
    wget && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/ViennaTools/ViennaLS/archive/$VIENNALS_GIT_COMMIT.tar.gz \
    -O /tmp/ViennaLS.tar.gz && tar -xf /tmp/ViennaLS.tar.gz \
    --directory /ViennaTools && mv /ViennaTools/ViennaLS-$VIENNALS_GIT_COMMIT /ViennaTools/ViennaLS
RUN wget https://github.com/ViennaTools/ViennaRay/archive/$VIENNARAY_GIT_COMMIT.tar.gz \
    -O /tmp/ViennaRay.tar.gz && tar -xf /tmp/ViennaRay.tar.gz \
    --directory /ViennaTools && mv /ViennaTools/ViennaRay-$VIENNARAY_GIT_COMMIT /ViennaTools/ViennaRay
COPY viennals_cmake.patch ViennaLS/cmake.patch
RUN cd ViennaLS && patch -u CMakeLists.txt -i cmake.patch && mkdir build && cd build && cmake .. \
    -D VTK_DIR=/usr/lib/x86_64-linux-gnu/cmake/vtk-9.1/ \
    -D CMAKE_INSTALL_PREFIX=/usr && make buildDependencies && make install
COPY viennaray_cmake.patch ViennaRay/cmake.patch
RUN cd ViennaRay && patch -u CMakeLists.txt -i cmake.patch && mkdir build && cd build && cmake .. \
    -D embree_DIR=/usr/lib/x86_64-linux-gnu/cmake/embree-3.12.2/ \
    -D CMAKE_INSTALL_PREFIX=/usr && make install
WORKDIR /mnt/output
USER 1000:1000
CMD cmake /mnt/project && make && bash run.sh
