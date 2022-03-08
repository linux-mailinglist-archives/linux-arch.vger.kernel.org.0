Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1E4D1082
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 07:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiCHGxL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 01:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiCHGxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 01:53:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FDD2A733;
        Mon,  7 Mar 2022 22:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/yKwct0b4ss4FukQegiXNehQmZXPiS+Wk9lmglO2t/c=; b=QnCOI7sadUYOtcjaSgq15cpR1p
        MBWrPcnwEW+hB2ifQNfo4rJUUZtPFdPyMRmrkA8RIrLGcvr7XIVbL3FQhVCHfZPcAGnDZLI0eWlMr
        rGdUHwZ5tYV6HIRXqKAY03LGLmcfr84BGiByWdw6AJrG1rmy8TqMXLztB8uCAJVkUtWgOaXqU5Gut
        9y9j7K/jbpCv9YTlIz618N7TzgJFHPF6WYespFtD1aVFw7fWbycpWS42AmHfyinxpzXBaw2Wc2llC
        gDcOa4IEoJUGh7T7ECHPNIk9AZEXj6NxkZh5Uc6I7QTOg7lej/XtQI5+pHEG8wuFY+IHwcr+KHdah
        iqXLCSHQ==;
Received: from [2001:4bb8:184:7746:6f50:7a98:3141:c37b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRThZ-002y1W-7I; Tue, 08 Mar 2022 06:52:09 +0000
Date:   Tue, 8 Mar 2022 07:52:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [RFC PULL] remove arch/h8300
Message-ID: <Yib9F5SqKda/nH9c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

h8300 hasn't been maintained for quite a while, with even years old
pull request lingering in the old repo.  Given that it always was
rather fringe to start with I'd suggest to go ahead and remove the
port:

The following changes since commit 5c1ee569660d4a205dced9cb4d0306b907fb7599:

  Merge branch 'for-5.17-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2022-02-22 16:14:35 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/misc.git remove-h8300

for you to fetch changes up to 1c4b5ecb7ea190fa3e9f9d6891e6c90b60e04f24:

  remove the h8300 architecture (2022-02-23 08:52:50 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      remove the h8300 architecture

 .../bindings/clock/renesas,h8300-div-clock.txt     |  24 --
 Documentation/devicetree/bindings/h8300/cpu.txt    |  13 -
 .../interrupt-controller/renesas,h8300h-intc.txt   |  22 --
 .../interrupt-controller/renesas,h8s-intc.txt      |  22 --
 .../memory-controllers/renesas,h8300-bsc.yaml      |  35 --
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
 arch/h8300/Kbuild                                  |   5 -
 arch/h8300/Kconfig                                 |  50 ---
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
 arch/h8300/include/asm/processor.h                 | 127 ------
 arch/h8300/include/asm/ptrace.h                    |  39 --
 arch/h8300/include/asm/segment.h                   |  40 --
 arch/h8300/include/asm/signal.h                    |  23 --
 arch/h8300/include/asm/smp.h                       |   1 -
 arch/h8300/include/asm/string.h                    |  18 -
 arch/h8300/include/asm/switch_to.h                 |  52 ---
 arch/h8300/include/asm/syscall.h                   |  43 --
 arch/h8300/include/asm/thread_info.h               | 105 -----
 arch/h8300/include/asm/tlb.h                       |   7 -
 arch/h8300/include/asm/traps.h                     |  41 --
 arch/h8300/include/asm/user.h                      |  75 ----
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
 arch/h8300/kernel/entry.S                          | 434 ---------------------
 arch/h8300/kernel/h8300_ksyms.c                    |  35 --
 arch/h8300/kernel/head_ram.S                       |  61 ---
 arch/h8300/kernel/head_rom.S                       | 111 ------
 arch/h8300/kernel/irq.c                            |  99 -----
 arch/h8300/kernel/kgdb.c                           | 135 -------
 arch/h8300/kernel/module.c                         |  71 ----
 arch/h8300/kernel/process.c                        | 173 --------
 arch/h8300/kernel/ptrace.c                         | 200 ----------
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
 arch/h8300/mm/init.c                               | 101 -----
 arch/h8300/mm/memory.c                             |  53 ---
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
 init/Kconfig                                       |   3 +-
 tools/arch/h8300/include/asm/bitsperlong.h         |  15 -
 tools/arch/h8300/include/uapi/asm/mman.h           |   7 -
 160 files changed, 5 insertions(+), 6981 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,h8300-div-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/h8300/cpu.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,h8300h-intc.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,h8s-intc.txt
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
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
 delete mode 100644 arch/h8300/include/asm/segment.h
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
 delete mode 100644 drivers/clk/h8300/Makefile
 delete mode 100644 drivers/clk/h8300/clk-div.c
 delete mode 100644 drivers/clk/h8300/clk-h8s2678.c
 delete mode 100644 drivers/clocksource/h8300_timer16.c
 delete mode 100644 drivers/clocksource/h8300_timer8.c
 delete mode 100644 drivers/clocksource/h8300_tpu.c
 delete mode 100644 drivers/irqchip/irq-renesas-h8300h.c
 delete mode 100644 drivers/irqchip/irq-renesas-h8s.c
 delete mode 100644 tools/arch/h8300/include/asm/bitsperlong.h
 delete mode 100644 tools/arch/h8300/include/uapi/asm/mman.h
