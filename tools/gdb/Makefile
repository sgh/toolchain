#############################################################
#
# gdb 
#
#############################################################

$(DL_DIR)/$(GDB_SOURCE):
	$(WGET) --passive -P $(DL_DIR) $(GDB_SITE)/$(GDB_SOURCE)

$(GDB_DIR)/.unpacked: $(DL_DIR)/$(GDB_SOURCE)
	$(GDB_CAT) $(DL_DIR)/$(GDB_SOURCE) | tar -C $(BUILD_DIR) -xf -
	touch $(GDB_DIR)/.unpacked

$(GDB_DIR)/.configured: $(GDB_DIR)/.unpacked
	(cd $(GDB_DIR); \
	./configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--enable-target-opt-space \
			$(TARGET_OPTS) \
			--enable-multilib; \
	touch .configured );

gdb: gdb-install

gdb-install: $(GDB_DIR)/.configured
	PATH=$$PATH:$(TARGET_DIR)/bin $(MAKE) -C $(GDB_DIR) all install

gdb-clean:
	$(MAKE) -C $(GDB_DIR) clean

gdb-dirclean:
	rm -rf $(GDB_DIR)
