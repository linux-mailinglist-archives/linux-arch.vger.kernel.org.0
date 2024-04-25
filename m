Return-Path: <linux-arch+bounces-3953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE98B1EDD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 12:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4CE2890CF
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 10:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BC38595B;
	Thu, 25 Apr 2024 10:13:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725D2E647;
	Thu, 25 Apr 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040003; cv=none; b=OrCRfMJ/2MIcrOGiOsd142eX3ekXsvAMUQyZR3A1iHC5eMynPim5QduVff9YPh5CPu5Z2HPeLYdnJTGx55gcCJkkjUWyOps3xuKl9QqxGIoAEOgcJfOMdgDCu2y5uIHXV6pSvBpKnxz4Nj1mKaiJCQdYBZeDJOgAwMvVBAqEhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040003; c=relaxed/simple;
	bh=U+b8fa7W192UqFK+Q+qJIol6Ba04zHnJqB/lQJ6Cp9g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2NxY0Sk6/J3HPL+OT8rlXHJigmpqDtWxBw1xbt3bnS39iGXTK9I7wy0f0hySYcdYFPtZcq6W1KxwzXZ+8njSfPRr1eAR4LucM0SP1ast0+QR0xYgAqO6p6AfsCxaRYqQxZ8eCEVzaqXmtV3Vl4bH2griItZ6BwLDq/SgGg0Uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQBSt5g3Fz6JB3D;
	Thu, 25 Apr 2024 18:10:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C26F3140736;
	Thu, 25 Apr 2024 18:13:16 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 11:13:15 +0100
Date: Thu, 25 Apr 2024 11:13:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>, <linuxarm@huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <20240425111315.00002948@huawei.com>
In-Reply-To: <20240425105637.000030a7@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>
	<87plugthim.wl-maz@kernel.org>
	<20240424135438.00001ffc@huawei.com>
	<20240425102806.00003683@Huawei.com>
	<20240425105637.000030a7@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Apr 2024 10:56:37 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 25 Apr 2024 10:28:06 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 24 Apr 2024 13:54:38 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > On Tue, 23 Apr 2024 13:01:21 +0100
