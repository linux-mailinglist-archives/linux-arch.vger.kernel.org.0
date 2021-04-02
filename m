Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EBB3527D6
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhDBJGA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:06:00 -0400
Received: from marcansoft.com ([212.63.210.85]:34044 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBJF7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 05:05:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 21EE142720;
        Fri,  2 Apr 2021 09:05:50 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/18] Apple M1 SoC platform bring-up
Date:   Fri,  2 Apr 2021 18:05:24 +0900
Message-Id: <20210402090542.131194-1-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series brings up initial support for the Apple M1 SoC, used in the
2020 Mac Mini, MacBook Pro, and MacBook Air models.

The following features are supported in this initial port:

- UART (samsung-style) with earlycon support
- Interrupts, including affinity and IPIs (Apple Interrupt Controller)
- SMP (through standard spin-table support)
- simplefb-based framebuffer
- Devicetree for the Mac Mini (should work for the others too at this
  stage)

See below for an overview of changes since v3.

== Merge notes ==

This patchset has several dependencies:

* Build dep on the FIQ support series in [1].
* Runtime dep on the Samsung TTY changes in tty-next (modulo DT validation).
* Runtime dep on the nVHE changes being reviewed in [2].

A tree containing this patchset on top of the required dependencies is
available at [3][4], for those who want to test it.

This series is expected to be merged by Arnd via the SoC tree.
Maintainers, please ack if you are happy with the patches. We will
coordinate with Arnd and Mark on the FIQ series to make sure all
that goes smoothly.

[1] https://lore.kernel.org/linux-arm-kernel/20210315115629.57191-1-mark.rutland@arm.com/T/
[2] https://lore.kernel.org/linux-arm-kernel/20210330173947.999859-1-maz@kernel.org/T/
[3] git://github.com/AsahiLinux/linux.git upstream-bringup-v4
[4] https://github.com/AsahiLinux/linux/tree/upstream-bringup-v4

== Testing notes ==

This has been tested on an Apple M1 Mac Mini booting to a framebuffer
and serial console, with SMP and KASLR, with an arm64 defconfig
(+ CONFIG_FB_SIMPLE for the fb). In addition, the AIC driver now supports
running in EL1, tested in UP mode only.

== Patch overview ==

- 01-02 Core platform DT bindings
- 03-04 CPU DT bindings and MIDR defines
- 05-06 Add interrupt-names support to the ARM timer driver
        This is used to cleanly express the lack of a secure timer;
        platforms in the past have used various hacks like dummy
        IRQs here.
- 07-12 ioremap_np() (nGnRnE) support
        The fabric in these SoCs only supports nGnRnE accesses for
        standard MMIO, except for PCI ranges which use nGnRE. Linux
        currently defaults to the latter on ARM64, so this adds a new
        ioremap type and DT properties to automatically select it for
        drivers using OF and devm abstractions, under buses specified
        in DT.
- 13-15 AIC (Apple Interrupt Controller) driver and support defines
        This also embeds FIQ handling for this platform.
- 16    Introduce CONFIG_ARCH_APPLE & add it to defconfig
- 17    simple-framebuffer bindings for Apple (trivial)
- 18    Add the initial M1 Mac Mini (j274) devicetree

== About the hardware ==

These machines officially support booting unsigned/user-provided
XNU-like kernels, with a very different boot protocol and devicetree
format. We are developing an initial bootloader, m1n1 [1], to take care
of as many hardware peculiarities as possible and present a standard
Linux arm64 boot protocol and device tree. In the future, I expect that
production setups will add U-Boot and perhaps GRUB into the boot chain,
to make the boot process similar to other ARM64 platforms.

The machines expose their debug UART over USB Type C, triggered with
vendor-specific USB-PD commands. Currently, the easiest way to get a
serial console on these machines is to use a second M1 box and a simple
USB C cable [2]. You can also build a DIY interface using an Arduino, a
FUSB302 chip or board, and a 1.2V UART-TTL adapter [3]. In the coming
weeks we will be designing an open hardware project to provide
serial/debug connectivity to these machines (and, hopefully, also
support other UART-over-Type C setups from other vendors). Please
contact me privately if you are interested in getting an early prototype
version of one of these devices.

We also have WIP/not merged yet support for loading kernels and
interacting via dwc3 usb-gadget, which works with a standard C-C or C-A
cable and any Linux host.

A quickstart guide to booting Linux kernels on these machines is
available at [4], and we are documenting the hardware at [5].

[1] https://github.com/AsahiLinux/m1n1/
[2] https://github.com/AsahiLinux/macvdmtool/
[3] https://github.com/AsahiLinux/vdmtool/
[4] https://github.com/AsahiLinux/docs/wiki/Developer-Quickstart
[5] https://github.com/AsahiLinux/docs/wiki

