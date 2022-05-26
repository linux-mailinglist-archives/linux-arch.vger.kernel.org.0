Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9653453511D
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbiEZPA1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 May 2022 11:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiEZPA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 May 2022 11:00:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7E68FA1;
        Thu, 26 May 2022 08:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64758B820FF;
        Thu, 26 May 2022 15:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A4C34118;
        Thu, 26 May 2022 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653577222;
        bh=Cd/1ZXZJ9qU9gjbOH5AFyWltJq9YKhnw/r6aVSk11Yc=;
        h=From:Date:Subject:To:Cc:From;
        b=fhJDkA1A/wiaIjeGRZROBKH6UmnhlxymGAaDjjRlqmmdecRjsGB/CGsa9b2NO4bcC
         bQ/ikzTNqSWYcN3kcKRCEWN7+T5oSftCd2E116gK4Jr1d0bLV8HJKseu8wvYd0GZBS
         WOTOcZ+0POuepEs8JiF8VIk17YPWsrbr4wIJ+KbOakp5QQlFTu847fDpdE7Kz7zD/2
         2D8J/AYZCNNC72PBv9rEaBPJORnGZJe4jqr9N9pij+Hcl7bGfvnksfJHdEHHakIS9r
         R2Cb2Ple8x305F4sXLudTBhqVCsPDAg3USI7cd9gjVxPk13H6vGTRkhMI0P5Xt7AWH
         sfqukz8eK6BMA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-300beab2b76so17936597b3.13;
        Thu, 26 May 2022 08:00:22 -0700 (PDT)
X-Gm-Message-State: AOAM533arQbtQRnO7Ffi+D4CnAJrjiUcDBuzfShVFI0a+UdagMUc6/qd
        nzkCss7zUe90ijK1H+mMzE8QI2e5xrBlBdF4h+g=
X-Google-Smtp-Source: ABdhPJx7MF2CMqt/1dxzQOfoFXzft69/UYtGxB/8ktADoxOyLWWXp1IHDRXGJk2RZOyvSP/4OIWLo+gCehvEpsF6yHo=
X-Received: by 2002:a81:6283:0:b0:2ff:2443:6f3c with SMTP id
 w125-20020a816283000000b002ff24436f3cmr38823576ywb.135.1653577221037; Thu, 26
 May 2022 08:00:21 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 26 May 2022 17:00:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
Message-ID: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
Subject: [GIT PULL] asm-generic changes for 5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.19

for you to fetch changes up to b2441b3bdce6c02cb96278d98c620d7ba1d41b7b:

  h8300: remove stale bindings and symlink (2022-05-20 22:40:56 +0200)

----------------------------------------------------------------
asm-generic changes for 5.19

The asm-generic tree contains three separate changes for linux-5.19:

- The h8300 architecture is retired after it has been effectively
  unmaintained for a number of years. This is the last architecture we
  supported that has no MMU implementation, but there are still a few
  architectures (arm, m68k, riscv, sh and xtensa) that support CPUs with
  and without an MMU.

- A series to add a generic ticket spinlock that can be shared by most
  architectures with a working cmpxchg or ll/sc type atomic, including
  the conversion of riscv, csky and openrisc. This series is also a
  prerequisite for the loongarch64 architecture port that will come as
  a separate pull request.

- A cleanup of some exported uapi header files to ensure they can be
  included from user space without relying on other kernel headers.

----------------------------------------------------------------
Arnd Bergmann (4):
      Merge branch 'remove-h8300' of
git://git.infradead.org/users/hch/misc into asm-generic
      Merge tag 'generic-ticket-spinlocks-v6' of
git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux into
asm-generic
      Merge branch 'asm-generic-headers-cleanup' into asm-generic
      h8300: remove stale bindings and symlink

Christoph Hellwig (1):
      remove the h8300 architecture

Guo Ren (1):
      csky: Move to generic ticket-spinlock

Masahiro Yamada (6):
      agpgart.h: do not include <stdlib.h> from exported header
      kbuild: prevent exported headers from including <stdlib.h>, <stdbool.h>
      riscv: add linux/bpf_perf_event.h to UAPI compile-test coverage
      mips: add asm/stat.h to UAPI compile-test coverage
      powerpc: add asm/stat.h to UAPI compile-test coverage
      sparc: add asm/stat.h to UAPI compile-test coverage

