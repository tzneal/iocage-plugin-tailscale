#!/bin/sh

# remove all of this once quarterly is tailscale 1.19+
pkg install -y git-lite go
git clone https://github.com/tailscale/tailscale.git
cd tailscale/cmd/tailscale
go build
cp tailscale /usr/local/bin
cd ../tailscaled
go build
cp tailscaled /usr/local/bin

sysrc -f /etc/rc.conf tailscaled_enable="YES"
service tailscaled start
