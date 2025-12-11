Return-Path: <linux-arch+bounces-15333-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A950CB47F6
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 02:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C271301BEA8
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9D277819;
	Thu, 11 Dec 2025 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2JJnt6x"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8692737F3;
	Thu, 11 Dec 2025 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765418339; cv=none; b=Zqr3MS701WMYzujOqUX3DPPqx8b7tBKaRqfiylV/dIjd85GMfPR6++xO0RBvnviT6sg3lXQQusAqC01PSZtlYc5HD0jDbjyUI513THsQWCK4GjK3b7uXcEyzhCp9zBoJ8DcpEyTYFR50Kc9pPjDSdXyeM5NAEVSbJYChJvzVN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765418339; c=relaxed/simple;
	bh=vlF760B5VM4cBVjm5lLCjMa4CdR2bjBkUw3h2n7BWas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzvPvM1bN+gK92kDJ/rxJwYF7i4/oyyxgyhVA5D91vnTj75MNnwk/JPGj8a2ykjXYDFinamlHQH4D3E99n1FiFkX0KFnmhWZ+Ks0NGjaJ8ANe1a5JCWSdB3zBur6LO9qh5SkaoKJADWPJ8ufJTyti6xdQ8E3J3w+X7hDWdnbMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2JJnt6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CFFC4CEF1;
	Thu, 11 Dec 2025 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765418338;
	bh=vlF760B5VM4cBVjm5lLCjMa4CdR2bjBkUw3h2n7BWas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c2JJnt6x50ZeIVYp/2of259vDiRGLRdEM8mvk36W1oexnHD1wz6LWyyt4VNZc3jk+
	 tMkAu90O7wwxrgdsXqBV4yBJ4e2VzA8LvpKM3FFxqj7IFqi4IrJIR9Ut9Jf4Mja5uH
	 q4rWWOXN784TyKSxTap7GyaZmrheqcPLGjH7J4+uAEjb85shCGRoy6cs1NAVc87L18
	 LEu9M/+IttnzQiPBIzeeoS7bftUZ/pgqJd+fl0P0l6G4LGsNrTnrOat57Ji2vY5aPH
	 vB+AyOfmA/WUgHZu5fi6lv3g1foWIBcBNJWoE1LCCNA8fZ8pqCzDr00OUf52r+jj2N
	 pu34W0G6ngx4A==
Message-ID: <7b2f7f85-4790-4eeb-adea-6ff1d399bd28@kernel.org>
Date: Thu, 11 Dec 2025 02:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
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
 Nadav Amit <nadav.amit@gmail.com>, Liu Shixin <liushixin2@huawei.com>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-3-david@kernel.org>
 <834ec5ca-d43c-441d-a10b-ea268333e433@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <834ec5ca-d43c-441d-a10b-ea268333e433@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/25 12:22, Lorenzo Stoakes wrote:
> On Fri, Dec 05, 2025 at 10:35:56PM +0100, David Hildenbrand (Red Hat) wrote:
>> Ever since we stopped using the page count to detect shared PMD
>> page tables, these comments are outdated.
>>
>> The only reason we have to flush the TLB early is because once we drop
>> the i_mmap_rwsem, the previously shared page table could get freed (to
>> then get reallocated and used for other purpose). So we really have to
>> flush the TLB before that could happen.
>>
>> So let's simplify the comments a bit.
>>
>> The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
>> part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
>> correctly after huge_pmd_unshare") was confusing: sure it is recorded
>> in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
>> anything. So let's drop that comment while at it as well.
>>
>> We'll centralize these comments in a single helper as we rework the code
>> next.
>>
>> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
>> Cc: Liu Shixin <liushixin2@huawei.com>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> 
> LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

> 
>> ---
>>   mm/hugetlb.c | 24 ++++++++----------------
>>   1 file changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 51273baec9e5d..3c77cdef12a32 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>   	tlb_end_vma(tlb, vma);
>>
>>   	/*
>> -	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
>> -	 * could defer the flush until now, since by holding i_mmap_rwsem we
>> -	 * guaranteed that the last reference would not be dropped. But we must
>> -	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
>> -	 * dropped and the last reference to the shared PMDs page might be
>> -	 * dropped as well.
>> -	 *
>> -	 * In theory we could defer the freeing of the PMD pages as well, but
>> -	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
>> -	 * detect sharing, so we cannot defer the release of the page either.
> 
> Was it this comment that led you to question the page_count issue? :)

Heh, no, I know about the changed handling already. I stumbled over the 
page_count() remaining usage while working on some cleanups I previously 
had as part of this series :)

-- 
Cheers

David