Palmer Dabbelt (3):
      asm-generic: qrwlock: Document the spinlock fairness requirements
      RISC-V: Move to generic spinlocks
      RISC-V: Move to queued RW locks

Peter Zijlstra (3):
      asm-generic: ticket-lock: New generic ticket-based spinlock
      asm-generic: qspinlock: Indicate the use of mixed-size atomics
      openrisc: Move to ticket-spinlock

 .../bindings/clock/renesas,h8300-div-clock.txt     |  24 --
 .../bindings/clock/renesas,h8s2678-pll-clock.txt   |  23 --
 Documentation/devicetree/bindings/h8300/cpu.txt    |  13 -
 .../interrupt-controller/renesas,h8300h-intc.txt   |  22 --
 .../interrupt-controller/renesas,h8s-intc.txt      |  22 --
 .../memory-controllers/renesas,h8300-bsc.yaml      |  35 --
 .../bindings/timer/renesas,16bit-timer.txt         |  25 --
 .../bindings/timer/renesas,8bit-timer.txt          |  25 --
 .../features/core/cBPF-JIT/arch-support.txt        |   1 -
 .../features/core/eBPF-JIT/arch-support.txt        |   1 -
 .../core/generic-idle-thread/arch-support.txt      |   1 -
 .../features/core/jump-labels/arch-support.txt     |   1 -
 .../core/thread-info-in-task/arch-support.txt      |   1 -
 .../features/core/tracehook/arch-support.txt       |   1 -
 .../features/debug/KASAN/arch-support.txt          |   1 -
 .../debug/debug-vm-pgtable/arch-support.txt        |   1 -
 .../debug/gcov-profile-all/arch-support.txt        |   1 -
 Documentation/features/debug/kcov/arch-support.txt |   1 -
 Documentation/features/debug/kgdb/arch-support.txt |   1 -
 .../features/debug/kmemleak/arch-support.txt       |   1 -
 .../debug/kprobes-on-ftrace/arch-support.txt       |   1 -
 .../features/debug/kprobes/arch-support.txt        |   1 -
 .../features/debug/kretprobes/arch-support.txt     |   1 -
 .../features/debug/optprobes/arch-support.txt      |   1 -
 .../features/debug/stackprotector/arch-support.txt |   1 -
 .../features/debug/uprobes/arch-support.txt        |   1 -
 .../debug/user-ret-profiler/arch-support.txt       |   1 -
 .../features/io/dma-contiguous/arch-support.txt    |   1 -
 .../locking/cmpxchg-local/arch-support.txt         |   1 -
 .../features/locking/lockdep/arch-support.txt      |   1 -
 .../locking/queued-rwlocks/arch-support.txt        |   1 -
 .../locking/queued-spinlocks/arch-support.txt      |   1 -
 .../features/perf/kprobes-event/arch-support.txt   |   1 -
 .../features/perf/perf-regs/arch-support.txt       |   1 -
 .../features/perf/perf-stackdump/arch-support.txt  |   1 -
 .../sched/membarrier-sync-core/arch-support.txt    |   1 -
 .../features/sched/numa-balancing/arch-support.txt |   1 -
 .../seccomp/seccomp-filter/arch-support.txt        |   1 -
 .../time/arch-tick-broadcast/arch-support.txt      |   1 -
 .../features/time/clockevents/arch-support.txt     |   1 -
 .../time/context-tracking/arch-support.txt         |   1 -
 .../features/time/irq-time-acct/arch-support.txt   |   1 -
 .../features/time/virt-cpuacct/arch-support.txt    |   1 -
 .../features/vm/ELF-ASLR/arch-support.txt          |   1 -
 .../features/vm/PG_uncached/arch-support.txt       |   1 -
 Documentation/features/vm/THP/arch-support.txt     |   1 -
 Documentation/features/vm/TLB/arch-support.txt     |   1 -
 .../features/vm/huge-vmap/arch-support.txt         |   1 -
 .../features/vm/ioremap_prot/arch-support.txt      |   1 -
 .../features/vm/pte_special/arch-support.txt       |   1 -
 MAINTAINERS                                        |  11 -
 arch/csky/include/asm/Kbuild                       |   3 +
 arch/csky/include/asm/spinlock.h                   |  89 -----
 arch/csky/include/asm/spinlock_types.h             |  27 --
 arch/h8300/Kbuild                                  |   5 -
 arch/h8300/Kconfig                                 |  49 ---
 arch/h8300/Kconfig.cpu                             |  99 -----
 arch/h8300/Kconfig.debug                           |   2 -
 arch/h8300/Makefile                                |  44 ---
 arch/h8300/boot/Makefile                           |  27 --
 arch/h8300/boot/compressed/Makefile                |  45 ---
 arch/h8300/boot/compressed/head.S                  |  49 ---
 arch/h8300/boot/compressed/misc.c                  |  76 ----
 arch/h8300/boot/compressed/vmlinux.lds             |  35 --
 arch/h8300/boot/compressed/vmlinux.scr             |   9 -
 arch/h8300/boot/dts/Makefile                       |   6 -
 arch/h8300/boot/dts/edosk2674.dts                  | 108 -----
 arch/h8300/boot/dts/h8300h_sim.dts                 |  97 -----
 arch/h8300/boot/dts/h8s_sim.dts                    | 100 -----
 arch/h8300/configs/edosk2674_defconfig             |  48 ---
 arch/h8300/configs/h8300h-sim_defconfig            |  48 ---
 arch/h8300/configs/h8s-sim_defconfig               |  48 ---
 arch/h8300/include/asm/Kbuild                      |   8 -
 arch/h8300/include/asm/bitops.h                    | 179 ---------
 arch/h8300/include/asm/bug.h                       |  13 -
 arch/h8300/include/asm/byteorder.h                 |   7 -
 arch/h8300/include/asm/cache.h                     |  12 -
 arch/h8300/include/asm/elf.h                       | 102 -----
 arch/h8300/include/asm/flat.h                      |  36 --
 arch/h8300/include/asm/hash.h                      |  54 ---
 arch/h8300/include/asm/io.h                        |  67 ----
 arch/h8300/include/asm/irq.h                       |  25 --
 arch/h8300/include/asm/irqflags.h                  |  97 -----
 arch/h8300/include/asm/kgdb.h                      |  45 ---
 arch/h8300/include/asm/mmu_context.h               |   6 -
 arch/h8300/include/asm/page.h                      |  17 -
 arch/h8300/include/asm/page_offset.h               |   2 -
 arch/h8300/include/asm/pgtable.h                   |  43 --
 arch/h8300/include/asm/processor.h                 | 126 ------
 arch/h8300/include/asm/ptrace.h                    |  39 --
 arch/h8300/include/asm/signal.h                    |  23 --
 arch/h8300/include/asm/smp.h                       |   1 -
 arch/h8300/include/asm/string.h                    |  18 -
 arch/h8300/include/asm/switch_to.h                 |  52 ---
 arch/h8300/include/asm/syscall.h                   |  43 --
 arch/h8300/include/asm/thread_info.h               | 102 -----
 arch/h8300/include/asm/tlb.h                       |   7 -
 arch/h8300/include/asm/traps.h                     |  41 --
 arch/h8300/include/asm/user.h                      |  71 ----
 arch/h8300/include/asm/vmalloc.h                   |   4 -
 arch/h8300/include/uapi/asm/Kbuild                 |   2 -
 arch/h8300/include/uapi/asm/byteorder.h            |   7 -
 arch/h8300/include/uapi/asm/posix_types.h          |  13 -
 arch/h8300/include/uapi/asm/ptrace.h               |  43 --
 arch/h8300/include/uapi/asm/sigcontext.h           |  19 -
 arch/h8300/include/uapi/asm/signal.h               |  92 -----
 arch/h8300/include/uapi/asm/unistd.h               |   8 -
 arch/h8300/kernel/.gitignore                       |   2 -
 arch/h8300/kernel/Makefile                         |  22 --
 arch/h8300/kernel/asm-offsets.c                    |  70 ----
 arch/h8300/kernel/entry.S                          | 433 ---------------------
 arch/h8300/kernel/h8300_ksyms.c                    |  35 --
 arch/h8300/kernel/head_ram.S                       |  60 ---
 arch/h8300/kernel/head_rom.S                       | 111 ------
 arch/h8300/kernel/irq.c                            |  99 -----
 arch/h8300/kernel/kgdb.c                           | 135 -------
 arch/h8300/kernel/module.c                         |  71 ----
 arch/h8300/kernel/process.c                        | 173 --------
 arch/h8300/kernel/ptrace.c                         | 199 ----------
 arch/h8300/kernel/ptrace_h.c                       | 256 ------------
 arch/h8300/kernel/ptrace_s.c                       |  44 ---
 arch/h8300/kernel/setup.c                          | 213 ----------
 arch/h8300/kernel/signal.c                         | 287 --------------
 arch/h8300/kernel/sim-console.c                    |  31 --
 arch/h8300/kernel/syscalls.c                       |  15 -
 arch/h8300/kernel/traps.c                          | 156 --------
 arch/h8300/kernel/vmlinux.lds.S                    |  69 ----
 arch/h8300/lib/Makefile                            |   9 -
 arch/h8300/lib/abs.S                               |  21 -
 arch/h8300/lib/ashldi3.c                           |  25 --
 arch/h8300/lib/ashrdi3.c                           |  25 --
 arch/h8300/lib/delay.c                             |  41 --
 arch/h8300/lib/libgcc.h                            |  78 ----
 arch/h8300/lib/lshrdi3.c                           |  24 --
 arch/h8300/lib/memcpy.S                            |  86 ----
 arch/h8300/lib/memset.S                            |  70 ----
 arch/h8300/lib/moddivsi3.S                         |  73 ----
 arch/h8300/lib/modsi3.S                            |  73 ----
 arch/h8300/lib/muldi3.c                            |  45 ---
 arch/h8300/lib/mulsi3.S                            |  39 --
 arch/h8300/lib/ucmpdi2.c                           |  18 -
 arch/h8300/lib/udivsi3.S                           |  77 ----
 arch/h8300/mm/Makefile                             |   6 -
 arch/h8300/mm/fault.c                              |  57 ---
 arch/h8300/mm/init.c                               |  95 -----
 arch/h8300/mm/memory.c                             |  52 ---
 arch/mips/include/uapi/asm/stat.h                  |  20 +-
 arch/openrisc/Kconfig                              |   1 -
 arch/openrisc/include/asm/Kbuild                   |   5 +-
 arch/openrisc/include/asm/spinlock.h               |  27 --
 arch/openrisc/include/asm/spinlock_types.h         |   7 -
 arch/powerpc/include/uapi/asm/stat.h               |  10 +-
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/include/asm/Kbuild                      |   4 +
 arch/riscv/include/asm/spinlock.h                  | 135 -------
 arch/riscv/include/asm/spinlock_types.h            |  25 --
 arch/sparc/include/uapi/asm/stat.h                 |  12 +-
 drivers/clk/Makefile                               |   1 -
 drivers/clk/h8300/Makefile                         |   3 -
 drivers/clk/h8300/clk-div.c                        |  57 ---
 drivers/clk/h8300/clk-h8s2678.c                    | 145 -------
 drivers/clocksource/Kconfig                        |  20 -
 drivers/clocksource/Makefile                       |   3 -
 drivers/clocksource/h8300_timer16.c                | 192 ---------
 drivers/clocksource/h8300_timer8.c                 | 211 ----------
 drivers/clocksource/h8300_tpu.c                    | 158 --------
 drivers/irqchip/Kconfig                            |  11 -
 drivers/irqchip/Makefile                           |   2 -
 drivers/irqchip/irq-renesas-h8300h.c               |  94 -----
 drivers/irqchip/irq-renesas-h8s.c                  | 102 -----
 drivers/net/ethernet/smsc/Kconfig                  |   4 +-
 drivers/net/ethernet/smsc/smc91x.h                 |  11 -
 drivers/tty/serial/Kconfig                         |   5 +-
 include/asm-generic/qrwlock.h                      |   4 +
 include/asm-generic/qspinlock.h                    |  29 ++
 include/asm-generic/spinlock.h                     |  94 ++++-
 include/asm-generic/spinlock_types.h               |  17 +
 include/uapi/linux/agpgart.h                       |   9 +-
 init/Kconfig                                       |   3 +-
 scripts/dtc/include-prefixes/h8300                 |   1 -
 tools/arch/h8300/include/asm/bitsperlong.h         |  15 -
 tools/arch/h8300/include/uapi/asm/mman.h           |   7 -
 usr/dummy-include/stdbool.h                        |   7 +
 usr/dummy-include/stdlib.h                         |   7 +
 usr/include/Makefile                               |  12 +-
 185 files changed, 192 insertions(+), 7354 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt
 delete mode 100644
Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/h8300/cpu.txt
 delete mode 100644
Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
 delete mode 100644
Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt
 delete mode 100644
Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
 delete mode 100644
