FROM ubuntu AS base


# [utilities]
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl ca-certificates usbutils minicom nano


# [debugger] - need a special raspberry pi build of open OCD (on chip debugger) 
RUN apt-get install -y --no-install-recommends \
    gdb-multiarch \
    pkg-config automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-dev libudev-dev

RUN git clone https://github.com/raspberrypi/openocd.git --branch picoprobe --depth=1 \
    && cd openocd \
    && ./bootstrap \
    && ./configure --disable-werror --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio --enable-picoprobe \
    && make -j4 \
    && make install

# - add device permission
RUN mkdir -p /etc/udev/rules.d
RUN echo 'ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE:="0666"' > /etc/udev/rules.d/99-openocd.rules


# [rust]
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup target install thumbv6m-none-eabi
RUN cargo install flip-link
RUN cargo install probe-run --locked



# [project]
# ADD ./docker/connect.sh .