> > > Marc Zyngier <maz@kernel.org> wrote:
> > >     
> > > > On Mon, 22 Apr 2024 11:40:20 +0100,
> > > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:      
> > > > > 
> > > > > On Thu, 18 Apr 2024 14:54:07 +0100
> > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > > >         
> > > > > > From: James Morse <james.morse@arm.com>
> > > > > > 
> > > > > > To support virtual CPU hotplug, ACPI has added an 'online capable' bit
> > > > > > to the MADT GICC entries. This indicates a disabled CPU entry may not
> > > > > > be possible to online via PSCI until firmware has set enabled bit in
> > > > > > _STA.
> > > > > > 
> > > > > > This means that a "usable" GIC is one that is marked as either enabled,
> > > > > > or online capable. Therefore, change acpi_gicc_is_usable() to check both
> > > > > > bits. However, we need to change the test in gic_acpi_match_gicc() back
> > > > > > to testing just the enabled bit so the count of enabled distributors is
> > > > > > correct.
> > > > > > 
> > > > > > What about the redistributor in the GICC entry? ACPI doesn't want to say.
> > > > > > Assume the worst: When a redistributor is described in the GICC entry,
> > > > > > but the entry is marked as disabled at boot, assume the redistributor
> > > > > > is inaccessible.
> > > > > > 
> > > > > > The GICv3 driver doesn't support late online of redistributors, so this
> > > > > > means the corresponding CPU can't be brought online either. Clear the
> > > > > > possible and present bits.
> > > > > > 
> > > > > > Systems that want CPU hotplug in a VM can ensure their redistributors
> > > > > > are always-on, and describe them that way with a GICR entry in the MADT.
> > > > > > 
> > > > > > When mapping redistributors found via GICC entries, handle the case
> > > > > > where the arch code believes the CPU is present and possible, but it
> > > > > > does not have an accessible redistributor. Print a warning and clear
> > > > > > the present and possible bits.
> > > > > > 
> > > > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>        
> > > > > 
> > > > > +CC Marc,
> > > > > 
> > > > > Whilst this has been unchanged for a long time, I'm not 100% sure
> > > > > we've specifically drawn your attention to it before now.
> > > > > 
> > > > > Jonathan
> > > > >         
> > > > > > 
> > > > > > ---
> > > > > > v7: No Change.
> > > > > > ---
> > > > > >  drivers/irqchip/irq-gic-v3.c | 21 +++++++++++++++++++--
> > > > > >  include/linux/acpi.h         |  3 ++-
> > > > > >  2 files changed, 21 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > > > > > index 10af15f93d4d..66132251c1bb 100644
> > > > > > --- a/drivers/irqchip/irq-gic-v3.c
> > > > > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > > > > @@ -2363,11 +2363,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
> > > > > >  				(struct acpi_madt_generic_interrupt *)header;
> > > > > >  	u32 reg = readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
> > > > > >  	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
> > > > > > +	int cpu = get_cpu_for_acpi_id(gicc->uid);
> > > > > >  	void __iomem *redist_base;
> > > > > >  
> > > > > >  	if (!acpi_gicc_is_usable(gicc))
> > > > > >  		return 0;
> > > > > >  
> > > > > > +	/*
> > > > > > +	 * Capable but disabled CPUs can be brought online later. What about
> > > > > > +	 * the redistributor? ACPI doesn't want to say!
> > > > > > +	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
> > > > > > +	 * Otherwise, prevent such CPUs from being brought online.
> > > > > > +	 */
> > > > > > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> > > > > > +		pr_warn_once("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
> > > > > > +		set_cpu_present(cpu, false);
> > > > > > +		set_cpu_possible(cpu, false);
> > > > > > +		return 0;
> > > > > > +	}        
> > > > 
> > > > It seems dangerous to clear those this late in the game, given how
> > > > disconnected from the architecture code this is. Are we sure that
> > > > nothing has sampled these cpumasks beforehand?      
> > > 
> > > Hi Marc,
> > > 
> > > Any firmware that does this is being considered as buggy already
> > > but given it is firmware and the spec doesn't say much about this,
> > > there is always the possibility.
> > > 
> > > Not much happens between the point where these are setup and
> > > the point where the the gic inits and this code runs, but even if careful
> > > review showed it was fine today, it will be fragile to future changes.
> > > 
> > > I'm not sure there is a huge disadvantage for such broken firmware in
> > > clearing these masks from the point of view of what is used throughout
> > > the rest of the kernel. Here I think we are just looking to prevent the CPU
> > > being onlined later.
> > > 
> > > We could add a set_cpu_broken() with appropriate mask.
> > > Given this is very arm64 specific I'm not sure Rafael will be keen on
> > > us checking such a mask in the generic ACPI code, but we could check it in
> > > arch_register_cpu() and just not register the cpu if it matches.
> > > That will cover the vCPU hotplug case.
> > > 
> > > Does that sounds sensible, or would you prefer something else?    
> > 
> > Hi Marc
> > 
> > Some experiments later (faking this on a physical board - I never liked
> > CPU 120 anyway!) and using a different mask brings it's own minor pain.
> > 
> > When all the rest of the CPUs are brought up cpuhp_bringup_mask() is called
> > on cpu_present_mask so we need to do a dance in there to use a temporary
> > mask with broken cpus removed.  I think it makes sense to cut that out
> > at the top of the cpuhp_bringup_mask() pile of actions rather than trying
> > to paper over each actual thing that is dying... (looks like an infinite loop
> > somewhere but I haven't tracked down where yet).
> > 
> > I'll spin a patch so you can see what it looks like, but my concern is
> > we are just moving the risk from early users of these masks to later cases
> > where code assumes cpu_present_mask definitely means they are present.
> > That is probably a small set of cases but not nice either.
> > 
> > Looks like one of those cases where we need to pick the lesser of two evils
> > which is probably still the cpu_broken_mask approach.
> > 
> > On plus side if we decide to go back to the original approach having seen
> > that I already have the code :)
> > 
> > Jonathan
> >   
> 
> Patch on top of this series.  If no one shouts before I have it ready I'll
> roll a v8 with the mask introduction as a new patch and the other changes pushed into
> appropriate patches.
> 
> From 361b76f36bfb4ff74fdceca7ebf14cfa43cae4a9 Mon Sep 17 00:00:00 2001
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Date: Wed, 24 Apr 2024 17:42:49 +0100
> Subject: [PATCH] cpu: Add broken cpu mask to mark CPUs where inconsistent
>  firmware means we can't start them.
> 
> On ARM64, it is not currently possible to use CPUs where the GICC entry
> in ACPI specifies that it is online capable but not enabled. Only
> always enabled entries are supported.
> 
> Previously if this condition was met, the present and possible cpu masks
> were cleared for the relevant cpus.  However, those masks may already
> have been used by other code so this is not known to be safe.
> 
> An alternative is to use an additional mask (broken) and check that
> in the subset of places where these CPUs might be onlined or the
> infrastructure to indicate this is possible created.
> Specifically in bringup_nonboot_cpus() and in arch_register_cpu().
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Obviously I'd missed Marc's reply on keeping this local to gicv3.
Will give that a go.

