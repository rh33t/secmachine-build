#!/bin/bash
IF="tun0"
if [[ $(ip addr | grep $IF) == '' ]]; then echo ""; else ip addr show dev $IF | grep "inet\b" | awk '{print $2}'| cut -d/ -f1; fi
