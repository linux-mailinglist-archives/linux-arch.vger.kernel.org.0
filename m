Return-Path: <linux-arch+bounces-3924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C302D8B0A2C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36ECB27FB1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB415B574;
	Wed, 24 Apr 2024 12:54:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD6415B140;
	Wed, 24 Apr 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963285; cv=none; b=nxHNE+MBCVxHYkS58KjvkjpILnWazKDt9G6zU1wzJMYgGkNy7U6zzWLtVmkABTdhFtDrD2V8K8asdCM3IKGqQyS39/TGQyIRvORioCI2nsAP1wztAxb9flwQG7+PQQBELniOBcvooZhwqHI28opCNSDDtBSzTpjT1MhLTeiUtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963285; c=relaxed/simple;
	bh=ZttWvlAuKeGR5g1PWeJ85Q2jl8Nk6BYcwEybR7S22zc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev3i4dp3BtK1zAh/eTT4vzj4dQ6Amjky4jly+GxOpAnglqz1NMsAj0nS5BYSd78Q6fKgcf2p2cIr1IaDJ/Lq0Wi2fwOG5fvpXNj7osO+CIh1PpkUI7d8SDXnSslxIP64Qae2HgGtv/ZUU/geem3h9nkijG+IkFmEK7eSX4o449g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VPf5c4WC0z6D8cL;
	Wed, 24 Apr 2024 20:52:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DE891404F5;
	Wed, 24 Apr 2024 20:54:40 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 13:54:39 +0100
Date: Wed, 24 Apr 2024 13:54:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linuxarm@huawei.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <20240424135438.00001ffc@huawei.com>
In-Reply-To: <87plugthim.wl-maz@kernel.org>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>
	<87plugthim.wl-maz@kernel.org>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Apr 2024 13:01:21 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Mon, 22 Apr 2024 11:40:20 +0100,
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > On Thu, 18 Apr 2024 14:54:07 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > From: James Morse <james.morse@arm.com>
> > > 
> > > To support virtual CPU hotplug, ACPI has added an 'online capable' bit
> > > to the MADT GICC entries. This indicates a disabled CPU entry may not
> > > be possible to online via PSCI until firmware has set enabled bit in
> > > _STA.
> > > 
> > > This means that a "usable" GIC is one that is marked as either enabled,
> > > or online capable. Therefore, change acpi_gicc_is_usable() to check both
> > > bits. However, we need to change the test in gic_acpi_match_gicc() back
> > > to testing just the enabled bit so the count of enabled distributors is
> > > correct.
> > > 
> > > What about the redistributor in the GICC entry? ACPI doesn't want to say.
> > > Assume the worst: When a redistributor is described in the GICC entry,
> > > but the entry is marked as disabled at boot, assume the redistributor
> > > is inaccessible.
> > > 
> > > The GICv3 driver doesn't support late online of redistributors, so this
> > > means the corresponding CPU can't be brought online either. Clear the
> > > possible and present bits.
> > > 
> > > Systems that want CPU hotplug in a VM can ensure their redistributors
> > > are always-on, and describe them that way with a GICR entry in the MADT.
> > > 
> > > When mapping redistributors found via GICC entries, handle the case
> > > where the arch code believes the CPU is present and possible, but it
> > > does not have an accessible redistributor. Print a warning and clear
> > > the present and possible bits.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > +CC Marc,
> > 
> > Whilst this has been unchanged for a long time, I'm not 100% sure
> > we've specifically drawn your attention to it before now.
> > 
> > Jonathan
> >   
> > > 
> > > ---
> > > v7: No Change.
> > > ---
> > >  drivers/irqchip/irq-gic-v3.c | 21 +++++++++++++++++++--
> > >  include/linux/acpi.h         |  3 ++-
> > >  2 files changed, 21 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > > index 10af15f93d4d..66132251c1bb 100644
> > > --- a/drivers/irqchip/irq-gic-v3.c
> > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > @@ -2363,11 +2363,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
> > >  				(struct acpi_madt_generic_interrupt *)header;
> > >  	u32 reg = readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
> > >  	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
> > > +	int cpu = get_cpu_for_acpi_id(gicc->uid);
> > >  	void __iomem *redist_base;
> > >  
> > >  	if (!acpi_gicc_is_usable(gicc))
> > >  		return 0;
> > >  
> > > +	/*
> > > +	 * Capable but disabled CPUs can be brought online later. What about
> > > +	 * the redistributor? ACPI doesn't want to say!
> > > +	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
> > > +	 * Otherwise, prevent such CPUs from being brought online.
> > > +	 */
> > > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> > > +		pr_warn_once("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
> > > +		set_cpu_present(cpu, false);
> > > +		set_cpu_possible(cpu, false);
> > > +		return 0;
> > > +	}  
> 
> It seems dangerous to clear those this late in the game, given how
> disconnected from the architecture code this is. Are we sure that
> nothing has sampled these cpumasks beforehand?

Hi Marc,

Any firmware that does this is being considered as buggy already
but given it is firmware and the spec doesn't say much about this,
there is always the possibility.

Not much happens between the point where these are setup and
the point where the the gic inits and this code runs, but even if careful
review showed it was fine today, it will be fragile to future changes.

I'm not sure there is a huge disadvantage for such broken firmware in
clearing these masks from the point of view of what is used throughout
the rest of the kernel. Here I think we are just looking to prevent the CPU
being onlined later.

We could add a set_cpu_broken() with appropriate mask.
Given this is very arm64 specific I'm not sure Rafael will be keen on
us checking such a mask in the generic ACPI code, but we could check it in
arch_register_cpu() and just not register the cpu if it matches.
That will cover the vCPU hotplug case.

Does that sounds sensible, or would you prefer something else?

Jonathan







> 
> Thanks,
> 
> 	M.
> 


