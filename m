Return-Path: <linux-arch+bounces-15527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF5CD4005
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 13:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01475300A374
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68D156F45;
	Sun, 21 Dec 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYt8izPK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DC8248B;
	Sun, 21 Dec 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766319893; cv=none; b=L9AelUwuPoa00oJWQXrWNMLVBpE7zGz1IjjfA86K1dmL1v7MyDVGkFpPxH9O1A9zhmYHnxe+XNVDjWx9Md6bfq7AxTVE+n22MeVzLZIUkL6gSXhPGcZkpHcAdnJE0UIcyk5WtYQbeD57HR+tXb54+O+NTJdu+Lh8CxZu5DmRYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766319893; c=relaxed/simple;
	bh=IqPxZ/9JKNcdTw/8izbbZYaeUpAAZSbuuFtctc/CLm4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VSoio/fCWSvilfrYPiXrS+VddWRKoSZj11jx2rxc/ImRwgIQmhTgE5HU3fnochE+oyiHMoWtl1O1WYuTB0V0V0XtcxKNGoq2sPic9fAdmVppDbnr7AZ6b8F3tV+e2y4uSJxA6pkuDjPKLTJMzjEH+5Zu++Y1Stl0oO++Px07S3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYt8izPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C2FC4CEFB;
	Sun, 21 Dec 2025 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766319892;
	bh=IqPxZ/9JKNcdTw/8izbbZYaeUpAAZSbuuFtctc/CLm4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=tYt8izPKSJbk40BHKx3r8/+AfFkFWB6BVc8qn87q5kjCcrluSk3OQJNpTrNlz3pGz
	 DVTfFdLV89tLr1ezgV+7vLlihUvuA378IKn4JVcIk8Vd2HqmYFraSVp1wXlhwwVUYv
	 KYmtrINYMvMG8zF0FMzl/iM5xYo3TmTpo1mhf6oe4IhZPB0c7eVXm7tiXMjR1bfC7e
	 MaBaRiCypuOwQ+QWAvt1jEyroS6nscvKF9dlRxn5hBTP4ley/8SO+EcSeW2SFyAIxQ
	 d5aCmShGfRuUxPG8OEeb0HMrBTwBc1XxpdDdafel8nJ2UY0Tp31U2apQoG75akVuFD
	 ZeQRrQZOBQ/Zw==
Message-ID: <e78f5457-43fb-4656-ad53-bfda72936ef5@kernel.org>
Date: Sun, 21 Dec 2025 13:24:44 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
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
Content-Language: en-US
In-Reply-To: <3d9ce821-a39d-4164-a225-fcbe790ea951@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 14:59, David Hildenbrand (Red Hat) wrote:
> On 12/19/25 14:52, David Hildenbrand (Red Hat) wrote:
>> On 12/19/25 13:37, Harry Yoo wrote:
>>> On Fri, Dec 12, 2025 at 08:10:19AM +0100, David Hildenbrand (Red Hat) wrote:
>>>> As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
>>>> huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
>>>> where we perform so many IPI broadcasts when unsharing hugetlb PMD page
>>>> tables that it severely regresses some workloads.
>>>>
>>>> In particular, when we fork()+exit(), or when we munmap() a large
>>>> area backed by many shared PMD tables, we perform one IPI broadcast per
>>>> unshared PMD table.
>>>>
>>>
>>> [...snip...]
>>>
>>>> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
>>>> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
>>>> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
>>>> Tested-by: Laurence Oberman <loberman@redhat.com>
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>>>> ---
>>>>     include/asm-generic/tlb.h |  74 ++++++++++++++++++++++-
>>>>     include/linux/hugetlb.h   |  19 +++---
>>>>     mm/hugetlb.c              | 121 ++++++++++++++++++++++----------------
>>>>     mm/mmu_gather.c           |   7 +++
>>>>     mm/mprotect.c             |   2 +-
>>>>     mm/rmap.c                 |  25 +++++---
>>>>     6 files changed, 179 insertions(+), 69 deletions(-)
>>>>
>>>> @@ -6522,22 +6511,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>>>>     				pte = huge_pte_clear_uffd_wp(pte);
>>>>     			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
>>>>     			pages++;
>>>> +			tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
>>>>     		}
>>>>     
>>>>     next:
>>>>     		spin_unlock(ptl);
>>>>     		cond_resched();
>>>>     	}
>>>> -	/*
>>>> -	 * There is nothing protecting a previously-shared page table that we
>>>> -	 * unshared through huge_pmd_unshare() from getting freed after we
>>>> -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
>>>> -	 * succeeded, flush the range corresponding to the pud.
>>>> -	 */
>>>> -	if (shared_pmd)
>>>> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
>>>> -	else
>>>> -		flush_hugetlb_tlb_range(vma, start, end);
>>>> +
>>>> +	tlb_flush_mmu_tlbonly(tlb);
>>>> +	huge_pmd_unshare_flush(tlb, vma);
>>>
>>> Shouldn't we teach mmu_gather that it has to call
>>
>> I hope not :) In the worst case we could keep the
>> flush_hugetlb_tlb_range() in the !shared case in. Suboptimal but I am
>> sick and tired of dealing with this hugetlb mess.
>>
>>
>> Let me CC Ryan and Catalin for the arm64 pieces and Christophe on the
>> ppc pieces: See [1] where we convert away from some
>> flush_hugetlb_tlb_range() users to operate on mmu_gather using
>> * tlb_remove_huge_tlb_entry() for mremap() and mprotect(). Before we
>>      would only use it in __unmap_hugepage_range().
>> * tlb_flush_pmd_range() for unsharing of shared PMD tables. We already
>>      used that in one call path.
> 
> To clarify, powerpc does not select ARCH_WANT_HUGE_PMD_SHARE, so the
> second change does not apply to ppc.
> 

