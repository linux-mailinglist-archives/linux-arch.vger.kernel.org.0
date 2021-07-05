Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0413BBAD1
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhGEKJx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 06:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhGEKJw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Jul 2021 06:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FFB3613D1;
        Mon,  5 Jul 2021 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625479636;
        bh=mDmSqc1ZHT5JQPxFFbw6bbExIYM08SRlNrojKMaW1NU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CrSJd3SJnIoFW2JNrjOqlCuTXPln9sRlTwpQWF2uP/gRGaLNCLThs2wtVkfLNtIgT
         gm2iArLVhPmhfe8rFuHRO4FkJydanGvdvu+ESFKXR949xOP6Z32V0Z8oi9QSsH4oY7
         Ly3vEYVKSCApSuP67Kl7LclmSbhVd+etbW/bAVJ33nbcKCJ4v5UDET9TQJGdE9j5J2
         0AmKX08yVZO/6zKmcHAVBagOkSbBPfCPQeXRDPd/hJWHNaLLehMb6Dc5OZhTlUleGS
         5OfaozSL/UVbgmF+cgufkrTZQGlWg20iQ+u4U0aLNI9y2tRNA/HqEIFVonbSxvsAPc
         dRROT+6QFn1OA==
Received: by mail-wr1-f47.google.com with SMTP id t15so18025008wry.11;
        Mon, 05 Jul 2021 03:07:16 -0700 (PDT)
X-Gm-Message-State: AOAM530BBMFfo+Z9PivdchcAArrgBo7jClTuIYRa1vHofxgdPzxrv4XK
        Vw0gdLmU77Utb/Rz99u+NEd16PQ24yY9VI71ung=
X-Google-Smtp-Source: ABdhPJyCa40n4qbdSBQQCcJYoIOkZncVk0WfewkiU841b5++uzOxojqVhIO++2Yq7kLIzSpJsQxK433dNXjd2d2xb9k=
X-Received: by 2002:adf:e107:: with SMTP id t7mr14857043wrz.165.1625479634719;
 Mon, 05 Jul 2021 03:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com> <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 5 Jul 2021 12:06:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
Message-ID: <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 3, 2021 at 2:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
> The version we got here makes it no longer crash the kernel, but
> I see your point that the runtime warning is still wrong. I'll have
> a look at what it would take to guard all inb/outb callers with a
> Kconfig conditional, and will report back after that.

I created a preliminary patch and got it to cleanly build on my randconfig box,
here is what that involved:

- added 89 Kconfig dependencies on HAS_IOPORT for PC-style devices
  that are not on a PCI card.
- added 188 Kconfig dependencies on LEGACY_PCI for PCI drivers that
  require port I/O. The idea is to have that control drivers for both pre-PCIe
  devices and and PCIe devices that require long-deprecated features like
  I/O resources, but possibly other features as well.
- The ACPI subsystem needs access to I/O ports, so that also gets a
  dependency.
- CONFIG_INDIRECT_PIO requires HAS_IOPORT
-  /dev/ioport needs an #ifdef around it
- several graphics drivers need workarounds instead of a 'depends on'
  because they are used in virtual machines: vgaconsole, bochs, qxl,
  cirrus. They work with or without port I/O
- A usb-uhci rework to split pci from non-pci support
- Minor workarounds for optional I/O port usage in libata, ipmi, tpm,
  dmi-firmware, altera-stapl, parport, vga
- lots of #ifdefs in 8250
- some drivers/pci/ quirks are #ifdef'd
- drivers using ioport_map()/pci_iomap() to access ports could be
  kept working when I/O ports are memory mapped

I tested the patch on a 5.13-rc4 snapshot that already has other
patches applied as a baseline for randconfig testing, so it doesn't
apply as-is.

Linus, if you like this approach, then I can work on splitting it up into
meaningful patches and submit it for a future release. I think the
CONFIG_LEGACY_PCI option has value on its own, but the others
do introduce some churn.

Full patch (120KB): https://pastebin.com/yaFSmAuY

diffstat:
 drivers/accessibility/speakup/Kconfig        |   1 +
 drivers/acpi/Kconfig                         |   1 +
 drivers/ata/Kconfig                          |  34 ++++++++++-----------
 drivers/ata/ata_generic.c                    |   3 +-
 drivers/ata/libata-sff.c                     |   2 ++
 drivers/bus/Kconfig                          |   2 +-
 drivers/char/Kconfig                         |   3 +-
 drivers/char/ipmi/Makefile                   |  11 +++----
 drivers/char/ipmi/ipmi_si_intf.c             |   3 +-
 drivers/char/ipmi/ipmi_si_pci.c              |   3 ++
 drivers/char/mem.c                           |   6 +++-
 drivers/char/tpm/Kconfig                     |   1 +
 drivers/char/tpm/tpm_infineon.c              |  14 ++++++---
 drivers/char/tpm/tpm_tis_core.c              |  19 +++++-------
 drivers/comedi/Kconfig                       |  53
