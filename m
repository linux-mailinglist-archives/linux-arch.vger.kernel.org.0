Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74387438DA
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 12:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjF3KBo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 06:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjF3KBI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 06:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A53A93;
        Fri, 30 Jun 2023 03:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2ED561714;
        Fri, 30 Jun 2023 10:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EB9C433C0;
        Fri, 30 Jun 2023 10:01:01 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.5
Date:   Fri, 30 Jun 2023 18:00:37 +0800
Message-Id: <20230630100037.1071320-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
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

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.5

for you to fetch changes up to 5ee35c769663cb1c5f26e12cad84904dc3002de8:

  LoongArch: Remove five DIE_* definitions in kdebug.h (2023-06-29 20:58:44 +0800)

----------------------------------------------------------------
LoongArch changes for v6.5

1, Preliminary ClangBuiltLinux enablement;
2, Add support to clone a time namespace;
3, Add vector extensions support;
4, Add SMT (Simultaneous Multi-Threading) support;
5, Support dbar with different hints;
6, Introduce hardware page table walker;
7, Add jump-label implementation;
8, Add rethook and uprobes support;
9, Some bug fixes and other small changes.

----------------------------------------------------------------
Binbin Zhou (2):
      dt-bindings: interrupt-controller: Add Loongson EIOINTC
      irqchip/loongson-eiointc: Add DT init support

Dan Carpenter (1):
      LoongArch: Delete unnecessary debugfs checking

Haoran Jiang (1):
      LoongArch: Replace kretprobe with rethook

Huacai Chen (6):
      Merge 'irq/loongarch-fixes-6.5' into loongarch-next
      LoongArch: Set CPU#0 as the io master for FDT
      LoongArch: Add vector extensions support
      LoongArch: Add SMT (Simultaneous Multi-Threading) support
      LoongArch: Support dbar with different hints
      LoongArch: Introduce hardware page table walker

Jianmin Lv (3):
      irqchip/loongson-pch-pic: Fix initialization of HT vector register
      irqchip/loongson-liointc: Fix IRQ trigger polarity
      irqchip/loongson-eiointc: Fix irq affinity setting during resume

Liu Peibao (1):
      irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment

Tiezhu Yang (8):
      LoongArch: Add support to clone a time namespace
      LoongArch: Select HAVE_DEBUG_KMEMLEAK to support kmemleak
      LoongArch: Move three functions from kprobes.c to inst.c
      LoongArch: Check for AMO instructions in insns_not_supported()
      LoongArch: Add larch_insn_gen_break() to generate break insns
      LoongArch: Use larch_insn_gen_break() for kprobes
      LoongArch: Add uprobes support
      LoongArch: Remove five DIE_* definitions in kdebug.h

WANG Rui (3):
      LoongArch: Add guard for the larch_insn_gen_xxx functions
      LoongArch: Calculate various sizes in the linker script
      LoongArch: extable: Also recognize ABI names of registers

WANG Xuerui (8):
      LoongArch: Prepare for assemblers with proper FCSR class support
      LoongArch: Make the CPUCFG&CSR ops simple aliases of compiler built-ins
      LoongArch: Simplify the invtlb wrappers
      LoongArch: Tweak CFLAGS for Clang compatibility
      LoongArch: vDSO: Use CLANG_FLAGS instead of filtering out '--target='
      LoongArch: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
      LoongArch: Mark Clang LTO as working
      Makefile: Add loongarch target flag for Clang compilation

Yinbo Zhu (2):
      irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE flag
      LoongArch: Export some arch-specific pm interfaces

