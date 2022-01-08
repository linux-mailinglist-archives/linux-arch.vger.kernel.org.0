Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2E5488490
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiAHQoT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAHQoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71EC06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED0B60C33
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33981C36AE0;
        Sat,  8 Jan 2022 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660257;
        bh=FcO7EcnRgQppJrQtVRCzUZV2lgnwvJHnM2p8OenS9kg=;
        h=From:To:Cc:Subject:Date:From;
        b=eqdSx/HffFr6QDgFrKwXqR1bWkDrWKxJxF6N0O4d8zrWgE2DY0I8I+etDxA9XFkRm
         V6egOsq56trx1RDi5zzDMTHjVy0sPEYai10KkKWVXAvU5J9UjhEPZ7p72xEtXtFaUD
         Pduya0kFNA0XhKSOAF8vZ1QrjViD1dUjzqu1uBmTB44vUDyJZCwKIl8Jvt7V0BQ3A8
         VHyTLhGuXC36FR8DG/mgP5v6YoToH8sKs9gig0GR90Iq7735Q6KfU37bNOi1t7mT9i
         TP/7jXtQyNRZ9gLhgJdIgtLNy01kzji4ftVVFZ1D3MXJYyH5QqmPT6bdi/I4AK5qeP
         z2nNVIJQT676Q==
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 00/23] mm, sched: Rework lazy mm handling
Date:   Sat,  8 Jan 2022 08:43:45 -0800
Message-Id: <cover.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all-

Sorry I've been sitting on this so long.  I think it's in decent shape, it
has no *known* bugs, and I think it's time to get the show on the road.
This series needs more eyeballs, too.

The overall point of this series is to get rid of the scalability
problems with mm_count, and my goal is to solve it once and for all,
for all architectures, in a way that doesn't have any gotchas for
unwary users of ->active_mm.

Most of this series is just cleanup, though.  mmgrab(), mmdrop(), and
->active_mm are a mess.  A number of ->active_mm users are simply
wrong.  kthread lazy mm handling is inconsistent with user thread lazy
mm handling (by accident, as far as I can tell).  And membarrier()
relies on the barrier semantics of mmdrop() and mmgrab(), such that
anything that gets rid of those barriers risks breaking membarrier().
x86 is sometimes non-lazy when the core thinks it's lazy because the
core mm code didn't offer any mechanism by which x86 could tell the core
that it's exiting lazy mode.

So most of this series is just cleanup.  Bogus users of ->active_mm
are fixed, and membarrier() is reworked so that its barriers are
explicit instead of depending on mmdrop() and mmgrab().  x86 lazy
handling is extensively tidied up, and x86's EFI mm code gets tidied
up a bit too.  I think I've done this all in a way that introduces
little or no overhead.


Additionally, all the code paths that change current->mm are consolidated
so that there is only one path to start using an mm and only one path
to stop using it.

Once that's done, the actual meat (the hazard pointers) isn't so bad, and
the x86 optimization on top that should eliminate scanning of remote CPUs
in __mmput() is about two lines of code.  Other architectures with
sufficiently accurate mm_cpumask() tracking should be able to do the same
thing.

akpm, this is intended to mostly replace Nick Piggin's lazy shootdown
series.  This series implements lazy shootdown on x86 implicitly, and
powerpc should be able to do the same thing in just a couple lines
of code if it wants to.  The result is IMO much cleaner and more
maintainable.

Once this is all reviewed, I'm hoping it can go in -tip (and -next) after
the merge window or go in -mm.  This is not intended for v5.16.  I suspect
-tip is easier in case other arch maintainers want to optimize their
code in the same release.

