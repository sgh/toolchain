#############################################################
#
# gcc
#
#############################################################
GCC_VER:=snapshot
GCC_SOURCE:=gcc-$(GCC_VER).tar.bz2
#GCC_SITE:=ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VER)/
GCC_SITE:=http://localhost/~sgh
GCC_DIR:=$(BUILD_DIR)/gcc-$(GCC_VER)
GCC_CAT:=bzcat
