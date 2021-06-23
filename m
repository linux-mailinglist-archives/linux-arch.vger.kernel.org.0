Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74D73B1FB6
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFWRls (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 13:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhFWRln (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 13:41:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FEAA611C1;
        Wed, 23 Jun 2021 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624469965;
        bh=eHXNDHJR9/wxQKqSPMiVFmlMc/hdxr9eeuF51cyQjuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qd2LUBdrDJc/CTjXjpCpCiXrT5Fx8o4euTGsjiy10KNWPLZKOVQ35zFzXEGVlM0sl
         UATVCk8s0MjiOUQLgmIuonR+lZLuM0igh/2J0q8MtaemS8l96NUXgWLYAGo91nZHXV
         kyGHBibeHDhzTEmT1IqZCxr/RidNgFoqIBlw+ogX3teUqzylYA7EknDJC+KQ54LMAB
         kaprZRf14F1z8M8xCB2fs+vurZ3gY+FyNtYrpHhfA25XVgzoCIA2H+7owF/V0WjiM7
         8fQ+ZdFGnUqg9HDANU7gNAFLaRpKwk5vjavU5KPOAk9Kyrl0zSDhjhAdSuWVBoIK+I
         3/Vxu/JDS35zw==
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
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com,
        Valentin Schneider <Valentin.Schneider@arm.com>
Subject: [PATCH v10 07/16] sched: Split the guts of sched_setaffinity() into a helper function
Date:   Wed, 23 Jun 2021 18:38:39 +0100
Message-Id: <20210623173848.318-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623173848.318-1-will@kernel.org>
References: <20210623173848.318-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for replaying user affinity requests using a saved mask,
split sched_setaffinity() up so that the initial task lookup and
security checks are only performed when the request is coming directly
from userspace.

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 105 ++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f6ea3d7a07f2..d151446d5987 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6787,53 +6787,22 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
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
@@ -6854,23 +6823,63 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
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
2.32.0.93.g670b81a890-goog

