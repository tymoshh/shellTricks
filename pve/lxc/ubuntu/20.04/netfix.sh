#!/bin/bash
cat <<EOF | tee /etc/netplan/10-lxc.yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
EOF
systemctl enable systemd-networkd --now
systemctl disable cloud-init
cloud-init clean
netplan apply
