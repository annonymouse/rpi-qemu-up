#!/bin/sh

raspbian_zip=http://downloads.raspberrypi.org/raspbian/images/raspbian-2014-12-25/2014-12-24-wheezy-raspbian.zip
qemu_kernel=http://xecdesign.com/downloads/linux-qemu/kernel-qemu

wget $qemu_kernel

packer build raspbian.json
