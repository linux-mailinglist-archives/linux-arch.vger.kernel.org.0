Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1D2D2BF0
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 14:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgLHNaK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 08:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgLHNaK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 08:30:10 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
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
        kernel-team@android.com
Subject: [PATCH v5 06/15] sched: Introduce task_cpu_possible_mask() to limit fallback rq selection
Date:   Tue,  8 Dec 2020 13:28:26 +0000
Message-Id: <20201208132835.6151-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208132835.6151-1-will@kernel.org>
References: <20201208132835.6151-1-will@kernel.org>
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
 include/linux/mmu_context.h | 8 ++++++++
 kernel/sched/core.c         | 8 +++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index 03dee12d2b61..bc4ac3c525e6 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -14,4 +14,12 @@
 static inline void leave_mm(int cpu) { }
 #endif
 
+/*
+ * CPUs that are capable of running task @p. By default, we assume a sane,
+ * homogeneous system. Must contain at least one active CPU.
+ */
+#ifndef task_cpu_possible_mask
+# define task_cpu_possible_mask(p)	cpu_possible_mask
+#endif
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7e453492cff..58474569a2ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1708,7 +1708,10 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (is_per_cpu_kthread(p))
 		return cpu_online(cpu);
 
-	return cpu_active(cpu);
+	if (!cpu_active(cpu))
+		return false;
+
+	return cpumask_test_cpu(cpu, task_cpu_possible_mask(p));
 }
 
 /*
@@ -2318,10 +2321,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			}
 			fallthrough;
 		case possible:
-			do_set_cpus_allowed(p, cpu_possible_mask);
+			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
 			state = fail;
 			break;
-
 		case fail:
 			BUG();
 			break;
-- 
2.29.2.576.ga3fc446d84-goog

