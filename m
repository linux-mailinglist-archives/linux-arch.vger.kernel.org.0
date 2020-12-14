Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C402D937B
	for <lists+linux-arch@lfdr.de>; Mon, 14 Dec 2020 08:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407125AbgLNHCF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Dec 2020 02:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407124AbgLNHCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2020 02:02:03 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62AC0613D3;
        Sun, 13 Dec 2020 23:01:23 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id j1so8141986pld.3;
        Sun, 13 Dec 2020 23:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTzD/PwVnUryCFsCtBkXOLSBdB20HGAb9puUxId4JVk=;
        b=IR9n6Xx3XA7TWORm+admowft3H2sA37sBIcd+GaFLOP0qFk15JB6uoOrHhMuzatwsC
         HQ26+f50MnEXp3JmLnlvTNWfB67/uTwwboaOXijLrWMS6goDqh1RGiVPj6YwHXedhuRY
         ONdoimeRGscvIVFc1AQRLCydCRLvZxavxCIVqjhlqtBuGaHa2ynhR8Y6wfovleCF/YR/
         8TzsXLnt+Plc6HEfBAzkyeRebiyMGgTwde7hSwzi50i/1jG056NrAeoOuUjU7F6IIrfA
         Pj80cWPZLza80QoJ00gbstNsZK2bmcjZeoCU3aGM10vTa0vfEgq5iccJ+843aJqUDBJn
         V/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTzD/PwVnUryCFsCtBkXOLSBdB20HGAb9puUxId4JVk=;
        b=HoQcgMuQlgHH547uVsBFGAKLicfTjaEskVWli7YpkdgoEsDLkz/rdTnCABxVfz2dEp
         s4UCu55i/kXqAmLkLpQPCeEg0ZyzpBH+8huaN4ymK3ctTz9Gx5OsGG4aTcHGOINd3yT0
         /eKD5esVD6i5NPvDmGgxon+VYtkzXB1rHOxJpcZKRQnB2ZColhafGX4E33fi6JZVQjfe
         KlLB5E6Usxq6k3ryzTX7LFA2JNBGDJxyYqwYDtWKO5EVUxGwxl9tDQ+l772Yu167Vm8U
         yiyxfJoJbCMncFS2Lgfekp76P6IGdmt+eOz44SIbk1wnjKWCsFQEPcVUXnq9RatSZNId
         v7eg==
X-Gm-Message-State: AOAM5322pQbOzTHYEkBdqO7sf4oCr7tZZV5HpJh/Unwtbfwdw9ue5J2M
        M3d6reidVn6zYAfMhTO+h1jY4Oto9pU=
X-Google-Smtp-Source: ABdhPJwxGbCiA5g+oFBRL0MsR3yqlxPJyXmC3pmGD+mzl4QTJz+fHRqE9o5Gyew/trGb6oI0bDkZuQ==
X-Received: by 2002:a17:902:7887:b029:dc:20e:47ff with SMTP id q7-20020a1709027887b02900dc020e47ffmr2078675pll.65.1607929282651;
        Sun, 13 Dec 2020 23:01:22 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id 84sm19570018pfy.9.2020.12.13.23.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 23:01:22 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/5] lazy tlb: allow lazy tlb mm switching to be configurable
Date:   Mon, 14 Dec 2020 16:53:09 +1000
Message-Id: <20201214065312.270062-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201214065312.270062-1-npiggin@gmail.com>
References: <20201214065312.270062-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CONFIG_MMU_LAZY_TLB which can be configured out to disable
the lazy tlb mechanism entirely, and switches to init_mm when
switching to a kernel thread.

NOMMU systems could easily go without this and save a bit of code
and the refcount atomics, because their mm switch is a no-op. They
have not been switched over by default because the arch code needs
to be audited and tested for lazy tlb mm refcounting and converted
to _lazy_tlb refcounting if necessary.

CONFIG_MMU_LAZY_TLB_REFCOUNT is also added, but it must always
be enabled if CONFIG_MMU_LAZY_TLB is enabled until the next patch
which provides an alternate scheme.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig             | 17 +++++++++
 include/linux/sched/mm.h | 13 +++++--
 kernel/sched/core.c      | 75 ++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h     |  4 ++-
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ba4e966484ab..84faaba66364 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -430,6 +430,23 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  irqs disabled over activate_mm. Architectures that do IPI based TLB
 	  shootdowns should enable this.
 
+# Should make this depend on MMU, because there is little use for lazy mm switching
+# with NOMMU. Must audit NOMMU architecture code for lazy mm refcounting first.
+config MMU_LAZY_TLB
+	def_bool y
+	help
+	  Enable "lazy TLB" mmu context switching for kernel threads.
+	  If this is disabled then switching to a kernel thread always
+	  switches to init_mm. If mm switches are inexpensive or free
+	  (in the case of NOMMU) then this could be disabled.
+
+config MMU_LAZY_TLB_REFCOUNT
+	def_bool y
+	depends on MMU_LAZY_TLB
+	help
+	  This must be enabled if MMU_LAZY_TLB is enabled until the next
+	  patch.
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 94a117160083..5edf8e942c84 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -52,12 +52,21 @@ static inline void mmdrop(struct mm_struct *mm)
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
+		 * membarrier comment finish_task_switch which relies on this.
+		 */
+		smp_mb();
+	}
 }
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c2f8ea43d29b..9c1dc9406e4b 100644
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
@@ -3722,22 +3725,10 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
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
@@ -3766,11 +3757,57 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
-			rq->prev_mm = prev->active_mm;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+			/* Will mmdrop_lazy_tlb() in finish_task_switch(). */
+			rq->prev_lazy_mm = prev->active_mm;
 			prev->active_mm = NULL;
+#else
+			/*
+			 * Without MMU_LAZY_REFCOUNT there is no lazy
+			 * tracking (because no rq->prev_lazy_mm) in
+			 * finish_task_switch, so no mmdrop_lazy_tlb(),
+			 * so no memory barrier for membarrier (see the
+			 * membarrier comment in finish_task_switch()).
+			 * Do it here.
+			 */
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

