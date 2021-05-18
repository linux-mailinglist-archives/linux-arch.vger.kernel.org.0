Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165123875A2
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348217AbhERJun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242312AbhERJt4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23B95613F1;
        Tue, 18 May 2021 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331311;
        bh=44h3JsYZ/KIsAP+Upj/qBCyu3PQIrAfBaeDZkj8kEHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMayGdvqj7sLozMbYFnwY2WFufoESelFZSH8VuLRTDX3yLwAATjm9J81bgPDOuugT
         hCTg2WgfvbgkYufvVeb6qBR1RxTWc5mKSSyDGC2a+ksgEFM/o4wU3UPORukgbOdirx
         XS1frfOXkyKZnlH/Ii+ARG8h7cFNv7BP21kof+VBHR5KYXRVQ6IRHC3tLCeC1xp1Wg
         0s3eWa2ZL08a+qhYd73PdJwGSwbR9dYH3QW3noMKqynRPt+Jqgh18gDZMgfE+s9fIc
         ydGY2gtkHFAEJ3Rl/mLyW7P4N5vPGXKWmjuSWk3RRTWvkiytoyFyj12egmW3tIMlSu
         Gd2JZAmEk6fsg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: [PATCH v6 15/21] sched: Defer wakeup in ttwu() for unschedulable frozen tasks
Date:   Tue, 18 May 2021 10:47:19 +0100
Message-Id: <20210518094725.7701-16-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Asymmetric systems may not offer the same level of userspace ISA support
across all CPUs, meaning that some applications cannot be executed by
some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
not feature support for 32-bit applications on both clusters.

Although we take care to prevent explicit hot-unplug of all 32-bit
capable CPUs on such a system, this is required when suspending on some
SoCs where the firmware mandates that the suspend/resume operation is
handled by CPU 0, which may not be capable of running 32-bit tasks.

Consequently, there is a window on the resume path where no 32-bit
capable CPUs are available for scheduling and waking up a 32-bit task
will result in a scheduler BUG() due to failure of select_fallback_rq():

  | kernel BUG at kernel/sched/core.c:2858!
  | Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
  | ...
  | Call trace:
  |  select_fallback_rq+0x4b0/0x4e4
  |  try_to_wake_up.llvm.4388853297126348405+0x460/0x5b0
  |  default_wake_function+0x1c/0x30
  |  autoremove_wake_function+0x1c/0x60
  |  __wake_up_common.llvm.11763074518265335900+0x100/0x1b8
  |  __wake_up+0x78/0xc4
  |  ep_poll_callback+0x20c/0x3fc

Prevent wakeups of unschedulable frozen tasks in ttwu() and instead
defer the wakeup to __thaw_tasks(), which runs only once all the
secondary CPUs are back online.

Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/freezer.c    | 10 +++++++++-
 kernel/sched/core.c | 13 +++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index dc520f01f99d..8f3d950c2a87 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -11,6 +11,7 @@
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
+#include <linux/mmu_context.h>
 
 /* total number of freezing conditions in effect */
 atomic_t system_freezing_cnt = ATOMIC_INIT(0);
@@ -146,9 +147,16 @@ bool freeze_task(struct task_struct *p)
 void __thaw_task(struct task_struct *p)
 {
 	unsigned long flags;
+	const struct cpumask *mask = task_cpu_possible_mask(p);
 
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (frozen(p))
+	/*
+	 * Wake up frozen tasks. On asymmetric systems where tasks cannot
+	 * run on all CPUs, ttwu() may have deferred a wakeup generated
+	 * before thaw_secondary_cpus() had completed so we generate
+	 * additional wakeups here for tasks in the PF_FREEZER_SKIP state.
+	 */
+	if (frozen(p) || (frozen_or_skipped(p) && mask != cpu_possible_mask))
 		wake_up_process(p);
 	spin_unlock_irqrestore(&freezer_lock, flags);
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d7d058fc012e..f5ff55786344 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3525,6 +3525,19 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (!(p->state & state))
 		goto unlock;
 
+#ifdef CONFIG_FREEZER
+	/*
+	 * If we're going to wake up a thread which may be frozen, then
+	 * we can only do so if we have an active CPU which is capable of
+	 * running it. This may not be the case when resuming from suspend,
+	 * as the secondary CPUs may not yet be back online. See __thaw_task()
+	 * for the actual wakeup.
+	 */
+	if (unlikely(frozen_or_skipped(p)) &&
+	    !cpumask_intersects(cpu_active_mask, task_cpu_possible_mask(p)))
+		goto unlock;
+#endif
+
 	trace_sched_waking(p);
 
 	/* We're going to change ->state: */
-- 
2.31.1.751.gd2f1c929bd-goog

