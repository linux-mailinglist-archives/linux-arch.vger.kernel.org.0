Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A05E21ACB6
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 03:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGJB52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 21:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJB51 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 21:57:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA577C08C5CE;
        Thu,  9 Jul 2020 18:57:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so1842342pfu.1;
        Thu, 09 Jul 2020 18:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5MO1bZ0QpZZ3545VDR9j5SJ7kjibHldB5C8L2Sm+nM=;
        b=hYJ1J+ucWd2AGeEVGR5Xr3ji7mFHM5j35Bw3Ut4o8mC5uOIgy30o+KIhPFNee9+5jv
         gEMU/hJVvmeDOF2pIUqMd92H837uftb/kYyRdiOyppwh6DXXkQY9VsopHU6dRiCf9C9c
         vudJcmVo/772RpC3fCAlGRV77oM5pjhHfPrSH46obfRFznXI9fy1pINsIpzMfJr8Rah9
         64XvcCP7QTxFpyxJl4QgnLV95uaK9qSl5fOCf/oayUPiNByAi0Ua7KVXftPRMixni6Mx
         almGO6i3pa8//FqI+k11fbgzBNf2nWJKeBote9KqnhXjPu2WD0SpRtNY9UxEEZXAwff8
         rI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5MO1bZ0QpZZ3545VDR9j5SJ7kjibHldB5C8L2Sm+nM=;
        b=K8C39veSth2QbPtjjbH/J4ovWoIfkUQ63j1cXdeIBGwtulM99F8XGuqL95stXw/oJu
         jhll4TXoQ7qjkjJ5G0V5/8KaDNet4LirkmFqROAZHHiElctGtmhjB+dWtm1e/Cdlvabz
         j3vj+qT2Y+ReycKdx9Lnn2YhqMzhpnjcKuwHWN8hPPbweLCQ3lWMWcYPA3y4D66CTfG0
         xJsu/pzBcO3r0NYJ/vu4FyyaBoX86EYO4odEPQOxnyztOHyg/xqMqDY+mp+kEGxAcAB+
         LU1l8d0nA13b2pELTygI8MpuQqU0TyyRW4TEWA1iaXVpWhZFr64WT1NRkgKTi06KUC9A
         TENw==
X-Gm-Message-State: AOAM533Xly7ZAAaAbaK1QWdlSR4C9WiGigWEJKqpPaRxEUzMEoSoNE8n
        CvOeNJxEJUYdvGKSwhFwH/FW1mB7
X-Google-Smtp-Source: ABdhPJzL9EEp5r78RNYso4V7xHXE/gz6xbWKa/IR+miGnLeio4Yj+s3j+T5CMKEk/0dssSW2RkN5iw==
X-Received: by 2002:a65:6786:: with SMTP id e6mr30019082pgr.395.1594346246250;
        Thu, 09 Jul 2020 18:57:26 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (220-245-19-62.static.tpgi.com.au. [220.245.19.62])
        by smtp.gmail.com with ESMTPSA id 7sm3912834pgw.85.2020.07.09.18.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 18:57:25 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Date:   Fri, 10 Jul 2020 11:56:43 +1000
Message-Id: <20200710015646.2020871-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

And get rid of the generic sync_core_before_usermode facility.

This helper is the wrong way around I think. The idea that membarrier
state requires a core sync before returning to user is the easy one
that does not need hiding behind membarrier calls. The gap in core
synchronization due to x86's sysret/sysexit and lazy tlb mode, is the
tricky detail that is better put in x86 lazy tlb code.

Consider if an arch did not synchronize core in switch_mm either, then
membarrier_mm_sync_core_before_usermode would be in the wrong place
but arch specific mmu context functions would still be the right place.
There is also a exit_lazy_tlb case that is not covered by this call, which
could be a bugs (kthread use mm the membarrier process's mm then context
switch back to the process without switching mm or lazy mm switch).

This makes lazy tlb code a bit more modular.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../membarrier-sync-core/arch-support.txt     |  6 +++-
 arch/x86/include/asm/mmu_context.h            | 35 +++++++++++++++++++
 arch/x86/include/asm/sync_core.h              | 28 ---------------
 include/linux/sched/mm.h                      | 14 --------
 include/linux/sync_core.h                     | 21 -----------
 kernel/cpu.c                                  |  4 ++-
 kernel/kthread.c                              |  2 +-
 kernel/sched/core.c                           | 16 ++++-----
 8 files changed, 51 insertions(+), 75 deletions(-)
 delete mode 100644 arch/x86/include/asm/sync_core.h
 delete mode 100644 include/linux/sync_core.h

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 52ad74a25f54..bd43fb1f5986 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -5,6 +5,10 @@
 #
 # Architecture requirements
 #
+# If your architecture returns to user-space through non-core-serializing
+# instructions, you need to ensure these are done in switch_mm and exit_lazy_tlb
+# (if lazy tlb switching is implemented).
+#
 # * arm/arm64/powerpc
 #
 # Rely on implicit context synchronization as a result of exception return
@@ -24,7 +28,7 @@
 # instead on write_cr3() performed by switch_mm() to provide core serialization
 # after changing the current mm, and deal with the special case of kthread ->
 # uthread (temporarily keeping current mm into active_mm) by issuing a
-# sync_core_before_usermode() in that specific case.
+# serializing instruction in exit_lazy_mm() in that specific case.
 #
     -----------------------
     |         arch |status|
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 255750548433..5263863a9be8 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -6,6 +6,7 @@
 #include <linux/atomic.h>
 #include <linux/mm_types.h>
 #include <linux/pkeys.h>
