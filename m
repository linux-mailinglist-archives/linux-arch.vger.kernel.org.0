Return-Path: <linux-arch+bounces-14312-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F97C02794
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A71354EA68C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9608D32ED27;
	Thu, 23 Oct 2025 16:40:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B166308F38;
	Thu, 23 Oct 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237634; cv=none; b=R9ck50BeZTtwfPcX5eFZQTkOwXVgrX6bLOENKj425SkivR79UtJf3ApJ7lMb7bij5pk5HNjHlDiQZqPRog1qFePjVPUL/E/IjRlHRofdFHnvx9Pt9y+ggA7cU/o+kdIma803eutWuJILwNK5ETOA50JmZVZv9j+TWhTmunV0I+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237634; c=relaxed/simple;
	bh=62vnVCxhE2uq9rWK5Sz6k2NBWe86N2NlRNfP+hO/mWk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YORc3ArPm7HbjrUbl8Ffn8nNgdlxtknArOc4KeUq2vPE4xQ/+i1IyOu8pxvDoHJhFkkYJtfo07jo8Vpb8XeqXYpECd2tt6fswSKmP3kIVkLINx4j7agKTLZWZDrcR08JOKVGxzXh+99xe4iZUcwJaVIxLE5WA2MSsVFKW4NUO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cssDh5Wmgz6L57c;
	Fri, 24 Oct 2025 00:39:00 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D77761400CB;
	Fri, 24 Oct 2025 00:40:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 17:40:27 +0100
Date: Thu, 23 Oct 2025 17:40:26 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	<james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Arnd Bergmann
	<arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>,
	Drew Fustini <fustini@kernel.org>
Subject: Re: [PATCH v4 0/6] Cache coherency management subsystem
Message-ID: <20251023174026.00005b42@huawei.com>
In-Reply-To: <20251022-harsh-juggling-2d4778b0649e@spud>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
	<20251022122241.d2aa0d7864f67112aa7691bf@linux-foundation.org>
	<20251022-harsh-juggling-2d4778b0649e@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 22 Oct 2025 21:47:21 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Oct 22, 2025 at 12:22:41PM -0700, Andrew Morton wrote:
> > On Wed, 22 Oct 2025 12:33:43 +0100 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > Support system level interfaces for cache maintenance as found on some
> > > ARM64 systems. This is needed for correct functionality during various
> > > forms of memory hotplug (e.g. CXL). Typical hardware has MMIO interface
> > > found via ACPI DSDT.
> > > 
> > > Includes parameter changes to cpu_cache_invalidate_memregion() but no
> > > functional changes for architectures that already support this call.  
> > 
> > I see additions to lib/ so presumably there is an expectation that
> > other architectures might use this.
> > 
> > Please expand on this.  Any particular architectures in mind?  Any
> > words of wisdom which maintainers of those architectures might benefit
> > from?  
> 
> It seems fairly probable that we're gonna end up with riscv systems
> where drivers are being used for both this and the existing non-standard
> cache ops stuff.
> 
> > > How to merge?  When this is ready to proceed (so subject to review
> > > feedback on this version), I'm not sure what the best route into the
> > > kernel is. Conor could take the lot via his tree for drivers/cache but
> > > the generic changes perhaps suggest it might be better if Andrew
> > > handles this?  Any merge conflicts in drivers/cache will be trivial
> > > build file stuff. Or maybe even take it throug one of the affected
> > > trees such as CXL.  
> > 
> > Let's not split the series up.  Either CXL or COnor's tree is fine my
> > me.  
> 
> CXL is fine by me, greater volume there probably by orders of magnitude.
> 

On CXL discord, some reasonable doubts were expressed about justifying
this to Linus via CXL. Which is fair given tiny overlap from a 'where
the code is' point of view and also it seems I went too far in trying to
avoid people interpreting this as affecting x86 systems (see earlier
versions for how my badly scoped cover letter distracted from what this
was doing) and focus in on what was specifically being enabled rather
than the generic bit. Hence it mentions arm64 only right now and right
at the top of the cover letter.

Given it's not Arm architecture (hence just one Kconfig line in Arm
specific code) I guess alternative is back to drivers/cache and Conor which
I see goes via SoC (so +CC SoC tree maintainers).

Given there will be a v5 I'll rewrite the cover letter to make it less
specific whilst still calling out that for now the only driver happens to
be in an Arm SoC. Will leave some time for additional review first though!

Thanks,

Jonathan





