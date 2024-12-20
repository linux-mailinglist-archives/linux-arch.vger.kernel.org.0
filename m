Return-Path: <linux-arch+bounces-9447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B809F90AD
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 11:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058BF16F67B
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB411C548F;
	Fri, 20 Dec 2024 10:49:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0EB1C4A0D;
	Fri, 20 Dec 2024 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691792; cv=none; b=X+zCPk7xcGiNteuuGbaJw1QLRS6TjqqKIHLL5sfG0Kz2yi5ccfYAF1Ma5b/fhstrri7xTf4SaybjrKKHY0Sm3KYR0j5aDxVe6B7+zxreLfYWETjmOieqCMdQM/d9oJq/qWRnJcpTsy5cD+FtHSEf7PYGFXKNueQXj+i+uITvk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691792; c=relaxed/simple;
	bh=+YoPJYCVW+iqFgfJaBJhg6jUs924rEbw4ZmRIr4ZZOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di5gGRo4iWxvq01nfGqNlUoBbolKL0iQAdAXrqSmYxV8DBMBEzLGLttOCIH0q/d6UgXS4IeF6tp2vC0wiHMRznq35V7VEmiQEUjMEx1HpvD8ExyXRIXx5UjdErWg/UYhlz59pjxFebbkkkNEb5CC9KjN63e9CooYmBhyPwqYsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D0A81480;
	Fri, 20 Dec 2024 02:50:18 -0800 (PST)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8254C3F58B;
	Fri, 20 Dec 2024 02:49:44 -0800 (PST)
Message-ID: <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
Date: Fri, 20 Dec 2024 11:49:38 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
To: Peter Zijlstra <peterz@infradead.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241219171920.GB26279@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter, Qi,

On 19/12/2024 18:19, Peter Zijlstra wrote:
> On Thu, Dec 19, 2024 at 04:44:16PM +0000, Kevin Brodsky wrote:
>> Besides the ptlock management at PTE/PMD level, all the
>> pagetable_*_[cd]tor have the same implementation. Introduce common
>> helpers for all levels to reduce the duplication.
> Uff, I forgot to Cc you on the discussion here, sorry!:
>
>   https://lkml.kernel.org/r/cover.1734526570.git.zhengqi.arch@bytedance.com
>
> we now have two series doing more or less overlapping things :/
>
> You can in fact trivially merge the all the implementations -- the
> apparent non-common bit (ptlock_free) is a no-op for all those other
> levels because they'll be having ptdesc->lock == NULL.

Ah that is good to know, thanks for letting me know about that and Qi's
series! Fortunately there isn't that much overlap between our series - I
think we can easily sort this out.

Qi, shall we collaborate to make our series complementary? I believe my
series covers patch 2 and 4 of your series, but it goes further by
covering all levels and all architectures, and patches introducing
ctor/dtor are already split as Alexander suggested on your series. So my
suggestion would be:

* Remove patch 1 in my series - I'd just introduce
pagetable_{p4d,pgd}_[cd]tor with the same implementation as
pagetable_pud_[cd]tor.
* Remove patch 2 and 4 from your series and rebase it on mine.

Let me know if that makes sense, if so I'll post a v2.

Cheers,
- Kevin

