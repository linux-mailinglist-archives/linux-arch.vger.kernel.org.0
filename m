Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0D387594
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348099AbhERJuA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348135AbhERJt1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD153613CB;
        Tue, 18 May 2021 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331289;
        bh=nWVmEPeR0hM9A1fN5XIKmBdskSrJ1G92PsqLDEhYaSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJZqDMYB1gHPG9YMTA0G3FEGVzf5TtzSg0BgVnZHPLaioxVDGWkxXh8gwz/OvrV6a
         d9QkWGIU208DCKa/xvr3mO7xf8vPcLQ2XYb3DyrfBR/iom3FBG3Bh4TFhJb7gMXYbQ
         nny2uINhbOB96DwiMBfoVcXVt+l1BQ9+RR2EQxK65Ltxuh4hAQU5XREskaMI56htpu
         7oRAlRX4ZpVgEAUlSkoz7G/o6qi6RIp7p37jAJ9tBXOK7HbX2TYOPr3BPeo8Ck8A2P
         7NQ/uHCz1LgDyo8aUGO95xjD2rMEqBqzCOTyLYbV3v25w5ag6+TYDrqIc3VPeuOO9y
         1NELW1ysbLwmQ==
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
Subject: [PATCH v6 09/21] sched: Reject CPU affinity changes based on task_cpu_possible_mask()
Date:   Tue, 18 May 2021 10:47:13 +0100
Message-Id: <20210518094725.7701-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
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
index 482f7fdca0e8..21da3d7f9e47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2350,6 +2350,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	unsigned int dest_cpu;
 	struct rq_flags rf;
 	struct rq *rq;
@@ -2370,6 +2371,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
 		 */
 		cpu_valid_mask = cpu_online_mask;
+	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/*
-- 
2.31.1.751.gd2f1c929bd-goog

