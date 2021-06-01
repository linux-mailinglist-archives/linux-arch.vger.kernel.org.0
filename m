Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD764396D48
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jun 2021 08:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhFAGZG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Jun 2021 02:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhFAGZE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jun 2021 02:25:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08676C061756;
        Mon, 31 May 2021 23:23:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so1242941pjq.3;
        Mon, 31 May 2021 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B2ZM54o9Bp1W7ui49t2FYRDuyLvPHwC8Il/uTHhhdMs=;
        b=XDJ2kYvmv/Z5M24qrG7KDMUE9p7aJ0RlQOBX1p/t2w4hIRyxR6UjTzA19/wWm8wdfC
         2bssCYG5blnj9LMkj0KYjULkjvgmSvquyWjePNQYm//MxqhrHejkK0QcMGRIOOJbMpox
         7lTAot474lVNko8WQIRuPXUlRf3A83o42kAVvfnakMYQ5V5QvGDcEzfdLv1MpTxUKbNv
         e+S+jSKkwHUTddDHEL3mGYjuaQDAWQaGCy1sXxnPFkwfKdci8juvdPKPN8bYXqfSQPrI
         UD3u5SitNYnPXIjG3reVtT1Z66MrR1ddVVxfrlRrOkUzRhQFpbERqoAxcac1BEAeYuRK
         nDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B2ZM54o9Bp1W7ui49t2FYRDuyLvPHwC8Il/uTHhhdMs=;
        b=BtgkB/UYmbtvVYw5kZteocobI+0sLEAmkxHujE59SjJKBuu2wZFpGzl6GqftyUsGde
         RGuab/CLvUba2QeKdpZCRERItxI3gU2sOXnYBzFyF14ApbluJMtk8A+U0sV8Vznb/hRb
         RZXv2sJXoHRNGxtIghex6TScsJu7pVnBiIS3vlqhWk6vbExMojzoHzp60A3QiD3yC1rQ
         qXcJW3fLz3ujBGRPtwr5SOql8uaNTRRfCZvj2J6fMZMYOKI4GImes5/+P4FdDkoJ09qh
         9JIFK3lyImAe0q1nQDX2h83hB9JCxn2W5ipyOGd9c+QyguNqM2eYPI4GzMxrqke/r8oj
         T0YQ==
X-Gm-Message-State: AOAM532U7p8Kv3JKRfK93lk+QWfsHAYcH9PV/IKpkRKFAt882dx2byrK
        ecT4Hu3kJFPu5v0fHqwD2WA=
X-Google-Smtp-Source: ABdhPJy2DUM8gibAhLieX5iGh16ca9VDqhVgs0t9sh7k8/bnT7er59ZtGvorelTu6yvv6DxaKgwUsw==
X-Received: by 2002:a17:90b:3587:: with SMTP id mm7mr21958255pjb.71.1622528599607;
        Mon, 31 May 2021 23:23:19 -0700 (PDT)
Received: from bobo.ibm.com (60-241-69-122.static.tpgi.com.au. [60.241.69.122])
        by smtp.gmail.com with ESMTPSA id h1sm12519100pfh.72.2021.05.31.23.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 23:23:19 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 2/4] lazy tlb: allow lazy tlb mm switching to be configurable
Date:   Tue,  1 Jun 2021 16:23:01 +1000
Message-Id: <20210601062303.3932513-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210601062303.3932513-1-npiggin@gmail.com>
References: <20210601062303.3932513-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CONFIG_MMU_LAZY_TLB which can be configured out to disable the lazy
tlb mechanism entirely, and switches to init_mm when switching to a
kernel thread.

NOMMU systems could easily go without this and save a bit of code and
the refcount atomics, because their mm switch is a no-op. They have not
been switched over by default because the arch code needs to be audited
and tested for lazy tlb mm refcounting and converted to _lazy_tlb
refcounting if necessary.

CONFIG_MMU_LAZY_TLB_REFCOUNT is also added, but it must always be
enabled if CONFIG_MMU_LAZY_TLB is enabled until the next patch which
provides an alternate scheme.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig             | 26 ++++++++++++++
 include/linux/sched/mm.h | 13 +++++--
 kernel/sched/core.c      | 75 ++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h     |  4 ++-
 4 files changed, 96 insertions(+), 22 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c45b770d3579..276e1c1c0219 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,32 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  irqs disabled over activate_mm. Architectures that do IPI based TLB
 	  shootdowns should enable this.
 
+# Enable "lazy TLB", which means a user->kernel thread context switch does not
+# switch the mm to init_mm and the kernel thread takes a reference to the user
+# mm to provide its kernel mapping. This is how Linux has traditionally worked
+# (see Documentation/vm/active_mm.rst), for performance. Switching to and from
+# idle thread is a performance-critical case.
+#
+# If mm context switches are inexpensive or free (in the case of NOMMU) then
+# this could be disabled.
+#
+# It would make sense to have this depend on MMU, but need to audit and test
+# the NOMMU architectures for lazy mm refcounting first.
+config MMU_LAZY_TLB
+	def_bool y
+	depends on !NO_MMU_LAZY_TLB
+
+# This allows archs to disable MMU_LAZY_TLB. mmgrab/mmdrop in arch/ code has
+# to be audited and switched to _lazy_tlb postfix as necessary.
+config NO_MMU_LAZY_TLB
+	def_bool n
+
+# Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
+# For now, this must be enabled if MMU_LAZY_TLB is enabled.
+config MMU_LAZY_TLB_REFCOUNT
+	def_bool y
+	depends on MMU_LAZY_TLB
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index bfd1baca5266..29e4638ad124 100644
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
index e359c76ea2e2..299c3eb12b2b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4171,7 +4171,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
+	struct mm_struct *mm = NULL;
 	long prev_state;
 
 	/*
@@ -4190,7 +4190,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+	mm = rq->prev_lazy_mm;
+	rq->prev_lazy_mm = NULL;
+#endif
 
 	/*
 	 * A task struct has one reference for the use as "current".
@@ -4282,22 +4285,10 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
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
@@ -4326,11 +4317,57 @@ context_switch(struct rq *rq, struct task_struct *prev,
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
index a189bec13729..0729cf19a987 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -961,7 +961,9 @@ struct rq {
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

