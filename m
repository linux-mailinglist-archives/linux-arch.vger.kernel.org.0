Return-Path: <linux-arch+bounces-15520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1360CD03CF
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 15:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65EB5303AC9A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293BD32C942;
	Fri, 19 Dec 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIqhcCbk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019CA32C927;
	Fri, 19 Dec 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153617; cv=none; b=d3zrVgRoSNL+b1iZ9bTFjDXUil6XrPWE5mEP2MKSWmga+iC73HMalHG/mYPfH80SWPRlF/c9ecJKa19kg/q3gIyJJEv38M9v+6ph4WM+FipSzKDJDfeUZ3FGMl2yvmpMfMnckXYoZ3Qv/UkzClO5mTn+nI9c3varzZPYVbaopRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153617; c=relaxed/simple;
	bh=CrkOtUOzG/C+S+bRb/2kdsA2273FJPK3WzL22ob66m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dA+RV2ElP1kzYmk5Ox3IrDVArwxaMppguNTQW5rcMjJtZ7A2/Y1sNi7EZqsU6cJl4qfBQtE4l+gnbvkFQfQI7FEt+jfF4eQmyEU0mhB+3gQM8Eot7SmopAYherovjJ4qMTxsTFZ8sV9rXOQr+g5R7yQKEYQI/y3HsYQ5zBo5yQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIqhcCbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BDAC4CEF1;
	Fri, 19 Dec 2025 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766153616;
	bh=CrkOtUOzG/C+S+bRb/2kdsA2273FJPK3WzL22ob66m4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SIqhcCbk/SIwcMNfwkO6NCQwBss4ZaAM97VIiSj20QW7XS2NrW7NOulPhtZLJtp08
	 e1nUzeZMB9O+iEtSi9d+ad1kpcgyEEk+gEs5ef2H24VnyJnsiVOa8YM3Q3vATXR/R0
	 TIy+DQ2c1E5KfOjFRk0ilcCxMgA+evAqU7CKjKSWrtcur5CbfPifNIqgbxqlTnDDGm
	 vjEOJEdsszmmqzRVBKQMUVBWFC7cXbFWjU5Anz+tYT2JGXTRJtpzurxX0MeTxlAu23
	 IoK3jhKkWRbgImICt9oH22aSiG/bSE9HalI4KLa5l+jYAO7gCqLdrg0rKIY/R3ob4l
	 xQXQJRZfwTm9A==
Message-ID: <2bbe1e49-95ba-42ea-b6af-5eeb61d68c4c@kernel.org>
Date: Fri, 19 Dec 2025 15:13:29 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
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
 Nadav Amit <nadav.amit@gmail.com>, Liu Shixin <liushixin2@huawei.com>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-3-david@kernel.org> <aUTYE9fHf5Fq3eHa@hyeyoo>
 <506fef86-5c3b-490e-94f9-2eb6c9c47834@kernel.org> <aUU1DY4206FibsLf@hyeyoo>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aUU1DY4206FibsLf@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 12:20, Harry Yoo wrote:
> On Fri, Dec 19, 2025 at 07:11:00AM +0100, David Hildenbrand (Red Hat) wrote:
>> On 12/19/25 05:44, Harry Yoo wrote:
>>> On Fri, Dec 12, 2025 at 08:10:17AM +0100, David Hildenbrand (Red Hat) wrote:
>>>> Ever since we stopped using the page count to detect shared PMD
>>>> page tables, these comments are outdated.
>>>>
>>>> The only reason we have to flush the TLB early is because once we drop
>>>> the i_mmap_rwsem, the previously shared page table could get freed (to
>>>> then get reallocated and used for other purpose). So we really have to
>>>> flush the TLB before that could happen.
>>>>
>>>> So let's simplify the comments a bit.
>>>>
>>>> The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
>>>> part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
>>>> correctly after huge_pmd_unshare") was confusing: sure it is recorded
>>>> in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
>>>> anything. So let's drop that comment while at it as well.
>>>>
>>>> We'll centralize these comments in a single helper as we rework the code
>>>> next.
>>>>
>>>> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
>>>> Reviewed-by: Rik van Riel <riel@surriel.com>
>>>> Tested-by: Laurence Oberman <loberman@redhat.com>
>>>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Acked-by: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Liu Shixin <liushixin2@huawei.com>
>>>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>>>> ---
>>>
>>> Looks good to me,
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>>
>>> with a question below.
>>
>> Hi Harry,
>>
>> thanks for the review!
> 
> No problem!
> I would love to review more, as long as my time & ability allows ;)
> 
>>>>    mm/hugetlb.c | 24 ++++++++----------------
>>>>    1 file changed, 8 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 51273baec9e5d..3c77cdef12a32 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>>    	tlb_end_vma(tlb, vma);
>>>>    	/*
>>>> -	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
>>>> -	 * could defer the flush until now, since by holding i_mmap_rwsem we
>>>> -	 * guaranteed that the last reference would not be dropped. But we must
>>>> -	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
>>>> -	 * dropped and the last reference to the shared PMDs page might be
>>>> -	 * dropped as well.
>>>> -	 *
>>>> -	 * In theory we could defer the freeing of the PMD pages as well, but
>>>> -	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
>>>> -	 * detect sharing, so we cannot defer the release of the page either.
>>>> -	 * Instead, do flush now.
>>>
>>> Does this mean we can now try defer-freeing of these page tables,
>>> and if so, would it be worth it?
>>
>> There is one very tricky thing:
>>
>> Whoever is the last owner of a (previously) shared page table must unmap any
>> contained pages (adjust mapcount/ref, sync a/d bit, ...).
> 
> Right.
> 
>> So it's not just a matter of deferring the freeing, because these page tables
>> will still contain content.
> 
> I was (and maybe still) bit confused while reading the old comment as
> it implied (or maybe I just misread) that by deferring freeing of page tables
> we don't have to flush TLB in __unmap_hugepage_range() and can flush later
> instead.

Yeah, I am also confused by the old comment. I think the idea there was 
to drop the reference only later and thereby deferred-free the page.

One could now grab a reference to the page table to keep it alive even 
after unsharing it (decrementing the shared counter), no longer 
confusing shared vs. unshared handling.

But the basic problem of the new exclusive owner reusing the page table 
for something else is not really affected at all by that change. We must 
flush before the exclusive owner could reuse it ... and the shared vs. 
refcount split does not really help in that regard AFAIKS.

-- 
Cheers

David

