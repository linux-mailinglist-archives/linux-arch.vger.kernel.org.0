Return-Path: <linux-arch+bounces-3958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D28C8B2477
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 17:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02641C210FF
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE9E14A4F9;
	Thu, 25 Apr 2024 15:00:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78E1494BC;
	Thu, 25 Apr 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057228; cv=none; b=iUe0G5u4yM6kkt80L2mZUZhF5/1cn9/087qkXfXySYmmyBGO+FsDJ9LxqTPGbof0x6i11D/k4Ss1/ia89AniK2bx9Vem4/ft0aGqUXShBGqe3qb3r9yFCDqnoAf4Dnrh1kcJfDK1fLy5BOdn8rFJzcCZyK8vm2oF4/1XxwBZJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057228; c=relaxed/simple;
	bh=HvN8k9aDJPOql2/EPOWvZFEF30jxyxQy9xYUGmACbj4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYZWjEQlvKj+aGQIc+6GELaKzm9lL3wyIbj6z5r+c8tjSoQ6vs4EBysZgAMfFF3IalRa8fnviVH0nP2AWQzdpysVJY2cHk64f8K+a1nGER61NYJrYUYjnbHPFiViyGrQ3Wb2jwT92U3w/rC8FjVDEi8Psmkr7NfvqcYJB5btanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQJtd31g7z6DBbS;
	Thu, 25 Apr 2024 23:00:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 917A4140736;
	Thu, 25 Apr 2024 23:00:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 16:00:18 +0100
Date: Thu, 25 Apr 2024 16:00:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
Message-ID: <20240425155726.000063f7@huawei.com>
In-Reply-To: <20240425133150.000009fa@Huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>
	<87plugthim.wl-maz@kernel.org>
	<20240424135438.00001ffc@huawei.com>
	<86il06rd19.wl-maz@kernel.org>
	<20240425133150.000009fa@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Apr 2024 13:31:50 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 24 Apr 2024 16:33:22 +0100
> Marc Zyngier <maz@kernel.org> wrote:
> 
> > On Wed, 24 Apr 2024 13:54:38 +0100,
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:  
> > > 
> > > On Tue, 23 Apr 2024 13:01:21 +0100
> > > Marc Zyngier <maz@kernel.org> wrote:
> > >     
> > > > On Mon, 22 Apr 2024 11:40:20 +0100,
> > > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:    
> > > > > 
> > > > > On Thu, 18 Apr 2024 14:54:07 +0100
> > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:    
> > 
> > [...]
> >   
> > > > >       
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
> > 
> > There is no shortage of broken firmware out there, and I expect this
> > trend to progress.
> >   
> > > Not much happens between the point where these are setup and
> > > the point where the the gic inits and this code runs, but even if careful
> > > review showed it was fine today, it will be fragile to future changes.
> > > 
> > > I'm not sure there is a huge disadvantage for such broken firmware in
> > > clearing these masks from the point of view of what is used throughout
> > > the rest of the kernel. Here I think we are just looking to prevent the CPU
> > > being onlined later.    
> > 
> > I totally agree on the goal, I simply question the way you get to it.
> >   
> > > 
> > > We could add a set_cpu_broken() with appropriate mask.
> > > Given this is very arm64 specific I'm not sure Rafael will be keen on
> > > us checking such a mask in the generic ACPI code, but we could check it in
> > > arch_register_cpu() and just not register the cpu if it matches.
> > > That will cover the vCPU hotplug case.
> > >
> > > Does that sounds sensible, or would you prefer something else?    
> > 
> > 
> > Such a 'broken_rdists' mask is exactly what I have in mind, just
> > keeping it private to the GIC driver, and not expose it anywhere else.
> > You can then fail the hotplug event early, and avoid changing the
> > global masks from within the GIC driver. At least, we don't mess with
> > the internals of the kernel, and the CPU is properly marked as dead
> > (that mechanism should already work).
> > 
> > I'd expect the handling side to look like this (will not compile, but
> > you'll get the idea):  
> Hi Marc,
> 
> In general this looks good - but...
> 
> I haven't gotten to the bottom of why yet (and it might be a side
> effect of how I hacked the test by lying in minimal fashion and
> just frigging the MADT read functions) but the hotplug flow is only getting
> as far as calling __cpu_up() before it seems to enter an infinite loop.
> That is it never gets far enough to fail this test.
> 
> Getting stuck in a psci cpu_on call.  I'm guessing something that
> we didn't get to in the earlier gicv3 calls before bailing out is blocking that?
> Looks like it gets to
> SMCCC smc
> and is never seen again.
> 
> Any ideas on where to look?  The one advantage so far of the higher level
> approach is we never tried the hotplug callbacks at all so avoided hitting
> that call.  One (little bit horrible) solution that might avoid this would 
> be to add another cpuhp state very early on and fail at that stage.
> I'm not keen on doing that without a better explanation than I have so far!

Whilst it still doesn't work I suspect I'm loosing ability to print to the console
between that point and somewhat later and real problem is elsewhere.

Jonathan

> 
> Thanks,
> 
> J
> 
>  
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 6fb276504bcc..e8f02bfd0e21 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -1009,6 +1009,9 @@ static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
> >  	u64 typer;
> >  	u32 aff;
> >  
> > +	if (cpumask_test_cpu(smp_processor_id(), &broken_rdists))
> > +		return 1;
> > +
> >  	/*
> >  	 * Convert affinity to a 32bit value that can be matched to
> >  	 * GICR_TYPER bits [63:32].
> > @@ -1260,14 +1263,15 @@ static int gic_dist_supports_lpis(void)
> >  		!gicv3_nolpi);
> >  }
> >  
> > -static void gic_cpu_init(void)
> > +static int gic_cpu_init(void)
> >  {
> >  	void __iomem *rbase;
> > -	int i;
> > +	int ret, i;
> >  
> >  	/* Register ourselves with the rest of the world */
> > -	if (gic_populate_rdist())
> > -		return;
> > +	ret = gic_populate_rdist();
> > +	if (ret)
> > +		return ret;
> >  
> >  	gic_enable_redist(true);
> >  
> > @@ -1286,6 +1290,8 @@ static void gic_cpu_init(void)
> >  
> >  	/* initialise system registers */
> >  	gic_cpu_sys_reg_init();
> > +
> > +	return 0;
> >  }
> >  
> >  #ifdef CONFIG_SMP
> > @@ -1295,7 +1301,11 @@ static void gic_cpu_init(void)
> >  
> >  static int gic_starting_cpu(unsigned int cpu)
> >  {
> > -	gic_cpu_init();
> > +	int ret;
> > +
> > +	ret = gic_cpu_init();
> > +	if (ret)
> > +		return ret;
> >  
> >  	if (gic_dist_supports_lpis())
> >  		its_cpu_init();
> > 
> > But the question is: do you rely on these masks having been
> > "corrected" anywhere else?
> > 
> > Thanks,
> > 
> > 	M.
> >   
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


