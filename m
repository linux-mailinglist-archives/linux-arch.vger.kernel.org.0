Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167D0387599
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348057AbhERJu3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348056AbhERJte (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE8E2613DB;
        Tue, 18 May 2021 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331297;
        bh=P87T2EfUL7peRiOL9j9h5VxX48Zfl+w2CWwNb/BHI/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEetJlCzqOez2e7J4B7XUnVnt3Uw1kt/v1RkvMkHpV/oc7I5qwF1IVj6EnkT8iqqu
         ezAtVrzs18o6PT/4U5I84PqtvXE6xaKZ7aEuHQMXidCvT6jjTsKVAvWxqZ1PdcAC/A
         UpZOBjToLwld7ULDIUXBJJyIP7S+IsVEB5NjUB3vpaiLa+LvdrYTftk5SnnYYmOSWb
         aKCvIGouAjn/2Y9kl02SmS/558f/bw3p1qgkUGNUS7+S9M+KFJTLwYwFXQyQj4a/cw
         DFUQABCuIHoe8TI51N+iNHceWzLnEpr4w/Q5eUA9sMI+tri175AxAZAMCkrIUjVc0i
         SR0zvVxQpNJ0A==
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
Subject: [PATCH v6 11/21] sched: Split the guts of sched_setaffinity() into a helper function
Date:   Tue, 18 May 2021 10:47:15 +0100
Message-Id: <20210518094725.7701-12-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for replaying user affinity requests using a saved mask,
split sched_setaffinity() up so that the initial task lookup and
security checks are only performed when the request is coming directly
from userspace.

Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 110 +++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9512623d5a60..808bbe669a6d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6788,9 +6788,61 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	return retval;
 }
 
-long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+static int
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 {
+	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
+
+	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
+		return -ENOMEM;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpuset_cpus_allowed(p, cpus_allowed);
+	cpumask_and(new_mask, mask, cpus_allowed);
+
+	/*
+	 * Since bandwidth control happens on root_domain basis,
+	 * if admission test is enabled, we only admit -deadline
+	 * tasks allowed to run on all the CPUs in the task's
+	 * root_domain.
+	 */
+#ifdef CONFIG_SMP
+	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
+		rcu_read_lock();
+		if (!cpumask_subset(task_rq(p)->rd->span, new_mask)) {
+			retval = -EBUSY;
+			rcu_read_unlock();
+			goto out_free_masks;
+		}
+		rcu_read_unlock();
+	}
+#endif
+again:
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+	if (retval)
+		goto out_free_masks;
+
+	cpuset_cpus_allowed(p, cpus_allowed);
+	if (!cpumask_subset(new_mask, cpus_allowed)) {
+		/*
+		 * We must have raced with a concurrent cpuset update.
+		 * Just reset the cpumask to the cpuset's cpus_allowed.
+		 */
+		cpumask_copy(new_mask, cpus_allowed);
+		goto again;
+	}
+
+out_free_masks:
+	free_cpumask_var(new_mask);
+	free_cpumask_var(cpus_allowed);
+	return retval;
+}
+
+long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+{
 	struct task_struct *p;
 	int retval;
 
@@ -6810,68 +6862,22 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 		retval = -EINVAL;
 		goto out_put_task;
 	}
-	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_put_task;
-	}
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_cpus_allowed;
-	}
-	retval = -EPERM;
+
 	if (!check_same_owner(p)) {
 		rcu_read_lock();
 		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
 			rcu_read_unlock();
-			goto out_free_new_mask;
+			retval = -EPERM;
+			goto out_put_task;
 		}
 		rcu_read_unlock();
 	}
 
 	retval = security_task_setscheduler(p);
 	if (retval)
-		goto out_free_new_mask;
-
-
-	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, in_mask, cpus_allowed);
-
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
-again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+		goto out_put_task;
 
-	if (!retval) {
-		cpuset_cpus_allowed(p, cpus_allowed);
-		if (!cpumask_subset(new_mask, cpus_allowed)) {
-			/*
-			 * We must have raced with a concurrent cpuset
-			 * update. Just reset the cpus_allowed to the
-			 * cpuset's cpus_allowed
-			 */
-			cpumask_copy(new_mask, cpus_allowed);
-			goto again;
-		}
-	}
-out_free_new_mask:
-	free_cpumask_var(new_mask);
-out_free_cpus_allowed:
-	free_cpumask_var(cpus_allowed);
+	retval = __sched_setaffinity(p, in_mask);
 out_put_task:
 	put_task_struct(p);
 	return retval;
-- 
2.31.1.751.gd2f1c929bd-goog

