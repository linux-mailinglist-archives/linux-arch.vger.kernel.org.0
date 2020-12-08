Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754102D2C00
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 14:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgLHNaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 08:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbgLHNaR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 08:30:17 -0500
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
Subject: [PATCH v5 10/15] sched: Introduce force_compatible_cpus_allowed_ptr() to limit CPU affinity
Date:   Tue,  8 Dec 2020 13:28:30 +0000
Message-Id: <20201208132835.6151-11-will@kernel.org>
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

Although userspace can carefully manage the affinity masks for such
tasks, one place where it is particularly problematic is execve()
because the CPU on which the execve() is occurring may be incompatible
with the new application image. In such a situation, it is desirable to
restrict the affinity mask of the task and ensure that the new image is
entered on a compatible CPU. From userspace's point of view, this looks
the same as if the incompatible CPUs have been hotplugged off in the
task's affinity mask.

In preparation for restricting the affinity mask for compat tasks on
arm64 systems without uniform support for 32-bit applications, introduce
force_compatible_cpus_allowed_ptr(), which restricts the affinity mask
for a task to contain only compatible CPUs.

Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/sched.h |   1 +
 kernel/sched/core.c   | 100 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 76cd21fa5501..e42dd0fb85c5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1653,6 +1653,7 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
+extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
 #else
 static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 92ac3e53f50a..1cfc94be18a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1863,25 +1863,19 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
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
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	unsigned int dest_cpu;
-	struct rq_flags rf;
-	struct rq *rq;
 	int ret = 0;
 
-	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
 	if (p->flags & PF_KTHREAD) {
@@ -1936,7 +1930,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
 		/* Need help from migration thread: drop lock and wait. */
-		task_rq_unlock(rq, p, &rf);
+		task_rq_unlock(rq, p, rf);
 		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
 		return 0;
 	} else if (task_on_rq_queued(p)) {
@@ -1944,20 +1938,96 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
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
+ * affinity mask and @subset_mask, writing the resulting mask to @new_mask.
+ * If the resulting mask is empty, leave the affinity unchanged and return
+ * -EINVAL.
+ */
+static int restrict_cpus_allowed_ptr(struct task_struct *p,
+				     struct cpumask *new_mask,
+				     const struct cpumask *subset_mask)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	rq = task_rq_lock(p, &rf);
+	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
+		task_rq_unlock(rq, p, &rf);
+		return -EINVAL;
+	}
+
+	return __set_cpus_allowed_ptr_locked(p, new_mask, false, rq, &rf);
+}
+
+/*
+ * Restrict a given task's CPU affinity so that it is a subset of
+ * task_cpu_possible_mask(). If the resulting mask is empty, we warn and
+ * walk up the cpuset hierarchy until we find a suitable mask.
+ */
+void force_compatible_cpus_allowed_ptr(struct task_struct *p)
+{
+	cpumask_var_t new_mask;
+	const struct cpumask *override_mask = task_cpu_possible_mask(p);
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		goto out_set_mask;
+
+	if (!restrict_cpus_allowed_ptr(p, new_mask, override_mask))
+		goto out_free_mask;
+
+	/*
+	 * We failed to find a valid subset of the affinity mask for the
+	 * task, so override it based on its cpuset hierarchy.
+	 */
+	cpuset_cpus_allowed(p, new_mask);
+	override_mask = new_mask;
+
+out_set_mask:
+	if (printk_ratelimit()) {
+		printk_deferred("Overriding affinity for process %d (%s) to CPUs %*pbl\n",
+				task_pid_nr(p), p->comm,
+				cpumask_pr_args(override_mask));
+	}
+
+	set_cpus_allowed_ptr(p, override_mask);
+out_free_mask:
+	free_cpumask_var(new_mask);
+}
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
-- 
2.29.2.576.ga3fc446d84-goog

