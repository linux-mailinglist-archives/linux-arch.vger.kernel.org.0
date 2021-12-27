Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D743480247
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhL0Qq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:46:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231394AbhL0Qo4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGfnHM012039;
        Mon, 27 Dec 2021 16:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=4KpaggvRiK2h8tNiJG6+axMUof4YkxvhC21os7lYx3g=;
 b=oXVDp4fbLdU2ShuarvWSEiAnXO8UHIF9nk45YZ1w/oMSiNe9yFOto7S2SEtn2Pe7NqeI
 1o9NeAwQKX9xTsVHuYpWqT3hXPDiInZnmoMcELvzUuQo8UtB5fmao7I7b3bNA0lWGVz1
 oGg3gUTbzEYXpdtzroauxyOT/UXyZODhLKoY6hc7BjqOGRYGcaNduPoN4D6WJx2zRy4Y
 4+pU3FZLTQilaUCJh/9BKnYoC6Y4md/t6nLI3e1fRxdboDsYDpaDu8u201WIq5GITSU6
 BAFC0+TuFHjG1LX5sENTPG46KSAfSLye5Hd4tUYVxVTY9hK6Z8BusxchB14Bw3wfc8SU OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ug0rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:23 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGg7lt012959;
        Mon, 27 Dec 2021 16:43:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ug0qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGgkpH003026;
        Mon, 27 Dec 2021 16:43:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3d5tx9bf34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhIno43450874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13155A405B;
        Mon, 27 Dec 2021 16:43:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93528A4054;
        Mon, 27 Dec 2021 16:43:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:17 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: [RFC 00/32] Kconfig: Introduce HAS_IOPORT and LEGACY_PCI options
Date:   Mon, 27 Dec 2021 17:42:45 +0100
Message-Id: <20211227164317.4146918-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _KZvmyQo14uIoH6Ur9P840lSkJoECuO2
X-Proofpoint-ORIG-GUID: TOkcRkEPEkI_6CIAFvKexnKZBFc_6RCk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112270080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Kernel Hackers,

Some platforms such as s390 do not support legacy PCI devices nor PCI I/O
spaces. On such platforms I/O space accessors like inb()/outb() are merely
stubs that can never actually work. The way these stubs are implemented in
asm-generic/io.h leads to compiler warnings because any use will
essentially lead to a NULL pointer access. In a previous patch we tried
handling this case by generating a run-time warning on access. This
approach however was rejected by Linus in tha mail below with the argument
that this really should be a compile-time check and, though a much more
invasive change, we believe that is indeed the right approach.

https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

This patch series aims to do exactly that by introducing a HAS_IOPORT
config option akin to the existing HAS_IOMEM. When this is unset
inb()/outb() and friends may not be defined. Now since I/O port access is
not only used in legacy PCI devices or with legacy I/O spaces for backwards
compatible PCI Express devices, but also for  example in ACPI we also
introduce another config option LEGACY_PCI to specifically disable the
compilation of drivers for legacy PCI devices and legacy I/O space uses
while keeping I/O port accessors for non-legacy uses. This allows modern
systems which do not need legacy PCI support to skip building drivers for
legacy devices while keeping e.g.  ACPI support.

This series builts heavily on an original patch for demonstating the
concept by Arnd Bergmann and was created in collaboration with him as
discussed in the follow up to his original patch here:

https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com/

It rebases his patch on v5.16-rc7, adds the missing arch selects for
HAS_IOPORT, fixes a few trivial findings from the original patch discussion
and splits the patch into more manageable patches. One other thing that
came up during the discussion is the idea of adding a separate
HARDCODED_IOPORTS config option for drivers which use hardcoded I/O port
numbers, this is not currently implemented but could still be added if we
find enough drivers that should not be compiled on platforms where
HAS_IOPORT is set but these hardcoded I/O ports will not work. According to
the above discussion John Garry is looking into this but I wanted to get
the discussion going on this proposal.

The series is split up into multiple patches as follows:

- Patch 01: Adds the LEGACY_PCI config and selects it for all remaining
  drivers for legacy PCI devices.

- Patch 02: Adds the HAS_IOPORT config option and selects it for those
  architectures supporting the I/O space access. It is currently not
  selected for s390, nds32, um, h8300, nios2, openrisc, hexagon, csky, and
  xtensa

- Patches 03-26: Add HAS_IOPORT dependencies on a per subsystem basis.
  These dependencies are either Kconfig "depends on" or ifdefs where I/O
  port access is an alternative path or required e.g. for a sysfs file.

- Patches 27-31: Handle HAS_IOPORT dependencies for some special cases such
  as sysfs files, PCI quirks and in USB code.

- Patch 32: Removes the inb()/outb() etc. definitions in asm-generic/io.h
  when HAS_IOPORT is not selected e.g. on s390.

