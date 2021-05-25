Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606433904EC
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhEYPRX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232335AbhEYPRP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:17:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7ADC6142F;
        Tue, 25 May 2021 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955746;
        bh=r0igYkdDa6pTkf5eR6dqCXpYwXk+rrFbiGdpzDOL3Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4V+2OfCK+A62N/gJBG8uc7LZTybgyIOpJB3/JHXiNBkKpqkdAxuXCZhkcTn++95A
         iacFXwLrhTL/85OaF/86ioTWnGRoMX61GVttCc2qjJInGLFFs1xolWfMm+kvmJn8xs
         b3lUWUsk+6CoY9z9aC7cHa5J9hhL46Q+FhHyg54l763ZLBJeDaDi1er3QH70hgmMia
         ECChJ78tYf790Uu6CT8p79SZ8EtJ+pgTbG2IPZ+CemhqF7XWyLn35BEE8TnMfNjx5K
         nxnjTHlNiLYteoDh0U9BdQd32VRDUfMzHB1Jf236uAPM66EUb5HcjMk73PPqdaVkKH
         jK0QtrPAWbcJA==
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
        kernel-team@android.com, Li Zefan <lizefan@huawei.com>
Subject: [PATCH v7 08/22] cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
Date:   Tue, 25 May 2021 16:14:18 +0100
Message-Id: <20210525151432.16875-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If the scheduler cannot find an allowed CPU for a task,
cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
if cgroup v1 is in use.

In preparation for allowing architectures to provide their own fallback
mask, just return early if we're either using cgroup v1 or we're using
cgroup v2 with a mask that contains invalid CPUs. This will allow
select_fallback_rq() to figure out the mask by itself.

Cc: Li Zefan <lizefan@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/cpuset.h |  1 +
 kernel/cgroup/cpuset.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 04c20de66afc..ed6ec677dd6b 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -15,6 +15,7 @@
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
 #include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/jump_label.h>
 
 #ifdef CONFIG_CPUSETS
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a945504c0ae7..8c799260a4a2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3322,9 +3322,17 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
+	const struct cpumask *cs_mask;
+	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+
 	rcu_read_lock();
-	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
-		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
+	cs_mask = task_cs(tsk)->cpus_allowed;
+
+	if (!is_in_v2_mode() || !cpumask_subset(cs_mask, possible_mask))
+		goto unlock; /* select_fallback_rq will try harder */
+
+	do_set_cpus_allowed(tsk, cs_mask);
+unlock:
 	rcu_read_unlock();
 
 	/*
-- 
2.31.1.818.g46aad6cb9e-goog

