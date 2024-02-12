Return-Path: <linux-arch+bounces-2183-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767F8511A5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16B61F23364
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A62556F;
	Mon, 12 Feb 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJZ/6rrj"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69C28370
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735380; cv=none; b=oKa/1/XTakoHs/bX+Ei8XjzjLIF/PiC3BmBPcqjmbGLWY06cMoOiAdmZ0UPjaDX7YAXAEMWWUedH63iHXJwZxNtwx1ykTHmqdbBu9En+VVj/vs+hic1zT8KFuokG8Uov5vcFs8CUbHtZi0V4M/IBVQWoa40qW779yaEs5JpOZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735380; c=relaxed/simple;
	bh=iN0ZQbM9DZxALFUgS9Q08kQ+Ol82GM4tETLHfgNCsNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSwcM/Hr6QzbZdOkvejsePVR+JyriXfFR9VnUsp6g+7u7oVvtC6MTZsLVsU47jgWlYbJ+d/p5KzcmPDKDjC8dBN9RmzA8lrYYEa7gcknksfbKMczXOz4MH5OKl6ACwDqrxnc31veGtaxcdMgB0werHWbivcTjqfZBD6zOg7j0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJZ/6rrj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707735377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UV8bdgpmsnr14qmRHmP9LgSt0o7Rd0LaIu3KD5rWrF0=;
	b=ZJZ/6rrjmC8ZgCGtyRp48tW4Ph0xvNAdTWSrN4ptSGp6E+CB88TA1EMGMkyewB37f5saYa
	bGWd7tHrBTPo7uwah8TeJ4RruapkRwvoj6K7lJ8gtcwKdvCs8vgg/uXwJSDftnNWfs31Mw
	8pnuMp0fFZZ7SOSkA310vvMA5XGrln0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-jjrzNnMzOXyNVgY8Tmts2g-1; Mon, 12 Feb 2024 05:56:14 -0500
X-MC-Unique: jjrzNnMzOXyNVgY8Tmts2g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33b1799e433so1499428f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 02:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707735373; x=1708340173;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV8bdgpmsnr14qmRHmP9LgSt0o7Rd0LaIu3KD5rWrF0=;
        b=Eun7rKxFYU5EYVPbgo8jjb0eAdYFjpzznTSc+Wkq18gBxFkpyjS6/PYRVvc9cIlmwU
         6IQjU7DjjahITzYjet1x9lLXedy3R8vhZzia5saWjRyCsa6gbFctXm53GJ0C7A8Xrh5a
         b0m4oFkLkvZjf6BG/aIyspIipxfXfUIsg7Hb2CsXKpf4Rz/+UZkIDfcCbS3mIgiaD26J
         VBLpJTeQvBS2sSQ3vFuBG1Z40Nf1pWEgwtWH4Lqng4e2s5CChfdwiuDYoAFnj3dO0jMs
         qm8TzefqNc3INuRnPG0pzH/SaUmHpSoLOx7jblElo0GOUlYlJB6ng3mOFe8eyV1HK/nj
         rm7Q==
X-Gm-Message-State: AOJu0YxPHfNBYHRzi2wWApidObzCOiGcogpztjpAXi8yDcgWNTDOOOx+
	kGSSSskP/9dIwVYAbkZ/8Zr7+BOv5T5BhkIOi82Tbb/mRRw3PdBPkvb0ZXHScfHqC0IQGwgfbdm
	T/TAHfh+qFG37LdRFRrad4oPwC67+5H93235oEg4oUY+cQWZq2fxne9NR8mI=
X-Received: by 2002:adf:f783:0:b0:33b:6d36:de48 with SMTP id q3-20020adff783000000b0033b6d36de48mr4787408wrp.26.1707735373491;
        Mon, 12 Feb 2024 02:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/IczVnpqG7OkL74qqeEO8Efr3rPNiI2sLLGfEI45Sntu72wIYKx9fA7rHUuSCnjIuJqb7rg==
