Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14FF399066
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jun 2021 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFBQuF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Jun 2021 12:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhFBQuB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Jun 2021 12:50:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6C1E610A1;
        Wed,  2 Jun 2021 16:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622652498;
        bh=+0NLguOvQ/SVpTtQ+rBgEHqDg+B1MsugcBVESzqvkUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMOwJ5J+c8M3VPygei6ZBu4e8coSkSgxL13UeArKq5lulgQS0KbWjjSd4SedVOhN9
         g1wQ0FHZcYU89mWzarAuy74oOIbp3B1aSXmNDiFRsqyyOrgaS9bzxkigTn6j9S2+Wd
         n3q2SKSYH48NK8G8tHY/5InbrZQurzJVJWJzXHI8gN3z+VG/FANIseCvKrTTR3JEFA
         uAwe9fwzlJXCt/4ZvvhWIC6JMB7//5r/58IBwzIyHy5H3z9l5eVPJLxBFIFJPeJrEQ
         YQ3NZf2eWXwVtfKC2IainGSXiRo3ifGYP1sDbirsoc8AJ7PmnU8oVkJMM0L3SiT20+
         HUIk+2/RLtqhQ==
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
        kernel-team@android.com
Subject: [PATCH v8 12/19] sched: Introduce task_cpus_dl_admissible() to check proposed affinity
Date:   Wed,  2 Jun 2021 17:47:12 +0100
Message-Id: <20210602164719.31777-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602164719.31777-1-will@kernel.org>
References: <20210602164719.31777-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for restricting the affinity of a task during execve()
on arm64, introduce a new task_cpus_dl_admissible() helper function to
give an indication as to whether the restricted mask is admissible for
a deadline task.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/sched.h |  6 ++++++
 kernel/sched/core.c   | 44 +++++++++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 91a6cfeae242..9b17d8cfa6ef 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1691,6 +1691,7 @@ extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
 extern void release_user_cpus_ptr(struct task_struct *p);
+extern bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask);
 extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
 extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
 #else
@@ -1713,6 +1714,11 @@ static inline void release_user_cpus_ptr(struct task_struct *p)
 {
 	WARN_ON(p->user_cpus_ptr);
 }
+
+static inline bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask)
+{
+	return true;
+}
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 58e2cf7520c0..b4f8dc18ae11 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6933,6 +6933,31 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	return retval;
 }
 
+#ifdef CONFIG_SMP
+bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask)
+{
+	bool ret;
+
+	/*
+	 * If the task isn't a deadline task or admission control is
+	 * disabled then we don't care about affinity changes.
+	 */
+	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
+		return true;
+
+	/*
+	 * Since bandwidth control happens on root_domain basis,
+	 * if admission test is enabled, we only admit -deadline
+	 * tasks allowed to run on all the CPUs in the task's
+	 * root_domain.
+	 */
+	rcu_read_lock();
+	ret = cpumask_subset(task_rq(p)->rd->span, mask);
+	rcu_read_unlock();
+	return ret;
+}
+#endif
+
 static int
 __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 {
@@ -6950,23 +6975,10 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	cpuset_cpus_allowed(p, cpus_allowed);
 	cpumask_and(new_mask, mask, cpus_allowed);
 
-	/*
-	 * Since bandwidth control happens on root_domain basis,
-	 * if admission test is enabled, we only admit -deadline
-	 * tasks allowed to run on all the CPUs in the task's
-	 * root_domain.
-	 */
-#ifdef CONFIG_SMP
-	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
-		rcu_read_lock();
-		if (!cpumask_subset(task_rq(p)->rd->span, new_mask)) {
-			retval = -EBUSY;
-			rcu_read_unlock();
-			goto out_free_new_mask;
-		}
-		rcu_read_unlock();
+	if (!task_cpus_dl_admissible(p, new_mask)) {
+		retval = -EBUSY;
+		goto out_free_new_mask;
 	}
-#endif
 again:
 	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
 	if (retval)
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

