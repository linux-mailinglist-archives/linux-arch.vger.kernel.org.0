Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A725138CAEC
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhEUQ0x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 12:26:53 -0400
Received: from foss.arm.com ([217.140.110.172]:50960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhEUQ0x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 12:26:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 471EF1424;
        Fri, 21 May 2021 09:25:29 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBD233F73B;
        Fri, 21 May 2021 09:25:26 -0700 (PDT)
Date:   Fri, 21 May 2021 17:25:24 +0100
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
Subject: Re: [PATCH v6 08/21] cpuset: Honour task_cpu_possible_mask() in
 guarantee_online_cpus()
Message-ID: <20210521162524.22cwmrao3df7m4jb@e107158-lin.cambridge.arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-9-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/18/21 10:47, Will Deacon wrote:
> Asymmetric systems may not offer the same level of userspace ISA support
> across all CPUs, meaning that some applications cannot be executed by
> some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> not feature support for 32-bit applications on both clusters.
> 
> Modify guarantee_online_cpus() to take task_cpu_possible_mask() into
> account when trying to find a suitable set of online CPUs for a given
> task. This will avoid passing an invalid mask to set_cpus_allowed_ptr()
> during ->attach() and will subsequently allow the cpuset hierarchy to be
> taken into account when forcefully overriding the affinity mask for a
> task which requires migration to a compatible CPU.
> 
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/cpuset.h |  2 +-
>  kernel/cgroup/cpuset.c | 33 +++++++++++++++++++--------------
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index ed6ec677dd6b..414a8e694413 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -185,7 +185,7 @@ static inline void cpuset_read_unlock(void) { }
>  static inline void cpuset_cpus_allowed(struct task_struct *p,
>  				       struct cpumask *mask)
>  {
> -	cpumask_copy(mask, cpu_possible_mask);
> +	cpumask_copy(mask, task_cpu_possible_mask(p));
>  }
>  
>  static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 8c799260a4a2..b532a5333ff9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -372,18 +372,26 @@ static inline bool is_in_v2_mode(void)
>  }
>  
>  /*
> - * Return in pmask the portion of a cpusets's cpus_allowed that
> - * are online.  If none are online, walk up the cpuset hierarchy
> - * until we find one that does have some online cpus.
> + * Return in pmask the portion of a task's cpusets's cpus_allowed that
> + * are online and are capable of running the task.  If none are found,
> + * walk up the cpuset hierarchy until we find one that does have some
> + * appropriate cpus.
>   *
>   * One way or another, we guarantee to return some non-empty subset
>   * of cpu_online_mask.
>   *
>   * Call with callback_lock or cpuset_mutex held.
>   */
> -static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
> +static void guarantee_online_cpus(struct task_struct *tsk,
> +				  struct cpumask *pmask)
>  {
> -	while (!cpumask_intersects(cs->effective_cpus, cpu_online_mask)) {
> +	struct cpuset *cs = task_cs(tsk);

task_cs() requires rcu_read_lock(), but I can't see how the lock is obtained
from cpuset_attach() path, did I miss it? Running with lockdep should spill
suspicious RCU usage warning.

Maybe it makes more sense to move the rcu_read_lock() inside the function now
with task_cs()?

Thanks

--
Qais Yousef

> +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +
> +	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_online_mask)))
> +		cpumask_copy(pmask, cpu_online_mask);
> +
> +	while (!cpumask_intersects(cs->effective_cpus, pmask)) {
>  		cs = parent_cs(cs);
>  		if (unlikely(!cs)) {
>  			/*
> @@ -393,11 +401,10 @@ static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
>  			 * cpuset's effective_cpus is on its way to be
>  			 * identical to cpu_online_mask.
>  			 */
> -			cpumask_copy(pmask, cpu_online_mask);
>  			return;
>  		}
>  	}
> -	cpumask_and(pmask, cs->effective_cpus, cpu_online_mask);
> +	cpumask_and(pmask, pmask, cs->effective_cpus);
>  }
>  
>  /*
> @@ -2199,15 +2206,13 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  
>  	percpu_down_write(&cpuset_rwsem);
>  
> -	/* prepare for attach */
> -	if (cs == &top_cpuset)
> -		cpumask_copy(cpus_attach, cpu_possible_mask);
> -	else
> -		guarantee_online_cpus(cs, cpus_attach);
> -
>  	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>  
>  	cgroup_taskset_for_each(task, css, tset) {
> +		if (cs != &top_cpuset)
> +			guarantee_online_cpus(task, cpus_attach);
> +		else
> +			cpumask_copy(cpus_attach, task_cpu_possible_mask(task));
>  		/*
>  		 * can_attach beforehand should guarantee that this doesn't
>  		 * fail.  TODO: have a better way to handle failure here
> @@ -3303,7 +3308,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  
>  	spin_lock_irqsave(&callback_lock, flags);
>  	rcu_read_lock();
> -	guarantee_online_cpus(task_cs(tsk), pmask);
> +	guarantee_online_cpus(tsk, pmask);
>  	rcu_read_unlock();
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  }
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 
