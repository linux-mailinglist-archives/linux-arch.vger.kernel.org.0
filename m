Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE053915C2
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhEZLP5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 07:15:57 -0400
Received: from foss.arm.com ([217.140.110.172]:43016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234060AbhEZLP4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 07:15:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF62B1516;
        Wed, 26 May 2021 04:14:24 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E0463F73B;
        Wed, 26 May 2021 04:14:22 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
        kernel-team@android.com
Subject: Re: [PATCH v7 01/22] sched: Favour predetermined active CPU as migration destination
In-Reply-To: <20210525151432.16875-2-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org> <20210525151432.16875-2-will@kernel.org>
Date:   Wed, 26 May 2021 12:14:20 +0100
Message-ID: <877djlhhmb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 25/05/21 16:14, Will Deacon wrote:
> Since commit 6d337eab041d ("sched: Fix migrate_disable() vs
> set_cpus_allowed_ptr()"), the migration stopper thread is left to
> determine the destination CPU of the running task being migrated, even
> though set_cpus_allowed_ptr() already identified a candidate target
> earlier on.
>
> Unfortunately, the stopper doesn't check whether or not the new
> destination CPU is active or not, so __migrate_task() can leave the task
> sitting on a CPU that is outside of its affinity mask, even if the CPU
> originally chosen by SCA is still active.
>
> For example, with CONFIG_CPUSET=n:
>
>  $ taskset -pc 0-2 $PID
>  # offline CPUs 3-4
>  $ taskset -pc 3-5 $PID
>
> Then $PID remains on its current CPU (one of 0-2) and does not get
> migrated to CPU 5.
>
> Rework 'struct migration_arg' so that an optional pointer to an affinity
> mask can be provided to the stopper, allowing us to respect the
> original choice of destination CPU when migrating. Note that there is
> still the potential to race with a concurrent CPU hot-unplug of the
> destination CPU if the caller does not hold the hotplug lock.
>
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/sched/core.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..1702a60d178d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1869,6 +1869,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
>  struct migration_arg {
>       struct task_struct		*task;
>       int				dest_cpu;
> +	const struct cpumask		*dest_mask;
>       struct set_affinity_pending	*pending;
>  };
>
> @@ -1917,6 +1918,7 @@ static int migration_cpu_stop(void *data)
>       struct set_affinity_pending *pending = arg->pending;
>       struct task_struct *p = arg->task;
>       int dest_cpu = arg->dest_cpu;
> +	const struct cpumask *dest_mask = arg->dest_mask;
>       struct rq *rq = this_rq();
>       bool complete = false;
>       struct rq_flags rf;
> @@ -1956,12 +1958,8 @@ static int migration_cpu_stop(void *data)
>                       complete = true;
>               }
>
> -		if (dest_cpu < 0) {
> -			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
> -				goto out;
> -
> -			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
> -		}
> +		if (dest_mask && (cpumask_test_cpu(task_cpu(p), dest_mask)))
> +			goto out;
>

IIRC the reason we deferred the pick to migration_cpu_stop() was because of
those insane races involving multiple SCA calls the likes of:

  p->cpus_mask = [0, 1]; p on CPU0

  CPUx                           CPUy                   CPU0

  SCA(p, [2])
    __do_set_cpus_allowed();
    queue migration_cpu_stop()
                                 SCA(p, [3])
                                   __do_set_cpus_allowed();
                                                        migration_cpu_stop()

The stopper needs to use the latest cpumask set by the second SCA despite
having an arg->pending set up by the first SCA. Doesn't this break here?

I'm not sure I've paged back in all of the subtleties laying in ambush
here, but what about the below?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..cd447c9db61d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1916,7 +1916,6 @@ static int migration_cpu_stop(void *data)
 	struct migration_arg *arg = data;
 	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
-	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
@@ -1954,19 +1953,15 @@ static int migration_cpu_stop(void *data)
 		if (pending) {
 			p->migration_pending = NULL;
 			complete = true;
-		}
 
-		if (dest_cpu < 0) {
 			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
 				goto out;
-
-			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
 		}
 
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, dest_cpu);
+			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
 		else
-			p->wake_cpu = dest_cpu;
+			p->wake_cpu = arg->dest_cpu;
 
 		/*
 		 * XXX __migrate_task() can fail, at which point we might end
@@ -2249,7 +2244,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			init_completion(&my_pending.done);
 			my_pending.arg = (struct migration_arg) {
 				.task = p,
-				.dest_cpu = -1,		/* any */
+				.dest_cpu = dest_cpu,
 				.pending = &my_pending,
 			};
 
@@ -2257,6 +2252,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		} else {
 			pending = p->migration_pending;
 			refcount_inc(&pending->refs);
+			pending->arg.dest_cpu = dest_cpu;
 		}
 	}
 	pending = p->migration_pending;
