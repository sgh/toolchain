#############################################################
#
# binutils 
#
#############################################################

$(DL_DIR)/$(BINUTILS_SOURCE):
	$(WGET) -P $(DL_DIR) $(BINUTILS_SITE)/$(BINUTILS_SOURCE)

$(BINUTILS_DIR): $(DL_DIR)/$(BINUTILS_SOURCE)
	$(BINUTILS_CAT) $(DL_DIR)/$(BINUTILS_SOURCE) | tar -C $(BUILD_DIR) -xf -

$(BINUTILS_DIR)/.configured: $(BINUTILS_DIR)
	(cd $(BINUTILS_DIR); \
	./configure --target=${TARGET} --prefix=${TARGET_DIR} --enable-target-opt-space --enable-multilib; \
	touch .configured );
	$(MAKE) -C $(BINUTILS_DIR) 

binutils: $(BINUTILS_DIR)/.configured

binutils-clean:
	$(MAKE) -C $(BINUTILS_DIR) clean

binutils-dirclean:
	rm -rf $(BINUTILS_DIR)
