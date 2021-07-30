Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB573DB7C0
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbhG3LZc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 07:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238686AbhG3LZ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 07:25:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4618861052;
        Fri, 30 Jul 2021 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627644323;
        bh=/xV+B6YkGUKsuRqCsRod36aQoKNwqGQIrjvP2SH2eIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSKAsUARHBkBdoEoome15laphgjsBNjIOy44tgDvvLkw92V9SQCFCOEd6CzDEGDwF
         65T42EsQmO4YGI5M6yMmKo5zDXPcPXM0tlXwxME892lebrvnKjnHHlAHEFFNOKZURR
         AbDJ3U3R7KezD3a5KjYDmMTLKfWNVRKQYKUZz57q71HqK2Ofpkjtg8Mm8q9g895FJB
         +vZe9JyULJ62f8p4r00EtLwQJUbm4l68IAfuPLLorxH3ywAuktSKoqyNEgMU37jsWU
         f8nAXE61OVPFfkmXs35Rx17o8LdWSj2qFOjvRxIbw6hDvuj1lREw6W9QJSa4y7Wjkr
         5o+aTpPO4icZQ==
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: [PATCH v11 08/16] sched: Allow task CPU affinity to be restricted on asymmetric systems
Date:   Fri, 30 Jul 2021 12:24:35 +0100
Message-Id: <20210730112443.23245-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210730112443.23245-1-will@kernel.org>
References: <20210730112443.23245-1-will@kernel.org>
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
task's affinity mask. Similarly, if a subsequent execve() reverts to
a compatible image, then the old affinity is restored if it is still
valid.

In preparation for restricting the affinity mask for compat tasks on
arm64 systems without uniform support for 32-bit applications, introduce
{force,relax}_compatible_cpus_allowed_ptr(), which respectively restrict
and restore the affinity mask for a task based on the compatible CPUs.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/sched.h |   2 +
 kernel/sched/core.c   | 180 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h  |   1 +
 3 files changed, 167 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 91dab7a62aa1..2ebe3d6f8f0c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1708,6 +1708,8 @@ extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
 extern void release_user_cpus_ptr(struct task_struct *p);
+extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
+extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
 #else
 static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d4219d366103..aec75ec1d257 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2707,27 +2707,22 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
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
-				  const struct cpumask *new_mask,
-				  u32 flags)
+static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
+					 const struct cpumask *new_mask,
+					 u32 flags,
+					 struct rq *rq,
+					 struct rq_flags *rf)
+	__releases(rq->lock)
+	__releases(p->pi_lock)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	unsigned int dest_cpu;
-	struct rq_flags rf;
-	struct rq *rq;
 	int ret = 0;
 	bool kthread = p->flags & PF_KTHREAD;
 
-	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
 	if (kthread || is_migration_disabled(p)) {
@@ -2783,20 +2778,173 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 	__do_set_cpus_allowed(p, new_mask, flags);
 
-	return affine_move_task(rq, p, &rf, dest_cpu, flags);
+	if (flags & SCA_USER)
+		release_user_cpus_ptr(p);
+
+	return affine_move_task(rq, p, rf, dest_cpu, flags);
 
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
+				  const struct cpumask *new_mask, u32 flags)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	rq = task_rq_lock(p, &rf);
+	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
+}
+
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
 	return __set_cpus_allowed_ptr(p, new_mask, 0);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
+/*
+ * Change a given task's CPU affinity to the intersection of its current
+ * affinity mask and @subset_mask, writing the resulting mask to @new_mask
+ * and pointing @p->user_cpus_ptr to a copy of the old mask.
+ * If the resulting mask is empty, leave the affinity unchanged and return
+ * -EINVAL.
+ */
+static int restrict_cpus_allowed_ptr(struct task_struct *p,
+				     struct cpumask *new_mask,
+				     const struct cpumask *subset_mask)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+	int err;
+	struct cpumask *user_mask = NULL;
+
+	if (!p->user_cpus_ptr) {
+		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+
+		if (!user_mask)
+			return -ENOMEM;
+	}
+
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * Forcefully restricting the affinity of a deadline task is
+	 * likely to cause problems, so fail and noisily override the
+	 * mask entirely.
+	 */
+	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
+		err = -EPERM;
+		goto err_unlock;
+	}
+
+	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
+		err = -EINVAL;
+		goto err_unlock;
+	}
+
+	/*
+	 * We're about to butcher the task affinity, so keep track of what
+	 * the user asked for in case we're able to restore it later on.
+	 */
+	if (user_mask) {
+		cpumask_copy(user_mask, p->cpus_ptr);
+		p->user_cpus_ptr = user_mask;
+	}
+
+	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
+
+err_unlock:
+	task_rq_unlock(rq, p, &rf);
+	kfree(user_mask);
+	return err;
+}
+
+/*
+ * Restrict the CPU affinity of task @p so that it is a subset of
+ * task_cpu_possible_mask() and point @p->user_cpu_ptr to a copy of the
+ * old affinity mask. If the resulting mask is empty, we warn and walk
+ * up the cpuset hierarchy until we find a suitable mask.
+ */
+void force_compatible_cpus_allowed_ptr(struct task_struct *p)
+{
+	cpumask_var_t new_mask;
+	const struct cpumask *override_mask = task_cpu_possible_mask(p);
+
+	alloc_cpumask_var(&new_mask, GFP_KERNEL);
+
+	/*
+	 * __migrate_task() can fail silently in the face of concurrent
+	 * offlining of the chosen destination CPU, so take the hotplug
+	 * lock to ensure that the migration succeeds.
+	 */
+	cpus_read_lock();
+	if (!cpumask_available(new_mask))
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
+	WARN_ON(set_cpus_allowed_ptr(p, override_mask));
+out_free_mask:
+	cpus_read_unlock();
+	free_cpumask_var(new_mask);
+}
+
+static int
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+
+/*
+ * Restore the affinity of a task @p which was previously restricted by a
+ * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
+ * @p->user_cpus_ptr.
+ *
+ * It is the caller's responsibility to serialise this with any calls to
+ * force_compatible_cpus_allowed_ptr(@p).
+ */
+void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
+{
+	unsigned long flags;
+	struct cpumask *mask = p->user_cpus_ptr;
+
+	/*
+	 * Try to restore the old affinity mask. If this fails, then
+	 * we free the mask explicitly to avoid it being inherited across
+	 * a subsequent fork().
+	 */
+	if (!mask || !__sched_setaffinity(p, mask))
+		return;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	release_user_cpus_ptr(p);
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+}
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
@@ -7613,7 +7761,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
 	if (retval)
 		goto out_free_new_mask;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..e88c2d399f0d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2234,6 +2234,7 @@ extern struct task_struct *pick_next_task_idle(struct rq *rq);
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
 #define SCA_MIGRATE_ENABLE	0x04
+#define SCA_USER		0x08
 
 #ifdef CONFIG_SMP
 
-- 
2.32.0.402.g57bb445576-goog

