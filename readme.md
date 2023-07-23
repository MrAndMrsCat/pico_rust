# PicoRust

Visual Studio Code [developement container](https://code.visualstudio.com/docs/devcontainers/containers) for the Raspberry Pi Pico using Rust [Embassy](https://github.com/embassy-rs/embassy) framework.

# debugger

Project expects a pico-probe connected to the container.

# Windows WSL

To attach the pico-probe / usb debugger to the WSL environment, open powershell and list the devices with 

`usbipd wsl list`

the probe should be in the list, like so:

```
BUSID  VID:PID    DEVICE                                                        STATE
1-2    1e71:2006  USB Input Device                                              Not attached
2-2    046d:c52b  Logitech USB Input Device, USB Input Device                   Not attached
2-3    0a12:0001  Generic Bluetooth Radio                                       Not attached
4-1    2516:008f  USB Input Device                                              Not attached
4-2    2e8a:000c  Picoprobe CMSIS-DAP v2, USB Serial Device (COM3)              Not attached
4-4    0781:5571  USB Mass Storage Device                                       Not attached
```

use the BUSID to attach

`usbipd wsl attach --busid 4-2`