Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961FE70BDFF
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjEVM06 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjEVM0d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:26:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F5E51BF4;
        Mon, 22 May 2023 05:24:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1E5B11FB;
        Mon, 22 May 2023 05:25:20 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40BD63F59C;
        Mon, 22 May 2023 05:24:34 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 00/26] locking/atomic: restructuring + kerneldoc
Date:   Mon, 22 May 2023 13:24:03 +0100
Message-Id: <20230522122429.1915021-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

These patches restructure the generated atomic headers, and add
kerneldoc comments for all of the generic atomic{,64,_long}_t
operations. This is intended to supersede Paul's earlier attempt:

  https://lore.kernel.org/lkml/19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop/

The core headers now generate raw_atomic*() operations as the
fundamental instrumentation-safe atomics, with the arch_atomic*()
functions being an implementation detail that shouldn't be used
directly.

Each raw_atomic*() op is given a single definition with all related
ifdeffery inside, e.g.

| /**
|  * raw_atomic_inc_return_acquire() - atomic increment with acquire ordering
|  * @v: pointer to atomic_t
|  *
|  * Atomically updates @v to (@v + 1) with acquire ordering.
|  *
|  * Safe to use in noinstr code; prefer atomic_inc_return_acquire() elsewhere.
|  *
|  * Return: the new value of @v.
|  */
| static __always_inline int
| raw_atomic_inc_return_acquire(atomic_t *v)
| {
| #if defined(arch_atomic_inc_return_acquire)
| 	return arch_atomic_inc_return_acquire(v);
| #elif defined(arch_atomic_inc_return_relaxed)
| 	int ret = arch_atomic_inc_return_relaxed(v);
| 	__atomic_acquire_fence();
| 	return ret;
| #elif defined(arch_atomic_inc_return)
| 	return arch_atomic_inc_return(v);
| #else
| 	return raw_atomic_add_return_acquire(1, v);
| #endif
| }

Similarly, the regular atomic*() ops (which already have a single
definition) are given kerneldoc comments, e.g.

| /**
|  * atomic_inc_return_acquire() - atomic increment with acquire ordering
|  * @v: pointer to atomic_t
|  *
|  * Atomically updates @v to (@v + 1) with acquire ordering.
|  *
|  * Unsafe to use in noinstr code; use raw_atomic_inc_return_acquire() there.
|  *
|  * Return: the new value of @v.
|  */
| static __always_inline int
| atomic_inc_return_acquire(atomic_t *v)
| {
| 	instrument_atomic_read_write(v, sizeof(*v));
| 	return raw_atomic_inc_return_acquire(v);
| }

The kerneldoc comments themselves are built from templates as with the
fallbacks, which should allow them to be extended in future if necessary.

I've compile-tested this for a number of architectures and
configurations, but as usual this probably needs to see some testing by
build robots.

The patches are based on the tip tree's locking/core branch,
specifically commit:

  3cf363a4daf359e8 ("s390/cpum_sf: Convert to cmpxchg128()")

Thanks,
Mark.

Mark Rutland (25):
  locking/atomic: arm: fix sync ops
  locking/atomic: remove fallback comments
  locking/atomic: hexagon: remove redundant arch_atomic_cmpxchg
  locking/atomic: make atomic*_{cmp,}xchg optional
  locking/atomic: arc: add preprocessor symbols
  locking/atomic: arm: add preprocessor symbols
  locking/atomic: hexagon: add preprocessor symbols
  locking/atomic: m68k: add preprocessor symbols
  locking/atomic: parisc: add preprocessor symbols
  locking/atomic: sh: add preprocessor symbols
  locking/atomic: sparc: add preprocessor symbols
  locking/atomic: x86: add preprocessor symbols
  locking/atomic: xtensa: add preprocessor symbols
  locking/atomic: scripts: remove bogus order parameter
  locking/atomic: scripts: remove leftover "${mult}"
  locking/atomic: scripts: factor out order template generation
  locking/atomic: scripts: add trivial raw_atomic*_<op>()
  locking/atomic: treewide: use raw_atomic*_<op>()
  locking/atomic: scripts: build raw_atomic_long*() directly
  locking/atomic: scripts: restructure fallback ifdeffery
  locking/atomic: scripts: split pfx/name/sfx/order
  locking/atomic: scripts: simplify raw_atomic_long*() definitions
  locking/atomic: scripts: simplify raw_atomic*() definitions
  locking/atomic: scripts: generate kerneldoc comments
  locking/atomic: treewide: delete arch_atomic_*() kerneldoc

