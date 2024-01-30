Return-Path: <linux-arch+bounces-1826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C799841E22
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2691C25256
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F6E5820C;
	Tue, 30 Jan 2024 08:41:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21256B94;
	Tue, 30 Jan 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604093; cv=none; b=HfhezekukRqUiuUXvMY0zx6p9mpvqi8yH3nE5WtTfz0dwVEc3O853h/4iHtL9Hukwx9DuYsZEjlfttymFA7qLAR7outj2N1n42/fuygB7A8htkyC0qZlQGCBaWfZS5o3xMsVTe5AxKtSJsRLrBM1nKw+NRtY/WER0/u2ezqMLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604093; c=relaxed/simple;
	bh=qjL50loYk73px3wyOA47dKIQLHPZHHZWfV2Xt/C3D6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl1o7NeMpwqLssHUGRm7XRP9f0fxeE/Cr9+vLLHeAoK2YSQNQG9yIYNVnDG9F5NJhmcHZSDhODRbue+gp5cOFsKuNsyH9/6t5YAEc8DNSQ5jL0zmfj+a0R2dAByo6syyQQQO/9JS1cLSsf4eFccCVv4i01tfpUoqd51NA7atlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5232BDA7;
	Tue, 30 Jan 2024 00:42:13 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E241A3F738;
	Tue, 30 Jan 2024 00:41:25 -0800 (PST)
Message-ID: <6cf5cce0-69aa-437b-a13f-4d9adeae01df@arm.com>
Date: Tue, 30 Jan 2024 08:41:23 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] mm/mmu_gather: pass "delay_rmap" instead of
 encoded page to __tlb_remove_page_size()
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
 <20240129143221.263763-6-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240129143221.263763-6-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:32, David Hildenbrand wrote:
> We have two bits available in the encoded page pointer to store
> additional information. Currently, we use one bit to request delay of the
> rmap removal until after a TLB flush.
> 
> We want to make use of the remaining bit internally for batching of
> multiple pages of the same folio, specifying that the next encoded page
> pointer in an array is actually "nr_pages". So pass page + delay_rmap flag
> instead of an encoded page, to handle the encoding internally.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/s390/include/asm/tlb.h | 13 ++++++-------
>  include/asm-generic/tlb.h   | 12 ++++++------
>  mm/mmu_gather.c             |  7 ++++---
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index d1455a601adc..48df896d5b79 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -25,8 +25,7 @@
>  void __tlb_remove_table(void *_table);
>  static inline void tlb_flush(struct mmu_gather *tlb);
>  static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
> -					  struct encoded_page *page,
> -					  int page_size);
> +		struct page *page, bool delay_rmap, int page_size);
>  
>  #define tlb_flush tlb_flush
>  #define pte_free_tlb pte_free_tlb
> @@ -42,14 +41,14 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>   * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
>   * has already been freed, so just do free_page_and_swap_cache.
>   *
> - * s390 doesn't delay rmap removal, so there is nothing encoded in
> - * the page pointer.
> + * s390 doesn't delay rmap removal.
>   */
>  static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
> -					  struct encoded_page *page,
> -					  int page_size)
> +		struct page *page, bool delay_rmap, int page_size)
>  {
> -	free_page_and_swap_cache(encoded_page_ptr(page));
> +	VM_WARN_ON_ONCE(delay_rmap);
> +
> +	free_page_and_swap_cache(page);
>  	return false;
>  }
>  
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 129a3a759976..2eb7b0d4f5d2 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -260,9 +260,8 @@ struct mmu_gather_batch {
>   */
>  #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
>  
> -extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
> -				   struct encoded_page *page,
> -				   int page_size);
> +extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
> +		bool delay_rmap, int page_size);
>  
>  #ifdef CONFIG_SMP
>  /*
> @@ -462,13 +461,14 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  static inline void tlb_remove_page_size(struct mmu_gather *tlb,
>  					struct page *page, int page_size)
>  {
> -	if (__tlb_remove_page_size(tlb, encode_page(page, 0), page_size))
> +	if (__tlb_remove_page_size(tlb, page, false, page_size))
>  		tlb_flush_mmu(tlb);
>  }
>  
> -static __always_inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page, unsigned int flags)
> +static __always_inline bool __tlb_remove_page(struct mmu_gather *tlb,
> +		struct page *page, bool delay_rmap)
>  {
> -	return __tlb_remove_page_size(tlb, encode_page(page, flags), PAGE_SIZE);
> +	return __tlb_remove_page_size(tlb, page, delay_rmap, PAGE_SIZE);
>  }
>  
>  /* tlb_remove_page
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 604ddf08affe..ac733d81b112 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -116,7 +116,8 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
>  	tlb->local.next = NULL;
>  }
>  
> -bool __tlb_remove_page_size(struct mmu_gather *tlb, struct encoded_page *page, int page_size)
> +bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
> +		bool delay_rmap, int page_size)
>  {
>  	struct mmu_gather_batch *batch;
>  
> @@ -131,13 +132,13 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct encoded_page *page, i
>  	 * Add the page and check if we are full. If so
>  	 * force a flush.
>  	 */
> -	batch->encoded_pages[batch->nr++] = page;
> +	batch->encoded_pages[batch->nr++] = encode_page(page, delay_rmap);
>  	if (batch->nr == batch->max) {
>  		if (!tlb_next_batch(tlb))
>  			return true;
>  		batch = tlb->active;
>  	}
> -	VM_BUG_ON_PAGE(batch->nr > batch->max, encoded_page_ptr(page));
> +	VM_BUG_ON_PAGE(batch->nr > batch->max, page);
>  
>  	return false;
>  }


