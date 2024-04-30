Return-Path: <linux-arch+bounces-4067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FA8B758C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 14:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8221F24F1E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2069F13DB90;
	Tue, 30 Apr 2024 12:16:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1A168A9;
	Tue, 30 Apr 2024 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479366; cv=none; b=adqrGyIN1D54owhvTp+TJKIrsCe7kGKiCyNN336z61Z2l8BWCCtVkV2Ex6sSG7NoZkEgwMVW2n7l0EB+DcFwHgfdZ6bggsEJqKQb2gXE2hKxV5it0VLxIEUPjaXn5UNGPK3x1cwl3YOYOgb23WGBPM/fU3a2kz6sNfRBCDxPI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479366; c=relaxed/simple;
	bh=gBZiN4Mf0s2xCDPpRXTW0QpBKbKBVv/CmKr2e8bRBss=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNOCrawEdJodA1xwmATxPOqxOP0+BGekqzexft7dW5Lxps0bI9mtXCjDDv89TWQvhY9zwddEGUjlxcVJ8q3o6ZvpnLWdRjic5OzCH/DN7DmOqUn5bJWuofg1n1c/GD5kgbIfgv5Mb+Ql38jtFh9Z+wJJX0DeC0VnC8Sl0o/WSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTJxs1TQYz6J73T;
	Tue, 30 Apr 2024 20:13:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B3F04140B54;
	Tue, 30 Apr 2024 20:16:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 13:16:00 +0100
Date: Tue, 30 Apr 2024 13:15:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Marc Zyngier <maz@kernel.org>, <linuxarm@huawei.com>,
	<linuxarm@huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 11/16] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <20240430131540.00000930@huawei.com>
In-Reply-To: <20240429101938.000027b2@huawei.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
	<20240426135126.12802-12-Jonathan.Cameron@huawei.com>
	<87il04t7j2.wl-maz@kernel.org>
	<20240426192858.000033d9@huawei.com>
	<87frv5u3p8.wl-maz@kernel.org>
	<20240429101938.000027b2@huawei.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Apr 2024 10:21:31 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Sun, 28 Apr 2024 12:28:03 +0100
> Marc Zyngier <maz@kernel.org> wrote:
> 
> > On Fri, 26 Apr 2024 19:28:58 +0100,
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:  
> > > 
> > > 
> > > I'll not send a formal v9 until early next week, so here is the current state
> > > if you have time to take another look before then.    
> > 
> > Don't bother resending this on my account -- you only sent it on
> > Friday and there hasn't been much response to it yet. There is still a
> > problem (see below), but looks otherwise OK.
> > 
> > [...]
> >   
> > > @@ -2363,11 +2381,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
> > >  				(struct acpi_madt_generic_interrupt *)header;
> > >  	u32 reg = readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
> > >  	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
> > > +	int cpu = get_cpu_for_acpi_id(gicc->uid);    
> > 
> > I already commented that get_cpu_for_acpi_id() can...  
> 
> Indeed sorry - I blame Friday syndrome for me failing to address that.
> 
> >   
> > >  	void __iomem *redist_base;
> > >  
> > > -	if (!acpi_gicc_is_usable(gicc))
> > > +	/* Neither enabled or online capable means it doesn't exist, skip it */
> > > +	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
> > >  		return 0;
> > >  
> > > +	/*
> > > +	 * Capable but disabled CPUs can be brought online later. What about
> > > +	 * the redistributor? ACPI doesn't want to say!
> > > +	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
> > > +	 * Otherwise, prevent such CPUs from being brought online.
> > > +	 */
> > > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> > > +		pr_warn("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
> > > +		cpumask_set_cpu(cpu, &broken_rdists);    
> > 
> > ... return -EINVAL, and then be passed to cpumask_set_cpu(), with
> > interesting effects. It shouldn't happen, but I trust anything that
> > comes from firmware tables as much as I trust a campaigning
> > politician's promises. This should really result in the RD being
> > considered unusable, but without affecting any CPU (there is no valid
> > CPU the first place).
> > 
> > Another question is what get_cpu_for acpi_id() returns for a disabled
> > CPU. A valid CPU number? Or -EINVAL?  
> It's a match function that works by iterating over 0 to nr_cpu_ids and
> 
> if (uid == get_acpi_id_for_cpu(cpu))
> 
> So the question become does get_acpi_id_for_cpu() return a valid CPU
> number for a disabled CPU.
> 
> That uses acpi_cpu_get_madt_gicc(cpu)->uid so this all gets a bit circular.
> That looks it up via cpu_madt_gicc[cpu] which after the proposed updated
> patch is set if enabled or online capable.  There are however a few other
> error checks in acpi_map_gic_cpu_interface() that could lead to it
> not being set (MPIDR validity checks). I suspect all of these end up being
> fatal elsewhere which is why this hasn't blown up before.
> 
> If any of those cases are possible we could get a null pointer
> dereference.
> 
> Easy to harden this case via the following (which will leave us with
> -EINVAL.  There are other call sites that might trip over this.
> I'm inclined to harden them as a separate issue though so as not
> to get in the way of this patch set.
> 
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bc9a6656fc0c..a407f9cd549e 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -124,7 +124,8 @@ static inline int get_cpu_for_acpi_id(u32 uid)
>         int cpu;
> 
>         for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -               if (uid == get_acpi_id_for_cpu(cpu))
> +               if (acpi_cpu_get_madt_gicc(cpu) &&
> +                   uid == get_acpi_id_for_cpu(cpu))
>                         return cpu;
> 
>         return -EINVAL;
> 
> I'll spin an additional patch to make that change after testing I haven't
> messed it up.
> 
> At the call site in gic_acpi_parse_madt_gicc() I'm not sure we can do better
> than just skipping setting broken_rdists. I'll also pull the declaration of
> that cpu variable down into this condition so it's more obvious we only
> care about it in this error path.

Just for the record, for my deliberately broken test case it seems that it returns
a valid CPU ID anyway. That's what I'd expect given acpi_parse_and_init_cpus()
doesn't check if the gicc entrees are enabled or not.

Jonathan

> 
> Jonathan
> 
> 
> 
> 
> 
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


