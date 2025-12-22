Return-Path: <linux-arch+bounces-15531-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE5ECD578C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 11:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAD7C300F96D
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E245312830;
	Mon, 22 Dec 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glwFxBeJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60691301002;
	Mon, 22 Dec 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398239; cv=none; b=HOt8+uQev/ea0TAbv4SZqyYswKPGoKzy+xcrgBKqHnLAzQHARqOeDUUsrFE9mnl9B1mLCMxKTi6SQMEG5IJj3eSkboXeBDf4Z80N+NNFUFcyR5xYfgQQzmSSbrUPCr+0xs5k1SUFwwfvrsVTfNMePdjaih++rOTMgcOLcdH1vaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398239; c=relaxed/simple;
	bh=oqvDU7EcxPgLIt7kqJ6tUYvc7fh9oOd7r5g2Qh/KjTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vew6eDv1QeH+ja+dHmmWPwW7yX/LCZ7q5bt1twNionCwJxD/puB96q9znmO1fdJV4UEHaqH/lG2jTLxyKjlZhZEm32EXe+bIR9IbD64pi5Mc5UwMFaqr4xxL+0mFXcC3v+XXgAaJUjirDKOGwGCNG7zR6eaz/yzhSDBIYqfhwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glwFxBeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1F7C116D0;
	Mon, 22 Dec 2025 10:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766398238;
	bh=oqvDU7EcxPgLIt7kqJ6tUYvc7fh9oOd7r5g2Qh/KjTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=glwFxBeJHfy/Hxw8E0IhkNQF2D75sUaWPBU97dBGqQz6RmNddi4AuNDGVRXl11MW5
	 /2XRcRjtcuW+PNO3XYgXDly/+1nqW71Z8wNkiivCJ3Jg7vi/qaEUg8J4toGx7nqkkz
	 RC2z+fWsSeanfTQwGH23Y6Vf5tNpm4TWdbplzUT0YtbQ8eTMrchSyhXYxYhA/YeQFZ
	 OPRiIuCw/OtPCmBpFpOqhk6zayMlQB8WgR7rXpsqEZFJyUY/Z+c80MqXHtj/CR8vcF
	 w1ay/Q/COiczt1kmwNYCUFJSSQcNJyIAUj3oSuM1C7TYwA6NT4ooYHb4wIaUUIsZFD
	 XSI866D9bbWPg==
Message-ID: <c66cb4e4-820e-419a-ae9f-efd2c15aa570@kernel.org>
Date: Mon, 22 Dec 2025 11:10:32 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
To: Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-5-david@kernel.org> <aUVHAD9G5_HKlYsR@hyeyoo>
 <d5bf88d9-aedf-4e6d-b5a0-e860bf0ed2e4@kernel.org>
 <3d9ce821-a39d-4164-a225-fcbe790ea951@kernel.org>
 <e78f5457-43fb-4656-ad53-bfda72936ef5@kernel.org> <aUioS4dkTrKgsHGP@hyeyoo>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aUioS4dkTrKgsHGP@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Okay, the existing hugetlb mmu_gather integration is hell on earth.
