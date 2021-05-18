Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4F387593
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348071AbhERJty (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348112AbhERJtY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 358BD613DC;
        Tue, 18 May 2021 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331286;
        bh=wMv2PdJYwMEJ9tSikM8uIF6fm2qkuS94TU9x613bwLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMkIKGq+1e4eB6KgumfgKe9peqbooTnY+8iKzWKWLYC3kuNzEA6kyIsR2uySffZz3
         lu2u0iNi5PAh0yfH3RH8UWDz8u9BI4QzNpoXaCuu5SV7328L6pN0X8wolSR4xR6oT4
         6cf6BNJxS8gFEut0DYy/7+hxCVkzQRDgGw3Lx8nkPWfeuhaLycJ3B8kcZmpwnLew6N
         MbuwLKjmFaL07RKLkigg5My4F5jxaYpXzVj3AmBFrMrVJdv92Fra2sJtZJh7CbNFHW
         ag+e9wq9p1cwZZ1MXr9e9/Qh4c299ix1NUcLZuvmtFXE0dU/hhHxj2otiOXER6EhNw
         imuCsKOwBpYJQ==
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
Subject: [PATCH v6 08/21] cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
Date:   Tue, 18 May 2021 10:47:12 +0100
Message-Id: <20210518094725.7701-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
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

Cc: Li Zefan <lizefan@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/cpuset.h |  2 +-
 kernel/cgroup/cpuset.c | 33 +++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 15 deletions(-)

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
index 8c799260a4a2..b532a5333ff9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -372,18 +372,26 @@ static inline bool is_in_v2_mode(void)
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
+	struct cpuset *cs = task_cs(tsk);
+	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+
+	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_online_mask)))
+		cpumask_copy(pmask, cpu_online_mask);
+
+	while (!cpumask_intersects(cs->effective_cpus, pmask)) {
 		cs = parent_cs(cs);
 		if (unlikely(!cs)) {
 			/*
@@ -393,11 +401,10 @@ static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
 			 * cpuset's effective_cpus is on its way to be
 			 * identical to cpu_online_mask.
 			 */
-			cpumask_copy(pmask, cpu_online_mask);
 			return;
 		}
 	}
-	cpumask_and(pmask, cs->effective_cpus, cpu_online_mask);
+	cpumask_and(pmask, pmask, cs->effective_cpus);
 }
 
 /*
@@ -2199,15 +2206,13 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
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
@@ -3303,7 +3308,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 
 	spin_lock_irqsave(&callback_lock, flags);
 	rcu_read_lock();
-	guarantee_online_cpus(task_cs(tsk), pmask);
+	guarantee_online_cpus(tsk, pmask);
 	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
-- 
2.31.1.751.gd2f1c929bd-goog

