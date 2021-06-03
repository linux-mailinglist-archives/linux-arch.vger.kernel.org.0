Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE439A974
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFCRqG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 13:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231163AbhFCRqF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 13:46:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93FDB613AA;
        Thu,  3 Jun 2021 17:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622742261;
        bh=+3AAWnxLNAizF5BOAx09ZBqZvfc8P+WJhmWgTzL4FE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtUd5ep1qXu8jxwy1P2RAtM6kdP7Kk//o/1w9wcs1Gg0DlSN7HHW4HkEgx6vZ6uqV
         32TnR18DQm0yZpCk+ibneMqZFwZ+eKWcyUhv9kNmJHW7gckzoxuHmr8mWSC4jjPiRw
         EjI6k96XwrGrwGAnHQGfG5hAPGpN6eIf2RYQHT+0N0oLppB2maFalXynunL264xwhU
         1jhgyYUDgZUcVXbQ8NRvoJJ4mkfnIiR+lmowcWf49RJfhDYjWJFsfsTst4LM2YiU3K
         EIoEjkF+9rGoftd0XMiSq+wjGjqWVe71EdXGNA+3xDFmy2NOswZh8DyXix9r/A3gGF
         xJqScnyLl+H2g==
Date:   Thu, 3 Jun 2021 18:44:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20210603174413.GC1170@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-3-will@kernel.org>
 <20210603123715.GA48596@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603123715.GA48596@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 01:37:15PM +0100, Mark Rutland wrote:
> On Wed, Jun 02, 2021 at 05:47:02PM +0100, Will Deacon wrote:
> > When confronted with a mixture of CPUs, some of which support 32-bit
> > applications and others which don't, we quite sensibly treat the system
> > as 64-bit only for userspace and prevent execve() of 32-bit binaries.
> > 
> > Unfortunately, some crazy folks have decided to build systems like this
> > with the intention of running 32-bit applications, so relax our
> > sanitisation logic to continue to advertise 32-bit support to userspace
> > on these systems and track the real 32-bit capable cores in a cpumask
> > instead. For now, the default behaviour remains but will be tied to
> > a command-line option in a later patch.
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/cpufeature.h |   8 +-
> >  arch/arm64/kernel/cpufeature.c      | 114 ++++++++++++++++++++++++----
> >  arch/arm64/tools/cpucaps            |   3 +-
> >  3 files changed, 110 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index 338840c00e8e..603bf4160cd6 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -630,9 +630,15 @@ static inline bool cpu_supports_mixed_endian_el0(void)
> >  	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
> >  }
> >  
> > +const struct cpumask *system_32bit_el0_cpumask(void);
> > +DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
> > +
> >  static inline bool system_supports_32bit_el0(void)
> >  {
> > -	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
> > +	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> > +
> > +	return static_branch_unlikely(&arm64_mismatched_32bit_el0) ||
> > +	       id_aa64pfr0_32bit_el0(pfr0);
> >  }
> 
> Note that read_sanitised_ftr_reg() has to do a bsearch() to find the
> arm64_ftr_reg, so this will make system_32bit_el0_cpumask() a fair
> amount more expensive than it needs to be.

I seriously doubt that it matters, but it did come up before and I proposed
a potential solution if it's actually a concern:

https://lore.kernel.org/r/20201202172727.GC29813@willie-the-truck

so if you can show that it's a problem, we can resurrect something like
that.

> Can we follow the pattern we have for arm64_ftr_reg_ctrel0, and have a
> arm64_ftr_reg_id_aa64pfr0_el1 that we can address directly here?

I mean, clearly its possible, but based on what data?

> That said. I reckon this could be much cleaner if we maintained separate
> caps:
> 
> ARM64_ALL_CPUS_HAVE_32BIT_EL0
> ARM64_SOME_CPUS_HAVE_32BIT_EL0
> 
> ... and allow arm64_mismatched_32bit_el0 to be set dependent on
> ARM64_SOME_CPUS_HAVE_32BIT_EL0. With that, this can be simplified to:
> 
> static inline bool system_supports_32bit_el0(void)
> {
> 	return (cpus_have_const_cap(ARM64_ALL_CPUS_HAVE_32BIT_EL0)) ||
> 		static_branch_unlikely(&arm64_mismatched_32bit_el0))

Something similar was discussed in November last year but this falls
apart with late onlining because its not generally possible to tell whether
you've seen all the CPUs or not.

I'm mostly reluctant to make significant changes based on cosmetic
preferences because testing and debugging this with all the system
combinations is really difficult. Do you see a functional issue with what
I have?

