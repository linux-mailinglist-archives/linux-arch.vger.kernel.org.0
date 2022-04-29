Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DFF514B74
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376695AbiD2N4N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbiD2Nzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4B3692BD;
        Fri, 29 Apr 2022 06:51:38 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDE3dH026919;
        Fri, 29 Apr 2022 13:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=xH1H+dZpcnkoXjkucpaq6JJ/BxwCu2uILw7KNDy7aWQ=;
 b=fpHIhE2wzCp/GSgwGsPiSJYIr2PtveG5Iz59hrxWkSf8C2XadyMUH6iCl2BIkscBsviH
 bMs0kjoTouaEfvPpLBtn/02HDov4kpHi91QLo5zxNYdxZixe0/OTMgryMIWDQjawPbVb
 5a429a/xVpTjRciOyQ0UtFYxdJibkBbFHqEwMwH1xWXDHPdnOjJAN/h7CmSevCuypgQe
 Jh4SnoKvS6VBQHbE7N+m1J2VM+b1lYcxnkvzwxEuLDD5X7N7MHWCQdCTnozg5GWY62G/
 Aq5tCCd4krFcIBBg23QFx0d3l3CRkv97Y1SzqYAmmDp8vXQcQG0lO9O3wGbEpWVIHG27 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxmna3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:14 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDgvAe001380;
        Fri, 29 Apr 2022 13:51:14 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxmn91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQlIW021539;
        Fri, 29 Apr 2022 13:51:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm93917qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDp9Lj46596356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535344C040;
        Fri, 29 Apr 2022 13:51:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8ADA4C04E;
        Fri, 29 Apr 2022 13:51:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:08 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [RFC v2 00/39] Kconfig: Introduce HAS_IOPORT config option
Date:   Fri, 29 Apr 2022 15:49:58 +0200
Message-Id: <20220429135108.2781579-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cdpDh2WxnvzULvYFTeuMjjLEezvDLJdH
X-Proofpoint-GUID: BkVAUnkRbGdJvgwI2KccZfGC2t9XHEzz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Kernel Hackers,

Some platforms such as s390 do not support PCI I/O spaces. On such platforms
I/O space accessors like inb()/outb() are stubs that can never actually work.
The way these stubs are implemented in asm-generic/io.h leads to compiler
warnings because any use will cause a NULL pointer access. In a previous patch
we tried handling this with a run-time warning on access. This approach however
was rejected by Linus[0] with the argument that this really should be
a compile-time check and, though a much more invasive change, we believe that
is indeed the right approach.

This patch series aims to do exactly that by introducing a HAS_IOPORT config
option akin to the existing HAS_IOMEM. When this is unset inb()/outb() and
friends may not be defined.

This series builts heavily on an original patch for demonstating the concept by
Arnd Bergmann[1] and is a stripped down version of a previous RFC[2]. The most
important change being that we dropped the LEGACY_PCI config option in favor of
using HAS_IOPORT regardless of whether the device is a legacy PCI device.
As this is a significant change to the overall series I did not carry over
previous R-bs.

This version is based on v5.18-rc4 and is also available on my kernel.org tree
in the has_ioport branch with the PGP signed tag has_ioport_rfc_v2:

https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git

Thanks,
Niklas Schnelle

Changes from RFC v1:
- Completely dropped the LEGACY_PCI option and replaced its dependencies with
  HAS_IOPORT as appropriate
- In the usb subsystem patch I incorporated the feedback from v1 by Alan Stern:
  - Used a local macro to nop in*()/out*() in the helpers
  - Removed an unnecessary further restriction on CONFIG_USB_UHCI_HCD
- Added a few more subsystems including wireless, ptp, and, mISDN that I had
  previously missed due to a blanket !S390.
- Removed blanket !S390 dependencies where they are added due to the I/O port
  problem
- In the sound system SND_OPL3_LIB needed to use "depends on" instead of
  "select" because of its added HAS_IOPORT dependency
- In the drm subsystem the bochs driver gets #ifdefs instead of a blanket
  dependency because its MMIO capable device variant should work without
  HAS_IOPORT.

