Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543554884A1
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiAHQoj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50542 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiAHQoe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B47C60DE4
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB396C36AE0;
        Sat,  8 Jan 2022 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660274;
        bh=+HQX3q3DuPuBg03W9xoO54/1KFTovvzwFnkvqR9M6l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzYTT9KWMZuhFsogwISh7v+tUggMo6MfWKPm8Rwm7S0a7cbwPGE92vse/UIuzStJ2
         MVALxrxuLKwu0wJdECMuOxgPw9eKUTIyaCQwr6qIFoq1xv1eCbqmGvs9hAxB6QF/aA
         bRytq3QvCl3/EhICa71pyihO7MzbsdO6/GXB7N+7J6P9yC0sli2ujMXtIgj5djFUNU
         AaxAC7/TzuFw6dqDvMgjaYhzsJSfCzedSXr6PeAIlH+qHD2xHylLkqUt7VpI8Jyr6x
         jCnSuWKaPqu7zaho/khcIwn27CSSjVJbeoAzD4bj6azmEnqgHxo58KoNv76DJl6uVQ
         JnUuCUBTga9Ew==
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 15/23] kthread: Switch to __change_current_mm()
Date:   Sat,  8 Jan 2022 08:44:00 -0800
Message-Id: <521a37c3b488e902b7f2f79f10ba2e2d729ff553.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove the open-coded mm switching in kthread_use_mm() and
kthread_unuse_mm().

This has one internally-visible effect: the old code active_mm
refcounting was inconsistent with everything else and mmgrabbed the
mm in kthread_use_mm().  The new code refcounts following the same
rules as normal user threads, so kthreads that are currently using
a user mm will not hold an mm_count reference.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/kthread.c | 45 ++-------------------------------------------
 1 file changed, 2 insertions(+), 43 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 18b0a2e0e3b2..77586f5b14e5 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1344,37 +1344,12 @@ EXPORT_SYMBOL(kthread_destroy_worker);
  */
 void kthread_use_mm(struct mm_struct *mm)
 {
-	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
 
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
 
-	task_lock(tsk);
-	/*
-	 * membarrier() requires a full barrier before switching mm.
-	 */
-	smp_mb__after_spinlock();
-
-	/* Hold off tlb flush IPIs while switching mm's */
-	local_irq_disable();
-	active_mm = tsk->active_mm;
-	if (active_mm != mm) {
-		mmgrab(mm);
-		tsk->active_mm = mm;
-	}
-	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
-	membarrier_update_current_mm(mm);
-	switch_mm_irqs_off(active_mm, mm, tsk);
-	membarrier_finish_switch_mm(mm);
-	local_irq_enable();
-	task_unlock(tsk);
-#ifdef finish_arch_post_lock_switch
-	finish_arch_post_lock_switch();
-#endif
-
-	if (active_mm != mm)
-		mmdrop(active_mm);
+	__change_current_mm(mm, false);
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
@@ -1393,23 +1368,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
 
 	force_uaccess_end(to_kthread(tsk)->oldfs);
 
-	task_lock(tsk);
-	/*
-	 * When a kthread stops operating on an address space, the loop
-	 * in membarrier_{private,global}_expedited() may not observe
-	 * that tsk->mm, and not issue an IPI. Membarrier requires a
-	 * memory barrier after accessing user-space memory, before
-	 * clearing tsk->mm.
-	 */
-	smp_mb__after_spinlock();
-	sync_mm_rss(mm);
-	local_irq_disable();
-	WRITE_ONCE(tsk->mm, NULL);  /* membarrier reads this without locks */
-	membarrier_update_current_mm(NULL);
-	/* active_mm is still 'mm' */
-	enter_lazy_tlb(mm, tsk);
-	local_irq_enable();
-	task_unlock(tsk);
+	__change_current_mm_to_kernel();
 }
 EXPORT_SYMBOL_GPL(kthread_unuse_mm);
 
-- 
2.33.1

