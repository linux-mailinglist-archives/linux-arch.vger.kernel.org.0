Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617AE34A864
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCZNpp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 09:45:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58788 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhCZNoz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 09:44:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6NWL3t9Tz9tyyW;
        Fri, 26 Mar 2021 14:44:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kIulHNAnYVH6; Fri, 26 Mar 2021 14:44:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWL2lGwz9tyyV;
        Fri, 26 Mar 2021 14:44:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33E0E8B8C9;
        Fri, 26 Mar 2021 14:44:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5JtG0C39F4IQ; Fri, 26 Mar 2021 14:44:47 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C055F8B8C7;
        Fri, 26 Mar 2021 14:44:46 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 31C9867611; Fri, 26 Mar 2021 13:44:47 +0000 (UTC)
Message-Id: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 00/17] Implement GENERIC_CMDLINE
To:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Date:   Fri, 26 Mar 2021 13:44:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The purpose of this series is to improve and enhance the
handling of kernel boot arguments.

It is first focussed on powerpc but also extends the capability
for other arches.

This is based on suggestion from Daniel Walker <danielwa@cisco.com>

Main changes in V3:
- Also accept destination equal to source in cmdline_build() by setting a tmp buffer in __initdata. Powerpc provides different source and destination and call __cmdline_build() directly.
- Taken comments received from Will and Rob
- Converted all architectures (Only tested on powerpc)

