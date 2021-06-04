Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3471F39BE32
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFDRNo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 13:13:44 -0400
Received: from foss.arm.com ([217.140.110.172]:43838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhFDRNo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 13:13:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853941063;
        Fri,  4 Jun 2021 10:11:57 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58693F73D;
        Fri,  4 Jun 2021 10:11:54 -0700 (PDT)
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
Subject: Re: [PATCH v8 08/19] sched: Reject CPU affinity changes based on task_cpu_possible_mask()
In-Reply-To: <20210602164719.31777-9-will@kernel.org>
References: <20210602164719.31777-1-will@kernel.org> <20210602164719.31777-9-will@kernel.org>
Date:   Fri, 04 Jun 2021 18:11:52 +0100
Message-ID: <874kedeeqv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/06/21 17:47, Will Deacon wrote:
> Reject explicit requests to change the affinity mask of a task via
> set_cpus_allowed_ptr() if the requested mask is not a subset of the
> mask returned by task_cpu_possible_mask(). This ensures that the
> 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> executing it, except in cases where the affinity is forced.
>
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

One comment/observation below, but regardless:

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>

> ---
>  kernel/sched/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0c1b6f1a6c91..b23c7f0ab31a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2347,15 +2347,17 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>                                 u32 flags)
>  {
>       const struct cpumask *cpu_valid_mask = cpu_active_mask;
> +	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
>       unsigned int dest_cpu;
>       struct rq_flags rf;
>       struct rq *rq;
>       int ret = 0;
> +	bool kthread = p->flags & PF_KTHREAD;
>
>       rq = task_rq_lock(p, &rf);
>       update_rq_clock(rq);
>
> -	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
> +	if (kthread || is_migration_disabled(p)) {
>               /*
>                * Kernel threads are allowed on online && !active CPUs,
>                * however, during cpu-hot-unplug, even these might get pushed
> @@ -2369,6 +2371,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>               cpu_valid_mask = cpu_online_mask;
>       }
>
> +	if (!kthread && !cpumask_subset(new_mask, cpu_allowed_mask)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +

IIUC this wouldn't be required if guarantee_online_cpus() couldn't build a
mask that extends beyond task_cpu_possible_mask(p): if the new mask doesn't
intersect with that possible mask, it means we're carrying an empty cpumask
and the cpumask_any_and_distribute() below would return nr_cpu_ids, so we'd
bail with -EINVAL.

I don't really see a way around it though due to the expectations behind
guarantee_online_cpus() :/

>       /*
>        * Must re-check here, to close a race against __kthread_bind(),
>        * sched_setaffinity() is not guaranteed to observe the flag.
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