> >  static inline bool system_supports_4kb_granule(void)
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index a4db25cd7122..4194a47de62d 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -107,6 +107,24 @@ DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
> >  bool arm64_use_ng_mappings = false;
> >  EXPORT_SYMBOL(arm64_use_ng_mappings);
> >  
> > +/*
> > + * Permit PER_LINUX32 and execve() of 32-bit binaries even if not all CPUs
> > + * support it?
> > + */
> > +static bool __read_mostly allow_mismatched_32bit_el0;
> > +
> > +/*
> > + * Static branch enabled only if allow_mismatched_32bit_el0 is set and we have
> > + * seen at least one CPU capable of 32-bit EL0.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
> > +
> > +/*
> > + * Mask of CPUs supporting 32-bit EL0.
> > + * Only valid if arm64_mismatched_32bit_el0 is enabled.
> > + */
> > +static cpumask_var_t cpu_32bit_el0_mask __cpumask_var_read_mostly;
> > +
> >  /*
> >   * Flag to indicate if we have computed the system wide
> >   * capabilities based on the boot time active CPUs. This
> > @@ -767,7 +785,7 @@ static void __init sort_ftr_regs(void)
> >   * Any bits that are not covered by an arm64_ftr_bits entry are considered
> >   * RES0 for the system-wide value, and must strictly match.
> >   */
> > -static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
> > +static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
> >  {
> >  	u64 val = 0;
> >  	u64 strict_mask = ~0x0ULL;
> > @@ -863,7 +881,7 @@ static void __init init_cpu_hwcaps_indirect_list(void)
> >  
> >  static void __init setup_boot_cpu_capabilities(void);
> >  
> > -static void __init init_32bit_cpu_features(struct cpuinfo_32bit *info)
> > +static void init_32bit_cpu_features(struct cpuinfo_32bit *info)
> >  {
> >  	init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
> >  	init_cpu_ftr_reg(SYS_ID_DFR1_EL1, info->reg_id_dfr1);
> > @@ -979,6 +997,22 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
> >  	WARN_ON(!ftrp->width);
> >  }
> >  
> > +static void update_mismatched_32bit_el0_cpu_features(struct cpuinfo_arm64 *info,
> > +						     struct cpuinfo_arm64 *boot)
> 
> Could we s/update/lazy_init/ here?
> 
> IIUC this caters for the case where CPU0 doesn't have AArch32 but a
> secondary does. That, and the naming looks odd in update_cpu_features()
> when we have:
> 
> 	update_mismatched_32bit_el0_cpu_features(...)
> 	update_32bit_cpu_features(...);

Sure thing, I'll rename this.

> > +{
> > +	static bool boot_cpu_32bit_regs_overridden = false;
> > +
> > +	if (!allow_mismatched_32bit_el0 || boot_cpu_32bit_regs_overridden)
> > +		return;
> > +
> > +	if (id_aa64pfr0_32bit_el0(boot->reg_id_aa64pfr0))
> > +		return;
> > +
> > +	boot->aarch32 = info->aarch32;
> > +	init_32bit_cpu_features(&boot->aarch32);
> > +	boot_cpu_32bit_regs_overridden = true;
> > +}
> 
> Can't we share this with the boot CPU path if we do:
> 
> /*
>  * Initialize the common AArch32 features on the first CPU with AArch32.
>  */
> static void lazy_init_32bit_el0_cpu_features(struct cpuinfo_arm64 *info,
> 					     struct cpuinfo_arm64 *boot)
> {
> 	static bool initialised = false;
> 	if (initialised || !id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
> 		return;
> 	
> 	boot->aarch32 = info->aarch32;
> 	init_32bit_cpu_features(&boot->aarch32);
> 	initiaised = true;
> }
> 
> ... or is the allow_mismatched_32bit_el0 check necessary for late
> hotplug?

Interesting. I think this works, but I'm wary that it results in the
32-bit features of a 64-bit-only boot CPU being populated using the first
32-bit-capable CPU even if we're not running with allow_mismatched_32bit_el0
enabled. That feels like setting ourselves up for future bugs. For example,
compat_has_neon() would unexpectedly return true even though 32-bit execve()
would be forbidden.

> > +static int __init init_32bit_el0_mask(void)
> > +{
> > +	if (!allow_mismatched_32bit_el0)
> > +		return 0;
> > +
> > +	if (!zalloc_cpumask_var(&cpu_32bit_el0_mask, GFP_KERNEL))
> > +		return -ENOMEM;
> > +
> > +	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +				 "arm64/mismatched_32bit_el0:online",
> > +				 enable_mismatched_32bit_el0, NULL);
> > +}
> 
> Shouldn't we clear this on a hot-unplug?

No, the mask is intended to show all of the 32-bit CPUs we've seen, so that
userspace can use it to construct 32-bit-capable affinity masks. Having a
race with hot-unplug doesn't help with that and sched_setaffinity() is quite
happy with offline CPUs in the provided mask.

Additionally, the underlying mask is used to implement task_cpu_possible(),
so if we wanted to remove CPUs then we'd need a separate mask just for
sysfs (which _already_ exposes the online mask separately).

Will