I performed the following testing:

- On s390 this series on top of v5.16-rc7 builds with allyesconfig i.e. the
  HAS_IOPORT=n case. It also builds with defconfig and the resulting kernel
  appears fully functional including tests with PCI devices.

- On x86_64 with a config based on Arch Linux' standard config and
  LEGACY_PCI=n it builds and I've been running kernels with this
  configuration for over a week without issue on my Ryzen 3990X based
  workstation (initially based on v5.16-rc6). I also tested LEGACY_PCI=y
  though I do not have any legacy PCI devices, I did confirm though that
  the additional modules are built as expected.

- For ARM64 I cross-compiled based on the current Arch Linux ARM generic
  kernel config and LEGACY_PCI=n and have been running a v5.16-rc6 based
  version of this patch on my Raspberry Pi 4 (DT not UEFI) and checked that
  the PCI based USB still works.

For easy consumption a branch on top of v5.16-rc7 is also available from my
Github here https://github.com/niklas88/linux/tree/has_ioport_rfc_v1

Thanks,
Niklas Schnelle

Niklas Schnelle (32):
  Kconfig: introduce and depend on LEGACY_PCI
  Kconfig: introduce HAS_IOPORT option and select it as necessary
  ACPI: Kconfig: add HAS_IOPORT dependencies
  parport: PC style parport depends on HAS_IOPORT
  char: impi, tpm: depend on HAS_IOPORT
  speakup: Kconfig: add HAS_IOPORT dependencies
  Input: gameport: add ISA and HAS_IOPORT dependencies
  comedi: Kconfig: add HAS_IOPORT dependencies
  sound: Kconfig: add HAS_IOPORT dependencies
  i2c: Kconfig: add HAS_IOPORT dependencies
  Input: Kconfig: add HAS_IOPORT dependencies
  iio: adc: Kconfig: add HAS_IOPORT dependencies
  hwmon: Kconfig: add HAS_IOPORT dependencies
  leds: Kconfig: add HAS_IOPORT dependencies
  media: Kconfig: add HAS_IOPORT dependencies
  misc: handle HAS_IOPORT dependencies
  net: Kconfig: add HAS_IOPORT dependencies
  pcmcia: Kconfig: add HAS_IOPORT dependencies
  platform: Kconfig: add HAS_IOPORT dependencies
  pnp: Kconfig: add HAS_IOPORT dependencies
  power: Kconfig: add HAS_IOPORT dependencies
  video: handle HAS_IOPORT dependencies
  rtc: Kconfig: add HAS_IOPORT dependencies
  scsi: Kconfig: add HAS_IOPORT dependencies
  watchdog: Kconfig: add HAS_IOPORT dependencies
  drm: handle HAS_IOPORT dependencies
  PCI/sysfs: make I/O resource depend on HAS_IOPORT
  PCI: make quirk using inw() depend on HAS_IOPORT
  firmware: dmi-sysfs: handle HAS_IOPORT dependencies
  /dev/port: don't compile file operations without CONFIG_DEVPORT
  usb: handle HAS_IOPORT dependencies
  asm-generic/io.h: drop inb() etc for HAS_IOPORT=n

 arch/alpha/Kconfig                           |   1 +
 arch/arc/Kconfig                             |   1 +
 arch/arm/Kconfig                             |   1 +
 arch/arm64/Kconfig                           |   1 +
 arch/ia64/Kconfig                            |   1 +
 arch/m68k/Kconfig                            |   1 +
 arch/microblaze/Kconfig                      |   1 +
 arch/mips/Kconfig                            |   1 +
 arch/parisc/Kconfig                          |   1 +
 arch/powerpc/Kconfig                         |   1 +
 arch/riscv/Kconfig                           |   1 +
 arch/sh/Kconfig                              |   1 +
 arch/sparc/Kconfig                           |   1 +
 arch/x86/Kconfig                             |   1 +
 drivers/accessibility/speakup/Kconfig        |   1 +
 drivers/acpi/Kconfig                         |   1 +
 drivers/ata/Kconfig                          |  34 ++---
 drivers/ata/ata_generic.c                    |   3 +-
 drivers/ata/libata-sff.c                     |   2 +
 drivers/bus/Kconfig                          |   2 +-
 drivers/char/Kconfig                         |   3 +-
 drivers/char/ipmi/Makefile                   |  11 +-
 drivers/char/ipmi/ipmi_si_intf.c             |   3 +-
 drivers/char/ipmi/ipmi_si_pci.c              |   3 +
 drivers/char/mem.c                           |   6 +-
 drivers/char/tpm/Kconfig                     |   1 +
 drivers/char/tpm/tpm_infineon.c              |  14 +-
 drivers/char/tpm/tpm_tis_core.c              |  19 ++-
 drivers/comedi/Kconfig                       |  53 ++++++++
 drivers/firmware/dmi-sysfs.c                 |   4 +
 drivers/gpio/Kconfig                         |   2 +-
 drivers/gpu/drm/qxl/Kconfig                  |   1 +
 drivers/gpu/drm/tiny/Kconfig                 |   1 +
 drivers/gpu/drm/tiny/cirrus.c                |   2 +
 drivers/hwmon/Kconfig                        |  21 ++-
 drivers/i2c/busses/Kconfig                   |  29 +++--
 drivers/iio/adc/Kconfig                      |   2 +-
 drivers/input/gameport/Kconfig               |   6 +-
 drivers/input/serio/Kconfig                  |   2 +
 drivers/input/touchscreen/Kconfig            |   1 +
 drivers/isdn/hardware/mISDN/Kconfig          |  14 +-
 drivers/leds/Kconfig                         |   2 +-
 drivers/media/cec/platform/Kconfig           |   2 +-
 drivers/media/pci/dm1105/Kconfig             |   2 +-
 drivers/media/radio/Kconfig                  |  15 ++-
 drivers/media/rc/Kconfig                     |   6 +
 drivers/message/fusion/Kconfig               |   8 +-
 drivers/misc/altera-stapl/Makefile           |   3 +-
 drivers/misc/altera-stapl/altera.c           |   6 +-
 drivers/net/Kconfig                          |   2 +-
 drivers/net/arcnet/Kconfig                   |   2 +-
 drivers/net/can/cc770/Kconfig                |   1 +
 drivers/net/can/sja1000/Kconfig              |   1 +
 drivers/net/ethernet/8390/Kconfig            |   2 +-
 drivers/net/ethernet/amd/Kconfig             |   2 +-
 drivers/net/ethernet/intel/Kconfig           |   4 +-
 drivers/net/ethernet/sis/Kconfig             |   6 +-
 drivers/net/ethernet/ti/Kconfig              |   4 +-
 drivers/net/ethernet/via/Kconfig             |   5 +-
 drivers/net/fddi/Kconfig                     |   4 +-
 drivers/net/hamradio/Kconfig                 |   6 +-
 drivers/net/wan/Kconfig                      |   2 +-
 drivers/net/wireless/atmel/Kconfig           |   4 +-
 drivers/net/wireless/intersil/hostap/Kconfig |   4 +-
 drivers/parport/Kconfig                      |   2 +-
 drivers/pci/Kconfig                          |  11 ++
 drivers/pci/pci-sysfs.c                      |  16 +++
 drivers/pci/quirks.c                         |   2 +
 drivers/pcmcia/Kconfig                       |   2 +-
 drivers/platform/chrome/Kconfig              |   1 +
 drivers/platform/chrome/wilco_ec/Kconfig     |   1 +
 drivers/pnp/isapnp/Kconfig                   |   2 +-
 drivers/power/reset/Kconfig                  |   1 +
 drivers/rtc/Kconfig                          |   4 +-
 drivers/scsi/Kconfig                         |  21 +--
 drivers/scsi/aic7xxx/Kconfig.aic79xx         |   2 +-
 drivers/scsi/aic7xxx/Kconfig.aic7xxx         |   2 +-
 drivers/scsi/aic94xx/Kconfig                 |   2 +-
 drivers/scsi/megaraid/Kconfig.megaraid       |   2 +-
 drivers/scsi/mvsas/Kconfig                   |   2 +-
 drivers/scsi/qla2xxx/Kconfig                 |   2 +-
 drivers/spi/Kconfig                          |   1 +
 drivers/staging/sm750fb/Kconfig              |   2 +-
 drivers/staging/vt6655/Kconfig               |   2 +-
 drivers/tty/Kconfig                          |   2 +-
 drivers/tty/serial/Kconfig                   |   2 +-
 drivers/usb/core/hcd-pci.c                   |   3 +-
 drivers/usb/host/Kconfig                     |   4 +-
 drivers/usb/host/pci-quirks.c                | 127 ++++++++++---------
 drivers/usb/host/pci-quirks.h                |  33 +++--
 drivers/usb/host/uhci-hcd.c                  |   2 +-
 drivers/usb/host/uhci-hcd.h                  |  77 +++++++----
 drivers/video/fbdev/Kconfig                  |  23 ++--
 drivers/watchdog/Kconfig                     |   6 +-
 include/asm-generic/io.h                     |   5 +
 include/linux/gameport.h                     |   9 +-
 include/linux/parport.h                      |   2 +-
 include/video/vga.h                          |   8 ++
 lib/Kconfig                                  |   4 +
 lib/Kconfig.kgdb                             |   1 +
 sound/drivers/Kconfig                        |   3 +
 sound/pci/Kconfig                            |  43 +++++--
 102 files changed, 532 insertions(+), 250 deletions(-)

-- 
2.32.0

