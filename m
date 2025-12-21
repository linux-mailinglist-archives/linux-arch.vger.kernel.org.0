Return-Path: <linux-arch+bounces-15525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B809CD3EBE
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D107A300982D
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6DA28853E;
	Sun, 21 Dec 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CWhqflV4"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3D27FD71
	for <linux-arch@vger.kernel.org>; Sun, 21 Dec 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766313842; cv=none; b=XK2yaZk1zeLdgzCuYleMuUWTIKtacFJ6yU57D1bT5FKNdYv+xwutmnf+UC1hQ43TKzJxoPbDYETcGkwd6U4xISvjkQnpl+VjFJskgjwhJVmJp8Z/iXvn+ggKp/XyblMRa9taoH1V2S++gc8hGCm1Unjk+fRREjkBqd099BCm14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766313842; c=relaxed/simple;
	bh=NawelembbC8+pUY9APpcquoZcw9U/+Q6GH3DhVuuGvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aV2miVZalePaMSORSyJSKTDKZrlKXROY0yrfJygW1h/aWrOYaMtffE9BvkR/zsVgHseZjhCGY7t9GUgoDNjkyaTZncSqYzKSUISv/L7od8T8d/e5Sip55kg/mgXXsQUFAl64y86BGHDg0sNq/EnX9W550qx0gapjhmvPOI9dLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CWhqflV4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <90c1ff67-46fb-4ddd-9bdd-43633f89dda2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766313826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/nJw25aoa6JK8nypoTwLkmJKFtsfe7JaJlTBhslbOk=;
	b=CWhqflV4t5sakvP8LVfvQLFJPUtApAiiqmvV0P8zoWeb8DX7MR5Iv59vb1r8AvOQvLi+dk
	d6wSA9+/L49daP6cNHmR3BWi7PRdBT1dNfmGLkiimtSAJNAgd7gRUFe+4IleLoukOg9bEm
	gA3HS59ZiYQcyO8QMu/kdTosDXgdahA=
Date: Sun, 21 Dec 2025 18:43:32 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 3/3] mm/khugepaged: skip redundant IPI in
 collapse_huge_page()
Content-Language: en-US
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
 <6fdf89ee-3f6a-420f-b4d6-b03e3e2c8c9b@linux.dev>
 <6dcfeb2a-dba6-4de9-ac1b-39312c6bbcb6@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <6dcfeb2a-dba6-4de9-ac1b-39312c6bbcb6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/19 16:25, David Hildenbrand (Red Hat) wrote:
