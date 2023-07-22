docker run --rm -it --device=/dev/bus/usb --device=/dev/ttyACM0 --entrypoint bash pico-rust-dev-env:master

# --security-opt seccomp=unconfined