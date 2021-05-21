Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BAD38CB9C
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhEURNC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 13:13:02 -0400
Received: from foss.arm.com ([217.140.110.172]:51910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhEURNB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 13:13:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 519DA1424;
        Fri, 21 May 2021 10:11:37 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069013F73D;
        Fri, 21 May 2021 10:11:34 -0700 (PDT)
Date:   Fri, 21 May 2021 18:11:32 +0100
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
Subject: Re: [PATCH v6 12/21] sched: Allow task CPU affinity to be restricted
 on asymmetric systems
Message-ID: <20210521171132.ev56j4isuxtf2zqa@e107158-lin.cambridge.arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-13-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-13-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/18/21 10:47, Will Deacon wrote:
> Asymmetric systems may not offer the same level of userspace ISA support
> across all CPUs, meaning that some applications cannot be executed by
> some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> not feature support for 32-bit applications on both clusters.
> 
> Although userspace can carefully manage the affinity masks for such
> tasks, one place where it is particularly problematic is execve()
> because the CPU on which the execve() is occurring may be incompatible
> with the new application image. In such a situation, it is desirable to
> restrict the affinity mask of the task and ensure that the new image is
> entered on a compatible CPU. From userspace's point of view, this looks
> the same as if the incompatible CPUs have been hotplugged off in the
> task's affinity mask. Similarly, if a subsequent execve() reverts to
> a compatible image, then the old affinity is restored if it is still
> valid.
> 
> In preparation for restricting the affinity mask for compat tasks on
> arm64 systems without uniform support for 32-bit applications, introduce
> {force,relax}_compatible_cpus_allowed_ptr(), which respectively restrict
> and restore the affinity mask for a task based on the compatible CPUs.
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/sched.h |   2 +
>  kernel/sched/core.c   | 165 ++++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h  |   1 +
>  3 files changed, 152 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index db32d4f7e5b3..91a6cfeae242 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1691,6 +1691,8 @@ extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new
>  extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
>  extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
>  extern void release_user_cpus_ptr(struct task_struct *p);
> +extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
> +extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
>  #else
>  static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>  {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 808bbe669a6d..ba66bcf8e812 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2357,26 +2357,21 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
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
>   */
> -static int __set_cpus_allowed_ptr(struct task_struct *p,
> -				  const struct cpumask *new_mask,
> -				  u32 flags)
> +static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
> +					 const struct cpumask *new_mask,
> +					 u32 flags,
> +					 struct rq *rq,
> +					 struct rq_flags *rf)
> +	__releases(rq->lock)
> +	__releases(p->pi_lock)
>  {
>  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
>  	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
>  	unsigned int dest_cpu;
> -	struct rq_flags rf;
> -	struct rq *rq;
>  	int ret = 0;
>  
> -	rq = task_rq_lock(p, &rf);
>  	update_rq_clock(rq);
>  
>  	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
> @@ -2430,20 +2425,158 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  
>  	__do_set_cpus_allowed(p, new_mask, flags);
>  
> -	return affine_move_task(rq, p, &rf, dest_cpu, flags);
> +	if (flags & SCA_USER)
> +		release_user_cpus_ptr(p);

Why do we need to release the pointer here?

Doesn't this mean if a 32bit task requests to change its affinity, then we'll
lose this info and a subsequent execve() to a 64bit application means we won't
be able to restore the original mask?

ie:

	p0-64bit
	  execve(32bit_app)
	    // p1-32bit created
	    p1-32bit.change_affinity()
	      relase_user_cpus_ptr()
	    execve(64bit_app)           // lost info about p0 affinity?

Hmm I think this helped me to get the answer. p1 changed its affinity, then
there's nothing to be inherited by a new execve(), so yes we no longer need
this info.

> +
> +	return affine_move_task(rq, p, rf, dest_cpu, flags);
>  
>  out:
> -	task_rq_unlock(rq, p, &rf);
> +	task_rq_unlock(rq, p, rf);
>  
>  	return ret;
>  }

[...]

> +/*
> + * Change a given task's CPU affinity to the intersection of its current
> + * affinity mask and @subset_mask, writing the resulting mask to @new_mask
> + * and pointing @p->user_cpus_ptr to a copy of the old mask.
> + * If the resulting mask is empty, leave the affinity unchanged and return
> + * -EINVAL.
> + */
> +static int restrict_cpus_allowed_ptr(struct task_struct *p,
> +				     struct cpumask *new_mask,
> +				     const struct cpumask *subset_mask)
> +{
> +	struct rq_flags rf;
> +	struct rq *rq;
> +	int err;
> +	struct cpumask *user_mask = NULL;
> +
> +	if (!p->user_cpus_ptr)
> +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> +
> +	rq = task_rq_lock(p, &rf);
> +
> +	/*
> +	 * We're about to butcher the task affinity, so keep track of what
> +	 * the user asked for in case we're able to restore it later on.
> +	 */
> +	if (user_mask) {
> +		cpumask_copy(user_mask, p->cpus_ptr);
> +		p->user_cpus_ptr = user_mask;
> +	}
> +
> +	/*
> +	 * Forcefully restricting the affinity of a deadline task is
> +	 * likely to cause problems, so fail and noisily override the
> +	 * mask entirely.
> +	 */
> +	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
> +		err = -EPERM;
> +		goto err_unlock;

free(user_mark) first?

> +	}
> +
> +	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
> +		err = -EINVAL;
> +		goto err_unlock;

ditto

> +	}
> +
> +	return __set_cpus_allowed_ptr_locked(p, new_mask, false, rq, &rf);
> +
> +err_unlock:
> +	task_rq_unlock(rq, p, &rf);
> +	return err;
> +}

Thanks

--
Qais Yousef
