Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22193488496
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiAHQo0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33468 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiAHQoY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2CA2B80B3D
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE1AC36AE0;
        Sat,  8 Jan 2022 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660262;
        bh=HiBwx4mEtQnTc2WUpUmEOonDFLkmsmydNayy9m64VSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtuXWiYgNBgfp5jlSiNLYtFt2CiAU59U2LgHizBP/dUVyrQwrBYVX9+SWSEkl8PGT
         eObayJdoFqyHCK8HSK3krTIjNdm7ydCpttcbshOMSeNl9OtEvUw35bP7DkZ09hrMDF
         j5eh54OZysoUhXTJ2aAjrEDVruVexhI0VqWjiveDz5Q7E3u+6wxHmeVrS+vHNpAlNP
         VWrLQv1R9GaAc0ngFWIFZRwFhsjCikcnqI9LTGhNysp6dmOR4XsUBEOJ6NLrPw07Gv
         nhSlp+8KEM42aG0rLAZaB7sZZbyzoB5O/rmGpVBBjApn2X8hJGVep+qrUapQDvMAY8
         8v/Or3RgKfdOQ==
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
Subject: [PATCH 05/23] membarrier, kthread: Use _ONCE accessors for task->mm
Date:   Sat,  8 Jan 2022 08:43:50 -0800
Message-Id: <e6e7c11c38a3880e56fb7dfff4fa67090d831a3b.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

membarrier reads cpu_rq(remote cpu)->curr->mm without locking.  Use
READ_ONCE() and WRITE_ONCE() to remove the data races.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fs/exec.c                 | 2 +-
 kernel/exit.c             | 2 +-
 kernel/kthread.c          | 4 ++--
 kernel/sched/membarrier.c | 7 ++++---
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3abbd0294e73..38b05e01c5bd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1006,7 +1006,7 @@ static int exec_mmap(struct mm_struct *mm)
 	local_irq_disable();
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
-	tsk->mm = mm;
+	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32e..70f2cbc42015 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -491,7 +491,7 @@ static void exit_mm(void)
 	 */
 	smp_mb__after_spinlock();
 	local_irq_disable();
-	current->mm = NULL;
+	WRITE_ONCE(current->mm, NULL);
 	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
 	local_irq_enable();
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 396ae78a1a34..3b18329f885c 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1358,7 +1358,7 @@ void kthread_use_mm(struct mm_struct *mm)
 		mmgrab(mm);
 		tsk->active_mm = mm;
 	}
-	tsk->mm = mm;
+	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
 	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
 	membarrier_finish_switch_mm(mm);
@@ -1399,7 +1399,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	smp_mb__after_spinlock();
 	sync_mm_rss(mm);
 	local_irq_disable();
-	tsk->mm = NULL;
+	WRITE_ONCE(tsk->mm, NULL);  /* membarrier reads this without locks */
 	membarrier_update_current_mm(NULL);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 30e964b9689d..327830f89c37 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -411,7 +411,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 			goto out;
 		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu_id)->curr);
-		if (!p || p->mm != mm) {
+		if (!p || READ_ONCE(p->mm) != mm) {
 			rcu_read_unlock();
 			goto out;
 		}
@@ -424,7 +424,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 			struct task_struct *p;
 
 			p = rcu_dereference(cpu_rq(cpu)->curr);
-			if (p && p->mm == mm)
+			if (p && READ_ONCE(p->mm) == mm)
 				__cpumask_set_cpu(cpu, tmpmask);
 		}
 		rcu_read_unlock();
@@ -522,7 +522,8 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 		struct task_struct *p;
 
 		p = rcu_dereference(rq->curr);
-		if (p && p->mm == mm)
+		/* exec and kthread_use_mm() write ->mm without locks */
+		if (p && READ_ONCE(p->mm) == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
 	}
 	rcu_read_unlock();
-- 
2.33.1

