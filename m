Return-Path: <linux-arch+bounces-15496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD798CCC4B7
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 15:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF8EF30275BD
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D141C2737F9;
	Thu, 18 Dec 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PpMbVtrz"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C8257448
	for <linux-arch@vger.kernel.org>; Thu, 18 Dec 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766068576; cv=none; b=k/UHHce4dudmppsRan483Cyexl9qClfiuyMUaRHLDkI4NgInLB5vMzo1ZFqMegitIoLNJY1FcTZAHn4M2FzYwJxvqdexfgYPzt4hUvz5T7O2pfPGl4ddi+7JkE0Lkmar6gbULK/t1ZAx6minS4y60en/skn8HoI0EIUkAiNzhCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766068576; c=relaxed/simple;
	bh=4KEVoBX1tq64wU+qAS265Rmxx0K+GFXcp+VSKNYxIp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVB21IaDVH0HJJEYRI6fKYG7VvK/eT31c1WklfzKFtxAD19nxPyxYrvx0BYsEhgLqwjB9zLYrSUmCsAzrCvZB+KbH6yY0iRZB6UcpOVxziWX9/71UkCeRdzixord3axGPVW3nBp0WelgsQ5rUoQXzaNd8Dk2PMFAxVDwylAtdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PpMbVtrz; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6fdf89ee-3f6a-420f-b4d6-b03e3e2c8c9b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766068571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/obYsmYE7DxZF0F7CimsIs8ULL/trNGoQu3yuIxJ4Q=;
	b=PpMbVtrzF9RqtCYbqHrg5kVIozY0nQPPfUZDye+GfxYxEfRSyrmGid/c8J5DlSEP9uuEaZ
	Rg366J3xLe78dFngON/IJ7OO8n1xI7PKzXlwpQYQvzYImbl3cCw37jX/Pq7r9o4a6Q0eDX
	kD2GtDWnn4voFSAKU1hfnCKTYllD5wI=
Date: Thu, 18 Dec 2025 22:35:59 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 3/3] mm/khugepaged: skip redundant IPI in
 collapse_huge_page()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <20251213080038.10917-1-lance.yang@linux.dev>
 <20251213080038.10917-4-lance.yang@linux.dev>
 <948d425a-2d6e-4439-a280-0ca9e7521b13@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <948d425a-2d6e-4439-a280-0ca9e7521b13@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/18 21:13, David Hildenbrand (Red Hat) wrote:
> On 12/13/25 09:00, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Similar to the hugetlb PMD unsharing optimization, skip the second IPI
>> in collapse_huge_page() when the TLB flush already provides necessary
>> synchronization.
>>
>> Before commit a37259732a7d ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE
>> unconditional"), bare metal x86 didn't enable MMU_GATHER_RCU_TABLE_FREE.
>> In that configuration, tlb_remove_table_sync_one() was a NOP. GUP-fast
>> synchronization relied on IRQ disabling, which blocks TLB flush IPIs.
>>
>> When Rik made MMU_GATHER_RCU_TABLE_FREE unconditional to support AMD's
>> INVLPGB, all x86 systems started sending the second IPI. However, on
>> native x86 this is redundant:
>>
>>    - pmdp_collapse_flush() calls flush_tlb_range(), sending IPIs to all
>>      CPUs to invalidate TLB entries
>>
>>    - GUP-fast runs with IRQs disabled, so when the flush IPI completes,
>>      any concurrent GUP-fast must have finished
>>
>>    - tlb_remove_table_sync_one() provides no additional synchronization
>>
>> On x86, skip the second IPI when running native (without paravirt) and
>> without INVLPGB. For paravirt with non-native flush_tlb_multi and for
>> INVLPGB, conservatively keep both IPIs.
>>
>> Use tlb_table_flush_implies_ipi_broadcast(), consistent with the hugetlb
>> optimization.
>>
>> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 97d1b2824386..06ea793a8190 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1178,7 +1178,12 @@ static int collapse_huge_page(struct mm_struct 
>> *mm, unsigned long address,
>>       _pmd = pmdp_collapse_flush(vma, address, pmd);
>>       spin_unlock(pmd_ptl);
>>       mmu_notifier_invalidate_range_end(&range);
>> -    tlb_remove_table_sync_one();
>> +    /*
>> +     * Skip the second IPI if the TLB flush above already synchronized
>> +     * with concurrent GUP-fast via broadcast IPIs.
>> +     */
>> +    if (!tlb_table_flush_implies_ipi_broadcast())
>> +        tlb_remove_table_sync_one();
> 
> We end up calling
> 
>      flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> 
>      -> flush_tlb_mm_range(freed_tables = true)
> 
>      -> flush_tlb_multi(mm_cpumask(mm), info);
> 
> So freed_tables=true and we should be doing the right thing.

Yep ;)

> BTW, I was wondering whether we should embed that 
> tlb_table_flush_implies_ipi_broadcast() check in 
> tlb_remove_table_sync_one() instead.
> It then relies on the caller to do the right thing (flush with 
> freed_tables=true or unshared_tables = true).
> 
> Thoughts?

Good point! Let me check the other callers to ensure they
are all preceded by a flush with freed_tables=true (or unshared_tables).

Will get back to you with what I find :)

Cheers,
Lance

