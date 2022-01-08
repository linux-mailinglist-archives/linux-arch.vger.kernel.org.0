Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635264884A7
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiAHQop (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiAHQok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89339C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29AE760DF0
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698EFC36AEF;
        Sat,  8 Jan 2022 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660279;
        bh=8QnnEAQzxd3ws7BHDkrTxXyGch3lQVCI4n1OHmf5M5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rF8QFsbIMcGBr1U5y8/pXL+EfJa32pzTSdYzFgYmToqPlFUXatWy1M9uUcpbDrtrp
         rVQLt/jBPIa6MBvvg6PqoYgoAQyx0Rf+oZj46edL8T8Pr3Ym4Whr3qbwUqe4TJfhqj
         AVwUVtWniDWr3OBWg0m79jM/ltpdvvkquHwe3kfGCrZH3DTd9CMqRSSpD5xcjWvZ5X
         SA333cy9bQigcr1rl2yd9Awz22kKRUE8zAH2oCCEo2KfrvUHKP/xlisMXdAiG7aNPx
         /KFPTgWlrDy5wmerDdjlXpTHXbguCa+hqj6xGFTiwVoxZy/BS3SAfbW3oVQqFmDvmc
         FmIeHtX3TurPw==
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
Subject: [PATCH 20/23] x86/mm: Remove leave_mm() in favor of unlazy_mm_irqs_off()
Date:   Sat,  8 Jan 2022 08:44:05 -0800
Message-Id: <5e80aa6deb3f0a7bdcba5e9f20c48df50b752fd3.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

x86's mm_cpumask() precisely tracks every CPU using an mm, with one
major caveat: x86 internally switches back to init_mm more
aggressively than the core code.  This means that it's possible for
x86 to point CR3 to init_mm and drop current->active_mm from
mm_cpumask().  The core scheduler doesn't know when this happens,
which is currently fine.

But if we want to use mm_cpumask() to optimize
for_each_possible_lazymm_cpu(), we need to keep mm_cpumask() in
sync with the core scheduler.

This patch removes x86's bespoke leave_mm() and uses the core scheduler's
unlazy_mm_irqs_off() so that a lazy mm can be dropped and ->active_mm
cleaned up together.  This allows for_each_possible_lazymm_cpu() to be
wired up on x86.

As a side effect, non-x86 architectures that use ACPI C3 will now leave
lazy mm mode before entering C3.  This can only possibly affect ia64,
because only x86 and ia64 enable CONFIG_ACPI_PROCESSOR_CSTATE.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/mmu.h  |  2 --
 arch/x86/mm/tlb.c           | 29 +++--------------------------
 arch/x86/xen/mmu_pv.c       |  2 +-
 drivers/cpuidle/cpuidle.c   |  2 +-
 drivers/idle/intel_idle.c   |  4 ++--
 include/linux/mmu_context.h |  4 +---
 kernel/sched/sched.h        |  2 --
 7 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..03ba71420ff3 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -63,7 +63,5 @@ typedef struct {
 		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
 	}
 
-void leave_mm(int cpu);
-#define leave_mm leave_mm
 
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 36ce9dffb963..e502565176b9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/mmu_context.h>
 #include <linux/sched/smt.h>
 #include <linux/sched/mm.h>
 
@@ -294,28 +295,6 @@ static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
 	write_cr3(new_mm_cr3);
 }
 
-void leave_mm(int cpu)
-{
-	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-
-	/*
-	 * It's plausible that we're in lazy TLB mode while our mm is init_mm.
-	 * If so, our callers still expect us to flush the TLB, but there
-	 * aren't any user TLB entries in init_mm to worry about.
-	 *
-	 * This needs to happen before any other sanity checks due to
-	 * intel_idle's shenanigans.
-	 */
-	if (loaded_mm == &init_mm)
-		return;
-
-	/* Warn if we're not lazy. */
-	WARN_ON(!this_cpu_read(cpu_tlbstate_shared.is_lazy));
-
-	switch_mm(NULL, &init_mm, NULL);
-}
-EXPORT_SYMBOL_GPL(leave_mm);
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -512,8 +491,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * from lazy TLB mode to normal mode if active_mm isn't changing.
 	 * When this happens, we don't assume that CR3 (and hence
 	 * cpu_tlbstate.loaded_mm) matches next.
-	 *
-	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
 	 */
 
 	/* We don't want flush_tlb_func() to run concurrently with us. */
@@ -523,7 +500,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	/*
 	 * Verify that CR3 is what we think it is.  This will catch
 	 * hypothetical buggy code that directly switches to swapper_pg_dir
-	 * without going through leave_mm() / switch_mm_irqs_off() or that
+	 * without going through switch_mm_irqs_off() or that
 	 * does something like write_cr3(read_cr3_pa()).
 	 *
 	 * Only do this check if CONFIG_DEBUG_VM=y because __read_cr3()
@@ -732,7 +709,7 @@ temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	 * restoring the previous mm.
 	 */
 	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
-		leave_mm(smp_processor_id());
+		unlazy_mm_irqs_off();
 
 	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 3359c23573c5..ba849185810a 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -898,7 +898,7 @@ static void drop_mm_ref_this_cpu(void *info)
 	struct mm_struct *mm = info;
 
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm)
-		leave_mm(smp_processor_id());
+		unlazy_mm_irqs_off();
 
 	/*
 	 * If this cpu still has a stale cr3 reference, then make sure
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef2ea1b12cd8..b865822a6278 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -223,7 +223,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	}
 
 	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
-		leave_mm(dev->cpu);
+		unlazy_mm_irqs_off();
 
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e6c543b5ee1d..bb5d3b3e28df 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -115,8 +115,8 @@ static unsigned int mwait_substates __initdata;
  * If the local APIC timer is not known to be reliable in the target idle state,
  * enable one-shot tick broadcasting for the target CPU before executing MWAIT.
  *
- * Optionally call leave_mm() for the target CPU upfront to avoid wakeups due to
- * flushing user TLBs.
+ * Optionally call unlazy_mm_irqs_off() for the target CPU upfront to avoid
+ * wakeups due to flushing user TLBs.
  *
  * Must be called under local_irq_disable().
  */
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index b9b970f7ab45..035e8e42eb78 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -10,9 +10,7 @@
 # define switch_mm_irqs_off switch_mm
 #endif
 
-#ifndef leave_mm
-static inline void leave_mm(int cpu) { }
-#endif
+extern void unlazy_mm_irqs_off(void);
 
 /*
  * CPUs that are capable of running user task @p. Must contain at least one
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1010e63962d9..e57121bc84d5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3071,5 +3071,3 @@ extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
-
-extern void unlazy_mm_irqs_off(void);
-- 
2.33.1

