Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CCD3904DC
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhEYPQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEYPQt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:16:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80DAA61429;
        Tue, 25 May 2021 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955719;
        bh=CaGYuHn+SqIHxXU6UGDKeLwnmsQSpMp2vSwKl8cv+Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvmR/T+9ImdYkkQM1ZIkxS6tIN/uW8GD9TCkPdOWhJ3aEGz7iodQEj0jl299SBLmu
         AqW+Sm2k4NLx6qCNcgNmpWR8xXGEiWmWahHD/NLhTJcvvbeBgNXy824r229OikQ0r2
         U4QmE1KH1XElloVrc9LB9xRzwSJmAjfoqYCQuY+t2bpDDH6ou/T45Dr88vriiU9mUi
         DkFl+Q35Q8hfvU+7LCPbKN7VwLVgkYVrSfrjrU24kqwVHSLYWO4sAE8WE3z+mCAcM2
         7re0y70/gZq2/v1xHXibaIn8Gd9y4aXemC5Ei6EIxutr8ZVk+gqHl21iPPxJsiguCJ
         ygvohKNFwCQCw==
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
        kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v7 01/22] sched: Favour predetermined active CPU as migration destination
Date:   Tue, 25 May 2021 16:14:11 +0100
Message-Id: <20210525151432.16875-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since commit 6d337eab041d ("sched: Fix migrate_disable() vs
set_cpus_allowed_ptr()"), the migration stopper thread is left to
determine the destination CPU of the running task being migrated, even
though set_cpus_allowed_ptr() already identified a candidate target
earlier on.

Unfortunately, the stopper doesn't check whether or not the new
destination CPU is active or not, so __migrate_task() can leave the task
sitting on a CPU that is outside of its affinity mask, even if the CPU
originally chosen by SCA is still active.

For example, with CONFIG_CPUSET=n:

 $ taskset -pc 0-2 $PID
 # offline CPUs 3-4
 $ taskset -pc 3-5 $PID

Then $PID remains on its current CPU (one of 0-2) and does not get
migrated to CPU 5.

Rework 'struct migration_arg' so that an optional pointer to an affinity
mask can be provided to the stopper, allowing us to respect the
original choice of destination CPU when migrating. Note that there is
still the potential to race with a concurrent CPU hot-unplug of the
destination CPU if the caller does not hold the hotplug lock.

Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..1702a60d178d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1869,6 +1869,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 struct migration_arg {
 	struct task_struct		*task;
 	int				dest_cpu;
+	const struct cpumask		*dest_mask;
 	struct set_affinity_pending	*pending;
 };
 
@@ -1917,6 +1918,7 @@ static int migration_cpu_stop(void *data)
 	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
 	int dest_cpu = arg->dest_cpu;
+	const struct cpumask *dest_mask = arg->dest_mask;
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
@@ -1956,12 +1958,8 @@ static int migration_cpu_stop(void *data)
 			complete = true;
 		}
 
-		if (dest_cpu < 0) {
-			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
-				goto out;
-
-			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
-		}
+		if (dest_mask && (cpumask_test_cpu(task_cpu(p), dest_mask)))
+			goto out;
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
@@ -2249,7 +2247,8 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			init_completion(&my_pending.done);
 			my_pending.arg = (struct migration_arg) {
 				.task = p,
-				.dest_cpu = -1,		/* any */
+				.dest_cpu = dest_cpu,
+				.dest_mask = &p->cpus_mask,
 				.pending = &my_pending,
 			};
 
-- 
2.31.1.818.g46aad6cb9e-goog