Documentation/devicetree/bindings/timer/renesas,16bit-timer.txt
 delete mode 100644
Documentation/devicetree/bindings/timer/renesas,8bit-timer.txt
 delete mode 100644 arch/csky/include/asm/spinlock.h
 delete mode 100644 arch/csky/include/asm/spinlock_types.h
 delete mode 100644 arch/h8300/Kbuild
 delete mode 100644 arch/h8300/Kconfig
 delete mode 100644 arch/h8300/Kconfig.cpu
 delete mode 100644 arch/h8300/Kconfig.debug
 delete mode 100644 arch/h8300/Makefile
 delete mode 100644 arch/h8300/boot/Makefile
 delete mode 100644 arch/h8300/boot/compressed/Makefile
 delete mode 100644 arch/h8300/boot/compressed/head.S
 delete mode 100644 arch/h8300/boot/compressed/misc.c
 delete mode 100644 arch/h8300/boot/compressed/vmlinux.lds
 delete mode 100644 arch/h8300/boot/compressed/vmlinux.scr
 delete mode 100644 arch/h8300/boot/dts/Makefile
 delete mode 100644 arch/h8300/boot/dts/edosk2674.dts
 delete mode 100644 arch/h8300/boot/dts/h8300h_sim.dts
 delete mode 100644 arch/h8300/boot/dts/h8s_sim.dts
 delete mode 100644 arch/h8300/configs/edosk2674_defconfig
 delete mode 100644 arch/h8300/configs/h8300h-sim_defconfig
 delete mode 100644 arch/h8300/configs/h8s-sim_defconfig
 delete mode 100644 arch/h8300/include/asm/Kbuild
 delete mode 100644 arch/h8300/include/asm/bitops.h
 delete mode 100644 arch/h8300/include/asm/bug.h
 delete mode 100644 arch/h8300/include/asm/byteorder.h
 delete mode 100644 arch/h8300/include/asm/cache.h
 delete mode 100644 arch/h8300/include/asm/elf.h
 delete mode 100644 arch/h8300/include/asm/flat.h
 delete mode 100644 arch/h8300/include/asm/hash.h
 delete mode 100644 arch/h8300/include/asm/io.h
 delete mode 100644 arch/h8300/include/asm/irq.h
 delete mode 100644 arch/h8300/include/asm/irqflags.h
 delete mode 100644 arch/h8300/include/asm/kgdb.h
 delete mode 100644 arch/h8300/include/asm/mmu_context.h
 delete mode 100644 arch/h8300/include/asm/page.h
 delete mode 100644 arch/h8300/include/asm/page_offset.h
 delete mode 100644 arch/h8300/include/asm/pgtable.h
 delete mode 100644 arch/h8300/include/asm/processor.h
 delete mode 100644 arch/h8300/include/asm/ptrace.h
 delete mode 100644 arch/h8300/include/asm/signal.h
 delete mode 100644 arch/h8300/include/asm/smp.h
 delete mode 100644 arch/h8300/include/asm/string.h
 delete mode 100644 arch/h8300/include/asm/switch_to.h
 delete mode 100644 arch/h8300/include/asm/syscall.h
 delete mode 100644 arch/h8300/include/asm/thread_info.h
 delete mode 100644 arch/h8300/include/asm/tlb.h
 delete mode 100644 arch/h8300/include/asm/traps.h
 delete mode 100644 arch/h8300/include/asm/user.h
 delete mode 100644 arch/h8300/include/asm/vmalloc.h
 delete mode 100644 arch/h8300/include/uapi/asm/Kbuild
 delete mode 100644 arch/h8300/include/uapi/asm/byteorder.h
 delete mode 100644 arch/h8300/include/uapi/asm/posix_types.h
 delete mode 100644 arch/h8300/include/uapi/asm/ptrace.h
 delete mode 100644 arch/h8300/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/h8300/include/uapi/asm/signal.h
 delete mode 100644 arch/h8300/include/uapi/asm/unistd.h
 delete mode 100644 arch/h8300/kernel/.gitignore
 delete mode 100644 arch/h8300/kernel/Makefile
 delete mode 100644 arch/h8300/kernel/asm-offsets.c
 delete mode 100644 arch/h8300/kernel/entry.S
 delete mode 100644 arch/h8300/kernel/h8300_ksyms.c
 delete mode 100644 arch/h8300/kernel/head_ram.S
 delete mode 100644 arch/h8300/kernel/head_rom.S
 delete mode 100644 arch/h8300/kernel/irq.c
 delete mode 100644 arch/h8300/kernel/kgdb.c
 delete mode 100644 arch/h8300/kernel/module.c
 delete mode 100644 arch/h8300/kernel/process.c
 delete mode 100644 arch/h8300/kernel/ptrace.c
 delete mode 100644 arch/h8300/kernel/ptrace_h.c
 delete mode 100644 arch/h8300/kernel/ptrace_s.c
 delete mode 100644 arch/h8300/kernel/setup.c
 delete mode 100644 arch/h8300/kernel/signal.c
 delete mode 100644 arch/h8300/kernel/sim-console.c
 delete mode 100644 arch/h8300/kernel/syscalls.c
 delete mode 100644 arch/h8300/kernel/traps.c
 delete mode 100644 arch/h8300/kernel/vmlinux.lds.S
 delete mode 100644 arch/h8300/lib/Makefile
 delete mode 100644 arch/h8300/lib/abs.S
 delete mode 100644 arch/h8300/lib/ashldi3.c
 delete mode 100644 arch/h8300/lib/ashrdi3.c
 delete mode 100644 arch/h8300/lib/delay.c
 delete mode 100644 arch/h8300/lib/libgcc.h
 delete mode 100644 arch/h8300/lib/lshrdi3.c
 delete mode 100644 arch/h8300/lib/memcpy.S
 delete mode 100644 arch/h8300/lib/memset.S
 delete mode 100644 arch/h8300/lib/moddivsi3.S
 delete mode 100644 arch/h8300/lib/modsi3.S
 delete mode 100644 arch/h8300/lib/muldi3.c
 delete mode 100644 arch/h8300/lib/mulsi3.S
 delete mode 100644 arch/h8300/lib/ucmpdi2.c
 delete mode 100644 arch/h8300/lib/udivsi3.S
 delete mode 100644 arch/h8300/mm/Makefile
 delete mode 100644 arch/h8300/mm/fault.c
 delete mode 100644 arch/h8300/mm/init.c
 delete mode 100644 arch/h8300/mm/memory.c
 delete mode 100644 arch/openrisc/include/asm/spinlock.h
 delete mode 100644 arch/openrisc/include/asm/spinlock_types.h
 delete mode 100644 arch/riscv/include/asm/spinlock.h
 delete mode 100644 arch/riscv/include/asm/spinlock_types.h
 delete mode 100644 drivers/clk/h8300/Makefile
 delete mode 100644 drivers/clk/h8300/clk-div.c
 delete mode 100644 drivers/clk/h8300/clk-h8s2678.c
 delete mode 100644 drivers/clocksource/h8300_timer16.c
 delete mode 100644 drivers/clocksource/h8300_timer8.c
 delete mode 100644 drivers/clocksource/h8300_tpu.c
 delete mode 100644 drivers/irqchip/irq-renesas-h8300h.c
 delete mode 100644 drivers/irqchip/irq-renesas-h8s.c
 create mode 100644 include/asm-generic/spinlock_types.h
 delete mode 120000 scripts/dtc/include-prefixes/h8300
 delete mode 100644 tools/arch/h8300/include/asm/bitsperlong.h
 delete mode 100644 tools/arch/h8300/include/uapi/asm/mman.h
 create mode 100644 usr/dummy-include/stdbool.h
 create mode 100644 usr/dummy-include/stdlib.h
