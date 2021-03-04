Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C282E32DC89
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbhCDVrx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:47:53 -0500
Received: from marcansoft.com ([212.63.210.85]:36200 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240113AbhCDVrj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Mar 2021 16:47:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 143BC3FA1B;
        Thu,  4 Mar 2021 21:39:19 +0000 (UTC)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v3 00/27] Apple M1 SoC platform bring-up
Date:   Fri,  5 Mar 2021 06:38:35 +0900
Message-Id: <20210304213902.83903-1-marcan@marcan.st>
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

See below for an overview of changes since v2.

== Merge notes ==

This patchset depends on both the nVHE changes that are already in
5.12-rc1, as well as the FIQ support work currently being reviewed
at [1]. A tree containing this patchset on top of the required
dependencies is available at [2][3]. Alternatively, you may apply
this series on top of Mark's tree at the arm64-fiq-20210302 tag [4][5].

This series is expected to be merged by Arnd via the SoC tree.
Maintainers, please ack if you are happy with the patches. We will
coordinate with Arnd and Mark on the FIQ series to make sure all
that goes smoothly.

This is marked RFT as it needs some basic testing on other on other
ARM platforms; in particular the Samsung UART driver changes need to be
tested, and the ioremap()/timer changes could use at least a smoke test
on some other arm64 platform. I would appreciate any test reports.

[1] https://lore.kernel.org/linux-arm-kernel/20210302101211.2328-1-mark.rutland@arm.com/T/#t
[2] git://github.com/AsahiLinux/linux.git upstream-bringup-v3
[3] https://github.com/AsahiLinux/linux/tree/upstream-bringup-v3
[4] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64-fiq-20210302
[5] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/tag/?h=arm64-fiq-20210302

== Testing notes ==

This has been tested on an Apple M1 Mac Mini booting to a framebuffer
and serial console, with SMP and (newly tested since v2) KASLR, with
an arm64 defconfig (+ CONFIG_FB_SIMPLE for the fb).

An arm32 build has been smoke-tested in qemu with the smdkc210 machine,
to test the samsung_tty changes on non-Apple (emulated) hardware.

== Patch overview ==

- 01    Cope with CPUs stuck in VHE mode
        This is a follow-up to the recent nVHE/cpufeature changes in
        mainline by Mark, adding a workaround for the M1's lack of
        nVHE mode.
- 02-03 Core platform DT bindings
- 04-05 CPU DT bindings and MIDR defines
- 06-07 Add interrupt-names support to the ARM timer driver
        This is used to cleanly express the lack of a secure timer;
        platforms in the past have used various hacks like dummy
        IRQs here.
- 08-12 ioremap_np() (nGnRnE) support
        The fabric in these SoCs only supports nGnRnE accesses for
        standard MMIO, except for PCI ranges which use nGnRE. Linux
        currently defaults to the latter on ARM64, so this adds a new
        ioremap type and DT properties to automatically select it for
        drivers using OF and devm abstractions, under buses specified
        in DT.
- 13-16 AIC (Apple Interrupt Controller) driver and support defines
        This also embeds FIQ handling for this platform.
- 17    Introduce CONFIG_ARCH_APPLE & add it to defconfig
- 18-25 Add Apple SoC support to the samsung_tty driver
        This includes several refactoring patches to be able to more
        cleanly introduce this, as well as a switch to
        devm_ioremap_resource to be able to use the nGnRnE support
        introduced above. Earlycon support is included with a
        special-case nGnRnE hack, as earlycon is too early to use the
        generic infrastructure.
- 26    simple-framebuffer bindings for Apple (trivial)
- 27    Add the initial M1 Mac Mini (j274) devicetree

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

== Changes since v2 ==

* Removed FIQ support patches, as this is now being handled as a
  separate series.
* Added nVHE workaround patch from Marc
* Renamed dts(i) files to better match conventions used in other
  platforms
* Renamed 'm1' in compatible/dts names to 't8103', to be better
  prepared for the chance of multiple SoCs being released under the
  same marketing name.
* Reworded device tree binding text for the platform.
* Changed the default ioremap_np() implementation to return NULL,
  like ioremap_uc().
* Added general documentation for ioremap() variants, including the
  newly introduced one.
* Reworked virtual IPI support in the AIC driver, and attempted
  to thoroughly shave the memory ordering yak.
* Moved GIC registers to sysregs.h instead of including that in the AIC
  driver.
* Added _EL1 suffixes to Apple sysregs.
* Addressed further review comments and feedback.


