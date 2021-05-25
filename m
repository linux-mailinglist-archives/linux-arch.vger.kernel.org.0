Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079C53904F7
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhEYPRx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232656AbhEYPRa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:17:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA4466142F;
        Tue, 25 May 2021 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955761;
        bh=EvkTo2K1PcCIoQ8/XfG+DFYRwxrDfvbuzCOjvHhGVVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qB7Rb9GQYCJT7DcWUyR6ChOA8Xjy3y9N0mX6afK36FmQkI0DmFdHmDAWHbPN71RNo
         GV73kWJHQwapNF/07xw+4SlB6qj7ndZ4xIBLMevlKW6ILJCyw63fWvAY2lwGKSq+KU
         lV4O5vmV/gYreyg++dxUdv20YWg2qYBtzWu2PPmajOYkVwQqObJx0IHj5vU6LXxBbY
         hIynBXOh6Lt9CIwPBSJxVQX+4Sy89kH76WK75B4LW2AL9LIJ54PX7QcpdKbrDCePBT
         JtyGI2hrgqg7ZfOfU/aX6ARJSO5lLCwZUH69BdO5kAvo2uI/qtvnJFA7FEVlQCsGnJ
         HetFLjMhr+q4w==
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
Subject: [PATCH v7 12/22] sched: Split the guts of sched_setaffinity() into a helper function
Date:   Tue, 25 May 2021 16:14:22 +0100
Message-Id: <20210525151432.16875-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
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
 kernel/sched/core.c | 105 ++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9349b8ecbcf9..0b7faca947a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6784,53 +6784,22 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	return retval;
 }
 
-long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+static int
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 {
-	cpumask_var_t cpus_allowed, new_mask;
-	struct task_struct *p;
 	int retval;
+	cpumask_var_t cpus_allowed, new_mask;
 
-	rcu_read_lock();
-
-	p = find_process_by_pid(pid);
-	if (!p) {
-		rcu_read_unlock();
-		return -ESRCH;
-	}
-
-	/* Prevent p going away */
-	get_task_struct(p);
-	rcu_read_unlock();
+	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
+		return -ENOMEM;
 
-	if (p->flags & PF_NO_SETAFFINITY) {
-		retval = -EINVAL;
-		goto out_put_task;
-	}
-	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_put_task;
-	}
 	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
 		retval = -ENOMEM;
 		goto out_free_cpus_allowed;
 	}
-	retval = -EPERM;
-	if (!check_same_owner(p)) {
-		rcu_read_lock();
-		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
-			rcu_read_unlock();
-			goto out_free_new_mask;
-		}
-		rcu_read_unlock();
-	}
-
-	retval = security_task_setscheduler(p);
-	if (retval)
-		goto out_free_new_mask;
-
 
 	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, in_mask, cpus_allowed);
+	cpumask_and(new_mask, mask, cpus_allowed);
 
 	/*
 	 * Since bandwidth control happens on root_domain basis,
@@ -6851,23 +6820,63 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 #endif
 again:
 	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+	if (retval)
+		goto out_free_new_mask;
 
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
+	cpuset_cpus_allowed(p, cpus_allowed);
+	if (!cpumask_subset(new_mask, cpus_allowed)) {
+		/*
+		 * We must have raced with a concurrent cpuset update.
+		 * Just reset the cpumask to the cpuset's cpus_allowed.
+		 */
+		cpumask_copy(new_mask, cpus_allowed);
+		goto again;
 	}
+
 out_free_new_mask:
 	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
+	return retval;
+}
+
+long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+{
+	struct task_struct *p;
+	int retval;
+
+	rcu_read_lock();
+
+	p = find_process_by_pid(pid);
+	if (!p) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	/* Prevent p going away */
+	get_task_struct(p);
+	rcu_read_unlock();
+
+	if (p->flags & PF_NO_SETAFFINITY) {
+		retval = -EINVAL;
+		goto out_put_task;
+	}
+
+	if (!check_same_owner(p)) {
+		rcu_read_lock();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
+			rcu_read_unlock();
+			retval = -EPERM;
+			goto out_put_task;
+		}
+		rcu_read_unlock();
+	}
+
+	retval = security_task_setscheduler(p);
+	if (retval)
+		goto out_put_task;
+
+	retval = __sched_setaffinity(p, in_mask);
 out_put_task:
 	put_task_struct(p);
 	return retval;
-- 
2.31.1.818.g46aad6cb9e-goog

