Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E306A9736
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCCMZE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 07:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCCMY7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 07:24:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E5A498A1;
        Fri,  3 Mar 2023 04:24:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C031DB8169E;
        Fri,  3 Mar 2023 12:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA3AC433EF;
        Fri,  3 Mar 2023 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677846295;
        bh=H5FljbpgCNE9x1vK95Cg2JCRQEG5BxuQrkbAN7vkA5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7X3uXZCKhZfj/d3Ol6/9XW2tSk54tkxWoQV4uFP9uaXOWokBlAbImhOF/QNsTEmt
         gtdPr4vO0SfOAFCBx57LzEaq+1tUIOzgPX5Cy8JFm0pWH1uklka0LQaL4i6B7WMWAf
         cFXpV9oi0HezhYnZ+Qa/uuoLclrVV2kb9t77Y6esQB4nW05JVBEm/C43GwvSCTbssq
         lcW60eUz8v567e03fXwwMPvc5PTaLSEJwWFYiQGancYYYFHFbPZli+svPkT6tnpr9C
         Lkzdi7LztWC2T3BgfTy28hYU8oURp/SF2rNmOuZge8DVvh71RDiAzMZ2VwBjDET8JC
         TI1lBbsEmTmDw==
Date:   Fri, 3 Mar 2023 14:24:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 15/34] mips: Implement the new page table range API
Message-ID: <ZAHnCQYF6bP+k7eq@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-16-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:18PM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> flush_dcache_folio().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
> from being per-page to per-folio.

Looks like update_mmu_cache_range() is missing:

  CC      mm/memory.o
mm/memory.c: In function 'set_pte_range':
mm/memory.c:4291:9: error: implicit declaration of function 'update_mmu_cache_range'; did you mean 'update_mmu_cache_pmd'? [-Werror=implicit-function-declaration]
 4291 |         update_mmu_cache_range(vma, addr, vmf->pte, nr);
      |         ^~~~~~~~~~~~~~~~~~~~~~
      |         update_mmu_cache_pmd
cc1: some warnings being treated as errors

 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/include/asm/cacheflush.h | 32 +++++++++++------
