---
layout: docs
title: Building From Source
next_section: contributing
permalink: /docs/building-from-source/
---

## Prologue

Installing machinekit from packages is the quickest route to success but for
any number of reasons you might want or need to build machinekit from source.

Debian Linux is our recommended work environment; the following instructions have
been tested on Debian Wheezy i386 and amd64 installations. They likely will
work with little alteration on recent Debian-based distributions such as
Ubuntu 14.04LTS and Linux Mint 17 but please, let's address the nuances of
working in distributions other than Debian or releases other than Wheezy on
supplemental pages so this page can remain focused on its primary goal of
getting you to a working machinekit environment.

These instructions presume you have a basic proficiency working in the Linux
bash shell from the command line in a terminal, know the difference between an
ordinary user and the root user and can switch between them, know what a Debian
package is and can use apt-related tools, and so forth. Only minimal attention
is paid here to Linux subtleties such as prompts you may receive from a
command you invoke, such as a request for you to enter a password or to answer
respond yes (Y/y) or no (N/n). The answer, by the way, is almost always yes.
As the saying goes, "Google is your friend," and so are the Man pages on your
system.

It is strongly recommended you perform these steps as an ordinary user and
not the root user. This requires that the ```sudo``` command be present and
also that you have sudo privileges. If you like living life in the fastlane,
you can perform them all as the root user, omitting the ```sudo``` prefix
where it occurs. We are not responsible for the result.

The ```sudo``` command may or may not be present on your Debian system
depending on the specific flavor of desktop environment you installed, if any.
If ```sudo``` is not present (simple test: try to invoke it) then you need to
perform an additional step:

    su -c "apt-get install sudo"

To give yourself all sudo privileges (which is overkill, by the way):

    su -c "adduser <your username> sudo"

where the entire string \<your username> should be replaced by your username.

Log out of the system, then log in again as the chosen user to
pick up the new privileges.


## Quick summary for the impatient

From a standing start on a fresh, updated install of Debian Wheezy with sudo
privileges set as described above, the following steps should result in a
working machinekit, including the
LinuxCNC application, built in Xenomai (realtime) and Posix (non-realtime)
flavors. It will have been built in the subdirectory
```machinekit``` with a so-called run-in-place (rip) version of LinuxCNC.
Once this process is finished, you will also have on hand all the basic tools
needed to track the github repository and do further development of machinekit.
Note that a considerable number of packages may be downloaded from the Internet
and there will be lots of compiling in this process. There will be opportunities to
get up and get a cup of coffee, check your email, maybe even walk the dog.

### First, perform the following steps
(also described in the companion page
   [Debian packages](../packages-debian))

    sudo sh -c \
        "echo 'deb http://deb.dovetail-automata.com wheezy main' >
        /etc/apt/sources.list.d/machinekit.list"
    sudo apt-get update
    sudo apt-get install dovetail-automata-keyring
    sudo apt-get update

    sudo apt-get install libczmq-dev python-zmq libjansson-dev \
        libwebsockets-dev libxenomai-dev

    sudo sh -c \
        "echo 'deb http://ftp.us.debian.org/debian wheezy-backports main' > \
         /etc/apt/sources.list.d/wheezy-backports.list"
    sudo apt-get update
    sudo apt-get install -t wheezy-backports cython

### Then proceed to the main event

    sudo apt-get install git devscripts
    git clone https://github.com/machinekit/machinekit.git
    cd machinekit
    debian/configure -px
    sudo mk-build-deps -i
    cd src
    ./autogen.sh
    ./configure
    make
    sudo make setuid

Voilà, you're done. Check your work by executing the just-built
LinuxCNC application,

    cd ..
    . scripts/rip-environment
    linuxcnc

### Additional runtime packages you may need

At this point you should be able to select and run most of the LinuxCNC user
interfaces. However, GladeVCP, Gmoccapy, and possibly some other
functionality will fail at runtime because they depend on certain
packages which are not installed during the build process described above.

You can install these additional packages to ensure the runtime environment is
the same as it would be had you installed machinekit directly from packages:

    sudo apt-get install \
         libgnomeprintui2.2 \
         python-configobj \
         python-glade2 \
         python-gst0.10 \
         python-gtkglext1 \
         python-gtksourceview2 \
         python-imaging-tk \
         python-vte \
         python-xlib \
         tcl-tclreadline

You can check your work by executing the LinuxCNC application and selecting,
e.g., a Gmoccapy configuration.

### Adding rip-environment script to .bashrc
To enable the use of Machinekit from every terminal without running the rip-environment script explicitly we can add it to the .bashrc using the following command:

    sh -c "echo -e 'if [ -f ~/machinekit/scripts/rip-environment ]; then\n\
        source ~/machinekit/scripts/rip-environment\n\
        echo \"Environment set up for running Machinekit and LinuxCNC\"\n\
    fi\n' >> ~/.bashrc"

## The details we didn't talk about

[material is forthcoming on the options which are available in this process,
for example to build for multiple realtime environments, to install machinekit
on the system, etc.]
