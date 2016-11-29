#!/bin/bash

echo "Starting Open vSwitch..."
service openvswitch-switch start

echo "Checking Open vSwitch status..."
while true; do
      if [ -S /var/run/openvswitch/db.sock ]; then
         break
      fi
      sleep 2
done

echo "Configuring Open vSwitch..."
ovs-vsctl add-br s3
ovs-vsctl add-port s3 eth1
ovs-vsctl add-port s3 eth2
ovs-vsctl set bridge s3 other-config:hwaddr=00:00:00:00:00:03
ovs-vsctl set bridge s3 protocols=OpenFlow13
ovs-vsctl set-controller s3 tcp:10.10.0.1:6633
ovs-vsctl set-fail-mode s3 secure
