Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14419396D46
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jun 2021 08:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhFAGY6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Jun 2021 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhFAGY5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jun 2021 02:24:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A80C061756;
        Mon, 31 May 2021 23:23:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y15so10579015pfn.13;
        Mon, 31 May 2021 23:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecwzSsruDCg5HQ2i3NCpkmbXtWN83qkbLVUmQqDCWlk=;
        b=YlsXlVsDWoYMGPxW+QyS762YHdFOjE7CxBcZfRMKkUnI2PFDKCy9EUcSexkxG0c6tc
         JEOxq2/lzF3ffdvVbpz5kWXSrVKFyifnzzZzYWyhirC+Wl3O2KuMjuZe1++feSbhj221
         a7jXtO00cFZrq5ZPUvJy+EZIuhgvZs8ffjQUkcF3fs5vG0jR70dh7b3/nPaDuA5S3xTF
         IYMaQMFZcwU8LY4YhFmqsekoeC1QlNfSLRQlkxdl6VXaguYbigTo1wp/2pO3dXha7wM7
         XnJrwdwqNReQ9QySyKo9rj2h0BQJIDEw9ISx0Rd4lrqILj5rW4LgeYMIdludaJaGFZyP
         FpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecwzSsruDCg5HQ2i3NCpkmbXtWN83qkbLVUmQqDCWlk=;
        b=k7QBHqTQy+pYM1WwrzgFLd0FqVHbJjMqgaJ8eEZvo89Mz4+FRFDceK3bCHLD/3Ixaj
         khZRZG4DIlTPeU9IEXj94EfNgrVDWPjCe7Rige5o5YKNAOdsYiTxP67FHwhdyBPalIXa
         zS/SD9bQVlkhQM/J/aABOTqmynzb1draFHP4WixmEr74tsrhIhNdDa6/WfBcr5xa2Xbw
         oV6yq1tN6mlA/vOA4vRMM3m7DGQXhgF3F6BXfTdXww4TQwm3je2dxxeECUvb286BjXQJ
         uqKCPeg4sTcE73qOx2Wjw5w3cb2Gw2hL7b0Xx0hS//Jqf442CM3esZ8NVrzx1q/rWWjS
         aBvg==
X-Gm-Message-State: AOAM531G7L9ItL3QgtFxz4W9B7eZvuNo3rpwYGgI2FirwGb2hNK6DIfU
        DqjkJKPUFaRJ0v+brqkmHKI=
X-Google-Smtp-Source: ABdhPJwCAsEtEKpT8K7Nr300NGB/ZvSukjJyFZA0oMZFNmXMIB8cLbka5YfgBrjsXWlgMYSF+dBsCQ==
X-Received: by 2002:a63:da0a:: with SMTP id c10mr26585212pgh.255.1622528595531;
        Mon, 31 May 2021 23:23:15 -0700 (PDT)
Received: from bobo.ibm.com (60-241-69-122.static.tpgi.com.au. [60.241.69.122])
        by smtp.gmail.com with ESMTPSA id h1sm12519100pfh.72.2021.05.31.23.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 23:23:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 1/4] lazy tlb: introduce lazy mm refcount helper functions
Date:   Tue,  1 Jun 2021 16:23:00 +1000
Message-Id: <20210601062303.3932513-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210601062303.3932513-1-npiggin@gmail.com>
References: <20210601062303.3932513-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add explicit _lazy_tlb annotated functions for lazy mm refcounting.
This makes lazy mm references more obvious, and allows explicit
refcounting to be removed if it is not used.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 ++--
 fs/exec.c                            |  4 ++--
 include/linux/sched/mm.h             | 11 +++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/kthread.c                     | 11 +++++++----
 kernel/sched/core.c                  | 15 ++++++++-------
 9 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 827b50f1c73e..1b4a41aad793 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -253,7 +253,7 @@ static int ecard_init_mm(void)
 	current->mm = mm;
 	current->active_mm = mm;
 	activate_mm(active_mm, mm);
