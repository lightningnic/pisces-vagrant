#! /bin/sh -ve

# Please make sure that you update the path to the current OVS directory.
DIR=~/ovs/utilities

$DIR/ovs-ofctl --protocols=OpenFlow15 del-flows br0

# SMAC Table 0
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=0,priority=32768,dl_src=08:00:27:15:b4:11 actions=resubmit(,1)"
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=0,priority=32768,dl_src=08:00:27:7e:0b:95 actions=resubmit(,1)"
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=0,priority=0                              actions=controller"

# DMAC Table 1
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=1,priority=32768,dl_dst=08:00:27:15:b4:11 actions=set_field:1->reg0,resubmit(,2)"
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=1,priority=32768,dl_dst=08:00:27:7e:0b:95 actions=set_field:2->reg0,resubmit(,2)"
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=1,priority=0                              actions=flood"

# SRC Pruning Table 2
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=2,priority=32768,in_port=1,reg0=1 actions="
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=2,priority=32768,in_port=2,reg0=2 actions="
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=2,priority=32768,in_port=3,reg0=3 actions="
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=2,priority=32768,in_port=4,reg0=4 actions="
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=2,priority=32768,in_port=5,reg0=5 actions="
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=2,priority=32768,in_port=6,reg0=6 actions="
$DIR/ovs-ofctl --protocols=OpenFlow15 add-flow br0 "table=2,priority=0                              actions=output:NXM_NX_REG0[]"
