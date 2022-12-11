FROM debian:bullseye as builder

ARG KNXD_VERSION
ARG KNXD_REF

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends\
            ca-certificates \
            git-core \
            build-essential \
            debhelper \
            autoconf \
            automake \
            libusb-1.0-0-dev \
            pkg-config \
            libsystemd-dev \
            libev-dev \
            cmake

# Build knxd
RUN git clone -b debian https://github.com/knxd/knxd.git
RUN cd knxd && git checkout $KNXD_REF && dpkg-buildpackage -b -uc

FROM debian:bullseye-slim

LABEL maintainer="Han Verstraete <welteki@pm.me>" \
      knxd_version=$KNXD_VERSION

COPY --from=builder /knxd_*.deb /
COPY --from=builder /knxd-tools_*.deb /

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends\
            libusb-1.0-0 \
            libev4 \
            lsb-base \
      && rm -rf /var/lib/apt/lists/*

RUN dpkg -i knxd_*.deb knxd-tools_*.deb

CMD ["/bin/bash"]
