#############################################################
#
# gcc
#
#############################################################

$(DL_DIR)/$(GCC_SOURCE):
	$(WGET) -P $(DL_DIR) $(GCC_SITE)/$(GCC_SOURCE)

$(GCC_DIR)/.unpacked: $(DL_DIR)/$(GCC_SOURCE)
	$(GCC_CAT) $(DL_DIR)/$(GCC_SOURCE) | tar -C $(BUILD_DIR) -xf -
	$(PATCH) -p0 -d $(GCC_DIR) < $(shell pwd)/$(TOOLS_DIR)/gcc/arm-elf-multilib.patch
	touch $(GCC_DIR)/.unpacked

$(GCC_DIR)/.configured: $(NEWLIB_DIR)/.unpacked $(GCC_DIR)/.unpacked 
	(cd $(GCC_DIR); \
	./configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--enable-languages="c,c++" \
			--enable-target-opt-space --with-headers=$(NEWLIB_DIR)/newlib/libc/include \
			--enable-multilib; \
	touch .configured );

gcc: binutils gcc-install

gcc-install: $(GCC_DIR)/.configured
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(GCC_DIR) all-gcc install-gcc

gcc-clean:
	$(MAKE) -C $(GCC_DIR) clean

gcc-dirclean:
	rm -rf $(GCC_DIR)
