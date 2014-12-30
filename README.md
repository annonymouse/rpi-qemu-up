Raspberry Pi QEMU UP 
============================
Helps build you a QEMU image that boots a RaspberryPi emulation.  This mostly
follows the instructions from

http://xecdesign.com/qemu-emulating-raspberry-pi-the-easy-way/

but I got sick of typing it every time.

Why not packer.io?
==================

Can we packer this?  The QEMU builder in packer could do the job, but I couldn't
figure out a way to hook into the packer process, and it's not really for this
-- it wants to build vbox images really.  Also I didn't want to learn Go just
yet.  I have the beginnings of something in this repo -- but networking and vnc
is all messed up as the qemu builder seems to want to vnc into this machine, and
I start getting SDL problems at least on OSX.

I needed to put so much scripting around this to give packer something it
expected that I felt it was just easier to write my own scripts.

Usage
=====

To initially grab a new(ish) raspbian image, run

    ./raspbianemu fetch

then to provision a system

    ./raspbianemu build

and finally to use it

    ./raspbianemu up

Installing QEMU on OSX
======================

    brew install qemu --with-sdl --with-vde

The blogs seem to complain a lot about needing to compile with GCC, and problems
with enabling arm 1176 support -- these are all fixed in the latest QEMU
versions available in homebrew.

Details on using QEMU with the RPi Images
=========================================

Resize the image file to match your SD card image.  Diskutil should tell you the
size.

(note it simplifies sizes to harddisk manufacturer measuers of GB i.e. 1GB ==
1000000000 bytes)

From there you can use qemu-resize to resize the disk image on disk so you can
resize in qemu later.

    $ diskutil info /dev/disk2
    $ qemu-img resize noobs.img <size in bytes>

    $ qemu-system-arm -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw init=/bin/bash" -kernel kernel-qemu -hda noobs.img 

We run into problems with the default mapping of the disk for QEMU not being
/dev/mmcblk01.  So that needs to be setup by init'ing into bash

    $ qemu-system-arm -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -kernel kernel-qemu -hda 2014-01-07-wheezy-raspbian.img

From here you can just use the image.  However, the raspi-config knows that your
disk image isn't an sd card, and thus can't arbitrarily resize it - -You'll need
to do this manually from within debian. TODO make this work in make-raspbian.

Links
=====

http://www.royvanrijn.com/blog/2014/06/raspberry-pi-emulation-on-os-x/

https://github.com/psema4/pine/wiki/Installing-QEMU-on-OS-X

http://xecdesign.com/qemu-emulating-raspberry-pi-the-easy-way/

http://xecdesign.com/compiling-qemu/

https://www.bentasker.co.uk/documentation/linux/267-testing-raspberry-pi-images-with-qemu

http://www.raspberrypi.org/forums/viewtopic.php?f=31&t=44080

