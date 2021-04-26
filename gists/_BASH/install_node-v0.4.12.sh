#!/bin/sh

apt-get -y update

apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++

mkdir /tmp/node-install
cd /tmp/node-install
wget http://nodejs.org/dist/node-v0.4.12.tar.gz
tar -zxf node-v0.4.12.tar.gz

cd node-v0.4.12
./configure && make && make install