== Project Blurb ==

Asahi Linux is an open community project dedicated to developing and
maintaining mainline support for Apple Silicon on Linux. Feel free to
drop by #asahi and #asahi-dev on freenode to chat with us, or check
our website for more information on the project:

https://asahilinux.org/

== Changes since v3 ==

* Serial patches have already been merged into tty-next and are
  no longer included
* nVHE fixup patches are being reviewed separately and no longer
  part of this series
* Updated arm,arch-timer bindings to be more restrictive, renamed
  phys-secure to sec-phys
* Reordered ioremap() variants list in device-io.rst
* Removed sysreg_apple.h (defines are in drivers now)
* Many cleanups, bug fixes, and reworks to AIC, including some bug
  fixes from Marc's KVM series, kernel as EL1 support, and more.
* Simplified non-posted MMIO DT handling to only apply to direct
  children of a bus, and only use "nonposted-mmio". Removed quirk
  optimization.
* Implemented default pci_remap_cfgspace() in terms of ioremap_np()
  and removed arch-specific pci_remap_cfgspace override for arm64
  (arm32 can come later)
* Replaced license in AIC bindings header with GPL-2.0+ OR MIT
* Other minor typo/style fixes

Arnd Bergmann (1):
  docs: driver-api: device-io: Document I/O access functions

Hector Martin (17):
  dt-bindings: vendor-prefixes: Add apple prefix
  dt-bindings: arm: apple: Add bindings for Apple ARM platforms
  dt-bindings: arm: cpus: Add apple,firestorm & icestorm compatibles
  arm64: cputype: Add CPU implementor & types for the Apple M1 cores
  dt-bindings: timer: arm,arch_timer: Add interrupt-names support
  arm64: arch_timer: Implement support for interrupt-names
  asm-generic/io.h:  Add a non-posted variant of ioremap()
  docs: driver-api: device-io: Document ioremap() variants & access
    funcs
  arm64: Implement ioremap_np() to map MMIO as nGnRnE
  asm-generic/io.h: implement pci_remap_cfgspace using ioremap_np
  of/address: Add infrastructure to declare MMIO as non-posted
  arm64: Move ICH_ sysreg bits from arm-gic-v3.h to sysreg.h
  dt-bindings: interrupt-controller: Add DT bindings for apple-aic
  irqchip/apple-aic: Add support for the Apple Interrupt Controller
  arm64: Kconfig: Introduce CONFIG_ARCH_APPLE
  dt-bindings: display: Add apple,simple-framebuffer
  arm64: apple: Add initial Apple Mac mini (M1, 2020) devicetree

 .../devicetree/bindings/arm/apple.yaml        |  64 ++
 .../devicetree/bindings/arm/cpus.yaml         |   2 +
 .../bindings/display/simple-framebuffer.yaml  |   5 +
 .../interrupt-controller/apple,aic.yaml       |  88 ++
 .../bindings/timer/arm,arch_timer.yaml        |  19 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/driver-api/device-io.rst        | 356 ++++++++
 .../driver-api/driver-model/devres.rst        |   1 +
 MAINTAINERS                                   |  14 +
 arch/arm64/Kconfig.platforms                  |   7 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/apple/Makefile            |   2 +
 arch/arm64/boot/dts/apple/t8103-j274.dts      |  45 +
 arch/arm64/boot/dts/apple/t8103.dtsi          | 135 +++
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/include/asm/cputype.h              |   6 +
 arch/arm64/include/asm/io.h                   |  11 +-
 arch/arm64/include/asm/sysreg.h               |  60 ++
 arch/sparc/include/asm/io_64.h                |   4 +
 drivers/clocksource/arm_arch_timer.c          |  24 +-
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-apple-aic.c               | 837 ++++++++++++++++++
 drivers/of/address.c                          |  43 +-
 include/asm-generic/io.h                      |  22 +-
 include/asm-generic/iomap.h                   |   9 +
 include/clocksource/arm_arch_timer.h          |   1 +
 .../interrupt-controller/apple-aic.h          |  15 +
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/io.h                            |  23 +-
 include/linux/ioport.h                        |   1 +
 include/linux/irqchip/arm-gic-v3.h            |  56 --
 include/linux/of_address.h                    |   1 +
 lib/devres.c                                  |  22 +
 34 files changed, 1807 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/apple.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 create mode 100644 arch/arm64/boot/dts/apple/Makefile
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j274.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103.dtsi
 create mode 100644 drivers/irqchip/irq-apple-aic.c
 create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h

--
2.30.0

