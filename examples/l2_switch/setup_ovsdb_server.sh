#!/usr/bin/env bash

export RTE_SDK=/home/vagrant/ovs/deps/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
export DPDK_DIR=$RTE_SDK
export DPDK_BUILD=$DPDK_DIR/$RTE_TARGET/

cd ~/ovs/ovsdb
sudo ./ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
                      --remote=db:Open_vSwitch,Open_vSwitch,manager_options --pidfile

