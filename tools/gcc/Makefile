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

$(GCC_DIR)-bootstrap/.configured-bootstrap: $(NEWLIB_DIR)/.unpacked $(GCC_DIR)/.unpacked 
	(mkdir -p $(GCC_DIR)-bootstrap; cd $(GCC_DIR)-bootstrap; \
	$(GCC_DIR)/configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--without-headers \
			--enable-languages="c,c++" \
			--enable-target-opt-space \
			$(TARGET_OPTS) \
			--enable-multilib; \
	touch .configured-bootstrap );

$(GCC_DIR)-final/.configured-final: $(NEWLIB_DIR)/.unpacked $(GCC_DIR)/.unpacked 
	(mkdir -p $(GCC_DIR)-final; cd $(GCC_DIR)-final; \
	$(GCC_DIR)/configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--with-headers=$(NEWLIB_DIR)/newlib/libc/include \
			--enable-languages="c,c++" \
			--enable-target-opt-space \
			$(TARGET_OPTS) \
			--enable-multilib; \
	touch .configured-final );

gcc: binutils gcc-bootstrap

gcc-install: gcc-bootstrap

gcc-bootstrap: $(GCC_DIR)-bootstrap/.configured-bootstrap
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(GCC_DIR)-bootstrap all-gcc install-gcc

gcc-final: $(GCC_DIR)-final/.configured-final
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(GCC_DIR)-final all-gcc install-gcc


gcc-clean:
	$(MAKE) -C $(GCC_DIR) clean

gcc-dirclean:
	rm -rf $(GCC_DIR)
