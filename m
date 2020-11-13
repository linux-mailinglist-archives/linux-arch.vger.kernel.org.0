Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C851D2B185F
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 10:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgKMJiT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 04:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgKMJiS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 04:38:18 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52D92225E;
        Fri, 13 Nov 2020 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605260297;
        bh=mEksWh+4+8NCkqXKHhes2krWnYnJe6uXQp/IwoxcPus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJ0sm9lHRn2NQcCZTgSUk4cOUP3hLVjvsmBJGt7GyQvLrLB3sw/PHAn3OW4g2y+xf
         i4IFIQJKyA13wq70oIJuWjkVxl9hcZ6/JOWAJJf+Aemj5zNMUOoqU6CISQ3mo34AUi
         mJd2vhiTsZioGZxsitQFkZYPgfNNdfOeu7ILmrbE=
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
Subject: [PATCH v3 11/14] sched: Reject CPU affinity changes based on arch_cpu_allowed_mask()
Date:   Fri, 13 Nov 2020 09:37:16 +0000
Message-Id: <20201113093720.21106-12-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113093720.21106-1-will@kernel.org>
References: <20201113093720.21106-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reject explicit requests to change the affinity mask of a task via
set_cpus_allowed_ptr() if the requested mask is not a subset of the
mask returned by arch_cpu_allowed_mask(). This ensures that the
'cpus_mask' for a given task cannot contain CPUs which are incapable of
executing it, except in cases where the affinity is forced.

Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8df38ebfe769..13bdb2ae4d3f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1877,6 +1877,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 					 struct rq_flags *rf)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	const struct cpumask *cpu_allowed_mask = arch_cpu_allowed_mask(p);
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
2.29.2.299.gdc1121823c-goog

