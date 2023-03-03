Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF416A978B
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 13:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCCMu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 07:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCCMuY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 07:50:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D242442BFA;
        Fri,  3 Mar 2023 04:50:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47F27B8163F;
        Fri,  3 Mar 2023 12:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03047C433EF;
        Fri,  3 Mar 2023 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677847810;
        bh=PZ2Ce91kgZFEmOYlhfDXn2Xr6BsBLgCv6OQM1Gjk+Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jq/wlIbU+cH5rU0B0xt9rYmQYFsbmOEIF7NQvoknlUvzxoRNivUFKnHVO5/+SD15v
         +xqkIhkN+/COCmbRs5mtRvJOuspdxVqjOP/KHdqEJMXpbx3wi4hpb+dMRcllqOJHx/
         f9Q5YAR3gAypnte1fnkoZJrRkBg1LfjjIRsRScSF2WJWSrF5zV87Ku3tQshHOP+/ds
         SzZvBYabdKzwYJy0Skb6JgMRK0yYHiyrGQHVd9Nrqcp8G9viAHWN+dHgAnABa7/ifz
         xj2aEXhZT6l3yFsaEQmMpl89TJLHCKAkKWxGmUlmBifXyd0BZCeeCmuB8328XvDabq
         LYbK/VIduOlKg==
Date:   Fri, 3 Mar 2023 14:49:57 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v3 16/34] nios2: Implement the new page table range API
Message-ID: <ZAHs9cS/OzxzgQsT@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-17-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:19PM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> flush_dcache_folio().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
> from being per-page to per-folio.

This failed for me with 

  CC      arch/nios2/mm/cacheflush.o
arch/nios2/mm/cacheflush.c: In function 'flush_dcache_folio':
arch/nios2/mm/cacheflush.c:195:48: error: passing argument 2 of 'flush_aliases' from incompatible pointer type [-Werror=incompatible-pointer-types]
  195 |                         flush_aliases(mapping, folio);
      |                                                ^~~~~
      |                                                |
      |                                                struct folio *
arch/nios2/mm/cacheflush.c:74:71: note: expected 'struct page *' but argument is of type 'struct folio *'
   74 | static void flush_aliases(struct address_space *mapping, struct page *page)
      |                                                          ~~~~~~~~~~~~~^~~~
In file included from arch/nios2/mm/cacheflush.c:10:
arch/nios2/mm/cacheflush.c: At top level:
include/linux/export.h:57:43: error: redefinition of '__ksymtab_flush_dcache_folio'
   57 |         static const struct kernel_symbol __ksymtab_##sym               \
      |                                           ^~~~~~~~~~
include/linux/export.h:96:9: note: in expansion of macro '__KSYMTAB_ENTRY'
   96 |         __KSYMTAB_ENTRY(sym, sec)
      |         ^~~~~~~~~~~~~~~
include/linux/export.h:140:41: note: in expansion of macro '___EXPORT_SYMBOL'
  140 | #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
      |                                         ^~~~~~~~~~~~~~~~
include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
  147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
      |                                         ^~~~~~~~~~~~~~~
include/linux/export.h:150:41: note: in expansion of macro '_EXPORT_SYMBOL'
  150 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
      |                                         ^~~~~~~~~~~~~~
arch/nios2/mm/cacheflush.c:207:1: note: in expansion of macro 'EXPORT_SYMBOL'
  207 | EXPORT_SYMBOL(flush_dcache_folio);
      | ^~~~~~~~~~~~~
include/linux/export.h:57:43: note: previous definition of '__ksymtab_flush_dcache_folio' with type 'const struct kernel_symbol'
   57 |         static const struct kernel_symbol __ksymtab_##sym               \
      |                                           ^~~~~~~~~~
include/linux/export.h:96:9: note: in expansion of macro '__KSYMTAB_ENTRY'
   96 |         __KSYMTAB_ENTRY(sym, sec)
      |         ^~~~~~~~~~~~~~~
include/linux/export.h:140:41: note: in expansion of macro '___EXPORT_SYMBOL'
  140 | #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
      |                                         ^~~~~~~~~~~~~~~~
include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
  147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
      |                                         ^~~~~~~~~~~~~~~
include/linux/export.h:150:41: note: in expansion of macro '_EXPORT_SYMBOL'
  150 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
      |                                         ^~~~~~~~~~~~~~
