Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC302C729E
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbgK1VuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbgK1S17 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:27:59 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847EBC0258F0;
        Sat, 28 Nov 2020 08:02:00 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so6718764pga.7;
        Sat, 28 Nov 2020 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Twyf0/RNSa3vRRlfp1Oet03l6vxb8aXJKdhGNWclcs=;
        b=tOVJyMY59cAHL0Zzh3IdRygvgG/jwamJDHuys8IGkS0xRl9q8lB2RMbbQR9JlnInyL
         Eiuv17njNNKkWNknihj7Gt/Y7sYfrxSdsi8OC7T/3P/067pVTZC+d6GwyK3b+oxynnHv
         ualnu2jlm8a7xOIh0iPc0la4kJAcrDbOYjgazdmLJTBG3CCm2GZT9ruRdlt+io/y2DTA
         aei7B3l2rG8ORKFGCWYu5he3af+ipX4rgqppNP+1mnOSxSOHvlzwY6p9/sqY9ECmBnHP
         u2Uj3PTMr7YGFUnRDq3YRKNrLuM3DfdvKxH7KW1/3XGwL0QQe7tOEpxh9XVVA/35Gknb
         kQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Twyf0/RNSa3vRRlfp1Oet03l6vxb8aXJKdhGNWclcs=;
        b=hP34e20CU9o4AaHIPw6e4UhS1zacrDd56C6T+4W7nqPFTP7XNxqS5u3gSLjBmSWUTw
         mgFTykx6VtXD7hW4mKu8WAQ+KJTfo25WudzPeG/B1MSzC4/gi5aHMMj8RxrmjJX+h8Vv
         kJ6Mq9l3m2K/s08YzwYQVLqzIbQ76foliznB1fZHkb/o/orWMLL+Ghy/os1sAN8kEPwg
         FH4zC/5H6L3Mii33eeT2Rl3YGXXr2KQRnUK6eSpDpCdnJYodoScJ33RcCrcvkIIKXmmy
         w6nMaa72CzCjLoCHxp+0gssIqqZZh9Vn6iC8dco+vsLXAKWvzR870ICxi3DchMcEPuZM
         Ia+g==
X-Gm-Message-State: AOAM531iA7g4KLcI0R2mC/4Pfu1AZJHFgMiV4MUThy+IeXd4XXjnWrkp
        tWfiWyLRk1umC32xoMZa5g9y8MYQ9pY=
X-Google-Smtp-Source: ABdhPJwmFPhtuAX9fmgjTV1NdLL+hs+IbGGuWhOPDdSX9td7UVffTtdAIrAze3tOKAkjX2mNhJn8wA==
X-Received: by 2002:a17:90a:460b:: with SMTP id w11mr16545731pjg.12.1606579319860;
        Sat, 28 Nov 2020 08:01:59 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:01:59 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 2/8] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Date:   Sun, 29 Nov 2020 02:01:35 +1000
Message-Id: <20201128160141.1003903-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

And get rid of the generic sync_core_before_usermode facility. This is
functionally a no-op in the core scheduler code, but it also catches

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
 .../membarrier-sync-core/arch-support.txt     |  6 ++++-
 arch/x86/include/asm/mmu_context.h            | 27 +++++++++++++++++++
 include/linux/sched/mm.h                      | 14 ----------
 kernel/cpu.c                                  |  4 ++-
 kernel/sched/core.c                           | 16 +++++------
 5 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 47e6903f47a5..0763a63a7097 100644
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
index 36afcbea6a9f..8094893254f1 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -6,12 +6,14 @@
 #include <linux/atomic.h>
 #include <linux/mm_types.h>
 #include <linux/pkeys.h>
+#include <linux/sched/mm.h>
 
 #include <trace/events/tlb.h>
 
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/sync_core.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -94,6 +96,31 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
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
+	sync_core_before_usermode();
+}
+#endif
+
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d5ece7a9a403..2c6bcdf76d99 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -7,7 +7,6 @@
 #include <linux/sched.h>
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
-#include <linux/sync_core.h>
 
 /*
  * Routines for handling mm_structs
@@ -335,16 +334,6 @@ enum {
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
@@ -358,9 +347,6 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 static inline void membarrier_exec_mmap(struct mm_struct *mm)
 {
 }
-static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
-{
-}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dcc46039ade5..e4e8cebd82e2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3620,22 +3620,19 @@ static struct rq *finish_task_switch(struct task_struct *prev)
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
@@ -6689,6 +6686,7 @@ void idle_task_exit(void)
 	BUG_ON(current != this_rq()->idle);
 
 	if (mm != &init_mm) {
+		/* enter_lazy_tlb is not done because we're about to go down */
 		switch_mm(mm, &init_mm, current);
 		finish_arch_post_lock_switch();
 	}
-- 
2.23.0

