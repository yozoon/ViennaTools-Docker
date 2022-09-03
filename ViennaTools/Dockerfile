# syntax=docker/dockerfile:1
FROM alpine:3.16

RUN apk add --no-cache bash gcc g++ patch make cmake git wget vtk vtk-dev embree embree-dev

ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++

RUN mkdir -p /ViennaTools
WORKDIR /ViennaTools

# Download ViennaLS
ENV VIENNALS_GIT_COMMIT=fcaa9c486e40a299c3144a89043647ac9006ba3c
RUN wget https://github.com/ViennaTools/ViennaLS/archive/$VIENNALS_GIT_COMMIT.tar.gz \
    -O /tmp/ViennaLS.tar.gz \
    && tar -xf /tmp/ViennaLS.tar.gz --directory /ViennaTools \
    && mv /ViennaTools/ViennaLS-$VIENNALS_GIT_COMMIT /ViennaTools/ViennaLS

# Build and install ViennaLS
COPY viennals_cmake.patch ViennaLS/cmake.patch
RUN cd ViennaLS \
    && patch -u CMakeLists.txt -i cmake.patch \
    && mkdir build && cd build \
    && cmake .. -D CMAKE_INSTALL_PREFIX=/usr \
    && make buildDependencies \
    && make install

# Download ViennaRay
ENV VIENNARAY_GIT_COMMIT=35b5aed51593cb501f3409e0343016fd956c1c8d
RUN wget https://github.com/ViennaTools/ViennaRay/archive/$VIENNARAY_GIT_COMMIT.tar.gz \
    -O /tmp/ViennaRay.tar.gz \
    && tar -xf /tmp/ViennaRay.tar.gz --directory /ViennaTools \
    && mv /ViennaTools/ViennaRay-$VIENNARAY_GIT_COMMIT /ViennaTools/ViennaRay

# Build and install ViennaRay
COPY viennaray_cmake.patch ViennaRay/cmake.patch
RUN cd ViennaRay \
    && patch -u CMakeLists.txt -i cmake.patch \
    && mkdir build \
    && cd build \
    && cmake .. -D CMAKE_INSTALL_PREFIX=/usr \
    && make -j $(nproc) \
    && make install

COPY launch.sh launch.sh
WORKDIR /mnt/output
USER 1000:1000
ENTRYPOINT ["bash", "/ViennaTools/launch.sh"]
