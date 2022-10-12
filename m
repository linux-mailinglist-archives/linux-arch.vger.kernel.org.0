Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9A5FC7BB
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJLOvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJLOu5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 10:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E105DED2F;
        Wed, 12 Oct 2022 07:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06BB861521;
        Wed, 12 Oct 2022 14:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94D1C433C1;
        Wed, 12 Oct 2022 14:50:51 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.1
Date:   Wed, 12 Oct 2022 22:48:46 +0800
Message-Id: <20221012144846.2963749-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.1

for you to fetch changes up to 2c8577f5e455b149f3ecb24e9a9f48f372a5d71a:

  LoongArch: Update Loongson-3 default config file (2022-10-12 16:36:23 +0800)

----------------------------------------------------------------
LoongArch changes for v6.1

1, Use EXPLICIT_RELOCS (ABIv2.0);
2, Use generic BUG() handler;
3, Refactor TLB/Cache operations;
4, Add qspinlock support;
5, Add perf events support;
6, Add kexec/kdump support;
7, Add BPF JIT support;
8, Add ACPI-based laptop driver;
9, Update the default config file.

----------------------------------------------------------------
Colin Ian King (1):
      LoongArch: Kconfig: Fix spelling mistake "delibrately" -> "deliberately"

Huacai Chen (10):
      Merge tag 'efi-next-for-v6.1' into loongarch-next
      LoongArch: Flush TLB earlier at initialization
      LoongArch: Mark __xchg() and __cmpxchg() as __always_inline
      LoongArch: Refactor cache probe and flush methods
      LoongArch: Support access filter to /dev/mem interface
      LoongArch: Use TLB for ioremap()
      LoongArch: Add qspinlock support
      LoongArch: Add perf events support
      LoongArch: Add SysRq-x (TLB Dump) support
      LoongArch: Update Loongson-3 default config file

Jianmin Lv (2):
      LoongArch: Fix cpu name after CPU-hotplug
      LoongArch: Add ACPI-based generic laptop driver

Rui Wang (1):
      LoongArch: mm: Refactor TLB exception handlers

Tiezhu Yang (4):
      LoongArch: Do not create sysfs control file for io master CPUs
      LoongArch: Move {signed,unsigned}_imm_check() to inst.h
      LoongArch: Add some instruction opcodes and formats
      LoongArch: Add BPF JIT support

Xi Ruoyao (5):
      LoongArch: Add Kconfig option AS_HAS_EXPLICIT_RELOCS
      LoongArch: Adjust symbol addressing for AS_HAS_EXPLICIT_RELOCS
      LoongArch: Define ELF relocation types added in ABIv2.0
      LoongArch: Support PC-relative relocations in modules
      LoongArch: Support R_LARCH_GOT_PC_{LO12,HI20} in modules

