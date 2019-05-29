#!/usr/bin/env bash

export RTE_SDK=/home/vagrant/ovs/deps/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
export DPDK_DIR=$RTE_SDK
export DPDK_BUILD=$DPDK_DIR/$RTE_TARGET/

cd ~/ovs/vswitchd
sudo gdbserver :12345 ./ovs-vswitchd --dpdk -c 0x1 -n 4 -- unix:/usr/local/var/run/openvswitch/db.sock --pidfile

