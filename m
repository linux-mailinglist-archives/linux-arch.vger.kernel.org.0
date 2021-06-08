Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4893439FE6C
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhFHSFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234059AbhFHSFt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE2F561376;
        Tue,  8 Jun 2021 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175435;
        bh=5sDhSy8Iq6M6yt1brsixZg6Zkbj8pJRMdMdyvPGuV1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siyWlODmpTUHHzEEiXWvcnK8i83NNJ+MZH7E9+pgKi/bAY6VNDkMWHWdL7+uk09nL
         WZCfhs8iQjJmBvmd0rTZSeIMLyU1R7kE6Fwwcv93zH/JAWgUjJwWzc4aHoiIkoiS9+
         1XGZ40/sK/CERo7HMNX0Ly1eHcQU3tbmX5Ke1WDT+rtkmuUrDnMsLgnFcVt06cYmJt
         Ooq8IXVwRZdgmEq6KhZGmC0DXd2U4JXiHl2uG2LpAaR4vVjwb5oT8PUCe15S4elHKr
         KF95gJbAC/j3MKb/tTkAE3Nse8v7PA9UX3UI59vf5dm+T28Ce9lIgX5nzCoF9Lyqev
         5kz0LB2+X3U/g==
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
Subject: [PATCH v9 07/20] cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
Date:   Tue,  8 Jun 2021 19:03:00 +0100
Message-Id: <20210608180313.11502-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Asymmetric systems may not offer the same level of userspace ISA support
across all CPUs, meaning that some applications cannot be executed by
some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
not feature support for 32-bit applications on both clusters.

Modify guarantee_online_cpus() to take task_cpu_possible_mask() into
account when trying to find a suitable set of online CPUs for a given
task. This will avoid passing an invalid mask to set_cpus_allowed_ptr()
during ->attach() and will subsequently allow the cpuset hierarchy to be
taken into account when forcefully overriding the affinity mask for a
task which requires migration to a compatible CPU.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/cpuset.h |  2 +-
 kernel/cgroup/cpuset.c | 43 +++++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index ed6ec677dd6b..414a8e694413 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -185,7 +185,7 @@ static inline void cpuset_read_unlock(void) { }
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
-	cpumask_copy(mask, cpu_possible_mask);
+	cpumask_copy(mask, task_cpu_possible_mask(p));
 }
 
 static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6ec7303d5b1f..4e7c271e3800 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -372,18 +372,29 @@ static inline bool is_in_v2_mode(void)
 }
 
 /*
- * Return in pmask the portion of a cpusets's cpus_allowed that
- * are online.  If none are online, walk up the cpuset hierarchy
- * until we find one that does have some online cpus.
+ * Return in pmask the portion of a task's cpusets's cpus_allowed that
+ * are online and are capable of running the task.  If none are found,
+ * walk up the cpuset hierarchy until we find one that does have some
+ * appropriate cpus.
  *
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_mask.
  *
  * Call with callback_lock or cpuset_mutex held.
  */
-static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
+static void guarantee_online_cpus(struct task_struct *tsk,
+				  struct cpumask *pmask)
 {
-	while (!cpumask_intersects(cs->effective_cpus, cpu_online_mask)) {
+	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+	struct cpuset *cs;
+
+	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_online_mask)))
+		cpumask_copy(pmask, cpu_online_mask);
+
+	rcu_read_lock();
+	cs = task_cs(tsk);
+
+	while (!cpumask_intersects(cs->effective_cpus, pmask)) {
 		cs = parent_cs(cs);
 		if (unlikely(!cs)) {
 			/*
@@ -393,11 +404,13 @@ static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
 			 * cpuset's effective_cpus is on its way to be
 			 * identical to cpu_online_mask.
 			 */
-			cpumask_copy(pmask, cpu_online_mask);
-			return;
+			goto out_unlock;
 		}
 	}
-	cpumask_and(pmask, cs->effective_cpus, cpu_online_mask);
+	cpumask_and(pmask, pmask, cs->effective_cpus);
+
+out_unlock:
+	rcu_read_unlock();
 }
 
 /*
@@ -2199,15 +2212,13 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	percpu_down_write(&cpuset_rwsem);
 
-	/* prepare for attach */
-	if (cs == &top_cpuset)
-		cpumask_copy(cpus_attach, cpu_possible_mask);
-	else
-		guarantee_online_cpus(cs, cpus_attach);
-
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
 	cgroup_taskset_for_each(task, css, tset) {
+		if (cs != &top_cpuset)
+			guarantee_online_cpus(task, cpus_attach);
+		else
+			cpumask_copy(cpus_attach, task_cpu_possible_mask(task));
 		/*
 		 * can_attach beforehand should guarantee that this doesn't
 		 * fail.  TODO: have a better way to handle failure here
@@ -3302,9 +3313,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	unsigned long flags;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
-	guarantee_online_cpus(task_cs(tsk), pmask);
-	rcu_read_unlock();
+	guarantee_online_cpus(tsk, pmask);
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

