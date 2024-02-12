Return-Path: <linux-arch+bounces-2185-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 301F0851214
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 12:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6631C21B71
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76DE38DDB;
	Mon, 12 Feb 2024 11:22:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228139FC3;
	Mon, 12 Feb 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736920; cv=none; b=PEUInb7nUV42DFjifTuSA1/vZIVtp0MfbX7cBCihLeibc0p//wFGgdBbKGKpgaXCU+TC643QhOshpku7gXTvgZp3uqR6dVYtpmwnUSOnvi56SIk7hn6ztgQYab2EBjAcfD89CZss10sYVeQInTU1QNgUd5JRxkKYOjlvAGZnW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736920; c=relaxed/simple;
	bh=M39Ph9w44/c6HZ9wqYZBxEolgPUrr+2T1hAQWtHx3e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBOVHLBlTzzcF2+y21ChsqyWBFLKDil8qERwMtJSA08vXZ7IYlf7jyNBo8Jbf7wlUXtA3uMtu9TZEj7PgLPzoslUDWFyFi/VoZWdgOXZ2+NZJTYChGQnm2PsJqiCya70KKIyxp3KlAnm4TYmpL2NxyGU17GgwYYSxXY4aHa4SJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9AFDA7;
	Mon, 12 Feb 2024 03:22:38 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5E683F762;
	Mon, 12 Feb 2024 03:21:53 -0800 (PST)
Message-ID: <398991e6-d09d-4f47-a110-4ff1e8356b6e@arm.com>
Date: Mon, 12 Feb 2024 11:21:52 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] mm/mmu_gather: improve cond_resched() handling
 with large folios and expensive page freeing
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Michal Hocko <mhocko@suse.com>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20240209221509.585251-1-david@redhat.com>
 <20240209221509.585251-10-david@redhat.com>
 <f1578e92-4de0-4718-bf79-ec29e9a19fe0@arm.com>
 <6c66f7ca-4b14-4bbb-bf06-e81b3481b03f@redhat.com>
 <590946ad-a538-4c99-947f-93455c2d96c6@arm.com>
 <e6774e16-90c0-4fba-9b9c-98de803fc920@redhat.com>
 <66ca6c58-1983-494f-b920-140be736f1d8@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <66ca6c58-1983-494f-b920-140be736f1d8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 11:05, David Hildenbrand wrote:
