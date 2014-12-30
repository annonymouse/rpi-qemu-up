#!/bin/sh
set -e

raspbian_zip=http://downloads.raspberrypi.org/raspbian/images/raspbian-2014-12-25/2014-12-24-wheezy-raspbian.zip
qemu_kernel=http://xecdesign.com/downloads/linux-qemu/kernel-qemu

mkdir -p resources
wget $qemu_kernel -O resources/qemu-kernel
wget $raspbian_zip -O resources/raspbian.zip
pushd resources
unzip raspbian.zip
qemu-img convert -f raw -O qcow2 *.img raspbian.qcow2
popd

packer build raspbian.json
