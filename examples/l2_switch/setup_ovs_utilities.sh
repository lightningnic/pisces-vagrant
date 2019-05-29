#!/usr/bin/env bash

export RTE_SDK=/home/vagrant/ovs/deps/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
export DPDK_DIR=$RTE_SDK
export DPDK_BUILD=$DPDK_DIR/$RTE_TARGET/

cd ~/ovs/utilities
sudo ./ovs-vsctl --no-wait init
sudo ./ovs-vsctl add-br br0 -- set bridge br0 datapath_type=netdev
sudo ./ovs-vsctl set bridge br0 protocols=OpenFlow15
sudo ./ovs-vsctl add-port br0 dpdk0 -- set Interface dpdk0 type=dpdk
sudo ./ovs-vsctl add-port br0 dpdk1 -- set Interface dpdk1 type=dpdk

