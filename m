Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1449590C7D
	for <lists+linux-arch@lfdr.de>; Fri, 12 Aug 2022 09:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiHLHYp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Aug 2022 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiHLHYo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Aug 2022 03:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D9BA50E7;
        Fri, 12 Aug 2022 00:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CAD36174A;
        Fri, 12 Aug 2022 07:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E167C433D7;
        Fri, 12 Aug 2022 07:24:39 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v5.20
Date:   Fri, 12 Aug 2022 15:24:03 +0800
Message-Id: <20220812072403.3075518-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-5.20

for you to fetch changes up to 715355922212a3be8bfe5a94b5707a045ac6bf00:

  docs/zh_CN/LoongArch: Add I14 description (2022-08-12 13:10:11 +0800)

----------------------------------------------------------------
LoongArch changes for v5.20

1, Optimise getcpu() with vDSO;
2, PCI enablement on top of pci & irqchip changes;
3, Stack unwinder and stack trace support;
4, Some bug fixes and build error fixes;
5, Update the default config file.

Note: There is a conflict in arch/loongarch/include/asm/irq.h but can
be fixed simply (just remove both lines from the irqchip tree and the
loongarch tree).
----------------------------------------------------------------
Huacai Chen (8):
      Merge 'irq/loongarch', 'pci/ctrl/loongson' and 'pci/header-cleanup-immutable'
      LoongArch: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
      LoongArch: Adjust arch/loongarch/Kconfig
      LoongArch: Jump to the link address before enable PG
      LoongArch: Parse MADT to get multi-processor information
      LoongArch: Add PCI controller support
      LoongArch: Add vDSO syscall __vdso_getcpu()
      LoongArch: Update Loongson-3 default config file

Qing Zhang (5):
      LoongArch: Requires __force attributes for any casts
      LoongArch: Add guess unwinder support
      LoongArch: Add prologue unwinder support
      LoongArch: Add STACKTRACE support
      LoongArch: Add USER_STACKTRACE support

Tiezhu Yang (2):
      docs/LoongArch: Add I14 description
      docs/zh_CN/LoongArch: Add I14 description

