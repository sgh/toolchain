#############################################################
#
# newlib
#
#############################################################

$(DL_DIR)/$(NEWLIB_SOURCE):
	$(WGET) --passive -P $(DL_DIR) $(NEWLIB_SITE)/$(NEWLIB_SOURCE)

$(NEWLIB_DIR): $(DL_DIR)/$(NEWLIB_SOURCE)
	$(NEWLIB_CAT) $(DL_DIR)/$(NEWLIB_SOURCE) | tar -C $(BUILD_DIR) -xf -

$(NEWLIB_DIR)_build: $(NEWLIB_DIR)
	(mkdir -p $(NEWLIB_DIR)_build; cd $(NEWLIB_DIR)_build; \
	$(NEWLIB_DIR)/configure --target=${TARGET} \
			--host=$(HOST) \
			--build=i686-linux-gnu \
			--prefix=${TARGET_DIR} \
			--disable-newlib-supplied-syscalls \
			--disable-newlib-mb \
			--disable-newlib-atexit-alloc \
			$(TARGET_OPTS) \
			--enable-multilib; );


newlib: gcc newlib-install

newlib-install: $(NEWLIB_DIR)_build
	PATH=$$PATH:$(TARGET_DIR)/bin CFLAGS=-DSTRING_ONLY $(MAKE) -C $(NEWLIB_DIR)_build all
	$(MAKE) -C $(NEWLIB_DIR)_build install

newlib-clean:
	$(MAKE) -C $(NEWLIB_DIR) clean

newlib-dirclean:
	rm -rf $(NEWLIB_DIR)
