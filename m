Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5145E2C2BE8
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 16:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbgKXPvg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 10:51:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390035AbgKXPvf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:35 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646D02086A;
        Tue, 24 Nov 2020 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233094;
        bh=deEZsI4JMfZft5nsFKUFREErfrnI08kQMrUiB+oeZmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZAqDxPfY0CHfGP9qkIm9uA+pzT5bEH+/W5nd8/KT6OUaSR/R9lxlP6cDozzyYre9
         Tgdoyau5VM1CQ6qiFuQQ5EId1gG4CPP1/nXJfROp/VPvMed5bpu13OyvzkBRsaSW9y
         Vs8F/2gRZiBZPvxKvvoOhQnp6uL4xKpywLit4EXc=
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
        kernel-team@android.com
Subject: [PATCH v4 11/14] sched: Reject CPU affinity changes based on arch_task_cpu_possible_mask()
Date:   Tue, 24 Nov 2020 15:50:36 +0000
Message-Id: <20201124155039.13804-12-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reject explicit requests to change the affinity mask of a task via
set_cpus_allowed_ptr() if the requested mask is not a subset of the
mask returned by arch_task_cpu_possible_mask(). This ensures that the
'cpus_mask' for a given task cannot contain CPUs which are incapable of
executing it, except in cases where the affinity is forced.

Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 99992d0beb65..095deda50643 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1877,6 +1877,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 					 struct rq_flags *rf)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	const struct cpumask *cpu_allowed_mask = arch_task_cpu_possible_mask(p);
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -1887,6 +1888,9 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 		 * Kernel threads are allowed on online && !active CPUs
 		 */
 		cpu_valid_mask = cpu_online_mask;
+	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/*
-- 
2.29.2.454.gaff20da3a2-goog

