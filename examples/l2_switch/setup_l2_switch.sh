#!/usr/bin/env bash

export RTE_SDK=/home/vagrant/ovs/deps/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
export DPDK_DIR=$RTE_SDK
export DPDK_BUILD=$DPDK_DIR/$RTE_TARGET/

cd ~/ovs
sudo ./configure --with-dpdk=$DPDK_BUILD CFLAGS="-g -O2 -Wno-cast-align" \
                   p4inputfile=/vagrant/examples/l2_switch/l2_switch.p4 \
                   p4outputdir=./include/p4/src
sudo make clean
sudo make -j 2
