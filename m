Return-Path: <linux-arch+bounces-3993-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B25C8B3759
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 14:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4145FB215AC
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B8145B0C;
	Fri, 26 Apr 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhInhu73"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC171E52A;
	Fri, 26 Apr 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135292; cv=none; b=ptditzuVsph4EcSGNxPeRCtMaehWLWOM0nGBG+c89jhZLok631YhjJZsQIoWICo2mDsBouLBj7SlRku4XuNVqm9jM9kHsbMp/jK2UjEzFNtPYxiPjJAhzE4Z5hZeDiHmN1L/EpALIk8rvKBnbhFRORvFOz6csK5ipxffFQorUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135292; c=relaxed/simple;
	bh=st9N10ArNUyvvV0O3ITMWIsRRo6eZ2Ebw9/XgVcbw0s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVz6mIsr5RknmejyLYItEgywEN4SPsAl5FJtz+VIpbRoQn1AyapCRnrZUR+kiOdXEgSivAdCjGJkBGo+we28eG48eU0vu10/QmRK21kg2m0qzwkKyEw3pWYM1fM4h+nyBompEujojIa02JO+xHif8wDiM8THlddMhO/8sr6IXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhInhu73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E7C113CD;
	Fri, 26 Apr 2024 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714135291;
	bh=st9N10ArNUyvvV0O3ITMWIsRRo6eZ2Ebw9/XgVcbw0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhInhu73+ejrsJQp7XW+TlWHiMfsPF9kDo/EibrlYTgEzK8TMbXBv6CeuCa5LxVXq
	 PVqPQwuloEel+Isr+bhThUF4SmUs9Fn25FkAiESPt17ervqrh0S/dUDRRWWQlV/by9
	 nUTr94h0OYz1bgnzhrDD/SufHJIxw9vT68YGCSfSAhz9HNFGR74uJUL2+F/raEZG9C
	 LAP4IbiD2z5Kqq0CRxOhWYAhg/ysrzLrVT3N/0GWozDR3tnqmGrbDGDduDjY6S4uVG
	 Y90lnGMNgYMYAtENSOHFBBjSi/lAIfpMPfj4331iav/zEl8giMzudkZgPVBvnLnGvg
	 0QMiJ7Mk4oB+Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1s0KtM-008DZj-AC;
	Fri, 26 Apr 2024 13:41:28 +0100
Date: Fri, 26 Apr 2024 13:41:27 +0100
Message-ID: <86bk5wqoso.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <linuxarm@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
	Ingo Molnar
	<mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen
	<dave.hansen@linux.intel.com>,
	<justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs
In-Reply-To: <20240425175502.00007def@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>
	<87plugthim.wl-maz@kernel.org>
	<20240424135438.00001ffc@huawei.com>
	<86il06rd19.wl-maz@kernel.org>
	<20240425133150.000009fa@Huawei.com>
	<20240425155726.000063f7@huawei.com>
	<20240425175502.00007def@huawei.com>
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
X-SA-Exim-Rcpt-To: Jonathan.Cameron@Huawei.com, linuxarm@huawei.com, tglx@linutronix.de, peterz@infradead.org, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, linux@armlinux.org.uk, rafael@kernel.org, miguel.luis@oracle.com, james.morse@arm.com, salil.mehta@huawei.com, jean-philippe@linaro.org, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, justin.he@arm.com, jianyong.wu@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 25 Apr 2024 17:55:27 +0100,
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> On Thu, 25 Apr 2024 16:00:17 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Thu, 25 Apr 2024 13:31:50 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Wed, 24 Apr 2024 16:33:22 +0100
> > > Marc Zyngier <maz@kernel.org> wrote:

[...]

> > >   
> > > > I'd expect the handling side to look like this (will not compile, but
> > > > you'll get the idea):    
> > > Hi Marc,
> > > 
> > > In general this looks good - but...
> > > 
> > > I haven't gotten to the bottom of why yet (and it might be a side
> > > effect of how I hacked the test by lying in minimal fashion and
> > > just frigging the MADT read functions) but the hotplug flow is only getting
> > > as far as calling __cpu_up() before it seems to enter an infinite loop.
> > > That is it never gets far enough to fail this test.
> > > 
> > > Getting stuck in a psci cpu_on call.  I'm guessing something that
> > > we didn't get to in the earlier gicv3 calls before bailing out is blocking that?
> > > Looks like it gets to
> > > SMCCC smc
> > > and is never seen again.
> > > 
> > > Any ideas on where to look?  The one advantage so far of the higher level
> > > approach is we never tried the hotplug callbacks at all so avoided hitting
> > > that call.  One (little bit horrible) solution that might avoid this would 
> > > be to add another cpuhp state very early on and fail at that stage.
> > > I'm not keen on doing that without a better explanation than I have so far!  
> > 
> > Whilst it still doesn't work I suspect I'm loosing ability to print to the console
> > between that point and somewhat later and real problem is
> > elsewhere.

Sorry, travelling at the moment, so only spotted this now.

> 
> Hi again,
> 
> Found it I think.  cpuhp calls between cpu:bringup and ap:online 
> arm made from notify_cpu_starting() are clearly marked as nofail with a comment.
> STARTING must not fail!
> 
> https://elixir.bootlin.com/linux/latest/source/kernel/cpu.c#L1642

Ah, now that rings a bell! ;-)

> 
> Whilst I have no immediate idea why that comment is there it is pretty strong
> argument against trying to have the CPUHP_AP_IRQ_GIC_STARTING callback fail
> and expecting it to carry on working :( 
> There would have been a nice print message, but given I don't appear to have
> a working console after that stage I never see it.
> 
> So the best I have yet come up with for this is the option of a new callback registered
> in gic_smp_init()
> 
> cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
> 			  "irqchip/arm/gicv3:checkrdist",
> 			  gic_broken_rdist, NULL);
> 
> with callback being simply 
> 
> static int gic_broken_rdist(unsigned int cpu)
> {
> 	if (cpumask_test_cpu(cpu, &broken_rdists))
> 		return -EINVAL;
> 
> 	return 0;
> }
> 
> That gets called cpuhp_up_callbacks() and is allows to fail and roll back the steps.
> 
> Not particularly satisfying but keeps the logic confined to the gicv3 driver.
> 
> What do you think?

Good enough for me. Cc me on the resulting patch when you repost it so
that I can eyeball it, but this is IMO the right direction.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

