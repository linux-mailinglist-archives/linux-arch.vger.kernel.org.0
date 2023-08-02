Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CB76D3F8
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHBQrm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjHBQrl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124EAF7;
        Wed,  2 Aug 2023 09:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1BCC61A17;
        Wed,  2 Aug 2023 16:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EA2C433C8;
        Wed,  2 Aug 2023 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690994859;
        bh=/E+ZGNf7pqyE0N/8dyCERPNM856MwrVOubxqVk9vle8=;
        h=From:To:Cc:Subject:Date:From;
        b=aTRQEZyLEEFhULSFcqWRYjeiiGA2A8GNkdIqJ3ALr2x+rdIYtoU1KonuYLocPcy6U
         l5s1xoa+OpJicL7QpwvnZtMCTdq/d/gY/ibAEsURfsRqksHD/U3Ydjuw3+luC3DZ0k
         zfW/Zue9mnQg1+NWxF9Fw8fa7iuktrHWA0VIJ8GR9sxAyWYq98875IC6apemRs4vg5
         3lpvlSmk/0aAeJFUb8LXQu+xkf4PtKjhDrZUIK5F6HlYxCkhy50DX/Z8WWRWL6Smyu
         sb3s+38tdE9Z+4v5GYb2V/MlcoppdHvadpmJTB+aDrMOIAOlYzk5z2VJa1ea4zYY6I
         AeKYa7Eh6c+wA==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V10 00/19] riscv: Add Native/Paravirt/CNA qspinlock support
Date:   Wed,  2 Aug 2023 12:46:42 -0400
Message-Id: <20230802164701.192791-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Hello everyone,

I'm back after one year. This is the tenth version of riscv qspinlock.

patch[1 - 8]: Native qspinlock
patch[9 -17]: Paravirt qspinlock
patch[18-19]: Compact NUMA-awared (CNA) qspinlock

This series based on Andrew Jones' pv-time patches and Alex Kogan's CNA
qspinlock patches. I merge them into sg2042-master branch, then you could
directly try it:

https://github.com/guoren83/linux/tree/qspinlock_v10_pvlock_cna_qspinlock_v15

Use sophgo_mango_ubuntu_defconfig for sg2042 64 cores board.

Native qspinlock
================

This time we've proved the qspinlock on th1520 [1] & sg2042 [2], which
gives stability and performance improvement. All T-HEAD processors have
a strong LR/SC forward progress guarantee than the requirements of the
ISA, which could satisfy the xchg_tail of native_qspinlock. Now,
qspinlock has been run with us for more than 1 year, and we have enough
confidence to enable it for all the T-HEAD processors. Of causes, we
found a livelock problem with the qspinlock lock torture test from the
CPU store merge buffer delay mechanism, which caused the queued spinlock
becomes a dead ring and RCU warning to come out. We introduce a custom
WRITE_ONCE to solve this. Do we need explicit ISA instruction to signal
it? Or let hardware handle this.

We've tested the patch on SOPHGO sg2042 & th1520 and passed the stress
test on Fedora & Ubuntu & OpenEuler ... Here is the performance
comparison between qspinlock and ticket_lock on sg2042 (64 cores):

sysbench test=threads threads=32 yields=100 lock=8 (+13.8%):
  queued_spinlock 0.5109/0.00
  ticket_spinlock 0.5814/0.00

perf futex/hash (+6.7%):
  queued_spinlock 1444393 operations/sec (+- 0.09%)
  ticket_spinlock 1353215 operations/sec (+- 0.15%)

perf futex/wake-parallel (+8.6%):
  queued_spinlock (waking 1/64 threads) in 0.0253 ms (+-2.90%)
  ticket_spinlock (waking 1/64 threads) in 0.0275 ms (+-3.12%)

perf futex/requeue (+4.2%):
  queued_spinlock Requeued 64 of 64 threads in 0.0785 ms (+-0.55%)
  ticket_spinlock Requeued 64 of 64 threads in 0.0818 ms (+-4.12%)

