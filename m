Return-Path: <linux-arch+bounces-15513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444FCCEF65
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 09:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE1E5300764C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B128934F;
	Fri, 19 Dec 2025 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0IbDoos"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDE274B3C;
	Fri, 19 Dec 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132752; cv=none; b=ggMJbJS/gc1DmmQDR9+Sfj+IitBL+m55ZyoqC++yEiwyyGvI2HnMHhKPlzIzUg5BmGAS5D/9WDMu71/c/6QAfr39NKBGek//0yzBa3jslubKfP6bjr9b+XHUr3Ebt43pR5TVKr5zFl1edhoNbeFde3ufpYyZkeCJyDgJSQouiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132752; c=relaxed/simple;
	bh=/RRZ3mRSlbHOY3u6KA/2jGTrq8Qaxhr/c/ozcV+Y+Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS9afc6Sjh+K1DuADaJTi2fyrBisnpFtQ7cc0Og9+P+mE9p22/HsaF9CK+EobwGMwOZ+/K3YY4/VDF5kYB4XGAidunON7NW/fOFIb6fvlqnUTm6vmwbitBJ/eEYyzPt/o5gju61zmPtT9KKMsNoGlju1MR4s1RpjpLrvEfq4EVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0IbDoos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870E8C4CEF1;
	Fri, 19 Dec 2025 08:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766132752;
	bh=/RRZ3mRSlbHOY3u6KA/2jGTrq8Qaxhr/c/ozcV+Y+Fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f0IbDoosSzUY1ZyRHNqb732zfUiSXMvzWpxfK/unVQgAuPAwYWbNvqyCsfYWR5fit
	 7+x6bgUuA3CtH3n0GAiOZL9xk/LUcL45zYnr8neQPOgJmqRyuHRUXmN9KjwkF4/Em/
	 X5CM7WgFFQ4dCoKXPcyKh4BCKw5LCWWQhw9lRKCo0KAMJ1h2QwhHQq82iaCQMCm0ye
	 wqoEM3v8Sx0pioqN8h1Y0r7hLBMCbHwEstBASeMw6n4X9rlqwiuTd6EnP3fE6I5lXH
	 UlQ48qppsN89wNNrss1UqRXly3H5rtZ6QBQkUOt8ix1v5B1mqVfRl873piLgi80d/a
	 6+kU8A1On/9mw==
Message-ID: <6dcfeb2a-dba6-4de9-ac1b-39312c6bbcb6@kernel.org>
Date: Fri, 19 Dec 2025 09:25:38 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] mm/khugepaged: skip redundant IPI in
 collapse_huge_page()
To: Lance Yang <lance.yang@linux.dev>
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
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <6fdf89ee-3f6a-420f-b4d6-b03e3e2c8c9b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 15:35, Lance Yang wrote:
> 
> 
> On 2025/12/18 21:13, David Hildenbrand (Red Hat) wrote:
>> On 12/13/25 09:00, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> Similar to the hugetlb PMD unsharing optimization, skip the second IPI
>>> in collapse_huge_page() when the TLB flush already provides necessary
>>> synchronization.
>>>
>>> Before commit a37259732a7d ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE
>>> unconditional"), bare metal x86 didn't enable MMU_GATHER_RCU_TABLE_FREE.
>>> In that configuration, tlb_remove_table_sync_one() was a NOP. GUP-fast
>>> synchronization relied on IRQ disabling, which blocks TLB flush IPIs.
>>>
>>> When Rik made MMU_GATHER_RCU_TABLE_FREE unconditional to support AMD's
>>> INVLPGB, all x86 systems started sending the second IPI. However, on
>>> native x86 this is redundant:
>>>
>>>     - pmdp_collapse_flush() calls flush_tlb_range(), sending IPIs to all
>>>       CPUs to invalidate TLB entries
>>>
>>>     - GUP-fast runs with IRQs disabled, so when the flush IPI completes,
>>>       any concurrent GUP-fast must have finished
>>>
>>>     - tlb_remove_table_sync_one() provides no additional synchronization
>>>
>>> On x86, skip the second IPI when running native (without paravirt) and
>>> without INVLPGB. For paravirt with non-native flush_tlb_multi and for
>>> INVLPGB, conservatively keep both IPIs.
>>>
>>> Use tlb_table_flush_implies_ipi_broadcast(), consistent with the hugetlb
>>> optimization.
>>>
>>> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>>    mm/khugepaged.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 97d1b2824386..06ea793a8190 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1178,7 +1178,12 @@ static int collapse_huge_page(struct mm_struct
>>> *mm, unsigned long address,
>>>        _pmd = pmdp_collapse_flush(vma, address, pmd);
>>>        spin_unlock(pmd_ptl);
>>>        mmu_notifier_invalidate_range_end(&range);
>>> -    tlb_remove_table_sync_one();
>>> +    /*
>>> +     * Skip the second IPI if the TLB flush above already synchronized
>>> +     * with concurrent GUP-fast via broadcast IPIs.
>>> +     */
>>> +    if (!tlb_table_flush_implies_ipi_broadcast())
>>> +        tlb_remove_table_sync_one();
>>
>> We end up calling
>>
>>       flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>
>>       -> flush_tlb_mm_range(freed_tables = true)
>>
>>       -> flush_tlb_multi(mm_cpumask(mm), info);
>>
>> So freed_tables=true and we should be doing the right thing.
> 
> Yep ;)
> 
>> BTW, I was wondering whether we should embed that
>> tlb_table_flush_implies_ipi_broadcast() check in
>> tlb_remove_table_sync_one() instead.
>> It then relies on the caller to do the right thing (flush with
>> freed_tables=true or unshared_tables = true).
>>
>> Thoughts?
> 
> Good point! Let me check the other callers to ensure they
> are all preceded by a flush with freed_tables=true (or unshared_tables).
> 
> Will get back to you with what I find :)

The use case in tlb_table_flush() is a bit confusing. But I would assume 
that we have a TLB flush with remove_tables=true beforehand. Otherwise 
we cannot possibly free the page table.

-- 
Cheers

David

