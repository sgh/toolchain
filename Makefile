
# ARM-processorts
TARGET := arm-elf
TARGET_OPTS = --enable-interwork

# Hitachi H3xx-series
;TARGET := h8300-hms

## Motorola
;TARGET := m68k-bdm-elf

# HC11
;TARGET := m6811-elf


WGET := wget
MAKE := make
PATCH := patch

TARGETS := binutils gcc newlib

TARGETS_CLEAN:=$(patsubst %,%-clean,$(TARGETS))
TARGETS_INSTALL:=$(patsubst %,%-install,$(TARGETS))

.SILENT: world

TARGET_DIR := $(shell pwd)/$(TARGET)-tools
BUILD_DIR := $(shell pwd)/$(TARGET)_build/
DL_DIR := src/
TOOLS_DIR := tools/

all: world

clean: $(TARGETS_CLEAN)

install: $(TARGETS_INSTALL)

include tools/*/*.mk
include tools/*/Makefile


world: $(BUILD_DIR) $(TARGETS)
	echo
	echo "Build complete :). Toolchain resides in $(TARGET_DIR)"

$(BUILD_DIR):
	mkdir -p $@

