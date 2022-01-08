Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3E4884A3
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiAHQom (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiAHQog (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522EC06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A927860DD0
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69B3C36AEF;
        Sat,  8 Jan 2022 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660275;
        bh=yDoOe4UwcHpvI4lvTKMEryFWVpWlenvaZDNNNclnJoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3IkvhwWWHhRcORWc95cYxl3JBHz9QHqFg3GicxqeO4scRWEn5+GAU7+QXvzaQiJu
         /t6TFUZP4ot00mZAAozBixOfCTjbJ0M2wWN0Nck3kravEBBMEZjMhI17BeOQ4QtAgB
         TAAeAIT0X8HOYseASDVhjZz4+JPBgThT+RsGEkN7JweaLGMQQEmsFfRpGdUT7GrFiI
         R1fkR/UrIud6v2FczSgTzelxa5hlD7NLt6WOQpC4QK1c3hFKfxW6qtfFDgj/lgIdMU
         YcvRH6xgb1NkCB3TVSaJYSF95qiUH/AI+c/xHGdI20dqWnZEXzHJ4LkXLoZOpx6Uv0
         nKfAKa94/vq/w==
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
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
Date:   Sat,  8 Jan 2022 08:44:01 -0800
Message-Id: <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, switching between a real user mm and a kernel context (including
idle) performs an atomic operation on a per-mm counter via mmgrab() and
mmdrop().  For a single-threaded program, this isn't a big problem: a pair
of atomic operations when entering and returning from idle isn't free, but
it's not very expensive in the grand scheme of things.  For a heavily
multithreaded program on a large system, however, the overhead can be very
large -- all CPUs can end up hammering the same cacheline with atomic
operations, and scalability suffers.

The purpose of mmgrab() and mmdrop() is to make "lazy tlb" mode safe.  When
Linux switches from user to kernel mm context, instead of immediately
reprogramming the MMU to use init_mm, the kernel continues to use the most
recent set of user page tables.  This is safe as long as those page tables
aren't freed.

RCU can't be used to keep the pagetables alive, since RCU read locks can't
be held when idle.

To improve scalability, this patch adds a percpu hazard pointer scheme to
keep lazily-used mms alive.  Each CPU has a single pointer to an mm that
must not be freed, and __mmput() checks the pointers belonging to all CPUs
that might be lazily using the mm in question.

By default, this means walking all online CPUs, but arch code can override
the set of CPUs to check if they can do something more clever.  For
architectures that have accurate mm_cpumask(), mm_cpumask() is a reasonable
choice.  For architectures that can guarantee that *no* remote CPUs are
lazily using an mm after the user portion of the pagetables are torn down
(any architcture that uses IPI shootdowns in exit_mmap() and unlazies the
MMU in the IPI handler, e.g. x86 on bare metal), the set of CPUs to check
could be empty.

XXX: I *think* this is correct when hot-unplugging a CPU, but this needs
double-checking and maybe even a WARN to make sure the ordering is correct.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-MM <linux-mm@kvack.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/sched/mm.h |   3 +
 kernel/fork.c            |  11 ++
 kernel/sched/core.c      | 230 +++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h     |  10 +-
 4 files changed, 221 insertions(+), 33 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 7509b2b2e99d..3ceba11c049c 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -76,6 +76,9 @@ static inline bool mmget_not_zero(struct mm_struct *mm)
 
 /* mmput gets rid of the mappings and all user-space */
 extern void mmput(struct mm_struct *);
+
+extern void mm_unlazy_mm_count(struct mm_struct *mm);
+
 #ifdef CONFIG_MMU
 /* same as above but performs the slow path from the async context. Can
  * be called from the atomic context as well
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..2df72cf3c0d2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1122,6 +1122,17 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+
+	/*
+	 * We hold one mm_count reference.  Convert all remaining lazy_mm
+	 * references to mm_count references so that the mm will be genuinely
+	 * unused when mm_count goes to zero.  Do this after exit_mmap() so
+	 * that, if the architecture shoots down remote TLB entries via IPI in
+	 * exit_mmap() and calls unlazy_mm_irqs_off() when doing so, most or
+	 * all lazy_mm references can be removed without
+	 * mm_unlazy_mm_count()'s help.
+	 */
+	mm_unlazy_mm_count(mm);
 	mmdrop(mm);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95eb0e78f74c..64e4058b3c61 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -20,6 +20,7 @@
 
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
+#include <asm/mmu.h>
 
 #include "../workqueue_internal.h"
 #include "../../fs/io-wq.h"
@@ -4750,6 +4751,144 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	prepare_arch_switch(next);
 }
 
+/*
+ * Called after each context switch.
+ *
+ * Strictly speaking, no action at all is required here.  This rq
+ * can hold an extra reference to at most one mm, so the memory
+ * wasted by deferring the mmdrop() forever is bounded.  That being
+ * said, it's straightforward to safely drop spare references
+ * in the common case.
+ */
+static void mmdrop_lazy(struct rq *rq)
+{
+	struct mm_struct *old_mm;
+
+	old_mm = READ_ONCE(rq->drop_mm);
+
+	do {
+		/*
+		 * If there is nothing to drop or if we are still using old_mm,
+		 * then don't call mmdrop().
+		 */
+		if (likely(!old_mm || old_mm == rq->lazy_mm))
+			return;
+	} while (!try_cmpxchg_relaxed(&rq->drop_mm, &old_mm, NULL));
+
+	mmdrop(old_mm);
+}
+
+#ifndef for_each_possible_lazymm_cpu
+#define for_each_possible_lazymm_cpu(cpu, mm) for_each_online_cpu((cpu))
+#endif
+
+static bool __try_mm_drop_rq_ref(struct rq *rq, struct mm_struct *mm)
+{
+	struct mm_struct *old_drop_mm = smp_load_acquire(&rq->drop_mm);
+
+	/*
+	 * We know that old_mm != mm: this is the only function that
+	 * might set drop_mm to mm, and we haven't set it yet.
+	 */
+	WARN_ON_ONCE(old_drop_mm == mm);
+
+	if (!old_drop_mm) {
+		/*
+		 * Just set rq->drop_mm to mm and our reference will
+		 * get dropped eventually after rq is done with it.
+		 */
+		return try_cmpxchg(&rq->drop_mm, &old_drop_mm, mm);
+	}
+
+	/*
+	 * The target cpu could still be using old_drop_mm.  We know that, if
+	 * old_drop_mm still exists, then old_drop_mm->mm_users == 0.  Can we
+	 * drop it?
+	 *
+	 * NB: it is critical that we load rq->lazy_mm again after loading
+	 * drop_mm.  If we looked at a prior value of lazy_mm (which we
+	 * already know to be mm), then we would be subject to a race:
+	 *
+	 * Us:
+	 *     Load rq->lazy_mm.
+	 * Remote CPU:
+	 *     Switch to old_drop_mm (with mm_users > 0)
+	 *     Become lazy and set rq->lazy_mm = old_drop_mm
+	 * Third CPU:
+	 *     Set old_drop_mm->mm_users to 0.
+	 *     Set rq->drop_mm = old_drop_mm
+	 * Us:
+	 *     Incorrectly believe that old_drop_mm is unused
+	 *     because rq->lazy_mm != old_drop_mm
+	 *
+	 * In other words, to verify that rq->lazy_mm is not keeping a given
+	 * mm alive, we must load rq->lazy_mm _after_ we know that mm_users ==
+	 * 0 and therefore that rq will not switch to that mm.
+	 */
+	if (smp_load_acquire(&rq->lazy_mm) != mm) {
+		/*
+		 * We got lucky!  rq _was_ using mm, but it stopped.
+		 * Just drop our reference.
+		 */
+		mmdrop(mm);
+		return true;
+	}
+
+	/*
+	 * If we got here, rq->lazy_mm != old_drop_mm, and we ruled
+	 * out the race described above.  rq is done with old_drop_mm,
+	 * so we can steal the reference held by rq and replace it with
+	 * our reference to mm.
+	 */
+	if (cmpxchg(&rq->drop_mm, old_drop_mm, mm) != old_drop_mm)
+		return false;
+
+	mmdrop(old_drop_mm);
+	return true;
+}
+
+/*
+ * This converts all lazy_mm references to mm to mm_count refcounts.  Our
+ * caller holds an mm_count reference, so we don't need to worry about mm
+ * being freed out from under us.
+ */
+void mm_unlazy_mm_count(struct mm_struct *mm)
+{
+	unsigned int drop_count = 0;
+	int cpu;
+
+	/*
+	 * mm_users is zero, so no cpu will set its rq->lazy_mm to mm.
+	 */
+	WARN_ON_ONCE(atomic_read(&mm->mm_users) != 0);
+
+	for_each_possible_lazymm_cpu(cpu, mm) {
+		struct rq *rq = cpu_rq(cpu);
+
+		if (smp_load_acquire(&rq->lazy_mm) != mm)
+			continue;
+
+		/*
+		 * Grab one reference.  Do it as a batch so we do a maximum
+		 * of two atomic operations instead of one per lazy reference.
+		 */
+		if (!drop_count) {
+			/*
+			 * Collect lots of references.  We'll drop the ones we
+			 * don't use.
+			 */
+			drop_count = num_possible_cpus();
+			atomic_add(drop_count, &mm->mm_count);
+		}
+		drop_count--;
+
+		while (!__try_mm_drop_rq_ref(rq, mm))
+			;
+	}
+
+	atomic_sub(drop_count, &mm->mm_count);
+}
+
 /**
  * finish_task_switch - clean up after a task-switch
  * @prev: the thread we just switched away from.
@@ -4773,7 +4912,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
 	long prev_state;
 
 	/*
@@ -4792,8 +4930,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
-
 	/*
 	 * A task struct has one reference for the use as "current".
 	 * If a task dies, then it sets TASK_DEAD in tsk->state and calls
@@ -4824,12 +4960,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 
 	fire_sched_in_preempt_notifiers(current);
 
-	/*
-	 * If an architecture needs to take a specific action for
-	 * SYNC_CORE, it can do so in switch_mm_irqs_off().
-	 */
-	if (mm)
-		mmdrop(mm);
+	mmdrop_lazy(rq);
 
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
@@ -4891,36 +5022,55 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 */
 	arch_start_context_switch(prev);
 
+	/*
+	 * Sanity check: if something went wrong and the previous mm was
+	 * freed while we were still using it, KASAN might not notice
+	 * without help.
+	 */
+	kasan_check_byte(prev->active_mm);
+
 	/*
 	 * kernel -> kernel   lazy + transfer active
-	 *   user -> kernel   lazy + mmgrab() active
+	 *   user -> kernel   lazy + lazy_mm grab active
 	 *
-	 * kernel ->   user   switch + mmdrop() active
+	 * kernel ->   user   switch + lazy_mm release active
 	 *   user ->   user   switch
 	 */
 	if (!next->mm) {                                // to kernel
 		enter_lazy_tlb(prev->active_mm, next);
 
 		next->active_mm = prev->active_mm;
-		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
-		else
+		if (prev->mm) {                         // from user
+			SCHED_WARN_ON(rq->lazy_mm);
+
+			/*
+			 * Acqure a lazy_mm reference to the active
+			 * (lazy) mm.  No explicit barrier needed: we still
+			 * hold an explicit (mm_users) reference.  __mmput()
+			 * can't be called until we call mmput() to drop
+			 * our reference, and __mmput() is a release barrier.
+			 */
+			WRITE_ONCE(rq->lazy_mm, next->active_mm);
+		} else {
 			prev->active_mm = NULL;
+		}
 	} else {                                        // to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		/*
-		 * sys_membarrier() requires an smp_mb() between setting
-		 * rq->curr->mm to a membarrier-enabled mm and returning
-		 * to userspace.
+		 * An arch implementation of for_each_possible_lazymm_cpu()
+		 * may skip this CPU now that we have switched away from
+		 * prev->active_mm, so we must not reference it again.
 		 */
+
 		membarrier_finish_switch_mm(next->mm);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop() in finish_task_switch(). */
-			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
+
+			/* Drop our lazy_mm reference to the old lazy mm. */
+			smp_store_release(&rq->lazy_mm, NULL);
 		}
 	}
 
