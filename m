Return-Path: <linux-arch+bounces-15494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB0CCBF84
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598FE30E59A5
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066EA33345A;
	Thu, 18 Dec 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlaanNU4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27AC32E6BE;
	Thu, 18 Dec 2025 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063339; cv=none; b=YQ/SiogGyJ5m9U0nrnvNY/RxIvc6RMB36snRa4lOCMGcuTkXDR+/2MZPaKv3jK/iUqNM5Ulvcnrq2SUkuwTWZCm3Ebnkv4ycSRwPeLzs6IgNmDwF6E4V8pTg0NWg9htfJURGYpxQsrAUHMklK2bqqkZIH618twh46EU1Qgfxh98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063339; c=relaxed/simple;
	bh=0f+h7b+YOWMHTpqkys0NZVUgtFkd09ljBQAIIb8BYlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiiB84s9pDKwst/gcGOQmFFHlYnQ24YDms7uGPjijJiAVsG+0wqpzuTIkRG7boFGCFwNLQs/a4cKxehiv+0Prbv8Cf+/2L9z7eW2XouaJkMzU8m32+5edQxQxXj+nMz4EX7fxJVRiwLuCDNKnuGcgz/7Ch01XJ2Q3fEcj0BnDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlaanNU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752E7C4CEFB;
	Thu, 18 Dec 2025 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766063339;
	bh=0f+h7b+YOWMHTpqkys0NZVUgtFkd09ljBQAIIb8BYlw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dlaanNU4XaeqJ6Fw+l7gb5R9fj9XzIwLPvYylFyMeZ+86+59Awhj7gokVCe5AjXID
	 VEWPNJXh6WRvrO8u3H4K/6ADHyYO3We4dmJnxSxy6XsmRJ8KXyoOK639E+Pwi1aDc3
	 KrQ4vqhF2wBmINiPTRty5fkKmB01SqIP2dXkaTAsC/pX295oT77A/o1lmqe2HwDY41
	 2Q0K3/PDdNFZpPGQ5XrPq+y4/cXCCHZK0cIbqvMifDYWC/vHKaxAUIo5GsAlGWgmHt
	 p0ILzG7u0juBycR0B0nxf58poGQP8StDWHw8xmZYxlmM4X4tcgA35NGdgwFPH6qQqW
	 hEUz/JDYJtFVw==
Message-ID: <f7552c2e-e12c-47c8-9b60-ec645cddf804@kernel.org>
Date: Thu, 18 Dec 2025 14:08:50 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] mm/tlb: allow architectures to skip redundant TLB
 sync IPIs
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251213080038.10917-1-lance.yang@linux.dev>
 <20251213080038.10917-2-lance.yang@linux.dev>
 <4ff8abad-186a-41b7-a269-70e9b1dc61e5@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <4ff8abad-186a-41b7-a269-70e9b1dc61e5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/25 06:48, Lance Yang wrote:
> 
> 
> On 2025/12/13 16:00, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When unsharing hugetlb PMD page tables, we currently send two IPIs:
>> one for TLB invalidation, and another to synchronize with concurrent
>> GUP-fast walkers.
>>
>> However, if the TLB flush already reaches all CPUs, the second IPI is
>> redundant. GUP-fast runs with IRQs disabled, so when the TLB flush IPI
>> completes, any concurrent GUP-fast must have finished.
>>
>> Add tlb_table_flush_implies_ipi_broadcast() to let architectures indicate
>> their TLB flush provides full synchronization, enabling the redundant IPI
>> to be skipped.
>>
>> The default implementation returns false to maintain current behavior.
>>
>> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>    include/asm-generic/tlb.h | 22 +++++++++++++++++++++-
>>    1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 324a21f53b64..3f0add95604f 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -248,6 +248,21 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
>>    #define tlb_needs_table_invalidate() (true)
>>    #endif
>>    
>> +/*
>> + * Architectures can override if their TLB flush already broadcasts IPIs to all
>> + * CPUs when freeing or unsharing page tables.
>> + *
>> + * Return true only when the flush guarantees:
>> + * - IPIs reach all CPUs with potentially stale paging-structure cache entries
>> + * - Synchronization with IRQ-disabled code like GUP-fast
>> + */
>> +#ifndef tlb_table_flush_implies_ipi_broadcast
>> +static inline bool tlb_table_flush_implies_ipi_broadcast(void)
>> +{
>> +	return false;
>> +}
>> +#endif
> 
> As the kernel test robot reported[1][2], the compiler is unhappy with
> patch #3:
> 
> ```
>      mm/khugepaged.c: In function 'collapse_huge_page':
>>>>> mm/khugepaged.c:1185:14: error: implicit declaration of function 'tlb_table_flush_implies_ipi_broadcast' [-Werror=implicit-function-declaration]
>       1185 |         if (!tlb_table_flush_implies_ipi_broadcast())
>            |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      cc1: some warnings being treated as errors
> ```
> 
> I'll move tlb_table_flush_implies_ipi_broadcast() outside of
> CONFIG_MMU_GATHER_RCU_TABLE_FREE in next version, making the complier
> happy on architectures that don't enable that config ;)

Yeah, that's probably cleanest.

-- 
Cheers

David

