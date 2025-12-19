Return-Path: <linux-arch+bounces-15518-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48CACD02C9
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 14:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F233309F23C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F122D29B7;
	Fri, 19 Dec 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZTh/akB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA72153FB;
	Fri, 19 Dec 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152370; cv=none; b=kwjpiVlgIH/NbjiNYRkLPM7q3fO3WidP6z9+ZwZdxRHioW0whkMsY2Rs31nwpwxQFM6qqwOzWXeNWj5olu9V2cqGyVdL1Iy/vze9Pkoz0zRiF3YdI1x4NhpaFkUfD+tHt6csien7NJB00ZbCjovgGhOiTr0LaGukkyxMBpeuve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152370; c=relaxed/simple;
	bh=kp11YU2QH+WTDS76e4SebHd/dxUjhu1pW98eOwe8K0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXPklWEltYV+HoySDVpxDi9ive2pSRlMP7uZWVrv5FrFWV1EUqLIThRv1ewlsqb6AihtovZagMUOVyf037VIczLceJQqA6MHz1cIk9eu8UGfcdiOwz08Se2huqsdH5ckjuK1kWCNoyHmIqszwqI/RA+tFaNW69fpo6kaahOeWXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZTh/akB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840A5C4CEF1;
	Fri, 19 Dec 2025 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766152369;
	bh=kp11YU2QH+WTDS76e4SebHd/dxUjhu1pW98eOwe8K0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BZTh/akBrk0EFUsB0mnnrGI4bSdbDF3g3y2Tib8PutDKdve9TMuIWjcv9u2LLNdIX
	 ADG1T0x8r9IcGlyAB5/mldOvYLs5PCnr+afNXRsNJvt+VsnshEE3B7EhHkawPk/Bdy
	 S8FORjtngC0ok6jYoVShmyBc4dYpbN45kXgzzGtFXA4LOp8ChVkABePp5Bj9KN6NTi
	 WwpW+GdParMGATH8cbUsN4GqanpHT5ornzR3FJFIqS/7duGdYRphCyiiTquvWaMA8h
	 8fNb0YcKhcskSfvgYd7X5jdCHEkSirsMW40Bi0pn+61Me+MMQYToQG/Xxu8mLzUeEK
	 pQ1h0rbMtfKRA==
Message-ID: <d5bf88d9-aedf-4e6d-b5a0-e860bf0ed2e4@kernel.org>
Date: Fri, 19 Dec 2025 14:52:41 +0100
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
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aUVHAD9G5_HKlYsR@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 13:37, Harry Yoo wrote:
> On Fri, Dec 12, 2025 at 08:10:19AM +0100, David Hildenbrand (Red Hat) wrote:
>> As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
>> huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
>> where we perform so many IPI broadcasts when unsharing hugetlb PMD page
>> tables that it severely regresses some workloads.
>>
>> In particular, when we fork()+exit(), or when we munmap() a large
>> area backed by many shared PMD tables, we perform one IPI broadcast per
>> unshared PMD table.
>>
> 
> [...snip...]
> 
>> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
>> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
>> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
>> Tested-by: Laurence Oberman <loberman@redhat.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> ---
>>   include/asm-generic/tlb.h |  74 ++++++++++++++++++++++-
>>   include/linux/hugetlb.h   |  19 +++---
>>   mm/hugetlb.c              | 121 ++++++++++++++++++++++----------------
>>   mm/mmu_gather.c           |   7 +++
>>   mm/mprotect.c             |   2 +-
>>   mm/rmap.c                 |  25 +++++---
>>   6 files changed, 179 insertions(+), 69 deletions(-)
>>
>> @@ -6522,22 +6511,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>>   				pte = huge_pte_clear_uffd_wp(pte);
>>   			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
>>   			pages++;
>> +			tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
>>   		}
>>   
>>   next:
>>   		spin_unlock(ptl);
>>   		cond_resched();
>>   	}
>> -	/*
>> -	 * There is nothing protecting a previously-shared page table that we
>> -	 * unshared through huge_pmd_unshare() from getting freed after we
>> -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
>> -	 * succeeded, flush the range corresponding to the pud.
>> -	 */
>> -	if (shared_pmd)
>> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
>> -	else
>> -		flush_hugetlb_tlb_range(vma, start, end);
>> +
>> +	tlb_flush_mmu_tlbonly(tlb);
>> +	huge_pmd_unshare_flush(tlb, vma);
> 
> Shouldn't we teach mmu_gather that it has to call

I hope not :) In the worst case we could keep the 
flush_hugetlb_tlb_range() in the !shared case in. Suboptimal but I am 
sick and tired of dealing with this hugetlb mess.


Let me CC Ryan and Catalin for the arm64 pieces and Christophe on the 
ppc pieces: See [1] where we convert away from some 
flush_hugetlb_tlb_range() users to operate on mmu_gather using
* tlb_remove_huge_tlb_entry() for mremap() and mprotect(). Before we
   would only use it in __unmap_hugepage_range().
* tlb_flush_pmd_range() for unsharing of shared PMD tables. We already
   used that in one call path.

[1] https://lore.kernel.org/all/20251212071019.471146-5-david@kernel.org/


> flush_hugetlb_tlb_range() instead of ordinary TLB flush routine,
> otherwise it will break ARCHes that has "special requirements"
> for evicting hugetlb backing TLB entries?

Yeah, I was briefly wondering about that myself (and the inconsistency 
we had in the code). I would hope that we're good, but maybe there are 
some nasty corner cases we're missing. So thanks for raising that.


Given tlb_remove_huge_tlb_entry() exist (and is already getting used) I 
would assume that it does the right thing.

In tlb_unshare_pmd_ptdesc(), I am now using tlb_flush_pmd_range(), 
because we know that we are dealing with PMD-sized hugetlb folios.

And in fact, we were already doing that in case of 
__unmap_hugepage_range(), where we did exactly what I do now:

	tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);

So, again, something would already be broken there unless I am missing 
something important.


Looking at it, I wonder whether we must do the 
tlb_remove_huge_tlb_entry() in move_hugetlb_page_tables() after the
move_huge_pte(). Looks like tlb_remove_huge_tlb_entry() might do some 
flushing on ppc (and not just updating the mmu_gather) through 
__tlb_remove_tlb_entry(). But it's a bit confusing.

-- 
Cheers

David

