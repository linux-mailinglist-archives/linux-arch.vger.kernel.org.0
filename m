Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559B72D9370
	for <lists+linux-arch@lfdr.de>; Mon, 14 Dec 2020 08:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407161AbgLNHCM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Dec 2020 02:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgLNHCA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2020 02:02:00 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D53C0613CF;
        Sun, 13 Dec 2020 23:01:20 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id b8so2148411plx.0;
        Sun, 13 Dec 2020 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGjE6Oe6mVSK72UaRSxHAy5QAmJ4uKC6X/D55j0mgnM=;
        b=kav7cHCYxYQuP8L6G7ZPNKuglYUtblvdQ39I3dnJiAwNZgRQY2TsSzPWGCMwCWqqbb
         lyVHXwnCB19HUUWSPM+7iWZQz0OepzKgQfDd3n857+uXQgiU4NKMPcUDlyT/4sYEmFkB
         VmJnHhuKT1eOz8MrHCUwlh/f6XRrW25VPE1LLBcpRjD/VAD8cu0hPT5GbJj6OTQLJs1Z
         UaeHk1ogQBpVAao0lwAYzGsUDM6hWOv13AyjisgMVY4DffUUaDL6mf4XQOAUIJ3ymFf1
         aaau/HcMhHWntY1Po3WpyQXFnY1E86dlvecwBVDhA/IYMqM2O1t7/p9lciMiUUMBthC5
         zpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGjE6Oe6mVSK72UaRSxHAy5QAmJ4uKC6X/D55j0mgnM=;
        b=NBneY11mZac9fw2/4b3j1sOqqvm5grEyU5y3gqUX7rUQDMo4BKZqdWWW7+tg80dbGJ
         O7X9xit1Fka6A+OZlak3YZXQvxfWPXZWMDBGCQh8g9QBgxYRNUUUTnaRcNx7fxn9jlxW
         n05m3XIiP4AvpiMhzrdEpA2hAt7/lvNbvuwcRNvQxFnQ6PUpjI3RYtzojBb/q6kZ17SK
         jzdqstC90vfIASDmzO+UdeWdErpGy2FTrTlGiJumQNWaymt/X0ds6QElybYrqS2+6aCP
         V5nhoYEOAryQCpECCzAoZuDboYAnXSN3YjqorZgwJwoCv32MHMhIV0sAFB1ZsCQk+qxN
         0J2w==
X-Gm-Message-State: AOAM532/XVw8qcoL2p/5HA+N7PwPhegFjOxRYU/K8Hk8rv/vkJuN6oXw
        P0rjlVm+r6UaVUA+/VakHr21ypOKM0U=
X-Google-Smtp-Source: ABdhPJxJOUrDaqX3qExF0UOrRm/OWxZCHdgQA3sDhREGOfNyDxgCR36pLLdlpYpGj+IZTqgueJG6wg==
X-Received: by 2002:a17:902:d38b:b029:db:e003:3ff0 with SMTP id e11-20020a170902d38bb02900dbe0033ff0mr17491568pld.7.1607929278513;
        Sun, 13 Dec 2020 23:01:18 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id 84sm19570018pfy.9.2020.12.13.23.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 23:01:18 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 1/5] lazy tlb: introduce lazy mm refcount helper functions
Date:   Mon, 14 Dec 2020 16:53:08 +1000
Message-Id: <20201214065312.270062-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201214065312.270062-1-npiggin@gmail.com>
References: <20201214065312.270062-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add explicit _lazy_tlb annotated functions for lazy mm refcounting.
This makes things a bit more explicit, and allows explicit refcounting
to be removed if it is not used.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 ++--
 fs/exec.c                            |  4 ++--
 include/linux/sched/mm.h             | 11 +++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/kthread.c                     | 11 +++++++----
 kernel/sched/core.c                  | 15 ++++++++-------
 8 files changed, 33 insertions(+), 18 deletions(-)

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
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index b487b489d4b6..74708aef333e 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -658,10 +658,10 @@ static void do_exit_flush_lazy_tlb(void *arg)
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
 
 	atomic_dec(&mm->context.active_cpus);
diff --git a/fs/exec.c b/fs/exec.c
index 547a2390baf5..56fc23dcbe4d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1028,9 +1028,9 @@ static int exec_mmap(struct mm_struct *mm)
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
index d5ece7a9a403..94a117160083 100644
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
index 2b8d7a5db383..a54cdfa08d71 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -576,7 +576,7 @@ static int finish_cpu(unsigned int cpu)
 	 */
 	if (mm != &init_mm)
 		idle->active_mm = &init_mm;
-	mmdrop(mm);
+	mmdrop_lazy_tlb(mm);
 	return 0;
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 1f236ed375f8..3711a74fcf4a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -474,7 +474,7 @@ static void exit_mm(void)
 		__set_current_state(TASK_RUNNING);
 		mmap_read_lock(mm);
 	}
-	mmgrab(mm);
+	mmgrab_lazy_tlb(mm);
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 933a625621b8..da189e0d26ed 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1240,14 +1240,14 @@ void kthread_use_mm(struct mm_struct *mm)
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
 	switch_mm_irqs_off(active_mm, mm, tsk);
 	local_irq_enable();
@@ -1257,7 +1257,7 @@ void kthread_use_mm(struct mm_struct *mm)
 #endif
 
 	if (active_mm != mm)
-		mmdrop(active_mm);
+		mmdrop_lazy_tlb(active_mm);
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
@@ -1280,10 +1280,13 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	sync_mm_rss(mm);
 	local_irq_disable();
 	tsk->mm = NULL;
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
index e7e453492cff..c2f8ea43d29b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3629,13 +3629,14 @@ static struct rq *finish_task_switch(struct task_struct *prev)
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
@@ -3739,9 +3740,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
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
@@ -3749,7 +3750,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 		next->active_mm = prev->active_mm;
 		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
+			mmgrab_lazy_tlb(prev->active_mm);
 		else
 			prev->active_mm = NULL;
 	} else {                                        // to user
@@ -3765,7 +3766,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop() in finish_task_switch(). */
+			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
 		}
@@ -7206,7 +7207,7 @@ void __init sched_init(void)
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	enter_lazy_tlb(&init_mm, current);
 
 	/*
-- 
2.23.0

