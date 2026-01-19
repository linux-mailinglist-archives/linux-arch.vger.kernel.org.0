Return-Path: <linux-arch+bounces-15856-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B691D3A4B8
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31B35307E2D6
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076B299AA3;
	Mon, 19 Jan 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7bFMmLq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB31279DCD;
	Mon, 19 Jan 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817939; cv=none; b=n3U/9BzBFe7BIbWypYWebK5iipgawcA/gsNSNCWlxJP8h0O1md7vGn8JYO2f4ZRaGQnI3hLbMHh38YFFMf13ray14q6nJz0vs/+TuIi0UtuNsuDnrWVJv2JimBUH6jwEhEj8FH9KobkA2YJ0eL6dxmmcoxwVDnFUlbs2hFJ2ov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817939; c=relaxed/simple;
	bh=fChsW6zHlCrxmXpBWFm7rxfPs3w59SiQtBb4E9KHfFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHcCV72g7uzSptMk0zPuyaI3N3saSKaX8pEyt9mcg5/x6zy1yPFy1NfmMTU/a4lbmt19er7T+Cn3AnfuSIwNczwOC6UtSDHLBGKAKo9EKWP/kS9+l5+H3qf3dW4nbGtClfDbAGB4QbZ36OeBiIEX0s8oTRQNR9tAkni5glaE0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7bFMmLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AFFC2BCB2;
	Mon, 19 Jan 2026 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768817939;
	bh=fChsW6zHlCrxmXpBWFm7rxfPs3w59SiQtBb4E9KHfFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d7bFMmLq1M9B8AoeKJQ9vihTU2U179+WmU91kWylvHMAex0kvNr1DQu7ArTzlhgmn
	 4pPAxBoFN99lPf4XxyZ7tKbta1qikb7XJrp4yQh6co8oYvuotYRIA1NvXdzUJZRifS
	 FxhutMYG4Y4QWgPa5uqAQinVsFZ/C3a1U/Ly553bgwajDO3Eafz7qBAx+ZsgAtcKkO
	 zZN7xdRM9KwgEZWJ72QmBNlK7I+iUWDUAFicFdjUCQSAPYwBG/CXF+M+t1L9sAxu1e
	 JiR+7Xwrb5/DZiknvTj7tiHrF90zeuEV3qr6RB81V4uGa/vwe/R5dc7JkZ36tQyv3/
	 F3k5MADrrYaOg==
Message-ID: <d38fcbe5-8b4a-40bc-b8c8-1c49ccaa9964@kernel.org>
Date: Mon, 19 Jan 2026 11:18:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
To: Wei Yang <richard.weiyang@gmail.com>, Qi Zheng <qi.zheng@linux.dev>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 ioworker0@gmail.com, linmag7@gmail.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
 <20251231094243.zmjs7kgflm7q6k73@master>
 <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
 <20260101020715.45wqnjgcklvjcth3@master>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260101020715.45wqnjgcklvjcth3@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/26 03:07, Wei Yang wrote:
> On Wed, Dec 31, 2025 at 05:52:57PM +0800, Qi Zheng wrote:
>>
>>
>> On 12/31/25 5:42 PM, Wei Yang wrote:
>>> On Wed, Dec 17, 2025 at 05:45:48PM +0800, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> The PT_RECLAIM can work on all architectures that support
>>>> MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>>>> MMU_GATHER_RCU_TABLE_FREE.
>>>>
>>>> BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>>>> to turn it off.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>> arch/x86/Kconfig | 1 -
>>>> mm/Kconfig       | 9 ++-------
>>>> 2 files changed, 2 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>> index 80527299f859a..0d22da56a71b0 100644
>>>> --- a/arch/x86/Kconfig
>>>> +++ b/arch/x86/Kconfig
>>>> @@ -331,7 +331,6 @@ config X86
>>>> 	select FUNCTION_ALIGNMENT_4B
>>>> 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>> 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>>> -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>>>> 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>>>> 	select SCHED_SMT			if SMP
>>>> 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index bd0ea5454af82..fc00b429b7129 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>> 	  The architecture has hardware support for userspace shadow call
>>>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>>>
>>>> -config ARCH_SUPPORTS_PT_RECLAIM
>>>> -	def_bool n
>>>> -
>>>> config PT_RECLAIM
>>>> -	bool "reclaim empty user page table pages"
>>>> -	default y
>>>> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>>> -	select MMU_GATHER_RCU_TABLE_FREE
>>>> +	def_bool y
>>>> +	depends on MMU_GATHER_RCU_TABLE_FREE
>>>> 	help
>>>> 	  Try to reclaim empty user page table pages in paths other than munmap
>>>> 	  and exit_mmap path.
>>>
>>> Hi, Qi
>>>
>>> I am new to PT_RECLAIM, when reading related code I got one question.
>>>
>>> Before this patch,  we could have this config combination:
>>>
>>>       CONFIG_MMU_GATHER_RCU_TABLE_FREE & !CONFIG_PT_RECLAIM
>>>
>>> This means tlb_remove_table_free() is rcu version while tlb_remove_table_one()
>>> is semi rcu version.
>>>
>>> I am curious could we use rcu version tlb_remove_table_one() for this case?
>>> Use rcu version tlb_remove_table_one() if CONFIG_MMU_GATHER_RCU_TABLE_FREE. Is
>>> there some limitation here?
>>
>> I think there's no problem. The rcu version can also ensure that the
>> fast GUP works well.
>>
> 
> Thanks for your quick response :-)
> 
> And Happy New Year
> 
> So my little suggestion is move the definition of __tlb_remove_table_one()
> under CONFIG_MMU_GATHER_RCU_TABLE_FREE. Do you thinks this would be more
> clear?


Do you mean

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 2faa23d7f8d42..6aeba4bae68d2 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -319,7 +319,7 @@ static inline void tlb_table_invalidate(struct 
mmu_gather *tlb)
         }
  }

-#ifdef CONFIG_PT_RECLAIM
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
  static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
  {
         struct ptdesc *ptdesc;

?

-- 
Cheers

David