Andy Lutomirski (23):
  membarrier: Document why membarrier() works
  x86/mm: Handle unlazying membarrier core sync in the arch code
  membarrier: Remove membarrier_arch_switch_mm() prototype in core code
  membarrier: Make the post-switch-mm barrier explicit
  membarrier, kthread: Use _ONCE accessors for task->mm
  powerpc/membarrier: Remove special barrier on mm switch
  membarrier: Rewrite sync_core_before_usermode() and improve
    documentation
  membarrier: Remove redundant clear of mm->membarrier_state in
    exec_mmap()
  membarrier: Fix incorrect barrier positions during exec and
    kthread_use_mm()
  x86/events, x86/insn-eval: Remove incorrect active_mm references
  sched/scs: Initialize shadow stack on idle thread bringup, not
    shutdown
  Rework "sched/core: Fix illegal RCU from offline CPUs"
  exec: Remove unnecessary vmacache_seqnum clear in exec_mmap()
  sched, exec: Factor current mm changes out from exec
  kthread: Switch to __change_current_mm()
  sched: Use lightweight hazard pointers to grab lazy mms
  x86/mm: Make use/unuse_temporary_mm() non-static
  x86/mm: Allow temporary mms when IRQs are on
  x86/efi: Make efi_enter/leave_mm use the temporary_mm machinery
  x86/mm: Remove leave_mm() in favor of unlazy_mm_irqs_off()
  x86/mm: Use unlazy_mm_irqs_off() in TLB flush IPIs
  x86/mm: Optimize for_each_possible_lazymm_cpu()
  x86/mm: Opt in to IRQs-off activate_mm()

 .../membarrier-sync-core/arch-support.txt     |  69 +--
 arch/arm/include/asm/membarrier.h             |  21 +
 arch/arm/kernel/smp.c                         |   2 -
 arch/arm64/include/asm/membarrier.h           |  19 +
 arch/arm64/kernel/smp.c                       |   2 -
 arch/csky/kernel/smp.c                        |   2 -
 arch/ia64/kernel/process.c                    |   1 -
 arch/mips/cavium-octeon/smp.c                 |   1 -
 arch/mips/kernel/smp-bmips.c                  |   2 -
 arch/mips/kernel/smp-cps.c                    |   1 -
 arch/mips/loongson64/smp.c                    |   2 -
 arch/powerpc/include/asm/membarrier.h         |  28 +-
 arch/powerpc/mm/mmu_context.c                 |   1 -
 arch/powerpc/platforms/85xx/smp.c             |   2 -
 arch/powerpc/platforms/powermac/smp.c         |   2 -
 arch/powerpc/platforms/powernv/smp.c          |   1 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c  |   2 -
 arch/powerpc/platforms/pseries/pmem.c         |   1 -
 arch/riscv/kernel/cpu-hotplug.c               |   2 -
 arch/s390/kernel/smp.c                        |   1 -
 arch/sh/kernel/smp.c                          |   1 -
 arch/sparc/kernel/smp_64.c                    |   2 -
 arch/x86/Kconfig                              |   2 +-
 arch/x86/events/core.c                        |   9 +-
 arch/x86/include/asm/membarrier.h             |  25 ++
 arch/x86/include/asm/mmu.h                    |   6 +-
 arch/x86/include/asm/mmu_context.h            |  15 +-
 arch/x86/include/asm/sync_core.h              |  20 -
 arch/x86/kernel/alternative.c                 |  67 +--
 arch/x86/kernel/cpu/mce/core.c                |   2 +-
 arch/x86/kernel/smpboot.c                     |   2 -
 arch/x86/lib/insn-eval.c                      |  13 +-
 arch/x86/mm/tlb.c                             | 155 +++++--
 arch/x86/platform/efi/efi_64.c                |   9 +-
 arch/x86/xen/mmu_pv.c                         |   2 +-
 arch/xtensa/kernel/smp.c                      |   1 -
 drivers/cpuidle/cpuidle.c                     |   2 +-
 drivers/idle/intel_idle.c                     |   4 +-
 drivers/misc/sgi-gru/grufault.c               |   2 +-
 drivers/misc/sgi-gru/gruhandles.c             |   2 +-
 drivers/misc/sgi-gru/grukservices.c           |   2 +-
 fs/exec.c                                     |  28 +-
 include/linux/mmu_context.h                   |   4 +-
 include/linux/sched/hotplug.h                 |   6 -
 include/linux/sched/mm.h                      |  58 ++-
 include/linux/sync_core.h                     |  21 -
 init/Kconfig                                  |   3 -
 kernel/cpu.c                                  |  21 +-
 kernel/exit.c                                 |   2 +-
 kernel/fork.c                                 |  11 +
 kernel/kthread.c                              |  50 +--
 kernel/sched/core.c                           | 409 +++++++++++++++---
 kernel/sched/idle.c                           |   1 +
 kernel/sched/membarrier.c                     |  97 ++++-
 kernel/sched/sched.h                          |  11 +-
 55 files changed, 745 insertions(+), 482 deletions(-)
 create mode 100644 arch/arm/include/asm/membarrier.h
 create mode 100644 arch/arm64/include/asm/membarrier.h
 create mode 100644 arch/x86/include/asm/membarrier.h
 delete mode 100644 include/linux/sync_core.h

-- 
2.33.1

