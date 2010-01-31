#############################################################
#
# gdb 
#
#############################################################

$(DL_DIR)/$(GDB_SOURCE):
	$(WGET) --passive -P $(DL_DIR) $(GDB_SITE)/$(GDB_SOURCE)

$(GDB_DIR): $(DL_DIR)/$(GDB_SOURCE)
	$(GDB_CAT) $(DL_DIR)/$(GDB_SOURCE) | tar -C $(BUILD_DIR) -xf -

$(GDB_DIR)_build: $(GDB_DIR)
	(mkdir -p $(GDB_DIR)_build; cd $(GDB_DIR)_build; \
	$(GDB_DIR)/configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--enable-target-opt-space \
			--disable-werror \
			$(TARGET_OPTS) \
			--enable-multilib; );

gdb: gdb-install

gdb-install: $(GDB_DIR)_build
	PATH=$(TARGET_DIR)/bin:$$PATH $(MAKE) -j 2 -C $(GDB_DIR)_build all 
	PATH=$(TARGET_DIR)/bin:$$PATH $(MAKE) -C $(GDB_DIR)_build install

gdb-clean:
	$(MAKE) -C $(GDB_DIR) clean

gdb-dirclean:
	rm -rf $(GDB_DIR)