Paul E. McKenney (1):
  locking/atomic: docs: Add atomic operations to the driver basic API
    documentation

 Documentation/driver-api/basics.rst          |    5 +-
 arch/alpha/include/asm/atomic.h              |   35 -
 arch/arc/include/asm/atomic-spinlock.h       |    9 +
 arch/arc/include/asm/atomic.h                |   24 -
 arch/arc/include/asm/atomic64-arcv2.h        |   19 +-
 arch/arm/include/asm/assembler.h             |   17 +
 arch/arm/include/asm/atomic.h                |   15 +-
 arch/arm/include/asm/sync_bitops.h           |   29 +-
 arch/arm/lib/bitops.h                        |   14 +-
 arch/arm/lib/testchangebit.S                 |    4 +
 arch/arm/lib/testclearbit.S                  |    4 +
 arch/arm/lib/testsetbit.S                    |    4 +
 arch/arm64/include/asm/atomic.h              |   28 -
 arch/csky/include/asm/atomic.h               |   35 -
 arch/hexagon/include/asm/atomic.h            |   69 +-
 arch/ia64/include/asm/atomic.h               |    7 -
 arch/loongarch/include/asm/atomic.h          |   56 -
 arch/m68k/include/asm/atomic.h               |   18 +-
 arch/mips/include/asm/atomic.h               |   11 -
 arch/openrisc/include/asm/atomic.h           |    3 -
 arch/parisc/include/asm/atomic.h             |   27 +-
 arch/powerpc/include/asm/atomic.h            |   24 -
 arch/powerpc/kernel/smp.c                    |   12 +-
 arch/riscv/include/asm/atomic.h              |   72 -
 arch/sh/include/asm/atomic-grb.h             |    9 +
 arch/sh/include/asm/atomic-irq.h             |    9 +
 arch/sh/include/asm/atomic-llsc.h            |    9 +
 arch/sh/include/asm/atomic.h                 |    3 -
 arch/sparc/include/asm/atomic_32.h           |   18 +-
 arch/sparc/include/asm/atomic_64.h           |   29 +-
 arch/x86/include/asm/atomic.h                |   87 -
 arch/x86/include/asm/atomic64_32.h           |   76 -
 arch/x86/include/asm/atomic64_64.h           |   81 -
 arch/x86/include/asm/cmpxchg_64.h            |    4 +
 arch/x86/kernel/alternative.c                |    4 +-
 arch/x86/kernel/cpu/mce/core.c               |   16 +-
 arch/x86/kernel/nmi.c                        |    2 +-
 arch/x86/kernel/pvclock.c                    |    4 +-
 arch/x86/kvm/x86.c                           |    2 +-
 arch/xtensa/include/asm/atomic.h             |   12 +-
 include/asm-generic/atomic.h                 |    3 -
 include/asm-generic/bitops/atomic.h          |   12 +-
 include/asm-generic/bitops/lock.h            |    8 +-
 include/linux/atomic/atomic-arch-fallback.h  | 5200 ++++++++++++------
 include/linux/atomic/atomic-instrumented.h   | 3484 ++++++++++--
 include/linux/atomic/atomic-long.h           | 2122 ++++---
 include/linux/context_tracking.h             |    4 +-
 include/linux/context_tracking_state.h       |    2 +-
 include/linux/cpumask.h                      |    2 +-
 include/linux/jump_label.h                   |    2 +-
 kernel/context_tracking.c                    |   12 +-
 kernel/sched/clock.c                         |    2 +-
 scripts/atomic/atomic-tbl.sh                 |  112 +-
 scripts/atomic/atomics.tbl                   |    2 +-
 scripts/atomic/fallbacks/acquire             |    4 -
 scripts/atomic/fallbacks/add_negative        |   14 +-
 scripts/atomic/fallbacks/add_unless          |   15 +-
 scripts/atomic/fallbacks/andnot              |    6 +-
 scripts/atomic/fallbacks/cmpxchg             |    3 +
 scripts/atomic/fallbacks/dec                 |    6 +-
 scripts/atomic/fallbacks/dec_and_test        |   14 +-
 scripts/atomic/fallbacks/dec_if_positive     |    8 +-
 scripts/atomic/fallbacks/dec_unless_positive |    8 +-
 scripts/atomic/fallbacks/fence               |    4 -
 scripts/atomic/fallbacks/fetch_add_unless    |   17 +-
 scripts/atomic/fallbacks/inc                 |    6 +-
 scripts/atomic/fallbacks/inc_and_test        |   14 +-
 scripts/atomic/fallbacks/inc_not_zero        |   13 +-
 scripts/atomic/fallbacks/inc_unless_negative |    8 +-
 scripts/atomic/fallbacks/read_acquire        |    6 +-
 scripts/atomic/fallbacks/release             |    4 -
 scripts/atomic/fallbacks/set_release         |    6 +-
 scripts/atomic/fallbacks/sub_and_test        |   15 +-
 scripts/atomic/fallbacks/try_cmpxchg         |    6 +-
 scripts/atomic/fallbacks/xchg                |    3 +
 scripts/atomic/gen-atomic-fallback.sh        |  264 +-
 scripts/atomic/gen-atomic-instrumented.sh    |   23 +-
 scripts/atomic/gen-atomic-long.sh            |   38 +-
 scripts/atomic/kerneldoc/add                 |   13 +
 scripts/atomic/kerneldoc/add_negative        |   13 +
 scripts/atomic/kerneldoc/add_unless          |   18 +
 scripts/atomic/kerneldoc/and                 |   13 +
 scripts/atomic/kerneldoc/andnot              |   13 +
 scripts/atomic/kerneldoc/cmpxchg             |   14 +
 scripts/atomic/kerneldoc/dec                 |   12 +
 scripts/atomic/kerneldoc/dec_and_test        |   12 +
 scripts/atomic/kerneldoc/dec_if_positive     |   12 +
 scripts/atomic/kerneldoc/dec_unless_positive |   12 +
 scripts/atomic/kerneldoc/inc                 |   12 +
 scripts/atomic/kerneldoc/inc_and_test        |   12 +
 scripts/atomic/kerneldoc/inc_not_zero        |   12 +
 scripts/atomic/kerneldoc/inc_unless_negative |   12 +
 scripts/atomic/kerneldoc/or                  |   13 +
 scripts/atomic/kerneldoc/read                |   12 +
 scripts/atomic/kerneldoc/set                 |   13 +
 scripts/atomic/kerneldoc/sub                 |   13 +
 scripts/atomic/kerneldoc/sub_and_test        |   13 +
 scripts/atomic/kerneldoc/try_cmpxchg         |   15 +
 scripts/atomic/kerneldoc/xchg                |   13 +
 scripts/atomic/kerneldoc/xor                 |   13 +
 100 files changed, 8975 insertions(+), 3688 deletions(-)
 create mode 100755 scripts/atomic/fallbacks/cmpxchg
 create mode 100755 scripts/atomic/fallbacks/xchg
 create mode 100644 scripts/atomic/kerneldoc/add
 create mode 100644 scripts/atomic/kerneldoc/add_negative
 create mode 100644 scripts/atomic/kerneldoc/add_unless
 create mode 100644 scripts/atomic/kerneldoc/and
 create mode 100644 scripts/atomic/kerneldoc/andnot
 create mode 100644 scripts/atomic/kerneldoc/cmpxchg
 create mode 100644 scripts/atomic/kerneldoc/dec
 create mode 100644 scripts/atomic/kerneldoc/dec_and_test
 create mode 100644 scripts/atomic/kerneldoc/dec_if_positive
 create mode 100644 scripts/atomic/kerneldoc/dec_unless_positive
 create mode 100644 scripts/atomic/kerneldoc/inc
 create mode 100644 scripts/atomic/kerneldoc/inc_and_test
 create mode 100644 scripts/atomic/kerneldoc/inc_not_zero
 create mode 100644 scripts/atomic/kerneldoc/inc_unless_negative
 create mode 100644 scripts/atomic/kerneldoc/or
 create mode 100644 scripts/atomic/kerneldoc/read
 create mode 100644 scripts/atomic/kerneldoc/set
 create mode 100644 scripts/atomic/kerneldoc/sub
 create mode 100644 scripts/atomic/kerneldoc/sub_and_test
 create mode 100644 scripts/atomic/kerneldoc/try_cmpxchg
 create mode 100644 scripts/atomic/kerneldoc/xchg
 create mode 100644 scripts/atomic/kerneldoc/xor

-- 
2.30.2

