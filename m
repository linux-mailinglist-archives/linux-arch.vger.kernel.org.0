Return-Path: <linux-arch+bounces-2174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B96850EF7
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 09:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42A61C20815
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F27464;
	Mon, 12 Feb 2024 08:37:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14333F7;
	Mon, 12 Feb 2024 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727059; cv=none; b=R5MIpdzvld6WrTjKyjruProFH53DkZU+cxglg2haTuvk0XriZpkXvS7Hgl8ccSXGntOJyHmAlkNIDqzE2NCMw+0k/Q6UqczvJ2VZEQCX3r+FuaJp2CDDfbJFYXfuOuitHIuE+n82qtD1wyS8HYAeDRolZwR11Gs9w4FtPDPum0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727059; c=relaxed/simple;
	bh=Gb03w9GjFy0RW+c0j9zZ7K/5lxbYES/OXeUcepSVlp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfY1AYBrxRdhSGeqpNRU+wQ/RKmNnq//ujlsLNJDvC1+7Aic38cdTWj/wX28P8o25ju0Sy1+CdT6kCEhVZie0GyJH6Lmy6PkH2qA/pw8MuX6vvnwoctyOCYPI4hP73SfkX0bi0VmLO06OyEelh/MQPefnq2G4qaOD53eLe7mTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C332DA7;
	Mon, 12 Feb 2024 00:38:17 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB68C3F762;
	Mon, 12 Feb 2024 00:37:32 -0800 (PST)
Message-ID: <d0de978e-6cca-49c0-88d2-b7c807fb25c4@arm.com>
Date: Mon, 12 Feb 2024 08:37:31 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] mm/memory: factor out zapping of present pte
 into zap_present_pte()
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
 <20240209221509.585251-2-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240209221509.585251-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 22:15, David Hildenbrand wrote:
> Let's prepare for further changes by factoring out processing of present
> PTEs.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 94 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7c3ca41a7610..5b0dc33133a6 100644
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
> +	struct folio *folio = NULL;
> +	bool delay_rmap = false;
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
> @@ -1555,7 +1603,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	arch_enter_lazy_mmu_mode();
>  	do {
>  		pte_t ptent = ptep_get(pte);
> -		struct folio *folio = NULL;
> +		struct folio *folio;
>  		struct page *page;
>  
>  		if (pte_none(ptent))
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


