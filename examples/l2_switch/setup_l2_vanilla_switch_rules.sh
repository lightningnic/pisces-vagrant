#!/usr/bin/env bash

export RTE_SDK=/home/vagrant/ovs/deps/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
export DPDK_DIR=$RTE_SDK
export DPDK_BUILD=$DPDK_DIR/$RTE_TARGET/

cd /vagrant/examples/l2_switch/
sudo ./l2_vanilla_switch.sh
