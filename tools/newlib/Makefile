#############################################################
#
# newlib
#
#############################################################

$(DL_DIR)/$(NEWLIB_SOURCE):
	$(NEWLIB) -P $(DL_DIR) $(NEWLIB_SITE)/$(NEWLIB_SOURCE)

$(NEWLIB_DIR)/.unpacked: $(DL_DIR)/$(NEWLIB_SOURCE)
	$(NEWLIB_CAT) $(DL_DIR)/$(NEWLIB_SOURCE) | tar -C $(BUILD_DIR) -xf -
	touch $(NEWLIB_DIR)/.unpacked

$(NEWLIB_DIR)/.configured: $(NEWLIB_DIR)/.unpacked $(NEWLIB_DIR)/.unpacked
	(cd $(NEWLIB_DIR); \
	./configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--enable-target-opt-space \
			--enable-multilib; \
	touch .configured );

$(NEWLIB_DIR)/.installed: $(NEWLIB_DIR)/.configured
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(NEWLIB_DIR) all install
	touch $(NEWLIB_DIR)/.installed

newlib: $(NEWLIB_DIR)/.installed

newlib-install:
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(NEWLIB_DIR) install

newlib-clean:
	$(MAKE) -C $(NEWLIB_DIR) clean

newlib-dirclean:
	rm -rf $(NEWLIB_DIR)
