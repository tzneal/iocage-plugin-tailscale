#!/bin/sh

# <-- remove all of this once the standard tailscale package version is >= 1.19 -->
GIT_HASH=eeccbccd08626fd968f849a86eac9d39ebd94f12
pkg install -y git-lite go
git clone https://github.com/tailscale/tailscale.git
git checkout "$(GIT_HASH)"
cd tailscale/cmd/tailscale
go build
cp tailscale /usr/local/bin
cd ../tailscaled
go build
cp tailscaled /usr/local/bin
# <-- remove the above -->

# trigger tailscale's TrueNAS detection
touch /usr/local/bin/freenas-debug

sysrc -f /etc/rc.conf tailscaled_enable="YES"
service tailscaled start
