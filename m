Return-Path: <linux-arch+bounces-15334-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB37CB48E3
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 03:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5176300B988
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 02:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F425C704;
	Thu, 11 Dec 2025 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6l4T5Th"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2C3B8D67;
	Thu, 11 Dec 2025 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765420056; cv=none; b=o5d1wsPbFN7iTrDDrxaMTUNbydo0mUJh4LU0fx9QffNWYEMG+1U4DuUoT5dWKeQ4o7ybCJ8FXXfU/f1jNnL2rcy3zLKjJ8VPNXtKQVSj7NidDdBQZ5dW0szxUOHG0nAKTqOdv8YE11ejBGHej5M5iunAzWmqGHjDCvSh5fT9HOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765420056; c=relaxed/simple;
	bh=8GORaNEXq8uXBefaMnKYI3bxgG/PKfW93QgypZ3ERGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHVH9HlT6KgQGBreggFGOWrCNY9G82K7s/LgnVZkvTI8ENPiztnijG1BxTw31mA+fDx9r5Mx63BLIAEg6wVnR1DVi8k2+xwppSLTS+Qk8UVq8OlhvuVgyTEYzSctmTtBz9Xn2VRIklGcySsx6uYkYHRKi7qw4DhlEM3afSDHcAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6l4T5Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A49C4CEF1;
	Thu, 11 Dec 2025 02:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765420056;
	bh=8GORaNEXq8uXBefaMnKYI3bxgG/PKfW93QgypZ3ERGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S6l4T5ThQz0XdHnCjkgLCYDFafAUWnhtsoSb4pEiCKIpsA1a5HNfwagp9ikjr9ee9
	 s+e8D5Uag659pKXgTuBz+BWe7ZdyT3wZdl+lCopycrY/OsAA4+K3lV3iirETXp5maG
	 9XZsLm20ZYPnkZOCt8tfG1wM/TEp+87es+1Lq3otrffUkjPLrCCv79tlRo9hKC6GEH
	 B5BGM3YJajaN6uDknddxWY27GLJudYBVWCwPq4zt+GokeLsbHWKLR8Jzpi4YKP4PNb
	 S02yVs4Qq1FQ72CLKVNsH5qTbTLaVwLlr6UrZ5k1QaJM7qJZ3/7xPHa0JWxbuxyd4p
	 yZBmfYLGTii+w==
Message-ID: <9ac7c53e-04ae-49f3-976d-44d1e29587d1@kernel.org>
Date: Thu, 11 Dec 2025 03:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
 <c641335e-39aa-490a-b587-4a2586917bc9@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <c641335e-39aa-490a-b587-4a2586917bc9@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> (2) tlb_remove_table_sync_one() is not a NOP on architectures with
>>      CONFIG_MMU_GATHER_RCU_TABLE_FREE that actually don't need a sync.
>>
>>      Take x86 as an example: in the common case (!pv, !X86_FEATURE_INVLPGB)
>>      we still issue IPIs during TLB flushes and don't actually need the
>>      second tlb_remove_table_sync_one().
> 
> Hmm wasn't aware that x86 would still IPI even with
> CONFIG_MMU_GATHER_RCU_TABLE_FREE??
> 
> But then we'd have to set tlb->freed_tables and as per your above point
> maybe overkill...hm one for another time then I guess! :)

I have a prototype patch to handle that, Lance wants to look into 
polishing it up :)

[...]

>> +++ b/include/asm-generic/tlb.h
>> @@ -364,6 +364,17 @@ struct mmu_gather {
>>   	unsigned int		vma_huge : 1;
>>   	unsigned int		vma_pfn  : 1;
>>
>> +	/*
>> +	 * Did we unshare (unmap) any shared page tables?
> 
> Given mshare is incoming, maybe worth clarifying and being explicit about
> hugetlb in both comment and name?

I think we should instead call out mshare eplicitly, once we know what 
that would need here.

In general, I don't think we'll really use the "unshare" termonology a 
lot with mshare, as it's not really something transparent. In the mshare 
world it's simply an unmap in the mshare-owner MM. (mshare_detach 
similarly is rather a unmap operation)

Long story short: I'll lean towards keeping this here as it is and not 
creating even longer names.

> 
>> +	 */
>> +	unsigned int		unshared_tables : 1;
>> +
>> +	/*
>> +	 * Did we unshare any page tables such that they are now exclusive
>> +	 * and could get reused+modified by the new owner?
>> +	 */
>> +	unsigned int		fully_unshared_tables : 1;
> 
> Does fully_unshared_tables rely on unshared_tables also being set?

See below.

> 
>> +
>>   	unsigned int		batch_count;
>>
>>   #ifndef CONFIG_MMU_GATHER_NO_GATHER
>> @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>>   	tlb->cleared_pmds = 0;
>>   	tlb->cleared_puds = 0;
>>   	tlb->cleared_p4ds = 0;
>> +	tlb->unshared_tables = 0;
> 
> As Nadav points out, should also initialise fully_unshared_tables.

Right, but on an earlier init path, not on the range reset path here.

> 
>>   	/*
>>   	 * Do not reset mmu_gather::vma_* fields here, we do not
>>   	 * call into tlb_start_vma() again to set them if there is an
>> @@ -484,7 +496,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>>   	 * these bits.
>>   	 */
>>   	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
>> -	      tlb->cleared_puds || tlb->cleared_p4ds))
>> +	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->unshared_tables))
> 
> What about fully_unshared_tables? I guess though unshared_tables implies
> fully_unshared_tables.

