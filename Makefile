
## Host environment
HOST = i686-linux-gnu
#HOST = i586-mingw32msvc
HOST_CPUS = `getconf _NPROCESSORS_ONLN`

# ARM-processors
TARGET := arm-elf
TARGET_OPTS = --enable-interwork

# AVR32
;TARGET := avr32-linux

WGET := wget
PATCH := patch

TARGETS := binutils gcc newlib gdb

TARGETS_CLEAN:=$(patsubst %,%-clean,$(TARGETS))
TARGETS_INSTALL:=$(patsubst %,%-install,$(TARGETS))

.SILENT: world

TARGET_DIR := $(shell pwd)/$(HOST)-$(TARGET)-tools
BUILD_DIR := $(shell pwd)/$(HOST)-$(TARGET)_build/
DL_DIR := src/
TOOLS_DIR := tools/

all: world

clean: $(TARGETS_CLEAN)

install: $(TARGETS_INSTALL)

include tools/*/*.mk
include tools/*/Makefile

versionfile:
	mkdir -p ${TARGET_DIR}
	( \
	echo -n "Metadata: " ; git describe ; \
	echo "GCC: " ${GCC_VER} ; \
	echo "Binutils " ${BINUTILS_VER} ; \
	echo "Newlib: " ${NEWLIB_VER} ; \
	echo "GDB: " ${GDB_VER} \
	) > ${TARGET_DIR}/README

world: $(BUILD_DIR) versionfile $(TARGETS)
	echo "Stripping toolchain"
	ls ${TARGET_DIR}/bin | grep -v "$(TARGET)-gccbug" | xargs -i strip ${TARGET_DIR}/bin/{}
	strip ${TARGET_DIR}/libexec/gcc/$(TARGET)/*/cc1
	strip ${TARGET_DIR}/libexec/gcc/$(TARGET)/*/cc1plus
	strip ${TARGET_DIR}/libexec/gcc/$(TARGET)/*/lto1
	echo
	echo "Build complete :). Toolchain resides in $(TARGET_DIR)"

$(BUILD_DIR):
	mkdir -p $@

