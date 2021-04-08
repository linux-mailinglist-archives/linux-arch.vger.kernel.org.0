Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B349C3588F9
	for <lists+linux-arch@lfdr.de>; Thu,  8 Apr 2021 17:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhDHPzv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 11:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhDHPzv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 11:55:51 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ECDC061760;
        Thu,  8 Apr 2021 08:55:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1C00841E64;
        Thu,  8 Apr 2021 15:55:30 +0000 (UTC)
To:     soc@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
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
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple M1 SoC platform bring-up for 5.13
Message-ID: <bdb18e9f-fcd7-1e31-2224-19c0e5090706@marcan.st>
Date:   Fri, 9 Apr 2021 00:55:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd and all,

Here's the final version of the M1 SoC bring-up series, based on
v4 which was reviewed here:

https://lore.kernel.org/linux-arm-kernel/20210402090542.131194-1-marcan@marcan.st/T/#u

Changes since v4 as reviewed:

* Sort DT soc bus nodes by address (NFC)
* Introduce defines to better represent the meaning of hwirq IDs in
   the AIC driver (NFC)
* Update stale comments in AIC (NFC)
* Make of_mmio_is_nonposted static and not exported (export change only)
* Rewrite pci_remap_cfgspace() more succintly using ?: operator (NFC)
* Update FIQ series merge to arm64/for-next/fiq
* Remove the nVHE series (we will let this go through amd64 on its own)

The public key that signed the tag is available here:

https://mrcn.st/pub

Or pull e22a629a4c515dd5 from keys.gnupg.net or pgp.mit.edu.

Cheers,
Hector

The following changes since commit 847bea3d08af9158ae9e17b43632d6aa4f1702a0:

   Merge remote-tracking branch 'arm64/for-next/fiq' (2021-04-08 19:21:57 +0900)

are available in the Git repository at:

   https://github.com/AsahiLinux/linux.git tags/m1-soc-bringup-v5

for you to fetch changes up to 7d2d16ccf15d8eb84accfaf44a0b324f36e39588:

   arm64: apple: Add initial Apple Mac mini (M1, 2020) devicetree (2021-04-08 20:18:41 +0900)

----------------------------------------------------------------
Apple M1 SoC platform bring-up

This series brings up initial support for the Apple M1 SoC, used in the
2020 Mac Mini, MacBook Pro, and MacBook Air models.

The following features are supported in this initial port:

- UART (samsung-style) with earlycon support
- Interrupts, including affinity and IPIs (Apple Interrupt Controller)
- SMP (through standard spin-table support)
- simplefb-based framebuffer
- Devicetree for the Mac Mini (should work for the others too at this
   stage)

== Merge notes ==

This tag is based on v5.12-rc3 and includes the following two
dependencies merged in:

* Tip of arm64/for-next/fiq: 3889ba70102e
   This is a hard (build) dependency that adds support for FIQ
   interrupts, which is required for this SoC and the included AIC
   irqchip driver. It is already merged in the arm64 tree.

* From tty/tty-next: 71b25f4df984
   This commit includes the Samsung UART changes that have already
   been merged into the tty tree. It is nominally a soft dependency,
   but if this series is merged first it would trigger devicetree
   validation failures as the DT included in it depends on bindings
   introduced in the tty tree.

   There was a merge conflict here. It has been resolved the same
   way gregkh resolved it in a later tty merge, and both tty-next
   and torvalds/master merge cleanly with this series at this time.

This series additionally depends on the nVHE changes in [1] to boot,
but we are letting those get merged through arm64.

[1] https://lore.kernel.org/linux-arm-kernel/20210408131010.1109027-1-maz@kernel.org/T/#u

== Testing notes ==

This has been tested on an Apple M1 Mac Mini booting to a framebuffer
and serial console, with SMP and KASLR, with an arm64 defconfig
(+ CONFIG_FB_SIMPLE for the fb). In addition, the AIC driver now
supports running in EL1, tested in UP mode only.

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

Signed-off-by: Hector Martin <marcan@marcan.st>

----------------------------------------------------------------
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
       docs: driver-api: device-io: Document ioremap() variants & access funcs
       arm64: Implement ioremap_np() to map MMIO as nGnRnE
       asm-generic/io.h: implement pci_remap_cfgspace using ioremap_np
       of/address: Add infrastructure to declare MMIO as non-posted
       arm64: Move ICH_ sysreg bits from arm-gic-v3.h to sysreg.h
       dt-bindings: interrupt-controller: Add DT bindings for apple-aic
       irqchip/apple-aic: Add support for the Apple Interrupt Controller
       arm64: Kconfig: Introduce CONFIG_ARCH_APPLE
       dt-bindings: display: Add apple,simple-framebuffer
       arm64: apple: Add initial Apple Mac mini (M1, 2020) devicetree

  Documentation/devicetree/bindings/arm/apple.yaml   |  64 ++
  Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +
  .../bindings/display/simple-framebuffer.yaml       |   5 +
  .../bindings/interrupt-controller/apple,aic.yaml   |  88 +++
  .../devicetree/bindings/timer/arm,arch_timer.yaml  |  19 +
  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
  Documentation/driver-api/device-io.rst             | 356 +++++++++
  Documentation/driver-api/driver-model/devres.rst   |   1 +
  MAINTAINERS                                        |  14 +
  arch/arm64/Kconfig.platforms                       |   7 +
  arch/arm64/boot/dts/Makefile                       |   1 +
  arch/arm64/boot/dts/apple/Makefile                 |   2 +
  arch/arm64/boot/dts/apple/t8103-j274.dts           |  45 ++
  arch/arm64/boot/dts/apple/t8103.dtsi               | 135 ++++
  arch/arm64/configs/defconfig                       |   1 +
  arch/arm64/include/asm/cputype.h                   |   6 +
  arch/arm64/include/asm/io.h                        |  11 +-
  arch/arm64/include/asm/sysreg.h                    |  60 ++
  arch/sparc/include/asm/io_64.h                     |   4 +
  drivers/clocksource/arm_arch_timer.c               |  24 +-
  drivers/irqchip/Kconfig                            |   8 +
  drivers/irqchip/Makefile                           |   1 +
  drivers/irqchip/irq-apple-aic.c                    | 852 +++++++++++++++++++++
  drivers/of/address.c                               |  43 +-
  include/asm-generic/io.h                           |  22 +-
  include/asm-generic/iomap.h                        |   9 +
  include/clocksource/arm_arch_timer.h               |   1 +
  .../dt-bindings/interrupt-controller/apple-aic.h   |  15 +
  include/linux/cpuhotplug.h                         |   1 +
  include/linux/io.h                                 |  18 +-
  include/linux/ioport.h                             |   1 +
  include/linux/irqchip/arm-gic-v3.h                 |  56 --
  lib/devres.c                                       |  22 +
  33 files changed, 1816 insertions(+), 80 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/arm/apple.yaml
  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
  create mode 100644 arch/arm64/boot/dts/apple/Makefile
  create mode 100644 arch/arm64/boot/dts/apple/t8103-j274.dts
  create mode 100644 arch/arm64/boot/dts/apple/t8103.dtsi
  create mode 100644 drivers/irqchip/irq-apple-aic.c
  create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h
