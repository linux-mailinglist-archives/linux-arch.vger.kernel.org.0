Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2333B3904EA
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhEYPRW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232202AbhEYPRL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:17:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8B246141D;
        Tue, 25 May 2021 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955742;
        bh=QagufuVpOB4kXBKDhC/C+NjO+ztB6hqCnw2dJisJ2TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOWNl3Ngb0Mbd4T+OcanPvU4JIFpSJzcilJqEM/j4OfZnS8VQDZlC09dRG5Ry1mQW
         yfFPsp2eHau679tdJxMO1kOZhD2jIMXOk0oNRrni/tKFHZSuS7IJ+IbYHcVSrJ6k+U
         RKVnaQZ1r1bZ436wutDgRzdIrFNsFlXhUiji4dtp1p918kQtsXvCMUG08fsCOWhjH+
         oRkATuClqNcqT4z36pzJYUdH6kJm6xvUprg+MfRIEN01XsJ1BP/D0Ghq9+qVcX9thl
         CNw9MN2XqWBdC8ujh6yd2TQQmb9QdzOHDCw6TEOO+VwDkTS/Rn5IoGzffqnJTtD01A
         QJMIj7bAzqy+Q==
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: [PATCH v7 07/22] sched: Introduce task_cpu_possible_mask() to limit fallback rq selection
Date:   Tue, 25 May 2021 16:14:17 +0100
Message-Id: <20210525151432.16875-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Asymmetric systems may not offer the same level of userspace ISA support
across all CPUs, meaning that some applications cannot be executed by
some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
not feature support for 32-bit applications on both clusters.

On such a system, we must take care not to migrate a task to an
unsupported CPU when forcefully moving tasks in select_fallback_rq()
in response to a CPU hot-unplug operation.

Introduce a task_cpu_possible_mask() hook which, given a task argument,
allows an architecture to return a cpumask of CPUs that are capable of
executing that task. The default implementation returns the
cpu_possible_mask, since sane machines do not suffer from per-cpu ISA
limitations that affect scheduling. The new mask is used when selecting
the fallback runqueue as a last resort before forcing a migration to the
first active CPU.

Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/mmu_context.h | 11 +++++++++++
 kernel/sched/core.c         |  5 ++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index 03dee12d2b61..1a599ba3524f 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -14,4 +14,15 @@
 static inline void leave_mm(int cpu) { }
 #endif
 
+/*
+ * CPUs that are capable of running task @p. By default, we assume a sane,
+ * homogeneous system. Must contain at least one active CPU.
+ */
+#ifndef task_cpu_possible_mask
+# define task_cpu_possible_mask(p)	cpu_possible_mask
+# define task_cpu_possible(cpu, p)	true
+#else
+# define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
+#endif
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1702a60d178d..00ed51528c70 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1814,7 +1814,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 
 	/* Non kernel threads are not allowed during either online or offline. */
 	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu);
+		return cpu_active(cpu) && task_cpu_possible(cpu, p);
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
@@ -2791,10 +2791,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			 *
 			 * More yuck to audit.
 			 */
-			do_set_cpus_allowed(p, cpu_possible_mask);
+			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
 			state = fail;
 			break;
-
 		case fail:
 			BUG();
 			break;
-- 
2.31.1.818.g46aad6cb9e-goog