fully_unshared_tables is only for triggering IPIs and consequently not 
about flushing TLBs.

The TLB part is taken care of by unshared_tables, and we will always set 
unshared_tables when unsharing any page tables (incl. fully unshared ones).


> 
>>   		return;
>>
>>   	tlb_flush(tlb);
>> @@ -773,6 +785,61 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
>>   }
>>   #endif
>>
>> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>> +static inline void tlb_unshare_pmd_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt,
>> +					  unsigned long addr)
>> +{
>> +	/*
>> +	 * The caller must make sure that concurrent unsharing + exclusive
>> +	 * reuse is impossible until tlb_flush_unshared_tables() was called.
>> +	 */
>> +	VM_WARN_ON_ONCE(!ptdesc_pmd_is_shared(pt));
>> +	ptdesc_pmd_pts_dec(pt);
>> +
>> +	/* Clearing a PUD pointing at a PMD table with PMD leaves. */
>> +	tlb_flush_pmd_range(tlb, addr & PUD_MASK, PUD_SIZE);
> 
> OK I guess before we were always flushing for each page, but now we are
> accumulating the flushes here.

Yes.

> 
>> +
>> +	/*
>> +	 * If the page table is now exclusively owned, we fully unshared
>> +	 * a page table.
>> +	 */
>> +	if (!ptdesc_pmd_is_shared(pt))
>> +		tlb->fully_unshared_tables = true;
>> +	tlb->unshared_tables = true;
>> +}
>> +
>> +static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
>> +{
>> +	/*
>> +	 * As soon as the caller drops locks to allow for reuse of
>> +	 * previously-shared tables, these tables could get modified and
>> +	 * even reused outside of hugetlb context. So flush the TLB now.
> 
> Hmm but you're doing this in both the case of unshare and fully unsharing, so is
> this the right place to make this comment?

That's why I start the comment below with "Similarly", to make it clear 
that the comments build up on each other.

But I'm afraid I might not be getting your point fully here :/

> 
> Surely here this is about flushing TLBs for the unsharer only as it no longer
> uses it?
> 
>> +	 *
>> +	 * Note that we cannot defer the flush to a later point even if we are
>> +	 * not the last sharer of the page table.
>> +	 */
> 
> Not hugely clear, some double negative here. Maybe worth saying something like:
> 
> 'Even if we are not fully unsharing a PMD table, we must flush the TLB for the
> unsharer who no longer has access to this memory'
> 
> Or something? Assuming this is accurate :)

I'll adjust it to "Not that even if we are not fully unsharing a PMD 
table, we must flush the TLB for the unsharer now.".

[...]

>> +		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
> 
> OK I guess we need to add these to cases where we remove previous entries
> because before we weren't accumulating TLB state except in
> __unmap_hugepage_range()?

Exactly.

> 
>>
>>   		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
>>   		if (!dst_pte)
>> @@ -5136,13 +5137,13 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>>   		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
>>   	}
>>
>> -	if (shared_pmd)
>> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
>> -	else
>> -		flush_hugetlb_tlb_range(vma, old_end - len, old_end);
>> +	tlb_flush_mmu_tlbonly(&tlb);
> 
> Maybe:
> 
> 	if (!tlb->unshared_tables)
> 		tlb_flush_mmu_tlbonly(&tlb);
> 
> To avoid doing that twice? Not sure if so important as will be noop second time
> though.

No,  see the existing code on the !shared path: we flush even if we 
didn't unshare anything, and I am not changing these semantics.

The huge_pmd_unshare_flush() will skip the second tlb_flush_mmu_tlbonly().

> 
>> +	huge_pmd_unshare_flush(&tlb, vma);
> 
> OK I guess the semantics are
> 
> huge_pmd_unshare() for everything that needs unsharing, accumulating tlb state...
> 
> huge_pmd_unshare_flush() to, err, flush :) followed by tlb_finish_mmu() obv, and
> with i_mmap lock held...


The tlb_finish_mmu() can be defered, as it's mostly for safety checks in 
the hugetlb usage here. For pure unsharing, huge_pmd_unshare_flush() 
will do any flushing early.

> 
>> +
>>   	mmu_notifier_invalidate_range_end(&range);
>>   	i_mmap_unlock_write(mapping);
>>   	hugetlb_vma_unlock_write(vma);
>> +	tlb_finish_mmu(&tlb);
> 
> Does it matter that the hugetlb VMA lock is gone when we invoke
> tlb_finish_mmu()? I'm guessing not.

It shouldn't, as it's mostly safety-checks only for our use case here.

