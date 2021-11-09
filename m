Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40F244A5A5
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 05:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhKIEOS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Nov 2021 23:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbhKIEOQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Nov 2021 23:14:16 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C2C061766;
        Mon,  8 Nov 2021 20:11:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x131so13019020pfc.12;
        Mon, 08 Nov 2021 20:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQFU+G/DSpCOLSveRI/qk3sBgfhtXA2EHZFO2cdZU3k=;
        b=qJxIvWCExqTfbShydvUAUEHw6FPpZoGR5E3RcJCItA+OAJ5G/pMOfRerK0px5Tb+WS
         DnNOXgGGdjBZ6dNL2QP6A/cZC1qSKOGOsasvjXhDKHQ5JvcyV2EzOWIxPPS46Cscfn7M
         V1oX904uxGev4PA0bV5KcJedjxnrW10wCzfiEtkD/DXZg4H/mnv9WAw/u7p5DOnQ+jFp
         tCghQUyjIEp7Xs3I/c+0PiD27omu5QwdLly0KitYRmW0wG8yjCIabKosZIDMUNKAKryb
         tp5YIBE8vINHnKtor/eg8mR9r9tl+P6m9l5ydmQYaSjtPwlC7eIp5FffshIMffXHy7S0
         PnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQFU+G/DSpCOLSveRI/qk3sBgfhtXA2EHZFO2cdZU3k=;
        b=1gV3BqpNWQ6CUhFlPTbk/AQJLOtbbwCarfaBuAmN5QWHhZckOxEqLT2d5zhmjmGvVo
         m0znZEm+lhElFCku/FPQP5o3IfdajjLgSUmqcmKvRkVM3MG7bwjW8Pxgw8gk7N6qVwTk
         0YkWEZiN03C0n729eKLLiGHmMrNlMl9y/qaYn9gI2fXzdSYViGiOHg8q4zQ+8AyhQQNK
         oYiPdqsnw2dcvqA293hktKmTq2Lo9i0urWeRdwqPS2hbHV1BI8d89d2IB0SkAstSZIFO
         zhAVyDhCkOy1mMDvhuBVzRBLdJFsmjO7dx6eNfzYTlnDQEUbzinMcb+YnQKjnj3RF+Af
         TD5g==
X-Gm-Message-State: AOAM531LvdxV3rt41txTLumYI8VjzQmJCOpkOlcQvzTTZJKAaFwNkv/g
        dQp28tnb9caPcbpN7zqHWG4=
X-Google-Smtp-Source: ABdhPJxcyaGAYMWexUl6VpDyScbecT8IrSM4/mBcOSWvZMP+IcmfUAwYfo4xdWSidD9cB7AIJVMZbQ==
X-Received: by 2002:a63:7d6:: with SMTP id 205mr3634863pgh.289.1636431091328;
        Mon, 08 Nov 2021 20:11:31 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id o19sm18278063pfu.56.2021.11.08.20.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 20:11:31 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 1/4] lazy tlb: introduce lazy mm refcount helper functions
Date:   Tue,  9 Nov 2021 14:11:16 +1000
Message-Id: <20211109041119.1972927-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211109041119.1972927-1-npiggin@gmail.com>
References: <20211109041119.1972927-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add explicit _lazy_tlb annotated functions for lazy mm refcounting.
This makes lazy mm references more obvious, and allows explicit
refcounting to be removed if it is not used.

The non-trivial change in kthread_use_mm/kthread_unuse_mm is because it
is clever with refcounting: If it happens that the kthread's lazy tlb mm
(active_mm) is the same as the mm to be used, the code doesn't touch the
refcount but rather transfers the lazy refcount to used-mm refcount. Now
that lazy tlb mm refcount may not be equivalent to regular refcount,
this trick doesn't work and we must mmgrab a regular reference on mm to
use, and mmdrop_lazy_tlb the previous active_mm.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 ++--
 fs/exec.c                            |  2 +-
 include/linux/sched/mm.h             | 11 +++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/kthread.c                     | 21 +++++++++++++--------
 kernel/sched/core.c                  | 15 ++++++++-------
 9 files changed, 39 insertions(+), 22 deletions(-)

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
index 605bab448f84..88875387a347 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1582,7 +1582,7 @@ void start_secondary(void *unused)
 	if (IS_ENABLED(CONFIG_PPC32))
 		setup_kup();
 
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 7724af19ed7e..59156c2d2ebe 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -786,10 +786,10 @@ void exit_lazy_flush_tlb(struct mm_struct *mm, bool always_flush)
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
index a098c133d8d7..30ba5449bb14 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1030,7 +1030,7 @@ static int exec_mmap(struct mm_struct *mm)
 		mmput(old_mm);
 		return 0;
 	}
-	mmdrop(active_mm);
+	mmdrop_lazy_tlb(active_mm);
 	return 0;
 }
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 5561486fddef..f7a0b347fecb 100644
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
index 192e43a87407..fffe8b738201 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -613,7 +613,7 @@ static int finish_cpu(unsigned int cpu)
 	 */
 	if (mm != &init_mm)
 		idle->active_mm = &init_mm;
-	mmdrop(mm);
+	mmdrop_lazy_tlb(mm);
 	return 0;
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32e..8e7b41702ad6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -475,7 +475,7 @@ static void exit_mm(void)
 		__set_current_state(TASK_RUNNING);
 		mmap_read_lock(mm);
 	}
-	mmgrab(mm);
+	mmgrab_lazy_tlb(mm);
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5b37a8567168..83ed75d531b4 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1350,14 +1350,19 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
 
+	/*
+	 * It's possible that tsk->active_mm == mm here, but we must
+	 * still mmgrab(mm) and mmdrop_lazy_tlb(active_mm), because lazy
+	 * mm may not have its own refcount (see mmgrab/drop_lazy_tlb()).
+	 */
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
@@ -1374,12 +1379,9 @@ void kthread_use_mm(struct mm_struct *mm)
 	 * memory barrier after storing to tsk->mm, before accessing
 	 * user-space memory. A full memory barrier for membarrier
 	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
-	 * mmdrop(), or explicitly with smp_mb().
+	 * mmdrop_lazy_tlb().
 	 */
-	if (active_mm != mm)
-		mmdrop(active_mm);
-	else
-		smp_mb();
+	mmdrop_lazy_tlb(active_mm);
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
@@ -1411,10 +1413,13 @@ void kthread_unuse_mm(struct mm_struct *mm)
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
index 1bba4128a3e6..480205b6a188 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4831,13 +4831,14 @@ static struct rq *finish_task_switch(struct task_struct *prev)
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
@@ -4900,9 +4901,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
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
@@ -4910,7 +4911,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 		next->active_mm = prev->active_mm;
 		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
+			mmgrab_lazy_tlb(prev->active_mm);
 		else
 			prev->active_mm = NULL;
 	} else {                                        // to user
@@ -4926,7 +4927,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop() in finish_task_switch(). */
+			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
 		}
@@ -9441,7 +9442,7 @@ void __init sched_init(void)
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	enter_lazy_tlb(&init_mm, current);
 
 	/*
-- 
2.23.0