Yang Li (1):
      LoongArch: Fix unsigned comparison with less than zero

 Documentation/loongarch/introduction.rst           |   2 +-
 .../translations/zh_CN/loongarch/introduction.rst  |   4 +-
 arch/alpha/include/asm/dma.h                       |   9 -
 arch/alpha/include/asm/pci.h                       |   6 -
 arch/arc/include/asm/dma.h                         |   5 -
 arch/arm/include/asm/dma.h                         |   6 -
 arch/arm/include/asm/pci.h                         |   5 -
 arch/arm64/include/asm/pci.h                       |  18 +-
 arch/csky/include/asm/pci.h                        |  23 +-
 arch/ia64/include/asm/dma.h                        |   2 -
 arch/ia64/include/asm/pci.h                        |   6 -
 arch/loongarch/Kconfig                             |  19 +-
 arch/loongarch/Kconfig.debug                       |  29 ++
 arch/loongarch/Makefile                            |   2 +
 arch/loongarch/configs/loongson3_defconfig         |  34 +-
 arch/loongarch/include/asm/acpi.h                  | 142 ++++++++
 arch/loongarch/include/asm/bootinfo.h              |   2 +-
 arch/loongarch/include/asm/dma.h                   |  11 +
 arch/loongarch/include/asm/inst.h                  |  52 +++
 arch/loongarch/include/asm/irq.h                   |  45 +--
 arch/loongarch/include/asm/page.h                  |   2 -
 arch/loongarch/include/asm/pci.h                   |  25 ++
 arch/loongarch/include/asm/processor.h             |   9 +
 arch/loongarch/include/asm/stacktrace.h            |  20 ++
 arch/loongarch/include/asm/switch_to.h             |  14 +-
 arch/loongarch/include/asm/uaccess.h               |   4 +-
 arch/loongarch/include/asm/unwind.h                |  42 +++
 arch/loongarch/include/asm/vdso.h                  |   1 +
 arch/loongarch/include/asm/vdso/vdso.h             |  15 +-
 arch/loongarch/kernel/Makefile                     |   4 +
 arch/loongarch/kernel/acpi.c                       | 103 ++----
 arch/loongarch/kernel/asm-offsets.c                |   2 +
 arch/loongarch/kernel/head.S                       |  19 +-
 arch/loongarch/kernel/irq.c                        |  58 ++-
 arch/loongarch/kernel/proc.c                       |   2 +-
 arch/loongarch/kernel/process.c                    |  90 ++++-
 arch/loongarch/kernel/smp.c                        |   5 +-
 arch/loongarch/kernel/stacktrace.c                 |  78 ++++
 arch/loongarch/kernel/switch.S                     |   2 +
 arch/loongarch/kernel/time.c                       |  16 +-
 arch/loongarch/kernel/traps.c                      |  24 +-
 arch/loongarch/kernel/unwind_guess.c               |  67 ++++
 arch/loongarch/kernel/unwind_prologue.c            | 176 +++++++++
 arch/loongarch/kernel/vdso.c                       |  25 +-
 arch/loongarch/pci/acpi.c                          | 175 +++++++++
 arch/loongarch/pci/pci.c                           | 101 ++++++
 arch/loongarch/vdso/Makefile                       |   2 +-
 arch/loongarch/vdso/vdso.lds.S                     |   1 +
 arch/loongarch/vdso/vgetcpu.c                      |  43 +++
 arch/m68k/include/asm/dma.h                        |   6 -
 arch/m68k/include/asm/pci.h                        |   2 -
 arch/microblaze/include/asm/dma.h                  |   6 -
 arch/mips/include/asm/dma.h                        |   8 -
 arch/mips/include/asm/mach-loongson64/irq.h        |   3 +-
 arch/mips/include/asm/pci.h                        |   6 -
 arch/parisc/include/asm/dma.h                      |   6 -
 arch/parisc/include/asm/pci.h                      |   5 -
 arch/powerpc/include/asm/dma.h                     |   6 -
 arch/powerpc/include/asm/pci.h                     |   1 -
 arch/riscv/include/asm/pci.h                       |  31 +-
 arch/s390/include/asm/dma.h                        |   6 -
 arch/s390/include/asm/pci.h                        |   1 -
 arch/sh/include/asm/dma.h                          |   6 -
 arch/sh/include/asm/pci.h                          |   6 -
 arch/sparc/include/asm/dma.h                       |   8 -
 arch/sparc/include/asm/pci.h                       |   9 -
 arch/um/include/asm/pci.h                          |  24 +-
 arch/x86/include/asm/dma.h                         |   8 -
 arch/x86/include/asm/pci.h                         |   3 -
 arch/x86/kernel/cpu/cyrix.c                        |   1 +
 arch/xtensa/include/asm/dma.h                      |   7 -
 arch/xtensa/include/asm/pci.h                      |   3 -
 drivers/acpi/bus.c                                 |   3 +
 drivers/acpi/irq.c                                 |  58 ++-
 drivers/acpi/pci_mcfg.c                            |  13 +
 drivers/comedi/drivers/comedi_isadma.c             |   2 +-
 drivers/irqchip/Kconfig                            |  32 +-
 drivers/irqchip/Makefile                           |   3 +
 drivers/irqchip/irq-gic-v3.c                       |  18 +-
 drivers/irqchip/irq-gic.c                          |  18 +-
 drivers/irqchip/irq-loongarch-cpu.c                | 148 ++++++++
 drivers/irqchip/irq-loongson-eiointc.c             | 395 +++++++++++++++++++++
 drivers/irqchip/irq-loongson-liointc.c             | 203 +++++++----
 drivers/irqchip/irq-loongson-pch-lpc.c             | 205 +++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c             | 127 ++++---
 drivers/irqchip/irq-loongson-pch-pic.c             | 177 +++++++--
 drivers/pci/controller/Kconfig                     |   2 +-
 drivers/pci/controller/pci-loongson.c              | 206 ++++++++---
 drivers/pci/pci.c                                  |   2 +
 drivers/pci/quirks.c                               |   4 +-
 drivers/pnp/resource.c                             |   5 +-
 include/asm-generic/pci.h                          |  39 +-
 include/asm-generic/pci_iomap.h                    |   2 +
 include/linux/acpi.h                               |   4 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/irq.h                                |   1 +
 include/linux/isa-dma.h                            |  14 +
 include/linux/pci-ecam.h                           |   1 +
 kernel/irq/generic-chip.c                          |   2 +-
 sound/core/isadma.c                                |   2 +-
 100 files changed, 2775 insertions(+), 621 deletions(-)
 create mode 100644 arch/loongarch/include/asm/dma.h
 create mode 100644 arch/loongarch/include/asm/pci.h
 create mode 100644 arch/loongarch/include/asm/unwind.h
 create mode 100644 arch/loongarch/kernel/stacktrace.c
 create mode 100644 arch/loongarch/kernel/unwind_guess.c
 create mode 100644 arch/loongarch/kernel/unwind_prologue.c
 create mode 100644 arch/loongarch/pci/acpi.c
 create mode 100644 arch/loongarch/pci/pci.c
 create mode 100644 arch/loongarch/vdso/vgetcpu.c
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
 create mode 100644 include/linux/isa-dma.h
