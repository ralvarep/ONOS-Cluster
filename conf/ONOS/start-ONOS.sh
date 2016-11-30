#!/bin/bash

# Load bashrc
PS1='$ ' . ~/.bashrc

cd ~/onos-*;
pkill -f java
sleep 3
bin/onos-service server 1>/tmp/stdout.log 2>/tmp/stderr.log &