[0] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
[1] https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com/
[2] https://yhbt.net/lore/all/20211227164317.4146918-1-schnelle@linux.ibm.com/

Niklas Schnelle (39):
  Kconfig: introduce HAS_IOPORT option and select it as necessary
  ACPI: add dependency on HAS_IOPORT
  ata: add HAS_IOPORT dependencies
  char: impi, tpm: depend on HAS_IOPORT
  comedi: add HAS_IOPORT dependencies
  counter: add HAS_IOPORT dependencies
  /dev/port: don't compile file operations without CONFIG_DEVPORT
  drm: handle HAS_IOPORT dependencies
  firmware: dmi-sysfs: handle HAS_IOPORT=n
  gpio: add HAS_IOPORT dependencies
  hwmon: add HAS_IOPORT dependencies
  i2c: add HAS_IOPORT dependencies
  iio: adc: Kconfig: add HAS_IOPORT dependencies
  Input: add HAS_IOPORT dependencies
  Input: gameport: add ISA and HAS_IOPORT dependencies
  leds: add HAS_IOPORT dependencies
  media: add HAS_IOPORT dependencies
  misc: add HAS_IOPORT dependencies
  mISDN: add HAS_IOPORT dependencies
  mpt fusion: add HAS_IOPORT dependencies
  net: add HAS_IOPORT dependencies
  parport: PC style parport depends on HAS_IOPORT
  PCI: make quirk using inw() depend on HAS_IOPORT
  PCI/sysfs: make I/O resource depend on HAS_IOPORT
  pcmcia: add HAS_IOPORT dependencies
  platform: add HAS_IOPORT dependencies
  pnp: add HAS_IOPORT dependencies
  power: add HAS_IOPORT dependencies
  rtc: add HAS_IOPORT dependencies
  scsi: add HAS_IOPORT dependencies
  sound: add HAS_IOPORT dependencies
  speakup: add HAS_IOPORT dependency for SPEAKUP_SERIALIO
  staging: add HAS_IOPORT dependencies
  tty: serial: add HAS_IOPORT dependencies
  usb: handle HAS_IOPORT dependencies
  video: handle HAS_IOPORT dependencies
  watchdog: add HAS_IOPORT dependencies
  wireless: add HAS_IOPORT dependencies
  asm-generic/io.h: drop inb() etc for HAS_IOPORT=n

 arch/alpha/Kconfig                           |   1 +
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
 drivers/ata/Kconfig                          |   1 +
 drivers/bus/Kconfig                          |   2 +-
 drivers/char/Kconfig                         |   3 +-
 drivers/char/ipmi/Makefile                   |  11 +-
 drivers/char/ipmi/ipmi_si_intf.c             |   3 +-
 drivers/char/ipmi/ipmi_si_pci.c              |   3 +
 drivers/char/mem.c                           |   6 +-
 drivers/char/tpm/Kconfig                     |   1 +
 drivers/char/tpm/tpm_infineon.c              |  14 +-
 drivers/char/tpm/tpm_tis_core.c              |  19 ++-
 drivers/comedi/Kconfig                       |  33 ++++-
 drivers/counter/Kconfig                      |   1 +
 drivers/firmware/dmi-sysfs.c                 |   4 +
 drivers/gpio/Kconfig                         |   2 +-
 drivers/gpu/drm/qxl/Kconfig                  |   1 +
 drivers/gpu/drm/tiny/bochs.c                 |  19 +++
 drivers/gpu/drm/tiny/cirrus.c                |   2 +
 drivers/hwmon/Kconfig                        |  21 ++-
 drivers/i2c/busses/Kconfig                   |  31 +++--
 drivers/iio/adc/Kconfig                      |   2 +-
 drivers/input/gameport/Kconfig               |   4 +-
 drivers/input/serio/Kconfig                  |   2 +
 drivers/input/touchscreen/Kconfig            |   1 +
 drivers/isdn/Kconfig                         |   1 -
 drivers/isdn/hardware/mISDN/Kconfig          |  12 +-
 drivers/leds/Kconfig                         |   2 +-
 drivers/media/pci/dm1105/Kconfig             |   2 +-
 drivers/media/radio/Kconfig                  |  14 +-
 drivers/media/rc/Kconfig                     |   6 +
 drivers/message/fusion/Kconfig               |   2 +-
 drivers/misc/altera-stapl/Makefile           |   3 +-
 drivers/misc/altera-stapl/altera.c           |   6 +-
 drivers/net/Kconfig                          |   2 +-
 drivers/net/arcnet/Kconfig                   |   2 +-
 drivers/net/can/cc770/Kconfig                |   1 +
 drivers/net/can/sja1000/Kconfig              |   1 +
 drivers/net/ethernet/8390/Kconfig            |   2 +-
 drivers/net/ethernet/amd/Kconfig             |   2 +-
 drivers/net/ethernet/intel/Kconfig           |   2 +-
 drivers/net/ethernet/sis/Kconfig             |   4 +-
 drivers/net/ethernet/ti/Kconfig              |   2 +-
 drivers/net/ethernet/via/Kconfig             |   1 +
 drivers/net/fddi/Kconfig                     |   2 +-
 drivers/net/hamradio/Kconfig                 |   6 +-
 drivers/net/wan/Kconfig                      |   2 +-
 drivers/net/wireless/atmel/Kconfig           |   2 +-
 drivers/net/wireless/intersil/hostap/Kconfig |   2 +-
 drivers/parport/Kconfig                      |   4 +-
 drivers/pci/pci-sysfs.c                      |  16 +++
 drivers/pci/quirks.c                         |   2 +
 drivers/pcmcia/Kconfig                       |   2 +-
 drivers/platform/chrome/Kconfig              |   1 +
 drivers/platform/chrome/wilco_ec/Kconfig     |   1 +
 drivers/pnp/isapnp/Kconfig                   |   2 +-
 drivers/power/reset/Kconfig                  |   1 +
 drivers/rtc/Kconfig                          |   4 +-
 drivers/scsi/Kconfig                         |  19 +--
 drivers/scsi/aic7xxx/Kconfig.aic79xx         |   2 +-
 drivers/scsi/aic7xxx/Kconfig.aic7xxx         |   2 +-
 drivers/scsi/aic94xx/Kconfig                 |   2 +-
 drivers/scsi/megaraid/Kconfig.megaraid       |   6 +-
 drivers/scsi/mvsas/Kconfig                   |   2 +-
 drivers/scsi/qla2xxx/Kconfig                 |   2 +-
 drivers/staging/sm750fb/Kconfig              |   2 +-
 drivers/staging/vt6655/Kconfig               |   2 +-
 drivers/tty/Kconfig                          |   2 +-
 drivers/tty/serial/8250/Kconfig              |   2 +-
 drivers/tty/serial/Kconfig                   |   2 +-
 drivers/usb/core/hcd-pci.c                   |   2 +
 drivers/usb/host/Kconfig                     |   4 +-
 drivers/usb/host/pci-quirks.c                | 128 ++++++++++---------
 drivers/usb/host/pci-quirks.h                |  31 +++--
 drivers/usb/host/uhci-hcd.c                  |   2 +-
 drivers/usb/host/uhci-hcd.h                  |  33 +++--
 drivers/video/fbdev/Kconfig                  |  25 ++--
 drivers/watchdog/Kconfig                     |   6 +-
 include/asm-generic/io.h                     |   5 +
 include/linux/gameport.h                     |   9 +-
 include/linux/parport.h                      |   2 +-
 include/video/vga.h                          |   8 ++
 lib/Kconfig                                  |   4 +
 lib/Kconfig.kgdb                             |   1 +
 net/ax25/Kconfig                             |   2 +-
 sound/drivers/Kconfig                        |   5 +
 sound/isa/Kconfig                            |  44 +++----
 sound/pci/Kconfig                            |  64 +++++++---
 101 files changed, 489 insertions(+), 246 deletions(-)

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
-- 
2.32.0

