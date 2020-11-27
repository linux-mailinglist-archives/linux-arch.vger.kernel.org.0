Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692482C66A2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgK0NTW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 08:19:22 -0500
Received: from foss.arm.com ([217.140.110.172]:41458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730364AbgK0NTV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 08:19:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 341AC31B;
        Fri, 27 Nov 2020 05:19:21 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 011DA3F70D;
        Fri, 27 Nov 2020 05:19:18 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:19:16 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201127131916.ncoqmg62dselezyl@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-8-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/24/20 15:50, Will Deacon wrote:

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2003a7d5ab5..818c8f7bdf2a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1860,24 +1860,18 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>  }
>  
>  /*
> - * Change a given task's CPU affinity. Migrate the thread to a
> - * proper CPU and schedule it away if the CPU it's executing on
> - * is removed from the allowed bitmask.
> - *
> - * NOTE: the caller must have a valid reference to the task, the
> - * task must not exit() & deallocate itself prematurely. The
> - * call is not atomic; no spinlocks may be held.
> + * Called with both p->pi_lock and rq->lock held; drops both before returning.

nit: wouldn't it be better for the caller to acquire and release the locks?
Not a big deal but it's always confusing when half of the work done outside the
function and the other half done inside.

Thanks

--
Qais Yousef

>   */
> -static int __set_cpus_allowed_ptr(struct task_struct *p,
> -				  const struct cpumask *new_mask, bool check)
> +static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
> +					 const struct cpumask *new_mask,
> +					 bool check,
> +					 struct rq *rq,
> +					 struct rq_flags *rf)
>  {
>  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
>  	unsigned int dest_cpu;
> -	struct rq_flags rf;
> -	struct rq *rq;
>  	int ret = 0;
>  
> -	rq = task_rq_lock(p, &rf);
>  	update_rq_clock(rq);
>  
>  	if (p->flags & PF_KTHREAD) {
> @@ -1929,7 +1923,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  	if (task_running(rq, p) || p->state == TASK_WAKING) {
>  		struct migration_arg arg = { p, dest_cpu };
>  		/* Need help from migration thread: drop lock and wait. */
> -		task_rq_unlock(rq, p, &rf);
> +		task_rq_unlock(rq, p, rf);
>  		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
>  		return 0;
>  	} else if (task_on_rq_queued(p)) {
> @@ -1937,20 +1931,69 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  		 * OK, since we're going to drop the lock immediately
>  		 * afterwards anyway.
>  		 */
> -		rq = move_queued_task(rq, &rf, p, dest_cpu);
> +		rq = move_queued_task(rq, rf, p, dest_cpu);
>  	}
>  out:
> -	task_rq_unlock(rq, p, &rf);
> +	task_rq_unlock(rq, p, rf);
>  
>  	return ret;
>  }