Youling Tang (1):
      LoongArch: Add jump-label implementation

 .../interrupt-controller/loongson,eiointc.yaml     |  59 ++++
 .../features/core/jump-labels/arch-support.txt     |   2 +-
 .../features/debug/kmemleak/arch-support.txt       |   2 +-
 arch/loongarch/Kconfig                             |  72 +++-
 arch/loongarch/Makefile                            |  23 +-
 arch/loongarch/include/asm/Kbuild                  |   1 -
 arch/loongarch/include/asm/acpi.h                  |  13 +-
 arch/loongarch/include/asm/asmmacro.h              | 393 +++++++++++++++++++++
 arch/loongarch/include/asm/barrier.h               | 130 +++----
 arch/loongarch/include/asm/cpu-features.h          |   2 +-
 arch/loongarch/include/asm/cpu-info.h              |   1 +
 arch/loongarch/include/asm/cpu.h                   |   2 +
 arch/loongarch/include/asm/fpregdef.h              |   7 +
 arch/loongarch/include/asm/fpu.h                   | 185 +++++++++-
 arch/loongarch/include/asm/gpr-num.h               |  30 ++
 arch/loongarch/include/asm/inst.h                  |  55 ++-
 arch/loongarch/include/asm/io.h                    |   2 +-
 arch/loongarch/include/asm/jump_label.h            |  50 +++
 arch/loongarch/include/asm/kdebug.h                |   5 -
 arch/loongarch/include/asm/kprobes.h               |   5 +-
 arch/loongarch/include/asm/loongarch.h             |  76 ++--
 arch/loongarch/include/asm/module.h                |   2 +-
 arch/loongarch/include/asm/page.h                  |   1 +
 arch/loongarch/include/asm/percpu.h                |   6 +-
 arch/loongarch/include/asm/pgtable.h               |   4 +-
 arch/loongarch/include/asm/qspinlock.h             |  18 +
 arch/loongarch/include/asm/suspend.h               |  10 +
 arch/loongarch/include/asm/tlb.h                   |  46 ++-
 arch/loongarch/include/asm/uprobes.h               |  36 ++
 arch/loongarch/include/asm/vdso/gettimeofday.h     |   9 +-
 arch/loongarch/include/asm/vdso/vdso.h             |  32 +-
 arch/loongarch/include/uapi/asm/hwcap.h            |   1 +
 arch/loongarch/include/uapi/asm/ptrace.h           |  16 +-
 arch/loongarch/include/uapi/asm/sigcontext.h       |  18 +
 arch/loongarch/kernel/Makefile                     |   8 +-
 arch/loongarch/kernel/acpi.c                       |  32 ++
 arch/loongarch/kernel/cpu-probe.c                  |  16 +
 arch/loongarch/kernel/efi-header.S                 |   6 +-
 arch/loongarch/kernel/fpu.S                        | 270 ++++++++++++++
 arch/loongarch/kernel/head.S                       |   8 +-
 arch/loongarch/kernel/inst.c                       |  83 ++++-
 arch/loongarch/kernel/jump_label.c                 |  22 ++
 arch/loongarch/kernel/kprobes.c                    |  96 +----
 arch/loongarch/kernel/proc.c                       |   2 +
 arch/loongarch/kernel/process.c                    |  12 +-
 arch/loongarch/kernel/ptrace.c                     | 110 ++++++
 arch/loongarch/kernel/rethook.c                    |  28 ++
 arch/loongarch/kernel/rethook.h                    |   8 +
 .../{kprobes_trampoline.S => rethook_trampoline.S} |   6 +-
 arch/loongarch/kernel/signal.c                     | 326 ++++++++++++++++-
 arch/loongarch/kernel/smp.c                        |  27 +-
 arch/loongarch/kernel/traps.c                      |  95 ++++-
 arch/loongarch/kernel/unaligned.c                  |   2 -
 arch/loongarch/kernel/uprobes.c                    | 153 ++++++++
 arch/loongarch/kernel/vdso.c                       |  98 ++++-
 arch/loongarch/kernel/vmlinux.lds.S                |   9 +
 arch/loongarch/lib/dump_tlb.c                      |   6 +-
 arch/loongarch/mm/tlb.c                            |  21 +-
 arch/loongarch/mm/tlbex.S                          |  27 +-
 arch/loongarch/power/suspend.c                     |   8 +-
 arch/loongarch/vdso/Makefile                       |   7 +-
 arch/loongarch/vdso/vgetcpu.c                      |   2 +-
 drivers/acpi/Kconfig                               |   2 +-
 drivers/irqchip/irq-loongson-eiointc.c             | 135 +++++--
 drivers/irqchip/irq-loongson-liointc.c             |  13 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  10 +-
 scripts/Makefile.clang                             |   1 +
 67 files changed, 2549 insertions(+), 414 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
 create mode 100644 arch/loongarch/include/asm/jump_label.h
 create mode 100644 arch/loongarch/include/asm/qspinlock.h
 create mode 100644 arch/loongarch/include/asm/suspend.h
 create mode 100644 arch/loongarch/include/asm/uprobes.h
 create mode 100644 arch/loongarch/kernel/jump_label.c
 create mode 100644 arch/loongarch/kernel/rethook.c
 create mode 100644 arch/loongarch/kernel/rethook.h
 rename arch/loongarch/kernel/{kprobes_trampoline.S => rethook_trampoline.S} (93%)
 create mode 100644 arch/loongarch/kernel/uprobes.c
