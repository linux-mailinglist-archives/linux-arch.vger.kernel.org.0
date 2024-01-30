Return-Path: <linux-arch+bounces-1832-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7173E841EAB
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D26628F034
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7283260866;
	Tue, 30 Jan 2024 09:03:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB6605CF;
	Tue, 30 Jan 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605423; cv=none; b=ab5W//+uVBz54c99z6K7Qi1CBImG+5iUfx1ch4gjaWzYdP+4aWSdzveC8jIwIlhTL+mnxi+WDSj3ttc2nJHDG3QgBDQNfzBK62qnF8yE/PG9yCw5KUWm2ssKvVV98b+Vkt4lK53khHemelqlOVukVBG5WW5MDHwz95Sd8qWD11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605423; c=relaxed/simple;
	bh=nBml0oiJ6D0UQzvGSde6AYnzRvh5VcdeBvdq6qBUeYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+vhLJLTyYKkdJiMLfrDZv4avSsWiCOirj9gcSQUmHNJVZMlEJmbAtcbHlcXQ5L3ftaUc058yvRozBloYHld3MPkfx+IozyQMLOKUSQbBZ8BwpJ0fQGqeaB0Cya3l9MW9+JO5xgntkE63aHL+PtO6gLbAVJK0ZF+R75RjeLyN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DCEA139F;
	Tue, 30 Jan 2024 01:04:24 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA66B3F738;
	Tue, 30 Jan 2024 01:03:37 -0800 (PST)
Message-ID: <075975db-a59b-483a-95d7-0990442ebe6f@arm.com>
Date: Tue, 30 Jan 2024 09:03:36 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] mm/mmu_gather: define ENCODED_PAGE_FLAG_DELAY_RMAP
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
 <20240129143221.263763-7-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240129143221.263763-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:32, David Hildenbrand wrote:
> Nowadays, encoded pages are only used in mmu_gather handling. Let's
> update the documentation, and define ENCODED_PAGE_BIT_DELAY_RMAP. While at
> it, rename ENCODE_PAGE_BITS to ENCODED_PAGE_BITS.
> 
> If encoded page pointers would ever be used in other context again, we'd
> likely want to change the defines to reflect their context (e.g.,
> ENCODED_PAGE_FLAG_MMU_GATHER_DELAY_RMAP). For now, let's keep it simple.
> 
> This is a preparation for using the remaining spare bit to indicate that
> the next item in an array of encoded pages is a "nr_pages" argument and
> not an encoded page.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/mm_types.h | 17 +++++++++++------
>  mm/mmu_gather.c          |  5 +++--
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8b611e13153e..1b89eec0d6df 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -210,8 +210,8 @@ struct page {
>   *
>   * An 'encoded_page' pointer is a pointer to a regular 'struct page', but
>   * with the low bits of the pointer indicating extra context-dependent
> - * information. Not super-common, but happens in mmu_gather and mlock
> - * handling, and this acts as a type system check on that use.
> + * information. Only used in mmu_gather handling, and this acts as a type
> + * system check on that use.
>   *
>   * We only really have two guaranteed bits in general, although you could
>   * play with 'struct page' alignment (see CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
> @@ -220,21 +220,26 @@ struct page {
>   * Use the supplied helper functions to endcode/decode the pointer and bits.
>   */
>  struct encoded_page;
> -#define ENCODE_PAGE_BITS 3ul
> +
> +#define ENCODED_PAGE_BITS			3ul
> +
> +/* Perform rmap removal after we have flushed the TLB. */
> +#define ENCODED_PAGE_BIT_DELAY_RMAP		1ul
> +
>  static __always_inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
>  {
> -	BUILD_BUG_ON(flags > ENCODE_PAGE_BITS);
> +	BUILD_BUG_ON(flags > ENCODED_PAGE_BITS);
>  	return (struct encoded_page *)(flags | (unsigned long)page);
>  }
>  
>  static inline unsigned long encoded_page_flags(struct encoded_page *page)
>  {
> -	return ENCODE_PAGE_BITS & (unsigned long)page;
> +	return ENCODED_PAGE_BITS & (unsigned long)page;
>  }
>  
>  static inline struct page *encoded_page_ptr(struct encoded_page *page)
>  {
> -	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
> +	return (struct page *)(~ENCODED_PAGE_BITS & (unsigned long)page);
>  }
>  
>  /*
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index ac733d81b112..6540c99c6758 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -53,7 +53,7 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_
>  	for (int i = 0; i < batch->nr; i++) {
>  		struct encoded_page *enc = batch->encoded_pages[i];
>  
> -		if (encoded_page_flags(enc)) {
> +		if (encoded_page_flags(enc) & ENCODED_PAGE_BIT_DELAY_RMAP) {
>  			struct page *page = encoded_page_ptr(enc);
>  			folio_remove_rmap_pte(page_folio(page), page, vma);
>  		}
> @@ -119,6 +119,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
>  bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
>  		bool delay_rmap, int page_size)
>  {
> +	int flags = delay_rmap ? ENCODED_PAGE_BIT_DELAY_RMAP : 0;
>  	struct mmu_gather_batch *batch;
>  
>  	VM_BUG_ON(!tlb->end);
> @@ -132,7 +133,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
>  	 * Add the page and check if we are full. If so
>  	 * force a flush.
>  	 */
> -	batch->encoded_pages[batch->nr++] = encode_page(page, delay_rmap);
> +	batch->encoded_pages[batch->nr++] = encode_page(page, flags);
>  	if (batch->nr == batch->max) {
>  		if (!tlb_next_batch(tlb))
>  			return true;


