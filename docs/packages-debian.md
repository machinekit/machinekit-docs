---
layout: docs
title: Debian packages
next_section: community
permalink: /docs/packages-debian/
---

Third-party packages for Debian Wheezy are available for amd64, i386
and ARM/Beaglebone. 

## Quick start

Decide which type of realtime kernel you want: for x86 and amd64,
your options are RT-PREEMPT, Xenomai, or RTAI. For ARM/Beaglebone and
ARM/Raspberry Pi, Xenomai is the only supported realtime kernel.

The RT-PREEMPT realtime kernel comes from the stock wheezy package
stream. Xenomai is a custom kernel with lower latency;
both are fine for applications with hardware step generation or plain
servo configs. RTAI is justifiable only for high-rate software step
generation, at the expense of signficantly higher maintainence
(RT-PREEMPT and Xenomai installs have no significant kernel
dependencies; RTAI installations only run with the kernel the package
was built for).

Follow these steps to configure Apt and install a kernel and Machinekit packages:

### Configure Apt for i386, amd64 and arm7 (Beaglebone) 

Copy and paste the following into a shell to configure the package archive:

    sudo sh -c \
        "echo 'deb http://deb.dovetail-automata.com wheezy main' > \
		/etc/apt/sources.list.d/machinekit.list; \
		apt-get update ; \
		apt-get install dovetail-automata-keyring"

### Configure Apt for armv6 (Raspberry) 

Copy and paste the following into a shell to configure the package
archive:

    sudo sh -c \
      "apt-key adv --keyserver hkp://keys.gnupg.net --recv-key 49550439; \
      echo 'deb http://0ptr.link/raspbian wheezy main' > \
      /etc/apt/sources.list.d/rpi-machinekit.list"
    sudo apt-get update

### Install an RT-PREEMPT realtime kernel (x86 and amd64)

	sudo apt-get install linux-image-rt-686-pae   # x86
	sudo apt-get install linux-image-rt-amd64     # amd64

### Install a Xenomai realtime kernel (all platforms)

	sudo apt-get install linux-image-xenomai

### Install an RTAI realtime kernel (x86 and amd64)

	sudo apt-get install linux-image-rtai
	

### Install run-time packages 

For those wanting just Machinekit binaries, the following should
install the main 'machinekit' package for your kernel choice (multiple
kernels and flavors possible):

    sudo apt-get install machinekit-rt-preempt
    sudo apt-get install machinekit-xenomai
    sudo apt-get install machinekit-rtai-kernel
    sudo apt-get install machinekit-posix # non-RT (aka 'simulator mode')


### Post-installation hints

- when using Xenomai, you need to log out and log in again after package installation (assuming the Xenomai kernel was already running)
- Beaglebone users: please see [Alex's installation hints](https://github.com/strahlex/asciidoc-sandbox/wiki/Creating-a-Machinekit-Debian-Image)

### Install development environment packages

For those wanting a development environment, run:

    sudo apt-get install libczmq-dev python-zmq libjansson-dev \
        libwebsockets-dev libxenomai-dev

Further more, add wheezy-backports in the package archive for cython 0.19:

    sudo sh -c \
        "echo 'deb http://ftp.us.debian.org/debian wheezy-backports main' > \
         /etc/apt/sources.list.d/wheezy-backports.list"
    sudo apt-get update
    sudo apt-get install -t wheezy-backports cython


### Other things to do

- Browse the Debian archive directly at
  [http://deb.dovetail-automata.com/pool/](http://deb.dovetail-automata.com/pool/)