System Benchmarks (+6.4%)
  queued_spinlock:
    System Benchmarks Index Values               BASELINE       RESULT    INDEX
    Dhrystone 2 using register variables         116700.0  628613745.4  53865.8
    Double-Precision Whetstone                       55.0     182422.8  33167.8
    Execl Throughput                                 43.0      13116.6   3050.4
    File Copy 1024 bufsize 2000 maxblocks          3960.0    7762306.2  19601.8
    File Copy 256 bufsize 500 maxblocks            1655.0    3417556.8  20649.9
    File Copy 4096 bufsize 8000 maxblocks          5800.0    7427995.7  12806.9
    Pipe Throughput                               12440.0   23058600.5  18535.9
    Pipe-based Context Switching                   4000.0    2835617.7   7089.0
    Process Creation                                126.0      12537.3    995.0
    Shell Scripts (1 concurrent)                     42.4      57057.4  13456.9
    Shell Scripts (8 concurrent)                      6.0       7367.1  12278.5
    System Call Overhead                          15000.0   33308301.3  22205.5
                                                                       ========
    System Benchmarks Index Score                                       12426.1

  ticket_spinlock:
    System Benchmarks Index Values               BASELINE       RESULT    INDEX
    Dhrystone 2 using register variables         116700.0  626541701.9  53688.2
    Double-Precision Whetstone                       55.0     181921.0  33076.5
    Execl Throughput                                 43.0      12625.1   2936.1
    File Copy 1024 bufsize 2000 maxblocks          3960.0    6553792.9  16550.0
    File Copy 256 bufsize 500 maxblocks            1655.0    3189231.6  19270.3
    File Copy 4096 bufsize 8000 maxblocks          5800.0    7221277.0  12450.5
    Pipe Throughput                               12440.0   20594018.7  16554.7
    Pipe-based Context Switching                   4000.0    2571117.7   6427.8
    Process Creation                                126.0      10798.4    857.0
    Shell Scripts (1 concurrent)                     42.4      57227.5  13497.1
    Shell Scripts (8 concurrent)                      6.0       7329.2  12215.3
    System Call Overhead                          15000.0   30766778.4  20511.2
                                                                       ========
    System Benchmarks Index Score                                       11670.7

The qspinlock has a significant improvement on SOPHGO SG2042 64
cores platform than the ticket_lock.

Paravirt qspinlock
==================

Based on Andrew Jones' "Add skeleton for pv-time support" patches to unify the
paravirt framework.

We implemented kvm_kick_cpu/kvm_wait_cpu and add tracepoints to observe the
behaviors. Also, introduce a new SBI extension SBI_EXT_PVLOCK (0xAB0401). If the
name and number are approved, I will send a formal proposal to the SBI spec.

Compact NUMA-awared (CNA) qspinlock
===================================

Based on Alex Kogan's "Add NUMA-awareness to qspinlock" patches.

The multi sg2042 chips could compose 2/4 NUMA nodes, and these pathes are the
preparation for the next test. I hope "CNA v.s. native" could have a better
improvement than "qspinlock v.s. ticket_lock." We tested it on sg2042 hardware
with "numa_spinlock=on" to ensure the software is bug-free before the next
multi-nodes hardware comes out.

Changlog:
V10:
 - Using an alternative framework instead of static_key_branch in the
   asm/spinlock.h.
 - Fixup store merge buffer problem, which causes qspinlock lock
   torture test livelock.
 - Add paravirt qspinlock support, include KVM backend
 - Add Compact NUMA-awared qspinlock support 

V9:
https://lore.kernel.org/linux-riscv/20220808071318.3335746-1-guoren@kernel.org/
 - Cleanup generic ticket-lock code, (Using smp_mb__after_spinlock as
   RCsc)
 - Add qspinlock and combo-lock for riscv
 - Add qspinlock to openrisc
 - Use generic header in csky
 - Optimize cmpxchg & atomic code

V8:
https://lore.kernel.org/linux-riscv/20220724122517.1019187-1-guoren@kernel.org/
 - Coding convention ticket fixup
 - Move combo spinlock into riscv and simply asm-generic/spinlock.h
 - Fixup xchg16 with wrong return value
 - Add csky qspinlock
 - Add combo & qspinlock & ticket-lock comparison
 - Clean up unnecessary riscv acquire and release definitions
 - Enable ARCH_INLINE_READ*/WRITE*/SPIN* for riscv & csky

V7:
https://lore.kernel.org/linux-riscv/20220628081946.1999419-1-guoren@kernel.org/
 - Add combo spinlock (ticket & queued) support
 - Rename ticket_spinlock.h
 - Remove unnecessary atomic_read in ticket_spin_value_unlocked  

V6:
https://lore.kernel.org/linux-riscv/20220621144920.2945595-1-guoren@kernel.org/
 - Fixup Clang compile problem Reported-by: kernel test robot
 - Cleanup asm-generic/spinlock.h
 - Remove changelog in patch main comment part, suggested by
   Conor.Dooley
 - Remove "default y if NUMA" in Kconfig

V5:
https://lore.kernel.org/linux-riscv/20220620155404.1968739-1-guoren@kernel.org/
 - Update comment with RISC-V forward guarantee feature.
 - Back to V3 direction and optimize asm code.