>>
>> I *think* to get everything right (work around all the hacks we have) we might have to do a
>>
>> 	tlb_change_page_size(tlb, sz);
>> 	tlb_start_vma(tlb, vma);
>>
>> before adding something to the tlb and a tlb_end_vma(tlb, vma) if we
>> don't immediately call tlb_finish_mmu() already.
> 
> Good point, indeed!
> 
>> tlb_change_page_size() will set page_size accordingly (as required for
>> ppc IIUC).
> 
> Right. PPC wants to flush TLB when the page size changes.
> 
>> tlb_start_vma()->tlb_update_vma_flags() will set tlb->vma_huge for ...
>> some very good reason I am sure.
> 
> :)
> 
>> So something like the following might do the trick:
>>
>>  From b0b854c2f91ce0931e1462774c92015183fb5b52 Mon Sep 17 00:00:00 2001
>> From: "David Hildenbrand (Red Hat)" <david@kernel.org>
>> Date: Sun, 21 Dec 2025 12:57:43 +0100
>> Subject: [PATCH] tmp
>>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> ---
>>   mm/hugetlb.c | 12 +++++++++++-
>>   mm/rmap.c    |  4 ++++
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 7fef0b94b5d1e..14521210181c9 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5113,6 +5113,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>>   	/* Prevent race with file truncation */
>>   	hugetlb_vma_lock_write(vma);
>>   	i_mmap_lock_write(mapping);
>> +
>> +	tlb_change_page_size(&tlb, sz);
>> +	tlb_start_vma(&tlb, vma);
>>   	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
>>   		src_pte = hugetlb_walk(vma, old_addr, sz);
>>   		if (!src_pte) {
>> @@ -5128,13 +5131,13 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>>   			new_addr |= last_addr_mask;
>>   			continue;
>>   		}
>> -		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
>>   		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
>>   		if (!dst_pte)
>>   			break;
>>   		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
>> +		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
>>   	}
>>   	tlb_flush_mmu_tlbonly(&tlb);
>> @@ -6416,6 +6419,8 @@ long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vm
>>   	BUG_ON(address >= end);
>>   	flush_cache_range(vma, range.start, range.end);
>> +	tlb_change_page_size(tlb, psize);
>> +	tlb_start_vma(tlb, vma);
>>   	mmu_notifier_invalidate_range_start(&range);
>>   	hugetlb_vma_lock_write(vma);
>> @@ -6532,6 +6537,8 @@ long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vm
>>   	hugetlb_vma_unlock_write(vma);
>>   	mmu_notifier_invalidate_range_end(&range);
>> +	tlb_end_vma(tlb, vma);
>> +
>>   	return pages > 0 ? (pages << h->order) : pages;
>>   }
>> @@ -7259,6 +7266,9 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>>   	} else {
>>   		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>>   	}
>> +
>> +	tlb_change_page_size(&tlb, sz);
>> +	tlb_start_vma(&tlb, vma);
>>   	for (address = start; address < end; address += PUD_SIZE) {
>>   		ptep = hugetlb_walk(vma, address, sz);
>>   		if (!ptep)
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index d6799afe11147..27210bc6fb489 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2015,6 +2015,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   					goto walk_abort;
>>   				tlb_gather_mmu(&tlb, mm);
>> +				tlb_change_page_size(&tlb, huge_page_size(hstate_vma(vma)));
>> +				tlb_start_vma(&tlb, vma);
>>   				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
>>   					hugetlb_vma_unlock_write(vma);
>>   					huge_pmd_unshare_flush(&tlb, vma);
>> @@ -2413,6 +2415,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>   				}
>>   				tlb_gather_mmu(&tlb, mm);
>> +				tlb_change_page_size(&tlb, huge_page_size(hstate_vma(vma)));
>> +				tlb_start_vma(&tlb, vma);
>>   				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
>>   					hugetlb_vma_unlock_write(vma);
>>   					huge_pmd_unshare_flush(&tlb, vma);
>> -- 
>> 2.52.0
>>
>>
>>
>> But now I'm staring at it and wonder whether we should just defer the TLB flushing changes
>> to a later point and only focus on the IPI flushes.
> 
> You mean defer TLB flushing to which point? For unmapping or
> changing permission of VMAs, flushing at VMA boundary already makes sense?

Defer converting to mmu_gather to a later patch set :)

I gave it a try yesterday, but it's also a bit ugly.

In the code above, primarily the rmap change is nasty.

> 
> Or if you meant batching TLB flushes in try_to_{migrate,unmap}_one()...
> 
> /me starts wondering...
> 
> "Hmm... for RMAP, we already have TLB flush batching
>   via struct tlbflush_unmap_batch. Why not use this framework
>   when unmapping shared hugetlb pages as well?"

Hm, also not what we really want in most cases. I don't think we should 
be using that outside of rmap.c (and I have the gut feeling that we 
should maybe make use of mmu_gather in there instead at some point).

Let me try a bit to see if I can clean the code here up, or if I just 
add a temporary custom batching data structure.

Thanks for bringing this up!

-- 
Cheers

David

