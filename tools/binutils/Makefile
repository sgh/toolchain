#############################################################
#
# binutils 
#
#############################################################

$(DL_DIR)/$(BINUTILS_SOURCE):
	$(WGET) -P $(DL_DIR) $(BINUTILS_SITE)/$(BINUTILS_SOURCE)

$(BINUTILS_DIR): $(DL_DIR)/$(BINUTILS_SOURCE)
	$(BINUTILS_CAT) $(DL_DIR)/$(BINUTILS_SOURCE) | tar -C $(BUILD_DIR) -xf -
	mkdir -p $(BINUTILS_DIR)_build

$(BINUTILS_DIR)_build: $(BINUTILS_DIR)
	(cd $(BINUTILS_DIR)_build; \
	$(BINUTILS_DIR)/configure \
		--host=$(HOST) \
		--build=i686-linux-gnu \
		--target=${TARGET} \
		--prefix=${TARGET_DIR} \
		--enable-target-opt-space \
		$(TARGET_OPTS) \
		--enable-multilib; );

binutils: binutils-install

binutils-install: $(BINUTILS_DIR)_build
	$(MAKE) -C $(BINUTILS_DIR)_build all install MAKEINFO=makeinfo

binutils-clean:
	$(MAKE) -C $(BINUTILS_DIR)_build clean

binutils-dirclean:
	rm -rf $(BINUTILS_DIR)
	rm -rf $(BINUTILS_DIR)_build
