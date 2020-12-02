Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26AE2CBD9F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 14:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgLBNAq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 08:00:46 -0500
Received: from foss.arm.com ([217.140.110.172]:38834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbgLBNAn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 08:00:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2779D30E;
        Wed,  2 Dec 2020 04:59:57 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7C5C3F718;
        Wed,  2 Dec 2020 04:59:54 -0800 (PST)
Date:   Wed, 2 Dec 2020 12:59:52 +0000
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
Message-ID: <20201202125952.z2q6oucoqbwt6aq2@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-13-will@kernel.org>
 <20201127134122.oughqeizhl2j4iky@e107158-lin.cambridge.arm.com>
 <20201201221335.GA28496@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201221335.GA28496@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/01/20 22:13, Will Deacon wrote:
> On Fri, Nov 27, 2020 at 01:41:22PM +0000, Qais Yousef wrote:
> > On 11/24/20 15:50, Will Deacon wrote:
> > > If we want to support 32-bit applications, then when we identify a CPU
> > > with mismatched 32-bit EL0 support we must ensure that we will always
> > > have an active 32-bit CPU available to us from then on. This is important
> > > for the scheduler, because is_cpu_allowed() will be constrained to 32-bit
> > > CPUs for compat tasks and forced migration due to a hotplug event will
> > > hang if no 32-bit CPUs are available.
> > > 
> > > On detecting a mismatch, prevent offlining of either the mismatching CPU
> > > if it is 32-bit capable, or find the first active 32-bit capable CPU
> > > otherwise.
> >                                        ^^^^^
> > 
> > You use cpumask_any_and(). Better use cpumask_first_and()? We have a truly
> > random function now, cpumask_any_and_distribute(), if you'd like to pick
> > something 'truly' random.
> 
> I think cpumask_any_and() is better, because it makes it clear that I don't
> care about which CPU is chosen (and under the hood it ends up calling
> cpumask_first_and() _anyway_). So this is purely cosmetic.
> 
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 29017cbb6c8e..fe470683b43e 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -1237,6 +1237,8 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
> > >  
> > >  static int enable_mismatched_32bit_el0(unsigned int cpu)
> > >  {
> > > +	static int lucky_winner = -1;
> > > +
> > >  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> > >  	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
> > >  
> > > @@ -1245,6 +1247,22 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
> > >  		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
> > >  	}
> > >  
> > > +	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
> > > +		return 0;
> > 
> > Hmm I'm struggling to get what you're doing here. You're treating CPU0 (the
> > boot CPU) specially here, but I don't get why?
> 
> If our ability to execute 32-bit code is the same as the boot CPU then we
> don't have to do anything. That way, we can postpone nominating the lucky
> winner until we really need to.

Okay I see what you're doing now. The '== cpu_32bit' part of the check gave me
trouble. If the first N cpus are 64bit only, we'll skip them here. Worth
a comment?

Wouldn't it be better to replace this with a check if cpu_32bit_el0_mask is
empty instead? That would be a lot easier to read.

> 
> > > +	if (lucky_winner >= 0)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * We've detected a mismatch. We need to keep one of our CPUs with
> > > +	 * 32-bit EL0 online so that is_cpu_allowed() doesn't end up rejecting
> > > +	 * every CPU in the system for a 32-bit task.
> > > +	 */
> > > +	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
> > > +							 cpu_active_mask);
> > 
> > cpumask_any_and() could return an error. It could be hard or even impossible to
> > trigger, but better check if lucky_winner is not >= nr_cpu_ids before calling
> > get_cpu_device(lucky_winner) to stay in the safe side and avoid a potential
> > splat?
> 
> I don't see how it can return an error here. There are two cases to
> consider:
> 
>   1. The CPU being brought online is the first 32-bit-capable CPU. In which
>      case, we don't use cpumask_any_and() at all.
> 
>   2. The CPU being brought online is the first 64-bit-only CPU. In which
>      case, the CPU doing the onlining is 32-bit capable and will be in
>      the active mask.

Now I understand the if condition above; yeah I think this will not hit.
The condition above simply guarantees cpu_32bit_el0_mask is not empty. And
since this is online path, there's a guarantee there's a single bit shared
between the 2 masks since the same path must have set this shared bit.

> 
> > We can do better by the way and do smarter check in remove_cpu() to block
> > offlining the last aarch32 capable CPU without 'hardcoding' a specific cpu. But
> > won't insist and happy to wait for someone to come complaining this is not good
> > enough first.
> 
> I couldn't find a satisfactory way to do this without the possibility of
> subtle races, so I'd prefer to keep it simple for the moment. In particular,
> I wanted to make sure that somebody iterating over the cpu_possible_mask
> and calling is_cpu_allowed(p, cpu) for each CPU and a 32-bit task can not
> reach the end of the mask without ever getting a value of 'true'.
> 
> I'm open to revisiting this once some of this is merged, but right now
> I don't think it's needed and it certainly adds complexity.

Agreed. I just wanted to share some awareness. Let's not make this series more
complicated than it needs to be.

> 
> > Some vendors play games with hotplug to help with saving power. They might want
> > to dynamically nominate the last man standing 32bit capable CPU. Again, we can
> > wait for someone to complain first I guess.
> 
> The reality is that either all "big" cores or all "little" cores will be the
> ones that are 32-bit capable, so I doubt it matters an awful lot which one
> of the cluster is left online from a PM perspective. The real problem is
> that a core has to be left online at all, but I don't think we can avoid
> that.

I don't have specific info, but in theory it could matter. We enforce
a specific core to be always online, rather than allow any core to be offlined
until there's a single one left in the mask. I agree we shouldn't worry about
this for now.

And yes, we can't avoid keeping the last 32bit capable cpu online. The same way
we can't offline the last cpu in a normal system.

Thanks

--
Qais Yousef
