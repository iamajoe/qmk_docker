# QMK utils

Setup for building and flashing QMK firmware.

Based on [github.com/j6s/ergodone-qmk](https://github.com/j6s/ergodone-qmk)

## Requirements

- `docker`
- `make`
- `git`

## Getting started

Create a folder `./keyboard/usercustom` and inside, set the keyboard config files as per QMK documentation with a `default` keymap.

## Build

```sh
make build
```

A `./build` folder is created with the hex inside.

## Flash

Any of these methods will run the `build` for you.

### Flash git local

This is my recommended flash method. The `tkg_toolkit` is cloned to your system and used directly.

```sh
make flash
```

### Flash through docker

A docker container will be created with the `tkg_toolkit` inside and will run from there.

```sh
make flashdocker
```

#### Macbook Silicone

Because of the different kind of architecture you need a different flash process

```sh
make flashdockermacsilicone
```

## Different keyboard

You might not want the `usercustom` folder and instead have your own. You can use a different keyboard inside the `./keyboard` folder by running the commands like so:

```bash
KEYBOARD=foo KEYMAP=bar make flash
```

This command will assume that you have the folder `./keyboard/foo` with a keymap `bar` inside.
