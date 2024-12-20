Return-Path: <linux-arch+bounces-9452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2995E9F9445
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 15:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6547F1883F04
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF421638C;
	Fri, 20 Dec 2024 14:28:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EF215F41;
	Fri, 20 Dec 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704926; cv=none; b=bZQo/RxsEKbpr3SdNfMCcXYVydxlF/p/M7wk6fblGMrc18/Zk8WpjbqoGVygCnaFD2f1SDkFgMZ80LnwQWryTBVN5RVoUoliheeOGbwjpLpb//GTjc2p9BuMoqFxU9YHA+nkvKCpzO+8RReHzfXOLuKwV7RuoIIivJP654czdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704926; c=relaxed/simple;
	bh=NoZP/C74YL+gAOuTVINVRjr/kSwdZlwelqBG4tRegrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl3ugV6MpXI9rED7ttUQLLfM6bg+XRR9Tw7U1rXj0H/zz1gadfOqOUHESPQDnVpvQ7MlBPLbU7+vuOBU44lWdClETFG9OeKKwHhQqpo+FemZ/NLlOH6kfVI+gDVerxnJ1yLlcjF+0TZVLVDjkGNPNRnWWaIlWkzKm+O+DSepU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F5F1480;
	Fri, 20 Dec 2024 06:29:12 -0800 (PST)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FAEB3F720;
	Fri, 20 Dec 2024 06:28:38 -0800 (PST)
Message-ID: <7f5e6ac7-01ef-46c8-bc85-7f8399dadb19@arm.com>
Date: Fri, 20 Dec 2024 15:28:36 +0100
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
 <2f65f93e-9d44-4acc-b63c-8f5a35f59699@arm.com>
 <33ce9b58-4787-49cd-a7f2-34272cb3ecf7@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <33ce9b58-4787-49cd-a7f2-34272cb3ecf7@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2024 15:16, Qi Zheng wrote:
>>>
>>> Did I miss something?
>>>
>>> My patch series is not only for cleanup, but also for fixes of
>>> UAF issue [1], so is it possible to rebase your patch series onto
>>> mine? I can post v3 ASAP.
>>
>> I see, yours should be merged first then. The issue is that yours would
>> depend on some of the patches in mine, not the other way round.
>>
>> My suggestion would then be for you to take patch 5, 6 and 7 from my
>> series, as they match Alexander's suggestions (and patch 5 is I think a
>> useful simplification), and replace patch 2 in your series with those. I
>> would then rebase my series on top and adapt it accordingly. Does that
>> sound reasonable?
>
> Sounds good. But maybe just patch 5 and 6. Because I actually did
> the work of your patch 7 in my patch 2 and 4.

Yes that's fair! You'd have to do adapt my patch 7 to make it fit in
your series so I agree it makes more sense this way.

>
> So, is it okay to do something like the following?
>
> 1. I separate the ctor()/dtor() part from my patch 2, and then replace
>    the rest with your patch 6.
> 2. take your patch 5 form your series

Sounds good to me!

IIUC Dave Hansen gave his Acked-by for the x86 part of patch 6 [1],
would make sense to add it when you post your v3.

>
> If it's ok, I will post the v3 next Monday. ;)

Perfect. I'm going offline tonight, when I come back in the new year
I'll review your v3 series and post a new version of this one.

Cheers,
- Kevin

[1]
https://lore.kernel.org/linux-mm/a7398426-56d1-40b4-a1c9-40ae8c8a4b4b@intel.com/

