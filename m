Return-Path: <linux-arch+bounces-1905-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9E843CBF
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085C91C279B3
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319B755785;
	Wed, 31 Jan 2024 10:32:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E44C61;
	Wed, 31 Jan 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697123; cv=none; b=SB5PFaA39wKusTHIbvjtimTkBfhbu73KKloxifu+5L2OhYCwAGLTz7g8OSLuhXRVxgywS1n7zRr+d3qGjsylJQ+hC5IPrkagJrO36C6J9rlMUt0IDRebg78dQDfTzLKAoGDtmvBISY3jeQJMcnQqlK7Cl6E3LDpTVf8NNILMrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697123; c=relaxed/simple;
	bh=p+76q6wFys2x4uxnvAIjBWutVg1nOrqx8fPv9A+DXxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjLDaIaKpnAntE3xabPYS0iiGV+y4rlNi+7axTw/ikdsxV+wVNdrWx2TeEBWGLXeDRfWUE7KrRe6KpcyohMaoi0+jZuQFKk5tPKao/ofz/OFxyVpVyvE/3tAoADWDWDWZJhT5LM1lTGgaH/xfIlLRwW8WtsnnmOtFo+I8yEJhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3E8FDA7;
	Wed, 31 Jan 2024 02:32:42 -0800 (PST)
Received: from [10.57.79.60] (unknown [10.57.79.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A65A23F5A1;
	Wed, 31 Jan 2024 02:31:53 -0800 (PST)
Message-ID: <424115a2-a924-4c28-8027-32db6ab9278d@arm.com>
Date: Wed, 31 Jan 2024 10:31:51 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] mm/memory: optimize unmap/zap with PTE-mapped THP
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
 <20240129143221.263763-10-david@redhat.com>
 <bec84017-b1c9-48e7-a206-c4c8a651ee83@arm.com>
 <cf9adefc-8508-49a4-a7f0-784e345c5d80@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cf9adefc-8508-49a4-a7f0-784e345c5d80@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 10:21, David Hildenbrand wrote:
> 
>>> +
>>> +#ifndef clear_full_ptes
>>> +/**
>>> + * clear_full_ptes - Clear PTEs that map consecutive pages of the same folio.
>>
>> I know its implied from "pages of the same folio" (and even more so for the
>> above variant due to mention of access/dirty), but I wonder if its useful to
>> explicitly state that "all ptes being cleared are present at the time of the
>> call"?
> 
> "Clear PTEs" -> "Clear present PTEs" ?
> 
> That should make it clearer.

Works for me.

> 
> [...]
> 
>>>       if (!delay_rmap) {
>>> -        folio_remove_rmap_pte(folio, page, vma);
>>> +        folio_remove_rmap_ptes(folio, page, nr, vma);
>>> +
>>> +        /* Only sanity-check the first page in a batch. */
>>>           if (unlikely(page_mapcount(page) < 0))
>>>               print_bad_pte(vma, addr, ptent, page);
>>
>> Is there a case for either removing this all together or moving it into
>> folio_remove_rmap_ptes()? It seems odd to only check some pages.
>>
> 
> I really wanted to avoid another nasty loop here.
> 
> In my thinking, for 4k folios, or when zapping subpages of large folios, we
> still perform the exact same checks. Only when batching we don't. So if there is
> some problem, there are ways to get it triggered. And these problems are barely
> ever seen.
> 
> folio_remove_rmap_ptes() feels like the better place -- especially because the
> delayed-rmap handling is effectively unchecked. But in there, we cannot
> "print_bad_pte()".
> 
> [background: if we had a total mapcount -- iow cheap folio_mapcount(), I'd check
> here that the total mapcount does not underflow, instead of checking per-subpage]

All good points... perhaps extend the comment to describe how this could be
solved in future with cheap total_mapcount()? Or in the commit log if you prefer?

> 
>>
>>>       }
>>> -    if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
>>> +    if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
>>>           *force_flush = true;
>>>           *force_break = true;
>>>       }
>>>   }
>>>   -static inline void zap_present_pte(struct mmu_gather *tlb,
>>> +/*
>>> + * Zap or skip one present PTE, trying to batch-process subsequent PTEs that
>>> map
>>
>> Zap or skip *at least* one... ?
> 
> Ack
> 