Sorry for the noise!

Jonathan

> ---
>  arch/arm64/kernel/smp.c      |  3 +++
>  drivers/irqchip/irq-gic-v3.c |  3 +--
>  include/linux/cpumask.h      | 19 +++++++++++++++++++
>  kernel/cpu.c                 |  8 +++++++-
>  4 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index ccb6ad347df9..39cd6a7c40d8 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -513,6 +513,9 @@ int arch_register_cpu(int cpu)
>  	    IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
>  		return -EPROBE_DEFER;
>  
> +	if (cpu_broken(cpu)) /* Inconsistent firmware - can't online */
> +		return -ENODEV;
> +
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  	/* For now block anything that looks like physical CPU Hotplug */
>  	if (invalid_logical_cpuid(cpu) || !cpu_present(cpu)) {
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 66132251c1bb..a0063eb6484d 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2377,8 +2377,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
>  	 */
>  	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
>  		pr_warn_once("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
> -		set_cpu_present(cpu, false);
> -		set_cpu_possible(cpu, false);
> +		set_cpu_broken(cpu);
>  		return 0;
>  	}
>  
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 4b202b94c97a..70a93ad8e590 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -96,6 +96,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
>   *     cpu_enabled_mask  - has bit 'cpu' set iff cpu can be brought online
>   *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
>   *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
> + *     cpu_broken_mask  - has bit 'cpu' set iff the cpu should never be onlined
>   *
>   *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
>   *
> @@ -130,12 +131,14 @@ extern struct cpumask __cpu_enabled_mask;
>  extern struct cpumask __cpu_present_mask;
>  extern struct cpumask __cpu_active_mask;
>  extern struct cpumask __cpu_dying_mask;
> +extern struct cpumask __cpu_broken_mask;
>  #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
>  #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
>  #define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
>  #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
>  #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
>  #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
> +#define cpu_broken_mask   ((const struct cpumask *)&__cpu_broken_mask)
>  
>  extern atomic_t __num_online_cpus;
>  
> @@ -1073,6 +1076,12 @@ set_cpu_dying(unsigned int cpu, bool dying)
>  		cpumask_clear_cpu(cpu, &__cpu_dying_mask);
>  }
>  
> +static inline void
> +set_cpu_broken(unsigned int cpu)
> +{
> +	cpumask_set_cpu(cpu, &__cpu_broken_mask);
> +}
> +
>  /**
>   * to_cpumask - convert a NR_CPUS bitmap to a struct cpumask *
>   * @bitmap: the bitmap
> @@ -1159,6 +1168,11 @@ static inline bool cpu_dying(unsigned int cpu)
>  	return cpumask_test_cpu(cpu, cpu_dying_mask);
>  }
>  
> +static inline bool cpu_broken(unsigned int cpu)
> +{
> +	return cpumask_test_cpu(cpu, cpu_broken_mask);
> +}
> +
>  #else
>  
>  #define num_online_cpus()	1U
> @@ -1197,6 +1211,11 @@ static inline bool cpu_dying(unsigned int cpu)
>  	return false;
>  }
>  
> +static inline bool cpu_broken(unsigned int cpu)
> +{
> +	return false;
> +}
> +
>  #endif /* NR_CPUS > 1 */
>  
>  #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 537099bf5d02..f8b73a11869e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1907,12 +1907,15 @@ static inline bool cpuhp_bringup_cpus_parallel(unsigned int ncpus) { return fals
>  
>  void __init bringup_nonboot_cpus(unsigned int max_cpus)
>  {
> +	static const struct cpumask tmp_mask __initdata;
> +
>  	/* Try parallel bringup optimization if enabled */
>  	if (cpuhp_bringup_cpus_parallel(max_cpus))
>  		return;
>  
> +	cpumask_andnot(&tmp_mask, cpu_present_mask, cpu_broken_mask);
>  	/* Full per CPU serialized bringup */
> -	cpuhp_bringup_mask(cpu_present_mask, max_cpus, CPUHP_ONLINE);
> +	cpuhp_bringup_mask(&tmp_mask, max_cpus, CPUHP_ONLINE);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP_SMP
> @@ -3129,6 +3132,9 @@ EXPORT_SYMBOL(__cpu_active_mask);
>  struct cpumask __cpu_dying_mask __read_mostly;
>  EXPORT_SYMBOL(__cpu_dying_mask);
>  
> +struct cpumask __cpu_broken_mask __ro_after_init;
> +EXPORT_SYMBOL(__cpu_broken_mask);
> +
>  atomic_t __num_online_cpus __read_mostly;
>  EXPORT_SYMBOL(__num_online_cpus);
>  


