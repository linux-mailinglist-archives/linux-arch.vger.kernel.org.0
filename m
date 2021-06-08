Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A826339FE6A
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhFHSFr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234060AbhFHSFo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3C8F61377;
        Tue,  8 Jun 2021 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175431;
        bh=gmXuSd2iyTh8x2keQgbZ8qOFQ3JyIAnvzsqKbezooMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwKYx2t5ajD3Xk0nXbE4s0AnJYFcl6WeKVUwVwtttn3dMLLWu6gqaY0c3rQXM/nW5
         Plkr1cPTXbT9Y9tvGKmXqEspeCBAyYWW6czuI94VdA3dgIBpCsOTCymmMqAYhxXdsN
         +mohPrXdYj+GgYJPcQjXG/XYNZ3qUKsGlFyHrVtI4n6BWKV4BQlsSMZWOjxvRl7VI2
         d0URnvc6G1oloSX6TZPyiApg30XQkwYFzETwQwLc3TOv54lMnhAVJJz+OwoQNmGoSb
         x2232wQ5Fq+W0yRvaK8KnlAEDXbFlr2aPf7dqNmzGnhBjayIiiLU+uno/8/SOI42Ut
         MygQCm347Y1Sg==
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
Subject: [PATCH v9 06/20] cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
Date:   Tue,  8 Jun 2021 19:02:59 +0100
Message-Id: <20210608180313.11502-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
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

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/cpuset.h | 1 +
 kernel/cgroup/cpuset.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

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
index a945504c0ae7..6ec7303d5b1f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3322,9 +3322,13 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
+	const struct cpumask *cs_mask;
+	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+
 	rcu_read_lock();
-	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
-		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
+	cs_mask = task_cs(tsk)->cpus_allowed;
+	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
+		do_set_cpus_allowed(tsk, cs_mask);
 	rcu_read_unlock();
 
 	/*
-- 
2.32.0.rc1.229.g3e70b5a671-goog

