Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0142D2BFE
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 14:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgLHNaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 08:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgLHNaQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 08:30:16 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
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
        kernel-team@android.com
Subject: [PATCH v5 09/15] sched: Reject CPU affinity changes based on task_cpu_possible_mask()
Date:   Tue,  8 Dec 2020 13:28:29 +0000
Message-Id: <20201208132835.6151-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208132835.6151-1-will@kernel.org>
References: <20201208132835.6151-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reject explicit requests to change the affinity mask of a task via
set_cpus_allowed_ptr() if the requested mask is not a subset of the
mask returned by task_cpu_possible_mask(). This ensures that the
'cpus_mask' for a given task cannot contain CPUs which are incapable of
executing it, except in cases where the affinity is forced.

Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 58474569a2ea..92ac3e53f50a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1875,6 +1875,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  const struct cpumask *new_mask, bool check)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	unsigned int dest_cpu;
 	struct rq_flags rf;
 	struct rq *rq;
@@ -1888,6 +1889,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		 * Kernel threads are allowed on online && !active CPUs
 		 */
 		cpu_valid_mask = cpu_online_mask;
+	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/*
-- 
2.29.2.576.ga3fc446d84-goog

