Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252CB48849A
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiAHQof (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33630 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiAHQo3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CDC2B80B48
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2841BC36AF8;
        Sat,  8 Jan 2022 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660267;
        bh=EnLYGiRErjhDokS7ynPZj/PCAxWfuRJzmK2u9DRIXD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oD+cLyvFR3z8/hdUI0dQNvSw6VCygHK0d7zmsAL5mRiRPEs1GneFq+K8RC051+fvE
         wnOYH8GQ4M/EU8yekVbdZRo9BoZvgtAQM+Mo8CwqLL75oBw+kFhCNjQ4Kw95R9/L+Q
         2cMxMrBqDkkvQZ6p44oEJ6af2VfwomQlglAyCUgUXhn+ApfijDyEI0gdR8IO8rxc6s
         iN8tBLBhZmiTVW2+0LeID3inM9BWIx885T3ZTIGERPbA1tqeixjxhGT0Dnfv7RKPOQ
         fF2aZW0kl/addSxnjEw/3QUARWFQgGaimwmT7puia2X79uQP74nTTefxCs96QkJ8GJ
         /7URAbBq0i1BA==
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
Subject: [PATCH 09/23] membarrier: Fix incorrect barrier positions during exec and kthread_use_mm()
Date:   Sat,  8 Jan 2022 08:43:54 -0800
Message-Id: <21273aa5349827de22507ef445fbde1a12ac2f8f.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

membarrier() requires a barrier before changes to rq->curr->mm, not just
before writes to rq->membarrier_state.  Move the barrier in exec_mmap() to
the right place.  Add the barrier in kthread_use_mm() -- it was entirely
missing before.

This patch makes exec_mmap() and kthread_use_mm() use the same membarrier
hooks, which results in some code deletion.

As an added bonus, this will eliminate a redundant barrier in execve() on
arches for which spinlock acquisition is a barrier.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fs/exec.c                 |  6 +++++-
 include/linux/sched/mm.h  |  2 --
 kernel/kthread.c          |  5 +++++
 kernel/sched/membarrier.c | 15 ---------------
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 38b05e01c5bd..325dab98bc51 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1001,12 +1001,16 @@ static int exec_mmap(struct mm_struct *mm)
 	}
 
 	task_lock(tsk);
-	membarrier_exec_mmap(mm);
+	/*
+	 * membarrier() requires a full barrier before switching mm.
+	 */
+	smp_mb__after_spinlock();
 
 	local_irq_disable();
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
 	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
+	membarrier_update_current_mm(mm);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e107f292fc42..f1d2beac464c 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -344,8 +344,6 @@ enum {
 #include <asm/membarrier.h>
 #endif
 
-extern void membarrier_exec_mmap(struct mm_struct *mm);
-
 extern void membarrier_update_current_mm(struct mm_struct *next_mm);
 
 /*
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3b18329f885c..18b0a2e0e3b2 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1351,6 +1351,11 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(tsk->mm);
 
 	task_lock(tsk);
+	/*
+	 * membarrier() requires a full barrier before switching mm.
+	 */
+	smp_mb__after_spinlock();
+
 	/* Hold off tlb flush IPIs while switching mm's */
 	local_irq_disable();
 	active_mm = tsk->active_mm;
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index c38014c2ed66..44fafa6e1efd 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -277,21 +277,6 @@ static void ipi_sync_rq_state(void *info)
 	smp_mb();
 }
 
-void membarrier_exec_mmap(struct mm_struct *mm)
-{
-	/*
-	 * Issue a memory barrier before clearing membarrier_state to
-	 * guarantee that no memory access prior to exec is reordered after
-	 * clearing this state.
-	 */
-	smp_mb();
-	/*
-	 * Keep the runqueue membarrier_state in sync with this mm
-	 * membarrier_state.
-	 */
-	this_cpu_write(runqueues.membarrier_state, 0);
-}
-
 void membarrier_update_current_mm(struct mm_struct *next_mm)
 {
 	struct rq *rq = this_rq();
-- 
2.33.1

