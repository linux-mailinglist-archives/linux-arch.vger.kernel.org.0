Return-Path: <linux-arch+bounces-1902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FE843C83
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7ABB1C29C4E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D369D07;
	Wed, 31 Jan 2024 10:26:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901769964;
	Wed, 31 Jan 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696786; cv=none; b=iEV7pBWkixJGHrTzRzoQg7PoJLuwdPsm6ejXzYWRtkgJUlTZZYb27ZaTkkgFeGfTuD3tmPfoseD+SIptWsVN29LmCweunpfPRnKt98eStEjJNQfpDJSiF0Ogddnkla6Mvc686ZvZxkwmqrvSXEFY+hQrEvz5ho/5gPT+UibEYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696786; c=relaxed/simple;
	bh=6k5DByJTFjsHHVF679JwFY8xzfBlwG6FkcsPcj4eTlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G80HiY6r6A7moUBav60uLKuWKVqQ1h2YjWhG7GQv4YUDRB2/SEIuw2/PgSxWO7fQ0NnlwokUTORToTkO+Vy3Rd4dRQPKZGJYdP8WeF2AE7QCFfUKSfG92ughHBK3LA5OlWkkJK4CchwtKy6PSahqnlukwShpVnHRkdfnOW7Q8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F4F4DA7;
	Wed, 31 Jan 2024 02:27:06 -0800 (PST)
Received: from [10.57.79.60] (unknown [10.57.79.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994A23F5A1;
	Wed, 31 Jan 2024 02:26:15 -0800 (PST)
Message-ID: <1fd26a83-8e6f-4b96-9d27-dd46de9488cc@arm.com>
Date: Wed, 31 Jan 2024 10:26:13 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] mm/memory: optimize unmap/zap with PTE-mapped THP
To: David Hildenbrand <david@redhat.com>, Yin Fengwei
 <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michal Hocko <mhocko@kernel.org>
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
 linux-s390@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
References: <20240129143221.263763-1-david@redhat.com>
 <4ef64fd1-f605-4ddf-82e6-74b5e2c43892@intel.com>
 <ee94b8ca-9723-44c0-aa17-75c9678015c6@redhat.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ee94b8ca-9723-44c0-aa17-75c9678015c6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 10:16, David Hildenbrand wrote:
> On 31.01.24 03:20, Yin Fengwei wrote:
>> On 1/29/24 22:32, David Hildenbrand wrote:
>>> This series is based on [1] and must be applied on top of it.
>>> Similar to what we did with fork(), let's implement PTE batching
>>> during unmap/zap when processing PTE-mapped THPs.
>>>
>>> We collect consecutive PTEs that map consecutive pages of the same large
>>> folio, making sure that the other PTE bits are compatible, and (a) adjust
>>> the refcount only once per batch, (b) call rmap handling functions only
>>> once per batch, (c) perform batch PTE setting/updates and (d) perform TLB
>>> entry removal once per batch.
>>>
>>> Ryan was previously working on this in the context of cont-pte for
>>> arm64, int latest iteration [2] with a focus on arm6 with cont-pte only.
>>> This series implements the optimization for all architectures, independent
>>> of such PTE bits, teaches MMU gather/TLB code to be fully aware of such
>>> large-folio-pages batches as well, and amkes use of our new rmap batching
>>> function when removing the rmap.
>>>
>>> To achieve that, we have to enlighten MMU gather / page freeing code
>>> (i.e., everything that consumes encoded_page) to process unmapping
>>> of consecutive pages that all belong to the same large folio. I'm being
>>> very careful to not degrade order-0 performance, and it looks like I
>>> managed to achieve that.
>>
> 
> Let's CC Linus and Michal to make sure I'm not daydreaming.
> 
> Relevant patch:
>   https://lkml.kernel.org/r/20240129143221.263763-8-david@redhat.com
> 
> Context: I'm adjusting MMU gather code to support batching of consecutive pages
> that belong to the same large folio, when unmapping/zapping PTEs.
> 
> For small folios, there is no (relevant) change.
> 
> Imagine we have a PTE-mapped THP (2M folio -> 512 pages) and zap all 512 PTEs:
> Instead of adding 512 individual encoded_page entries, we add a combined entry
> that expresses "page+nr_pages". That allows for "easily" adding various other
> per-folio batching (refcount, rmap, swap freeing).
> 
> The implication is, that we can now batch effective more pages with large
> folios, exceeding the old 10000 limit. The number of involved *folios* does not
> increase, though.
> 
>> One possible scenario:
>> If all the folio is 2M size folio, then one full batch could hold 510M memory.
>> Is it too much regarding one full batch before just can hold (2M - 4096 * 2)
>> memory?
> 
> Excellent point, I think there are three parts to it:
> 
> (1) Batch pages / folio fragments per batch page
> 
> Before this change (and with 4k folios) we have exactly one page (4k) per
> encoded_page entry in the batch. Now, we can have (with 2M folios), 512 pages
> for every two encoded_page entries (page+nr_pages) in a batch page. So an
> average ~256 pages per encoded_page entry.
> 
> So one batch page can now store in the worst case ~256 times the number of
> pages, but the number of folio fragments ("pages+nr_pages") would not increase.
> 
> The time it takes to perform the actual page freeing of a batch will not be 256
> times higher -- the time is expected to be much closer to the old time (i.e.,
> not freeing more folios).

IIRC there is an option to zero memory when it is freed back to the buddy? So
that could be a place where time is proportional to size rather than
proportional to folio count? But I think that option is intended for debug only?
So perhaps not a problem in practice?


> 
> (2) Delayed rmap handling
> 
> We limit batching early (see tlb_next_batch()) when we have delayed rmap
> pending. Reason being, that we don't want to check for many entries if they
> require delayed rmap handling, while still holding the page table lock (see
> tlb_flush_rmaps()), because we have to remove the rmap before dropping the PTL.
> 
> Note that we perform the check whether we need delayed rmap handling per
> page+nr_pages entry, not per page. So we won't perform more such checks.
> 
> Once we set tlb->delayed_rmap (because we add one entry that requires it), we
> already force a flush before dropping the PT lock. So once we get a single
> delayed rmap entry in there, we will not batch more than we could have in the
> same page table: so not more than 512 entries (x86-64) in the worst case. So it
> will still be bounded, and not significantly more than what we had before.
> 
> So regarding delayed rmap handling I think this should be fine.
> 
> (3) Total patched pages
> 
> MAX_GATHER_BATCH_COUNT effectively limits the number of pages we allocate (full
> batches), and thereby limits the number of pages we were able to batch.
> 
> The old limit was ~10000 pages, now we could batch ~5000 folio fragments
> (page+nr_pages), resulting int the "times 256" increase in the worst case on
> x86-64 as you point out.
> 
> This 10000 pages limit was introduced in 53a59fc67f97 ("mm: limit mmu_gather
> batching to fix soft lockups on !CONFIG_PREEMPT") where we wanted to handle
> soft-lockups.
> 
> As the number of effective folios we are freeing does not increase, I *think*
> this should be fine.
> 
> 
> If any of that is a problem, we would have to keep track of the total number of
> pages in our batch, and stop as soon as we hit our 10000 limit -- independent of
> page vs. folio fragment. Something I would like to avoid of possible.
> 


