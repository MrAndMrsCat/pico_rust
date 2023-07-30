FROM ubuntu

# [utilities]
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl ca-certificates usbutils minicom nano netcat


# [debugger] - need a special raspberry pi build of open OCD (on chip debugger) 
RUN apt-get install -y --no-install-recommends \
    gdb-multiarch \
    pkg-config automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-dev libudev-dev libncurses5

RUN git clone https://github.com/raspberrypi/openocd.git --branch picoprobe --depth=1 \
    && cd openocd \
    && ./bootstrap \
    && ./configure --disable-werror --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio --enable-picoprobe \
    && make -j4 \
    && make install

# - add device permission
RUN mkdir -p /etc/udev/rules.d
RUN echo 'ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE:="0666"' > /etc/udev/rules.d/99-openocd.rules


# [arm GNU toolchain]
RUN cd /tmp \
    && curl -Lo gcc-arm-none-eabi.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2" \
    && mkdir /usr/share/gcc-arm-none-eabi \
    && tar xf gcc-arm-none-eabi.tar.xz --strip-components=1 -C /usr/share/gcc-arm-none-eabi \
    && rm -rf gcc-arm-none-eabi.tar.xz

RUN ln -s /usr/share/gcc-arm-none-eabi/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc \
    && ln -s /usr/share/gcc-arm-none-eabi/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++ \
    && ln -s /usr/share/gcc-arm-none-eabi/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb \
    && ln -s /usr/share/gcc-arm-none-eabi/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size \
    && ln -s /usr/share/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy \
    && ln -s /usr/share/gcc-arm-none-eabi/bin/arm-none-eabi-nm /usr/bin/arm-none-eabi-nm
    

# [rust]
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# use nightly rustc as embedded-hal-async v0.2.0-alpha.2 is not in the stable channel yet..
RUN rustup install nightly && rustup default nightly

RUN rustup target install thumbv6m-none-eabi \
    && cargo install flip-link \
    && cargo install probe-run \
    && cargo install defmt-print \
    && cargo install cargo-binutils \
    && rustup component add llvm-tools-preview
