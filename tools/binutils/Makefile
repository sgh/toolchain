#############################################################
#
# binutils 
#
#############################################################

$(DL_DIR)/$(BINUTILS_SOURCE):
	$(BINUTILS) -P $(DL_DIR) $(BINUTILS_SITE)/$(BINUTILS_SOURCE)

$(BINUTILS_DIR)/.unpacked: $(DL_DIR)/$(BINUTILS_SOURCE)
	$(BINUTILS_CAT) $(DL_DIR)/$(BINUTILS_SOURCE) | tar -C $(BUILD_DIR) -xf -
	touch $(BINUTILS_DIR)/.unpacked

$(BINUTILS_DIR)/.configured: $(BINUTILS_DIR)/.unpacked
	(cd $(BINUTILS_DIR); \
	./configure --target=${TARGET} --prefix=${TARGET_DIR} --enable-target-opt-space --enable-multilib; \
	touch .configured );

$(BINUTILS_DIR)/.installed: $(BINUTILS_DIR)/.configured
	$(MAKE) -C $(BINUTILS_DIR) all install
	touch $(BINUTILS_DIR)/.installed

binutils: $(BINUTILS_DIR)/.installed

binutils-clean:
	rm -f $(TARGET_DIR)/$(BINUTILS_TARGET_BINARY)
	-$(MAKE) -C $(BINUTILS_DIR) clean

binutils-dirclean:
	rm -rf $(BINUTILS_DIR)
