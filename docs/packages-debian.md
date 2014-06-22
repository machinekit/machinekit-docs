---
layout: docs
title: Debian packages
permalink: /docs/packages-debian/
---

Third-party packages for Debian Wheezy are available for amd64, i386
and ARM/Beaglebone.

## Quick start

Follow these steps to configure Apt and install Machinekit packages.

### Configure Apt

Copy and paste the following into a shell to configure the package archive:

    sudo sh -c \
        "echo 'deb http://deb.dovetail-automata.com wheezy main' > \
        /etc/apt/sources.list.d/machinekit.list"
    sudo apt-get update

### Install run-time packages

For those wanting just Machinekit binaries, the following should
install the main 'machinekit' package and the Xenomai Linux
kernel:

    sudo apt-get install machinekit-xenomai

List of RTOS choices:

    machinekit-xenomai
    machinekit-posix
    machinekit-rt-preempt

### Install development environment packages

For those wanting a development environment, run:

    sudo apt-get install libczmq-dev python-zmq libjansson-dev \
        libwebsockets-dev libxenomai-dev

This archive is currently unsigned. Apt will complain; simply answer
'y' to its warnings.

- **Beaglebone kernel note**

  While there is a Beaglebone kernel, it's easier to use that one
  shipped with the Machinekit Beaglebone images. It is nearly
  identical, and the packages in this archive currently require an
  extra step to boot from uBoot.

- **RTAI kernel**

  The machinekit repo builds and runs fine on RTAI. However, we currently
  do not have a sufficiently recent RTAI kernel available as a package here.

  In the interim there are some independently hosted 3.4.55-rtai-2
  kernel packages which run on Wheezy and against which MachineKit
  builds on x86 [http://deb.mgware.co.uk](http://deb.mgware.co.uk)
  
  Follow the instructions at that address.
  
  - *NB.* The packages are essentially the same ones as on Seb
    Kuzminsky's site,
    [http://highlab.com/~seb/linuxcnc/rtai-for-3.4-prerelease/]
    (http://highlab.com/~seb/linuxcnc/rtai-for-3.4-prerelease/) with a
    postinst script alteration to prevent some symlinks being
    clobbered which prevented MK building against them.


### Other things to do

- Browse the Debian archive directly at
  [http://deb.dovetail-automata.com/pool/](http://deb.dovetail-automata.com/pool/)

