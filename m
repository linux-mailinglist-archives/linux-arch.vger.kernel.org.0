Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79D2CE789
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 06:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbgLDF1G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 00:27:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgLDF1G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Dec 2020 00:27:06 -0500
From:   Andy Lutomirski <luto@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [RFC v2 2/2] [MOCKUP] sched/mm: Lightweight lazy mm refcounting
Date:   Thu,  3 Dec 2020 21:26:17 -0800
Message-Id: <e69827244c2f1e534aa83a40334ffa00bafe54c2.1607059162.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607059162.git.luto@kernel.org>
References: <cover.1607059162.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a mockup.  It's designed to illustrate the algorithm and how the
code might be structured.  There are several things blatantly wrong with
it:

The coding stype is not up to kernel standards.  I have prototypes in the
wrong places and other hacks.

There's a problem with mm_cpumask() not being reliable.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/fork.c        |   4 ++
 kernel/sched/core.c  | 128 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |  11 +++-
 3 files changed, 126 insertions(+), 17 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360fb032..0887a33cf84f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1066,6 +1066,8 @@ struct mm_struct *mm_alloc(void)
 	return mm_init(mm, current, current_user_ns());
 }
 
+extern void mm_fixup_lazy_refs(struct mm_struct *mm);
+
 static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
@@ -1084,6 +1086,8 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+
+	mm_fixup_lazy_refs(mm);
 	mmdrop(mm);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6c4b76147166..69dfdfe0e5b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3555,6 +3555,75 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	prepare_arch_switch(next);
 }
 
+static void drop_extra_mm_refs(struct rq *rq)
+{
+	unsigned long old_mm;
+
+	if (likely(!atomic_long_read(&rq->mm_to_mmdrop)))
+		return;
+
+	/*
+	 * Slow path.  This only happens when we recently stopped using
+	 * an mm that is exiting.
+	 */
+	old_mm = atomic_long_xchg_relaxed(&rq->mm_to_mmdrop, 0);
+	if (old_mm)
+		mmdrop((struct mm_struct *)old_mm);
+}
+
+/*
+ * This ensures that all lazy_mm refs to mm are converted to mm_count
+ * refcounts.  Our caller holds an mm_count reference, so we don't need
+ * to worry about mm being freed out from under us.
+ */
+void mm_fixup_lazy_refs(struct mm_struct *mm)
+{
+	int cpu;
+
+	/*
+	 * mm_users is zero, so no new lazy refs will be taken.
+	 */
+	WARN_ON_ONCE(atomic_read(&mm->mm_users) != 0);
+
+	/*
+	 * XXX: this is wrong on arm64 and possibly on other architectures.
+	 * Maybe we need a config option for this?  Or a
+	 * for_each_possible_lazy_cpu(cpu, mm) helper?
+	 */
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		struct rq *rq = cpu_rq(cpu);
+		unsigned long old;
+
+		if (READ_ONCE(rq->lazy_mm) != mm)
+			continue;
+
+		// XXX: we could optimize this by doing a big addition to
+		// mm_count up front instead of incrementing it separately
+		// for each CPU.
+		mmgrab(mm);
+
+		// XXX: could this be relaxed instead?
+		old = atomic_long_xchg(&rq->mm_to_mmdrop, (unsigned long)mm);
+
+		// At this point, mm can be mmdrop()ed at any time, probably
+		// by the target cpu.
+
+		if (!old)
+			continue;  // All done!
+
+		WARN_ON_ONCE(old == (unsigned long)mm);
+
+		// Uh oh!  We just stole an mm reference from the target CPU.
+		// Fortunately, we just observed the target's lazy_mm pointing
+		// to something other than old, and we observed this after
+		// bringing mm_users down to 0.  This means that the remote
+		// cpu is definitely done with old.  So we can drop it on the
+		// remote CPU's behalf.
+
+		mmdrop((struct mm_struct *)old);
+	}
+}
+
 /**
  * finish_task_switch - clean up after a task-switch
  * @prev: the thread we just switched away from.
@@ -3578,7 +3647,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
 	long prev_state;
 
 	/*
@@ -3597,8 +3665,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
-
 	/*
 	 * A task struct has one reference for the use as "current".
 	 * If a task dies, then it sets TASK_DEAD in tsk->state and calls
@@ -3629,11 +3695,28 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * rq->curr, before returning to userspace, and mmdrop() provides
 	 * this barrier.
 	 *
-	 * XXX: I don't think mmdrop() actually does this.  There's no
-	 * smp_mb__before/after_atomic() in there.
+	 * XXX: I don't think mmdrop() actually did this.  There's no
+	 * smp_mb__before/after_atomic() in there.  But mmdrop()
+	 * certainly doesn't do this now, since we don't call mmdrop().
 	 */
