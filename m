Return-Path: <linux-arch+bounces-3925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06988B0E77
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 17:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551DB1F293D3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48816130A;
	Wed, 24 Apr 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjojJ9tv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998B15EFDB;
	Wed, 24 Apr 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972806; cv=none; b=jGtHUk3DDJ0GlVrrSpOQLtTnOQOSNMZHOgvJ9uveDnCem09gJrrl91d5+bDOC/mSuleGXLvB5ozn0PJWJsh76vKZv+R93n2ddOKgvLZsfkKaQ5yjVFDlpYfDIvQm7CbGCIlawDDy8ycatLP5+tPuxBBgETL4NiZTc2ehvKQjpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972806; c=relaxed/simple;
	bh=eKJo5gG7zxObnBLQvdDtMfVRz5h7TuiTzRdbx1XUkHM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9mRk/gFAVqM9CFlAzgQ0yNpDzhvOtIiPi6q7CC9scVTAP9Nf52MKsRcHH59mI3/16QH5LCOwwZQEGdjvK6Dj1oGPf2/jcPk6Fb2X+lASUZS+zQoLfXL+q0IF4ERK/Rth0gYyYlT7LVPfuWs+DxwVnrFE0zTSJHMTo2rskdVuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjojJ9tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AC3C113CD;
	Wed, 24 Apr 2024 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972806;
	bh=eKJo5gG7zxObnBLQvdDtMfVRz5h7TuiTzRdbx1XUkHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AjojJ9tvZTHPOZR/m5u54kBnZ+v5gQoVRJnWRZb383Sp68Ye0+yfUFbFEmXumbr5M
	 fU0B/yxWBm19YdtzwC5IAPD/LDrg3L7acdSS1QHmkF88ezMp4Cx1G007yY6CiUgS7+
	 5qsWL2aYC1ehU1F3B12rZr+6awrFfyBSKJq++mg0YfXyrRRqS/d6R5FIgumS7w+T3i
	 Wbg1yvs31EHYu3O2+FVP+9MhGxgi1l1CcsXkFotK9esfkKMe9wm/LKYaFYdDp9LDwX
	 tOIIXPg6SyBNza2a5Z3gBjzNM00AJMrILFoS/KCwbC9ldyfTmKZQCyNGSNxRTvq1nH
	 mQRYlqDADNIxw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rzecd-007acO-2E;
	Wed, 24 Apr 2024 16:33:23 +0100
Date: Wed, 24 Apr 2024 16:33:22 +0100
Message-ID: <86il06rd19.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
	Borislav Petkov
	<bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	<justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs
In-Reply-To: <20240424135438.00001ffc@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>
	<87plugthim.wl-maz@kernel.org>
	<20240424135438.00001ffc@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: Jonathan.Cameron@huawei.com, tglx@linutronix.de, peterz@infradead.org, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, linux@armlinux.org.uk, rafael@kernel.org, miguel.luis@oracle.com, james.morse@arm.com, salil.mehta@huawei.com, jean-philippe@linaro.org, catalin.marinas@arm.com, will@kernel.org, linuxarm@huawei.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, justin.he@arm.com, jianyong.wu@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 24 Apr 2024 13:54:38 +0100,
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> On Tue, 23 Apr 2024 13:01:21 +0100
> Marc Zyngier <maz@kernel.org> wrote:
> 
> > On Mon, 22 Apr 2024 11:40:20 +0100,
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > 
> > > On Thu, 18 Apr 2024 14:54:07 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

[...]

> > >   
> > > > +	/*
> > > > +	 * Capable but disabled CPUs can be brought online later. What about
> > > > +	 * the redistributor? ACPI doesn't want to say!
> > > > +	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
> > > > +	 * Otherwise, prevent such CPUs from being brought online.
> > > > +	 */
> > > > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> > > > +		pr_warn_once("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
> > > > +		set_cpu_present(cpu, false);
> > > > +		set_cpu_possible(cpu, false);
> > > > +		return 0;
> > > > +	}  
> > 
> > It seems dangerous to clear those this late in the game, given how
> > disconnected from the architecture code this is. Are we sure that
> > nothing has sampled these cpumasks beforehand?
> 
> Hi Marc,
> 
> Any firmware that does this is being considered as buggy already
> but given it is firmware and the spec doesn't say much about this,
> there is always the possibility.

There is no shortage of broken firmware out there, and I expect this
trend to progress.

> Not much happens between the point where these are setup and
> the point where the the gic inits and this code runs, but even if careful
> review showed it was fine today, it will be fragile to future changes.
> 
> I'm not sure there is a huge disadvantage for such broken firmware in
> clearing these masks from the point of view of what is used throughout
> the rest of the kernel. Here I think we are just looking to prevent the CPU
> being onlined later.

I totally agree on the goal, I simply question the way you get to it.

> 
> We could add a set_cpu_broken() with appropriate mask.
> Given this is very arm64 specific I'm not sure Rafael will be keen on
> us checking such a mask in the generic ACPI code, but we could check it in
> arch_register_cpu() and just not register the cpu if it matches.
> That will cover the vCPU hotplug case.
>
> Does that sounds sensible, or would you prefer something else?


Such a 'broken_rdists' mask is exactly what I have in mind, just
keeping it private to the GIC driver, and not expose it anywhere else.
You can then fail the hotplug event early, and avoid changing the
global masks from within the GIC driver. At least, we don't mess with
the internals of the kernel, and the CPU is properly marked as dead
(that mechanism should already work).

I'd expect the handling side to look like this (will not compile, but
you'll get the idea):

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc..e8f02bfd0e21 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1009,6 +1009,9 @@ static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
 	u64 typer;
 	u32 aff;
 
+	if (cpumask_test_cpu(smp_processor_id(), &broken_rdists))
+		return 1;
+
 	/*
 	 * Convert affinity to a 32bit value that can be matched to
 	 * GICR_TYPER bits [63:32].
@@ -1260,14 +1263,15 @@ static int gic_dist_supports_lpis(void)
 		!gicv3_nolpi);
 }
 
-static void gic_cpu_init(void)
+static int gic_cpu_init(void)
 {
 	void __iomem *rbase;
-	int i;
+	int ret, i;
 
 	/* Register ourselves with the rest of the world */
-	if (gic_populate_rdist())
-		return;
+	ret = gic_populate_rdist();
+	if (ret)
+		return ret;
 
 	gic_enable_redist(true);
 
@@ -1286,6 +1290,8 @@ static void gic_cpu_init(void)
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
+
+	return 0;
 }
 
 #ifdef CONFIG_SMP
@@ -1295,7 +1301,11 @@ static void gic_cpu_init(void)
 
 static int gic_starting_cpu(unsigned int cpu)
 {
-	gic_cpu_init();
+	int ret;
+
+	ret = gic_cpu_init();
+	if (ret)
+		return ret;
 
 	if (gic_dist_supports_lpis())
 		its_cpu_init();

But the question is: do you rely on these masks having been
"corrected" anywhere else?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

