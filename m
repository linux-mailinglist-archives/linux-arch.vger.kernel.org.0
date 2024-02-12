Return-Path: <linux-arch+bounces-2177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8F5850FB4
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 10:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78711B230E7
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83496125AC;
	Mon, 12 Feb 2024 09:26:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ACB15A8;
	Mon, 12 Feb 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730004; cv=none; b=iPRmxQd0coQQ9h58fnxU+DymoEjUiZBXzlXOr03NXT6doocY5RHs9a41fWNcJec3x+ShjnG1HSkptTjAxFmlXPbi2p2cVJ03wuDwylf7rO9wzsWVywWFxMxKWf6mBZQpCgjdDFNqYwSSadh9MaVs9LqGwXC8KNOlIP8O3gpYWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730004; c=relaxed/simple;
	bh=3/gZFmIeC4omGnu9pY52APIUSPKCBfWi/3XjhMqMlZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COFLVUT3XvfpwnS9B7miOHyRa+XDHvUTQInA8mwt+6lYU/ZQtkzv5EjrSVvL3sb6jokySTOFNyJbdVGGQfo+/sYXuRnJkPyLUEqSO7X9OBr4IU8vZmqauVWhpsyo5vY36gAP2h7/V1FlFfrzfXQnkQzk8sTi81JdIvDfDhrmKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8ECCDA7;
	Mon, 12 Feb 2024 01:27:22 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164533F762;
	Mon, 12 Feb 2024 01:26:37 -0800 (PST)
Message-ID: <f1578e92-4de0-4718-bf79-ec29e9a19fe0@arm.com>
Date: Mon, 12 Feb 2024 09:26:36 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240209221509.585251-10-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 22:15, David Hildenbrand wrote:
> It's a pain that we have to handle cond_resched() in
> tlb_batch_pages_flush() manually and cannot simply handle it in
> release_pages() -- release_pages() can be called from atomic context.
> Well, in a perfect world we wouldn't have to make our code more at all.
> 
> With page poisoning and init_on_free, we might now run into soft lockups
> when we free a lot of rather large folio fragments, because page freeing
> time then depends on the actual memory size we are freeing instead of on
> the number of folios that are involved.
> 
> In the absolute (unlikely) worst case, on arm64 with 64k we will be able
> to free up to 256 folio fragments that each span 512 MiB: zeroing out 128
> GiB does sound like it might take a while. But instead of ignoring this
> unlikely case, let's just handle it.
> 
> So, let's teach tlb_batch_pages_flush() that there are some
> configurations where page freeing is horribly slow, and let's reschedule
> more frequently -- similarly like we did for now before we had large folio
> fragments in there. Note that we might end up freeing only a single folio
> fragment at a time that might exceed the old 512 pages limit: but if we
> cannot even free a single MAX_ORDER page on a system without running into
> soft lockups, something else is already completely bogus.
> 
> In the future, we might want to detect if handling cond_resched() is
> required at all, and just not do any of that with full preemption enabled.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/mmu_gather.c | 50 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index d175c0f1e2c8..2774044b5790 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -91,18 +91,19 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  }
>  #endif
>  
> -static void tlb_batch_pages_flush(struct mmu_gather *tlb)
> +static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
>  {
> -	struct mmu_gather_batch *batch;
> -
> -	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
> -		struct encoded_page **pages = batch->encoded_pages;
> +	struct encoded_page **pages = batch->encoded_pages;
> +	unsigned int nr, nr_pages;
>  
> +	/*
> +	 * We might end up freeing a lot of pages. Reschedule on a regular
> +	 * basis to avoid soft lockups in configurations without full
> +	 * preemption enabled. The magic number of 512 folios seems to work.
> +	 */
> +	if (!page_poisoning_enabled_static() && !want_init_on_free()) {

Is the performance win really worth 2 separate implementations keyed off this?
It seems a bit fragile, in case any other operations get added to free which are
proportional to size in future. Why not just always do the conservative version?

>  		while (batch->nr) {
> -			/*
> -			 * limit free batch count when PAGE_SIZE > 4K
> -			 */
> -			unsigned int nr = min(512U, batch->nr);
> +			nr = min(512, batch->nr);

If any entries are for more than 1 page, nr_pages will also be encoded in the
batch, so effectively this could be limiting to 256 actual folios (half of 512).
Is it worth checking for ENCODED_PAGE_BIT_NR_PAGES_NEXT and limiting accordingly?

nit: You're using 512 magic number in 2 places now; perhaps make a macro?

>  
>  			/*
>  			 * Make sure we cover page + nr_pages, and don't leave
> @@ -119,6 +120,37 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>  			cond_resched();
>  		}
>  	}
> +
> +	/*
> +	 * With page poisoning and init_on_free, the time it takes to free
> +	 * memory grows proportionally with the actual memory size. Therefore,
> +	 * limit based on the actual memory size and not the number of involved
> +	 * folios.
> +	 */
> +	while (batch->nr) {
> +		for (nr = 0, nr_pages = 0;
> +		     nr < batch->nr && nr_pages < 512; nr++) {
> +			if (unlikely(encoded_page_flags(pages[nr]) &
> +				     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
> +				nr_pages += encoded_nr_pages(pages[++nr]);
> +			else
> +				nr_pages++;
> +		}

I guess worst case here is freeing (511 + 8192) * 64K pages = ~544M. That's up
from the old limit of 512 * 64K = 32M, and 511 pages bigger than your statement
in the commit log. Are you comfortable with this? I guess the only alternative
is to start splitting a batch which would be really messy. I agree your approach
is preferable if 544M is acceptable.

> +
> +		free_pages_and_swap_cache(pages, nr);
> +		pages += nr;
> +		batch->nr -= nr;
> +
> +		cond_resched();
> +	}
> +}
> +
> +static void tlb_batch_pages_flush(struct mmu_gather *tlb)
> +{
> +	struct mmu_gather_batch *batch;
> +
> +	for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
> +		__tlb_batch_free_encoded_pages(batch);
>  	tlb->active = &tlb->local;
>  }
>  