Christophe Leroy (17):
  cmdline: Add generic function to build command line.
  drivers: of: use cmdline building function
  cmdline: Gives architectures opportunity to use generically defined
    boot cmdline manipulation
  powerpc: Convert to GENERIC_CMDLINE
  arm: Convert to GENERIC_CMDLINE
  arm64: Convert to GENERIC_CMDLINE
  hexagon: Convert to GENERIC_CMDLINE
  microblaze: Convert to GENERIC_CMDLINE
  nios2: Convert to GENERIC_CMDLINE
  openrisc: Convert to GENERIC_CMDLINE
  riscv: Convert to GENERIC_CMDLINE
  sh: Convert to GENERIC_CMDLINE
  sparc: Convert to GENERIC_CMDLINE
  xtensa: Convert to GENERIC_CMDLINE
  x86: Convert to GENERIC_CMDLINE
  mips: Convert to GENERIC_CMDLINE
  cmdline: Remove CONFIG_CMDLINE_EXTEND

 arch/arm/Kconfig                            | 38 +-------------
 arch/arm/kernel/atags_parse.c               | 15 ++----
 arch/arm64/Kconfig                          | 33 +-----------
 arch/arm64/kernel/idreg-override.c          |  9 ++--
 arch/hexagon/Kconfig                        | 11 +---
 arch/hexagon/kernel/setup.c                 | 10 +---
 arch/microblaze/Kconfig                     | 24 +--------
 arch/microblaze/configs/mmu_defconfig       |  2 +-
 arch/microblaze/kernel/head.S               |  4 +-
 arch/mips/Kconfig                           |  1 +
 arch/mips/Kconfig.debug                     | 44 ----------------
 arch/mips/configs/ar7_defconfig             |  1 -
 arch/mips/configs/bcm47xx_defconfig         |  1 -
 arch/mips/configs/bcm63xx_defconfig         |  1 -
 arch/mips/configs/bmips_be_defconfig        |  1 -
 arch/mips/configs/bmips_stb_defconfig       |  1 -
 arch/mips/configs/capcella_defconfig        |  1 -
 arch/mips/configs/ci20_defconfig            |  1 -
 arch/mips/configs/cu1000-neo_defconfig      |  1 -
 arch/mips/configs/cu1830-neo_defconfig      |  1 -
 arch/mips/configs/e55_defconfig             |  1 -
 arch/mips/configs/generic_defconfig         |  1 -
 arch/mips/configs/gpr_defconfig             |  1 -
 arch/mips/configs/loongson3_defconfig       |  1 -
 arch/mips/configs/mpc30x_defconfig          |  1 -
 arch/mips/configs/rt305x_defconfig          |  1 -
 arch/mips/configs/tb0219_defconfig          |  1 -
 arch/mips/configs/tb0226_defconfig          |  1 -
 arch/mips/configs/tb0287_defconfig          |  1 -
 arch/mips/configs/workpad_defconfig         |  1 -
 arch/mips/configs/xway_defconfig            |  1 -
 arch/mips/kernel/relocate.c                 |  4 +-
 arch/mips/kernel/setup.c                    | 40 +--------------
 arch/mips/pic32/pic32mzda/early_console.c   |  2 +-
 arch/mips/pic32/pic32mzda/init.c            |  2 -
 arch/nios2/Kconfig                          | 24 +--------
 arch/nios2/kernel/setup.c                   | 13 ++---
 arch/openrisc/Kconfig                       | 10 +---
 arch/powerpc/Kconfig                        | 37 +------------
 arch/powerpc/kernel/prom_init.c             | 17 +++---
 arch/riscv/Kconfig                          | 44 +---------------
 arch/riscv/kernel/setup.c                   |  5 +-
 arch/sh/Kconfig                             | 30 +----------
 arch/sh/configs/ap325rxa_defconfig          |  2 +-
 arch/sh/configs/dreamcast_defconfig         |  2 +-
 arch/sh/configs/ecovec24-romimage_defconfig |  2 +-
 arch/sh/configs/ecovec24_defconfig          |  2 +-
 arch/sh/configs/edosk7760_defconfig         |  2 +-
 arch/sh/configs/espt_defconfig              |  2 +-
 arch/sh/configs/j2_defconfig                |  2 +-
 arch/sh/configs/kfr2r09-romimage_defconfig  |  2 +-
 arch/sh/configs/kfr2r09_defconfig           |  2 +-
 arch/sh/configs/lboxre2_defconfig           |  2 +-
 arch/sh/configs/microdev_defconfig          |  2 +-
 arch/sh/configs/migor_defconfig             |  2 +-
 arch/sh/configs/polaris_defconfig           |  2 +-
 arch/sh/configs/r7780mp_defconfig           |  2 +-
 arch/sh/configs/r7785rp_defconfig           |  2 +-
 arch/sh/configs/rsk7201_defconfig           |  2 +-
 arch/sh/configs/rsk7203_defconfig           |  2 +-
 arch/sh/configs/rts7751r2d1_defconfig       |  2 +-
 arch/sh/configs/rts7751r2dplus_defconfig    |  2 +-
 arch/sh/configs/sdk7780_defconfig           |  2 +-
 arch/sh/configs/sdk7786_defconfig           |  2 +-
 arch/sh/configs/se7206_defconfig            |  2 +-
 arch/sh/configs/se7343_defconfig            |  2 +-
 arch/sh/configs/se7712_defconfig            |  2 +-
 arch/sh/configs/se7721_defconfig            |  2 +-
 arch/sh/configs/se7724_defconfig            |  2 +-
 arch/sh/configs/se7751_defconfig            |  2 +-
 arch/sh/configs/se7780_defconfig            |  2 +-
 arch/sh/configs/sh03_defconfig              |  2 +-
 arch/sh/configs/sh2007_defconfig            |  2 +-
 arch/sh/configs/sh7757lcr_defconfig         |  2 +-
 arch/sh/configs/sh7763rdp_defconfig         |  2 +-
 arch/sh/configs/shmin_defconfig             |  2 +-
 arch/sh/configs/shx3_defconfig              |  2 +-
 arch/sh/configs/titan_defconfig             |  2 +-
 arch/sh/configs/ul2_defconfig               |  2 +-
 arch/sh/kernel/setup.c                      | 11 +---
 arch/sparc/Kconfig                          | 18 +------
 arch/sparc/prom/bootstr_64.c                |  2 +-
 arch/x86/Kconfig                            | 45 +---------------
 arch/x86/kernel/setup.c                     | 17 +-----
 arch/xtensa/Kconfig                         | 15 +-----
 arch/xtensa/configs/audio_kc705_defconfig   |  1 -
 arch/xtensa/configs/common_defconfig        |  1 -
 arch/xtensa/configs/generic_kc705_defconfig |  1 -
 arch/xtensa/configs/iss_defconfig           |  1 -
 arch/xtensa/configs/nommu_kc705_defconfig   |  1 -
 arch/xtensa/configs/smp_lx200_defconfig     |  1 -
 arch/xtensa/configs/virt_defconfig          |  1 -
 arch/xtensa/configs/xip_kc705_defconfig     |  1 -
 arch/xtensa/kernel/setup.c                  | 10 +---
 drivers/firmware/efi/libstub/x86-stub.c     | 26 +++++-----
 drivers/of/fdt.c                            | 23 ++-------
 include/linux/cmdline.h                     | 57 +++++++++++++++++++++
 init/Kconfig                                | 46 +++++++++++++++++
 98 files changed, 209 insertions(+), 580 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.25.0

