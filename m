Return-Path: <linux-arch+bounces-4971-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB890EA8F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2024 14:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1726DB212D6
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2024 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312C6140E47;
	Wed, 19 Jun 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc38HwOX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A82140395;
	Wed, 19 Jun 2024 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799111; cv=none; b=ZUqxiUsE96JXGymCuQJgMao4B1V8UXMfsYrZUcffuy9pbn0Bu3FVL3oxRdjcgE4bMaJ44kWU3Wu5t+Eco+TcIJF+aJbYraw3YB00LOWXOvCIZd8gW/pVXMKcp8d4dXML61YbyUgDXkS/w1XGhlCHR8JvaQwYaqHQYFVylZD39X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799111; c=relaxed/simple;
	bh=8UC3dd/xs1eHvnpkbzMHjvpFYyuJFdFAOtxj21nX+eg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM27il8YBG3mV9MFQfqE8WilpmDWbuE1FfdchPlmcXOtpkfmBE2Le7+CgX1bESUddxdbUn/2R3tgqv2uStoeWApGvPldIzLxn13LLJNMTm0NcF8q9ioipaeiT0VtjY16U1q8ZHLXGDEK+Xx8QgUoU86HahA/0aqWFnA4scSZ6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc38HwOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F7C4AF1D;
	Wed, 19 Jun 2024 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718799110;
	bh=8UC3dd/xs1eHvnpkbzMHjvpFYyuJFdFAOtxj21nX+eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sc38HwOXXA8zwNu1EdxnZfwAfuSgOQAgHP98hrVE8/M1bYDhPzGiO2utokmcGPh1O
	 tUL7KmeG5lBnM5WSk8yS/X47u3Dd3UmY2teYTP7QE3Vb8AptBUIXiCRPVRJ7AjS6Zr
	 LNs4+n7wK0e8Id0QAB6MiwNXdtY0v7B/ymqcOPu6+hrsUidSmxxRKPEpwQB/vcNMr8
	 Yb9jHJs98KH+8M5/8tRuph9lP666N3CpqYfCuiejh8sdyMsx5eQyh5hnnuVRaQHMOd
	 JpcDIKnRshkSsCf6s4mO7+BYH6mXPLaKKeY3HVgG37cdfWuK0Yz4VLu2NXh2TS5d9F
	 MKgqmi0zKCfdg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sJuAG-005RXt-4M;
	Wed, 19 Jun 2024 13:11:48 +0100
Date: Wed, 19 Jun 2024 13:11:47 +0100
Message-ID: <867celjfng.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Will Deacon <will@kernel.org>,
	"Catalin\
 Marinas" <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	<loongarch@lists.linux.dev>,
	<x86@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"Rafael J . Wysocki"
	<rafael@kernel.org>,
	"Miguel Luis" <miguel.luis@oracle.com>,
	James Morse
	<james.morse@arm.com>,
	"Salil Mehta" <salil.mehta@huawei.com>,
	Jean-Philippe
 Brucker <jean-philippe@linaro.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Gavin
 Shan <gshan@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov
	<bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	<justin.he@arm.com>,
	<jianyong.wu@arm.com>,
	Karl Heubaum
	<karl.heubaum@oracle.com>
Subject: Re: [PATCH v10 00/19] ACPI/arm64: add support for virtual cpu hotplug
In-Reply-To: <20240613112511.00006331@huawei.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
	<20240613112511.00006331@huawei.com>
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
X-SA-Exim-Rcpt-To: Jonathan.Cameron@Huawei.com, will@kernel.org, catalin.marinas@arm.com, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, mark.rutland@arm.com, tglx@linutronix.de, peterz@infradead.org, loongarch@lists.linux.dev, x86@kernel.org, linux@armlinux.org.uk, rafael@kernel.org, miguel.luis@oracle.com, james.morse@arm.com, salil.mehta@huawei.com, jean-philippe@linaro.org, guohanjun@huawei.com, gshan@redhat.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, justin.he@arm.com, jianyong.wu@arm.com, karl.heubaum@oracle.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 13 Jun 2024 11:25:27 +0100,
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> On Wed, 29 May 2024 14:34:27 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > v10:
> > - Make acpi_processor_set_per_cpu() return 0 / error rather than bool
> >   to simplify error handling at the call sites.
> >   (Thanks to both Rafael and Gavin who commented on this)
> > - Gather tags.
> > - Rebase on v6.10-rc1
> > 
> > The approach to the GICv3 changes stablized very late in the 6.10 cycle.
> > Subject to Marc taking a final look at those, I think we are now
> > in a good state wrt to those and the ACPI parts. The remaining code
> > that hasn't received review tags from the relevant maintainers
> > is the arm64 specific arch_register_cpu().  Given I think this will go
> > through the arm64 tree, hopefully they have just been waiting for
> > everything else to be ready.
> 
> Marc, Will, Catalin,
> 
> Any comments on this series?  We definitely want to finally land this
> in 6.11!
> 
> Marc, in practice I think you already gave feedback on the the GICv3
> changes in here as part of the discussions in the earlier version threads,
> but if you have time for a final glance through it would be much appreciated.
> Thanks for all your earlier help on this btw.

I've had a quick look and the GICv3 parts look OK to me (you should
now have by tags for both patches).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

