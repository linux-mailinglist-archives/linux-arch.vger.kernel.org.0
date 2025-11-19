Return-Path: <linux-arch+bounces-14884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F7C6C3A2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 02:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7570D28F01
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 01:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A1C1E0083;
	Wed, 19 Nov 2025 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QC1tunr6"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79C19D07E;
	Wed, 19 Nov 2025 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515124; cv=none; b=Ox/vF8dTpkNeeUcIeUDJ7oIw1FwzMvX/x9z7T5iMZ+v5IN1gY1AF5Caj50BZ9Hmv3L5BkE5bJ/1zSl7pxtVM8IZ9aFYsnemEKHUhm1umA5DiBEZcR46OwW2uA1JatwL5zmiPWZWxkC0bXcqrS7ocB1F9GWpxyXnM2u6CQVyy3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515124; c=relaxed/simple;
	bh=66Pk51Y6hl6cFLy/Cjj2s2RgDzKKBJ5zXtSZ1r+4xsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVmTx63JOeghdMIK/2vGEZBdfQEXT4+c2y8SgIhTMsAFKGPnhJjBulCjupa3iInJrigWLoSnBkBPKJc58u//581PXHgPeueF+CQu8V1X3e24dwcm3dvbJBcG5Btx29xu6/mq3nT+TNxkjKoOjwyfGF+0l8ynlFER9vIWceZP5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QC1tunr6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jEWakcvW1TnAMoV+h8ZFjseo1NzKkn1k3ld14oxm230=; b=QC1tunr6eaQovDaqvqIBwr3X+/
	C3C5mLb7Pa22aUwA2v5Fa6Ah0VeP6F5VFmTRWqBPTqD0qJqZ0fFlPrCq6bhhkG1jA0YTxGkJaUBwi
	GQkwuUOualXgI8nvNDfrZZEwbffMu/1H2i/6cwuef4EsvzFYIzGipzrky8OkwVCzRZOpxybG/1TzI
	NhRJtkYVP1+gbltlQKPs1SuTkbYcWXrjwLS1XcMN8Cvaxk5vtIdYcqZZ4YH+fjMgc+o50wNVoyCp+
	l8heA9Yu81ccf5Z2bwICTGnz4TXBZCY9VEDbV5p6HemHQ4kcT9TxY/pIPsmLWD7eBJBUuYTcpZU1W
	5typ2JHQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLWq8-00000001L1B-2Eo5;
	Wed, 19 Nov 2025 01:18:32 +0000
Message-ID: <2241d985-0e35-41e5-93b1-1e8d4e7a84bf@infradead.org>
Date: Tue, 18 Nov 2025 17:18:31 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Conor Dooley <conor@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-cxl@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Drew Fustini <fustini@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, james.morse@arm.com,
 Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 linuxarm@huawei.com, Yushan Wang <wangyushan12@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 Andy Lutomirski <luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
References: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
 <20251117104800.2041329-4-Jonathan.Cameron@huawei.com>
 <3bf1793a-2ffd-4017-b4bf-dc63f3a2a7c8@infradead.org>
 <20251117-definite-uncounted-7cc07a377a71@spud>
 <20251118093041.00000c9e@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251118093041.00000c9e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/25 1:30 AM, Jonathan Cameron wrote:
> On Tue, 18 Nov 2025 00:13:07 +0000
> Conor Dooley <conor@kernel.org> wrote:
> 
>> On Mon, Nov 17, 2025 at 10:51:11AM -0800, Randy Dunlap wrote:
>>> Hi,
>>>
>>> On 11/17/25 2:47 AM, Jonathan Cameron wrote:  
>>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>>> index e629449dd2a3..e11136d188ae 100644
>>>> --- a/lib/Kconfig
>>>> +++ b/lib/Kconfig
>>>> @@ -542,6 +542,10 @@ config MEMREGION
>>>>  config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>>>>  	bool
>>>>  
>>>> +config GENERIC_CPU_CACHE_MAINTENANCE
>>>> +	bool
>>>> +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>>>> +
>>>>  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
>>>>  	bool  
>>>
>>> Architectures and/or platforms select ARCH_HAS_*.
>>>
>>> With this change above, it becomes the only entry in
>>> lib/Kconfig that does "select ARCH_HAS_anytning".
>>>
>>> so I think this is wrong, back*wards.  
>>
>> Maybe it is backwards, but I feel like this way is more logical. ARM64
>> has memregion invalidation only because this generic approach is
>> enabled, so the arch selects what it needs to get the support.
> 
> Exactly this. Catalin requested this form in response to an earlier
> version where arm64 Kconfig just had both selects for pretty much that
> reason. This is expected to be used on a subset of architectures.
> It is similar to things like GENERIC_ARCH_NUMA in this respect (though the
> arch_numa_init() etc in there are called only from other arch code
> so no ARCH_HAS_ symbols are associated with them).
> 
>> Alternatively, something like
> 
> I'm fine with this solution if Randy prefers it.

I do much prefer this alternative.

> Thanks for your help with this.

Thanks for listening.


>> | diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> | index 5f7f63d24931..75b2507f7eb2 100644
>> | --- a/arch/arm64/Kconfig
>> | +++ b/arch/arm64/Kconfig
>> | @@ -21,6 +21,7 @@ config ARM64
>> |  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>> |  	select ARCH_HAS_CACHE_LINE_SIZE
>> |  	select ARCH_HAS_CC_PLATFORM
>> | +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>> |  	select ARCH_HAS_CURRENT_STACK_POINTER
>> |  	select ARCH_HAS_DEBUG_VIRTUAL
>> |  	select ARCH_HAS_DEBUG_VM_PGTABLE
>> | @@ -146,7 +147,6 @@ config ARM64
>> |  	select GENERIC_ARCH_TOPOLOGY
>> |  	select GENERIC_CLOCKEVENTS_BROADCAST
>> |  	select GENERIC_CPU_AUTOPROBE
>> | -	select GENERIC_CPU_CACHE_MAINTENANCE
>> |  	select GENERIC_CPU_DEVICES
>> |  	select GENERIC_CPU_VULNERABILITIES
>> |  	select GENERIC_EARLY_IOREMAP
>> | diff --git a/lib/Kconfig b/lib/Kconfig
>> | index 09aec4a1e13f..ac223e627bc5 100644
>> | --- a/lib/Kconfig
>> | +++ b/lib/Kconfig
>> | @@ -544,8 +544,9 @@ config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>> |  	bool
>> |  
>> |  config GENERIC_CPU_CACHE_MAINTENANCE
>> | -	bool
>> | -	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>> | +	def_bool y
>> | +	depends on ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>> | +	depends on ARM64
>> |  
>> |  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
>> |  	bool
>> implies (to me at least) that arm64 has memregion invalidation as an
>> architectural feature and that the GENERIC_CPU_CACHE_MAINTENANCE option
>> is a just common cross-arch code, like generic entry etc, rather than
>> being the option gating the drivers that provide the feature in the
>> first place.
>>
>> I didn't really care which way it went, and was gonna post something to
>> squash and avoid another revision, but I found the resultant Kconfig
>> setup to be make less sense to me than what came before. If the switched
>> around version is less likely to be problematic etc, then sure, but I
>> amn't convinced by switching it at a first glance.


-- 
~Randy


