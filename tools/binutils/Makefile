#############################################################
#
# binutils 
#
#############################################################

$(DL_DIR)/$(BINUTILS_SOURCE):
	$(WGET) -P $(DL_DIR) $(BINUTILS_SITE)/$(BINUTILS_SOURCE)

$(BINUTILS_DIR): $(DL_DIR)/$(BINUTILS_SOURCE)
	$(BINUTILS_CAT) $(DL_DIR)/$(BINUTILS_SOURCE) | tar -C $(BUILD_DIR) -xf -
#	$(PATCH) -p1 -d $(BINUTILS_DIR) < $(shell pwd)/$(TOOLS_DIR)/binutils/elf32-arm.c.diff

binutils_configure: $(BINUTILS_DIR)
	(cd $(BINUTILS_DIR); \
	$(BINUTILS_DIR)/configure \
		--host=$(HOST) \
		--build=i686-linux-gnu \
		--target=${TARGET} \
		--prefix=${TARGET_DIR} \
		--enable-target-opt-space \
		$(TARGET_OPTS) \
		--disable-werror \
		--enable-multilib; );

binutils: binutils-install

binutils-install: binutils_configure 
	$(MAKE) -j 2 -C $(BINUTILS_DIR) all MAKEINFO=makeinfo
	$(MAKE) -C $(BINUTILS_DIR) install MAKEINFO=makeinfo

binutils-clean:
	$(MAKE) -C $(BINUTILS_DIR) clean

binutils-dirclean:
	rm -rf $(BINUTILS_DIR)
