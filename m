Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC66BACA8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjCOJws (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 05:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjCOJwP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 05:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EB7E89C;
        Wed, 15 Mar 2023 02:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D0361CB0;
        Wed, 15 Mar 2023 09:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D375C4339B;
        Wed, 15 Mar 2023 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678873867;
        bh=SS3nEk8RuVUf6cgvqO5Fgo/W8bTsermC5WUVbt8Pkik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/otul67vrR+5yINptH8xhcO6gsoHDd5eDAMhboCY/asJCWHV5mA4Rd0PUkaP24ks
         v8UHOu9i7owsvSAL2CAA16Anp7vpQkva5ZywLoHFQADbrqGsWVwvYgQgFjTzZNUHtv
         TZUWC2PgyH4gPQhGapNkixwkUbd/iJOTLIUThTcmJCzE/7BzoF369dM6oqu0OXRA+q
         nVD0tbFFjFLKJ2YbbpFh1P5rJqMPsxGjayItEzzdPYxWZVDPfwXcklb52ckVR6bc+d
         xdy9gnQu4H/oVbLZOwzs4Obeh5Kmoq72XlgQVxJPbiI9P5Tm9bbqYKwtxAqX0uPnW1
         Zu/IWISv5Jpbg==
Date:   Wed, 15 Mar 2023 11:50:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH v4 10/36] csky: Implement the new page table range API
Message-ID: <ZBGU/wdcQLh5IlBH@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-11-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:18AM +0000, Matthew Wilcox (Oracle) wrote:
> Add PFN_PTE_SHIFT, update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_dcache_clean flag from being per-page to per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/csky/abiv1/cacheflush.c         | 32 +++++++++++++++++-----------
>  arch/csky/abiv1/inc/abi/cacheflush.h |  2 ++
>  arch/csky/abiv2/cacheflush.c         | 32 ++++++++++++++--------------
>  arch/csky/abiv2/inc/abi/cacheflush.h | 10 +++++++--
>  arch/csky/include/asm/pgtable.h      |  8 ++++---
>  5 files changed, 50 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
> index fb91b069dc69..ba43f6c26b4f 100644
> --- a/arch/csky/abiv1/cacheflush.c
> +++ b/arch/csky/abiv1/cacheflush.c
> @@ -14,43 +14,49 @@
>  
>  #define PG_dcache_clean		PG_arch_1
>  
> -void flush_dcache_page(struct page *page)
> +void flush_dcache_folio(struct folio *folio)
>  {
>  	struct address_space *mapping;
>  
> -	if (page == ZERO_PAGE(0))
> +	if (is_zero_pfn(folio_pfn(folio)))
>  		return;
>  
> -	mapping = page_mapping_file(page);
> +	mapping = folio_flush_mapping(folio);
>  
> -	if (mapping && !page_mapcount(page))
> -		clear_bit(PG_dcache_clean, &page->flags);
> +	if (mapping && !folio_mapped(folio))
> +		clear_bit(PG_dcache_clean, &folio->flags);
>  	else {
>  		dcache_wbinv_all();
>  		if (mapping)
>  			icache_inv_all();
> -		set_bit(PG_dcache_clean, &page->flags);
> +		set_bit(PG_dcache_clean, &folio->flags);
>  	}
>  }
> +EXPORT_SYMBOL(flush_dcache_folio);
> +
> +void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
> +}
>  EXPORT_SYMBOL(flush_dcache_page);
>  
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
> -	pte_t *ptep)
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long addr,
> +		pte_t *ptep, unsigned int nr)
>  {
>  	unsigned long pfn = pte_pfn(*ptep);
> -	struct page *page;
> +	struct folio *folio;
>  
>  	if (!pfn_valid(pfn))
>  		return;
>  
> -	page = pfn_to_page(pfn);
> -	if (page == ZERO_PAGE(0))
> +	if (is_zero_pfn(pfn))
>  		return;
>  
> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> +	folio = page_folio(pfn_to_page(pfn));
> +	if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
>  		dcache_wbinv_all();
>  
> -	if (page_mapping_file(page)) {
> +	if (folio_flush_mapping(folio)) {
>  		if (vma->vm_flags & VM_EXEC)
>  			icache_inv_all();
>  	}
> diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
> index ed62e2066ba7..0d6cb65624c4 100644
> --- a/arch/csky/abiv1/inc/abi/cacheflush.h
> +++ b/arch/csky/abiv1/inc/abi/cacheflush.h
> @@ -9,6 +9,8 @@
>  
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  extern void flush_dcache_page(struct page *);
> +void flush_dcache_folio(struct folio *);
> +#define flush_dcache_folio flush_dcache_folio
>  
>  #define flush_cache_mm(mm)			dcache_wbinv_all()
>  #define flush_cache_page(vma, page, pfn)	cache_wbinv_all()
> diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
> index 39c51399dd81..622e5b1b3f8a 100644
> --- a/arch/csky/abiv2/cacheflush.c
> +++ b/arch/csky/abiv2/cacheflush.c
> @@ -6,30 +6,30 @@
>  #include <linux/mm.h>
>  #include <asm/cache.h>
>  
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> -		      pte_t *pte)
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
> +		pte_t *pte, unsigned int nr)
>  {
> -	unsigned long addr;
> -	struct page *page;
> +	unsigned long pfn = pte_pfn(*pte);
> +	struct folio *folio;
> +	unsigned int i;
>  
> -	if (!pfn_valid(pte_pfn(*pte)))
> +	if (!pfn_valid(pfn) || is_zero_pfn(pfn))
>  		return;
>  
> -	page = pfn_to_page(pte_pfn(*pte));
> -	if (page == ZERO_PAGE(0))
> -		return;
> +	folio = page_folio(pfn_to_page(pfn));
>  
> -	if (test_and_set_bit(PG_dcache_clean, &page->flags))
> +	if (test_and_set_bit(PG_dcache_clean, &folio->flags))
>  		return;
>  
> -	addr = (unsigned long) kmap_atomic(page);
> -
> -	dcache_wb_range(addr, addr + PAGE_SIZE);
> +	for (i = 0; i < folio_nr_pages(folio); i++) {
> +		unsigned long addr = (unsigned long) kmap_local_folio(folio,
> +								i * PAGE_SIZE);
>  
> -	if (vma->vm_flags & VM_EXEC)
> -		icache_inv_range(addr, addr + PAGE_SIZE);
> -
> -	kunmap_atomic((void *) addr);
> +		dcache_wb_range(addr, addr + PAGE_SIZE);
> +		if (vma->vm_flags & VM_EXEC)
> +			icache_inv_range(addr, addr + PAGE_SIZE);
> +		kunmap_local((void *) addr);
> +	}
>  }
>  
>  void flush_icache_deferred(struct mm_struct *mm)
> diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
> index a565e00c3f70..9c728933a776 100644
> --- a/arch/csky/abiv2/inc/abi/cacheflush.h
> +++ b/arch/csky/abiv2/inc/abi/cacheflush.h
> @@ -18,11 +18,17 @@
>  
>  #define PG_dcache_clean		PG_arch_1
>  
> +static inline void flush_dcache_folio(struct folio *folio)
> +{
> +	if (test_bit(PG_dcache_clean, &folio->flags))
> +		clear_bit(PG_dcache_clean, &folio->flags);
> +}
> +#define flush_dcache_folio flush_dcache_folio
> +
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  static inline void flush_dcache_page(struct page *page)
>  {
> -	if (test_bit(PG_dcache_clean, &page->flags))
> -		clear_bit(PG_dcache_clean, &page->flags);
> +	flush_dcache_folio(page_folio(page));
>  }
>  
>  #define flush_dcache_mmap_lock(mapping)		do { } while (0)
> diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
> index d4042495febc..8cd27104f408 100644
> --- a/arch/csky/include/asm/pgtable.h
> +++ b/arch/csky/include/asm/pgtable.h
> @@ -28,6 +28,7 @@
>  #define pgd_ERROR(e) \
>  	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
>  
> +#define PFN_PTE_SHIFT	PAGE_SHIFT
>  #define pmd_pfn(pmd)	(pmd_phys(pmd) >> PAGE_SHIFT)
>  #define pmd_page(pmd)	(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
>  #define pte_clear(mm, addr, ptep)	set_pte((ptep), \
> @@ -90,7 +91,6 @@ static inline void set_pte(pte_t *p, pte_t pte)
>  	/* prevent out of order excution */
>  	smp_mb();
>  }
> -#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
>  
>  static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>  {
> @@ -263,8 +263,10 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  extern void paging_init(void);
>  
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> -		      pte_t *pte);
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
> +		pte_t *pte, unsigned int nr);
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>  
>  #define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
>  	remap_pfn_range(vma, vaddr, pfn, size, prot)
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