X-Received: by 2002:adf:f783:0:b0:33b:6d36:de48 with SMTP id q3-20020adff783000000b0033b6d36de48mr4787383wrp.26.1707735373053;
        Mon, 12 Feb 2024 02:56:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjROoncsMS9ff/iccqKfqz0fi4PCC42VOc6vvwHBjhJXjzTpJlaTL/AcE4wlksfudxTI8Nufs1TaBw9FXcJAvIGseizwGfpxHdXA91AMi85HfqCVcWrZmAhA3vZkmt2Apb8EUGV7dsVepCozjNuALNAFILi4S1lEWPFA2EpYHWGbnq+al1ucIyDhLO6GYlvPt6CH52fPmJ6WZpvf6zSbVQ5BKD2Kux+GliB5ikYPH4IeWitD+J94+wHP/34NkYzOoGAVf5cDaKG2D+z8Tcj90Jllx2pQr/4FEJcvOX/r0uaPpwRIphvNTZrwlCMR/ofGFaNaFBcrakwcc6oCnzK4UH1GTnXGyqA3ct2TtXIGbXz5SgvPmcheBpCfmU3JBbtYjYJVOq/Cu9kPFBq+iV7BynOkk+LoYeavXAsKrJUEoxNqk7gJl1hVxmdbaHNRJ8GH/Xrep1FcL7ndv35Ff16lr+2y+KVyZcjp3vcFmekmjm1fP3DsAUD1AaCsrZ8ui/QWYnR8UJrHN1i4j0VP2kvQx3aAjFGQAhbf0rpwA914ul/9WCChdJIzh0+GSYZiRdVIOwT3amXD4KZNjOzHEfzMFG927T7BqZceLrfF6cUarIizPaeuFRSVL84WFcql7Rw3wC+P9g9pTa3pJGcQ+4RTKA649h0MJBUEeEzta0LzDdHl4QDvtp6+86jFU39Hh8luio0tRTYoC9rHDbADrYT6bGtiodX2nkZeYloJipmlKST9qoRl8=
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id bq26-20020a5d5a1a000000b0033b4335dce5sm6603003wrb.85.2024.02.12.02.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 02:56:12 -0800 (PST)
Message-ID: <e6774e16-90c0-4fba-9b9c-98de803fc920@redhat.com>
Date: Mon, 12 Feb 2024 11:56:11 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] mm/mmu_gather: improve cond_resched() handling
 with large folios and expensive page freeing
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <590946ad-a538-4c99-947f-93455c2d96c6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.02.24 11:32, Ryan Roberts wrote:
> On 12/02/2024 10:11, David Hildenbrand wrote:
>> Hi Ryan,
>>
>>>> -static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>>> +static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
>>>>    {
>>>> -    struct mmu_gather_batch *batch;
>>>> -
>>>> -    for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>>>> -        struct encoded_page **pages = batch->encoded_pages;
>>>> +    struct encoded_page **pages = batch->encoded_pages;
>>>> +    unsigned int nr, nr_pages;
>>>>    +    /*
>>>> +     * We might end up freeing a lot of pages. Reschedule on a regular
>>>> +     * basis to avoid soft lockups in configurations without full
>>>> +     * preemption enabled. The magic number of 512 folios seems to work.
>>>> +     */
>>>> +    if (!page_poisoning_enabled_static() && !want_init_on_free()) {
>>>
>>> Is the performance win really worth 2 separate implementations keyed off this?
>>> It seems a bit fragile, in case any other operations get added to free which are
>>> proportional to size in future. Why not just always do the conservative version?
>>
>> I really don't want to iterate over all entries on the "sane" common case. We
>> already do that two times:
>>
>> a) free_pages_and_swap_cache()
>>
>> b) release_pages()
>>
>> Only the latter really is required, and I'm planning on removing the one in (a)
>> to move it into (b) as well.
>>
>> So I keep it separate to keep any unnecessary overhead to the setups that are
>> already terribly slow.
>>
>> No need to iterate a page full of entries if it can be easily avoided.
>> Especially, no need to degrade the common order-0 case.
> 
> Yeah, I understand all that. But given this is all coming from an array, (so
> easy to prefetch?) and will presumably all fit in the cache for the common case,
> at least, so its hot for (a) and (b), does separating this out really make a
> measurable performance difference? If yes then absolutely this optimizaiton
> makes sense. But if not, I think its a bit questionable.

I primarily added it because

(a) we learned that each cycle counts during mmap() just like it does 
during fork().

(b) Linus was similarly concerned about optimizing out another batching 
walk in c47454823bd4 ("mm: mmu_gather: allow more than one batch of 
delayed rmaps"):

"it needs to walk that array of pages while still holding the page table 
lock, and our mmu_gather infrastructure allows for batching quite a lot 
of pages.  We may have thousands on pages queued up for freeing, and we 
wanted to walk only the last batch if we then added a dirty page to the 
queue."

So if it matters enough for reducing the time we hold the page table 
lock, it surely adds "some" overhead in general.


> 
> You're the boss though, so if your experience tells you this is neccessary, then
> I'm ok with that.

I did not do any measurements myself, I just did that intuitively as 
above. After all, it's all pretty straight forward (keeping the existing 
logic, we need a new one either way) and not that much code.

