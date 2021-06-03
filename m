Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B5A39A1B4
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 14:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFCNAs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 09:00:48 -0400
Received: from foss.arm.com ([217.140.110.172]:40942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhFCNAs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 09:00:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B34BC1063;
        Thu,  3 Jun 2021 05:59:03 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.3.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4929C3F774;
        Thu,  3 Jun 2021 05:58:59 -0700 (PDT)
Date:   Thu, 3 Jun 2021 13:58:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
        kernel-team@android.com
Subject: Re: [PATCH v8 15/19] arm64: Prevent offlining first CPU with 32-bit
 EL0 on mismatched system
Message-ID: <20210603125856.GC48596@C02TD0UTHF1T.local>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-16-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602164719.31777-16-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 02, 2021 at 05:47:15PM +0100, Will Deacon wrote:
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
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4194a47de62d..b31d7a1eaed6 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2877,15 +2877,33 @@ void __init setup_cpu_features(void)
>  
>  static int enable_mismatched_32bit_el0(unsigned int cpu)
>  {
> +	static int lucky_winner = -1;

This is cute, but could we please give it a meaningful name, e.g.
`pinned_cpu` ?

> +
>  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
>  	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
>  
>  	if (cpu_32bit) {
>  		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
>  		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
> -		setup_elf_hwcaps(compat_elf_hwcaps);
>  	}
>  
> +	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
> +		return 0;
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
> +	get_cpu_device(lucky_winner)->offline_disabled = true;
> +	setup_elf_hwcaps(compat_elf_hwcaps);
> +	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
> +		cpu, lucky_winner);
>  	return 0;
>  }

I guess this is going to play havoc with kexec and hibernate. :/

Thanks,
Mark.
