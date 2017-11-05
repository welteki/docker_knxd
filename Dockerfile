FROM resin/rpi-raspbian

# Install dependencies
RUN apt-get update && apt-get install -y \
    git-core \
    build-essential \
    debhelper \
    autotools-dev \
    autoconf \
    automake \
    libtool \
    libusb-1.0-0-dev \
    pkg-config \
    libsystemd-daemon-dev \
    dh-systemd \
    libev-dev \
    cmake

# Build knxd
RUN git clone https://github.com/knxd/knxd.git
RUN cd knxd && git checkout master && dpkg-buildpackage -b -uc
RUN cd .. && dpkg -i knxd_*.deb knxd-tools_*.deb

CMD ["/bin/bash"]