@@ -4938,7 +5088,8 @@ context_switch(struct rq *rq, struct task_struct *prev,
 void __change_current_mm(struct mm_struct *mm, bool mm_is_brand_new)
 {
 	struct task_struct *tsk = current;
-	struct mm_struct *old_active_mm, *mm_to_drop = NULL;
+	struct mm_struct *old_active_mm;
+	bool was_kernel;
 
 	BUG_ON(!mm);	/* likely to cause corruption if we continue */
 
@@ -4958,12 +5109,9 @@ void __change_current_mm(struct mm_struct *mm, bool mm_is_brand_new)
 	if (tsk->mm) {
 		/* We're detaching from an old mm.  Sync stats. */
 		sync_mm_rss(tsk->mm);
+		was_kernel = false;
 	} else {
-		/*
-		 * Switching from kernel mm to user.  Drop the old lazy
-		 * mm reference.
-		 */
-		mm_to_drop = tsk->active_mm;
+		was_kernel = true;
 	}
 
 	old_active_mm = tsk->active_mm;
@@ -4992,6 +5140,10 @@ void __change_current_mm(struct mm_struct *mm, bool mm_is_brand_new)
 
 	membarrier_finish_switch_mm(mm);
 	vmacache_flush(tsk);
+
+	if (was_kernel)
+		smp_store_release(&this_rq()->lazy_mm, NULL);
+
 	task_unlock(tsk);
 
 #ifdef finish_arch_post_lock_switch
@@ -5009,9 +5161,6 @@ void __change_current_mm(struct mm_struct *mm, bool mm_is_brand_new)
 		finish_arch_post_lock_switch();
 	}
 #endif
-
-	if (mm_to_drop)
-		mmdrop(mm_to_drop);
 }
 
 void __change_current_mm_to_kernel(void)
