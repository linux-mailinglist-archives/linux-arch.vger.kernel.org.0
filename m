Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E006A2C72A1
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgK1VuN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgK1S3l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:29:41 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24AC0258F3;
        Sat, 28 Nov 2020 08:02:14 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so6708885pgi.11;
        Sat, 28 Nov 2020 08:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74N67GuHsAKlUQCHO+8oJizzPlrfnBq33d6B/Ovug1c=;
        b=VkLwTGPmwmZvnPJHpLNIUbEQ3XRa/sOpBoQE2Sgr7xSLqciwk0q3eYNRAupvsW9v3M
         0Lwkb6wKoJjwhSbv10vfipxeq0nYWJtscGMbipiKOasgKYbjQ1+8k2J3ZSDqVgpZw+5k
         a0bQ7fDQGWs1BdqUP9p3zbwz3Ygx6Vnnnu13rHLs+Q77qJ10HfJ8afd4voMDkqzvYBSH
         Whs7pDJNUlUjHy2MHiGrJrMJ+l+1Mpi7jTugmuKoprsToU4KTqKcb0S7wxDlNskhFhX8
         kNnwDm1ODJbdMOAOQzpbbfnXq1HicbPfvzXdxI+O6MnJQTmxQ7fKgfP4rLg2TsEqStX4
         pbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74N67GuHsAKlUQCHO+8oJizzPlrfnBq33d6B/Ovug1c=;
        b=a6h0r+4Hz8wZROSg4vh04DiUXWX2N8NrksOtrGKKXu/pzfZ5LIAi/89QpGLPAadftc
         Da3hOP4UTqjxO87AkRSq715NVPSpIm72oXH9yQZ1Ho60Za5MiCleoo9h3oPnEOxYRp8B
         eeMGvTlJHqHiD6Y7ljkWz6zRUrw5gLxGB3Wspc3CB+kSDvTKzgdHLa2TB43GcDgOBnDG
         EL26hXLMNaHxBtonTnCFE8sx1Z2Kzyrs9jJVyUMhkw7ypICILsCF8guepmIId2PFEm06
         tuGKFdmsZADjB7gM6pTuHT1gUQvr5RVllugoOEiL6GaBOlC/BQlrckSQYUbyuLW6pH9O
         gGSQ==
X-Gm-Message-State: AOAM531pdIMJfte7BuvUqd7ToF9KRY2aia0dcmMFLyFZdRQJvUB/r/SZ
        534fwH6SFvUTkd0IPGEg5VdAhng5RUk=
X-Google-Smtp-Source: ABdhPJwxDwD+9zFmjMFp1FY1SUXYVEy5AQmGVT0CSX61N4g2WeQJxNZHGbtbroa2pwOuEZsmwpocJg==
X-Received: by 2002:a17:90a:a50b:: with SMTP id a11mr17214934pjq.170.1606579333519;
        Sat, 28 Nov 2020 08:02:13 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:02:13 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 5/8] lazy tlb: allow lazy tlb mm switching to be configurable
Date:   Sun, 29 Nov 2020 02:01:38 +1000
Message-Id: <20201128160141.1003903-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

NOMMU systems could easily go without this and save a bit of code
and the refcount atomics, because their mm switch is a no-op. I
haven't flipped them over because haven't audited all arch code to
convert over to using the _lazy_tlb refcounting.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig             | 11 +++++++
 include/linux/sched/mm.h | 13 ++++++--
 kernel/sched/core.c      | 68 +++++++++++++++++++++++++++++-----------
 kernel/sched/sched.h     |  4 ++-
 4 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..596bf589d74b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -430,6 +430,17 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  irqs disabled over activate_mm. Architectures that do IPI based TLB
 	  shootdowns should enable this.
 
+# Should make this depend on MMU, because there is little use for lazy mm switching
+# with NOMMU. Must audit NOMMU architecture code for lazy mm refcounting first.
+config MMU_LAZY_TLB
+	def_bool y
+	help
+	  Enable "lazy TLB" mmu context switching for kernel threads.
+
+config MMU_LAZY_TLB_REFCOUNT
+	def_bool y
+	depends on MMU_LAZY_TLB
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 7157c0f6fef8..bd0f27402d4b 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -51,12 +51,21 @@ static inline void mmdrop(struct mm_struct *mm)
 /* Helpers for lazy TLB mm refcounting */
 static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
