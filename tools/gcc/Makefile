#############################################################
#
# gcc
#
#############################################################

$(DL_DIR)/$(GCC_SOURCE):
	$(WGET) --passive -P $(DL_DIR) $(GCC_SITE)/$(GCC_SOURCE)

$(GCC_DIR): $(DL_DIR)/$(GCC_SOURCE) $(NEWLIB_DIR)
	$(GCC_CAT) $(DL_DIR)/$(GCC_SOURCE) | tar -C $(BUILD_DIR) -xf -
	mkdir -p $(TARGET_DIR)/arm-elf/include
	cp -r $(NEWLIB_DIR)/newlib/libc/include/* $(TARGET_DIR)/arm-elf/include/                                                       
	touch $(GCC_DIR)
	mkdir -p $(GCC_DIR)_build

$(GCC_DIR)_build: $(GCC_DIR)
	(mkdir -p $(GCC_DIR)_build; cd $(GCC_DIR)_build; \
	$(GCC_DIR)/configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--without-headers \
			--disable-__cxa_atexit \
			--enable-languages="c,c++" \
			--disable-nls \
			--enable-plugin \
			--with-newlib \
			--with-headers=$(NEWLIB_DIR)/newlib/libc/include \
			$(TARGET_OPTS) \
			--enable-multilib );

gcc: binutils gcc-install

gcc-install: $(GCC_DIR)_build
#PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -j 2 -C $(GCC_DIR)_build all-gcc all-target-libgcc install-gcc install-target-libgcc
	PATH=$(TARGET_DIR)/bin:$$PATH $(MAKE) -j ${HOST_CPUS} -C $(GCC_DIR)_build 
	PATH=$(TARGET_DIR)/bin:$$PATH $(MAKE) -C $(GCC_DIR)_build install

gcc-clean:
	$(MAKE) -C $(GCC_DIR)_build clean

gcc-dirclean:
	rm -rf $(GCC_DIR)
	rm -rf $(GCC_DIR)_build
