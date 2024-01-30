Return-Path: <linux-arch+bounces-1827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1876841E3C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C01B291779
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9A5647A;
	Tue, 30 Jan 2024 08:45:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF557861;
	Tue, 30 Jan 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604351; cv=none; b=NvDhH/+bLjIB+1PSiiikbLNmiZ/B9fb/1EHI2t8CzavBecy5LH4rzDHzagWmvzLVLTL/jEeyF7HNbQAQvMQ0fXGneqQlGVJRk+kKpzKlVKADOnJQz3zPSFn4FXwxDF2D5ggHjda76Ip0fum+izUxzPmQiONPEBvSizDCUapWHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604351; c=relaxed/simple;
	bh=YPivXGUwsgxM6K1OyqG9VqP6YDZRo0TgVHoytzvbpTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBkSOvvy0GeFekgq5cJaCG9J1F1DTM8foyah8TljxyjFB8LFTp9IzAKORRZlwDpDFRFB+7ViSK6iuQmRLUikuWkPih5nz5mqPhbSaRPp1mm5rcp10c3eS6g5cpMD6+M33Ex0MHI2lTFKsrzQpvXaGtuehgPgpOo/MjhaWkr+tok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600E3DA7;
	Tue, 30 Jan 2024 00:46:31 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B93E3F738;
	Tue, 30 Jan 2024 00:45:43 -0800 (PST)
Message-ID: <a50f2ee0-680d-4506-93f0-af22adda1b3b@arm.com>
Date: Tue, 30 Jan 2024 08:45:41 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] mm/memory: further separate anon and pagecache
 folio handling in zap_present_pte()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20240129143221.263763-1-david@redhat.com>
 <20240129143221.263763-4-david@redhat.com>
 <40cfb242-ceb0-44c6-afe7-c1744825dc62@arm.com>
 <c783e71c-2fc0-4752-be6b-7ea316758243@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c783e71c-2fc0-4752-be6b-7ea316758243@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/01/2024 08:37, David Hildenbrand wrote:
> On 30.01.24 09:31, Ryan Roberts wrote:
>> On 29/01/2024 14:32, David Hildenbrand wrote:
>>> We don't need up-to-date accessed-dirty information for anon folios and can
>>> simply work with the ptent we already have. Also, we know the RSS counter
>>> we want to update.
>>>
>>> We can safely move arch_check_zapped_pte() + tlb_remove_tlb_entry() +
>>> zap_install_uffd_wp_if_needed() after updating the folio and RSS.
>>>
>>> While at it, only call zap_install_uffd_wp_if_needed() if there is even
>>> any chance that pte_install_uffd_wp_if_needed() would do *something*.
>>> That is, just don't bother if uffd-wp does not apply.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   mm/memory.c | 16 +++++++++++-----
>>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 69502cdc0a7d..20bc13ab8db2 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1552,12 +1552,9 @@ static inline void zap_present_pte(struct mmu_gather
>>> *tlb,
>>>       folio = page_folio(page);
>>>       if (unlikely(!should_zap_folio(details, folio)))
>>>           return;
>>> -    ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>> -    arch_check_zapped_pte(vma, ptent);
>>> -    tlb_remove_tlb_entry(tlb, pte, addr);
>>> -    zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
>>>         if (!folio_test_anon(folio)) {
>>> +        ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>>           if (pte_dirty(ptent)) {
>>>               folio_mark_dirty(folio);
>>>               if (tlb_delay_rmap(tlb)) {
>>> @@ -1567,8 +1564,17 @@ static inline void zap_present_pte(struct mmu_gather
>>> *tlb,
>>>           }
>>>           if (pte_young(ptent) && likely(vma_has_recency(vma)))
>>>               folio_mark_accessed(folio);
>>> +        rss[mm_counter(folio)]--;
>>> +    } else {
>>> +        /* We don't need up-to-date accessed/dirty bits. */
>>> +        ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>> +        rss[MM_ANONPAGES]--;
>>>       }
>>> -    rss[mm_counter(folio)]--;
>>> +    arch_check_zapped_pte(vma, ptent);
>>
>> Isn't the x86 (only) implementation of this relying on the dirty bit? So doesn't
>> that imply you still need get_and_clear for anon? (And in hindsight I think that
>> logic would apply to the previous patch too?)
> 
> x86 uses the encoding !writable && dirty to indicate special shadow stacks. That
> is, the hw dirty bit is set by software (to create that combination), not by
> hardware.
> 
> So you don't have to sync against any hw changes of the hw dirty bit. What you
> had in the original PTE you read is sufficient.
> 

Right, got it. In that case:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>



