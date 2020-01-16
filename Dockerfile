FROM debian:buster as builder

ARG KNXD_VERSION
ARG KNXD_RELEASE_TAG

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends\
            ca-certificates \
            git-core \
            build-essential \
            debhelper \
            autotools-dev \
            autoconf \
            automake \
            libtool \
            libusb-1.0-0-dev \
            pkg-config \
            libsystemd-dev \
            dh-systemd \
            libev-dev \
            cmake

# Build knxd
RUN git clone https://github.com/knxd/knxd.git
RUN cd knxd && git checkout tags/$KNXD_RELEASE_TAG && dpkg-buildpackage -b -uc

FROM debian:buster-slim

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
