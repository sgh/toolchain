#############################################################
#
# binutils 
#
#############################################################

$(DL_DIR)/$(BINUTILS_SOURCE):
	$(WGET) -P $(DL_DIR) $(BINUTILS_SITE)/$(BINUTILS_SOURCE)

$(BINUTILS_DIR)/.unpacked: $(DL_DIR)/$(BINUTILS_SOURCE)
	$(BINUTILS_CAT) $(DL_DIR)/$(BINUTILS_SOURCE) | tar -C $(BUILD_DIR) -xf -
	touch $(BINUTILS_DIR)/.unpacked

$(BINUTILS_DIR)/.compiled: binutils-configure
	$(MAKE) -C $(BINUTILS_DIR) all 

$(BINUTILS_DIR)/.configured: binutils-unpack
	(cd $(BINUTILS_DIR); \
	./configure --target=${TARGET} --prefix=${TARGET_DIR} --enable-target-opt-space --enable-multilib; \
	touch .configured );

$(BINUTILS_DIR)/.compiled: binutils-configure

$(BINUTILS_DIR)/.installed: binutils-compile
	$(MAKE) -C $(BINUTILS_DIR) all 


binutils: binutils-install

binutils-unpack: $(BINUTILS_DIR)/.unpacked
binutils-configure: $(BINUTILS_DIR)/.configured
binutils-compile: $(BINUTILS_DIR)/.compiled
binutils-install: $(BINUTILS_DIR)/.installed


binutils-clean:
	$(MAKE) -C $(BINUTILS_DIR) clean

binutils-dirclean:
	rm -rf $(BINUTILS_DIR)