> On 12/18/25 15:35, Lance Yang wrote:
>>
>>
>> On 2025/12/18 21:13, David Hildenbrand (Red Hat) wrote:
>>> On 12/13/25 09:00, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> Similar to the hugetlb PMD unsharing optimization, skip the second IPI
>>>> in collapse_huge_page() when the TLB flush already provides necessary
>>>> synchronization.
>>>>
>>>> Before commit a37259732a7d ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE
>>>> unconditional"), bare metal x86 didn't enable 
>>>> MMU_GATHER_RCU_TABLE_FREE.
>>>> In that configuration, tlb_remove_table_sync_one() was a NOP. GUP-fast
>>>> synchronization relied on IRQ disabling, which blocks TLB flush IPIs.
>>>>
>>>> When Rik made MMU_GATHER_RCU_TABLE_FREE unconditional to support AMD's
>>>> INVLPGB, all x86 systems started sending the second IPI. However, on
>>>> native x86 this is redundant:
>>>>
>>>>     - pmdp_collapse_flush() calls flush_tlb_range(), sending IPIs to 
>>>> all
>>>>       CPUs to invalidate TLB entries
>>>>
>>>>     - GUP-fast runs with IRQs disabled, so when the flush IPI 
>>>> completes,
>>>>       any concurrent GUP-fast must have finished
>>>>
>>>>     - tlb_remove_table_sync_one() provides no additional 
>>>> synchronization
>>>>
>>>> On x86, skip the second IPI when running native (without paravirt) and
>>>> without INVLPGB. For paravirt with non-native flush_tlb_multi and for
>>>> INVLPGB, conservatively keep both IPIs.
>>>>
>>>> Use tlb_table_flush_implies_ipi_broadcast(), consistent with the 
>>>> hugetlb
>>>> optimization.
>>>>
>>>> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>>    mm/khugepaged.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 97d1b2824386..06ea793a8190 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1178,7 +1178,12 @@ static int collapse_huge_page(struct mm_struct
>>>> *mm, unsigned long address,
>>>>        _pmd = pmdp_collapse_flush(vma, address, pmd);
>>>>        spin_unlock(pmd_ptl);
>>>>        mmu_notifier_invalidate_range_end(&range);
>>>> -    tlb_remove_table_sync_one();
>>>> +    /*
>>>> +     * Skip the second IPI if the TLB flush above already synchronized
>>>> +     * with concurrent GUP-fast via broadcast IPIs.
>>>> +     */
>>>> +    if (!tlb_table_flush_implies_ipi_broadcast())
>>>> +        tlb_remove_table_sync_one();
>>>
>>> We end up calling
>>>
>>>       flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>>
>>>       -> flush_tlb_mm_range(freed_tables = true)
>>>
>>>       -> flush_tlb_multi(mm_cpumask(mm), info);
>>>
>>> So freed_tables=true and we should be doing the right thing.
>>
>> Yep ;)
>>
>>> BTW, I was wondering whether we should embed that
>>> tlb_table_flush_implies_ipi_broadcast() check in
>>> tlb_remove_table_sync_one() instead.
>>> It then relies on the caller to do the right thing (flush with
>>> freed_tables=true or unshared_tables = true).
>>>
>>> Thoughts?
>>
>> Good point! Let me check the other callers to ensure they
>> are all preceded by a flush with freed_tables=true (or unshared_tables).
>>
>> Will get back to you with what I find :)
> 
> The use case in tlb_table_flush() is a bit confusing. But I would assume 
> that we have a TLB flush with remove_tables=true beforehand. Otherwise 
> we cannot possibly free the page table.

Right! I assume you meant freed_tables=true (not remove_tables) ;)

Verified all callers have proper TLB flushes *beforehand*:

-> 1. mm/khugepaged.c:1188 (collapse_huge_page)

	pmdp_collapse_flush(vma, address, pmd)
	-> flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE)
		-> flush_tlb_mm_range(mm, ..., freed_tables = true)
			-> flush_tlb_multi(mm_cpumask(mm), info)

So freed_tables=true and we should be doing the right thing :)

-> 2. include/asm-generic/tlb.h:861 (tlb_flush_unshared_tables)

	tlb_flush_mmu_tlbonly(tlb)
	-> tlb_flush(tlb)
		-> flush_tlb_mm_range(mm, ..., unshared_tables = true)
			-> flush_tlb_multi(mm_cpumask(mm), info)

unshared_tables=true (equivalent to freed_tables for sending IPIs).

-> 3. mm/mmu_gather.c:341 (__tlb_remove_table_one)

When we can't allocate a batch page in tlb_remove_table(), we do:

	tlb_table_invalidate(tlb)
	-> tlb_flush_mmu_tlbonly(tlb)
		-> flush_tlb_mm_range(mm, ..., freed_tables = true)
			-> flush_tlb_multi(mm_cpumask(mm), info)

	Then:
	tlb_remove_table_one(table)
	-> __tlb_remove_table_one(table) // if !CONFIG_PT_RECLAIM
		-> tlb_remove_table_sync_one()

freed_tables=true, and this should work too.

Why is tlb->freed_tables guaranteed? Because callers like pte_free_tlb()
(via free_pte_range) set freed_tables=true before calling __pte_free_tlb(),
which then calls tlb_remove_table(). As you mentioned, we cannot free page
tables without freed_tables=true.

Note that tlb_remove_table_sync_one() was a NOP on bare metal x86
(CONFIG_MMU_GATHER_RCU_TABLE_FREE=n) before commit a37259732a7d.

-> 4-5. mm/khugepaged.c:1683,1819 (pmdp_get_lockless_sync macro)

Same as #1.

So all callers satisfy the requirement! Will embed the check in v2.

Hopefully I didn't miss any callers ;)

Cheers,
Lance