> 
> Kinda wish we could wrap these start/end states, it's fiddly to know that
> you have to:
> 
> - call huge_pmd_unshare_flush()
> - release i_mmap lock
> - unlock vma hugetlb (ugh god don't even get me started on how that's implemented :)
> - call tlb_finish_mmu()
> 
> Obv. this kind of thing can be part of future cleanups

Yes, not messing with there here :)

[...]

>> +/*
>> + * huge_pmd_unshare_flush - Complete a sequence of huge_pmd_unshare() calls
>> + * @tlb: the current mmu_gather.
>> + * @vma: the vma covering the pmd table.
>> + *
>> + * Perform necessary TLB flushes or IPI broadcasts to synchronize PMD table
>> + * unsharing with concurrent page table walkers (TLB, GUP-fast, etc.).
>> + *
>> + * This function must be called after a sequence of huge_pmd_unshare()
>> + * calls while still holding the i_mmap_rwsem.
>> + */
>> +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
>> +{
>> +	/*
>> +	 * We must synchronize page table unsharing such that nobody will
>> +	 * try reusing a previously-shared page table while it might still
>> +	 * be in use by previous sharers (TLB, GUP_fast).
>> +	 */
>> +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>> +
> 
> Extreme nit: inconsistent newline here compared to elsewhere :)
> 
> Not even sure why I'm making this point tbh

Inconsistent with what exactly? I prefered separating the 
safety-check+comment that explains why we check for the lock from the 
actual logic that carries out the actual logic.

> 
>> +	tlb_flush_unshared_tables(tlb);
>> +}
>> +
>>   #else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
>>
>>   pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>> @@ -6947,12 +6957,16 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>>   	return NULL;
>>   }
>>
>> -int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>> -				unsigned long addr, pte_t *ptep)
>> +int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
>> +		unsigned long addr, pte_t *ptep)
>>   {
>>   	return 0;
>>   }
>>
>> +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
>> +{
>> +}
>> +
>>   void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>>   				unsigned long *start, unsigned long *end)
>>   {
>> @@ -7219,6 +7233,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>>   	unsigned long sz = huge_page_size(h);
>>   	struct mm_struct *mm = vma->vm_mm;
>>   	struct mmu_notifier_range range;
>> +	struct mmu_gather tlb;
>>   	unsigned long address;
>>   	spinlock_t *ptl;
>>   	pte_t *ptep;
>> @@ -7229,6 +7244,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>>   	if (start >= end)
>>   		return;
>>
>> +	tlb_gather_mmu(&tlb, mm);
>>   	flush_cache_range(vma, start, end);
>>   	/*
>>   	 * No need to call adjust_range_if_pmd_sharing_possible(), because
>> @@ -7248,10 +7264,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>>   		if (!ptep)
>>   			continue;
>>   		ptl = huge_pte_lock(h, mm, ptep);
>> -		huge_pmd_unshare(mm, vma, address, ptep);
>> +		huge_pmd_unshare(&tlb, vma, address, ptep);
>>   		spin_unlock(ptl);
>>   	}
>> -	flush_hugetlb_tlb_range(vma, start, end);
>> +	huge_pmd_unshare_flush(&tlb, vma);
>>   	if (take_locks) {
>>   		i_mmap_unlock_write(vma->vm_file->f_mapping);
>>   		hugetlb_vma_unlock_write(vma);
>> @@ -7261,6 +7277,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>>   	 * Documentation/mm/mmu_notifier.rst.
>>   	 */
>>   	mmu_notifier_invalidate_range_end(&range);
>> +	tlb_finish_mmu(&tlb);
> 
> Hmm, does it matter that if !take_locks, the i_mmap lock and hugetlb vma
> locks will still be held when tlb_finish_mmu() is invoked here? I'm
> guessing it has no bearing but just to be sure :)

See above regarding safety checks.

[...]

>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/migrate.h>
>> @@ -2008,13 +2008,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   			 * if unsuccessful.
>>   			 */
>>   			if (!anon) {
>> +				struct mmu_gather tlb;
>> +
>>   				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>>   				if (!hugetlb_vma_trylock_write(vma))
>>   					goto walk_abort;
>> -				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
>> +
>> +				tlb_gather_mmu(&tlb, mm);
>> +				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
>>   					hugetlb_vma_unlock_write(vma);
>> -					flush_tlb_range(vma,
>> -						range.start, range.end);
>> +					huge_pmd_unshare_flush(&tlb, vma);
>> +					tlb_finish_mmu(&tlb);
> 
> Not sure if it matters, but elsewhere you order the locks as:
> 
> - huge_pmd_unshare_flush()
> - release i_mmap lock
> - unlock vma hugetlb
> - call tlb_finish_mmu()
> 
> But here it's:
> 
> - unlock vma hugetlb
> - huge_pmd_unshare_flush()
> - call tlb_finish_mmu()
> - (later) release i_mmap lock
> 
> Does that matter in terms of lock inversions etc.?
> 

I had a cleanup patch to change some of that, but I decided to keep it 
has is for this series: flush the tlb and issue the IPI while we still 
hold the page table lock.

(no idea what the hugetlb vma locking even does here, and how it 
interacts with the existing TLB flush -- not touching that confusing bit 
:) )

Thanks for the review!

-- 
Cheers

David

