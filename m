Return-Path: <linux-arch+bounces-3915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5095B8AE57C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CBF1C22F28
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E2131BC8;
	Tue, 23 Apr 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug+r3g67"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D684FB9;
	Tue, 23 Apr 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873692; cv=none; b=cz9KWm8SUh6a//Np9JoBumY8NCuRA/dq9OZ2NsDyusZ2ORgSs2H18UGRNr0GDWlCZ870lIbqrZRYFokBpruqTRbIaj4EzJ9R0mk6Yf1r1XUqD1ByUPDu0UiSyaPiu0MoggrXahX0GfR8fzxPaknkqT1lfi+7gAxutPE3TVXAG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873692; c=relaxed/simple;
	bh=DDAVN6UUdbMZmiRDg1+v0ARBePCm07Nc9Am7Qi6YmbI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Igk43dVezO6KThqRA3Px27hwNZavJfS6/C4vILlS+ILB5cMjhXFaen51L7B3R6m2iBTcdnZRU1yiblk9+RRcbHB+A0WvF4cXT6L6zBnew4LrHTR5eQuFtWBumnY/F82CdEw4LJMRgo8a3UV2K6SiAtId36pxt4WNVdiJXS4Klbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug+r3g67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BFCC116B1;
	Tue, 23 Apr 2024 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713873691;
	bh=DDAVN6UUdbMZmiRDg1+v0ARBePCm07Nc9Am7Qi6YmbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ug+r3g67sxsNaAlfzqqcRAxtn4LeOufWDtv96Fw18y8rKb19cz5iK7HbuFxrDKbIL
	 AT5cOJ+nFHfwl9Qc42GlCM6f54kcbeFOhLiLXdjOu3FeyqiGHEuRWItweAMmfryjiD
	 Cj3GnwEu8ZO8HzK8AmouONW+R2PLswDGx6ghqPkpHWDVdl9bDXIW9ULlTctR9h/FAz
	 UFmJM0z6rQAJ1197NZaSlHAwfpZ7iHduUSCKQvCEyk+TOk//ITdX9CpAh/Dy/1zzst
	 hQmkBU4QGPSCymKDiMkOkRNZTDHTLbn2I1c67agLr7y5l38i3n213dFVo7zOE+1+1l
	 cAVFvYd/qizzg==
Received: from [12.161.88.66] (helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rzEq1-007AX6-0Y;
	Tue, 23 Apr 2024 13:01:29 +0100
Date: Tue, 23 Apr 2024 13:01:21 +0100
Message-ID: <87plugthim.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra
	<peterz@infradead.org>,
	<linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>,
	<x86@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"Rafael J . Wysocki"
	<rafael@kernel.org>,
	Miguel Luis <miguel.luis@oracle.com>,
	"James Morse"
	<james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe
 Brucker <jean-philippe@linaro.org>,
	Catalin Marinas
	<catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	<linuxarm@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Dave\
 Hansen" <dave.hansen@linux.intel.com>,
	<justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs
In-Reply-To: <20240422114020.0000294f@Huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 12.161.88.66
X-SA-Exim-Rcpt-To: Jonathan.Cameron@Huawei.com, tglx@linutronix.de, peterz@infradead.org, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, linux@armlinux.org.uk, rafael@kernel.org, miguel.luis@oracle.com, james.morse@arm.com, salil.mehta@huawei.com, jean-philippe@linaro.org, catalin.marinas@arm.com, will@kernel.org, linuxarm@huawei.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, justin.he@arm.com, jianyong.wu@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 22 Apr 2024 11:40:20 +0100,
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> On Thu, 18 Apr 2024 14:54:07 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > From: James Morse <james.morse@arm.com>
> > 
> > To support virtual CPU hotplug, ACPI has added an 'online capable' bit
> > to the MADT GICC entries. This indicates a disabled CPU entry may not
> > be possible to online via PSCI until firmware has set enabled bit in
> > _STA.
> > 
> > This means that a "usable" GIC is one that is marked as either enabled,
> > or online capable. Therefore, change acpi_gicc_is_usable() to check both
> > bits. However, we need to change the test in gic_acpi_match_gicc() back
> > to testing just the enabled bit so the count of enabled distributors is
> > correct.
> > 
> > What about the redistributor in the GICC entry? ACPI doesn't want to say.
> > Assume the worst: When a redistributor is described in the GICC entry,
> > but the entry is marked as disabled at boot, assume the redistributor
> > is inaccessible.
> > 
> > The GICv3 driver doesn't support late online of redistributors, so this
> > means the corresponding CPU can't be brought online either. Clear the
> > possible and present bits.
> > 
> > Systems that want CPU hotplug in a VM can ensure their redistributors
> > are always-on, and describe them that way with a GICR entry in the MADT.
> > 
> > When mapping redistributors found via GICC entries, handle the case
> > where the arch code believes the CPU is present and possible, but it
> > does not have an accessible redistributor. Print a warning and clear
> > the present and possible bits.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> +CC Marc,
> 
> Whilst this has been unchanged for a long time, I'm not 100% sure
> we've specifically drawn your attention to it before now.
> 
> Jonathan
> 
> > 
> > ---
> > v7: No Change.
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 21 +++++++++++++++++++--
> >  include/linux/acpi.h         |  3 ++-
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 10af15f93d4d..66132251c1bb 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -2363,11 +2363,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
> >  				(struct acpi_madt_generic_interrupt *)header;
> >  	u32 reg = readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
> >  	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
> > +	int cpu = get_cpu_for_acpi_id(gicc->uid);
> >  	void __iomem *redist_base;
> >  
> >  	if (!acpi_gicc_is_usable(gicc))
> >  		return 0;
> >  
> > +	/*
> > +	 * Capable but disabled CPUs can be brought online later. What about
> > +	 * the redistributor? ACPI doesn't want to say!
> > +	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
> > +	 * Otherwise, prevent such CPUs from being brought online.
> > +	 */
> > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> > +		pr_warn_once("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
> > +		set_cpu_present(cpu, false);
> > +		set_cpu_possible(cpu, false);
> > +		return 0;
> > +	}

It seems dangerous to clear those this late in the game, given how
disconnected from the architecture code this is. Are we sure that
nothing has sampled these cpumasks beforehand?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

