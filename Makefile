KEYBOARD ?= usercustom
KEYMAP ?= default

TKG_DIR=${CURDIR}/tkg_toolkit

HID_BOOTLOADER=${TKG_DIR}/linux/bin/hid_bootloader_cli
ifeq ($(shell uname), Darwin)
  HID_BOOTLOADER=${TKG_DIR}/mac/bin/hid_bootloader_cli
endif

.PHONY: build flash flashraw flashmacsilicone

${TKG_DIR}:
	git clone https://github.com/kairyu/tkg-toolkit ${TKG_DIR} --recursive

build:
	mkdir -p $(CURDIR)/build
	docker build -t qmk_firmware -f Dockerfile.qmk .
	docker run --rm -it \
		-v "$(CURDIR)/keyboard:/root/keyboard" \
		-v "$(CURDIR)/build:/root/build" \
		-e "KEYBOARD=${KEYBOARD}" \
		-e "KEYMAP=${KEYMAP}" \
		--name qmk_firmware_run \
		qmk_firmware 

flash: ${TKG_DIR} build
	sudo ${HID_BOOTLOADER} -w -v -mmcu=atmega32u4 $(CURDIR)/build/built.hex:/root/keyboard.hex

flashdocker: 
	docker build -t flash_firmware -f Dockerfile.flash .
	docker run --rm -it \
		--privileged -v /dev:/dev \
		--user $$(id -u):$$(id -g) \
		-v "$(CURDIR)/build/built.hex:/root/keyboard.hex" \
		--name flash_firmware_run \
		flash_firmware 

# TODO: this should be automatic
flashdockermacsilicone: 
	docker build -t flash_firmware --platform linux/x86_64 -f Dockerfile.flash .
	docker run --rm -it \
		--privileged -v /dev:/dev \
		--user $$(id -u):$$(id -g) \
		-v "$(CURDIR)/build/built.hex:/root/keyboard.hex" \
		--name flash_firmware_run \
		flash_firmware 