Arnd Bergmann (1):
  docs: driver-api: device-io: Document I/O access functions

Hector Martin (25):
  dt-bindings: vendor-prefixes: Add apple prefix
  dt-bindings: arm: apple: Add bindings for Apple ARM platforms
  dt-bindings: arm: cpus: Add apple,firestorm & icestorm compatibles
  arm64: cputype: Add CPU implementor & types for the Apple M1 cores
  dt-bindings: timer: arm,arch_timer: Add interrupt-names support
  arm64: arch_timer: implement support for interrupt-names
  asm-generic/io.h:  Add a non-posted variant of ioremap()
  docs: driver-api: device-io: Document ioremap() variants & access
    funcs
  arm64: Implement ioremap_np() to map MMIO as nGnRnE
  of/address: Add infrastructure to declare MMIO as non-posted
  arm64: Add Apple vendor-specific system registers
  arm64: move ICH_ sysreg bits from arm-gic-v3.h to sysreg.h
  dt-bindings: interrupt-controller: Add DT bindings for apple-aic
  irqchip/apple-aic: Add support for the Apple Interrupt Controller
  arm64: Kconfig: Introduce CONFIG_ARCH_APPLE
  tty: serial: samsung_tty: Separate S3C64XX ops structure
  tty: serial: samsung_tty: Add ucon_mask parameter
  tty: serial: samsung_tty: Add s3c24xx_port_type
  tty: serial: samsung_tty: IRQ rework
  tty: serial: samsung_tty: Use devm_ioremap_resource
  dt-bindings: serial: samsung: Add apple,s5l-uart compatible
  tty: serial: samsung_tty: Add support for Apple UARTs
  tty: serial: samsung_tty: Add earlycon support for Apple UARTs
  dt-bindings: display: Add apple,simple-framebuffer
  arm64: apple: Add initial Apple Mac mini (M1, 2020) devicetree

Marc Zyngier (1):
  arm64: Cope with CPUs stuck in VHE mode

 .../devicetree/bindings/arm/apple.yaml        |  64 ++
 .../devicetree/bindings/arm/cpus.yaml         |   2 +
 .../bindings/display/simple-framebuffer.yaml  |   5 +
 .../interrupt-controller/apple,aic.yaml       |  88 +++
 .../bindings/serial/samsung_uart.yaml         |   4 +-
 .../bindings/timer/arm,arch_timer.yaml        |  14 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/driver-api/device-io.rst        | 356 +++++++++
 .../driver-api/driver-model/devres.rst        |   1 +
 MAINTAINERS                                   |  15 +
 arch/arm64/Kconfig.platforms                  |   8 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/apple/Makefile            |   2 +
 arch/arm64/boot/dts/apple/t8103-j274.dts      |  45 ++
 arch/arm64/boot/dts/apple/t8103.dtsi          | 135 ++++
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/include/asm/cputype.h              |   6 +
 arch/arm64/include/asm/io.h                   |   1 +
 arch/arm64/include/asm/sysreg.h               |  60 ++
 arch/arm64/include/asm/sysreg_apple.h         |  69 ++
 arch/arm64/kernel/head.S                      |  33 +-
 arch/arm64/kernel/hyp-stub.S                  |  28 +-
 arch/sparc/include/asm/io_64.h                |   4 +
 drivers/clocksource/arm_arch_timer.c          |  24 +-
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-apple-aic.c               | 710 ++++++++++++++++++
 drivers/of/address.c                          |  72 +-
 drivers/tty/serial/Kconfig                    |   2 +-
 drivers/tty/serial/samsung_tty.c              | 496 +++++++++---
 include/asm-generic/io.h                      |  22 +-
 include/asm-generic/iomap.h                   |   9 +
 include/clocksource/arm_arch_timer.h          |   1 +
 .../interrupt-controller/apple-aic.h          |  15 +
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/io.h                            |   2 +
 include/linux/ioport.h                        |   1 +
 include/linux/irqchip/arm-gic-v3.h            |  56 --
 include/linux/of_address.h                    |   1 +
 include/linux/serial_s3c.h                    |  16 +
 lib/devres.c                                  |  22 +
 41 files changed, 2228 insertions(+), 175 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/apple.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 create mode 100644 arch/arm64/boot/dts/apple/Makefile
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j274.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103.dtsi
 create mode 100644 arch/arm64/include/asm/sysreg_apple.h
 create mode 100644 drivers/irqchip/irq-apple-aic.c
 create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h

--
2.30.0

