#! /bin/bash
# after openocd has reached "accepting 'rtt' connection on tcp/8765" this can read the running app log messages
# see https://ferrous-systems.com/blog/gdb-and-defmt/
nc localhost 8765 | defmt-print -e /workspaces/PicoRust/app/target/thumbv6m-none-eabi/debug/pico-rust