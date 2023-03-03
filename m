Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC56A9697
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 12:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCCLlJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 06:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCCLlI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 06:41:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D3A5552B;
        Fri,  3 Mar 2023 03:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED10EB81699;
        Fri,  3 Mar 2023 11:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A04C433EF;
        Fri,  3 Mar 2023 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677843650;
        bh=ruSFyxEt4TFvCxQ7D5ZuCTiPoqk6MEI5Mh8KW4fJ6O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjYlbWmXEF6/jIBnZn2WVY1xVcL6etElUCDOJWt0Ja/uxH6MV1s8KMEupZrPA+ZLT
         /cKsT5BTyrxt/M3AQdSMyar+2CZmuevWp/Vp8Sv8x9wlSpCOZ4GEcFeAgJ2IAg45DD
         u+zOaeX0qBQHgVTigH4veZFtVNQp64llQes6U0scyI9reD0uFrR6QlObdX54CuAmt2
         vpDYLXWY3f8R8tfyO6z1p7WZv42ECuEESwhVeOpQeRo1g0Gh6E2Df3jaxYoNhEBq+z
         G8XcbfIt4IUzdXsVXvuktJ9dqDt9HHRsVRg8MHgzLyxbHYk1pOO+tw7Xx5egGBPm80
         pEO/P6fQwKhsg==
Date:   Fri, 3 Mar 2023 13:40:38 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH v3 09/34] csky: Implement the new page table range API
Message-ID: <ZAHctugW4aeMy6oy@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-10-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:12PM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_dcache_clean flag from being per-page to per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  arch/csky/abiv1/cacheflush.c         | 32 +++++++++++++++++-----------
>  arch/csky/abiv1/inc/abi/cacheflush.h |  2 ++
>  arch/csky/abiv2/cacheflush.c         | 30 +++++++++++++-------------
>  arch/csky/abiv2/inc/abi/cacheflush.h | 10 +++++++--
>  arch/csky/include/asm/pgtable.h      | 21 +++++++++++++++---
>  5 files changed, 62 insertions(+), 33 deletions(-)
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
> index 39c51399dd81..c1cf0d55a2a1 100644
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
> +	unsigned long pfn = pte_pfn(*pte);
>  	struct page *page;

Should be struct folio *folio instead:

  CC      arch/csky/abiv2/cacheflush.o
arch/csky/abiv2/cacheflush.c: In function 'update_mmu_cache_range':
arch/csky/abiv2/cacheflush.c:19:9: error: 'folio' undeclared (first use in this function)
   19 |         folio = page_folio(pfn_to_page(pfn));
      |         ^~~~~
arch/csky/abiv2/cacheflush.c:19:9: note: each undeclared identifier is reported only once for each function it appears in
arch/csky/abiv2/cacheflush.c:13:22: warning: unused variable 'page' [-Wunused-variable]
   13 |         struct page *page;
      |                      ^~~~

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
> index d4042495febc..a30ae048233e 100644
> --- a/arch/csky/include/asm/pgtable.h
> +++ b/arch/csky/include/asm/pgtable.h
> @@ -90,7 +90,20 @@ static inline void set_pte(pte_t *p, pte_t pte)
>  	/* prevent out of order excution */
>  	smp_mb();
>  }
> -#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
> +
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) += PAGE_SIZE;
> +	}
> +}
> +
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>  
>  static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>  {
> @@ -263,8 +276,10 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
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
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
