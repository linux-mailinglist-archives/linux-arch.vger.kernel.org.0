Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24938CB31
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 18:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhEUQma (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 12:42:30 -0400
Received: from foss.arm.com ([217.140.110.172]:51282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233011AbhEUQma (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 12:42:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 869721424;
        Fri, 21 May 2021 09:41:06 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 357A53F73B;
        Fri, 21 May 2021 09:41:04 -0700 (PDT)
Date:   Fri, 21 May 2021 17:41:01 +0100
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 11/21] sched: Split the guts of sched_setaffinity()
 into a helper function
Message-ID: <20210521164101.lwq5wr4mbb32co6l@e107158-lin.cambridge.arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-12-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-12-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/18/21 10:47, Will Deacon wrote:
> In preparation for replaying user affinity requests using a saved mask,
> split sched_setaffinity() up so that the initial task lookup and
> security checks are only performed when the request is coming directly
> from userspace.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/sched/core.c | 110 +++++++++++++++++++++++---------------------
>  1 file changed, 58 insertions(+), 52 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9512623d5a60..808bbe669a6d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6788,9 +6788,61 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	return retval;
>  }
>  
> -long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> +static int
> +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
>  {
> +	int retval;
>  	cpumask_var_t cpus_allowed, new_mask;
> +
> +	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
> +		return -ENOMEM;

Shouldn't we free cpus_allowed first?

Cheers

--
Qais Yousef

> +
> +	cpuset_cpus_allowed(p, cpus_allowed);
> +	cpumask_and(new_mask, mask, cpus_allowed);
> +
> +	/*
> +	 * Since bandwidth control happens on root_domain basis,
> +	 * if admission test is enabled, we only admit -deadline
> +	 * tasks allowed to run on all the CPUs in the task's
> +	 * root_domain.
> +	 */
> +#ifdef CONFIG_SMP
> +	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
> +		rcu_read_lock();
> +		if (!cpumask_subset(task_rq(p)->rd->span, new_mask)) {
> +			retval = -EBUSY;
> +			rcu_read_unlock();
> +			goto out_free_masks;
> +		}
> +		rcu_read_unlock();
> +	}
> +#endif
> +again:
> +	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
> +	if (retval)
> +		goto out_free_masks;
> +
> +	cpuset_cpus_allowed(p, cpus_allowed);
> +	if (!cpumask_subset(new_mask, cpus_allowed)) {
> +		/*
> +		 * We must have raced with a concurrent cpuset update.
> +		 * Just reset the cpumask to the cpuset's cpus_allowed.
> +		 */
> +		cpumask_copy(new_mask, cpus_allowed);
> +		goto again;
> +	}
> +
> +out_free_masks:
> +	free_cpumask_var(new_mask);
> +	free_cpumask_var(cpus_allowed);
> +	return retval;
> +}
> +
> +long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> +{
>  	struct task_struct *p;
>  	int retval;
>  
> @@ -6810,68 +6862,22 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  		retval = -EINVAL;
>  		goto out_put_task;
>  	}
> -	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
> -		retval = -ENOMEM;
> -		goto out_put_task;
> -	}
> -	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
> -		retval = -ENOMEM;
> -		goto out_free_cpus_allowed;
> -	}
> -	retval = -EPERM;
> +
>  	if (!check_same_owner(p)) {
>  		rcu_read_lock();
>  		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
>  			rcu_read_unlock();
> -			goto out_free_new_mask;
> +			retval = -EPERM;
> +			goto out_put_task;
>  		}
>  		rcu_read_unlock();
>  	}
>  
>  	retval = security_task_setscheduler(p);
>  	if (retval)
> -		goto out_free_new_mask;
> -
> -
> -	cpuset_cpus_allowed(p, cpus_allowed);
> -	cpumask_and(new_mask, in_mask, cpus_allowed);
> -
> -	/*
> -	 * Since bandwidth control happens on root_domain basis,
> -	 * if admission test is enabled, we only admit -deadline
> -	 * tasks allowed to run on all the CPUs in the task's
> -	 * root_domain.
> -	 */
> -#ifdef CONFIG_SMP
> -	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
> -		rcu_read_lock();
> -		if (!cpumask_subset(task_rq(p)->rd->span, new_mask)) {
> -			retval = -EBUSY;
> -			rcu_read_unlock();
> -			goto out_free_new_mask;
> -		}
> -		rcu_read_unlock();
> -	}
> -#endif
> -again:
> -	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
> +		goto out_put_task;
>  
> -	if (!retval) {
> -		cpuset_cpus_allowed(p, cpus_allowed);
> -		if (!cpumask_subset(new_mask, cpus_allowed)) {
> -			/*
> -			 * We must have raced with a concurrent cpuset
> -			 * update. Just reset the cpus_allowed to the
> -			 * cpuset's cpus_allowed
> -			 */
> -			cpumask_copy(new_mask, cpus_allowed);
> -			goto again;
> -		}
> -	}
> -out_free_new_mask:
> -	free_cpumask_var(new_mask);
> -out_free_cpus_allowed:
> -	free_cpumask_var(cpus_allowed);
> +	retval = __sched_setaffinity(p, in_mask);
>  out_put_task:
>  	put_task_struct(p);
>  	return retval;
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 