Okay, the existing hugetlb mmu_gather integration is hell on earth.

I *think* to get everything right (work around all the hacks we have) we might have to do a

	tlb_change_page_size(tlb, sz);
	tlb_start_vma(tlb, vma);

before adding something to the tlb and a tlb_end_vma(tlb, vma) if we
don't immediately call tlb_finish_mmu() already.

tlb_change_page_size() will set page_size accordingly (as required for
ppc IIUC).

tlb_start_vma()->tlb_update_vma_flags() will set tlb->vma_huge for ...
some very good reason I am sure.


So something like the following might do the trick:

 From b0b854c2f91ce0931e1462774c92015183fb5b52 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Date: Sun, 21 Dec 2025 12:57:43 +0100
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
  mm/hugetlb.c | 12 +++++++++++-
  mm/rmap.c    |  4 ++++
  2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7fef0b94b5d1e..14521210181c9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5113,6 +5113,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
  	/* Prevent race with file truncation */
  	hugetlb_vma_lock_write(vma);
  	i_mmap_lock_write(mapping);
+
+	tlb_change_page_size(&tlb, sz);
+	tlb_start_vma(&tlb, vma);
  	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
  		src_pte = hugetlb_walk(vma, old_addr, sz);
  		if (!src_pte) {
@@ -5128,13 +5131,13 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
  			new_addr |= last_addr_mask;
  			continue;
  		}
-		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
  
  		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
  		if (!dst_pte)
  			break;
  
  		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
+		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
  	}
  
  	tlb_flush_mmu_tlbonly(&tlb);
@@ -6416,6 +6419,8 @@ long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vm
  
  	BUG_ON(address >= end);
  	flush_cache_range(vma, range.start, range.end);
+	tlb_change_page_size(tlb, psize);
+	tlb_start_vma(tlb, vma);
  
  	mmu_notifier_invalidate_range_start(&range);
  	hugetlb_vma_lock_write(vma);
@@ -6532,6 +6537,8 @@ long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vm
  	hugetlb_vma_unlock_write(vma);
  	mmu_notifier_invalidate_range_end(&range);
  
+	tlb_end_vma(tlb, vma);
+
  	return pages > 0 ? (pages << h->order) : pages;
  }
  
@@ -7259,6 +7266,9 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
  	} else {
  		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
  	}
+
+	tlb_change_page_size(&tlb, sz);
+	tlb_start_vma(&tlb, vma);
  	for (address = start; address < end; address += PUD_SIZE) {
  		ptep = hugetlb_walk(vma, address, sz);
  		if (!ptep)
diff --git a/mm/rmap.c b/mm/rmap.c
index d6799afe11147..27210bc6fb489 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2015,6 +2015,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
  					goto walk_abort;
  
  				tlb_gather_mmu(&tlb, mm);
+				tlb_change_page_size(&tlb, huge_page_size(hstate_vma(vma)));
+				tlb_start_vma(&tlb, vma);
  				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
  					hugetlb_vma_unlock_write(vma);
  					huge_pmd_unshare_flush(&tlb, vma);
@@ -2413,6 +2415,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
  				}
  
  				tlb_gather_mmu(&tlb, mm);
+				tlb_change_page_size(&tlb, huge_page_size(hstate_vma(vma)));
+				tlb_start_vma(&tlb, vma);
  				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
  					hugetlb_vma_unlock_write(vma);
  					huge_pmd_unshare_flush(&tlb, vma);
-- 
2.52.0



But now I'm staring at it and wonder whether we should just defer the TLB flushing changes
to a later point and only focus on the IPI flushes. Doing only that with mmu_gather
looks *really* weird, and I don't want to introduce some other mechanism just for that
batching purpose.

Hm ...

-- 
Cheers

David

