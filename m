Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF839FE6E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhFHSF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234078AbhFHSFw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2514E613AC;
        Tue,  8 Jun 2021 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175439;
        bh=oZQTnBoiNHmMNC/XIJ3JXCME+8MVXh/ggSl0RMjN068=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9Q8qMVTYoKsuiTNC8h7bdaRp9uK1gc6DHSdj6GU7DVpmWn7oyEA/f0rw+GcxQpiM
         6cE99CRceMlCPcAM1UDTHEQ/am26QTPAxgUyN0uTe0hQguz0zx3skF2MkY5L1Vc3Nl
         X7Kx76qfnDevoq/FtL7fk/kBsgyNmFcSirqWBclSgjAtUQab+cDWCd0o2/tQ5opJfU
         9tCH5VZPdNmYvoquAFZrdVPVsZ10616r13XbfNcDBwsSqnb9lXVQ57b30lCkfv/FMW
         bLBP1P5YrOO+2D68QmUYPKfQSqk49+ZN6QVeggPLQX+VAHb2njLg6Gv585uL95Gznu
         SE869rxRVEJjw==
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
Subject: [PATCH v9 08/20] cpuset: Cleanup cpuset_cpus_allowed_fallback() use in select_fallback_rq()
Date:   Tue,  8 Jun 2021 19:03:01 +0100
Message-Id: <20210608180313.11502-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

select_fallback_rq() only needs to recheck for an allowed CPU if the
affinity mask of the task has changed since the last check.

Return a 'bool' from cpuset_cpus_allowed_fallback() to indicate whether
the affinity mask was updated, and use this to elide the allowed check
when the mask has been left alone.

No functional change.

Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/cpuset.h |  5 +++--
 kernel/cgroup/cpuset.c | 10 ++++++++--
 kernel/sched/core.c    |  3 +--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 414a8e694413..d2b9c41c8edf 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -59,7 +59,7 @@ extern void cpuset_wait_for_hotplug(void);
 extern void cpuset_read_lock(void);
 extern void cpuset_read_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
-extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
+extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
@@ -188,8 +188,9 @@ static inline void cpuset_cpus_allowed(struct task_struct *p,
 	cpumask_copy(mask, task_cpu_possible_mask(p));
 }
 
-static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
+static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
 {
+	return false;
 }
 
 static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4e7c271e3800..a6bab2259f98 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3327,17 +3327,22 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
  * which will not contain a sane cpumask during cases such as cpu hotplugging.
  * This is the absolute last resort for the scheduler and it is only used if
  * _every_ other avenue has been traveled.
+ *
+ * Returns true if the affinity of @tsk was changed, false otherwise.
  **/
 
-void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
+bool cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
 	const struct cpumask *cs_mask;
+	bool changed = false;
 	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
 
 	rcu_read_lock();
 	cs_mask = task_cs(tsk)->cpus_allowed;
-	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
+	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask)) {
 		do_set_cpus_allowed(tsk, cs_mask);
+		changed = true;
+	}
 	rcu_read_unlock();
 
 	/*
@@ -3357,6 +3362,7 @@ void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 	 * select_fallback_rq() will fix things ups and set cpu_possible_mask
 	 * if required.
 	 */
+	return changed;
 }
 
 void __init cpuset_init_current_mems_allowed(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c1b6f1a6c91..9e75cb3fbc9c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2779,8 +2779,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 		/* No more Mr. Nice Guy. */
 		switch (state) {
 		case cpuset:
-			if (IS_ENABLED(CONFIG_CPUSETS)) {
-				cpuset_cpus_allowed_fallback(p);
+			if (cpuset_cpus_allowed_fallback(p)) {
 				state = possible;
 				break;
 			}
-- 
2.32.0.rc1.229.g3e70b5a671-goog