V4:
https://lore.kernel.org/linux-riscv/1616868399-82848-4-git-send-email-guoren@kernel.org/
 - Remove custom sub-word xchg implementation
 - Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in locking/qspinlock

V3:
https://lore.kernel.org/linux-riscv/1616658937-82063-1-git-send-email-guoren@kernel.org/
 - Coding convention by Peter Zijlstra's advices

V2:
https://lore.kernel.org/linux-riscv/1606225437-22948-2-git-send-email-guoren@kernel.org/
 - Coding convention in cmpxchg.h
 - Re-implement short xchg
 - Remove char & cmpxchg implementations

V1:
https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/
 - Using cmpxchg loop to implement sub-word atomic

Guo Ren (19):
  asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
  asm-generic: ticket-lock: Move into ticket_spinlock.h
  riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
  riscv: qspinlock: Add basic queued_spinlock support
  riscv: qspinlock: Introduce combo spinlock
  riscv: qspinlock: Allow force qspinlock from the command line
  riscv: qspinlock: errata: Introduce ERRATA_THEAD_QSPINLOCK
  riscv: qspinlock: Use new static key for controlling call of
    virt_spin_lock()
  RISC-V: paravirt: pvqspinlock: Add paravirt qspinlock skeleton
  RISC-V: paravirt: pvqspinlock: KVM: Add paravirt qspinlock skeleton
  RISC-V: paravirt: pvqspinlock: KVM: Implement
    kvm_sbi_ext_pvlock_kick_cpu()
  RISC-V: paravirt: pvqspinlock: Add nopvspin kernel parameter
  RISC-V: paravirt: pvqspinlock: Remove unnecessary definitions of
    cmpxchg & xchg
  RISC-V: paravirt: pvqspinlock: Add xchg8 & cmpxchg_small support
  RISC-V: paravirt: pvqspinlock: Add SBI implementation
  RISC-V: paravirt: pvqspinlock: Add kconfig entry
  RISC-V: paravirt: pvqspinlock: Add trace point for pv_kick/wait
  locking/qspinlock: Move pv_ops into x86 directory
  locking/qspinlock: riscv: Add Compact NUMA-aware lock support

 .../admin-guide/kernel-parameters.txt         |   5 +-
 arch/riscv/Kconfig                            |  54 ++++
 arch/riscv/Kconfig.errata                     |  32 ++
 arch/riscv/errata/thead/errata.c              |  44 +++
 arch/riscv/include/asm/Kbuild                 |   2 +-
 arch/riscv/include/asm/cmpxchg.h              | 286 ++++++++++++------
 arch/riscv/include/asm/cpufeature.h           |   2 +
 arch/riscv/include/asm/errata_list.h          |  33 +-
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/kvm_vcpu_sbi.h         |   1 +
 arch/riscv/include/asm/paravirt.h             |  20 ++
 arch/riscv/include/asm/qspinlock.h            |  34 +++
 arch/riscv/include/asm/qspinlock_paravirt.h   |   7 +
 arch/riscv/include/asm/rwonce.h               |  24 ++
 arch/riscv/include/asm/sbi.h                  |  14 +
 arch/riscv/include/asm/spinlock.h             | 122 ++++++++
 arch/riscv/include/asm/vendorid_list.h        |  15 +
 arch/riscv/include/uapi/asm/kvm.h             |   1 +
 arch/riscv/kernel/cpufeature.c                |  26 ++
 arch/riscv/kernel/paravirt.c                  |  86 ++++++
 arch/riscv/kernel/sbi.c                       |   2 +-
 arch/riscv/kernel/setup.c                     |  22 ++
 .../kernel/trace_events_filter_paravirt.h     |  60 ++++
 arch/riscv/kvm/Makefile                       |   1 +
 arch/riscv/kvm/vcpu_sbi.c                     |   4 +
 arch/riscv/kvm/vcpu_sbi_pvlock.c              |  57 ++++
 arch/x86/include/asm/qspinlock.h              |   3 +-
 arch/x86/kernel/alternative.c                 |   6 +-
 include/asm-generic/rwonce.h                  |   2 +
 include/asm-generic/spinlock.h                |  87 +-----
 include/asm-generic/spinlock_types.h          |  12 +-
 include/asm-generic/ticket_spinlock.h         | 103 +++++++
 kernel/locking/qspinlock_cna.h                |  14 +-
 33 files changed, 971 insertions(+), 211 deletions(-)
 create mode 100644 arch/riscv/include/asm/qspinlock.h
 create mode 100644 arch/riscv/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/riscv/include/asm/rwonce.h
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 arch/riscv/kernel/trace_events_filter_paravirt.h
 create mode 100644 arch/riscv/kvm/vcpu_sbi_pvlock.c
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.36.1

