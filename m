Return-Path: <linux-arch+bounces-14855-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06262C688D5
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 10:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97E824EA4A0
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6F31771F;
	Tue, 18 Nov 2025 09:30:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA0314B79;
	Tue, 18 Nov 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458249; cv=none; b=Vs04e+g5vNOPGq+bF3u2LG4KBmM6WEd6HYRJ8nIMumGKOOievrxq1Y0g9vgPDnSXU3OatEJk+dyx9mw6dORBaaNcKp9JQZXJN4otoeN237AJTvWPVBp+8ENee/3BU7SJoZlai2SNtR8z0j5S5ejUmcx+oekFhe4u4u3an2ksHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458249; c=relaxed/simple;
	bh=U8SoEWNVo7Bg/vtnXCbFJOk39i8M3igdqr7sqdQ+yp4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chli7Jtj5SsehUVnZqEnw/yDHZpoAAbXGI1BLh9DwBtpJnWh+t4NYE9Gs2LYWEh2iPo2tUBzXoIpElEXj+z0F9UJXKvJHhJ5YYs5cXlUAL4w1ys47ET9GtflzHsbacOP7xqJml42IKeKot5iSKpGxHOZ35to9q5fUc9Vgitv88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9fTk1j18zJ46cb;
	Tue, 18 Nov 2025 17:30:02 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F92E140277;
	Tue, 18 Nov 2025 17:30:44 +0800 (CST)
Received: from localhost (10.48.158.191) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Nov
 2025 09:30:42 +0000
Date: Tue, 18 Nov 2025 09:30:41 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "Drew
 Fustini" <fustini@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, <james.morse@arm.com>, Will Deacon <will@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v6 3/7] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <20251118093041.00000c9e@huawei.com>
In-Reply-To: <20251117-definite-uncounted-7cc07a377a71@spud>
References: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
	<20251117104800.2041329-4-Jonathan.Cameron@huawei.com>
	<3bf1793a-2ffd-4017-b4bf-dc63f3a2a7c8@infradead.org>
	<20251117-definite-uncounted-7cc07a377a71@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 18 Nov 2025 00:13:07 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Nov 17, 2025 at 10:51:11AM -0800, Randy Dunlap wrote:
> > Hi,
> > 
> > On 11/17/25 2:47 AM, Jonathan Cameron wrote:  
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index e629449dd2a3..e11136d188ae 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -542,6 +542,10 @@ config MEMREGION
> > >  config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > >  	bool
> > >  
> > > +config GENERIC_CPU_CACHE_MAINTENANCE
> > > +	bool
> > > +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > > +
> > >  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
> > >  	bool  
> > 
> > Architectures and/or platforms select ARCH_HAS_*.
> > 
> > With this change above, it becomes the only entry in
> > lib/Kconfig that does "select ARCH_HAS_anytning".
> > 
> > so I think this is wrong, back*wards.  
> 
> Maybe it is backwards, but I feel like this way is more logical. ARM64
> has memregion invalidation only because this generic approach is
> enabled, so the arch selects what it needs to get the support.

Exactly this. Catalin requested this form in response to an earlier
version where arm64 Kconfig just had both selects for pretty much that
reason. This is expected to be used on a subset of architectures.
It is similar to things like GENERIC_ARCH_NUMA in this respect (though the
arch_numa_init() etc in there are called only from other arch code
so no ARCH_HAS_ symbols are associated with them).

> Alternatively, something like

I'm fine with this solution if Randy prefers it.

Thanks for your help with this.

Jonathan

> | diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> | index 5f7f63d24931..75b2507f7eb2 100644
> | --- a/arch/arm64/Kconfig
> | +++ b/arch/arm64/Kconfig
> | @@ -21,6 +21,7 @@ config ARM64
> |  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> |  	select ARCH_HAS_CACHE_LINE_SIZE
> |  	select ARCH_HAS_CC_PLATFORM
> | +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> |  	select ARCH_HAS_CURRENT_STACK_POINTER
> |  	select ARCH_HAS_DEBUG_VIRTUAL
> |  	select ARCH_HAS_DEBUG_VM_PGTABLE
> | @@ -146,7 +147,6 @@ config ARM64
> |  	select GENERIC_ARCH_TOPOLOGY
> |  	select GENERIC_CLOCKEVENTS_BROADCAST
> |  	select GENERIC_CPU_AUTOPROBE
> | -	select GENERIC_CPU_CACHE_MAINTENANCE
> |  	select GENERIC_CPU_DEVICES
> |  	select GENERIC_CPU_VULNERABILITIES
> |  	select GENERIC_EARLY_IOREMAP
> | diff --git a/lib/Kconfig b/lib/Kconfig
> | index 09aec4a1e13f..ac223e627bc5 100644
> | --- a/lib/Kconfig
> | +++ b/lib/Kconfig
> | @@ -544,8 +544,9 @@ config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> |  	bool
> |  
> |  config GENERIC_CPU_CACHE_MAINTENANCE
> | -	bool
> | -	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> | +	def_bool y
> | +	depends on ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> | +	depends on ARM64
> |  
> |  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
> |  	bool
> implies (to me at least) that arm64 has memregion invalidation as an
> architectural feature and that the GENERIC_CPU_CACHE_MAINTENANCE option
> is a just common cross-arch code, like generic entry etc, rather than
> being the option gating the drivers that provide the feature in the
> first place.
> 
> I didn't really care which way it went, and was gonna post something to
> squash and avoid another revision, but I found the resultant Kconfig
> setup to be make less sense to me than what came before. If the switched
> around version is less likely to be problematic etc, then sure, but I
> amn't convinced by switching it at a first glance.
> 



