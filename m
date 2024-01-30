Return-Path: <linux-arch+bounces-1830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A181841E59
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4AEB2DC99
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2BB57883;
	Tue, 30 Jan 2024 08:47:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437AE38DEC;
	Tue, 30 Jan 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604462; cv=none; b=GHK7E3suw/70eyLhVpQ5HucrlUS1JIPq/nPWIL0KnvbohDP80CzTjs1PEJD6l7LphO9cav5Su+5iaP6CSUdtAMgpKHLMn4MN0O8HO1V9/TYB8OMAzJ99BfC9ySv0r+hcflNIxJFBHrHgSzAaO9D0sOTKggW4NN9VMbSOVv70nXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604462; c=relaxed/simple;
	bh=+gC5XUeYUuFw+soxH/D3b8jk10TJuZtORaXfBsnPMBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0RSYAIwgMlRBxwAJM5x9zeF/gzAUtNvblbki2qOVjZvfszRTnK5BGkEAo2FvfNf3kKxVQpYTFodl0UQ3Lq5/5H587o9gGE7i2ATuI6t6Ll5fGu9bO4l5brUL5FfA3PkRBfJO2khWn44KP8p+mPA/d8m7mzMBggJx1c7D/dCjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E3AA139F;
	Tue, 30 Jan 2024 00:48:21 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF4953F738;
	Tue, 30 Jan 2024 00:47:34 -0800 (PST)
Message-ID: <e85fafb6-dd72-46c7-aa2c-2fa149f927d1@arm.com>
Date: Tue, 30 Jan 2024 08:47:34 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] mm/memory: factor out zapping folio pte into
 zap_present_folio_pte()
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
 <20240129143221.263763-5-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240129143221.263763-5-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:32, David Hildenbrand wrote:
> Let's prepare for further changes by factoring it out into a separate
> function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 53 ++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 20bc13ab8db2..a2190d7cfa74 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1528,30 +1528,14 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>  }
>  
> -static inline void zap_present_pte(struct mmu_gather *tlb,
> -		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
> -		unsigned long addr, struct zap_details *details,
> -		int *rss, bool *force_flush, bool *force_break)
> +static inline void zap_present_folio_pte(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma, struct folio *folio,
> +		struct page *page, pte_t *pte, pte_t ptent, unsigned long addr,
> +		struct zap_details *details, int *rss, bool *force_flush,
> +		bool *force_break)
>  {
>  	struct mm_struct *mm = tlb->mm;
>  	bool delay_rmap = false;
> -	struct folio *folio;
> -	struct page *page;
> -
> -	page = vm_normal_page(vma, addr, ptent);
> -	if (!page) {
> -		/* We don't need up-to-date accessed/dirty bits. */
> -		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> -		arch_check_zapped_pte(vma, ptent);
> -		tlb_remove_tlb_entry(tlb, pte, addr);
> -		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
> -		ksm_might_unmap_zero_page(mm, ptent);
> -		return;
> -	}
> -
> -	folio = page_folio(page);
> -	if (unlikely(!should_zap_folio(details, folio)))
> -		return;
>  
>  	if (!folio_test_anon(folio)) {
>  		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> @@ -1586,6 +1570,33 @@ static inline void zap_present_pte(struct mmu_gather *tlb,
>  	}
>  }
>  
> +static inline void zap_present_pte(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
> +		unsigned long addr, struct zap_details *details,
> +		int *rss, bool *force_flush, bool *force_break)
> +{
> +	struct mm_struct *mm = tlb->mm;
> +	struct folio *folio;
> +	struct page *page;
> +
> +	page = vm_normal_page(vma, addr, ptent);
> +	if (!page) {
> +		/* We don't need up-to-date accessed/dirty bits. */
> +		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> +		arch_check_zapped_pte(vma, ptent);
> +		tlb_remove_tlb_entry(tlb, pte, addr);
> +		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
> +		ksm_might_unmap_zero_page(mm, ptent);
> +		return;
> +	}
> +
> +	folio = page_folio(page);
> +	if (unlikely(!should_zap_folio(details, folio)))
> +		return;
> +	zap_present_folio_pte(tlb, vma, folio, page, pte, ptent, addr, details,
> +			      rss, force_flush, force_break);
> +}
> +
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				struct vm_area_struct *vma, pmd_t *pmd,
>  				unsigned long addr, unsigned long end,


