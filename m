Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7121ACAF
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJB5i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 21:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGJB5g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 21:57:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F4C08C5CE;
        Thu,  9 Jul 2020 18:57:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so3940391pjb.1;
        Thu, 09 Jul 2020 18:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lq+5YyzIbnzKrC5WXbMgZS97wejAnzujpqVbQxvF/Lw=;
        b=O7+ulI/LRglcP5qCLuMbbgD0ofzWmJwZEblGzJ+okVuGkOiR2gTyC03zrMjdXEH0hB
         5Gaw0vVEYTp/Qit2rqR8IwLbwn7QiKgsDKG0Fd7Xj2HiGjxd3aUPrm5RTkEYO3SLArfy
         CHQUEdv8xru96CJgIzueA831qH9INkjuVQSpgeUmTYZvUpsq+S9dcwtGqnUqc4Ff/XnN
         98BCZh90kPt0oy7qNLowjzgpHH4fVv1tL6+BRsfo2l0lALCrdOaf7pBzecCBEWfR17te
         Ct71OUJd6ZG2tIibzIJLu0lpZD31xXWBnaPD4lvungG6xgPkYsKnz/NsfKtkTikcts8Z
         yxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lq+5YyzIbnzKrC5WXbMgZS97wejAnzujpqVbQxvF/Lw=;
        b=XG8Ia8HitGf9WIC0/YMaU/Yvm3zuVvJwNoDLa7Un8zodxHs2pYql1PTUc+N+DlkGko
         lsortwCydoJ14/tFpNJsNUtir3NBBFFIxFRi+J2zQa9VdCABuNL67G88z6C7iNxkHEt0
         gYzsUS4dkGHoMi6JePboui6ztzIkCPg4Y7p9c8bGSFg7uZ7H+hKQk+Myoa+z7ikXBOnl
         OQGYSw2sAo4APwSbffv9DMg3KwANwiXjvTWHq0Pr2OZAYppBLYiB9YZJf+Fg0PQIexMP
         euQm505xVk7INpjL/4n213V0rc6gi2DLLrj5Ku7CJdRbcL9TIxn/mGBrk9RRHCKjzxB1
         Tgng==
X-Gm-Message-State: AOAM533fHO1Nbr4j7UFmZOO5MAr5tYF9yy5+Ns+L7G0I33qzaTca086D
        N6rKiHQiJmanXcRCwDCpBU/PO5cb
X-Google-Smtp-Source: ABdhPJzyKsV6YEQg8K0l5yERbWIQQgXyBnhpP546f8l96ub+MkrLebwuhaNiEd0fTTPWSKV0eL1Jog==
X-Received: by 2002:a17:90a:7185:: with SMTP id i5mr3327864pjk.170.1594346256131;
        Thu, 09 Jul 2020 18:57:36 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (220-245-19-62.static.tpgi.com.au. [220.245.19.62])
        by smtp.gmail.com with ESMTPSA id 7sm3912834pgw.85.2020.07.09.18.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 18:57:35 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [RFC PATCH 6/7] lazy tlb: allow lazy tlb mm switching to be configurable
Date:   Fri, 10 Jul 2020 11:56:45 +1000
Message-Id: <20200710015646.2020871-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

NOMMU systems could easily go without this and save a bit of code
and the mm refcounting, because their mm switch is a no-op. I haven't
flipped them over because haven't audited all arch code to convert
over to using the _lazy_tlb refcounting.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig             |  7 +++++
 include/linux/sched/mm.h | 12 ++++++---
 kernel/sched/core.c      | 55 +++++++++++++++++++++++++++-------------
 kernel/sched/sched.h     |  4 ++-
 4 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..2daf8fe6146a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -411,6 +411,13 @@ config MMU_GATHER_NO_GATHER
 	bool
 	depends on MMU_GATHER_TABLE_FREE
 
+# Would like to make this depend on MMU, because there is little use for lazy mm switching
+# with NOMMU, but have to audit NOMMU architecture code first.
+config MMU_LAZY_TLB
+	def_bool y
+	help
+	  Enable "lazy TLB" mmu context switching for kernel threads.
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 110d4ad21de6..2c2b20e2ccc7 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -53,18 +53,22 @@ void mmdrop(struct mm_struct *mm);
 /* Helpers for lazy TLB mm refcounting */
 static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
-	mmgrab(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+		mmgrab(mm);
 }
 
 static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 {
-	mmdrop(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+		mmdrop(mm);
 }
 
 static inline void mmdrop_lazy_tlb_smp_mb(struct mm_struct *mm)
 {
-	/* This depends on mmdrop providing a full smp_mb() */
-	mmdrop(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+		mmdrop(mm); /* This depends on mmdrop providing a full smp_mb() */
+	else
+		smp_mb();
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d19f2f517f6c..14b4fae6f6e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3253,7 +3253,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
+	struct mm_struct *mm = NULL;
 	long prev_state;
 
 	/*
@@ -3272,7 +3272,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
+#ifdef CONFIG_MMU_LAZY_TLB
+	mm = rq->prev_lazy_mm;
+	rq->prev_lazy_mm = NULL;
+#endif
 
 	/*
 	 * A task struct has one reference for the use as "current".
@@ -3393,22 +3396,11 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
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
+#ifdef CONFIG_MMU_LAZY_TLB
 	/*
 	 * kernel -> kernel   lazy + transfer active
 	 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
@@ -3440,10 +3432,37 @@ context_switch(struct rq *rq, struct task_struct *prev,
 			exit_lazy_tlb(prev->active_mm, next);
 
 			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
-			rq->prev_mm = prev->active_mm;
+			rq->prev_lazy_mm = prev->active_mm;
 			prev->active_mm = NULL;
 		}
 	}
+#else
+	if (!next->mm)
+		next->active_mm = &init_mm;
+	membarrier_switch_mm(rq, prev->active_mm, next->active_mm);
+	switch_mm_irqs_off(prev->active_mm, next->active_mm, next);
+	if (!prev->mm)
+		prev->active_mm = NULL;
+#endif
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
+	context_switch_mm(rq, prev, next);
 
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 877fb08eb1b0..b196dd885d33 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -929,7 +929,9 @@ struct rq {
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-	struct mm_struct	*prev_mm;
+#ifdef CONFIG_MMU_LAZY_TLB
+	struct mm_struct	*prev_lazy_mm;
+#endif
 
 	unsigned int		clock_update_flags;
 	u64			clock;
-- 
2.23.0

