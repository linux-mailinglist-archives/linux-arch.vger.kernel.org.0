Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FAE2C2BDE
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 16:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389978AbgKXPvS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 10:51:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389087AbgKXPvS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:18 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23DD5206FB;
        Tue, 24 Nov 2020 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233076;
        bh=r7aIzkV79sW9lwnI001IdntPXJ3WVOrQn3ZZAvFQUNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKiZgTcj4JT+7ZtbrFR8C1Jzddq5aSZoO82jmQrdjgeRlKo4q2S+PMrNdEYpJZ9CQ
         E1zGOEwTJHlwHeBLl1wk/YpGfBXkn1ygo3+o7hAUs/oSq4W8uhox2Jex/egfMGPnH6
         Hf1ZzmZ92kAjW/uhqliAS8mYebqMWJGMCMB1LU2E=
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
        kernel-team@android.com
Subject: [PATCH v4 07/14] sched: Introduce restrict_cpus_allowed_ptr() to limit task CPU affinity
Date:   Tue, 24 Nov 2020 15:50:32 +0000
Message-Id: <20201124155039.13804-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Asymmetric systems may not offer the same level of userspace ISA support
across all CPUs, meaning that some applications cannot be executed by
some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
not feature support for 32-bit applications on both clusters.

Although userspace can carefully manage the affinity masks for such
tasks, one place where it is particularly problematic is execve()
because the CPU on which the execve() is occurring may be incompatible
with the new application image. In such a situation, it is desirable to
restrict the affinity mask of the task and ensure that the new image is
entered on a compatible CPU. From userspace's point of view, this looks
the same as if the incompatible CPUs have been hotplugged off in its
affinity mask.

In preparation for restricting the affinity mask for compat tasks on
arm64 systems without uniform support for 32-bit applications, introduce
a restrict_cpus_allowed_ptr(), which allows the current affinity mask
for a task to be shrunk to the intersection of a parameter mask.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 73 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..1cd12c3ce9ee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1631,6 +1631,7 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
+extern int restrict_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *mask);
 #else
 static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..818c8f7bdf2a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1860,24 +1860,18 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 }
 
 /*
- * Change a given task's CPU affinity. Migrate the thread to a
- * proper CPU and schedule it away if the CPU it's executing on
- * is removed from the allowed bitmask.
- *
- * NOTE: the caller must have a valid reference to the task, the
- * task must not exit() & deallocate itself prematurely. The
- * call is not atomic; no spinlocks may be held.
+ * Called with both p->pi_lock and rq->lock held; drops both before returning.
  */
-static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, bool check)
+static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
+					 const struct cpumask *new_mask,
+					 bool check,
+					 struct rq *rq,
+					 struct rq_flags *rf)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	unsigned int dest_cpu;
-	struct rq_flags rf;
-	struct rq *rq;
 	int ret = 0;
 
-	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
 	if (p->flags & PF_KTHREAD) {
@@ -1929,7 +1923,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
 		/* Need help from migration thread: drop lock and wait. */
-		task_rq_unlock(rq, p, &rf);
+		task_rq_unlock(rq, p, rf);
 		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
 		return 0;
 	} else if (task_on_rq_queued(p)) {
@@ -1937,20 +1931,69 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		 * OK, since we're going to drop the lock immediately
 		 * afterwards anyway.
 		 */
-		rq = move_queued_task(rq, &rf, p, dest_cpu);
+		rq = move_queued_task(rq, rf, p, dest_cpu);
 	}
 out:
-	task_rq_unlock(rq, p, &rf);
+	task_rq_unlock(rq, p, rf);
 
 	return ret;
 }
 
+/*
+ * Change a given task's CPU affinity. Migrate the thread to a
+ * proper CPU and schedule it away if the CPU it's executing on
+ * is removed from the allowed bitmask.
+ *
+ * NOTE: the caller must have a valid reference to the task, the
+ * task must not exit() & deallocate itself prematurely. The
+ * call is not atomic; no spinlocks may be held.
+ */
+static int __set_cpus_allowed_ptr(struct task_struct *p,
+				  const struct cpumask *new_mask, bool check)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	rq = task_rq_lock(p, &rf);
+	return __set_cpus_allowed_ptr_locked(p, new_mask, check, rq, &rf);
+}
+
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
 	return __set_cpus_allowed_ptr(p, new_mask, false);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
+/*
+ * Change a given task's CPU affinity to the intersection of its current
+ * affinity mask and @subset_mask. If the resulting mask is empty, leave
+ * the affinity unchanged and return -EINVAL.
+ */
+int restrict_cpus_allowed_ptr(struct task_struct *p,
+			      const struct cpumask *subset_mask)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+	cpumask_var_t new_mask;
+	int retval;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	rq = task_rq_lock(p, &rf);
+	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
+		task_rq_unlock(rq, p, &rf);
+		retval = -EINVAL;
+		goto out_free_new_mask;
+	}
+
+	retval = __set_cpus_allowed_ptr_locked(p, new_mask, false, rq, &rf);
+
+out_free_new_mask:
+	free_cpumask_var(new_mask);
+	return retval;
+}
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
-- 
2.29.2.454.gaff20da3a2-goog

