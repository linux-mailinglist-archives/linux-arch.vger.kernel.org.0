Return-Path: <linux-arch+bounces-1838-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5F84201B
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B60B2BC76
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10212605D5;
	Tue, 30 Jan 2024 09:48:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305E59B4E;
	Tue, 30 Jan 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608087; cv=none; b=SekgRKvgjxll/SfiGxup745QKTEOLZK+xwCzXLiRdgJnYwuFUpYoelpZfoKn+4Ry50yMOcgbww/Tx+Em4vYhxjCpYjqfVqZj/TynuoCvGXRxZJ5mBlOatXBe9/q5ZreSDT72gVBnE9B6SH8Zvi45tdh3ku9NdsKpi3U9h/u+YMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608087; c=relaxed/simple;
	bh=v+6f5JbxnVnth39cGl4EmMu1BCx3bWHnFMyuWrpHkzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APPY93SKzgIO6Whcy5k4TkDDbs3gUwNgO6f+bFoVJyP1R8Z8b3qPAllcrmPQL1hVpg9008liiDwh8rJ4OrWGxwr/TyhPLHpDeU2p316AgCTkNmCfvommccS8p/6LriV4PZ/cx4dimWMlyCfOQUGqBwQ5ZgwHC42/T57K+pC+nvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F710DA7;
	Tue, 30 Jan 2024 01:48:48 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B3083F738;
	Tue, 30 Jan 2024 01:48:01 -0800 (PST)
