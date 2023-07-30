# PicoRust

Visual Studio Code [developement container](https://code.visualstudio.com/docs/devcontainers/containers) for the Raspberry Pi Pico using Rust [Embassy](https://github.com/embassy-rs/embassy) framework, with flashing / step through debugging using an attached picoprobe.

## debugger

The container expects a pico-probe is connected at these paths in [devcontainer.json](https://github.com/MrAndMrsCat/PicoRust/blob/main/.devcontainer/devcontainer.json), or the container will fail to run.

```
"runArgs": ["--device=/dev/bus/usb", "--device=/dev/ttyACM0"]
```

### Windows WSL

On windows another step is to attach the pico-probe / usb debugger to WSL, open powershell and list the devices with:

`usbipd wsl list`

the probe should be listed:

```
BUSID  VID:PID    DEVICE                                                        STATE
1-2    1e71:2006  USB Input Device                                              Not attached
2-2    046d:c52b  Logitech USB Input Device, USB Input Device                   Not attached
2-3    0a12:0001  Generic Bluetooth Radio                                       Not attached
4-1    2516:008f  USB Input Device                                              Not attached
4-2    2e8a:000c  Picoprobe CMSIS-DAP v2, USB Serial Device (COM3)              Not attached
4-4    0781:5571  USB Mass Storage Device                                       Not attached
```

use the BUSID to attach.

`usbipd wsl attach --busid 4-2`

### Other probes / targets

Asides from different dependancies in the Dockerfile, changes will probably be required in [tasks.json](https://github.com/MrAndMrsCat/PicoRust/blob/main/.vscode/tasks.json) e.g. config for the picoprobe here:

```
"type": "shell",
"label": "Start-OpenOCD",
"command": "openocd",
"args": [
    "-f", "interface/cmsis-dap.cfg",
    "-f", "target/rp2040.cfg",
    "-s", "tcl",
    "-c", "adapter speed 5000"
],
```

## App

The application source files are under [app/src](https://github.com/MrAndMrsCat/PicoRust/tree/main/app/src) with the entry point [app/src/main.rs](https://github.com/MrAndMrsCat/PicoRust/tree/main/app/src/main.rs).

### Logging

The [defmt](https://github.com/knurling-rs/defmt) stream can be opened with [print_defmt.sh](https://github.com/MrAndMrsCat/PicoRust/tree/main/print_defmt.sh).

## Acknowledgements 

[The Relational Technologist - getting-started-with-rust-on-a-raspberry](https://reltech.substack.com/p/getting-started-with-rust-on-a-raspberry)