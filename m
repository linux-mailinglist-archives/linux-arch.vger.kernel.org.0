Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89BB3B1FBA
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhFWRmA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 13:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhFWRlv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 13:41:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4136160231;
        Wed, 23 Jun 2021 17:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624469973;
        bh=eNdMyntynKaZmqjUHuRlcEAu/jD4r0nCk0D3oGZGO7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idkWtLAvSJyPgNDlsaUNjA+/sOd6VE6xoYzcIbhWxyCk7hSUDhjFUYAtpaEhhOGOF
         nxUgKxj6r0uIYIOPAJH7I+WArucxCyoKLG0z5QXz5nz/RLhqUNLa/G/+iVtBPGgsZI
         5d4doHvrcBbCTEz0QUb6GOZ6lneMS36opMn9F8HGrT2WraBuJyDNodVoL3kwtQuQ5y
         qqRdkYylQxEM45Iu5IlBPrHuiDPzf73RFmVjlZw/40OvUIiGM3GHGteyLadBNFdnCe
         4mnQLzIxk7eBudD5faQMD3jk71qd3oplrkvDlLgSOZsohN49EkVb+bsr6NzgyuFlRp
         watIl+D6wHcIw==
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
Subject: [PATCH v10 09/16] sched: Introduce dl_task_check_affinity() to check proposed affinity
Date:   Wed, 23 Jun 2021 18:38:41 +0100
Message-Id: <20210623173848.318-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623173848.318-1-will@kernel.org>
References: <20210623173848.318-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for restricting the affinity of a task during execve()
on arm64, introduce a new dl_task_check_affinity() helper function to
give an indication as to whether the restricted mask is admissible for
a deadline task.

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/sched.h |  6 ++++++
 kernel/sched/core.c   | 46 +++++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 91a6cfeae242..b9d0df8f7153 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1691,6 +1691,7 @@ extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
 extern void release_user_cpus_ptr(struct task_struct *p);
+extern int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask);
 extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
 extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
 #else
@@ -1713,6 +1714,11 @@ static inline void release_user_cpus_ptr(struct task_struct *p)
 {
 	WARN_ON(p->user_cpus_ptr);
 }
+
+static inline int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
+{
+	return 0;
+}
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d3d5e8b33961..d2fe6f8b8f6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6935,6 +6935,32 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	return retval;
 }
 
+#ifdef CONFIG_SMP
+int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
+{
+	int ret = 0;
+
+	/*
+	 * If the task isn't a deadline task or admission control is
+	 * disabled then we don't care about affinity changes.
+	 */
+	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
+		return 0;
+
+	/*
+	 * Since bandwidth control happens on root_domain basis,
+	 * if admission test is enabled, we only admit -deadline
+	 * tasks allowed to run on all the CPUs in the task's
+	 * root_domain.
+	 */
+	rcu_read_lock();
+	if (!cpumask_subset(task_rq(p)->rd->span, mask))
+		ret = -EBUSY;
+	rcu_read_unlock();
+	return ret;
+}
+#endif
+
 static int
 __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 {
@@ -6952,23 +6978,9 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
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
-	}
-#endif
+	retval = dl_task_check_affinity(p, new_mask);
+	if (retval)
+		goto out_free_new_mask;
 again:
 	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
 	if (retval)
-- 
2.32.0.93.g670b81a890-goog