Youling Tang (3):
      LoongArch: Use generic BUG() handler
      LoongArch: Add kexec support
      LoongArch: Add kdump support

 Documentation/arm/uefi.rst                       |    4 -
 arch/arm/include/asm/efi.h                       |    3 +-
 arch/arm/kernel/efi.c                            |   79 ++
 arch/arm/kernel/setup.c                          |    2 +-
 arch/arm64/Makefile                              |    9 +-
 arch/arm64/boot/.gitignore                       |    1 +
 arch/arm64/boot/Makefile                         |    6 +
 arch/arm64/kernel/image-vars.h                   |   13 -
 arch/loongarch/Kbuild                            |    1 +
 arch/loongarch/Kconfig                           |   74 +-
 arch/loongarch/Makefile                          |   40 +-
 arch/loongarch/boot/.gitignore                   |    1 +
 arch/loongarch/boot/Makefile                     |   14 +-
 arch/loongarch/configs/loongson3_defconfig       |   63 +-
 arch/loongarch/include/asm/Kbuild                |    5 +-
 arch/loongarch/include/asm/bootinfo.h            |    7 +-
 arch/loongarch/include/asm/bug.h                 |   58 +-
 arch/loongarch/include/asm/cacheflush.h          |   87 +-
 arch/loongarch/include/asm/cacheops.h            |   36 +-
 arch/loongarch/include/asm/cmpxchg.h             |    8 +-
 arch/loongarch/include/asm/cpu-features.h        |    5 -
 arch/loongarch/include/asm/cpu-info.h            |   21 +-
 arch/loongarch/include/asm/efi.h                 |   11 +-
 arch/loongarch/include/asm/elf.h                 |   37 +
 arch/loongarch/include/asm/fixmap.h              |   15 +
 arch/loongarch/include/asm/inst.h                |  410 +++++++-
 arch/loongarch/include/asm/io.h                  |   73 +-
 arch/loongarch/include/asm/kexec.h               |   60 ++
 arch/loongarch/include/asm/loongarch.h           |   33 +-
 arch/loongarch/include/asm/module.h              |   27 +-
 arch/loongarch/include/asm/module.lds.h          |    1 +
 arch/loongarch/include/asm/percpu.h              |    9 +
 arch/loongarch/include/asm/perf_event.h          |    4 +-
 arch/loongarch/include/asm/pgtable-bits.h        |    3 +
 arch/loongarch/include/asm/setup.h               |    2 +
 arch/loongarch/include/asm/spinlock.h            |   12 +
 arch/loongarch/include/asm/spinlock_types.h      |   11 +
 arch/loongarch/include/uapi/asm/bpf_perf_event.h |    9 +
 arch/loongarch/include/uapi/asm/perf_regs.h      |   40 +
 arch/loongarch/kernel/Makefile                   |    7 +
 arch/loongarch/kernel/cacheinfo.c                |   98 +-
 arch/loongarch/kernel/cpu-probe.c                |    4 +-
 arch/loongarch/kernel/crash_dump.c               |   23 +
 arch/loongarch/kernel/efi-header.S               |   99 ++
 arch/loongarch/kernel/efi.c                      |   33 +-
 arch/loongarch/kernel/env.c                      |   13 +-
 arch/loongarch/kernel/head.S                     |   40 +-
 arch/loongarch/kernel/image-vars.h               |   27 +
 arch/loongarch/kernel/machine_kexec.c            |  304 ++++++
 arch/loongarch/kernel/mem.c                      |    3 -
 arch/loongarch/kernel/module-sections.c          |   61 +-
 arch/loongarch/kernel/module.c                   |  105 +-
 arch/loongarch/kernel/perf_event.c               |  887 ++++++++++++++++
 arch/loongarch/kernel/perf_regs.c                |   53 +
 arch/loongarch/kernel/relocate_kernel.S          |  112 ++
 arch/loongarch/kernel/setup.c                    |   91 +-
 arch/loongarch/kernel/smp.c                      |    5 -
 arch/loongarch/kernel/sysrq.c                    |   65 ++
 arch/loongarch/kernel/topology.c                 |    3 +-
 arch/loongarch/kernel/traps.c                    |   33 +-
 arch/loongarch/kernel/vmlinux.lds.S              |    5 +
 arch/loongarch/mm/cache.c                        |  211 ++--
 arch/loongarch/mm/init.c                         |   64 ++
 arch/loongarch/mm/mmap.c                         |   29 +
 arch/loongarch/mm/tlb.c                          |    5 +-
 arch/loongarch/mm/tlbex.S                        |  537 +++++-----
 arch/loongarch/net/Makefile                      |    7 +
 arch/loongarch/net/bpf_jit.c                     | 1179 ++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.h                     |  282 ++++++
 arch/loongarch/pci/acpi.c                        |   76 +-
 arch/loongarch/pci/pci.c                         |    7 +-
 arch/riscv/Makefile                              |    6 +-
 arch/riscv/boot/.gitignore                       |    1 +
 arch/riscv/boot/Makefile                         |    6 +
 arch/riscv/kernel/image-vars.h                   |    9 -
 arch/x86/platform/efi/efi_64.c                   |   18 +-
 arch/x86/platform/efi/efi_thunk_64.S             |   13 +-
 drivers/firmware/efi/Kconfig                     |   45 +-
 drivers/firmware/efi/efi-init.c                  |   61 +-
 drivers/firmware/efi/efi.c                       |   15 +
 drivers/firmware/efi/libstub/Makefile            |   32 +-
 drivers/firmware/efi/libstub/Makefile.zboot      |   70 ++
 drivers/firmware/efi/libstub/arm64-stub.c        |   27 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c   |  290 +++---
 drivers/firmware/efi/libstub/efi-stub.c          |  118 +--
 drivers/firmware/efi/libstub/efistub.h           |   69 +-
 drivers/firmware/efi/libstub/fdt.c               |  175 ++--
 drivers/firmware/efi/libstub/file.c              |   23 +-
 drivers/firmware/efi/libstub/intrinsics.c        |   30 +
 drivers/firmware/efi/libstub/loongarch-stub.c    |  102 ++
 drivers/firmware/efi/libstub/mem.c               |   93 +-
 drivers/firmware/efi/libstub/randomalloc.c       |   25 +-
 drivers/firmware/efi/libstub/relocate.c          |   21 +-
 drivers/firmware/efi/libstub/systable.c          |    8 +
 drivers/firmware/efi/libstub/x86-stub.c          |   33 +-
 drivers/firmware/efi/libstub/zboot-header.S      |  143 +++
 drivers/firmware/efi/libstub/zboot.c             |  302 ++++++
 drivers/firmware/efi/libstub/zboot.lds           |   44 +
 drivers/platform/Kconfig                         |    2 +
 drivers/platform/Makefile                        |    1 +
 drivers/platform/loongarch/Kconfig               |   31 +
 drivers/platform/loongarch/Makefile              |    1 +
 drivers/platform/loongarch/loongson-laptop.c     |  624 ++++++++++++
 include/linux/efi.h                              |   35 +
 include/linux/pe.h                               |    2 +
 105 files changed, 6991 insertions(+), 1246 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kexec.h
 create mode 100644 arch/loongarch/include/asm/spinlock.h
 create mode 100644 arch/loongarch/include/asm/spinlock_types.h
 create mode 100644 arch/loongarch/include/uapi/asm/bpf_perf_event.h
 create mode 100644 arch/loongarch/include/uapi/asm/perf_regs.h
 create mode 100644 arch/loongarch/kernel/crash_dump.c
 create mode 100644 arch/loongarch/kernel/efi-header.S
 create mode 100644 arch/loongarch/kernel/image-vars.h
 create mode 100644 arch/loongarch/kernel/machine_kexec.c
 create mode 100644 arch/loongarch/kernel/perf_event.c
 create mode 100644 arch/loongarch/kernel/perf_regs.c
 create mode 100644 arch/loongarch/kernel/relocate_kernel.S
 create mode 100644 arch/loongarch/kernel/sysrq.c
 create mode 100644 arch/loongarch/net/Makefile
 create mode 100644 arch/loongarch/net/bpf_jit.c
 create mode 100644 arch/loongarch/net/bpf_jit.h
 create mode 100644 drivers/firmware/efi/libstub/Makefile.zboot
 create mode 100644 drivers/firmware/efi/libstub/intrinsics.c
 create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c
 create mode 100644 drivers/firmware/efi/libstub/systable.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
 create mode 100644 drivers/firmware/efi/libstub/zboot.c
 create mode 100644 drivers/firmware/efi/libstub/zboot.lds
 create mode 100644 drivers/platform/loongarch/Kconfig
 create mode 100644 drivers/platform/loongarch/Makefile
 create mode 100644 drivers/platform/loongarch/loongson-laptop.c
