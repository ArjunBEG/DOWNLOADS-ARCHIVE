#!/bin/bash

# 2017-06 (paulirish): updated for latest sources
# and incorporated fixes from my comments here: https://gist.github.com/xiaom/8264691#gistcomment-1648455

# 2015-ish (zmil): this script does absolutely ZERO error checking.   however, it worked
# for me on a RHEL 6.3 machine on 2012-08-08.  clearly, the version numbers
# and/or URLs should be made variables.  cheers,  zmil...@cs.wisc.edu

set -x

mkdir mosh
cd mosh

ROOT=`pwd`

echo "==================================="
echo "about to set up everything in $ROOT"
echo "==================================="

mkdir build

cd build
curl -L -O https://github.com/google/protobuf/releases/download/v3.3.0/protobuf-cpp-3.3.0.tar.gz
curl -L -O https://mosh.org/mosh-1.3.0.tar.gz
tar zxvf protobuf-cpp-3.3.0.tar.gz
tar zxvf mosh-1.3.0.tar.gz

echo "================="
echo "building protobuf"
echo "================="

cd $ROOT/build/protobuf-3.3.0
export CXXFLAGS="$CXXFLAGS -fPIC"
./configure --prefix=$HOME/local --disable-shared
make install


echo "============="
echo "building mosh"
echo "============="

cd $ROOT/build/mosh-1.3.0
export PROTOC=$HOME/local/bin/protoc
export protobuf_CFLAGS=-I$HOME/local/include

# if you run into errors, you can change this from .a to .so
export protobuf_LIBS=$HOME/local/lib/libprotobuf.a  

./configure --prefix=$HOME/local
make install

echo "==="
echo "if all was successful, binaries are now in $HOME/local/bin"
echo "==="

echo "to use this install, use the --server flag:"
echo "    mosh --server=$HOME/local/bin/mosh-server loginuser@host"
echo "==="