> On 12.02.24 11:56, David Hildenbrand wrote:
>> On 12.02.24 11:32, Ryan Roberts wrote:
>>> On 12/02/2024 10:11, David Hildenbrand wrote:
>>>> Hi Ryan,
>>>>
>>>>>> -static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>>>>> +static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
>>>>>>     {
>>>>>> -    struct mmu_gather_batch *batch;
>>>>>> -
>>>>>> -    for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>>>>>> -        struct encoded_page **pages = batch->encoded_pages;
>>>>>> +    struct encoded_page **pages = batch->encoded_pages;
>>>>>> +    unsigned int nr, nr_pages;
>>>>>>     +    /*
>>>>>> +     * We might end up freeing a lot of pages. Reschedule on a regular
>>>>>> +     * basis to avoid soft lockups in configurations without full
>>>>>> +     * preemption enabled. The magic number of 512 folios seems to work.
>>>>>> +     */
>>>>>> +    if (!page_poisoning_enabled_static() && !want_init_on_free()) {
>>>>>
>>>>> Is the performance win really worth 2 separate implementations keyed off this?
>>>>> It seems a bit fragile, in case any other operations get added to free
>>>>> which are
>>>>> proportional to size in future. Why not just always do the conservative
>>>>> version?
>>>>
>>>> I really don't want to iterate over all entries on the "sane" common case. We
>>>> already do that two times:
>>>>
>>>> a) free_pages_and_swap_cache()
>>>>
>>>> b) release_pages()
>>>>
>>>> Only the latter really is required, and I'm planning on removing the one in (a)
>>>> to move it into (b) as well.
>>>>
>>>> So I keep it separate to keep any unnecessary overhead to the setups that are
>>>> already terribly slow.
>>>>
>>>> No need to iterate a page full of entries if it can be easily avoided.
>>>> Especially, no need to degrade the common order-0 case.
>>>
>>> Yeah, I understand all that. But given this is all coming from an array, (so
>>> easy to prefetch?) and will presumably all fit in the cache for the common case,
>>> at least, so its hot for (a) and (b), does separating this out really make a
>>> measurable performance difference? If yes then absolutely this optimizaiton
>>> makes sense. But if not, I think its a bit questionable.
>>
>> I primarily added it because
>>
>> (a) we learned that each cycle counts during mmap() just like it does
>> during fork().
>>
>> (b) Linus was similarly concerned about optimizing out another batching
>> walk in c47454823bd4 ("mm: mmu_gather: allow more than one batch of
>> delayed rmaps"):
>>
>> "it needs to walk that array of pages while still holding the page table
>> lock, and our mmu_gather infrastructure allows for batching quite a lot
>> of pages.  We may have thousands on pages queued up for freeing, and we
>> wanted to walk only the last batch if we then added a dirty page to the
>> queue."
>>
>> So if it matters enough for reducing the time we hold the page table
>> lock, it surely adds "some" overhead in general.
>>
>>
>>>
>>> You're the boss though, so if your experience tells you this is neccessary, then
>>> I'm ok with that.
>>
>> I did not do any measurements myself, I just did that intuitively as
>> above. After all, it's all pretty straight forward (keeping the existing
>> logic, we need a new one either way) and not that much code.
>>
>> So unless there are strong opinions, I'd just leave the common case as
>> it was, and the odd case be special.
> 
> I think we can just reduce the code duplication easily:
> 
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index d175c0f1e2c8..99b3e9408aa0 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -91,18 +91,21 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct
> vm_area_struct *vma)
>  }
>  #endif
>  
> -static void tlb_batch_pages_flush(struct mmu_gather *tlb)
> -{
> -    struct mmu_gather_batch *batch;
> +/*
> + * We might end up freeing a lot of pages. Reschedule on a regular
> + * basis to avoid soft lockups in configurations without full
> + * preemption enabled. The magic number of 512 folios seems to work.
> + */
> +#define MAX_NR_FOLIOS_PER_FREE        512
>  
> -    for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
> -        struct encoded_page **pages = batch->encoded_pages;
> +static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
> +{
> +    struct encoded_page **pages = batch->encoded_pages;
> +    unsigned int nr, nr_pages;
>  
> -        while (batch->nr) {
> -            /*
> -             * limit free batch count when PAGE_SIZE > 4K
> -             */
> -            unsigned int nr = min(512U, batch->nr);
> +    while (batch->nr) {
> +        if (!page_poisoning_enabled_static() && !want_init_on_free()) {
> +            nr = min(MAX_NR_FOLIOS_PER_FREE, batch->nr);
>  
>              /*
>               * Make sure we cover page + nr_pages, and don't leave
> @@ -111,14 +114,39 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>              if (unlikely(encoded_page_flags(pages[nr - 1]) &
>                       ENCODED_PAGE_BIT_NR_PAGES_NEXT))
>                  nr++;
> +        } else {
> +            /*
> +             * With page poisoning and init_on_free, the time it
> +             * takes to free memory grows proportionally with the
> +             * actual memory size. Therefore, limit based on the
> +             * actual memory size and not the number of involved
> +             * folios.
> +             */
> +            for (nr = 0, nr_pages = 0;
> +                 nr < batch->nr && nr_pages < MAX_NR_FOLIOS_PER_FREE;
> +                 nr++) {
> +                if (unlikely(encoded_page_flags(pages[nr]) &
> +                         ENCODED_PAGE_BIT_NR_PAGES_NEXT))
> +                    nr_pages += encoded_nr_pages(pages[++nr]);
> +                else
> +                    nr_pages++;
> +            }
> +        }
>  
> -            free_pages_and_swap_cache(pages, nr);
> -            pages += nr;
> -            batch->nr -= nr;
> +        free_pages_and_swap_cache(pages, nr);
> +        pages += nr;
> +        batch->nr -= nr;
>  
> -            cond_resched();
> -        }
> +        cond_resched();
>      }
> +}
> +
> +static void tlb_batch_pages_flush(struct mmu_gather *tlb)
> +{
> +    struct mmu_gather_batch *batch;
> +
> +    for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
> +        __tlb_batch_free_encoded_pages(batch);
>      tlb->active = &tlb->local;
>  }
>  

Yes this is much cleaner IMHO! I don't think putting the poison and init_on_free
checks inside the while loops should make a whole lot of difference - you're
only going round that loop once in the common (4K pages) case.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>