+++++++++++++++++++++++++++++++++
 drivers/firmware/dmi-sysfs.c                 |   4 +++
 drivers/gpio/Kconfig                         |   2 +-
 drivers/gpu/drm/bochs/Kconfig                |   1 +
 drivers/gpu/drm/bochs/bochs_hw.c             |  24 ++++++++-------
 drivers/gpu/drm/qxl/Kconfig                  |   1 +
 drivers/gpu/drm/tiny/cirrus.c                |   2 ++
 drivers/hwmon/Kconfig                        |  23 +++++++++++++--
 drivers/i2c/busses/Kconfig                   |  31 ++++++++++---------
 drivers/ide/Kconfig                          |   1 +
 drivers/iio/adc/Kconfig                      |   2 +-
 drivers/input/gameport/Kconfig               |   6 ++--
 drivers/input/serio/Kconfig                  |   2 ++
 drivers/input/touchscreen/Kconfig            |   1 +
 drivers/isdn/hardware/mISDN/Kconfig          |  14 ++++-----
 drivers/leds/Kconfig                         |   2 +-
 drivers/media/cec/platform/Kconfig           |   2 +-
 drivers/media/pci/dm1105/Kconfig             |   2 +-
 drivers/media/radio/Kconfig                  |  15 +++++++++-
 drivers/media/rc/Kconfig                     |   9 +++++-
 drivers/message/fusion/Kconfig               |   8 ++---
 drivers/misc/altera-stapl/Makefile           |   3 +-
 drivers/misc/altera-stapl/altera.c           |   6 +++-
 drivers/net/Kconfig                          |   2 +-
 drivers/net/arcnet/Kconfig                   |   2 +-
 drivers/net/can/cc770/Kconfig                |   1 +
 drivers/net/can/sja1000/Kconfig              |   1 +
 drivers/net/ethernet/8390/Kconfig            |   2 +-
 drivers/net/ethernet/amd/Kconfig             |   2 +-
 drivers/net/ethernet/intel/Kconfig           |   4 +--
 drivers/net/ethernet/sis/Kconfig             |   6 ++--
 drivers/net/ethernet/ti/Kconfig              |   4 +--
 drivers/net/ethernet/via/Kconfig             |   5 ++--
 drivers/net/fddi/Kconfig                     |   4 +--
 drivers/net/hamradio/Kconfig                 |   6 ++--
 drivers/net/wan/Kconfig                      |   2 +-
 drivers/net/wireless/atmel/Kconfig           |   4 +--
 drivers/net/wireless/intersil/hostap/Kconfig |   4 +--
 drivers/parport/Kconfig                      |   2 +-
 drivers/pci/pci-sysfs.c                      |  16 ++++++++++
 drivers/pci/quirks.c                         |   2 ++
 drivers/pcmcia/Kconfig                       |   2 +-
 drivers/platform/chrome/Kconfig              |   1 +
 drivers/platform/chrome/wilco_ec/Kconfig     |   1 +
 drivers/pnp/isapnp/Kconfig                   |   2 +-
 drivers/power/reset/Kconfig                  |   1 +
 drivers/rtc/Kconfig                          |   4 ++-
 drivers/scsi/Kconfig                         |  21 ++++++-------
 drivers/scsi/aic7xxx/Kconfig.aic79xx         |   2 +-
 drivers/scsi/aic7xxx/Kconfig.aic7xxx         |   2 +-
 drivers/scsi/aic94xx/Kconfig                 |   2 +-
 drivers/scsi/megaraid/Kconfig.megaraid       |   2 +-
 drivers/scsi/mvsas/Kconfig                   |   2 +-
 drivers/scsi/qla2xxx/Kconfig                 |   2 +-
 drivers/spi/Kconfig                          |   1 +
 drivers/staging/kpc2000/Kconfig              |   2 +-
 drivers/staging/sm750fb/Kconfig              |   2 +-
 drivers/staging/vt6655/Kconfig               |   2 +-
 drivers/tty/Kconfig                          |   2 +-
 drivers/tty/serial/8250/8250_early.c         |   4 +++
 drivers/tty/serial/8250/8250_pci.c           |  19 ++++++++++--
 drivers/tty/serial/8250/8250_port.c          |  22 ++++++++++++--
 drivers/tty/serial/8250/Kconfig              |   1 +
 drivers/tty/serial/Kconfig                   |   2 +-
 drivers/usb/core/hcd-pci.c                   |   4 +--
 drivers/usb/host/Kconfig                     |   4 +--
 drivers/usb/host/pci-quirks.c                | 128
+++++++++++++++++++++++++++++++++++++++++--------------------------------------
 drivers/usb/host/pci-quirks.h                |  33 ++++++++++++++++-----
 drivers/usb/host/uhci-hcd.c                  |   2 +-
 drivers/usb/host/uhci-hcd.h                  |  77
+++++++++++++++++++++++++++++++----------------
 drivers/video/console/Kconfig                |   4 ++-
 drivers/video/fbdev/Kconfig                  |  24 +++++++--------
 drivers/watchdog/Kconfig                     |   6 ++--
 include/asm-generic/io.h                     |   6 ++++
 include/linux/gameport.h                     |   9 ++++--
 include/linux/parport.h                      |   2 +-
 include/video/vga.h                          |   8 +++++
 lib/Kconfig                                  |   4 +++
 lib/Kconfig.kgdb                             |   1 +
 sound/drivers/Kconfig                        |   3 ++
 sound/isa/Kconfig                            |   1 +
 sound/pci/Kconfig                            |  44 ++++++++++++++++++++++-----
 96 files changed, 575 insertions(+), 272 deletions(-)
