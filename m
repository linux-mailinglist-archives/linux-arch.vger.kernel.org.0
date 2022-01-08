Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101CC488492
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiAHQoV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50122 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiAHQoU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0943060BAA
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C0DC36AE3;
        Sat,  8 Jan 2022 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660259;
        bh=luXaTkuUOzn73UJhbrp8yKhm9hf+Uj848KliPU1OO9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwQbQtbbDo6gJrDXBM/q8zNDQ2YuHk3PRm9ab7IdxAnUz/hEwb2Us3d2xm0a6F4Sz
         aioxqBbMIshXmvZgHIcQ5+kdcUDPMN33Pw82ZRtwLpa116FbE5JypHK8bB63PsGnPX
         YK9FiNuWAsjsjsYw0/F4GOVYRVq/0uti65vMEAtecOtqdHsDMAMPq+g8OGJUL1KBz0
         azxwUcdGqkMeVBjinm9Boluur8OzqpzRqulo+7L762mn12i8B3YwRN7DPMEnPfpSBP
         P0FrOCqE8InKncA7ywZJo0mHp8IA/PtTNbcgRDUqfPqxwN/89Lpf2R52697O2MDXtk
         NGBqpnUybgVbA==
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
Subject: [PATCH 02/23] x86/mm: Handle unlazying membarrier core sync in the arch code
Date:   Sat,  8 Jan 2022 08:43:47 -0800
Message-Id: <b622be287d8148e017742ecf29a966aa4c6de664.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The core scheduler isn't a great place for
membarrier_mm_sync_core_before_usermode() -- the core scheduler
doesn't actually know whether we are lazy.  With the old code, if a
CPU is running a membarrier-registered task, goes idle, gets unlazied
via a TLB shootdown IPI, and switches back to the
membarrier-registered task, it will do an unnecessary core sync.

Conveniently, x86 is the only architecture that does anything in this
sync_core_before_usermode(), so membarrier_mm_sync_core_before_usermode()
is a no-op on all other architectures and we can just move the code.

(I am not claiming that the SYNC_CORE code was correct before or after this
 change on any non-x86 architecture.  I merely claim that this change
 improves readability, is correct on x86, and makes no change on any other
 architecture.)

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/tlb.c        | 58 +++++++++++++++++++++++++++++++---------
 include/linux/sched/mm.h | 13 ---------
 kernel/sched/core.c      | 14 +++++-----
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 59ba2968af1b..1ae15172885e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -9,6 +9,7 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/sched/smt.h>
+#include <linux/sched/mm.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -485,6 +486,15 @@ void cr4_update_pce(void *ignored)
 static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
 #endif
 
+static void sync_core_if_membarrier_enabled(struct mm_struct *next)
+{
+#ifdef CONFIG_MEMBARRIER
+	if (unlikely(atomic_read(&next->membarrier_state) &
+		     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE))
+		sync_core_before_usermode();
+#endif
+}
+
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -539,16 +549,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
 
 	/*
-	 * The membarrier system call requires a full memory barrier and
-	 * core serialization before returning to user-space, after
-	 * storing to rq->curr, when changing mm.  This is because
-	 * membarrier() sends IPIs to all CPUs that are in the target mm
-	 * to make them issue memory barriers.  However, if another CPU
-	 * switches to/from the target mm concurrently with
-	 * membarrier(), it can cause that CPU not to receive an IPI
-	 * when it really should issue a memory barrier.  Writing to CR3
-	 * provides that full memory barrier and core serializing
-	 * instruction.
+	 * membarrier() support requires that, when we change rq->curr->mm:
+	 *
+	 *  - If next->mm has membarrier registered, a full memory barrier
+	 *    after writing rq->curr (or rq->curr->mm if we switched the mm
+	 *    without switching tasks) and before returning to user mode.
+	 *
+	 *  - If next->mm has SYNC_CORE registered, then we sync core before
+	 *    returning to user mode.
+	 *
+	 * In the case where prev->mm == next->mm, membarrier() uses an IPI
+	 * instead, and no particular barriers are needed while context
+	 * switching.
+	 *
+	 * x86 gets all of this as a side-effect of writing to CR3 except
+	 * in the case where we unlazy without flushing.
+	 *
+	 * All other architectures are civilized and do all of this implicitly
+	 * when transitioning from kernel to user mode.
 	 */
 	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
@@ -566,7 +584,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		/*
 		 * If the CPU is not in lazy TLB mode, we are just switching
 		 * from one thread in a process to another thread in the same
-		 * process. No TLB flush required.
+		 * process. No TLB flush or membarrier() synchronization
+		 * is required.
 		 */
 		if (!was_lazy)
 			return;
@@ -576,16 +595,31 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * If the TLB is up to date, just use it.
 		 * The barrier synchronizes with the tlb_gen increment in
 		 * the TLB shootdown code.
+		 *
+		 * As a future optimization opportunity, it's plausible
+		 * that the x86 memory model is strong enough that this
+		 * smp_mb() isn't needed.
 		 */
 		smp_mb();
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
-				next_tlb_gen)
+		    next_tlb_gen) {
+			/*
+			 * We switched logical mm but we're not going to
+			 * write to CR3.  We already did smp_mb() above,
+			 * but membarrier() might require a sync_core()
+			 * as well.
+			 */
+			sync_core_if_membarrier_enabled(next);
+
 			return;
+		}
 
 		/*
 		 * TLB contents went out of date while we were in lazy
 		 * mode. Fall through to the TLB switching code below.
+		 * No need for an explicit membarrier invocation -- the CR3
+		 * write will serialize.
 		 */
 		new_asid = prev_asid;
 		need_flush = true;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 5561486fddef..c256a7fc0423 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -345,16 +345,6 @@ enum {
 #include <asm/membarrier.h>
 #endif
 
-static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
-{
-	if (current->mm != mm)
-		return;
-	if (likely(!(atomic_read(&mm->membarrier_state) &
-		     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
-		return;
-	sync_core_before_usermode();
-}
-
 extern void membarrier_exec_mmap(struct mm_struct *mm);
 
 extern void membarrier_update_current_mm(struct mm_struct *next_mm);
@@ -370,9 +360,6 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 static inline void membarrier_exec_mmap(struct mm_struct *mm)
 {
 }
-static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
-{
-}
 static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 {
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f21714ea3db8..6a1db8264c7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4822,22 +4822,22 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	kmap_local_sched_in();
 
 	fire_sched_in_preempt_notifiers(current);
+
 	/*
 	 * When switching through a kernel thread, the loop in
 	 * membarrier_{private,global}_expedited() may have observed that
 	 * kernel thread and not issued an IPI. It is therefore possible to
 	 * schedule between user->kernel->user threads without passing though
 	 * switch_mm(). Membarrier requires a barrier after storing to
-	 * rq->curr, before returning to userspace, so provide them here:
+	 * rq->curr, before returning to userspace, and mmdrop() provides
+	 * this barrier.
 	 *
-	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
-	 *   provided by mmdrop(),
-	 * - a sync_core for SYNC_CORE.
+	 * If an architecture needs to take a specific action for
+	 * SYNC_CORE, it can do so in switch_mm_irqs_off().
 	 */
-	if (mm) {
-		membarrier_mm_sync_core_before_usermode(mm);
+	if (mm)
 		mmdrop(mm);
-	}
+
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
-- 
2.33.1

