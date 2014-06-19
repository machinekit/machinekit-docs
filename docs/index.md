---
layout: docs
title: Welcome
next_section: packages-debian
permalink: /docs/home/
---

This section aims to be a comprehensive guide to Machinekit. We’ll cover topics such
as downloading and installing pre-built images for computers like the Beaglebone Black or 
Linux computer, getting up and running with your machine tool, customizing your installation
for the hardware you have, and participating in the ongoing development of 
Machinekit.

## So what is Machinekit?

Machinekit is a community-driven project delivering open-source software and protocols used to create distributed systems which command and control moving things in real time. Examples of moving things already being explored are robots, quad-copters, 3D printers, and machine tools. Where community interest exists, complete applications may be created within the Machinekit project.

The roots of Machinekit lie in the venerable open-source LinuxCNC project which focuses on local control of machine tools. The goal of the Machinekit project is to enable applications beyond local machine control while improving usability and platform options even for existing uses of LinuxCNC. Machinekit draws on the lessons learned with LinuxCNC and on its existing software base and also feeds back to the LinuxCNC project.

Machinekit can be configured to run in realtime on recent Linux kernels with Xenomai, RTAI, or RT_Preempt threads, and also in non-real time with vanilla Posix threads for simulation and testing. Machinekit introduces a new middleware architecture and, drawing on other open-source projects, software for messaging among local and distributed, realtime and non-realtime components.

Instances of Machinekit technology are currently running on a variety of hardware platforms ranging from limited-resource ARM devices, to modestly resourced ARM-based SoC boards, handhelds, and tablets, to multi-CPU x86 systems.

## About this documentation

Motion control software is a complicated thing, made more complicated by the fact that every machine
is different, with its own personality and quirks. While we will try to cover the most common uses of Machinekit in this documentation, you are sure to encounter situations not covered. When that happens, reach out to the community, through the forums ((LINK!)) or the ((LINK!)) Contact page of this website.

If you come across anything along the way that we haven’t covered, or if you
know of a tip you think others would find handy, please [file an
issue]({{ site.repository }}/issues/new) and we’ll see about
including it in this guide.
