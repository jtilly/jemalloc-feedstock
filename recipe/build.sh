#!/bin/bash

set -e
set -x

# Static TLS has caused users to experience some errors of the form
# "libjemalloc.so.2: cannot allocate memory in static TLS block"
#
# We disable this feature until we better understand how to avoid loader errors
# of this type
if [[ ${target_platform} =~ linux.* ]]; then
  ./configure --prefix=$PREFIX \
              --disable-tls \
              --with-mangling=aligned_alloc:__aligned_alloc
else
  ./configure --prefix=$PREFIX \
              --disable-tls
fi
make -j${CPU_COUNT}
make install