>  arch/mips/include/asm/pgtable.h    | 36 +++++++++++++------
>  arch/mips/mm/c-r4k.c               |  5 +--
>  arch/mips/mm/cache.c               | 56 +++++++++++++++---------------
>  arch/mips/mm/init.c                | 17 +++++----
>  5 files changed, 88 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
> index b3dc9c589442..2683cade42ef 100644
> --- a/arch/mips/include/asm/cacheflush.h
> +++ b/arch/mips/include/asm/cacheflush.h
> @@ -36,12 +36,12 @@
>   */
>  #define PG_dcache_dirty			PG_arch_1
>  
> -#define Page_dcache_dirty(page)		\
> -	test_bit(PG_dcache_dirty, &(page)->flags)
> -#define SetPageDcacheDirty(page)	\
> -	set_bit(PG_dcache_dirty, &(page)->flags)
> -#define ClearPageDcacheDirty(page)	\
> -	clear_bit(PG_dcache_dirty, &(page)->flags)
> +#define folio_test_dcache_dirty(folio)		\
> +	test_bit(PG_dcache_dirty, &(folio)->flags)
> +#define folio_set_dcache_dirty(folio)	\
> +	set_bit(PG_dcache_dirty, &(folio)->flags)
> +#define folio_clear_dcache_dirty(folio)	\
> +	clear_bit(PG_dcache_dirty, &(folio)->flags)
>  
>  extern void (*flush_cache_all)(void);
>  extern void (*__flush_cache_all)(void);
> @@ -50,15 +50,24 @@ extern void (*flush_cache_mm)(struct mm_struct *mm);
>  extern void (*flush_cache_range)(struct vm_area_struct *vma,
>  	unsigned long start, unsigned long end);
>  extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page, unsigned long pfn);
> -extern void __flush_dcache_page(struct page *page);
> +extern void __flush_dcache_pages(struct page *page, unsigned int nr);
>  
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> +static inline void flush_dcache_folio(struct folio *folio)
> +{
> +	if (cpu_has_dc_aliases)
> +		__flush_dcache_pages(&folio->page, folio_nr_pages(folio));
> +	else if (!cpu_has_ic_fills_f_dc)
> +		folio_set_dcache_dirty(folio);
> +}
> +#define flush_dcache_folio flush_dcache_folio
> +
>  static inline void flush_dcache_page(struct page *page)
>  {
>  	if (cpu_has_dc_aliases)
> -		__flush_dcache_page(page);
> +		__flush_dcache_pages(page, 1);
>  	else if (!cpu_has_ic_fills_f_dc)
> -		SetPageDcacheDirty(page);
> +		folio_set_dcache_dirty(page_folio(page));
>  }
>  
>  #define flush_dcache_mmap_lock(mapping)		do { } while (0)
> @@ -73,10 +82,11 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
>  		__flush_anon_page(page, vmaddr);
>  }
>  
> -static inline void flush_icache_page(struct vm_area_struct *vma,
> -	struct page *page)
> +static inline void flush_icache_pages(struct vm_area_struct *vma,
> +		struct page *page, unsigned int nr)
>  {
>  }
> +#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
>  
>  extern void (*flush_icache_range)(unsigned long start, unsigned long end);
>  extern void (*local_flush_icache_range)(unsigned long start, unsigned long end);
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 791389bf3c12..0cf0455e6ae8 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -105,8 +105,10 @@ do {									\
>  	}								\
>  } while(0)
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pteval);
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr);
> +
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>  
>  #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
>  
> @@ -204,19 +206,31 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
>  }
>  #endif
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pteval)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> +	unsigned int i;
> +	bool do_sync = false;
>  
> -	if (!pte_present(pteval))
> -		goto cache_sync_done;
> +	for (i = 0; i < nr; i++) {
> +		if (!pte_present(pte))
> +			continue;
> +		if (pte_present(ptep[i]) &&
> +		    (pte_pfn(ptep[i]) == pte_pfn(pte)))
> +			continue;
> +		do_sync = true;
> +	}
>  
> -	if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
> -		goto cache_sync_done;
> +	if (do_sync)
> +		__update_cache(addr, pte);
>  
> -	__update_cache(addr, pteval);
> -cache_sync_done:
> -	set_pte(ptep, pteval);
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) += 1 << _PFN_SHIFT;
> +	}
>  }
>  
>  /*
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index a549fa98c2f4..7d2a42f0cffd 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -679,13 +679,14 @@ static inline void local_r4k_flush_cache_page(void *args)
>  	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID))
>  		vaddr = NULL;
>  	else {
> +		struct folio *folio = page_folio(page);
>  		/*
>  		 * Use kmap_coherent or kmap_atomic to do flushes for
>  		 * another ASID than the current one.
>  		 */
>  		map_coherent = (cpu_has_dc_aliases &&
> -				page_mapcount(page) &&
> -				!Page_dcache_dirty(page));
> +				folio_mapped(folio) &&
> +				!folio_test_dcache_dirty(folio));
>  		if (map_coherent)
>  			vaddr = kmap_coherent(page, addr);
>  		else
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 11b3e7ddafd5..0668435521fc 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -82,13 +82,15 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
>  	return 0;
>  }
>  
> -void __flush_dcache_page(struct page *page)
> +void __flush_dcache_pages(struct page *page, unsigned int nr)
>  {
> -	struct address_space *mapping = page_mapping_file(page);
> +	struct folio *folio = page_folio(page);
> +	struct address_space *mapping = folio_flush_mapping(folio);
>  	unsigned long addr;
> +	unsigned int i;
>  
>  	if (mapping && !mapping_mapped(mapping)) {
> -		SetPageDcacheDirty(page);
> +		folio_set_dcache_dirty(folio);
>  		return;
>  	}
>  
> @@ -97,25 +99,21 @@ void __flush_dcache_page(struct page *page)
>  	 * case is for exec env/arg pages and those are %99 certainly going to
>  	 * get faulted into the tlb (and thus flushed) anyways.
>  	 */
> -	if (PageHighMem(page))
> -		addr = (unsigned long)kmap_atomic(page);
> -	else
> -		addr = (unsigned long)page_address(page);
> -
> -	flush_data_cache_page(addr);
> -
> -	if (PageHighMem(page))
> -		kunmap_atomic((void *)addr);
> +	for (i = 0; i < nr; i++) {
> +		addr = (unsigned long)kmap_local_page(page + i);
> +		flush_data_cache_page(addr);
> +		kunmap_local((void *)addr);
> +	}
>  }
> -
> -EXPORT_SYMBOL(__flush_dcache_page);
> +EXPORT_SYMBOL(__flush_dcache_pages);
>  
>  void __flush_anon_page(struct page *page, unsigned long vmaddr)
>  {
>  	unsigned long addr = (unsigned long) page_address(page);
> +	struct folio *folio = page_folio(page);
>  
>  	if (pages_do_alias(addr, vmaddr)) {
> -		if (page_mapcount(page) && !Page_dcache_dirty(page)) {
> +		if (folio_mapped(folio) && !folio_test_dcache_dirty(folio)) {
>  			void *kaddr;
>  
>  			kaddr = kmap_coherent(page, vmaddr);
> @@ -130,27 +128,29 @@ EXPORT_SYMBOL(__flush_anon_page);
>  
>  void __update_cache(unsigned long address, pte_t pte)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  	unsigned long pfn, addr;
>  	int exec = !pte_no_exec(pte) && !cpu_has_ic_fills_f_dc;
> +	unsigned int i;
>  
>  	pfn = pte_pfn(pte);
>  	if (unlikely(!pfn_valid(pfn)))
>  		return;
> -	page = pfn_to_page(pfn);
> -	if (Page_dcache_dirty(page)) {
> -		if (PageHighMem(page))
> -			addr = (unsigned long)kmap_atomic(page);
> -		else
> -			addr = (unsigned long)page_address(page);
> -
> -		if (exec || pages_do_alias(addr, address & PAGE_MASK))
> -			flush_data_cache_page(addr);
>  
> -		if (PageHighMem(page))
> -			kunmap_atomic((void *)addr);
> +	folio = page_folio(pfn_to_page(pfn));
> +	address &= PAGE_MASK;
> +	address -= offset_in_folio(folio, pfn << PAGE_SHIFT);
> +
> +	if (folio_test_dcache_dirty(folio)) {
> +		for (i = 0; i < folio_nr_pages(folio); i++) {
> +			addr = (unsigned long)kmap_local_folio(folio, i);
>  
> -		ClearPageDcacheDirty(page);
> +			if (exec || pages_do_alias(addr, address))
> +				flush_data_cache_page(addr);
> +			kunmap_local((void *)addr);
> +			address += PAGE_SIZE;
> +		}
> +		folio_clear_dcache_dirty(folio);
>  	}
>  }
>  
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 5a8002839550..19d4ca3b3fbd 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -88,7 +88,7 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
>  	pte_t pte;
>  	int tlbidx;
>  
> -	BUG_ON(Page_dcache_dirty(page));
> +	BUG_ON(folio_test_dcache_dirty(page_folio(page)));
>  
>  	preempt_disable();
>  	pagefault_disable();
> @@ -169,11 +169,12 @@ void kunmap_coherent(void)
>  void copy_user_highpage(struct page *to, struct page *from,
>  	unsigned long vaddr, struct vm_area_struct *vma)
>  {
> +	struct folio *src = page_folio(from);
>  	void *vfrom, *vto;
>  
>  	vto = kmap_atomic(to);
>  	if (cpu_has_dc_aliases &&
> -	    page_mapcount(from) && !Page_dcache_dirty(from)) {
> +	    folio_mapped(src) && !folio_test_dcache_dirty(src)) {
>  		vfrom = kmap_coherent(from, vaddr);
>  		copy_page(vto, vfrom);
>  		kunmap_coherent();
> @@ -194,15 +195,17 @@ void copy_to_user_page(struct vm_area_struct *vma,
>  	struct page *page, unsigned long vaddr, void *dst, const void *src,
>  	unsigned long len)
>  {
> +	struct folio *folio = page_folio(page);
> +
>  	if (cpu_has_dc_aliases &&
> -	    page_mapcount(page) && !Page_dcache_dirty(page)) {
> +	    folio_mapped(folio) && !folio_test_dcache_dirty(folio)) {
>  		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
>  		memcpy(vto, src, len);
>  		kunmap_coherent();
>  	} else {
>  		memcpy(dst, src, len);
>  		if (cpu_has_dc_aliases)
> -			SetPageDcacheDirty(page);
> +			folio_set_dcache_dirty(folio);
>  	}
>  	if (vma->vm_flags & VM_EXEC)
>  		flush_cache_page(vma, vaddr, page_to_pfn(page));
> @@ -212,15 +215,17 @@ void copy_from_user_page(struct vm_area_struct *vma,
>  	struct page *page, unsigned long vaddr, void *dst, const void *src,
>  	unsigned long len)
>  {
> +	struct folio *folio = page_folio(page);
> +
>  	if (cpu_has_dc_aliases &&
> -	    page_mapcount(page) && !Page_dcache_dirty(page)) {
> +	    folio_mapped(folio) && !folio_test_dcache_dirty(folio)) {
>  		void *vfrom = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
>  		memcpy(dst, vfrom, len);
>  		kunmap_coherent();
>  	} else {
>  		memcpy(dst, src, len);
>  		if (cpu_has_dc_aliases)
> -			SetPageDcacheDirty(page);
> +			folio_set_dcache_dirty(folio);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(copy_from_user_page);
> -- 
> 2.39.1
> 
> 

-- 
Sincerely yours,
Mike.
