Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C803DB7BA
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 13:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbhG3LZU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 07:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238662AbhG3LZQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 07:25:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D444961050;
        Fri, 30 Jul 2021 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627644311;
        bh=7LEh2aSH3zOeZLBW6RvesFNL9tENH6Ea6cYaqsgwy6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozkspCQJ9DpTuoIeGCM/4uUwKbVKkHbVMiC0KEvv6XbS1PVA/kZ6mdQ53FueMXklP
         WheblWgaAXsP74bkbNQTnN5+Vp57tDXVrVi89tYSEE2PDLjd8S7XI0M+OPRdlnJ8VE
         boZBzgHXOOlC2KyaByjBmOHZm4PDgoHR3HGXSowAcmxrwQDXSxtQxtptPPJoXMugd5
         FgwFshx/uhv8iXf3lLXQCPdJ4H8BXRFJtbyDrwWZPR3Z1tYyHwGjEnk+ff+aCwPiad
         XRzYq4NTTAlBT0tDVDMuBlGB6UCq+DnsqcKFt6Eryf+kSSsZxzLSM1yr+Q57MrXzKE
         M/e//lQTmGnyA==
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
Subject: [PATCH v11 05/16] sched: Reject CPU affinity changes based on task_cpu_possible_mask()
Date:   Fri, 30 Jul 2021 12:24:32 +0100
Message-Id: <20210730112443.23245-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210730112443.23245-1-will@kernel.org>
References: <20210730112443.23245-1-will@kernel.org>
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

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9fd598b8dac5..dbce9cd83a53 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2700,15 +2700,17 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	unsigned int dest_cpu;
 	struct rq_flags rf;
 	struct rq *rq;
 	int ret = 0;
+	bool kthread = p->flags & PF_KTHREAD;
 
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
+	if (kthread || is_migration_disabled(p)) {
 		/*
 		 * Kernel threads are allowed on online && !active CPUs,
 		 * however, during cpu-hot-unplug, even these might get pushed
@@ -2722,6 +2724,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		cpu_valid_mask = cpu_online_mask;
 	}
 
+	if (!kthread && !cpumask_subset(new_mask, cpu_allowed_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
-- 
2.32.0.402.g57bb445576-goog

