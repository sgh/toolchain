#############################################################
#
# gcc
#
#############################################################

$(DL_DIR)/$(GCC_SOURCE):
	$(WGET) -P $(DL_DIR) $(GCC_SITE)/$(GCC_SOURCE)

$(GCC_DIR): $(DL_DIR)/$(GCC_SOURCE)
	$(GCC_CAT) $(DL_DIR)/$(GCC_SOURCE) | tar -C $(BUILD_DIR) -xf -
	$(PATCH) -p0 -d $(GCC_DIR) < $(shell pwd)/$(TOOLS_DIR)/gcc/arm-elf-multilib.patch
	mkdir -p $(GCC_DIR)_build

$(GCC_DIR)_build: $(GCC_DIR) $(NEWLIB_DIR) 
	(mkdir -p $(GCC_DIR)_build; cd $(GCC_DIR)_build; \
	$(GCC_DIR)/configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--with-headers=$(NEWLIB_DIR)/newlib/libc/include \
			--disable-threads \
			--disable-__cxa_atexit \
			--enable-languages="c,c++" \
			--enable-target-opt-space \
			$(TARGET_OPTS) \
			--enable-multilib );

gcc: binutils gcc-install

gcc-install: $(GCC_DIR)_build
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(GCC_DIR)_build all-gcc install-gcc

gcc-clean:
	$(MAKE) -C $(GCC_DIR)_build clean

gcc-dirclean:
	rm -rf $(GCC_DIR)
	rm -rf $(GCC_DIR)_build
