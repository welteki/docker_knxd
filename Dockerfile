FROM resin/rpi-raspbian

# Create knxd user with UID 1001
RUN useradd knxd -u 1001 -s /bin/bash -U -M -G dialout

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
