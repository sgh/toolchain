#############################################################
#
# newlib
#
#############################################################

$(DL_DIR)/$(NEWLIB_SOURCE):
	$(WGET) --passive -P $(DL_DIR) $(NEWLIB_SITE)/$(NEWLIB_SOURCE)

$(NEWLIB_DIR): $(DL_DIR)/$(NEWLIB_SOURCE)
	$(NEWLIB_CAT) $(DL_DIR)/$(NEWLIB_SOURCE) | tar -C $(BUILD_DIR) -xf -
	touch $(NEWLIB_DIR)
	$(PATCH) -p1 -d $(NEWLIB_DIR) < $(shell pwd)/$(TOOLS_DIR)/newlib/0001-2014-01-07-Jeff-Johnston-jjohnstn-redhat.com.patch
	$(PATCH) -p1 -d $(NEWLIB_DIR) < $(shell pwd)/$(TOOLS_DIR)/newlib/0002-2014-01-10-Jeff-Johnston-jjohnstn-redhat.com.patch


newlib_configure: $(NEWLIB_DIR)
	(cd $(NEWLIB_DIR); \
	CC_FOR_TARGET=${TARGET}-gcc \
	$(NEWLIB_DIR)/configure --target=${TARGET} \
			--prefix=${TARGET_DIR} \
			--disable-newlib-supplied-syscalls \
			--disable-newlib-mb \
			--disable-newlib-atexit-alloc \
			$(TARGET_OPTS) \
			--enable-multilib; );


newlib: gcc newlib-install

newlib_compile:
	( export PATH=$(TARGET_DIR)/bin:$$PATH ; CFLAGS="-DSTRING_ONLY -DMALLOC_PROVIDED" $(MAKE) -j ${HOST_CPUS} -C $(NEWLIB_DIR) )

newlib-install: newlib_configure newlib_compile
	( export PATH=$(TARGET_DIR)/bin:$$PATH ; $(MAKE) -C $(NEWLIB_DIR) install )

newlib-clean:
	$(MAKE) -C $(NEWLIB_DIR) clean

newlib-dirclean:
	rm -rf $(NEWLIB_DIR)