Message-ID: <bec84017-b1c9-48e7-a206-c4c8a651ee83@arm.com>
Date: Tue, 30 Jan 2024 09:48:00 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240129143221.263763-10-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:32, David Hildenbrand wrote:
> Similar to how we optimized fork(), let's implement PTE batching when
> consecutive (present) PTEs map consecutive pages of the same large
> folio.
> 
> Most infrastructure we need for batching (mmu gather, rmap) is already
> there. We only have to add get_and_clear_full_ptes() and
> clear_full_ptes(). Similarly, extend zap_install_uffd_wp_if_needed() to
> process a PTE range.
> 
> We won't bother sanity-checking the mapcount of all subpages, but only
> check the mapcount of the first subpage we process.
> 
> To keep small folios as fast as possible force inlining of a specialized
> variant using __always_inline with nr=1.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/pgtable.h | 66 +++++++++++++++++++++++++++++
>  mm/memory.c             | 92 +++++++++++++++++++++++++++++------------
>  2 files changed, 132 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index aab227e12493..f0feae7f89fb 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -580,6 +580,72 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  }
>  #endif
>  
> +#ifndef get_and_clear_full_ptes
> +/**
> + * get_and_clear_full_ptes - Clear PTEs that map consecutive pages of the same
> + *			     folio, collecting dirty/accessed bits.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to clear.
> + * @full: Whether we are clearing a full mm.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a simple
> + * loop over ptep_get_and_clear_full(), merging dirty/accessed bits into
> + * returned PTE.
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
> +		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
> +{
> +	pte_t pte, tmp_pte;
> +
> +	pte = ptep_get_and_clear_full(mm, addr, ptep, full);
> +	while (--nr) {
> +		ptep++;
> +		addr += PAGE_SIZE;
> +		tmp_pte = ptep_get_and_clear_full(mm, addr, ptep, full);
> +		if (pte_dirty(tmp_pte))
> +			pte = pte_mkdirty(pte);
> +		if (pte_young(tmp_pte))
> +			pte = pte_mkyoung(pte);
> +	}
> +	return pte;
> +}
> +#endif
> +
> +#ifndef clear_full_ptes
> +/**
> + * clear_full_ptes - Clear PTEs that map consecutive pages of the same folio.

I know its implied from "pages of the same folio" (and even more so for the
above variant due to mention of access/dirty), but I wonder if its useful to
explicitly state that "all ptes being cleared are present at the time of the call"?

> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to clear.
> + * @full: Whether we are clearing a full mm.
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, unsigned int nr, int full)
> +{
> +	for (;;) {
> +		ptep_get_and_clear_full(mm, addr, ptep, full);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +	}
> +}
> +#endif
>  
>  /*
>   * If two threads concurrently fault at the same page, the thread that
> diff --git a/mm/memory.c b/mm/memory.c
> index a2190d7cfa74..38a010c4d04d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1515,7 +1515,7 @@ static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
>   */
>  static inline void
>  zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> -			      unsigned long addr, pte_t *pte,
> +			      unsigned long addr, pte_t *pte, int nr,
>  			      struct zap_details *details, pte_t pteval)
>  {
>  	/* Zap on anonymous always means dropping everything */
> @@ -1525,20 +1525,27 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>  	if (zap_drop_file_uffd_wp(details))
>  		return;
>  
> -	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> +	for (;;) {
> +		/* the PFN in the PTE is irrelevant. */
> +		pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> +		if (--nr == 0)
> +			break;
> +		pte++;
> +		addr += PAGE_SIZE;
> +	}
>  }
>  
> -static inline void zap_present_folio_pte(struct mmu_gather *tlb,
> +static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, struct folio *folio,
> -		struct page *page, pte_t *pte, pte_t ptent, unsigned long addr,
> -		struct zap_details *details, int *rss, bool *force_flush,
> -		bool *force_break)
> +		struct page *page, pte_t *pte, pte_t ptent, unsigned int nr,
> +		unsigned long addr, struct zap_details *details, int *rss,
> +		bool *force_flush, bool *force_break)
>  {
>  	struct mm_struct *mm = tlb->mm;
>  	bool delay_rmap = false;
>  
>  	if (!folio_test_anon(folio)) {
> -		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> +		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>  		if (pte_dirty(ptent)) {
>  			folio_mark_dirty(folio);
>  			if (tlb_delay_rmap(tlb)) {
> @@ -1548,36 +1555,49 @@ static inline void zap_present_folio_pte(struct mmu_gather *tlb,
>  		}
>  		if (pte_young(ptent) && likely(vma_has_recency(vma)))
>  			folio_mark_accessed(folio);
> -		rss[mm_counter(folio)]--;
> +		rss[mm_counter(folio)] -= nr;
>  	} else {
>  		/* We don't need up-to-date accessed/dirty bits. */
> -		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> -		rss[MM_ANONPAGES]--;
> +		clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
> +		rss[MM_ANONPAGES] -= nr;
>  	}
> +	/* Checking a single PTE in a batch is sufficient. */
>  	arch_check_zapped_pte(vma, ptent);
> -	tlb_remove_tlb_entry(tlb, pte, addr);
> +	tlb_remove_tlb_entries(tlb, pte, nr, addr);
>  	if (unlikely(userfaultfd_pte_wp(vma, ptent)))
> -		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> +		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details,
> +					      ptent);
>  
>  	if (!delay_rmap) {
> -		folio_remove_rmap_pte(folio, page, vma);
> +		folio_remove_rmap_ptes(folio, page, nr, vma);
> +
> +		/* Only sanity-check the first page in a batch. */
>  		if (unlikely(page_mapcount(page) < 0))
>  			print_bad_pte(vma, addr, ptent, page);

Is there a case for either removing this all together or moving it into
folio_remove_rmap_ptes()? It seems odd to only check some pages.


>  	}
> -	if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
> +	if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
>  		*force_flush = true;
>  		*force_break = true;
>  	}
>  }
>  
> -static inline void zap_present_pte(struct mmu_gather *tlb,
> +/*
> + * Zap or skip one present PTE, trying to batch-process subsequent PTEs that map

Zap or skip *at least* one... ?

> + * consecutive pages of the same folio.
> + *
> + * Returns the number of processed (skipped or zapped) PTEs (at least 1).
> + */
> +static inline int zap_present_ptes(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
> -		unsigned long addr, struct zap_details *details,
> -		int *rss, bool *force_flush, bool *force_break)
> +		unsigned int max_nr, unsigned long addr,
> +		struct zap_details *details, int *rss, bool *force_flush,
> +		bool *force_break)
>  {
> +	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>  	struct mm_struct *mm = tlb->mm;
>  	struct folio *folio;
>  	struct page *page;
> +	int nr;
>  
>  	page = vm_normal_page(vma, addr, ptent);
>  	if (!page) {
> @@ -1587,14 +1607,29 @@ static inline void zap_present_pte(struct mmu_gather *tlb,
>  		tlb_remove_tlb_entry(tlb, pte, addr);
>  		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
>  		ksm_might_unmap_zero_page(mm, ptent);
> -		return;
> +		return 1;
>  	}
>  
>  	folio = page_folio(page);
>  	if (unlikely(!should_zap_folio(details, folio)))
> -		return;
> -	zap_present_folio_pte(tlb, vma, folio, page, pte, ptent, addr, details,
> -			      rss, force_flush, force_break);
> +		return 1;
> +
> +	/*
> +	 * Make sure that the common "small folio" case is as fast as possible
> +	 * by keeping the batching logic separate.
> +	 */
> +	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
> +		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
> +				     NULL);
> +
> +		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
> +				       addr, details, rss, force_flush,
> +				       force_break);
> +		return nr;
> +	}
> +	zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, 1, addr,
> +			       details, rss, force_flush, force_break);
> +	return 1;
>  }
>  
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> @@ -1609,6 +1644,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	pte_t *start_pte;
>  	pte_t *pte;
>  	swp_entry_t entry;
> +	int nr;
>  
>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  	init_rss_vec(rss);
> @@ -1622,7 +1658,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  		pte_t ptent = ptep_get(pte);
>  		struct folio *folio = NULL;
>  		struct page *page;
> +		int max_nr;
>  
> +		nr = 1;
>  		if (pte_none(ptent))
>  			continue;
>  
> @@ -1630,10 +1668,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			break;
>  
>  		if (pte_present(ptent)) {
> -			zap_present_pte(tlb, vma, pte, ptent, addr, details,
> -					rss, &force_flush, &force_break);
> +			max_nr = (end - addr) / PAGE_SIZE;
> +			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
> +					      addr, details, rss, &force_flush,
> +					      &force_break);
>  			if (unlikely(force_break)) {
> -				addr += PAGE_SIZE;
> +				addr += nr * PAGE_SIZE;
>  				break;
>  			}
>  			continue;
> @@ -1687,8 +1727,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			WARN_ON_ONCE(1);
>  		}
>  		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> -		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> -	} while (pte++, addr += PAGE_SIZE, addr != end);
> +		zap_install_uffd_wp_if_needed(vma, addr, pte, 1, details, ptent);
> +	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
>  
>  	add_mm_rss_vec(mm, rss);
>  	arch_leave_lazy_mmu_mode();