So unless there are strong opinions, I'd just leave the common case as 
it was, and the odd case be special.

> 
> By the way, Matthew had an RFC a while back that was doing some clever things
> with batches further down the call chain (I think; be memory). Might be worth
> taking a look at that if you are planning a follow up change to (a).
> 

Do you have a pointer?

>>
>>>
>>>>            while (batch->nr) {
>>>> -            /*
>>>> -             * limit free batch count when PAGE_SIZE > 4K
>>>> -             */
>>>> -            unsigned int nr = min(512U, batch->nr);
>>>> +            nr = min(512, batch->nr);
>>>
>>> If any entries are for more than 1 page, nr_pages will also be encoded in the
>>> batch, so effectively this could be limiting to 256 actual folios (half of 512).
>>
>> Right, in the patch description I state "256 folio fragments". It's up to 512
>> folios (order-0).
>>
>>> Is it worth checking for ENCODED_PAGE_BIT_NR_PAGES_NEXT and limiting accordingly?
>>
>> At least with 4k page size, we never have more than 510 (IIRC) entries per batch
>> page. So any such optimization would only matter for large page sizes, which I
>> don't think is worth it.
> 
> Yep; agreed.
> 
>>
>> Which exact optimization do you have in mind and would it really make a difference?
> 
> No I don't think it would make any difference, performance-wise. I'm just
> pointing out that in pathalogical cases you could end up with half the number of
> pages being freed at a time.

Yes, I'll extend the patch description!

> 
>>
>>>
>>> nit: You're using 512 magic number in 2 places now; perhaps make a macro?
>>
>> I played 3 times with macro names (including just using something "intuitive"
>> like MAX_ORDER_NR_PAGES) but returned to just using 512.
>>
>> That cond_resched() handling is just absolutely disgusting, one way or the other.
>>
>> Do you have a good idea for a macro name?
> 
> MAX_NR_FOLIOS_PER_BATCH?
> MAX_NR_FOLIOS_PER_FREE?
> 
> I don't think the name has to be perfect, because its private to the c file; but
> it ensures the 2 usages remain in sync if someone wants to change it in future.

Makes sense, I'll use something along those lines.

> 
>>
>>>
>>>>                  /*
>>>>                 * Make sure we cover page + nr_pages, and don't leave
>>>> @@ -119,6 +120,37 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>>>                cond_resched();
>>>>            }
>>>>        }
>>>> +
>>>> +    /*
>>>> +     * With page poisoning and init_on_free, the time it takes to free
>>>> +     * memory grows proportionally with the actual memory size. Therefore,
>>>> +     * limit based on the actual memory size and not the number of involved
>>>> +     * folios.
>>>> +     */
>>>> +    while (batch->nr) {
>>>> +        for (nr = 0, nr_pages = 0;
>>>> +             nr < batch->nr && nr_pages < 512; nr++) {
>>>> +            if (unlikely(encoded_page_flags(pages[nr]) &
>>>> +                     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
>>>> +                nr_pages += encoded_nr_pages(pages[++nr]);
>>>> +            else
>>>> +                nr_pages++;
>>>> +        }
>>>
>>> I guess worst case here is freeing (511 + 8192) * 64K pages = ~544M. That's up
>>> from the old limit of 512 * 64K = 32M, and 511 pages bigger than your statement
>>> in the commit log. Are you comfortable with this? I guess the only alternative
>>> is to start splitting a batch which would be really messy. I agree your approach
>>> is preferable if 544M is acceptable.
>>
>> Right, I have in the description:
>>
>> "if we cannot even free a single MAX_ORDER page on a system without running into
>> soft lockups, something else is already completely bogus.".
>>
>> That would be 8192 pages on arm64. Anybody freeing a PMD-mapped THP would be in
>> trouble already and should just reconsider life choices running such a machine.
>>
>> We could have 511 more pages, yes. If 8192 don't trigger a soft-lockup, I am
>> confident that 511 more pages won't make a difference.
>>
>> But, if that ever is a problem, we can butcher this code as much as we want,
>> because performance with poisoning/zeroing is already down the drain.
>>
>> As you say, splitting even further is messy, so I rather avoid that unless
>> really required.
>>
> 
> Yep ok, I understand the argument better now - thanks.
> 

I'll further extend the patch description.

Thanks!

-- 
Cheers,

David / dhildenb


