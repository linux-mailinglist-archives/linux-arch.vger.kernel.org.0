Return-Path: <linux-arch+bounces-15410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB7CBC943
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 06:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE74300F31B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D919F11B;
	Mon, 15 Dec 2025 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GHlnuLzp"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3430DEAD
	for <linux-arch@vger.kernel.org>; Mon, 15 Dec 2025 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765777720; cv=none; b=p1EDp9FL/ySAqdv/QujY03cJ3NPIi4VR8jv6nkR6ihfUOenprYAosoIMBI/bdG5KaTId9cGgp2hGj9+sVu2UJWwG6PpFGer1fgB9Qjl8PymQevqqquN8GIdwKAdThB8CS3v+33xAUf/DFW1oL/rLUFWfPrPBMBFIfMNuBgjW4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765777720; c=relaxed/simple;
	bh=/BwNZkGSv+5kxhvU5A16hRMuRNslC68wp8tVJ6nv1LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0xE6yjo6LV6J/EVHOTrFvi+bCqxAmlM82UeW3sHvxSVPmlY6rT0HZg1dY4EHPbTOtHk/ZghI9xo0e8HtZRjAHLAtwSZanZGvBacRsydVH6GHwwH6dioYBlqNGEPRuJlwiOHSJhOXvOl5UTWF2kI3RUGJLI4MKPZm+aDFTha+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GHlnuLzp; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ff8abad-186a-41b7-a269-70e9b1dc61e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765777711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXBFQTQkWArDGCGQE3Qb4WRg56aochoyiuY4gkYroaU=;
	b=GHlnuLzp2XpmhCe7oRyppfHdyNfxGKYqQfvQfWKjYPAn57gO0JVV0fnA+AE3r0S0T4/GjV
	BR+ndZZ1ouw40aLma2uks6FFuAGjhdDsi29MQhXZERTN8qxw6Pc0+YzqGS8n7MPEhNqNSB
	gqbmALHgoIL0bLQmi+6vAqrgT2OxvXo=
Date: Mon, 15 Dec 2025 13:48:14 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/3] mm/tlb: allow architectures to skip redundant TLB
 sync IPIs
To: akpm@linux-foundation.org
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, shy828301@gmail.com, riel@surriel.com,
 jannh@google.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251213080038.10917-1-lance.yang@linux.dev>
 <20251213080038.10917-2-lance.yang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251213080038.10917-2-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/13 16:00, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When unsharing hugetlb PMD page tables, we currently send two IPIs:
> one for TLB invalidation, and another to synchronize with concurrent
> GUP-fast walkers.
> 
> However, if the TLB flush already reaches all CPUs, the second IPI is
> redundant. GUP-fast runs with IRQs disabled, so when the TLB flush IPI
> completes, any concurrent GUP-fast must have finished.
> 
> Add tlb_table_flush_implies_ipi_broadcast() to let architectures indicate
> their TLB flush provides full synchronization, enabling the redundant IPI
> to be skipped.
> 
> The default implementation returns false to maintain current behavior.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   include/asm-generic/tlb.h | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 324a21f53b64..3f0add95604f 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -248,6 +248,21 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
>   #define tlb_needs_table_invalidate() (true)
>   #endif
>   
> +/*
> + * Architectures can override if their TLB flush already broadcasts IPIs to all
> + * CPUs when freeing or unsharing page tables.
> + *
> + * Return true only when the flush guarantees:
> + * - IPIs reach all CPUs with potentially stale paging-structure cache entries
> + * - Synchronization with IRQ-disabled code like GUP-fast
> + */
> +#ifndef tlb_table_flush_implies_ipi_broadcast
> +static inline bool tlb_table_flush_implies_ipi_broadcast(void)
> +{
> +	return false;
> +}
> +#endif

As the kernel test robot reported[1][2], the compiler is unhappy with
patch #3:

```
    mm/khugepaged.c: In function 'collapse_huge_page':
>> >> mm/khugepaged.c:1185:14: error: implicit declaration of function 'tlb_table_flush_implies_ipi_broadcast' [-Werror=implicit-function-declaration]
     1185 |         if (!tlb_table_flush_implies_ipi_broadcast())
          |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: some warnings being treated as errors
```

I'll move tlb_table_flush_implies_ipi_broadcast() outside of
CONFIG_MMU_GATHER_RCU_TABLE_FREE in next version, making the complier
happy on architectures that don't enable that config ;)

[1] 
https://lore.kernel.org/oe-kbuild-all/202512142105.NXwq6dfP-lkp@intel.com/

[2] 
https://lore.kernel.org/oe-kbuild-all/202512142156.cShiu6PU-lkp@intel.com/
> +
>   void tlb_remove_table_sync_one(void);
>   
>   #else
> @@ -829,12 +844,17 @@ static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
>   	 * We only perform this when we are the last sharer of a page table,
>   	 * as the IPI will reach all CPUs: any GUP-fast.
>   	 *
> +	 * However, if the TLB flush already synchronized with other CPUs
> +	 * (indicated by tlb_table_flush_implies_ipi_broadcast()), we can skip
> +	 * the additional IPI.
> +	 *
>   	 * Note that on configs where tlb_remove_table_sync_one() is a NOP,
>   	 * the expectation is that the tlb_flush_mmu_tlbonly() would have issued
>   	 * required IPIs already for us.
>   	 */
>   	if (tlb->fully_unshared_tables) {
> -		tlb_remove_table_sync_one();
> +		if (!tlb_table_flush_implies_ipi_broadcast())
> +			tlb_remove_table_sync_one();
>   		tlb->fully_unshared_tables = false;
>   	}
>   }


