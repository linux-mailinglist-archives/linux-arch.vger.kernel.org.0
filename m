Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E063DB7B6
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhG3LZJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 07:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238663AbhG3LZH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 07:25:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2E9A60E76;
        Fri, 30 Jul 2021 11:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627644303;
        bh=C6JSXnDEz3VZcU1vdbB6SFjc0icBulmiQcPDWKZ8SX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j00pYhSr+EPU1app3tsMBIN1Ykaq1NImjdZcW2OLc+1aY4UGjG5ejq/bS4Db8o9Tq
         uYiHTzjxTPlaIt3m/N5KqsRrVWYfE/Kg6NLFiP0SXBWCBUdEWsHE1ULkOndQ1uSg49
         UmOMUL51YbYB1E1aFL8wt+w4oYtPShxuHp9WVv7leb+NsI97J7iMhkyWkWTXQQ61d+
         8qIMKtdSCAXD2qBsNz/mYsU6hT1Qoj0mDscBzUL6icHAaMyxCz7t1lwhCV16bfQgBM
         vWOLG4/3vI+2Bey/4uN9NRkzCVk80b9FLe02li7IVBIRgiGhxhOjvScRJ+esRwJuqF
         4mzEETJcM/lVQ==
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
Subject: [PATCH v11 03/16] cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
Date:   Fri, 30 Jul 2021 12:24:30 +0100
Message-Id: <20210730112443.23245-4-will@kernel.org>
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
index 6000d7fbf5da..3984284c76bd 100644
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
2.32.0.402.g57bb445576-goog

