Return-Path: <linux-arch+bounces-15519-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F244CD02E7
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74575300E81A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918D31D362;
	Fri, 19 Dec 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxOhiDdn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436C23E342;
	Fri, 19 Dec 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152802; cv=none; b=lzaMPMqaWRYMtY9H7YF0tOurRVnPistsJ+c52ruJGwEzy0Al+HNAOA24WU0GvEOgrVDLLRnprpaqjw0/lhWieMYXpDZ9vRrMiyGD9vTsSpghbSJhf1FnptSizL7CgMN4fkQtGYa2y4z0U2VmaM1MLeTzA4SMSYe3RRSXyFNPDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152802; c=relaxed/simple;
	bh=JWaw934JDfHKlA5sInvUxyZBA437IYufIDK3wABOHk0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YIQbRS5FLwOIq4LwKi6Y4Pnb09boig6XvPwAshUGun/E8aWBUPYZJBAqMbzCdJWY0vm6vVbgdFgZ3oRTzIx7dzOK4h+5yaIIuhFR3EVGDNski3M5dwVY/b4bNuSs0tApjXP80qHyylJyWs/UWfx/xey1IsjGTKbECU3y6iRAAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxOhiDdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97208C4CEF1;
	Fri, 19 Dec 2025 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766152800;
	bh=JWaw934JDfHKlA5sInvUxyZBA437IYufIDK3wABOHk0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uxOhiDdn5eNZtMqBuJSX4ivs/799liqB+DIx8GXZ5MehitAvEfEXlwvU0Z3T30ohy
	 7n/Tz90frJB1NvwJWfQ9cdDH7w1OK7iDT3YNnXrSPrCdhacEajjJscD8a5d/1lGyg2
	 b3E/Lo5yexghi+PacPVmA31lfSLDo0JR1YTUbKOFQBvuvWMmWzFunAWO2DaKiM12nd
	 dNiN9smTTqUXTDkIa2G2nX9yBGpdDMiUjy+M6BYrVZf09gFJbjPRsQxMlIo5B4zJGj
	 cEXr3TOPYu9w0FdmzB1aLgRpI74Uo8kfewMV6tRbVHr/zKVm7vdOonj0CIrzSsJ80E
	 +pI+sn3yhU1+w==
Message-ID: <3d9ce821-a39d-4164-a225-fcbe790ea951@kernel.org>
Date: Fri, 19 Dec 2025 14:59:52 +0100
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
Content-Language: en-US
In-Reply-To: <d5bf88d9-aedf-4e6d-b5a0-e860bf0ed2e4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 14:52, David Hildenbrand (Red Hat) wrote:
> On 12/19/25 13:37, Harry Yoo wrote:
>> On Fri, Dec 12, 2025 at 08:10:19AM +0100, David Hildenbrand (Red Hat) wrote:
>>> As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
>>> huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
>>> where we perform so many IPI broadcasts when unsharing hugetlb PMD page
>>> tables that it severely regresses some workloads.
>>>
>>> In particular, when we fork()+exit(), or when we munmap() a large
>>> area backed by many shared PMD tables, we perform one IPI broadcast per
>>> unshared PMD table.
>>>
>>
>> [...snip...]
>>
>>> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
>>> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
>>> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
>>> Tested-by: Laurence Oberman <loberman@redhat.com>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>>> ---
>>>    include/asm-generic/tlb.h |  74 ++++++++++++++++++++++-
>>>    include/linux/hugetlb.h   |  19 +++---
>>>    mm/hugetlb.c              | 121 ++++++++++++++++++++++----------------
>>>    mm/mmu_gather.c           |   7 +++
>>>    mm/mprotect.c             |   2 +-
>>>    mm/rmap.c                 |  25 +++++---
>>>    6 files changed, 179 insertions(+), 69 deletions(-)
>>>
>>> @@ -6522,22 +6511,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>>>    				pte = huge_pte_clear_uffd_wp(pte);
>>>    			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
>>>    			pages++;
>>> +			tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
>>>    		}
>>>    
>>>    next:
>>>    		spin_unlock(ptl);
>>>    		cond_resched();
>>>    	}
>>> -	/*
>>> -	 * There is nothing protecting a previously-shared page table that we
>>> -	 * unshared through huge_pmd_unshare() from getting freed after we
>>> -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
>>> -	 * succeeded, flush the range corresponding to the pud.
>>> -	 */
>>> -	if (shared_pmd)
>>> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
>>> -	else
>>> -		flush_hugetlb_tlb_range(vma, start, end);
>>> +
>>> +	tlb_flush_mmu_tlbonly(tlb);
>>> +	huge_pmd_unshare_flush(tlb, vma);
>>
>> Shouldn't we teach mmu_gather that it has to call
> 
> I hope not :) In the worst case we could keep the
> flush_hugetlb_tlb_range() in the !shared case in. Suboptimal but I am
> sick and tired of dealing with this hugetlb mess.
> 
> 
> Let me CC Ryan and Catalin for the arm64 pieces and Christophe on the
> ppc pieces: See [1] where we convert away from some
> flush_hugetlb_tlb_range() users to operate on mmu_gather using
> * tlb_remove_huge_tlb_entry() for mremap() and mprotect(). Before we
>     would only use it in __unmap_hugepage_range().
> * tlb_flush_pmd_range() for unsharing of shared PMD tables. We already
>     used that in one call path.

To clarify, powerpc does not select ARCH_WANT_HUGE_PMD_SHARE, so the 
second change does not apply to ppc.

-- 
Cheers

David

