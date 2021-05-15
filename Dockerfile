# AUTHOR: William ZHOU (me@willzhou.com)

FROM nvidia/cuda:11.3.0-devel-ubuntu20.04 AS builder

# Step 1: Install dependency
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -yq --no-install-recommends \
        build-essential \
        cmake \
        git && \
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Step 2: build!
COPY . /ethminer
WORKDIR /ethminer
ADD https://boostorg.jfrog.io/artifactory/main/release/1.66.0/source/boost_1_66_0.7z /root/.hunter/_Base/Download/Boost/1.66.0/075d0b4/boost_1_66_0.7z
RUN git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    cmake .. -DBINKERN=OFF -DETHASHCL=OFF && \
    cmake --build . -j && \
    make install

## Build Completed
FROM nvidia/cuda:11.3.0-runtime-ubuntu20.04 
COPY --from=builder /usr/local/bin/ethminer /usr/local/bin
ADD helper /ethminer/helper
RUN /ethminer/helper/init.sh
CMD ["bash", "-c", "/ethminer/helper/runner.sh"]

