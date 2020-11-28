Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595A32C72A2
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgK1VuN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgK1S3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:29:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9664DC0258F2;
        Sat, 28 Nov 2020 08:02:09 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so7110052pfu.1;
        Sat, 28 Nov 2020 08:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=846xez6akqNpiAUuyJyg7Cgtsg97LYlLXrFa3gyFRtY=;
        b=skUfCusnapFL4QjTU84UBawv0Zb8dW/d/8QkYdctwdGHUzbPnVqI5dIbMXvJyVUugf
         fgXzb23Cz1uq763IJaPqMvWoeXOjJml4Bpo9mt9rCdL/6+cuAwsKwfGbh2JTKjN00pjh
         5+n/jaWP5ggmGwOSrHnLZMtDcoPOHKbY6UXKvpgUovNRtB5ykoCejDrKXfvgh+sxy9HW
         MXEkoFva1uTEWLHLOYYXehr+6OI3Un+jP+UFbRtazCKWOMWRQzoluNnvm+jYuY3MdK0a
         QuV/D0FrPuV58JHb7DlkbeKAMloJwgFzRPJk+JdSGvWtQM5k2cc4yP+2/1I1nSubjBbN
         tL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=846xez6akqNpiAUuyJyg7Cgtsg97LYlLXrFa3gyFRtY=;
        b=pZJ2sfpCrrbDwbmuAHPr8iewrbN7KvGFszifsKwPcdMW29OMtuLgUMdpN/xdp4VgNs
         6eZ0YN/e3YtF9aYNX7DudEB6IP7YIo8H/Eu6djB0C24ZMtMXA9B/H6Io4BqRVOd5QEpd
         yNFKyamXCZLtFRyOW+N8gUDYkFl/EGLn8HwqeyBN9LQ1O9tGp378CwqEba/rgjVYl0ZM
         rFR9vEOfOKfXBRLam2XuFx9ug4MBhE5EUOB+yISZilEaeDZzHx/K59ctO5VqpultwPP4
         RPq/wP5VA3jisDc1tFLjx/kO2GdlVd+vTKljWI9TLBdpF2NeOJoW/GyOtls4VS5g7XCy
         8x2A==
X-Gm-Message-State: AOAM5306tfVkdQdDILj3ZOfPoFbuDSdrtanFeE+qUozRLYQi2pSbgzLp
        vJJhQVFjuBA3miJjNRg9pnuJcDtWi3Q=
X-Google-Smtp-Source: ABdhPJzfS/HO/ZAtAEyDNg6acxA2ioQDK2tyBX/rWx/5uj/HtudHJ/+YK14jYXjHb2pJaVwlFAEt1g==
X-Received: by 2002:a17:90b:4b11:: with SMTP id lx17mr17067698pjb.154.1606579328904;
        Sat, 28 Nov 2020 08:02:08 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:02:08 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 4/8] lazy tlb: introduce lazy mm refcount helper functions
Date:   Sun, 29 Nov 2020 02:01:37 +1000
Message-Id: <20201128160141.1003903-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
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
 fs/exec.c                            |  2 +-
 include/linux/sched/mm.h             | 11 +++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/kthread.c                     | 11 +++++++----
 kernel/sched/core.c                  | 15 ++++++++-------
 8 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 43eb1bfba466..a75938702c58 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -254,7 +254,7 @@ static int ecard_init_mm(void)
 	current->active_mm = mm;
 	activate_mm(active_mm, mm);
 	exit_lazy_tlb(active_mm, current);
-	mmdrop(active_mm);
+	mmdrop_lazy_tlb(active_mm);
 	ecard_init_pgtables(mm);
 	return 0;
 }
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index ac3fec03926a..e66606ef2a3d 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -658,11 +658,11 @@ static void do_exit_flush_lazy_tlb(void *arg)
 	if (current->active_mm == mm) {
 		WARN_ON_ONCE(current->mm != NULL);
 		/* Is a kernel thread and is using mm as the lazy tlb */
-		mmgrab(&init_mm);
+		mmgrab_lazy_tlb(&init_mm);
 		current->active_mm = &init_mm;
 		switch_mm_irqs_off(mm, &init_mm, current);
 		exit_lazy_tlb(mm, current);
-		mmdrop(mm);
+		mmdrop_lazy_tlb(mm);
 	}
 
 	atomic_dec(&mm->context.active_cpus);
diff --git a/fs/exec.c b/fs/exec.c
index 4b4dea1bb7ba..0a1461bb62e2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1031,7 +1031,7 @@ static int exec_mmap(struct mm_struct *mm)
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
 	} else {
-		mmdrop(active_mm);
+		mmdrop_lazy_tlb(active_mm);
 	}
 	return 0;
 }
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2c6bcdf76d99..7157c0f6fef8 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -48,6 +48,17 @@ static inline void mmdrop(struct mm_struct *mm)
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
index 134688d79589..ff9fcbc4e76b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -578,7 +578,7 @@ static int finish_cpu(unsigned int cpu)
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
index e380302aac13..f1241e19327e 100644
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
 	exit_lazy_tlb(active_mm, tsk);
@@ -1258,7 +1258,7 @@ void kthread_use_mm(struct mm_struct *mm)
 #endif
 
 	if (active_mm != mm)
-		mmdrop(active_mm);
+		mmdrop_lazy_tlb(active_mm);
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
@@ -1281,10 +1281,13 @@ void kthread_unuse_mm(struct mm_struct *mm)
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
index e4e8cebd82e2..e372b613d514 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3628,10 +3628,11 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * schedule between user->kernel->user threads without passing though
 	 * switch_mm(). Membarrier requires a full barrier after storing to
 	 * rq->curr, before returning to userspace, for
-	 * {PRIVATE,GLOBAL}_EXPEDITED. This is implicitly provided by mmdrop().
+	 * {PRIVATE,GLOBAL}_EXPEDITED. This is implicitly provided by
+	 * mmdrop_lazy_tlb().
 	 */
 	if (mm)
-		mmdrop(mm);
+		mmdrop_lazy_tlb(mm);
 
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
@@ -3736,9 +3737,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
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
@@ -3746,7 +3747,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 		next->active_mm = prev->active_mm;
 		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
+			mmgrab_lazy_tlb(prev->active_mm);
 		else
 			prev->active_mm = NULL;
 	} else {                                        // to user
@@ -3764,7 +3765,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		if (!prev->mm) {                        // from kernel
 			exit_lazy_tlb(prev->active_mm, next);
 
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

