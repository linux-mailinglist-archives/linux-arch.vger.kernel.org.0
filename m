Return-Path: <linux-arch+bounces-1821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71170841D4F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE7F1C24DC7
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6873B54BC5;
	Tue, 30 Jan 2024 08:13:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C23D54730;
	Tue, 30 Jan 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602428; cv=none; b=D9yB4jwcjVMAtZWRQIv7bjFaDTMuamtnb3SK47wrPx+IXNcEjqFA3NZQQ8sceKDRRjtxZ49be3yhU7aj4SKpFpI9LLjby6rY2n295R4v9u2s8pHJ8xxjWrwJiTj8e3Yvawk3LDgETbWlsLwRQcmqWYbzSH07TULboH5kpEe1uHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602428; c=relaxed/simple;
	bh=hoXZ+7t4/9iqisEcsZ0owVBriVlaMkcKhjK2xwCBTc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZ0jGYwfKAZL2NQYn3SplCk5VOQADeKkra8IID7LSy/HwRJ0fdZBhDzJi7iOv3iMRE15OxRr5HEqzvNuooEeIwktqnpnJazHIZLa3JYD+UOe2CSRbuI3zOlLjbJNhFfxHERfehMlBexHyPoxg+nT7Xc1TaNVUa43VMcRrmu91Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02A1DDA7;
	Tue, 30 Jan 2024 00:14:28 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6013F738;
	Tue, 30 Jan 2024 00:13:39 -0800 (PST)
Message-ID: <40e87333-4da9-4497-a117-9885986e376a@arm.com>
Date: Tue, 30 Jan 2024 08:13:38 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] mm/memory: factor out zapping of present pte into
 zap_present_pte()
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
 <20240129143221.263763-2-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240129143221.263763-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:32, David Hildenbrand wrote:
> Let's prepare for further changes by factoring out processing of present
> PTEs.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 92 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 52 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b05fd28dbce1..50a6c79c78fc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1532,13 +1532,61 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>  }
>  
> +static inline void zap_present_pte(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
> +		unsigned long addr, struct zap_details *details,
> +		int *rss, bool *force_flush, bool *force_break)
> +{
> +	struct mm_struct *mm = tlb->mm;
> +	bool delay_rmap = false;
> +	struct folio *folio;

You need to init this to NULL otherwise its a random value when calling
should_zap_folio() if vm_normal_page() returns NULL.

> +	struct page *page;
> +
> +	page = vm_normal_page(vma, addr, ptent);
> +	if (page)
> +		folio = page_folio(page);
> +
> +	if (unlikely(!should_zap_folio(details, folio)))
> +		return;
> +	ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> +	arch_check_zapped_pte(vma, ptent);
> +	tlb_remove_tlb_entry(tlb, pte, addr);
> +	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> +	if (unlikely(!page)) {
> +		ksm_might_unmap_zero_page(mm, ptent);
> +		return;
> +	}
> +
> +	if (!folio_test_anon(folio)) {
> +		if (pte_dirty(ptent)) {
> +			folio_mark_dirty(folio);
> +			if (tlb_delay_rmap(tlb)) {
> +				delay_rmap = true;
> +				*force_flush = true;
> +			}
> +		}
> +		if (pte_young(ptent) && likely(vma_has_recency(vma)))
> +			folio_mark_accessed(folio);
> +	}
> +	rss[mm_counter(folio)]--;
> +	if (!delay_rmap) {
> +		folio_remove_rmap_pte(folio, page, vma);
> +		if (unlikely(page_mapcount(page) < 0))
> +			print_bad_pte(vma, addr, ptent, page);
> +	}
> +	if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
> +		*force_flush = true;
> +		*force_break = true;
> +	}
> +}
> +
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				struct vm_area_struct *vma, pmd_t *pmd,
>  				unsigned long addr, unsigned long end,
>  				struct zap_details *details)
>  {
> +	bool force_flush = false, force_break = false;
>  	struct mm_struct *mm = tlb->mm;
> -	int force_flush = 0;
>  	int rss[NR_MM_COUNTERS];
>  	spinlock_t *ptl;
>  	pte_t *start_pte;
> @@ -1565,45 +1613,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			break;
>  
>  		if (pte_present(ptent)) {
> -			unsigned int delay_rmap;
> -
> -			page = vm_normal_page(vma, addr, ptent);
> -			if (page)
> -				folio = page_folio(page);
> -
> -			if (unlikely(!should_zap_folio(details, folio)))
> -				continue;
> -			ptent = ptep_get_and_clear_full(mm, addr, pte,
> -							tlb->fullmm);
> -			arch_check_zapped_pte(vma, ptent);
> -			tlb_remove_tlb_entry(tlb, pte, addr);
> -			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> -						      ptent);
> -			if (unlikely(!page)) {
> -				ksm_might_unmap_zero_page(mm, ptent);
> -				continue;
> -			}
> -
> -			delay_rmap = 0;
> -			if (!folio_test_anon(folio)) {
> -				if (pte_dirty(ptent)) {
> -					folio_mark_dirty(folio);
> -					if (tlb_delay_rmap(tlb)) {
> -						delay_rmap = 1;
> -						force_flush = 1;
> -					}
> -				}
> -				if (pte_young(ptent) && likely(vma_has_recency(vma)))
> -					folio_mark_accessed(folio);
> -			}
> -			rss[mm_counter(folio)]--;
> -			if (!delay_rmap) {
> -				folio_remove_rmap_pte(folio, page, vma);
> -				if (unlikely(page_mapcount(page) < 0))
> -					print_bad_pte(vma, addr, ptent, page);
> -			}
> -			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
> -				force_flush = 1;
> +			zap_present_pte(tlb, vma, pte, ptent, addr, details,
> +					rss, &force_flush, &force_break);
> +			if (unlikely(force_break)) {
>  				addr += PAGE_SIZE;
>  				break;
>  			}


