Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB36890A4
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 08:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjBCHTY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 02:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjBCHTX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 02:19:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9241719B0
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 23:19:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id mi9so4184655pjb.4
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 23:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zyO0Na48QxjwG/96vzDf++z0O8XkPhrocrCmdAQIr4=;
        b=RjMq26cALu6UQb/DQZXQLPnJ8q+5dxPkkAeNEEvpF3YmP/iIxIovFGviX1JlRz0jeg
         M7qLKRmW/kcc5x1c9SHmOSYnJe9+31+D24kVK96Ksr1S7Zt/aXoepztE4675W5+TKCmI
         l7ZXGa+Hkrlr29qD2BElEYcG56srSLiqGLTXdDhjWEbhTeezj+o3ucEl/DnGScKqEdos
         gjnHqOBFBvOGIB8B0ihoLS1aLm2EEzjTn2NTiSQLlM02bDjGVFKn0ywDHx4b4Xqh8fdJ
         /YT8fJBKv4a5hmE07ZK5OFW3fBPnCb8a4hDphqWN5QDzyLQrPez4UtETRdkzThwbDqBE
         bt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zyO0Na48QxjwG/96vzDf++z0O8XkPhrocrCmdAQIr4=;
        b=AnNZvIZpOi8CP9rdQU9xhGq787d6e8pborK+lwgp/duLSGCAiIC1Vd8J4VBFyfvtBy
         Mxssrw3dpQZzdfqMK9pE04yhG/FuQsaFlGvXoJT97yZbnZdz62uEIBEajkSAtOfbpDj8
         ZHytd/Eh60hxWiOVJHBSnnGiWCAlS+1tc/X6gYPodl5P4TM/D/ejLSa4N4Okp83ZdqoA
         LhGd6wL5N5j3OkiyCdDRzlbNjVVARvr+2ZHx6DdRRwF4I9jp3S6WygEpZ0z4rVEOhB5y
         zNfHj+AC/dOzD17eNM9FDByrZPZAO1HYRR+P98fcImtiCAHMXqReigQxPQdCyLTDes5z
         xVzA==
X-Gm-Message-State: AO0yUKX/m64zmCwueDAHF2KsAmASoChWNlm3uBrDU5ssUcGlYNoOuDFE
        TIPb4SBT/shzsyXLySEh8PA=
X-Google-Smtp-Source: AK7set+0jg4e6z5KWbhW7fRuU0ZT2jMMbq5RDBzo5fVKlfYThFxG8WOLHSndBW6UWk3y/w+dt7g5fQ==
X-Received: by 2002:a05:6a20:4428:b0:bd:278:f68f with SMTP id ce40-20020a056a20442800b000bd0278f68fmr11365775pzb.52.1675408745589;
        Thu, 02 Feb 2023 23:19:05 -0800 (PST)
Received: from bobo.ibm.com (193-116-117-77.tpgi.com.au. [193.116.117.77])
        by smtp.gmail.com with ESMTPSA id f20-20020a637554000000b004df4ba1ebfesm877558pgn.66.2023.02.02.23.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:19:05 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rik van Riel <riel@redhat.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 2/5] lazy tlb: introduce lazy tlb mm refcount helper functions
Date:   Fri,  3 Feb 2023 17:18:34 +1000
Message-Id: <20230203071837.1136453-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203071837.1136453-1-npiggin@gmail.com>
References: <20230203071837.1136453-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add explicit _lazy_tlb annotated functions for lazy tlb mm refcounting.
This makes the lazy tlb mm references more obvious, and allows the
refcounting scheme to be modified in later changes. There is no
functional change with this patch.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 ++--
 fs/exec.c                            |  2 +-
 include/linux/sched/mm.h             | 16 ++++++++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/kthread.c                     | 12 ++++++++++--
 kernel/sched/core.c                  | 15 ++++++++-------
 9 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 53813f9464a2..c30df1097c52 100644
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
index 6b90f10a6c81..7db6b3faea65 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1611,7 +1611,7 @@ void start_secondary(void *unused)
 	if (IS_ENABLED(CONFIG_PPC32))
 		setup_kup();
 
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 4e29b619578c..282359ab525b 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -794,10 +794,10 @@ void exit_lazy_flush_tlb(struct mm_struct *mm, bool always_flush)
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
index ab913243a367..1a32a88db173 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1033,7 +1033,7 @@ static int exec_mmap(struct mm_struct *mm)
 		mmput(old_mm);
 		return 0;
 	}
-	mmdrop(active_mm);
+	mmdrop_lazy_tlb(active_mm);
 	return 0;
 }
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..5376caf6fcf3 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -79,6 +79,22 @@ static inline void mmdrop_sched(struct mm_struct *mm)
 }
 #endif
 
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
+static inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
+{
+	mmdrop_sched(mm);
+}
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..189895288d9d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -623,7 +623,7 @@ static int finish_cpu(unsigned int cpu)
 	 */
 	if (mm != &init_mm)
 		idle->active_mm = &init_mm;
-	mmdrop(mm);
+	mmdrop_lazy_tlb(mm);
 	return 0;
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 15dc2ec80c46..1a4608d765e4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -537,7 +537,7 @@ static void exit_mm(void)
 		return;
 	sync_mm_rss(mm);
 	mmap_read_lock(mm);
-	mmgrab(mm);
+	mmgrab_lazy_tlb(mm);
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 7424a1839e9a..e4bc32a88866 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1410,6 +1410,11 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
 
+	/*
+	 * It is possible for mm to be the same as tsk->active_mm, but
+	 * we must still mmgrab(mm) and mmdrop_lazy_tlb(active_mm),
+	 * because these references are not equivalent.
+	 */
 	mmgrab(mm);
 
 	task_lock(tsk);
@@ -1433,9 +1438,9 @@ void kthread_use_mm(struct mm_struct *mm)
 	 * memory barrier after storing to tsk->mm, before accessing
 	 * user-space memory. A full memory barrier for membarrier
 	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
-	 * mmdrop().
+	 * mmdrop_lazy_tlb().
 	 */
-	mmdrop(active_mm);
+	mmdrop_lazy_tlb(active_mm);
 }
 EXPORT_SYMBOL_GPL(kthread_use_mm);
 
@@ -1463,10 +1468,13 @@ void kthread_unuse_mm(struct mm_struct *mm)
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
index e838feb6adc5..495f9a021de9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5189,13 +5189,14 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * rq->curr, before returning to userspace, so provide them here:
 	 *
 	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
-	 *   provided by mmdrop(),
+	 *   provided by mmdrop_lazy_tlb(),
 	 * - a sync_core for SYNC_CORE.
 	 */
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop_sched(mm);
+		mmdrop_lazy_tlb_sched(mm);
 	}
+
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
@@ -5252,9 +5253,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
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
@@ -5262,7 +5263,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 		next->active_mm = prev->active_mm;
 		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
+			mmgrab_lazy_tlb(prev->active_mm);
 		else
 			prev->active_mm = NULL;
 	} else {                                        // to user
@@ -5279,7 +5280,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		lru_gen_use_mm(next->mm);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop() in finish_task_switch(). */
+			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
 		}
@@ -9916,7 +9917,7 @@ void __init sched_init(void)
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	enter_lazy_tlb(&init_mm, current);
 
 	/*
-- 
2.37.2

