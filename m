Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B6D4E5B24
	for <lists+linux-arch@lfdr.de>; Wed, 23 Mar 2022 23:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbiCWWRf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Mar 2022 18:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiCWWRe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2022 18:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522D98FE49;
        Wed, 23 Mar 2022 15:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAC31617A4;
        Wed, 23 Mar 2022 22:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29033C340F4;
        Wed, 23 Mar 2022 22:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648073762;
        bh=NzRrbSV92qkWGTDt7v1Eibv5xzgymxnnuLSWmT+BxrQ=;
        h=From:Date:Subject:To:Cc:From;
        b=X5I1IqH1c9nP9OdhwDuRamLBRzVFqHHiHImJj+zeCG8n1EFMlSirzb3H1IfagLwHt
         aH0111YRPdW1bMfzHsE3UvbA+gUVdpfbfL0KSDzVtz1rLzXavR9G7/2GqwCNjt96FP
         RBd7eJnnCDNp7RdUwGfFiDKPfE92AhH8cm/i7Oyflg3fJvlPHneUlK/gC7pvmNcmg+
         OP6iC1YQO+8uzT3y1nH1g6BhG5nMtXF7DSt04LLBtUl27uycSVZ08pJy9wa9240XPo
         D6TUWQa1PXQCAU5nr//mlPocAfXuLcHTeDyXE9wchudvku7RzBjfKjwHax1NqmQMDA
         rybP7lizo6bKg==
Received: by mail-wm1-f50.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so6224803wms.1;
        Wed, 23 Mar 2022 15:16:02 -0700 (PDT)
X-Gm-Message-State: AOAM531Ig38u5701ZebM9j51fw3qkl5JdYOPrJ4VfhNOEsz40cbBeXJN
        ikcP9e/LzB0TT2mOoSKtO2thrJC2OpyI4VUA0ss=
X-Google-Smtp-Source: ABdhPJzsl7xnAe9eOe4UnDmgOCHpgeHp74M9UEm6W3KBh5r00zpvLoQBdNQYNVJXey/rlrbKoP5n/iJC3mOyQ3GTO+Y=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr11366222wmc.94.1648073760164; Wed, 23
 Mar 2022 15:16:00 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 23 Mar 2022 23:15:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0DeZ4Gx6fOqLkjmA7kNYW5ZHq8BUpWTXXdqdtxcHRNLg@mail.gmail.com>
Message-ID: <CAK8P3a0DeZ4Gx6fOqLkjmA7kNYW5ZHq8BUpWTXXdqdtxcHRNLg@mail.gmail.com>
Subject: [GIT PULL] asm-generic updates for 5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.18

for you to fetch changes up to aec499c75cf8e0b599be4d559e6922b613085f8f:

  nds32: Remove the architecture (2022-03-07 13:54:59 +0100)

----------------------------------------------------------------
asm-generic updates for 5.18

There are three sets of updates for 5.18 in the asm-generic tree:

 - The set_fs()/get_fs() infrastructure gets removed for good. This
   was already gone from all major architectures, but now we can
   finally remove it everywhere, which loses some particularly
   tricky and error-prone code.
   There is a small merge conflict against a parisc cleanup, the
   solution is to use their new version.

 - The nds32 architecture ends its tenure in the Linux kernel. The
   hardware is still used and the code is in reasonable shape, but
   the mainline port is not actively maintained any more, as all
   remaining users are thought to run vendor kernels that would never
   be updated to a future release.
   There are some obvious conflicts against changes to the removed
   files.

 - A series from Masahiro Yamada cleans up some of the uapi header
   files to pass the compile-time checks.

----------------------------------------------------------------
Alan Kao (1):
      nds32: Remove the architecture

Arnd Bergmann (21):
      uaccess: fix integer overflow on access_ok()
      Merge branch 'asm-generic-compile-test' into asm-generic
      sparc64: fix building assembly files
      uaccess: fix nios2 and microblaze get_user_8()
      nds32: fix access_ok() checks in get/put_user
      sparc64: add __{get,put}_kernel_nofault()
      x86: remove __range_not_ok()
      x86: use more conventional access_ok() definition
      nios2: drop access_ok() check from __put_user()
      uaccess: add generic __{get,put}_kernel_nofault
      MIPS: use simpler access_ok()
      m68k: fix access_ok for coldfire
      arm64: simplify access_ok()
      uaccess: fix type mismatch warnings from access_ok()
      uaccess: generalize access_ok()
      lib/test_lockup: fix kernel pointer check for separate address spaces
      sparc64: remove CONFIG_SET_FS support
      sh: remove CONFIG_SET_FS support
      ia64: remove CONFIG_SET_FS support
      uaccess: remove CONFIG_SET_FS
      Merge branch 'set_fs-4' of
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic into
asm-generic

Masahiro Yamada (6):
      signal.h: add linux/signal.h and asm/signal.h to UAPI
compile-test coverage
      shmbuf.h: add asm/shmbuf.h to UAPI compile-test coverage
      android/binder.h: add linux/android/binder(fs).h to UAPI
compile-test coverage
      fsmap.h: add linux/fsmap.h to UAPI compile-test coverage
      kexec.h: add linux/kexec.h to UAPI compile-test coverage
      reiserfs_xattr.h: add linux/reiserfs_xattr.h to UAPI compile-test coverage