arch/nios2/mm/cacheflush.c:201:1: note: in expansion of macro 'EXPORT_SYMBOL'
  201 | EXPORT_SYMBOL(flush_dcache_folio);
      | ^~~~~~~~~~~~~
arch/nios2/mm/cacheflush.c: In function 'update_mmu_cache_range':
arch/nios2/mm/cacheflush.c:235:40: error: passing argument 2 of 'flush_aliases' from incompatible pointer type [-Werror=incompatible-pointer-types]
  235 |                 flush_aliases(mapping, folio);
      |                                        ^~~~~
      |                                        |
      |                                        struct folio *
arch/nios2/mm/cacheflush.c:74:71: note: expected 'struct page *' but argument is of type 'struct folio *'
   74 | static void flush_aliases(struct address_space *mapping, struct page *page)
      |                                                          ~~~~~~~~~~~~~^~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:252: arch/nios2/mm/cacheflush.o] Error 1
make[3]: *** [scripts/Makefile.build:494: arch/nios2/mm] Error 2
make[2]: *** [scripts/Makefile.build:494: arch/nios2] Error 2
make[1]: *** [Makefile:2028: .] Error 2
make[1]: Leaving directory '/home/mike/build/cross/nios2/defconfig'
make: *** [Makefile:226: __sub-make] Error 2

 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/nios2/include/asm/cacheflush.h |  6 ++-
