
TARGET := arm-elf


WGET := wget
MAKE := make

TARGETS := binutils 
TARGETS_CLEAN:=$(patsubst %,%-clean,$(TARGETS))
TARGETS_INSTALL:=$(patsubst %,%-install,$(TARGETS))

.SILENT: world

TARGET_DIR := $(shell pwd)/$(TARGET)-tools
BUILD_DIR := $(shell pwd)/$(TARGET)_build/
DL_DIR := src/


all: world

clean: $(TARGETS_CLEAN)

install: $(TARGETS_INSTALL)

include tools/*/*.mk
include tools/*/Makefile


world: $(BUILD_DIR) $(TARGETS)
	echo "Build complete. Toolchain resides in $(TARGET_DIR)"

$(BUILD_DIR):
	mkdir -p $@

