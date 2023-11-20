Return-Path: <linux-arch+bounces-283-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F07F0F95
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 10:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067A71C20FC4
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 09:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D02B125BF;
	Mon, 20 Nov 2023 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eAF0KRxg"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB6ECD;
	Mon, 20 Nov 2023 01:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RRH8ihRwgqqNWiOQXVgz2lSe5cF5QqM2TrvGcFPpVxQ=; b=eAF0KRxgbthRFbPQ6izZC3J3oy
	NoICC18OIT3Qs7cMSCHEyKdPJVEqlqYYz46JeVVogCAoBWUhXiyxhy9SzyCivvREMDfvxXZSrMpqk
	BHZ3abqeLK7FySm29lIYiV3szbHsZGZ0MEwL9YBdWcQ/tt0m9Epi+ARclf048DAo9sTRBExtXyU2Y
	OWqc0bZ0sBPg5y7tECdJwrgrcIV0utpcws+XvnYsepZe+SO7zSvE1M0Dc3TnoMMhyx+qLFfvV/gAy
	zBVN1YBhtJaSqBUjieLhtAr5Xh4FKBvt+x6MQT63nLwsYbtpT2WmNNA7nk4PLOb78D4oGUQs88/cg
	AGe8pcpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43368)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r512Z-0005Gn-2Y;
	Mon, 20 Nov 2023 09:58:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r512Z-00034w-8Z; Mon, 20 Nov 2023 09:58:03 +0000
Date: Mon, 20 Nov 2023 09:58:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jianyong Wu <Jianyong.Wu@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Justin He <Justin.He@arm.com>, James Morse <James.Morse@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 34/39] arm64: psci: Ignore DENIED CPUs
Message-ID: <ZVstq+vhQSP73Nua@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <E1qvJBQ-00AqS8-8B@rmk-PC.armlinux.org.uk>
 <DB9PR08MB7511B178CA811C412766FDBAF4B0A@DB9PR08MB7511.eurprd08.prod.outlook.com>
 <ZVsl1ZQ9JRXPf4qH@shell.armlinux.org.uk>
 <DB9PR08MB7511C8825028074748FBB967F4B4A@DB9PR08MB7511.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR08MB7511C8825028074748FBB967F4B4A@DB9PR08MB7511.eurprd08.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 20, 2023 at 09:36:05AM +0000, Jianyong Wu wrote:
> 
> 
> > -----Original Message-----
> > From: Russell King <linux@armlinux.org.uk>
> > Sent: 2023年11月20日 17:25
> > To: Jianyong Wu <Jianyong.Wu@arm.com>
> > Cc: linux-pm@vger.kernel.org; loongarch@lists.linux.dev;
> > linux-acpi@vger.kernel.org; linux-arch@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-riscv@lists.infradead.org; kvmarm@lists.linux.dev; x86@kernel.org;
> > linux-csky@vger.kernel.org; linux-doc@vger.kernel.org;
> > linux-ia64@vger.kernel.org; linux-parisc@vger.kernel.org; Salil Mehta
> > <salil.mehta@huawei.com>; Jean-Philippe Brucker <jean-philippe@linaro.org>;
> > Justin He <Justin.He@arm.com>; James Morse <James.Morse@arm.com>;
> > Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>;
> > Mark Rutland <Mark.Rutland@arm.com>; Lorenzo Pieralisi
> > <lpieralisi@kernel.org>
> > Subject: Re: [PATCH 34/39] arm64: psci: Ignore DENIED CPUs
> > 
> > On Thu, Nov 16, 2023 at 07:45:51AM +0000, Jianyong Wu wrote:
> > > Hi Russell,
> > >
> > > One inline comment.
> > ...
> > > > Changes since RFC v2
> > > >  * Add specification reference
> > > >  * Use EPERM rather than EPROBE_DEFER
> > ...
> > > > @@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)  {
> > > >  	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
> > > >  	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
> > > > -	if (err)
> > > > +	if (err && err != -EPROBE_DEFER)
> > >
> > > Should this be EPERM? As the following psci cpu_on op will return it.
> > > I think you miss to change this when apply Jean-Philippe's patch.
> > 
> > It looks like James didn't properly update all places. Also,
> > 
> > > > diff --git a/drivers/firmware/psci/psci.c
> > > > b/drivers/firmware/psci/psci.c index d9629ff87861..ee82e7880d8c
> > > > 100644
> > > > --- a/drivers/firmware/psci/psci.c
> > > > +++ b/drivers/firmware/psci/psci.c
> > > > @@ -218,6 +218,8 @@ static int __psci_cpu_on(u32 fn, unsigned long
> > > > cpuid, unsigned long entry_point)
> > > >  	int err;
> > > >
> > > >  	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> > > > +	if (err == PSCI_RET_DENIED)
> > > > +		return -EPERM;
> > > >  	return psci_to_linux_errno(err);
> > 
> > This change is unnecessary - probably comes from when -EPROBE_DEFER was
> > being used. psci_to_linux_errno() already does:
> 
> But may print lots of noise like:
> 
> [    0.008955] smp: Bringing up secondary CPUs ...
> [    0.009661] psci: failed to boot CPU1 (-1)
> [    0.010360] psci: failed to boot CPU2 (-1)
> [    0.011164] psci: failed to boot CPU3 (-1)
> [    0.011946] psci: failed to boot CPU4 (-1)
> [    0.012764] psci: failed to boot CPU5 (-1)
> [    0.013534] psci: failed to boot CPU6 (-1)
> [    0.014349] psci: failed to boot CPU7 (-1)
> [    0.014820] smp: Brought up 1 node, 1 CPU
> 
> Is this expected?

Please read my email again, and take note of the _context_ above the
places that I've commented. Context matters.

What I'm saying is that this change:

 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
+	if (err == PSCI_RET_DENIED)
+		return -EPERM;
 	return psci_to_linux_errno(err);

Is unnecessary when psci_to_linux_errno() already does:

static __always_inline int psci_to_linux_errno(int errno)
{
	switch (errno) {
	...
	case PSCI_RET_DENIED:
		return -EPERM;

So, a return of PSCI_RET_DENIED from invoke_psci_fn() above will
_already_ be translated to -EPERM (which is -1) by
psci_to_linux_errno(). There is no need to add that extra if()
statement in __psci_cpu_on().

I was _not_ saying that the entire patch was unnecessary.

Context matters. That's why we include context in replies.

Standard email etiquette (before Microsoft messed it up) is to quote the
email that is being replied to, trimming hard irrelevant content, and to
place the reply comments immediately below the original content to which
the comments relate, to give the reply comments the context necessary
for correct interpretation.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

