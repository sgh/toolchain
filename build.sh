
TARGET=h8300-hms

PREFIX="/home/sgh/${TARGET}-tools"

COMMONFLAGS="-target=${TARGET} --prefix=${PREFIX} --enable-target-opt-space --enable-multilib"

mkdir -p ${TARGET}
cd ${TARGET}

## Binutils
mkdir -p binutils
cd binutils
../../src/binutils-2.15/configure ${COMMONFLAGS}
make all install
cd ..

## GCC
mkdir -p gcc
cd gcc
../../src/gcc-3.4.3/configure ${COMMONFLAGS} --enable-languages="c,c++"  --with-headers=../../src/newlib-1.12.0/newlib/libc/include
make all-gcc install-gcc
cd ..

## Newlib
mkdir -p newlib
cd newlib
../../src/newlib-1.12.0/configure ${COMMONFLAGS}
make all install
cd ..


cd ..
