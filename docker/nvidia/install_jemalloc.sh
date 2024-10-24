#!/bin/bash
JEMALLOC_VERSION="5.3.0"

wget https://github.com/jemalloc/jemalloc/releases/download/${JEMALLOC_VERSION}/jemalloc-${JEMALLOC_VERSION}.tar.bz2
tar -jxvf jemalloc-${JEMALLOC_VERSION}.tar.bz2
cd jemalloc-${JEMALLOC_VERSION}
apt install -y autogen autoconf
./autogen.sh
make -j2
make install
ldconfig
cd ..
rm -rf jemalloc-${JEMALLOC_VERSION} jemalloc-${JEMALLOC_VERSION}.tar.bz2
echo "jemalloc ${JEMALLOC_VERSION} installed successfully"