@@ -5044,8 +5193,17 @@ void __change_current_mm_to_kernel(void)
 	membarrier_update_current_mm(NULL);
 	vmacache_flush(tsk);
 
-	/* active_mm is still 'old_mm' */
-	mmgrab(old_mm);
+	/*
+	 * active_mm is still 'old_mm'
+	 *
+	 * Acqure a lazy_mm reference to the active (lazy) mm.  As in
+	 * context_switch(), no explicit barrier needed: we still hold an
+	 * explicit (mm_users) reference.  __mmput() can't be called until we
+	 * call mmput() to drop our reference, and __mmput() is a release
+	 * barrier.
+	 */
+	WRITE_ONCE(this_rq()->lazy_mm, old_mm);
+
 	enter_lazy_tlb(old_mm, tsk);
 
 	local_irq_enable();
@@ -8805,6 +8963,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 void unlazy_mm_irqs_off(void)
 {
 	struct mm_struct *mm = current->active_mm;
+	struct rq *rq = this_rq();
 
 	lockdep_assert_irqs_disabled();
 
@@ -8815,10 +8974,17 @@ void unlazy_mm_irqs_off(void)
 		return;
 
 	switch_mm_irqs_off(mm, &init_mm, current);
-	mmgrab(&init_mm);
 	current->active_mm = &init_mm;
+
+	/*
+	 * We don't need a lazy reference to init_mm -- it's not about
+	 * to go away.
+	 */
+	smp_store_release(&rq->lazy_mm, NULL);
+
 	finish_arch_post_lock_switch();
-	mmdrop(mm);
+
+	mmdrop_lazy(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b496a9ee9aec..1010e63962d9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -977,7 +977,15 @@ struct rq {
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-	struct mm_struct	*prev_mm;
+
+	/*
+	 * Fast refcounting scheme for lazy mm.  lazy_mm is a hazard pointer:
+	 * setting it to point to a lazily used mm keeps that mm from being
+	 * freed.  drop_mm points to am mm that needs an mmdrop() call
+	 * after the CPU owning the rq is done with it.
+	 */
+	struct mm_struct	*lazy_mm;
+	struct mm_struct	*drop_mm;
 
 	unsigned int		clock_update_flags;
 	u64			clock;
-- 
2.33.1

