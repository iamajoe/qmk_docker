# QMK docker

Setup for building and flashing QMK firmware using docker.

Based on [github.com/j6s/ergodone-qmk](https://github.com/j6s/ergodone-qmk)

## Requirements

The setup assumes that you have docker and make installed. Alternatively (to make) you could run the `docker` commands inside the `Makefile` yourself and bypass this way the need of `make`.

## Building

Create a folder `./keyboard/usercustom` and inside, set the config files as per QMK documentation. Inside, you should have a `default` keymap.

This repository contains everything that is needed for building & flashing the firmware - it will grab the latest copy of qmk_firmware
automatically when building.

Use `make build` to build the firmware.
A `./build` folder is created with the hex inside.
You should be able now to do `make flash` and flash that hex to the keyboard.

### Different keyboard

You can use a different keyboard inside the `./keyboard` folder by running the commands like so:

```bash
KEYBOARD=foo KEYMAP_NAME=bar make build
KEYBOARD_HEX=zed.hex make flash
```
