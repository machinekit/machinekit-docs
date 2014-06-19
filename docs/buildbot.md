---
layout: docs
title: Buildbot
prev_section: maintainers
next_section: C4
permalink: /docs/buildbot/
---

A [Buildbot instance][1] is contributed by Dovetail Automata LLC for
continuous integration and testing and for package building.

## Overview

The Buildbot tests source builds and builds packages for several
GNU/Linux distributions, including Debian and Red Hat derivatives, and
for i386, x86_64 and ARM (Beaglebone) architectures.  It also runs
unit tests on applicable thread systems (Xenomai, Xenomai kernel,
RT_PREEMPT and POSIX) for each distro and architecture.

## Continuous integration

The [C4 process][2] requires that contributed patches must compile
cleanly on the project's target platforms.  Manually building and
testing Machinekit is perhaps more difficult than other projects
because of architecture-, kernel- and distribution-dependent
requirements of the various combinations of hardware, real-time OSs
and distros it has been ported to.  Requiring manual builds of even a
subset of these combinations would impose a great burden on
[Maintainers][3].  The Buildbot eases the burden by automating
building and testing the comprehensive set of distro/arch/thread
combinations.

For each distribution and architecture, the Buildbot automates an
'RIP' universal build of all applicable thread systems.  Additionally,
documentation is separately built once for each distribution.  These
builds are done in an appropriate chroot environment on a Buildbot
slave 'builder' VM with 8 CPUs in order to get initial build results
as quickly as possible.  If this build fails, subsequent tests and
package builds for the same distro/arch are not attempted.

Once the RIP build completes successfully for a particular distro/arch
combination, the build result is copied to two single-CPU 'test'
slaves (VMs, or a single physical machine in the case of the
Beaglebone) running the matching distro with one CPU.  One test slave
runs a Xenomai kernel, and unit tests against the `xenomai` and
`xenomai-kernel` thread flavors are run sequentially.  The other test
slave runs an RT_PREEMPT kernel, and unit tests against the
`rt-preempt` and `posix` thread flavors are run sequentially.

A tarball of the build results and of the `tests/` directory for each
build and test run are available on the [Buildbot web `results`
directory][4].  Developers may find their build results in the
subdirectory named by the short SHA commit.

## Pull Request package builds

In addition to unit tests, pull request package builds are also
scheduled once a distro/arch RIP build completes successfully.

Package builds are executed in a chroot environment on the 'builder'
slave, just as the preceding RIP build.  The package and chroot are
set up to build packages for all applicable RT thread flavors.

For Debian, resulting packages are placed into an intermediate Apt
archive with the other build results in the [Buildbot web `results`
directory][4] (see above).

## `master` branch Debian package builds

When a pull request is merged into the `master` branch, the Buildbot
starts a special package-only build.  (The same code has already
passed tests, and tests need not be repeated.)

When the build succeeds, the resulting packages are automatically
pulled into the Dovetail Automata [Debian Apt package archive][5],
where they become updates to that package stream.


[1]: http://buildbot.dovetail-automata.com/grid
[2]: /docs/C4/
[3]: /docs/maintainers/
[4]: http://buildbot.dovetail-automata.com/results/
[5]: /docs/packages-debian/