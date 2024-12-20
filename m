Return-Path: <linux-arch+bounces-9450-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F29F93B6
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 14:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0314160716
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6B215787;
	Fri, 20 Dec 2024 13:50:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503B215708;
	Fri, 20 Dec 2024 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702628; cv=none; b=spg85sG1xu3FiYN+jhSO50xJV4Lce1vx9c6EWREr5waNNvtED0vR+bJpD7RM4LVCyKD4BHRSawYY5WzEaBhnST8LBu7YAxKvSsPHk+A2dI49HOPAZHVSCnRMuWQYXcqRlXjxWIMwfTVS0BAupF8lbZ8qzkBdHO8LnGcU4I/8nSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702628; c=relaxed/simple;
	bh=tOIKmNQEMGn9hjJIR0rcaMsoO1iRnTK3X02bB4ePQuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNZA4/357ECMr/XekYJjT+S51VuU29eVOUQoTKNX9Vob4nyh/I0DcrusbtcF6bftgNmPGbxIFLtT13JIp/nRly76I1TS+A2d8XDAPEAd5oPIWxPWdXr+dEUL6FM8p/oa1tARPuXWve3z/nzJ3Eq3VaniI0XNz6lPfMqYlt9ENK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E7851480;
	Fri, 20 Dec 2024 05:50:53 -0800 (PST)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF2793F720;
	Fri, 20 Dec 2024 05:50:19 -0800 (PST)
Message-ID: <2f65f93e-9d44-4acc-b63c-8f5a35f59699@arm.com>
Date: Fri, 20 Dec 2024 14:50:17 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-2-kevin.brodsky@arm.com>
 <20241219171920.GB26279@noisy.programming.kicks-ass.net>
 <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
 <0daabd32-cba4-4345-baa8-e8c66bc899ff@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <0daabd32-cba4-4345-baa8-e8c66bc899ff@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2024 12:46, Qi Zheng wrote:
> Hi Kevin,
>
> On 2024/12/20 18:49, Kevin Brodsky wrote:
>> [...]
>>
>> Qi, shall we collaborate to make our series complementary? I believe my
>> series covers patch 2 and 4 of your series, but it goes further by
>> covering all levels and all architectures, and patches introducing
>> ctor/dtor are already split as Alexander suggested on your series. So my
>> suggestion would be:
>>
>> * Remove patch 1 in my series - I'd just introduce
>> pagetable_{p4d,pgd}_[cd]tor with the same implementation as
>> pagetable_pud_[cd]tor.
>> * Remove patch 2 and 4 from your series and rebase it on mine.
>
> I quickly went through your patch series. It looks like my patch 2 and
> your patch 6 are duplicated, so you want me to remove my patch 2.
>
> But I think you may not be able to simple let arm64, riscv and x86 to
> use generic p4d_{alloc_one,free}(). Because even if
> CONFIG_PGTABLE_LEVELS > 4, the pgtable_l5_enabled() may not be true.
>
> For example, in arm64:
>
> #if CONFIG_PGTABLE_LEVELS > 4
>
> static __always_inline bool pgtable_l5_enabled(void)
> {
>     if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
>         return vabits_actual == VA_BITS;
>     return alternative_has_cap_unlikely(ARM64_HAS_VA52);
> }

Correct. That's why the implementation of p4d_free() I introduce in
patch 6 checks mm_p4d_folded(), which is implemented as
!pgtable_l5_enabled() on those architectures (see last paragraph in
commit message). In fact it turns out Alexander suggested exactly this
approach [2].

>
> Did I miss something?
>
> My patch series is not only for cleanup, but also for fixes of
> UAF issue [1], so is it possible to rebase your patch series onto
> mine? I can post v3 ASAP.

I see, yours should be merged first then. The issue is that yours would
depend on some of the patches in mine, not the other way round.

My suggestion would then be for you to take patch 5, 6 and 7 from my
series, as they match Alexander's suggestions (and patch 5 is I think a
useful simplification), and replace patch 2 in your series with those. I
would then rebase my series on top and adapt it accordingly. Does that
sound reasonable?

- Kevin

[2]
https://lore.kernel.org/all/Z2RKpdv7pL34MIEt@tuxmaker.boeblingen.de.ibm.com/


