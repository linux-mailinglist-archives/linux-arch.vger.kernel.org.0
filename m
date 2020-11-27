Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF15C2C66C2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 14:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgK0NXM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 08:23:12 -0500
Received: from foss.arm.com ([217.140.110.172]:41614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbgK0NXL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 08:23:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2093731B;
        Fri, 27 Nov 2020 05:23:11 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4DAC3F70D;
        Fri, 27 Nov 2020 05:23:08 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:23:06 +0000
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
Subject: Re: [PATCH v4 08/14] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20201127132306.ee4frq6ujz3fqxic@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-9-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/24/20 15:50, Will Deacon wrote:
> When exec'ing a 32-bit task on a system with mismatched support for
> 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> run it.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/process.c | 42 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1540ab0fbf23..72116b0c7c73 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -31,6 +31,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
> +#include <linux/cpuset.h>
>  #include <linux/elfcore.h>
>  #include <linux/pm.h>
>  #include <linux/tick.h>
> @@ -625,6 +626,45 @@ unsigned long arch_align_stack(unsigned long sp)
>  	return sp & ~0xf;
>  }
>  
> +static void adjust_compat_task_affinity(struct task_struct *p)
> +{
> +	cpumask_var_t cpuset_mask;
> +	const struct cpumask *possible_mask = system_32bit_el0_cpumask();
> +	const struct cpumask *newmask = possible_mask;
> +
> +	/*
> +	 * Restrict the CPU affinity mask for a 32-bit task so that it contains
> +	 * only the 32-bit-capable subset of its original CPU mask. If this is
> +	 * empty, then try again with the cpuset allowed mask. If that fails,
> +	 * forcefully override it with the set of all 32-bit-capable CPUs that
> +	 * we know about.
> +	 *
> +	 * From the perspective of the task, this looks similar to what would
> +	 * happen if the 64-bit-only CPUs were hot-unplugged at the point of
> +	 * execve().
> +	 */
> +	if (!restrict_cpus_allowed_ptr(p, possible_mask))
> +		goto out;
> +
> +	if (alloc_cpumask_var(&cpuset_mask, GFP_KERNEL)) {
> +		cpuset_cpus_allowed(p, cpuset_mask);
> +		if (cpumask_and(cpuset_mask, cpuset_mask, possible_mask)) {
> +			newmask = cpuset_mask;
> +			goto out_set_mask;
> +		}
> +	}

Wouldn't it be better to move this logic to restrict_cpus_allowed_ptr()?
I think it should always take cpusets into account and it's not special to
this particular handling here, no?

> +
> +	if (printk_ratelimit()) {
> +		printk_deferred("Overriding affinity for 32-bit process %d (%s) to CPUs %*pbl\n",
> +				task_pid_nr(p), p->comm, cpumask_pr_args(newmask));
> +	}

We have 2 cases where the affinity could have been overridden but we won't
print anything:

	1. restrict_cpus_allowed_ptr()
	2. intersection of cpuset_mask and possible mask drops some cpus.

Shouldn't we print something in these cases too?

IMO it would be better to move this print to restrict_cpus_allowed_ptr() too.

Thanks

--
Qais Yousef

> +out_set_mask:
> +	set_cpus_allowed_ptr(p, newmask);
> +	free_cpumask_var(cpuset_mask);
> +out:
> +	set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +}
> +
>  /*
>   * Called from setup_new_exec() after (COMPAT_)SET_PERSONALITY.
>   */
> @@ -635,7 +675,7 @@ void arch_setup_new_exec(void)
>  	if (is_compat_task()) {
>  		mmflags = MMCF_AARCH32;
>  		if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
> -			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +			adjust_compat_task_affinity(current);
>  	}
>  
>  	current->mm->context.flags = mmflags;
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
