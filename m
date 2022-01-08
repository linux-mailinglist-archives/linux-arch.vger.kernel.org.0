Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43913488493
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiAHQoX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiAHQoW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9928CC06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36AA560BAA
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709F9C36AF3;
        Sat,  8 Jan 2022 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660261;
        bh=LjdL825yge/umM2UgJRwPTnpW901vptpiAzBo0Abgdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlCM/878C1rYxAAe9UufUR7gcwXASA7e1xrfZVepu0whzF7ICFNMg6oO7ECN2Ok7t
         c+3+cWaPs8pEKoRin9U7PRYpzUzk+Ssq9kd5K1U7Vr4tyNrh4CPbWNiIhNlmLDebGz
         fKhJn5wiQIwLcFTRaVW3pvTEGODx2s2uMyLLtQy9RgyZfrM28FjRSGf+PbILr0+G+I
         onXa/0idW/YXqnEAJuZ4CIvCGvkvmHcA6YtSEEbeDoEsdQzYuO256oa4QmvY7M5cvq
         1/ZCZUBnGMFpwA9MNXtGN+S8jXWz3in7j0PTX1/YE7RUrwsR2GNvvmqGZsN7qKHa6j
         5RiYeD2VlBOOA==
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
Subject: [PATCH 04/23] membarrier: Make the post-switch-mm barrier explicit
Date:   Sat,  8 Jan 2022 08:43:49 -0800
Message-Id: <c1bc25b895213921cf36f4ee4ba07c1791fb631e.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

membarrier() needs a barrier after any CPU changes mm.  There is currently
a comment explaining why this barrier probably exists in all cases. The
logic is based on ensuring that the barrier exists on every control flow
path through the scheduler.  It also relies on mmgrab() and mmdrop() being
full barriers.

mmgrab() and mmdrop() would be better if they were not full barriers.  As a
trivial optimization, mmgrab() could use a relaxed atomic and mmdrop()
could use a release on architectures that have these operations.  Larger
optimizations are also in the works.  Doing any of these optimizations
while preserving an unnecessary barrier will complicate the code and
penalize non-membarrier-using tasks.

Simplify the logic by adding an explicit barrier, and allow architectures
to override it as an optimization if they want to.

One of the deleted comments in this patch said "It is therefore
possible to schedule between user->kernel->user threads without
passing through switch_mm()".  It is possible to do this without, say,
writing to CR3 on x86, but the core scheduler indeed calls
switch_mm_irqs_off() to tell the arch code to go back from lazy mode
to no-lazy mode.

The membarrier_finish_switch_mm() call in exec_mmap() is a no-op so long as
there is no way for a newly execed program to register for membarrier prior
to running user code.  Subsequent patches will merge the exec_mmap() code
with the kthread_use_mm() code, though, and keeping the paths consistent
will make the result more comprehensible.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fs/exec.c                |  1 +
 include/linux/sched/mm.h | 18 ++++++++++++++++++
 kernel/kthread.c         | 12 +-----------
 kernel/sched/core.c      | 34 +++++++++-------------------------
 4 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..3abbd0294e73 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1019,6 +1019,7 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
+	membarrier_finish_switch_mm(mm);
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 0df706c099e5..e8919995d8dd 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -349,6 +349,20 @@ extern void membarrier_exec_mmap(struct mm_struct *mm);
 
 extern void membarrier_update_current_mm(struct mm_struct *next_mm);
 
+/*
+ * Called by the core scheduler after calling switch_mm_irqs_off().
+ * Architectures that have implicit barriers when switching mms can
+ * override this as an optimization.
+ */
+#ifndef membarrier_finish_switch_mm
+static inline void membarrier_finish_switch_mm(struct mm_struct *mm)
+{
+	if (atomic_read(&mm->membarrier_state) &
+	    (MEMBARRIER_STATE_GLOBAL_EXPEDITED | MEMBARRIER_STATE_PRIVATE_EXPEDITED))
+		smp_mb();
+}
+#endif
+
 #else
 static inline void membarrier_exec_mmap(struct mm_struct *mm)
 {
@@ -356,6 +370,10 @@ static inline void membarrier_exec_mmap(struct mm_struct *mm)
 static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 {
 }
+static inline void membarrier_finish_switch_mm(struct mm_struct *mm)
+{
+}
+
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5b37a8567168..396ae78a1a34 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1361,25 +1361,15 @@ void kthread_use_mm(struct mm_struct *mm)
 	tsk->mm = mm;
 	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
+	membarrier_finish_switch_mm(mm);
 	local_irq_enable();
 	task_unlock(tsk);
 #ifdef finish_arch_post_lock_switch
 	finish_arch_post_lock_switch();
 #endif
 
-	/*
-	 * When a kthread starts operating on an address space, the loop
-	 * in membarrier_{private,global}_expedited() may not observe
-	 * that tsk->mm, and not issue an IPI. Membarrier requires a
-	 * memory barrier after storing to tsk->mm, before accessing
-	 * user-space memory. A full memory barrier for membarrier
-	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
-	 * mmdrop(), or explicitly with smp_mb().
-	 */
 	if (active_mm != mm)
 		mmdrop(active_mm);
-	else
-		smp_mb();
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6a1db8264c7b..917068b0a145 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4824,14 +4824,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	fire_sched_in_preempt_notifiers(current);
 
 	/*
-	 * When switching through a kernel thread, the loop in
-	 * membarrier_{private,global}_expedited() may have observed that
-	 * kernel thread and not issued an IPI. It is therefore possible to
-	 * schedule between user->kernel->user threads without passing though
-	 * switch_mm(). Membarrier requires a barrier after storing to
-	 * rq->curr, before returning to userspace, and mmdrop() provides
-	 * this barrier.
-	 *
 	 * If an architecture needs to take a specific action for
 	 * SYNC_CORE, it can do so in switch_mm_irqs_off().
 	 */
@@ -4915,15 +4907,14 @@ context_switch(struct rq *rq, struct task_struct *prev,
 			prev->active_mm = NULL;
 	} else {                                        // to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
+		switch_mm_irqs_off(prev->active_mm, next->mm, next);
+
 		/*
 		 * sys_membarrier() requires an smp_mb() between setting
-		 * rq->curr / membarrier_switch_mm() and returning to userspace.
-		 *
-		 * The below provides this either through switch_mm(), or in
-		 * case 'prev->active_mm == next->mm' through
-		 * finish_task_switch()'s mmdrop().
+		 * rq->curr->mm to a membarrier-enabled mm and returning
+		 * to userspace.
 		 */
-		switch_mm_irqs_off(prev->active_mm, next->mm, next);
+		membarrier_finish_switch_mm(next->mm);
 
 		if (!prev->mm) {                        // from kernel
 			/* will mmdrop() in finish_task_switch(). */
@@ -6264,17 +6255,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		RCU_INIT_POINTER(rq->curr, next);
 		/*
 		 * The membarrier system call requires each architecture
-		 * to have a full memory barrier after updating
-		 * rq->curr, before returning to user-space.
-		 *
-		 * Here are the schemes providing that barrier on the
-		 * various architectures:
-		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
-		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
-		 * - finish_lock_switch() for weakly-ordered
-		 *   architectures where spin_unlock is a full barrier,
-		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
-		 *   is a RELEASE barrier),
+		 * to have a full memory barrier before and after updating
+		 * rq->curr->mm, before returning to userspace.  This
+		 * is provided by membarrier_finish_switch_mm().  Architectures
+		 * that want to optimize this can override that function.
 		 */
 		++*switch_count;
 
-- 
2.33.1

