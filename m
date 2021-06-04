Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE6A39B618
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFDJkK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 05:40:10 -0400
Received: from foss.arm.com ([217.140.110.172]:34078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhFDJkK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 05:40:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04CAB1063;
        Fri,  4 Jun 2021 02:38:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663C03F774;
        Fri,  4 Jun 2021 02:38:19 -0700 (PDT)
Date:   Fri, 4 Jun 2021 10:38:08 +0100
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
Subject: Re: [PATCH v8 02/19] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20210604093808.GA64162@C02TD0UTHF1T.local>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-3-will@kernel.org>
 <20210603123715.GA48596@C02TD0UTHF1T.local>
 <20210603174413.GC1170@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603174413.GC1170@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 06:44:14PM +0100, Will Deacon wrote:
> On Thu, Jun 03, 2021 at 01:37:15PM +0100, Mark Rutland wrote:
> > On Wed, Jun 02, 2021 at 05:47:02PM +0100, Will Deacon wrote:
> > > When confronted with a mixture of CPUs, some of which support 32-bit
> > > applications and others which don't, we quite sensibly treat the system
> > > as 64-bit only for userspace and prevent execve() of 32-bit binaries.
> > > 
> > > Unfortunately, some crazy folks have decided to build systems like this
> > > with the intention of running 32-bit applications, so relax our
> > > sanitisation logic to continue to advertise 32-bit support to userspace
> > > on these systems and track the real 32-bit capable cores in a cpumask
> > > instead. For now, the default behaviour remains but will be tied to
> > > a command-line option in a later patch.
> > > 
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/cpufeature.h |   8 +-
> > >  arch/arm64/kernel/cpufeature.c      | 114 ++++++++++++++++++++++++----
> > >  arch/arm64/tools/cpucaps            |   3 +-
> > >  3 files changed, 110 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > > index 338840c00e8e..603bf4160cd6 100644
> > > --- a/arch/arm64/include/asm/cpufeature.h
> > > +++ b/arch/arm64/include/asm/cpufeature.h
> > > @@ -630,9 +630,15 @@ static inline bool cpu_supports_mixed_endian_el0(void)
> > >  	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
> > >  }
> > >  
> > > +const struct cpumask *system_32bit_el0_cpumask(void);
> > > +DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
> > > +
> > >  static inline bool system_supports_32bit_el0(void)
> > >  {
> > > -	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
> > > +	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> > > +
> > > +	return static_branch_unlikely(&arm64_mismatched_32bit_el0) ||
> > > +	       id_aa64pfr0_32bit_el0(pfr0);
> > >  }
> > 
> > Note that read_sanitised_ftr_reg() has to do a bsearch() to find the
> > arm64_ftr_reg, so this will make system_32bit_el0_cpumask() a fair
> > amount more expensive than it needs to be.
> 
> I seriously doubt that it matters, but it did come up before and I proposed
> a potential solution if it's actually a concern:
> 
> https://lore.kernel.org/r/20201202172727.GC29813@willie-the-truck
> 
> so if you can show that it's a problem, we can resurrect something like
> that.

I'm happy to leave that for future. I raised this because elsewhere this
is an issue when we need to avoid instrumentation; if that's not a
concern here on any path then I am not aware of a functional issue.

> > Can we follow the pattern we have for arm64_ftr_reg_ctrel0, and have a
> > arm64_ftr_reg_id_aa64pfr0_el1 that we can address directly here?
> 
> I mean, clearly its possible, but based on what data?
> 
> > That said. I reckon this could be much cleaner if we maintained separate
> > caps:
> > 
> > ARM64_ALL_CPUS_HAVE_32BIT_EL0
> > ARM64_SOME_CPUS_HAVE_32BIT_EL0
> > 
> > ... and allow arm64_mismatched_32bit_el0 to be set dependent on
> > ARM64_SOME_CPUS_HAVE_32BIT_EL0. With that, this can be simplified to:
> > 
> > static inline bool system_supports_32bit_el0(void)
> > {
> > 	return (cpus_have_const_cap(ARM64_ALL_CPUS_HAVE_32BIT_EL0)) ||
> > 		static_branch_unlikely(&arm64_mismatched_32bit_el0))
> 
> Something similar was discussed in November last year but this falls
> apart with late onlining because its not generally possible to tell whether
> you've seen all the CPUs or not.

Ah; is that for when your boot CPU set is all AArch32-capable, but a
late-onlined CPU is not?

I assume that we require at least one of the set of boot CPUs to be
AArch32 cpable, and don't settle the compat hwcaps after userspace has
started.

> I'm mostly reluctant to make significant changes based on cosmetic
> preferences because testing and debugging this with all the system
> combinations is really difficult.

Fair enough.

> > > +{
> > > +	static bool boot_cpu_32bit_regs_overridden = false;
> > > +
> > > +	if (!allow_mismatched_32bit_el0 || boot_cpu_32bit_regs_overridden)
> > > +		return;
> > > +
> > > +	if (id_aa64pfr0_32bit_el0(boot->reg_id_aa64pfr0))
> > > +		return;
> > > +
> > > +	boot->aarch32 = info->aarch32;
> > > +	init_32bit_cpu_features(&boot->aarch32);
> > > +	boot_cpu_32bit_regs_overridden = true;
> > > +}
> > 
> > Can't we share this with the boot CPU path if we do:
> > 
> > /*
> >  * Initialize the common AArch32 features on the first CPU with AArch32.
> >  */
> > static void lazy_init_32bit_el0_cpu_features(struct cpuinfo_arm64 *info,
> > 					     struct cpuinfo_arm64 *boot)
> > {
> > 	static bool initialised = false;
> > 	if (initialised || !id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
> > 		return;
> > 	
> > 	boot->aarch32 = info->aarch32;
> > 	init_32bit_cpu_features(&boot->aarch32);
> > 	initiaised = true;
> > }
> > 
> > ... or is the allow_mismatched_32bit_el0 check necessary for late
> > hotplug?
> 
> Interesting. I think this works, but I'm wary that it results in the
> 32-bit features of a 64-bit-only boot CPU being populated using the first
> 32-bit-capable CPU even if we're not running with allow_mismatched_32bit_el0
> enabled. That feels like setting ourselves up for future bugs. For example,
> compat_has_neon() would unexpectedly return true even though 32-bit execve()
> would be forbidden.

Sure; I had not considered that case.

Thanks,
Mark.