+#include <linux/sched/mm.h>
 
 #include <trace/events/tlb.h>
 
@@ -95,6 +96,40 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
+#ifdef CONFIG_MEMBARRIER
+/*
+ * Ensure that a core serializing instruction is issued before returning
+ * to user-mode, if a SYNC_CORE was requested. x86 implements return to
+ * user-space through sysexit, sysrel, and sysretq, which are not core
+ * serializing.
+ *
+ * See the membarrier comment in finish_task_switch as to why this is done
+ * in exit_lazy_tlb.
+ */
+#define exit_lazy_tlb exit_lazy_tlb
+static inline void exit_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+	/* Switching mm is serializing with write_cr3 */
+        if (tsk->mm != mm)
+                return;
+
+        if (likely(!(atomic_read(&mm->membarrier_state) &
+                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
+                return;
+
+	/* With PTI, we unconditionally serialize before running user code. */
+	if (static_cpu_has(X86_FEATURE_PTI))
+		return;
+	/*
+	 * Return from interrupt and NMI is done through iret, which is core
+	 * serializing.
+	 */
+	if (in_irq() || in_nmi())
+		return;
+	sync_core();
+}
+#endif
+
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
deleted file mode 100644
index c67caafd3381..000000000000
--- a/arch/x86/include/asm/sync_core.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_SYNC_CORE_H
-#define _ASM_X86_SYNC_CORE_H
-
-#include <linux/preempt.h>
-#include <asm/processor.h>
-#include <asm/cpufeature.h>
-
-/*
- * Ensure that a core serializing instruction is issued before returning
- * to user-mode. x86 implements return to user-space through sysexit,
- * sysrel, and sysretq, which are not core serializing.
- */
-static inline void sync_core_before_usermode(void)
-{
-	/* With PTI, we unconditionally serialize before running user code. */
-	if (static_cpu_has(X86_FEATURE_PTI))
-		return;
-	/*
-	 * Return from interrupt and NMI is done through iret, which is core
-	 * serializing.
-	 */
-	if (in_irq() || in_nmi())
-		return;
-	sync_core();
-}
-
-#endif /* _ASM_X86_SYNC_CORE_H */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 480a4d1b7dd8..9b026264b445 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -7,7 +7,6 @@
 #include <linux/sched.h>
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
-#include <linux/sync_core.h>
 
 /*
  * Routines for handling mm_structs
@@ -364,16 +363,6 @@ enum {
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
 
 #else
@@ -387,9 +376,6 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 static inline void membarrier_exec_mmap(struct mm_struct *mm)
 {
 }
-static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
-{
-}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/include/linux/sync_core.h b/include/linux/sync_core.h
deleted file mode 100644
index 013da4b8b327..000000000000
--- a/include/linux/sync_core.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_SYNC_CORE_H
-#define _LINUX_SYNC_CORE_H
-
-#ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
-#include <asm/sync_core.h>
-#else
-/*
- * This is a dummy sync_core_before_usermode() implementation that can be used
- * on all architectures which return to user-space through core serializing
- * instructions.
- * If your architecture returns to user-space through non-core-serializing
- * instructions, you need to write your own functions.
- */
-static inline void sync_core_before_usermode(void)
-{
-}
-#endif
-
-#endif /* _LINUX_SYNC_CORE_H */
-
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..134688d79589 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -572,7 +572,9 @@ static int finish_cpu(unsigned int cpu)
 
 	/*
 	 * idle_task_exit() will have switched to &init_mm, now
-	 * clean up any remaining active_mm state.
+	 * clean up any remaining active_mm state. exit_lazy_tlb
+	 * is not done, if an arch did any accounting in these
+	 * functions it would have to be added.
 	 */
 	if (mm != &init_mm)
 		idle->active_mm = &init_mm;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index e813d92f2eab..6f93c649aa97 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1251,9 +1251,9 @@ void kthread_use_mm(struct mm_struct *mm)
 	finish_arch_post_lock_switch();
 #endif
 
+	exit_lazy_tlb(active_mm, tsk);
 	if (active_mm != mm)
 		mmdrop(active_mm);
-	exit_lazy_tlb(active_mm, tsk);
 
 	to_kthread(tsk)->oldfs = get_fs();
 	set_fs(USER_DS);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index debc917bc69b..31e22c79826c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3294,22 +3294,19 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	kcov_finish_switch(current);
 
 	fire_sched_in_preempt_notifiers(current);
+
 	/*
 	 * When switching through a kernel thread, the loop in
 	 * membarrier_{private,global}_expedited() may have observed that
 	 * kernel thread and not issued an IPI. It is therefore possible to
 	 * schedule between user->kernel->user threads without passing though
-	 * switch_mm(). Membarrier requires a barrier after storing to
-	 * rq->curr, before returning to userspace, so provide them here:
-	 *
-	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
-	 *   provided by mmdrop(),
-	 * - a sync_core for SYNC_CORE.
+	 * switch_mm(). Membarrier requires a full barrier after storing to
+	 * rq->curr, before returning to userspace, for
+	 * {PRIVATE,GLOBAL}_EXPEDITED. This is implicitly provided by mmdrop().
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
@@ -6292,6 +6289,7 @@ void idle_task_exit(void)
 	BUG_ON(current != this_rq()->idle);
 
 	if (mm != &init_mm) {
+		/* enter_lazy_tlb is not done because we're about to go down */
 		switch_mm(mm, &init_mm, current);
 		finish_arch_post_lock_switch();
 	}
-- 
2.23.0