-	if (mm)
-		mmdrop(mm);
+	if (current->mm && rq->lazy_mm) {
+		/*
+		 * We are unlazying.  Any remote CPU that observes our
+		 * store to lazy_mm is permitted to free the mm if mm_users
+		 * and mm_count are both zero.
+		 */
+		WRITE_ONCE(rq->lazy_mm, NULL);
+	}
+
+	// Do this unconditionally.  There's a race in which a remote CPU
+	// sees rq->lazy_mm != NULL and gives us an extra mm ref while we
+	// are executing this code and we don't notice.  Instead of letting
+	// that ref sit around until the next time we unlazy, do it on every
+	// context switch.
+	//
+	// XXX: maybe we should do this at the beginning of a context switch
+	// instead?
+	drop_extra_mm_refs(rq);
 
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
@@ -3737,20 +3820,31 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	arch_start_context_switch(prev);
 
 	/*
-	 * kernel -> kernel   lazy + transfer active
-	 *   user -> kernel   lazy + mmgrab() active
+	 * TODO: write a new comment!
 	 *
-	 * kernel ->   user   switch + mmdrop() active
-	 *   user ->   user   switch
+	 * NB: none of this is kept in sync with the arch code.
+	 * In particular, active_mm can point to an mm that is no longer
+	 * in use by the arch mm code, and this condition can persist
+	 * across multiple context switches.  This isn't a problem
+	 * per se, but it does mean that using active_mm for anything
+	 * other than keeping an mm from being freed is a bit dubious.
 	 */
 	if (!next->mm) {                                // to kernel
 		enter_lazy_tlb(prev->active_mm, next);
 
 		next->active_mm = prev->active_mm;
-		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
-		else
+		if (prev->mm) {                         // from user
+			WARN_ON_ONCE(rq->lazy_mm);
+			WRITE_ONCE(rq->lazy_mm, next->active_mm);
+			/*
+			 * barrier here?  this needs to be visible to any
+			 * remote CPU that starts executing __mmput().  That
+			 * can't happen until either we call mmput() or until
+			 * prev migrates elsewhere.
+			 */
+		} else {
 			prev->active_mm = NULL;
+		}
 	} else {                                        // to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
 		/*
@@ -3760,12 +3854,14 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		 * The below provides this either through switch_mm(), or in
 		 * case 'prev->active_mm == next->mm' through
 		 * finish_task_switch()'s mmdrop().
+		 *
+		 * XXX: mmdrop() didn't do this before, and the new
+		 * code doesn't even call mmdrop().
 		 */
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop() in finish_task_switch(). */
-			rq->prev_mm = prev->active_mm;
+			/* will release lazy_mm in finish_task_switch(). */
 			prev->active_mm = NULL;
 		}
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..e0caee5f158e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -950,7 +950,16 @@ struct rq {
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-	struct mm_struct	*prev_mm;
+
+	/*
+	 * Hazard pointer for an mm that we might be using lazily.
+	 */
+	struct mm_struct	*lazy_mm;
+
+	/*
+	 * An mm that needs mmdrop()ing.
+	 */
+	atomic_long_t		mm_to_mmdrop;
 
 	unsigned int		clock_update_flags;
 	u64			clock;
-- 
2.28.0