-	mmgrab(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
+		mmgrab(mm);
 }
 
 static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 {
-	mmdrop(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
+		mmdrop(mm);
+	} else {
+		/*
+		 * mmdrop_lazy_tlb must provide a full memory barrier, see the
+		 * membarrier comment finish_task_switch.
+		 */
+		smp_mb();
+	}
 }
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e372b613d514..3b79c6cc3a37 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3579,7 +3579,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
+	struct mm_struct *mm = NULL;
 	long prev_state;
 
 	/*
@@ -3598,7 +3598,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+	mm = rq->prev_lazy_mm;
+	rq->prev_lazy_mm = NULL;
+#endif
 
 	/*
 	 * A task struct has one reference for the use as "current".
@@ -3630,6 +3633,8 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * rq->curr, before returning to userspace, for
 	 * {PRIVATE,GLOBAL}_EXPEDITED. This is implicitly provided by
 	 * mmdrop_lazy_tlb().
+	 *
+	 * This same issue applies to other places that mmdrop_lazy_tlb().
 	 */
 	if (mm)
 		mmdrop_lazy_tlb(mm);
@@ -3719,22 +3724,10 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	calculate_sigpending();
 }
 
-/*
- * context_switch - switch to the new MM and the new thread's register state.
- */
-static __always_inline struct rq *
-context_switch(struct rq *rq, struct task_struct *prev,
-	       struct task_struct *next, struct rq_flags *rf)
+static __always_inline void
+context_switch_mm(struct rq *rq, struct task_struct *prev,
+	       struct task_struct *next)
 {
-	prepare_task_switch(rq, prev, next);
-
-	/*
-	 * For paravirt, this is coupled with an exit in switch_to to
-	 * combine the page table reload and the switch backend into
-	 * one hypercall.
-	 */
-	arch_start_context_switch(prev);
-
 	/*
 	 * kernel -> kernel   lazy + transfer active
 	 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
@@ -3765,11 +3758,50 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		if (!prev->mm) {                        // from kernel
 			exit_lazy_tlb(prev->active_mm, next);
 
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
 			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
-			rq->prev_mm = prev->active_mm;
+			rq->prev_lazy_mm = prev->active_mm;
 			prev->active_mm = NULL;
+#else
+			/* See membarrier comment in finish_task_switch(). */
+			smp_mb();
+#endif
 		}
 	}
+}
+
+static __always_inline void
+context_switch_mm_nolazy(struct rq *rq, struct task_struct *prev,
+	       struct task_struct *next)
+{
+	if (!next->mm)
+		next->active_mm = &init_mm;
+	membarrier_switch_mm(rq, prev->active_mm, next->active_mm);
+	switch_mm_irqs_off(prev->active_mm, next->active_mm, next);
+	if (!prev->mm)
+		prev->active_mm = NULL;
+}
+
+/*
+ * context_switch - switch to the new MM and the new thread's register state.
+ */
+static __always_inline struct rq *
+context_switch(struct rq *rq, struct task_struct *prev,
+	       struct task_struct *next, struct rq_flags *rf)
+{
+	prepare_task_switch(rq, prev, next);
+
+	/*
+	 * For paravirt, this is coupled with an exit in switch_to to
+	 * combine the page table reload and the switch backend into
+	 * one hypercall.
+	 */
+	arch_start_context_switch(prev);
+
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+		context_switch_mm(rq, prev, next);
+	else
+		context_switch_mm_nolazy(rq, prev, next);
 
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..3b72aec5a2f2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -950,7 +950,9 @@ struct rq {
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-	struct mm_struct	*prev_mm;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+	struct mm_struct	*prev_lazy_mm;
+#endif
 
 	unsigned int		clock_update_flags;
 	u64			clock;
-- 
2.23.0

