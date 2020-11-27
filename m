Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B992C670B
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 14:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgK0Nl2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 08:41:28 -0500
Received: from foss.arm.com ([217.140.110.172]:42176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbgK0Nl1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 08:41:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39C3F31B;
        Fri, 27 Nov 2020 05:41:27 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 057FF3F70D;
        Fri, 27 Nov 2020 05:41:24 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:41:22 +0000
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
Subject: Re: [PATCH v4 12/14] arm64: Prevent offlining first CPU with 32-bit
 EL0 on mismatched system
Message-ID: <20201127134122.oughqeizhl2j4iky@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-13-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-13-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/24/20 15:50, Will Deacon wrote:
> If we want to support 32-bit applications, then when we identify a CPU
> with mismatched 32-bit EL0 support we must ensure that we will always
> have an active 32-bit CPU available to us from then on. This is important
> for the scheduler, because is_cpu_allowed() will be constrained to 32-bit
> CPUs for compat tasks and forced migration due to a hotplug event will
> hang if no 32-bit CPUs are available.
> 
> On detecting a mismatch, prevent offlining of either the mismatching CPU
> if it is 32-bit capable, or find the first active 32-bit capable CPU
> otherwise.
                                       ^^^^^

You use cpumask_any_and(). Better use cpumask_first_and()? We have a truly
random function now, cpumask_any_and_distribute(), if you'd like to pick
something 'truly' random.

I tried to clean up the cpumask_any* API mess, but ended up with too much
headache instead. Killng of cpumask_any*() might be the easier option. But
that's something different..

> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 29017cbb6c8e..fe470683b43e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1237,6 +1237,8 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
>  
>  static int enable_mismatched_32bit_el0(unsigned int cpu)
>  {
> +	static int lucky_winner = -1;
> +
>  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
>  	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
>  
> @@ -1245,6 +1247,22 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
>  		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
>  	}
>  
> +	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
> +		return 0;

Hmm I'm struggling to get what you're doing here. You're treating CPU0 (the
boot CPU) specially here, but I don't get why?

> +
> +	if (lucky_winner >= 0)
> +		return 0;
> +
> +	/*
> +	 * We've detected a mismatch. We need to keep one of our CPUs with
> +	 * 32-bit EL0 online so that is_cpu_allowed() doesn't end up rejecting
> +	 * every CPU in the system for a 32-bit task.
> +	 */
> +	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
> +							 cpu_active_mask);

cpumask_any_and() could return an error. It could be hard or even impossible to
trigger, but better check if lucky_winner is not >= nr_cpu_ids before calling
get_cpu_device(lucky_winner) to stay in the safe side and avoid a potential
splat?

We can do better by the way and do smarter check in remove_cpu() to block
offlining the last aarch32 capable CPU without 'hardcoding' a specific cpu. But
won't insist and happy to wait for someone to come complaining this is not good
enough first.

Some vendors play games with hotplug to help with saving power. They might want
to dynamically nominate the last man standing 32bit capable CPU. Again, we can
wait for someone to complain first I guess.

Cheers

--
Qais Yousef

> +	get_cpu_device(lucky_winner)->offline_disabled = true;
> +	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
> +		cpu, lucky_winner);
>  	return 0;
>  }
>  
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
