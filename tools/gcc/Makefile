#############################################################
#
# gcc
#
#############################################################

$(DL_DIR)/$(GCC_SOURCE):
	$(WGET) -P $(DL_DIR) $(GCC_SITE)/$(GCC_SOURCE)

$(GCC_DIR)/.unpacked: $(DL_DIR)/$(GCC_SOURCE)
	$(GCC_CAT) $(DL_DIR)/$(GCC_SOURCE) | tar -C $(BUILD_DIR) -xf -
	touch $(GCC_DIR)/.unpacked

$(GCC_DIR)/.configured: $(GCC_DIR)/.unpacked $(NEWLIB_DIR)/.unpacked
	(cd $(GCC_DIR); \
	./configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--enable-languages="c,c++" \
			--enable-target-opt-space --with-headers=$(NEWLIB_DIR)/newlib/libc/include \
			--enable-multilib; \
	touch .configured );

$(GCC_DIR)/.installed: $(GCC_DIR)/.configured
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(GCC_DIR) all-gcc install-gcc
	touch $(GCC_DIR)/.installed

gcc: binutils $(GCC_DIR)/.installed

gcc-install: 
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(GCC_DIR) install-gcc

gcc-clean:
	$(MAKE) -C $(GCC_DIR) clean

gcc-dirclean:
	rm -rf $(GCC_DIR)