-	mmdrop(active_mm);
+	mmdrop_lazy_tlb(active_mm);
 	ecard_init_pgtables(mm);
 	return 0;
 }
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 2e05c783440a..fb0bdfc67366 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1541,7 +1541,7 @@ void start_secondary(void *unused)
 {
 	unsigned int cpu = raw_smp_processor_id();
 
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 409e61210789..2962082787c0 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -663,10 +663,10 @@ void exit_lazy_flush_tlb(struct mm_struct *mm, bool always_flush)
 	if (current->active_mm == mm) {
 		WARN_ON_ONCE(current->mm != NULL);
 		/* Is a kernel thread and is using mm as the lazy tlb */
-		mmgrab(&init_mm);
+		mmgrab_lazy_tlb(&init_mm);
 		current->active_mm = &init_mm;
 		switch_mm_irqs_off(mm, &init_mm, current);
-		mmdrop(mm);
+		mmdrop_lazy_tlb(mm);
 	}
 
 	/*
diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..ca0f8b1af23a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1029,9 +1029,9 @@ static int exec_mmap(struct mm_struct *mm)
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
-		return 0;
+	} else {
+		mmdrop_lazy_tlb(active_mm);
 	}
-	mmdrop(active_mm);
 	return 0;
 }
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e24b1fe348e3..bfd1baca5266 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,17 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
+/* Helpers for lazy TLB mm refcounting */
+static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
+{
+	mmgrab(mm);
+}
+
+static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e538518556f4..e87a89824e6c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -602,7 +602,7 @@ static int finish_cpu(unsigned int cpu)
 	 */
 	if (mm != &init_mm)
 		idle->active_mm = &init_mm;
-	mmdrop(mm);
+	mmdrop_lazy_tlb(mm);
 	return 0;
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..8e87ec5f6be2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -476,7 +476,7 @@ static void exit_mm(void)
 		__set_current_state(TASK_RUNNING);
 		mmap_read_lock(mm);
 	}
-	mmgrab(mm);
+	mmgrab_lazy_tlb(mm);
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index fe3f2a40d61e..b70e28431a01 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1314,14 +1314,14 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
 
+	mmgrab(mm);
+
 	task_lock(tsk);
 	/* Hold off tlb flush IPIs while switching mm's */
 	local_irq_disable();
 	active_mm = tsk->active_mm;
-	if (active_mm != mm) {
-		mmgrab(mm);
+	if (active_mm != mm)
 		tsk->active_mm = mm;
-	}
 	tsk->mm = mm;
 	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
@@ -1341,7 +1341,7 @@ void kthread_use_mm(struct mm_struct *mm)
 	 * mmdrop(), or explicitly with smp_mb().
 	 */
 	if (active_mm != mm)
-		mmdrop(active_mm);
+		mmdrop_lazy_tlb(active_mm);
 	else
 		smp_mb();
 
@@ -1375,10 +1375,13 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	local_irq_disable();
 	tsk->mm = NULL;
 	membarrier_update_current_mm(NULL);
+	mmgrab_lazy_tlb(mm);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
 	local_irq_enable();
 	task_unlock(tsk);
+
+	mmdrop(mm);
 }
 EXPORT_SYMBOL_GPL(kthread_unuse_mm);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..e359c76ea2e2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4229,13 +4229,14 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * rq->curr, before returning to userspace, so provide them here:
 	 *
 	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
-	 *   provided by mmdrop(),
+	 *   provided by mmdrop_lazy_tlb(),
 	 * - a sync_core for SYNC_CORE.
 	 */
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop(mm);
+		mmdrop_lazy_tlb(mm);
 	}
+
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
@@ -4299,9 +4300,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 	/*
 	 * kernel -> kernel   lazy + transfer active
-	 *   user -> kernel   lazy + mmgrab() active
+	 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
 	 *
-	 * kernel ->   user   switch + mmdrop() active
+	 * kernel ->   user   switch + mmdrop_lazy_tlb() active
 	 *   user ->   user   switch
 	 */
 	if (!next->mm) {                                // to kernel
@@ -4309,7 +4310,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 		next->active_mm = prev->active_mm;
 		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
+			mmgrab_lazy_tlb(prev->active_mm);
 		else
 			prev->active_mm = NULL;
 	} else {                                        // to user
@@ -4325,7 +4326,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop() in finish_task_switch(). */
+			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
 		}
@@ -8239,7 +8240,7 @@ void __init sched_init(void)
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	enter_lazy_tlb(&init_mm, current);
 
 	/*
-- 
2.23.0

