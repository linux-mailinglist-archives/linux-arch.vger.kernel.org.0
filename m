Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB239C4DA
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 03:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFEBoY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 21:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEBoY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 21:44:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D172C061766;
        Fri,  4 Jun 2021 18:42:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u126so4715014pfu.13;
        Fri, 04 Jun 2021 18:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8uxX4t8g+DxGYDGoM+1rG8fWNFKPCHDobEAy7P79JU=;
        b=t/BsozX+HKFZD2zebtgF3JGrIwCTcVj4ffmsJERRbi/MNaFuO3WFo3bmI7M7Pw7IDj
         5k7ho9NFtodvy2hED8NQ029kOKEcm+emddzxclcV+A/9uFGxWtrrqyVwZBqBZQayVv8o
         uvzpSo3qbCEaRJsIsMf83kmaSWU82D3nQyk4UoworXY/8rBuy0UT3gajZ92D9fUUpVvL
         nkRMAM3yjYbObExBGVtCTrrn8upzvtdmLXXteWz7/0ii5TkWeGOPk21w9hgHzbsJtd4n
         8a+HzVHQmMqiendjAtp1CC0CeIVqy3BZs61INz/EoX+TblkTnx0ukJD5mdWH0Ta+yWQq
         0Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8uxX4t8g+DxGYDGoM+1rG8fWNFKPCHDobEAy7P79JU=;
        b=jvMX1RY1IwmoUtShecHs3l0pLldmTyaZSBm8jSfvl0fkiluOsrHH2LYoC/SaIJB/1R
         tPZtfZO4/YqNJ/bCB9Fmv8dsYjND81YGgz+QFGXD+z8E4waei/ngk8XxbVmu9LpDgeA3
         pF3qIdYP3gxpUzlbThPUzw1ILIFhawgEA8JWnI/muI3+2UGvi3OqhZ4SZbrElNyEwD66
         kPiwY1yTGAPo0ppUzSciea0tUx3PPgitsmr71Q/Yb1Zqfp3Qklbtw+74wCobCDnjcsqo
         yGp27f1MZuIheOfSiLL+15v+cic5D6ltXNdVTUvQCPeOfY6sJE2H9mDW0PlTiml7ZyEQ
         qivg==
X-Gm-Message-State: AOAM532j/uwP70VsEI/mQbEMjJhAn2Tv3ytpXiyZCe8uW3NNcV81BcVt
        VwTw0BtedivS11+OJS4oTOI=
X-Google-Smtp-Source: ABdhPJyaiJ+cifU73dwUkfKSCUG8g6xUPympTQc18g/8gDitQusrenWMupQEWYNpZsq0HZ+33JFCOQ==
X-Received: by 2002:aa7:900f:0:b029:2ec:82d2:d23 with SMTP id m15-20020aa7900f0000b02902ec82d20d23mr5855353pfo.16.1622857354192;
        Fri, 04 Jun 2021 18:42:34 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id q68sm5779056pjq.45.2021.06.04.18.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:42:33 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be configurable
Date:   Sat,  5 Jun 2021 11:42:14 +1000
Message-Id: <20210605014216.446867-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210605014216.446867-1-npiggin@gmail.com>
References: <20210605014216.446867-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
when it is context switched. This can be disabled by architectures that
don't require this refcounting if they clean up lazy tlb mms when the
last refcount is dropped. Currently this is always enabled, which is
what existing code does, so the patch is effectively a no-op.

Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig             |  4 ++++
 include/linux/sched/mm.h | 13 +++++++++++--
 kernel/sched/core.c      | 22 ++++++++++++++++++----
 kernel/sched/sched.h     |  4 +++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c45b770d3579..1cff045cdde6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,10 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  irqs disabled over activate_mm. Architectures that do IPI based TLB
 	  shootdowns should enable this.
 
+# Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
+config MMU_LAZY_TLB_REFCOUNT
+	def_bool y
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
index e359c76ea2e2..5e10cb712be3 100644
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
@@ -4326,9 +4329,20 @@ context_switch(struct rq *rq, struct task_struct *prev,
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
+			 * Without MMU_LAZY_TLB_REFCOUNT there is no lazy
+			 * tracking (because no rq->prev_lazy_mm) in
+			 * finish_task_switch, so no mmdrop_lazy_tlb(), so no
+			 * memory barrier for membarrier (see the membarrier
+			 * comment in finish_task_switch()).  Do it here.
+			 */
+			smp_mb();
+#endif
 		}
 	}
 
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