>  arch/nios2/include/asm/pgtable.h    | 27 +++++++++----
>  arch/nios2/mm/cacheflush.c          | 61 ++++++++++++++++-------------
>  3 files changed, 58 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
> index d0b71dd71287..8624ca83cffe 100644
> --- a/arch/nios2/include/asm/cacheflush.h
> +++ b/arch/nios2/include/asm/cacheflush.h
> @@ -29,9 +29,13 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
>  	unsigned long pfn);
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  void flush_dcache_page(struct page *page);
> +void flush_dcache_folio(struct folio *folio);
> +#define flush_dcache_folio flush_dcache_folio
>  
>  extern void flush_icache_range(unsigned long start, unsigned long end);
> -extern void flush_icache_page(struct vm_area_struct *vma, struct page *page);
> +void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
> +		unsigned int nr);
> +#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1);
>  
>  #define flush_cache_vmap(start, end)		flush_dcache_range(start, end)
>  #define flush_cache_vunmap(start, end)		flush_dcache_range(start, end)
> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
> index 0f5c2564e9f5..8a77821a17a5 100644
> --- a/arch/nios2/include/asm/pgtable.h
> +++ b/arch/nios2/include/asm/pgtable.h
> @@ -178,15 +178,23 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  	*ptep = pteval;
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pteval)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> -	unsigned long paddr = (unsigned long)page_to_virt(pte_page(pteval));
> -
> -	flush_dcache_range(paddr, paddr + PAGE_SIZE);
> -	set_pte(ptep, pteval);
> +	unsigned long paddr = (unsigned long)page_to_virt(pte_page(pte));
> +
> +	flush_dcache_range(paddr, paddr + nr * PAGE_SIZE);
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) += 1;
> +	}
>  }
>  
> +#define set_pte_at(mm, addr, ptep, pte)	set_ptes(mm, addr, ptep, pte, 1)
> +
>  static inline int pmd_none(pmd_t pmd)
>  {
>  	return (pmd_val(pmd) ==
> @@ -273,7 +281,10 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  extern void __init paging_init(void);
>  extern void __init mmu_init(void);
>  
> -extern void update_mmu_cache(struct vm_area_struct *vma,
> -			     unsigned long address, pte_t *pte);
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
> +		pte_t *ptep, unsigned int nr);
> +
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>  
>  #endif /* _ASM_NIOS2_PGTABLE_H */
> diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
> index 6aa9257c3ede..471485a84b2c 100644
> --- a/arch/nios2/mm/cacheflush.c
> +++ b/arch/nios2/mm/cacheflush.c
> @@ -138,10 +138,11 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
>  		__flush_icache(start, end);
>  }
>  
> -void flush_icache_page(struct vm_area_struct *vma, struct page *page)
> +void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
> +		unsigned int nr)
>  {
>  	unsigned long start = (unsigned long) page_address(page);
> -	unsigned long end = start + PAGE_SIZE;
> +	unsigned long end = start + nr * PAGE_SIZE;
>  
>  	__flush_dcache(start, end);
>  	__flush_icache(start, end);
> @@ -158,19 +159,19 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
>  		__flush_icache(start, end);
>  }
>  
> -void __flush_dcache_page(struct address_space *mapping, struct page *page)
> +void __flush_dcache_folio(struct address_space *mapping, struct folio *folio)
>  {
>  	/*
>  	 * Writeback any data associated with the kernel mapping of this
>  	 * page.  This ensures that data in the physical page is mutually
>  	 * coherent with the kernels mapping.
>  	 */
> -	unsigned long start = (unsigned long)page_address(page);
> +	unsigned long start = (unsigned long)folio_address(folio);
>  
> -	__flush_dcache(start, start + PAGE_SIZE);
> +	__flush_dcache(start, start + folio_size(folio));
>  }
>  
> -void flush_dcache_page(struct page *page)
> +void flush_dcache_folio(struct folio *folio)
>  {
>  	struct address_space *mapping;
>  
> @@ -178,32 +179,38 @@ void flush_dcache_page(struct page *page)
>  	 * The zero page is never written to, so never has any dirty
>  	 * cache lines, and therefore never needs to be flushed.
>  	 */
> -	if (page == ZERO_PAGE(0))
> +	if (is_zero_pfn(folio_pfn(folio)))
>  		return;
>  
> -	mapping = page_mapping_file(page);
> +	mapping = folio_flush_mapping(folio);
>  
>  	/* Flush this page if there are aliases. */
>  	if (mapping && !mapping_mapped(mapping)) {
> -		clear_bit(PG_dcache_clean, &page->flags);
> +		clear_bit(PG_dcache_clean, &folio->flags);
>  	} else {
> -		__flush_dcache_page(mapping, page);
> +		__flush_dcache_folio(mapping, folio);
>  		if (mapping) {
> -			unsigned long start = (unsigned long)page_address(page);
> -			flush_aliases(mapping,  page);
> -			flush_icache_range(start, start + PAGE_SIZE);
> +			unsigned long start = (unsigned long)folio_address(folio);
> +			flush_aliases(mapping, folio);
> +			flush_icache_range(start, start + folio_size(folio));
>  		}
> -		set_bit(PG_dcache_clean, &page->flags);
> +		set_bit(PG_dcache_clean, &folio->flags);
>  	}
>  }
> -EXPORT_SYMBOL(flush_dcache_page);
> +EXPORT_SYMBOL(flush_dcache_folio);
> +
> +void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
> +}
> +EXPORT_SYMBOL(flush_dcache_folio);
>  
> -void update_mmu_cache(struct vm_area_struct *vma,
> -		      unsigned long address, pte_t *ptep)
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
> +		pte_t *ptep, unsigned int nr)
>  {
>  	pte_t pte = *ptep;
>  	unsigned long pfn = pte_pfn(pte);
> -	struct page *page;
> +	struct folio *folio;
>  	struct address_space *mapping;
>  
>  	reload_tlb_page(vma, address, pte);
> @@ -215,19 +222,19 @@ void update_mmu_cache(struct vm_area_struct *vma,
>  	* The zero page is never written to, so never has any dirty
>  	* cache lines, and therefore never needs to be flushed.
>  	*/
> -	page = pfn_to_page(pfn);
> -	if (page == ZERO_PAGE(0))
> +	if (is_zero_pfn(pfn))
>  		return;
>  
> -	mapping = page_mapping_file(page);
> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> -		__flush_dcache_page(mapping, page);
> +	folio = page_folio(pfn_to_page(pfn));
> +	mapping = folio_flush_mapping(folio);
> +	if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
> +		__flush_dcache_folio(mapping, folio);
>  
> -	if(mapping)
> -	{
> -		flush_aliases(mapping, page);
> +	if (mapping) {
> +		flush_aliases(mapping, folio);
>  		if (vma->vm_flags & VM_EXEC)
> -			flush_icache_page(vma, page);
> +			flush_icache_pages(vma, &folio->page,
> +					folio_nr_pages(folio));
>  	}
>  }
>  
> -- 
> 2.39.1
> 
> 

-- 
Sincerely yours,
Mike.
