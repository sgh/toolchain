#############################################################
#
# newlib
#
#############################################################

$(DL_DIR)/$(NEWLIB_SOURCE):
	$(WGET) --passive -P $(DL_DIR) $(NEWLIB_SITE)/$(NEWLIB_SOURCE)

$(NEWLIB_DIR): $(DL_DIR)/$(NEWLIB_SOURCE)
	$(NEWLIB_CAT) $(DL_DIR)/$(NEWLIB_SOURCE) | tar -C $(BUILD_DIR) -xf -
#	$(PATCH) -p0 -d $(NEWLIB_DIR) < $(shell pwd)/$(TOOLS_DIR)/newlib/binutils-2.20.patch


newlib_configure: $(NEWLIB_DIR)
	(cd $(NEWLIB_DIR); \
	CC_FOR_TARGET=${TARGET}-gcc \
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

newlib-install: newlib_configure
	( export PATH=$(TARGET_DIR)/bin:$$PATH ; CFLAGS="-DSTRING_ONLY -DMALLOC_PROVIDED" $(MAKE) -C $(NEWLIB_DIR) all )
	( export PATH=$(TARGET_DIR)/bin:$$PATH ; $(MAKE) -C $(NEWLIB_DIR) install )

newlib-clean:
	$(MAKE) -C $(NEWLIB_DIR) clean

newlib-dirclean:
	rm -rf $(NEWLIB_DIR)