Thomas Bogendoerfer (1):
      MIPS: Handle address errors for accesses above CPU max virtual
user address

 .../interrupt-controller/andestech,ativic32.txt    |   19 -
 .../devicetree/bindings/nds32/andestech-boards     |   40 -
 Documentation/devicetree/bindings/nds32/atl2c.txt  |   28 -
 Documentation/devicetree/bindings/nds32/cpus.txt   |   38 -
 .../devicetree/bindings/perf/nds32v3-pmu.txt       |   17 -
 .../bindings/timer/andestech,atcpit100-timer.txt   |   33 -
 .../features/core/cBPF-JIT/arch-support.txt        |    1 -
 .../features/core/eBPF-JIT/arch-support.txt        |    1 -
 .../core/generic-idle-thread/arch-support.txt      |    1 -
 .../features/core/jump-labels/arch-support.txt     |    1 -
 .../core/thread-info-in-task/arch-support.txt      |    1 -
 .../features/core/tracehook/arch-support.txt       |    1 -
 .../features/debug/KASAN/arch-support.txt          |    1 -
 .../debug/debug-vm-pgtable/arch-support.txt        |    1 -
 .../debug/gcov-profile-all/arch-support.txt        |    1 -
 Documentation/features/debug/kcov/arch-support.txt |    1 -
 Documentation/features/debug/kgdb/arch-support.txt |    1 -
 .../features/debug/kmemleak/arch-support.txt       |    1 -
 .../debug/kprobes-on-ftrace/arch-support.txt       |    1 -
 .../features/debug/kprobes/arch-support.txt        |    1 -
 .../features/debug/kretprobes/arch-support.txt     |    1 -
 .../features/debug/optprobes/arch-support.txt      |    1 -
 .../features/debug/stackprotector/arch-support.txt |    1 -
 .../features/debug/uprobes/arch-support.txt        |    1 -
 .../debug/user-ret-profiler/arch-support.txt       |    1 -
 .../features/io/dma-contiguous/arch-support.txt    |    1 -
 .../locking/cmpxchg-local/arch-support.txt         |    1 -
 .../features/locking/lockdep/arch-support.txt      |    1 -
 .../locking/queued-rwlocks/arch-support.txt        |    1 -
 .../locking/queued-spinlocks/arch-support.txt      |    1 -
 .../features/perf/kprobes-event/arch-support.txt   |    1 -
 .../features/perf/perf-regs/arch-support.txt       |    1 -
 .../features/perf/perf-stackdump/arch-support.txt  |    1 -
 .../sched/membarrier-sync-core/arch-support.txt    |    1 -
 .../features/sched/numa-balancing/arch-support.txt |    1 -
 .../seccomp/seccomp-filter/arch-support.txt        |    1 -
 .../time/arch-tick-broadcast/arch-support.txt      |    1 -
 .../features/time/clockevents/arch-support.txt     |    1 -
 .../time/context-tracking/arch-support.txt         |    1 -
 .../features/time/irq-time-acct/arch-support.txt   |    1 -
 .../features/time/virt-cpuacct/arch-support.txt    |    1 -
 .../features/vm/ELF-ASLR/arch-support.txt          |    1 -
 .../features/vm/PG_uncached/arch-support.txt       |    1 -
 Documentation/features/vm/THP/arch-support.txt     |    1 -
 Documentation/features/vm/TLB/arch-support.txt     |    1 -
 .../features/vm/huge-vmap/arch-support.txt         |    1 -
 .../features/vm/ioremap_prot/arch-support.txt      |    1 -
 .../features/vm/pte_special/arch-support.txt       |    1 -
 MAINTAINERS                                        |   12 -
 arch/Kconfig                                       |   10 +-
 arch/alpha/Kconfig                                 |    1 -
 arch/alpha/include/asm/processor.h                 |    4 -
 arch/alpha/include/asm/thread_info.h               |    2 -
 arch/alpha/include/asm/uaccess.h                   |   53 +-
 arch/alpha/include/uapi/asm/signal.h               |    2 +-
 arch/arc/Kconfig                                   |    1 -
 arch/arc/include/asm/segment.h                     |   20 -
 arch/arc/include/asm/thread_info.h                 |    3 -
 arch/arc/include/asm/uaccess.h                     |   30 -
 arch/arc/kernel/process.c                          |    2 +-
 arch/arm/include/asm/uaccess.h                     |   22 +-
 arch/arm/include/uapi/asm/signal.h                 |    2 +-
 arch/arm/kernel/swp_emulate.c                      |    2 +-
 arch/arm/kernel/traps.c                            |    2 +-
 arch/arm/lib/uaccess_with_memcpy.c                 |   10 -
 arch/arm64/include/asm/uaccess.h                   |   29 +-
 arch/arm64/kernel/traps.c                          |    2 +-
 arch/csky/Kconfig                                  |    1 -
 arch/csky/include/asm/processor.h                  |    2 -
 arch/csky/include/asm/segment.h                    |   10 -
 arch/csky/include/asm/thread_info.h                |    2 -
 arch/csky/include/asm/uaccess.h                    |   12 -
 arch/csky/kernel/asm-offsets.c                     |    1 -
 arch/csky/kernel/perf_callchain.c                  |    2 +-
 arch/csky/kernel/signal.c                          |    2 +-
 arch/h8300/Kconfig                                 |    1 -
 arch/h8300/include/asm/processor.h                 |    1 -
 arch/h8300/include/asm/segment.h                   |   40 -
 arch/h8300/include/asm/thread_info.h               |    3 -
 arch/h8300/include/uapi/asm/signal.h               |    2 +-
 arch/h8300/kernel/entry.S                          |    1 -
 arch/h8300/kernel/head_ram.S                       |    1 -
 arch/h8300/mm/init.c                               |    6 -
 arch/h8300/mm/memory.c                             |    1 -
 arch/hexagon/Kconfig                               |    1 -
 arch/hexagon/include/asm/thread_info.h             |    6 -
 arch/hexagon/include/asm/uaccess.h                 |   25 -
 arch/hexagon/kernel/process.c                      |    1 -
 arch/ia64/Kconfig                                  |    1 -
 arch/ia64/include/asm/processor.h                  |    4 -
 arch/ia64/include/asm/thread_info.h                |    2 -
 arch/ia64/include/asm/uaccess.h                    |   26 +-
 arch/ia64/include/uapi/asm/signal.h                |    2 +-
 arch/ia64/kernel/unaligned.c                       |   60 +-
 arch/m68k/Kconfig.cpu                              |    1 +
 arch/m68k/include/asm/uaccess.h                    |   14 +-
 arch/m68k/include/uapi/asm/signal.h                |    2 +-
 arch/microblaze/Kconfig                            |    1 -
 arch/microblaze/include/asm/thread_info.h          |    6 -
 arch/microblaze/include/asm/uaccess.h              |   61 +-
 arch/microblaze/kernel/asm-offsets.c               |    1 -
 arch/microblaze/kernel/process.c                   |    1 -
 arch/mips/include/asm/uaccess.h                    |   49 +-
 arch/mips/include/uapi/asm/shmbuf.h                |    7 +-
 arch/mips/include/uapi/asm/signal.h                |    2 +-
 arch/mips/kernel/unaligned.c                       |   17 +
 arch/nds32/Kbuild                                  |    4 -
 arch/nds32/Kconfig                                 |  102 --
 arch/nds32/Kconfig.cpu                             |  218 ---
 arch/nds32/Kconfig.debug                           |    2 -
 arch/nds32/Makefile                                |   63 -
 arch/nds32/boot/.gitignore                         |    2 -
 arch/nds32/boot/Makefile                           |   16 -
 arch/nds32/boot/dts/Makefile                       |    2 -
 arch/nds32/boot/dts/ae3xx.dts                      |   90 --
 arch/nds32/configs/defconfig                       |  104 --
 arch/nds32/include/asm/Kbuild                      |    8 -
 arch/nds32/include/asm/assembler.h                 |   39 -
 arch/nds32/include/asm/barrier.h                   |   15 -
 arch/nds32/include/asm/bitfield.h                  |  985 -------------
 arch/nds32/include/asm/cache.h                     |   12 -
 arch/nds32/include/asm/cache_info.h                |   13 -
 arch/nds32/include/asm/cacheflush.h                |   53 -
 arch/nds32/include/asm/current.h                   |   12 -
 arch/nds32/include/asm/delay.h                     |   39 -
 arch/nds32/include/asm/elf.h                       |  180 ---
 arch/nds32/include/asm/fixmap.h                    |   29 -
 arch/nds32/include/asm/fpu.h                       |  126 --
 arch/nds32/include/asm/fpuemu.h                    |   44 -
 arch/nds32/include/asm/ftrace.h                    |   46 -
 arch/nds32/include/asm/futex.h                     |  101 --
 arch/nds32/include/asm/highmem.h                   |   65 -
 arch/nds32/include/asm/io.h                        |   84 --
 arch/nds32/include/asm/irqflags.h                  |   41 -
 arch/nds32/include/asm/l2_cache.h                  |  137 --
 arch/nds32/include/asm/linkage.h                   |   11 -
 arch/nds32/include/asm/memory.h                    |   91 --
 arch/nds32/include/asm/mmu.h                       |   12 -
 arch/nds32/include/asm/mmu_context.h               |   62 -
 arch/nds32/include/asm/nds32.h                     |   82 --
 arch/nds32/include/asm/nds32_fpu_inst.h            |  109 --
 arch/nds32/include/asm/page.h                      |   64 -
 arch/nds32/include/asm/perf_event.h                |   16 -
 arch/nds32/include/asm/pgalloc.h                   |   62 -
 arch/nds32/include/asm/pgtable.h                   |  377 -----
 arch/nds32/include/asm/pmu.h                       |  386 -----
 arch/nds32/include/asm/proc-fns.h                  |   44 -
 arch/nds32/include/asm/processor.h                 |  104 --
 arch/nds32/include/asm/ptrace.h                    |   77 -
 arch/nds32/include/asm/sfp-machine.h               |  158 ---
 arch/nds32/include/asm/shmparam.h                  |   19 -
 arch/nds32/include/asm/stacktrace.h                |   39 -
 arch/nds32/include/asm/string.h                    |   17 -
 arch/nds32/include/asm/suspend.h                   |   11 -
 arch/nds32/include/asm/swab.h                      |   35 -
 arch/nds32/include/asm/syscall.h                   |  142 --
 arch/nds32/include/asm/syscalls.h                  |   14 -
 arch/nds32/include/asm/thread_info.h               |   76 -
 arch/nds32/include/asm/tlb.h                       |   11 -
 arch/nds32/include/asm/tlbflush.h                  |   46 -
 arch/nds32/include/asm/uaccess.h                   |  286 ----
 arch/nds32/include/asm/unistd.h                    |    6 -
 arch/nds32/include/asm/vdso.h                      |   24 -
 arch/nds32/include/asm/vdso_datapage.h             |   37 -
 arch/nds32/include/asm/vdso_timer_info.h           |   14 -
 arch/nds32/include/asm/vermagic.h                  |    9 -
 arch/nds32/include/asm/vmalloc.h                   |    4 -
 arch/nds32/include/uapi/asm/Kbuild                 |    2 -
 arch/nds32/include/uapi/asm/auxvec.h               |   19 -
 arch/nds32/include/uapi/asm/byteorder.h            |   13 -
 arch/nds32/include/uapi/asm/cachectl.h             |   14 -
 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h       |   16 -
 arch/nds32/include/uapi/asm/param.h                |   11 -
 arch/nds32/include/uapi/asm/ptrace.h               |   25 -
 arch/nds32/include/uapi/asm/sigcontext.h           |   84 --
 arch/nds32/include/uapi/asm/unistd.h               |   16 -
 arch/nds32/kernel/.gitignore                       |    2 -
 arch/nds32/kernel/Makefile                         |   33 -
 arch/nds32/kernel/asm-offsets.c                    |   28 -
 arch/nds32/kernel/atl2c.c                          |   65 -
 arch/nds32/kernel/cacheinfo.c                      |   49 -
 arch/nds32/kernel/devtree.c                        |   19 -
 arch/nds32/kernel/dma.c                            |   82 --
 arch/nds32/kernel/ex-entry.S                       |  177 ---
 arch/nds32/kernel/ex-exit.S                        |  193 ---
 arch/nds32/kernel/ex-scall.S                       |  100 --
 arch/nds32/kernel/fpu.c                            |  266 ----
 arch/nds32/kernel/ftrace.c                         |  278 ----
 arch/nds32/kernel/head.S                           |  197 ---
 arch/nds32/kernel/irq.c                            |    9 -
 arch/nds32/kernel/module.c                         |  278 ----
 arch/nds32/kernel/nds32_ksyms.c                    |   25 -
 arch/nds32/kernel/perf_event_cpu.c                 | 1500 --------------------
 arch/nds32/kernel/pm.c                             |   80 --
 arch/nds32/kernel/process.c                        |  257 ----
 arch/nds32/kernel/ptrace.c                         |  118 --
 arch/nds32/kernel/setup.c                          |  369 -----
 arch/nds32/kernel/signal.c                         |  384 -----
 arch/nds32/kernel/sleep.S                          |  131 --
 arch/nds32/kernel/stacktrace.c                     |   53 -
 arch/nds32/kernel/sys_nds32.c                      |   84 --
 arch/nds32/kernel/syscall_table.c                  |   17 -
 arch/nds32/kernel/time.c                           |   11 -
 arch/nds32/kernel/traps.c                          |  354 -----
 arch/nds32/kernel/vdso.c                           |  231 ---
 arch/nds32/kernel/vdso/.gitignore                  |    2 -
 arch/nds32/kernel/vdso/Makefile                    |   79 --
 arch/nds32/kernel/vdso/datapage.S                  |   21 -
 arch/nds32/kernel/vdso/gen_vdso_offsets.sh         |   15 -
 arch/nds32/kernel/vdso/gettimeofday.c              |  269 ----
 arch/nds32/kernel/vdso/note.S                      |   11 -
 arch/nds32/kernel/vdso/sigreturn.S                 |   19 -
 arch/nds32/kernel/vdso/vdso.S                      |   18 -
 arch/nds32/kernel/vdso/vdso.lds.S                  |   75 -
 arch/nds32/kernel/vmlinux.lds.S                    |   70 -
 arch/nds32/lib/Makefile                            |    4 -
 arch/nds32/lib/clear_user.S                        |   42 -
 arch/nds32/lib/copy_from_user.S                    |   45 -
 arch/nds32/lib/copy_page.S                         |   40 -
 arch/nds32/lib/copy_template.S                     |   69 -
 arch/nds32/lib/copy_to_user.S                      |   45 -
 arch/nds32/lib/memcpy.S                            |   30 -
 arch/nds32/lib/memmove.S                           |   70 -
 arch/nds32/lib/memset.S                            |   33 -
 arch/nds32/lib/memzero.S                           |   18 -
 arch/nds32/math-emu/Makefile                       |   10 -
 arch/nds32/math-emu/faddd.c                        |   24 -
 arch/nds32/math-emu/fadds.c                        |   24 -
 arch/nds32/math-emu/fcmpd.c                        |   24 -
 arch/nds32/math-emu/fcmps.c                        |   24 -
 arch/nds32/math-emu/fd2s.c                         |   22 -
 arch/nds32/math-emu/fd2si.c                        |   30 -
 arch/nds32/math-emu/fd2siz.c                       |   30 -
 arch/nds32/math-emu/fd2ui.c                        |   30 -
 arch/nds32/math-emu/fd2uiz.c                       |   30 -
 arch/nds32/math-emu/fdivd.c                        |   27 -
 arch/nds32/math-emu/fdivs.c                        |   26 -
 arch/nds32/math-emu/fmuld.c                        |   23 -
 arch/nds32/math-emu/fmuls.c                        |   23 -
 arch/nds32/math-emu/fnegd.c                        |   21 -
 arch/nds32/math-emu/fnegs.c                        |   21 -
 arch/nds32/math-emu/fpuemu.c                       |  406 ------
 arch/nds32/math-emu/fs2d.c                         |   23 -
 arch/nds32/math-emu/fs2si.c                        |   29 -
 arch/nds32/math-emu/fs2siz.c                       |   29 -
 arch/nds32/math-emu/fs2ui.c                        |   29 -
 arch/nds32/math-emu/fs2uiz.c                       |   30 -
 arch/nds32/math-emu/fsi2d.c                        |   22 -
 arch/nds32/math-emu/fsi2s.c                        |   22 -
 arch/nds32/math-emu/fsqrtd.c                       |   21 -
 arch/nds32/math-emu/fsqrts.c                       |   21 -
 arch/nds32/math-emu/fsubd.c                        |   27 -
 arch/nds32/math-emu/fsubs.c                        |   27 -
 arch/nds32/math-emu/fui2d.c                        |   22 -
 arch/nds32/math-emu/fui2s.c                        |   22 -
 arch/nds32/mm/Makefile                             |   10 -
 arch/nds32/mm/alignment.c                          |  578 --------
 arch/nds32/mm/cacheflush.c                         |  338 -----
 arch/nds32/mm/extable.c                            |   16 -
 arch/nds32/mm/fault.c                              |  396 ------
 arch/nds32/mm/init.c                               |  263 ----
 arch/nds32/mm/mm-nds32.c                           |   96 --
 arch/nds32/mm/mmap.c                               |   73 -
 arch/nds32/mm/proc.c                               |  536 -------
 arch/nds32/mm/tlb.c                                |   50 -
 arch/nios2/Kconfig                                 |    1 -
 arch/nios2/include/asm/thread_info.h               |    9 -
 arch/nios2/include/asm/uaccess.h                   |  105 +-
 arch/nios2/kernel/signal.c                         |   20 +-
 arch/openrisc/Kconfig                              |    1 -
 arch/openrisc/include/asm/thread_info.h            |    7 -
 arch/openrisc/include/asm/uaccess.h                |   42 +-
 arch/parisc/Kconfig                                |    1 +
 arch/parisc/include/asm/futex.h                    |    6 -
 arch/parisc/include/asm/uaccess.h                  |   13 +-
 arch/parisc/include/uapi/asm/shmbuf.h              |    2 +
 arch/parisc/include/uapi/asm/signal.h              |    2 +-
 arch/parisc/kernel/signal.c                        |    4 +-
 arch/parisc/lib/memcpy.c                           |    2 +-
 arch/powerpc/include/asm/uaccess.h                 |   13 +-
 arch/powerpc/include/uapi/asm/shmbuf.h             |    5 +-
 arch/powerpc/include/uapi/asm/signal.h             |    2 +-
 arch/powerpc/lib/sstep.c                           |    4 +-
 arch/riscv/include/asm/uaccess.h                   |   33 +-
 arch/riscv/kernel/perf_callchain.c                 |    4 +-
 arch/s390/Kconfig                                  |    1 +
 arch/s390/include/asm/uaccess.h                    |   16 +-
 arch/s390/include/uapi/asm/signal.h                |    2 +-
 arch/sh/Kconfig                                    |    1 -
 arch/sh/include/asm/processor.h                    |    1 -
 arch/sh/include/asm/segment.h                      |   33 -
 arch/sh/include/asm/thread_info.h                  |    2 -
 arch/sh/include/asm/uaccess.h                      |   24 +-
 arch/sh/kernel/io_trapped.c                        |    9 +-
 arch/sh/kernel/process_32.c                        |    2 -
 arch/sh/kernel/traps_32.c                          |   30 +-
 arch/sparc/Kconfig                                 |    2 +-
 arch/sparc/include/asm/processor_32.h              |    6 -
 arch/sparc/include/asm/processor_64.h              |    4 -
 arch/sparc/include/asm/switch_to_64.h              |    4 +-
 arch/sparc/include/asm/thread_info_64.h            |    4 +-
 arch/sparc/include/asm/uaccess.h                   |    3 -
 arch/sparc/include/asm/uaccess_32.h                |   31 +-
 arch/sparc/include/asm/uaccess_64.h                |  106 +-
 arch/sparc/include/uapi/asm/shmbuf.h               |    5 +-
 arch/sparc/include/uapi/asm/signal.h               |    3 +-
 arch/sparc/kernel/process_32.c                     |    2 -
 arch/sparc/kernel/process_64.c                     |   12 -
 arch/sparc/kernel/signal_32.c                      |    2 +-
 arch/sparc/kernel/traps_64.c                       |    2 -
 arch/sparc/lib/NGmemcpy.S                          |    3 +-
 arch/sparc/mm/init_64.c                            |    7 +-
 arch/um/include/asm/uaccess.h                      |    7 +-
 arch/x86/events/core.c                             |    2 +-
 arch/x86/include/asm/uaccess.h                     |   35 +-
 arch/x86/include/uapi/asm/shmbuf.h                 |    6 +-
 arch/x86/include/uapi/asm/signal.h                 |    2 +-
 arch/x86/kernel/dumpstack.c                        |    6 -
 arch/x86/kernel/stacktrace.c                       |    2 +-
 arch/x86/lib/usercopy.c                            |    2 +-
 arch/xtensa/Kconfig                                |    1 -
 arch/xtensa/include/asm/asm-uaccess.h              |   71 -
 arch/xtensa/include/asm/processor.h                |    7 -
 arch/xtensa/include/asm/thread_info.h              |    3 -
 arch/xtensa/include/asm/uaccess.h                  |   26 +-
 arch/xtensa/include/uapi/asm/shmbuf.h              |    5 +-
 arch/xtensa/include/uapi/asm/signal.h              |    2 +-
 arch/xtensa/kernel/asm-offsets.c                   |    3 -
 drivers/clocksource/Kconfig                        |    9 -
 drivers/clocksource/Makefile                       |    1 -
 drivers/clocksource/timer-atcpit100.c              |  266 ----
 drivers/hid/uhid.c                                 |    2 +-
 drivers/irqchip/Makefile                           |    1 -
 drivers/irqchip/irq-ativic32.c                     |  156 --
 drivers/net/ethernet/faraday/Kconfig               |   12 +-
 drivers/scsi/sg.c                                  |    5 -
 drivers/video/console/Kconfig                      |    2 +-
 fs/exec.c                                          |    6 -
 include/asm-generic/access_ok.h                    |   48 +
 include/asm-generic/uaccess.h                      |   46 +-
 include/linux/syscalls.h                           |    4 -
 include/linux/uaccess.h                            |   59 +-
 include/rdma/ib.h                                  |    2 +-
 include/uapi/asm-generic/shmbuf.h                  |    4 +-
 include/uapi/asm-generic/signal.h                  |    2 +-
 include/uapi/linux/android/binder.h                |    4 +-
 include/uapi/linux/fsmap.h                         |    2 +-
 include/uapi/linux/kexec.h                         |    4 +-
 include/uapi/linux/reiserfs_xattr.h                |    2 +-
 kernel/events/callchain.c                          |    4 -
 kernel/events/core.c                               |    3 -
 kernel/exit.c                                      |   14 -
 kernel/kthread.c                                   |    5 -
 kernel/stacktrace.c                                |    3 -
 kernel/trace/bpf_trace.c                           |    4 -
 lib/strncpy_from_user.c                            |    2 +-
 lib/strnlen_user.c                                 |    2 +-
 lib/test_lockup.c                                  |   11 +-
 mm/maccess.c                                       |  119 --
 mm/memory.c                                        |    8 -
 net/bpfilter/bpfilter_kern.c                       |    2 +-
 scripts/recordmcount.pl                            |    3 -
 tools/include/asm/barrier.h                        |    2 -
 tools/perf/arch/nds32/Build                        |    1 -
 tools/perf/arch/nds32/util/Build                   |    1 -
 tools/perf/arch/nds32/util/header.c                |   29 -
 tools/testing/selftests/vDSO/vdso_config.h         |    4 -
 usr/include/Makefile                               |    8 -
 368 files changed, 436 insertions(+), 17120 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
 delete mode 100644 Documentation/devicetree/bindings/nds32/andestech-boards
 delete mode 100644 Documentation/devicetree/bindings/nds32/atl2c.txt
 delete mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
 delete mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
 delete mode 100644
Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
 delete mode 100644 arch/arc/include/asm/segment.h
 delete mode 100644 arch/csky/include/asm/segment.h
 delete mode 100644 arch/h8300/include/asm/segment.h
 delete mode 100644 arch/nds32/Kbuild
 delete mode 100644 arch/nds32/Kconfig
 delete mode 100644 arch/nds32/Kconfig.cpu
 delete mode 100644 arch/nds32/Kconfig.debug
 delete mode 100644 arch/nds32/Makefile
 delete mode 100644 arch/nds32/boot/.gitignore
 delete mode 100644 arch/nds32/boot/Makefile
 delete mode 100644 arch/nds32/boot/dts/Makefile
 delete mode 100644 arch/nds32/boot/dts/ae3xx.dts
 delete mode 100644 arch/nds32/configs/defconfig
 delete mode 100644 arch/nds32/include/asm/Kbuild
 delete mode 100644 arch/nds32/include/asm/assembler.h
 delete mode 100644 arch/nds32/include/asm/barrier.h
 delete mode 100644 arch/nds32/include/asm/bitfield.h
 delete mode 100644 arch/nds32/include/asm/cache.h
 delete mode 100644 arch/nds32/include/asm/cache_info.h
 delete mode 100644 arch/nds32/include/asm/cacheflush.h
 delete mode 100644 arch/nds32/include/asm/current.h
 delete mode 100644 arch/nds32/include/asm/delay.h
 delete mode 100644 arch/nds32/include/asm/elf.h
 delete mode 100644 arch/nds32/include/asm/fixmap.h
 delete mode 100644 arch/nds32/include/asm/fpu.h
 delete mode 100644 arch/nds32/include/asm/fpuemu.h
 delete mode 100644 arch/nds32/include/asm/ftrace.h
 delete mode 100644 arch/nds32/include/asm/futex.h
 delete mode 100644 arch/nds32/include/asm/highmem.h
 delete mode 100644 arch/nds32/include/asm/io.h
 delete mode 100644 arch/nds32/include/asm/irqflags.h
 delete mode 100644 arch/nds32/include/asm/l2_cache.h
 delete mode 100644 arch/nds32/include/asm/linkage.h
 delete mode 100644 arch/nds32/include/asm/memory.h
 delete mode 100644 arch/nds32/include/asm/mmu.h
 delete mode 100644 arch/nds32/include/asm/mmu_context.h
 delete mode 100644 arch/nds32/include/asm/nds32.h
 delete mode 100644 arch/nds32/include/asm/nds32_fpu_inst.h
 delete mode 100644 arch/nds32/include/asm/page.h
 delete mode 100644 arch/nds32/include/asm/perf_event.h
 delete mode 100644 arch/nds32/include/asm/pgalloc.h
 delete mode 100644 arch/nds32/include/asm/pgtable.h
 delete mode 100644 arch/nds32/include/asm/pmu.h
 delete mode 100644 arch/nds32/include/asm/proc-fns.h
 delete mode 100644 arch/nds32/include/asm/processor.h
 delete mode 100644 arch/nds32/include/asm/ptrace.h
 delete mode 100644 arch/nds32/include/asm/sfp-machine.h
 delete mode 100644 arch/nds32/include/asm/shmparam.h
 delete mode 100644 arch/nds32/include/asm/stacktrace.h
 delete mode 100644 arch/nds32/include/asm/string.h
 delete mode 100644 arch/nds32/include/asm/suspend.h
 delete mode 100644 arch/nds32/include/asm/swab.h
 delete mode 100644 arch/nds32/include/asm/syscall.h
 delete mode 100644 arch/nds32/include/asm/syscalls.h
 delete mode 100644 arch/nds32/include/asm/thread_info.h
 delete mode 100644 arch/nds32/include/asm/tlb.h
 delete mode 100644 arch/nds32/include/asm/tlbflush.h
 delete mode 100644 arch/nds32/include/asm/uaccess.h
 delete mode 100644 arch/nds32/include/asm/unistd.h
 delete mode 100644 arch/nds32/include/asm/vdso.h
 delete mode 100644 arch/nds32/include/asm/vdso_datapage.h
 delete mode 100644 arch/nds32/include/asm/vdso_timer_info.h
 delete mode 100644 arch/nds32/include/asm/vermagic.h
 delete mode 100644 arch/nds32/include/asm/vmalloc.h
 delete mode 100644 arch/nds32/include/uapi/asm/Kbuild
 delete mode 100644 arch/nds32/include/uapi/asm/auxvec.h
 delete mode 100644 arch/nds32/include/uapi/asm/byteorder.h
 delete mode 100644 arch/nds32/include/uapi/asm/cachectl.h
 delete mode 100644 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h
 delete mode 100644 arch/nds32/include/uapi/asm/param.h
 delete mode 100644 arch/nds32/include/uapi/asm/ptrace.h
 delete mode 100644 arch/nds32/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/nds32/include/uapi/asm/unistd.h
 delete mode 100644 arch/nds32/kernel/.gitignore
 delete mode 100644 arch/nds32/kernel/Makefile
 delete mode 100644 arch/nds32/kernel/asm-offsets.c
 delete mode 100644 arch/nds32/kernel/atl2c.c
 delete mode 100644 arch/nds32/kernel/cacheinfo.c
 delete mode 100644 arch/nds32/kernel/devtree.c
 delete mode 100644 arch/nds32/kernel/dma.c
 delete mode 100644 arch/nds32/kernel/ex-entry.S
 delete mode 100644 arch/nds32/kernel/ex-exit.S
 delete mode 100644 arch/nds32/kernel/ex-scall.S
 delete mode 100644 arch/nds32/kernel/fpu.c
 delete mode 100644 arch/nds32/kernel/ftrace.c
 delete mode 100644 arch/nds32/kernel/head.S
 delete mode 100644 arch/nds32/kernel/irq.c
 delete mode 100644 arch/nds32/kernel/module.c
 delete mode 100644 arch/nds32/kernel/nds32_ksyms.c
 delete mode 100644 arch/nds32/kernel/perf_event_cpu.c
 delete mode 100644 arch/nds32/kernel/pm.c
 delete mode 100644 arch/nds32/kernel/process.c
 delete mode 100644 arch/nds32/kernel/ptrace.c
 delete mode 100644 arch/nds32/kernel/setup.c
 delete mode 100644 arch/nds32/kernel/signal.c
 delete mode 100644 arch/nds32/kernel/sleep.S
 delete mode 100644 arch/nds32/kernel/stacktrace.c
 delete mode 100644 arch/nds32/kernel/sys_nds32.c
 delete mode 100644 arch/nds32/kernel/syscall_table.c
 delete mode 100644 arch/nds32/kernel/time.c
 delete mode 100644 arch/nds32/kernel/traps.c
 delete mode 100644 arch/nds32/kernel/vdso.c
 delete mode 100644 arch/nds32/kernel/vdso/.gitignore
 delete mode 100644 arch/nds32/kernel/vdso/Makefile
 delete mode 100644 arch/nds32/kernel/vdso/datapage.S
 delete mode 100755 arch/nds32/kernel/vdso/gen_vdso_offsets.sh
 delete mode 100644 arch/nds32/kernel/vdso/gettimeofday.c
 delete mode 100644 arch/nds32/kernel/vdso/note.S
 delete mode 100644 arch/nds32/kernel/vdso/sigreturn.S
 delete mode 100644 arch/nds32/kernel/vdso/vdso.S
 delete mode 100644 arch/nds32/kernel/vdso/vdso.lds.S
 delete mode 100644 arch/nds32/kernel/vmlinux.lds.S
 delete mode 100644 arch/nds32/lib/Makefile
 delete mode 100644 arch/nds32/lib/clear_user.S
 delete mode 100644 arch/nds32/lib/copy_from_user.S
 delete mode 100644 arch/nds32/lib/copy_page.S
 delete mode 100644 arch/nds32/lib/copy_template.S
 delete mode 100644 arch/nds32/lib/copy_to_user.S
 delete mode 100644 arch/nds32/lib/memcpy.S
 delete mode 100644 arch/nds32/lib/memmove.S
 delete mode 100644 arch/nds32/lib/memset.S
 delete mode 100644 arch/nds32/lib/memzero.S
 delete mode 100644 arch/nds32/math-emu/Makefile
 delete mode 100644 arch/nds32/math-emu/faddd.c
 delete mode 100644 arch/nds32/math-emu/fadds.c
 delete mode 100644 arch/nds32/math-emu/fcmpd.c
 delete mode 100644 arch/nds32/math-emu/fcmps.c
 delete mode 100644 arch/nds32/math-emu/fd2s.c
 delete mode 100644 arch/nds32/math-emu/fd2si.c
 delete mode 100644 arch/nds32/math-emu/fd2siz.c
 delete mode 100644 arch/nds32/math-emu/fd2ui.c
 delete mode 100644 arch/nds32/math-emu/fd2uiz.c
 delete mode 100644 arch/nds32/math-emu/fdivd.c
 delete mode 100644 arch/nds32/math-emu/fdivs.c
 delete mode 100644 arch/nds32/math-emu/fmuld.c
 delete mode 100644 arch/nds32/math-emu/fmuls.c
 delete mode 100644 arch/nds32/math-emu/fnegd.c
 delete mode 100644 arch/nds32/math-emu/fnegs.c
 delete mode 100644 arch/nds32/math-emu/fpuemu.c
 delete mode 100644 arch/nds32/math-emu/fs2d.c
 delete mode 100644 arch/nds32/math-emu/fs2si.c
 delete mode 100644 arch/nds32/math-emu/fs2siz.c
 delete mode 100644 arch/nds32/math-emu/fs2ui.c
 delete mode 100644 arch/nds32/math-emu/fs2uiz.c
 delete mode 100644 arch/nds32/math-emu/fsi2d.c
 delete mode 100644 arch/nds32/math-emu/fsi2s.c
 delete mode 100644 arch/nds32/math-emu/fsqrtd.c
 delete mode 100644 arch/nds32/math-emu/fsqrts.c
 delete mode 100644 arch/nds32/math-emu/fsubd.c
 delete mode 100644 arch/nds32/math-emu/fsubs.c
 delete mode 100644 arch/nds32/math-emu/fui2d.c
 delete mode 100644 arch/nds32/math-emu/fui2s.c
 delete mode 100644 arch/nds32/mm/Makefile
 delete mode 100644 arch/nds32/mm/alignment.c
 delete mode 100644 arch/nds32/mm/cacheflush.c
 delete mode 100644 arch/nds32/mm/extable.c
 delete mode 100644 arch/nds32/mm/fault.c
 delete mode 100644 arch/nds32/mm/init.c
 delete mode 100644 arch/nds32/mm/mm-nds32.c
 delete mode 100644 arch/nds32/mm/mmap.c
 delete mode 100644 arch/nds32/mm/proc.c
 delete mode 100644 arch/nds32/mm/tlb.c
 delete mode 100644 arch/sh/include/asm/segment.h
 delete mode 100644 drivers/clocksource/timer-atcpit100.c
 delete mode 100644 drivers/irqchip/irq-ativic32.c
 create mode 100644 include/asm-generic/access_ok.h
 delete mode 100644 tools/perf/arch/nds32/Build
 delete mode 100644 tools/perf/arch/nds32/util/Build
 delete mode 100644 tools/perf/arch/nds32/util/header.c
