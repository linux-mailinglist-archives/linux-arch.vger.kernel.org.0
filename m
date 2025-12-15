Return-Path: <linux-arch+bounces-15417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B12CBE762
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 16:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AFB1305D9B8
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120034A3C4;
	Mon, 15 Dec 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niGNJ/9n"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245AC263C7F;
	Mon, 15 Dec 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810085; cv=none; b=KJwhmbHHWv2tp4DOjqF79nal2L+hG1MKFaYQN2aWRZ5c4IZhmzclvTOlrr1kvypxB0tN+IX56rHtjALeQdhQUaF3InHk3OS5Za4XxWQn+AzQewe8LaDcF6uaGL5+EGStciPM+m3T1QMbw3XwJA867UN2ll3MCfYyeHgB/YTfc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810085; c=relaxed/simple;
	bh=mV3B6xzBDJJhXBY0+MuZ/E/eWrtZv1dU8DuL0QrCJos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRddLCNc7MJfSRGiZuTumNaDs7P3NW/oAuHBgtMmWxOdpu0Fi+SAwSHUmBMAM8J0UWi6onuQnpjpRi88eCQNNcP9jbn8GdOe9IdtHGQ8V1xmah+GCA6NIq5+jjZrDsKhQGKh9nKK+YIC9Q9eEjHQ7tGXZfFLTDn9BTiTO0nrlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niGNJ/9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7732C4CEF5;
	Mon, 15 Dec 2025 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765810084;
	bh=mV3B6xzBDJJhXBY0+MuZ/E/eWrtZv1dU8DuL0QrCJos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=niGNJ/9nLNAcG7+GscG5rl1VsKZF8bJb/qYslvcYV+zGeLxb07aeoEgPu7HJ/Sthn
	 mFTV0AClsXOnG6AmRKVOtCOwiVhUW36xovmM47DlfU7ZCIr6Z78vylhzbYZeYBBp0T
	 KwZ9YbjhYZ2JsYtvfh/0rnU5uqCmztM9pKxAGGrGEP6Re38zxFnZcTuZ7jBF+M4+Nc
	 Gw46iMjDQex4/+CrSySB+0oOSvSsgZjB1M6y6aarXaxSVBZ28Oz2q5IqAWk1XNGGNt
	 liezIwU5PL2imabkYE7mALE09KoTRj0q+rKwxm0xnNvUyvIGkQmPtwj4PbFejZ6P4t
	 3SE3nGyR6NsIg==
Message-ID: <937a4525-910d-4596-a9c4-29e47ca53667@kernel.org>
Date: Mon, 15 Dec 2025 15:47:57 +0100
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
 <9ac7c53e-04ae-49f3-976d-44d1e29587d1@kernel.org>
 <07e8b94e-b4a1-4541-84ed-a5d57058d5a1@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <07e8b94e-b4a1-4541-84ed-a5d57058d5a1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>>
>>> As Nadav points out, should also initialise fully_unshared_tables.
>>
>> Right, but on an earlier init path, not on the range reset path here.
> 
> Shouldn't we reset it also?
> 
> I mean __tlb_reset_range() is also called by __tlb_gather_mmu() (invoked by
> tlb_gather_mmu[_fullmm]()).
> 

__tlb_reset_range() is all about flushing the TLB.

In v2 I have:

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 247e3f9db6c7a..030a162a263ba 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -426,6 +426,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
  #endif
         tlb->vma_pfn = 0;
  
+       tlb->fully_unshared_tables = 0;
         __tlb_reset_range(tlb);
         inc_tlb_flush_pending(tlb->mm);
  }


>>
>>>
>>>>    	/*
>>>>    	 * Do not reset mmu_gather::vma_* fields here, we do not
>>>>    	 * call into tlb_start_vma() again to set them if there is an
>>>> @@ -484,7 +496,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>>>>    	 * these bits.
>>>>    	 */
>>>>    	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
>>>> -	      tlb->cleared_puds || tlb->cleared_p4ds))
>>>> +	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->unshared_tables))
>>>
>>> What about fully_unshared_tables? I guess though unshared_tables implies
>>> fully_unshared_tables.
>>
>> fully_unshared_tables is only for triggering IPIs and consequently not about
>> flushing TLBs.
>>
>> The TLB part is taken care of by unshared_tables, and we will always set
>> unshared_tables when unsharing any page tables (incl. fully unshared ones).
> 
> OK, so is there ever a situation where fully_unshared_tables would be set
> without unshared_tables? Presumably not.

tlb_unshare_pmd_ptdesc() will always set "unshared_tables" but only conditionally
sets "fully_unshared_tables".

"unshared_tables" might get handled by a prior TLB flush,
leaving only fully_unshared_tables set to perform the IPI in tlb_flush_unshared_tables().

So the important part is that whenever we unshare, we set "unshared_tables".

[...]

>>>> +{
>>>> +	/*
>>>> +	 * As soon as the caller drops locks to allow for reuse of
>>>> +	 * previously-shared tables, these tables could get modified and
>>>> +	 * even reused outside of hugetlb context. So flush the TLB now.
>>>
>>> Hmm but you're doing this in both the case of unshare and fully unsharing, so is
>>> this the right place to make this comment?
>>
>> That's why I start the comment below with "Similarly", to make it clear that
>> the comments build up on each other.
>>
>> But I'm afraid I might not be getting your point fully here :/
> 
> what I mean is, if we are not at the point of the table being fully unshared,
> nobody else can come in and reuse it right? Because we're still using it, just
> dropped a ref + flushed tlb?

After we drop the lock, someone else could fully unshare it. And that other (MM) would
not be able to flush the TLB for us -- in contrast to the IPI that would affect all
CPUs.

> 
> Isn't really the correct comment here that ranges that previously mapped the
> shared pages might no longer, so we must clear the TLB? I may be missing
> something :)

There are cases where we defer flushing the TLB until we dropped all (exclusive) locks.
In particular, MADV_DONTNEED does that in some cases, essentially deferring the flush
to the tlb_finish_mmu().

free_pgtables() will also defer the flush, performing the TLB flush during tlb_finish_mmu(),
before

The point is (as I tried to make clear in the comment), for unsharing we have no control
whenn the page table gets freed after we drop the lock.

So we must flush the TLB now and cannot defer it like we do in the other cases.

> 
> Or maybe the right thing is 'we must always flush the TLB because <blahdyblah>,
> and if we are fully unsharing tables we must avoid reuse of previously-shared
> tables when the caller drops the locks' or something?

I hope the description above made it clearer why I spell out that the TLB must be flushed
now.

> 
>>
>>>
>>> Surely here this is about flushing TLBs for the unsharer only as it no longer
>>> uses it?
>>>
>>>> +	 *
>>>> +	 * Note that we cannot defer the flush to a later point even if we are
>>>> +	 * not the last sharer of the page table.
>>>> +	 */
>>>
>>> Not hugely clear, some double negative here. Maybe worth saying something like:
>>>
>>> 'Even if we are not fully unsharing a PMD table, we must flush the TLB for the
>>> unsharer who no longer has access to this memory'
>>>
>>> Or something? Assuming this is accurate :)
>>
>> I'll adjust it to "Not that even if we are not fully unsharing a PMD table,
>> we must flush the TLB for the unsharer now.".
> 
> I guess you mean Note or that's even more confusing :P

:) Yeah, I did that in v2.

-- 
Cheers

David

