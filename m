Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8D387587
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348102AbhERJtW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348106AbhERJtQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C391613CE;
        Tue, 18 May 2021 09:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331279;
        bh=EV9JgCxKjLj4KVtD7cKw871l26IXkBBXbX6fJNN8AkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QqN0MSxlEWysNMl3QzC9VV1pquDbqXqjrrvGQioYU6YK/JDHtOJmFhEn4e6Yz9pPn
         krlxtnuEtmgB7W/xdaMVwHhPp2EFjsqVSWh9KzZJ7ixKZXtz7sprabF5LJuvT9aLqm
         zXlIbJNaSAqN05og4Uev+SmBGglmP6/ifaR/Z6/0mv41joOk+ZyJiyT7KJa5hUsNCh
         FHDpi7QSMs4GSKVLwtNkXznYWi/PAcTZ2KtJ3uIhrR+j/7yMp/3SZ/9Z7zAoJu+MBE
         fQ4YekLvZPq0FsLtAyGntl6Ci5qj3Dyw6dCOD1RltEn7LhmiK97uvujTMP6B98bhvf
         IXxQ9YVOktUPg==
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
Subject: [PATCH v6 06/21] sched: Introduce task_cpu_possible_mask() to limit fallback rq selection
Date:   Tue, 18 May 2021 10:47:10 +0100
Message-Id: <20210518094725.7701-7-will@kernel.org>
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
 include/linux/mmu_context.h |  8 ++++++++
 kernel/sched/core.c         | 10 ++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

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
index 5226cc26a095..482f7fdca0e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1813,8 +1813,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 		return cpu_online(cpu);
 
 	/* Non kernel threads are not allowed during either online or offline. */
-	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu);
+	if (!(p->flags & PF_KTHREAD)) {
+		if (cpu_active(cpu))
+			return cpumask_test_cpu(cpu, task_cpu_possible_mask(p));
+		return false;
+	}
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
@@ -2792,10 +2795,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
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
2.31.1.751.gd2f1c929bd-goog

