# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# The libembree* packages only exists for x86_64, thus we have to change our install dependencies
# if we are on another architecture
RUN export DEPENDENCIES="apt-utils build-essential git cmake libvtk9.1 libvtk9-dev qtbase5-dev wget" \
    && if test "$(uname -m)" = 'x86_64'; then export DEPENDENCIES="$DEPENDENCIES libembree3-3 libembree-dev"; fi \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive TZ=Europe/Vienna apt-get install -y --no-install-recommends $DEPENDENCIES \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /ViennaTools
WORKDIR /ViennaTools

ENV VIENNALS_GIT_COMMIT=fcaa9c486e40a299c3144a89043647ac9006ba3c
ENV VIENNARAY_GIT_COMMIT=35b5aed51593cb501f3409e0343016fd956c1c8d

RUN wget https://github.com/ViennaTools/ViennaLS/archive/$VIENNALS_GIT_COMMIT.tar.gz \
    -O /tmp/ViennaLS.tar.gz && tar -xf /tmp/ViennaLS.tar.gz \
    --directory /ViennaTools && mv /ViennaTools/ViennaLS-$VIENNALS_GIT_COMMIT /ViennaTools/ViennaLS
RUN wget https://github.com/ViennaTools/ViennaRay/archive/$VIENNARAY_GIT_COMMIT.tar.gz \
    -O /tmp/ViennaRay.tar.gz && tar -xf /tmp/ViennaRay.tar.gz \
    --directory /ViennaTools && mv /ViennaTools/ViennaRay-$VIENNARAY_GIT_COMMIT /ViennaTools/ViennaRay
COPY viennals_cmake.patch ViennaLS/cmake.patch
RUN cd ViennaLS && patch -u CMakeLists.txt -i cmake.patch && mkdir build && cd build && cmake .. \
    -D CMAKE_INSTALL_PREFIX=/usr && make buildDependencies && make install
COPY viennaray_cmake.patch ViennaRay/cmake.patch
RUN cd ViennaRay && patch -u CMakeLists.txt -i cmake.patch && mkdir build && cd build && cmake .. \
    -D CMAKE_INSTALL_PREFIX=/usr && make -j $(nproc) && make install
COPY launch.sh launch.sh
WORKDIR /mnt/output
USER 1000:1000
CMD bash /ViennaTools/launch.sh
