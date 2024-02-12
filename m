Return-Path: <linux-arch+bounces-2182-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9328510F4
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 11:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC51B250D3
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE0208C1;
	Mon, 12 Feb 2024 10:32:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EC38F86;
	Mon, 12 Feb 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733965; cv=none; b=b3pxc0VfJ2uUDzfOu4eYL4fKBHK7wws3YuMfjMxKubmVEoAMXRyLXo5SIHl5Hv11m6QAhuHRTsO4GaJ5wQrg1pRe4woJ4v4ayxyonTz9NxXaWm63+7KVbFb4Kx80tT7FZkKImFfDpINFu+uTb0P/03724rCm+ZqnwRp5N39kkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733965; c=relaxed/simple;
	bh=rue4OxYXJdrpeRwQ0vv+gyD470QjAXZx/8+YrSZvDYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owyDTD7uK+JDBge2yzPLOsfP22HVBbFB+1HJKUcFrtVvuCzLtWnQqtKOKFjML/llJUH2IbpzH7O1Z/sOXycoKPlSK7CnCHXYcosnWw7i8JLhSnjWZMOLIKG1M4QETjoWN6NeZf7XqOqNg+2tI4g/QOvlPvT5Ayx7z4zEE5s2Goc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 255FEDA7;
	Mon, 12 Feb 2024 02:33:23 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77AD83F762;
	Mon, 12 Feb 2024 02:32:38 -0800 (PST)
Message-ID: <590946ad-a538-4c99-947f-93455c2d96c6@arm.com>
Date: Mon, 12 Feb 2024 10:32:36 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6c66f7ca-4b14-4bbb-bf06-e81b3481b03f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 10:11, David Hildenbrand wrote:
> Hi Ryan,
> 
>>> -static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>> +static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
>>>   {
>>> -    struct mmu_gather_batch *batch;
>>> -
>>> -    for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>>> -        struct encoded_page **pages = batch->encoded_pages;
>>> +    struct encoded_page **pages = batch->encoded_pages;
>>> +    unsigned int nr, nr_pages;
>>>   +    /*
>>> +     * We might end up freeing a lot of pages. Reschedule on a regular
>>> +     * basis to avoid soft lockups in configurations without full
>>> +     * preemption enabled. The magic number of 512 folios seems to work.
>>> +     */
>>> +    if (!page_poisoning_enabled_static() && !want_init_on_free()) {
>>
>> Is the performance win really worth 2 separate implementations keyed off this?
>> It seems a bit fragile, in case any other operations get added to free which are
>> proportional to size in future. Why not just always do the conservative version?
> 
> I really don't want to iterate over all entries on the "sane" common case. We
> already do that two times:
> 
> a) free_pages_and_swap_cache()
> 
> b) release_pages()
> 
> Only the latter really is required, and I'm planning on removing the one in (a)
> to move it into (b) as well.
> 
> So I keep it separate to keep any unnecessary overhead to the setups that are
> already terribly slow.
> 
> No need to iterate a page full of entries if it can be easily avoided.
> Especially, no need to degrade the common order-0 case.

Yeah, I understand all that. But given this is all coming from an array, (so
easy to prefetch?) and will presumably all fit in the cache for the common case,
at least, so its hot for (a) and (b), does separating this out really make a
measurable performance difference? If yes then absolutely this optimizaiton
makes sense. But if not, I think its a bit questionable.

You're the boss though, so if your experience tells you this is neccessary, then
I'm ok with that.

By the way, Matthew had an RFC a while back that was doing some clever things
with batches further down the call chain (I think; be memory). Might be worth
taking a look at that if you are planning a follow up change to (a).

> 
>>
>>>           while (batch->nr) {
>>> -            /*
>>> -             * limit free batch count when PAGE_SIZE > 4K
>>> -             */
>>> -            unsigned int nr = min(512U, batch->nr);
>>> +            nr = min(512, batch->nr);
>>
>> If any entries are for more than 1 page, nr_pages will also be encoded in the
>> batch, so effectively this could be limiting to 256 actual folios (half of 512).
> 
> Right, in the patch description I state "256 folio fragments". It's up to 512
> folios (order-0).
> 
>> Is it worth checking for ENCODED_PAGE_BIT_NR_PAGES_NEXT and limiting accordingly?
> 
> At least with 4k page size, we never have more than 510 (IIRC) entries per batch
> page. So any such optimization would only matter for large page sizes, which I
> don't think is worth it.

Yep; agreed.

> 
> Which exact optimization do you have in mind and would it really make a difference?

No I don't think it would make any difference, performance-wise. I'm just
pointing out that in pathalogical cases you could end up with half the number of
pages being freed at a time.

> 
>>
>> nit: You're using 512 magic number in 2 places now; perhaps make a macro?
> 
> I played 3 times with macro names (including just using something "intuitive"
> like MAX_ORDER_NR_PAGES) but returned to just using 512.
> 
> That cond_resched() handling is just absolutely disgusting, one way or the other.
> 
> Do you have a good idea for a macro name?

MAX_NR_FOLIOS_PER_BATCH?
MAX_NR_FOLIOS_PER_FREE?

I don't think the name has to be perfect, because its private to the c file; but
it ensures the 2 usages remain in sync if someone wants to change it in future.

> 
>>
>>>                 /*
>>>                * Make sure we cover page + nr_pages, and don't leave
>>> @@ -119,6 +120,37 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>>               cond_resched();
>>>           }
>>>       }
>>> +
>>> +    /*
>>> +     * With page poisoning and init_on_free, the time it takes to free
>>> +     * memory grows proportionally with the actual memory size. Therefore,
>>> +     * limit based on the actual memory size and not the number of involved
>>> +     * folios.
>>> +     */
>>> +    while (batch->nr) {
>>> +        for (nr = 0, nr_pages = 0;
>>> +             nr < batch->nr && nr_pages < 512; nr++) {
>>> +            if (unlikely(encoded_page_flags(pages[nr]) &
>>> +                     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
>>> +                nr_pages += encoded_nr_pages(pages[++nr]);
>>> +            else
>>> +                nr_pages++;
>>> +        }
>>
>> I guess worst case here is freeing (511 + 8192) * 64K pages = ~544M. That's up
>> from the old limit of 512 * 64K = 32M, and 511 pages bigger than your statement
>> in the commit log. Are you comfortable with this? I guess the only alternative
>> is to start splitting a batch which would be really messy. I agree your approach
>> is preferable if 544M is acceptable.
> 
> Right, I have in the description:
> 
> "if we cannot even free a single MAX_ORDER page on a system without running into
> soft lockups, something else is already completely bogus.".
> 
> That would be 8192 pages on arm64. Anybody freeing a PMD-mapped THP would be in
> trouble already and should just reconsider life choices running such a machine.
> 
> We could have 511 more pages, yes. If 8192 don't trigger a soft-lockup, I am
> confident that 511 more pages won't make a difference.
> 
> But, if that ever is a problem, we can butcher this code as much as we want,
> because performance with poisoning/zeroing is already down the drain.
> 
> As you say, splitting even further is messy, so I rather avoid that unless
> really required.
> 

Yep ok, I understand the argument better now - thanks.


