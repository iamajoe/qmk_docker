# TODO: setup environment variables for these
KEYBOARD ?= usercustom
KEYMAP_NAME ?= default

.PHONY: build flash

build:
	mkdir -p $(CURDIR)/build
	docker build -t qmk_firmware -f Dockerfile.qmk .
	docker run --rm -it \
		-v "$(CURDIR)/keyboard:/root/keyboard" \
		-v "$(CURDIR)/build:/root/build" \
		-e "KEYBOARD=${KEYBOARD}" \
		-e "KEYMAP=${KEYMAP_NAME}" \
		--name qmk_firmware_run \
		qmk_firmware 

flash: 
	docker build -t flash_firmware -f Dockerfile.flash .
	docker run --rm -it \
		--privileged -v /dev:/dev \
		--user $$(id -u):$$(id -g) \
		-v "$(CURDIR)/build/built.hex:/root/keyboard.hex" \
		--name flash_firmware_run \
		flash_firmware 


